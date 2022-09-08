
IF OBJECT_ID('tempdb..#Referrals') IS NOT NULL
    DROP TABLE #Referrals
IF OBJECT_ID('tempdb..#AG') IS NOT NULL
    DROP TABLE #AG
IF OBJECT_ID('tempdb..#NAG') IS NOT NULL
    DROP TABLE #NAG
	IF OBJECT_ID('tempdb..#Results') IS NOT NULL
    DROP TABLE #Results



SELECT  [REFERRING_ORG_ID]
      ,datepart(M,[ACTION_DT_TM]) [Month]
      ,datepart(YY,[ACTION_DT_TM]) [Year]
	  ,count(*) as [Activity]
    into #AG 
  FROM Data_Mart_Planned.ERef.[EBSX02]
    where [ACTION_CD] = '1407'
	  and [REFERRING_ORG_ID] in ('L85055','L85020','L85601','L85032','L85016','L85066','L85018','L85011','L85007','L85624','L85021','L85025','L85609','L85004','L85006','L85065','L85035','L85030','L85003','L85001','L85008','L85047','L85039','L85053','L85026','L85019','L85022','L85033','L85038','L85050','L85062','L85061','L85046','L85031','L85040','L85037','L85056','L85611','L85064','L85043','L85017','L85024','L85015','L85013','L85036','L85044','L85051','L85048','L85607','L85028','L85023','L85054','L85010','L85042','L85014','L85619','L85612','L85029','L85052','L85012','L85034','L85002','Y01163','L85009','L85027')


	group by [REFERRING_ORG_ID]
      ,datepart(M,[ACTION_DT_TM])
      ,datepart(YY,[ACTION_DT_TM])




select
[REFERRING_ORG_ID] [ORGID]
	  ,datepart(M,[ACTION_DT_TM]) [Month]
    ,datepart(YY,[ACTION_DT_TM]) [Year]
	  ,	  [SPEC].[DISPLAY] [SPECD]
	  ,[CLINIC].[DISPLAY] [CLINICD]
	  ,case when concat([SPEC].[DISPLAY],[CLINIC].[DISPLAY]) in 
	  ('CardiologyArrhythmia',
'CardiologyCongenital Heart Disease',
'CardiologyHeart Failure',
'CardiologyHypertension',
'CardiologyNot Otherwise Specified',
'CardiologyValve Disorders',
'GynaecologyUrogynaecology / Prolapse',
'PhysiotherapyGynaecological Physiotherapy',
'Urology(In) Continence',
'Diabetic MedicineGeneral Diabetic Management',
'Diabetic MedicinePodiatry and Foot',
'Diabetic MedicineRenal Diabetes',
'CardiologyLipid Management',
'Diagnostic PathologyBlood Test',
'Endocrinology and Metabolic MedicineLipid Disorders',
'Ear, Nose & ThroatBalance / Dizziness',
'Ear, Nose & ThroatEar',
'Ear, Nose & ThroatFacial Plastic and Skin Lesions',
'Ear, Nose & ThroatHearing Tests/Aids - see Diag Phys Meas',
'Ear, Nose & ThroatNeck Lump / Thyroid',
'Ear, Nose & ThroatNose / Sinus',
'Ear, Nose & ThroatNot Otherwise Specified',
'Ear, Nose & ThroatOncology (Established Diagnosis)',
'Ear, Nose & ThroatSalivary Gland',
'Ear, Nose & ThroatSleep Apnoea - see Sleep Medicine',
'Ear, Nose & ThroatSnoring (not Sleep Apnoea)',
'Ear, Nose & ThroatThroat (incl Voice / Swallowing)',
'Ear, Nose & ThroatTinnitus',
'Endocrinology and Metabolic MedicineAdrenal Disorders',
'Endocrinology and Metabolic MedicineEndocrine Pregnancy',
'Endocrinology and Metabolic MedicineGynaecological Endocrinology',
'Endocrinology and Metabolic MedicineMetabolic Bone Disorders',
'Endocrinology and Metabolic MedicineNot Otherwise Specified',
'Endocrinology and Metabolic MedicinePituitary & Hypothalamic',
'Endocrinology and Metabolic MedicineThyroid / Parathyroid',
'Diagnostic EndoscopyColonic Imaging Assessment / Advice',
'Diagnostic EndoscopyFlexibleSigmoidoscopy',
'Diagnostic EndoscopyGastroscopy',
'Endoscopy - see Diagnostic Endoscopy',
'GI and Liver (Medicine and Surgery)Hepatology',
'GI and Liver (Medicine and Surgery)Inflammatory Bowel Disease (IBD)',
'GI and Liver (Medicine and Surgery)Lower GI (medical) excl IBD',
'GI and Liver (Medicine and Surgery)Oncology (Established Diagnosis)',
'GI and Liver (Medicine and Surgery)Upper GI incl Dyspepsia',
'GynaecologyColposcopy',
'GynaecologyFamily Planning',
'GynaecologyInfertility',
'GynaecologyMenopause',
'GynaecologyMenstrual Disorders',
'GynaecologyNot Otherwise Specified',
'GynaecologyPelvic Pain',
'GynaecologyPerineal Repair',
'GynaecologyRecurrent Miscarriage',
'GynaecologyVulval and Perineal Lesions',
'HaematologyClotting Disorders',
'HaematologyHaemoglobinopathies',
'HaematologyNot Otherwise Specified',
'HaematologyOncology (Established Diagnosis)',
'Mental Health - Adults of all agesAnxiety/Depression/Stress: Mild/Moderate',
'Mental Health - Adults of all agesAnxiety/Depression/Stress: Severe',
'Mental Health - Adults of all agesNot Otherwise Specified',
'Mental Health - Adults of all agesPsychological Disorders/Difficulties',
'Mental Health - Adults of all agesSelf Harm',
'Mental Health - Child and AdolescentNot Otherwise Specified',
'NeurologyCognitive Disorders',
'NeurologyEpilepsy',
'NeurologyHeadache',
'NeurologyNeuromuscular',
'NeurologyNot Otherwise Specified',
'OrthopaedicsFoot and Ankle',
'OrthopaedicsFracture - Non Emergency',
'OrthopaedicsHand and Wrist',
'OrthopaedicsHip',
'OrthopaedicsKnee',
'OrthopaedicsLimb Deformity/Reconstruction',
'OrthopaedicsPodiatric Surgery',
'OrthopaedicsShoulder and Elbow',
'OrthopaedicsSpine - Back Pain (not Scoliosis/Deform)',
'OrthopaedicsSpine - Neck Pain',
'OrthopaedicsSpine - Scoliosis and Deformity',
'OrthopaedicsSports Trauma',
'RheumatologyBone / Osteoporosis',
'RheumatologyInflammatory Arthritis',
'RheumatologyMusculoskeletal',
'RheumatologyOther Autoimmune Rheumatic Disease',
'RheumatologySpinal Disorders',
'Surgery - BreastFH of Breast Cancer (non 2WW)',
'Surgery - BreastMammoplasty (non 2WW)',
'Surgery - BreastOther symptomatic Breast (2WW)') then 'AG'
when right([SPEC].[DISPLAY],19)='Adolescent Services'
and [CLINIC].[DISPLAY]
in
('Allergy',
'Cardiology',
'Community Paediatric',
'Developmental / Learning Disabilities',
'Diabetes',
'Endocrinology',
'Gastroenterology',
'Gynaecology',
'Haematology',
'Immunology',
'Metabolic Disorders',
'Nephrology',
'Neurology',
'Other Medical',
'Respiratory',
'Rheumatology',
'Urology') then 'AG'
else 'Not AG' end [AG?]
,[02].*
     
into #Referrals

    FROM Data_Mart_Planned.ERef.[EBSX02] [02] 
  left join Data_Mart_Planned.ERef.[EBSX03] [SPEC]
  on [SPECIALTY_CD]=[SPEC].CODE
  left join Data_Mart_Planned.ERef.[EBSX03] [CLINIC]
  on [CLINIC_TYPE_CD]=[CLINIC].CODE

    where [ACTION_CD] = '1422'
	  and [REFERRING_ORG_ID] in ('L85055','L85020','L85601','L85032','L85016','L85066','L85018','L85011','L85007','L85624','L85021','L85025','L85609','L85004','L85006','L85065','L85035','L85030','L85003','L85001','L85008','L85047','L85039','L85053','L85026','L85019','L85022','L85033','L85038','L85050','L85062','L85061','L85046','L85031','L85040','L85037','L85056','L85611','L85064','L85043','L85017','L85024','L85015','L85013','L85036','L85044','L85051','L85048','L85607','L85028','L85023','L85054','L85010','L85042','L85014','L85619','L85612','L85029','L85052','L85012','L85034','L85002','Y01163','L85009','L85027')
	and [UBRN] not in 
	(select [UBRN] 
	from Data_Mart_Planned.ERef.[EBSX02] 
	where [ACTION_CD] = '1407'
	  and [REFERRING_ORG_ID] in ('L85055','L85020','L85601','L85032','L85016','L85066','L85018','L85011','L85007','L85624','L85021','L85025','L85609','L85004','L85006','L85065','L85035','L85030','L85003','L85001','L85008','L85047','L85039','L85053','L85026','L85019','L85022','L85033','L85038','L85050','L85062','L85061','L85046','L85031','L85040','L85037','L85056','L85611','L85064','L85043','L85017','L85024','L85015','L85013','L85036','L85044','L85051','L85048','L85607','L85028','L85023','L85054','L85010','L85042','L85014','L85619','L85612','L85029','L85052','L85012','L85034','L85002','Y01163','L85009','L85027')
)




SELECT  [REFERRING_ORG_ID]
      ,datepart(M,[ACTION_DT_TM]) [Month]
      ,datepart(YY,[ACTION_DT_TM]) [Year]
	  ,count(*) as [Activity]
   into #NAG  
  FROM #Referrals


    where [AG?] = 'AG'

	group by [REFERRING_ORG_ID]
      ,datepart(M,[ACTION_DT_TM]) 
      ,datepart(YY,[ACTION_DT_TM]) 


	  Select #AG.[REFERRING_ORG_ID]
      , CONVERT(DATE,CAST(#AG.[Year] AS VARCHAR(4))+'-'+
                    CAST(#AG.[Month] AS VARCHAR(2))+'-01') [Month_Date]
	  , #AG.[Activity] [A&G]
	  , #NAG.[Activity] [NonA&G]
	  , (cast(#AG.[Activity] as decimal)/(cast(#AG.[Activity] as decimal)+cast(#NAG.[Activity]as decimal))) [Utilisation]
	      into #Results 
	  from #AG 
	  full join #NAG
	  on #AG.REFERRING_ORG_ID=#NAG.REFERRING_ORG_ID
	  and #AG.[Month]=#NAG.[Month]
	  and #AG.[Year]=#NAG.[Year]

	  where #AG.[Year] >= '2021'

	  order by CONVERT(DATE,CAST(#AG.[Year] AS VARCHAR(4))+'-'+
                    CAST(#AG.[Month] AS VARCHAR(2))+'-01') desc