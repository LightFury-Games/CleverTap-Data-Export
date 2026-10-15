with player_base as 
(
select email, 'List 1' as player_list from lfg_clevertap_raw.stan_14th_oct_email_list_1
union 
select email, 'List 2' as player_list from lfg_clevertap_raw.stan_14th_oct_email_list_2
), 

match_starts as 
(
select email 
		, sum(case when eventprops_game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_starts
		, sum(case when eventprops_game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_starts

from lfg_clevertap_raw.lfg_match_start_flat a 
join player_base b using(email)
where export_date = '2026-10-14'
group by 1
),

match_completes as 
(
select email 
		, sum(case when eventprops_game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_completes
		, sum(case when eventprops_game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_completes

from lfg_clevertap_raw.lfg_match_end_flat a 
join player_base b using(email)
where export_date = '2026-10-14'
	and eventprops_match_end_type = 'ematchendtype::completed'
group by 1
)

select a.player_list 
		, a.email 
		
		, coalesce(sp_match_starts, 0) as sp_match_starts
		, coalesce(mp_match_starts, 0) as mp_match_starts
		, coalesce(sp_match_starts, 0) + coalesce(mp_match_starts, 0) as total_match_starts
		
		, coalesce(sp_match_completes, 0) as sp_match_completes
		, coalesce(mp_match_completes, 0) as mp_match_completes
		, coalesce(sp_match_completes, 0) + coalesce(mp_match_completes, 0) as total_match_starts

from player_base a 
left join match_starts b on a.email = b.email 
left join match_completes c on a.email = c.email 
order by 1,2 
;
