Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A371B6AA5F6
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Mar 2023 00:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCCX4K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 18:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCCX4J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 18:56:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D8A66D14
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 15:56:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323MQdcu005482;
        Fri, 3 Mar 2023 22:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=koZV5dWdej11YsFDvXhc9bm1k/G7olxZXxxnLl8QbEs=;
 b=ACWgwjJ7G9hDkz+iqavhLvW3Nq/josfWeRaFfWXURbY9NdaMPO5jN1Ye5hMYLtqzB34D
 gZ6ViSlrEP+xIqd9ltdK7+WiiD6/ywhxYh220hhrAOIdASjC9oufD9dW7U5xkBZ3dPZF
 karBgV/PHez+UjOmcH7D/R2es2RoBOSD5VVIUpu86oBlg/Pcm18kIl4wIo434Q7ZZ2FS
 rVzKNO0ha8oWxnTL1BdWUFgp0r1FLmk4+SBKQOGW3SLXg18Ul22zC8p7nNVFaS8eC8O7
 3sN6zcwjb849OrBlgD7U/tYd0tIj5NU9Kas82lvaykTAQqzvyi7n3IGwqlKvkfuHMyvl dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2gq8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 22:49:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323Mdtwv031321;
        Fri, 3 Mar 2023 22:49:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sjxp2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 22:49:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChnhyCzfjGuoRvPWsWV5N7KQunoSNzI4sJ+rbKwfh0JSkJep0NPiKSpPCQBGoQpoSWqhbekIPHl2JaTpkY8bjA8emmuMM4iywlYIztae3OJr2oBfEDOSy1whvDQT3r68rWZJAbh5TuCm6IxLuTHhfuc5C+UbPhAum2XVBTE6D9bmvFb1NxkjP/YjXHJGDftlNH6jniV1WjYRUKyoZaxyPZIUKA37Pukn8uy57PpC9UeSSUntzNpsei1OtDk8nzOJwITh9e9cuOlbZhqHp5mlZHaSo9fsfueLy/c+cc3Zbcj9CZxBJ4dFuqIEsxHO+5CrVFxfWs+sOJCNhu45DP+PQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koZV5dWdej11YsFDvXhc9bm1k/G7olxZXxxnLl8QbEs=;
 b=EifYKXj2/o1Ths6Gzo2Fn2t3B7f3f3OHJzCX61Tzo5ad1G0RGxEyLJXLMl1t/2Z21TxOZR3Yk3zwTMzhZifYlaAkJQlg8GZ5WnH7KPli96lOsTWDlkERx4EeCNKe90IeIar8RxzPnzp+HDT4kB3z5IlJ68ik5TXS7cUguu3aljnnakesmHdrsgvajwttJL8KCYVtMcmCH2JbwWiQzqo6boXgBcOBszIjPDyfLLX9QGNlmsr5/wrknrGY/QXsnKlwyV5ciZRHzZAXven4iCfUhKdPhGWg/ANcibhQaT6rFBw1mwHopvHwi0FUAzvoZT00sTLCzPkuQPIFmVfG4Edu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koZV5dWdej11YsFDvXhc9bm1k/G7olxZXxxnLl8QbEs=;
 b=jyKGdxWWUuw7IA56z+kqUWh9HGVKpOFHKIcmpQib7F19bU1EfqFb3RwvNRLg7w3rcFGwbGMoierLq3IQoADsnH7yy5dA25NZ4Lz7Yv7mGqDfKCmKA0rCVjvJOif38TXW9suejmGz6TESz68rQZOyRjE9RaHOzN3Am/Bi6PljnJk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6824.namprd10.prod.outlook.com (2603:10b6:8:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 22:49:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 22:49:03 +0000
Message-ID: <73a37af8-01cf-38fd-988c-b72dc41f2a58@oracle.com>
Date:   Sat, 4 Mar 2023 06:48:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 09/10] btrfs: return a btrfs_bio from btrfs_bio_alloc
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-10-hch@lst.de>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ad6996-ff56-46bb-571e-08db1c397cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3O+kNkTOjMxpJkMkouJqiXb2952mtIhUaM8dDQuPSVFD8cXC89HIoOVwcUmeonVPyQRcUaZH5Lz/KMU3CDjzsowmachkZRbwoIklH3dAhlBh7AerUOVyA0+9NExFoDvy/Qy2VgEOApOyZuGcA2fVFRVDfEQ5BEgdbff6mDkjQVN5YgoK2ZoZ1ZXqDAZKmyfJATmwnRC7emcIRMZNgVUqBUBeainQ0ZWTOKZcjwdR6Zxa9Ci1Yu1g8O+whNGka6UBa3LypJ0XaWIieV+uJksYzf/5p5cVMRczuVVjifN+C8Dtu3lYposYv3CgregEvD//gjRkoNu3BjMoUOVcZtOwSEWmVNVvghma8BDjn+9LBs6XETbCwpaZC9KqB9kBlR6Fh9IX+QG4Os+VCSkIPg8RnYaOIko3YYSASIedHys6UugJYCglZLM7W/Uoi2vk8gmhaWRIDS+emiE78IrSNhwZWpxKbkoGQgnp0EEYJoKFqkjVi2R+5Cq22on8Lrwej02tW5M4Favc+dTw+xWHczH4E7+BgpK69D44LlcU/dEgF/1XlPuLPkTAG8J4PbZ2YaTS6AkxsMQhQ4g7bitr7t8WpVRXu/d9lTtdzWnrIMvCAFvzEm/pQhIqXu+rccvu1mYLZclkVdlFAIMhRVTvZ5HJ5u9kNDR8qzKuwLv+YKBygBUc/kfjnz6ixGPwtgHrBtG23joy7SzZQ+cf/I19u7fJkAqiT4FV36Ygp7zcOkvy4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(36756003)(6666004)(6506007)(26005)(53546011)(6512007)(186003)(2616005)(41300700001)(6486002)(66476007)(8936002)(66556008)(31696002)(2906002)(86362001)(8676002)(4326008)(44832011)(66946007)(4744005)(5660300002)(316002)(38100700002)(110136005)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlltR0ZWV0NITTFZK25YbnBGNnZSSlBVbzB1Zmh0NDF5eURnSUs3Q0s0U2Rz?=
 =?utf-8?B?cXk4R0RWRzF3b0o5OWVuZ2V3b1lhSGFPRU0xVkxUZWcrcU1UUG5MRDBSb2xs?=
 =?utf-8?B?dDNvUVJub2xDZjZnQ3ZlV2ttM0xXQkpVZmk3cDNBWmpTamh1VWMzTDBGczhW?=
 =?utf-8?B?WUZBcGU4dlltRWhYaVNoTkxXcjRJV0R6UXRPTkdmZVR6dm9PamhHL1pieFJ6?=
 =?utf-8?B?VzlzV3BHd0hmb2NNZDdRUC9WdnFsTnVzb1BKQ3VBcVJIL3BOUEt5WGFJalVu?=
 =?utf-8?B?NHFrNkZTSkZyR0VxbFBMMTFoM0JyU1g1UUtoMDRaNUxkcENLQVJMQjJLLzFE?=
 =?utf-8?B?bzRMVmExaDZySit5VHBvTTBQRDRYY1pPYzFXVW54OEF4bzMxTkUvTGk2SnRR?=
 =?utf-8?B?UzJIVjJwY2dTeU4vSUNtZWhDV2FNNjNvN0NmRmRDTTU3aXA0NlN5Z3U3THRt?=
 =?utf-8?B?bWtMa0Q0YlZWNWUxejFrbVJPZ1RkMWh0OEdDbUN3TnRac1ZEc0lONFRuR2ts?=
 =?utf-8?B?QllrK0JDK0FkeGhaRWtoa296RCt3SXFKNW5BcHBDQ3o3Nmdnd0tIdFNyZFh5?=
 =?utf-8?B?eTJ0cFRzbmU2bzM0cmk4TmhkQ3hwOXRabkJ1Q0IxbkZDNFgvYS9NZXZWSzVX?=
 =?utf-8?B?R0NBZHJwVUU3clE4Ny9xNlNUNU9NTVRLdVNpOHlQVWQ5ZXRrTWllUitoc0s5?=
 =?utf-8?B?dmJRLzBzOWkyM0lvV3BXZjVsUWRBM2NmdFpyUlpTU0FHL2pXWXkrWEh5b3NH?=
 =?utf-8?B?VW04SDcwR2p3MFMzdkNvUVQzdkxoblRKa2RTdHE4ZTdqK3p6a05UUWJuQmtW?=
 =?utf-8?B?NjIwSUZMcjk3bkY3V1M1dWVxZEZkSEJUR2JENTU4RkZIUG04SThwc1NzNVha?=
 =?utf-8?B?RWQrNXJyTk5YdWswSE9scWx0eWJIcTQraXU2clJBTStNQ2J1RHFPN2dFR0xl?=
 =?utf-8?B?TnZDY3lrUWEwRWovcEVuZmExQW1zSitBQnRkMnovdlBodW9yQ0ZUNE4zaXpI?=
 =?utf-8?B?U1A4Mjl3S0c1bk1iMGFYeExaQXJSYWQvek9FTHFia2RxNm1Ldy9KWHVnbGcx?=
 =?utf-8?B?NVZDREMyejRSUDlBUjJTOHRmWVJhYU85ODQ2aEVPRTcvOXFIaDd0SW5BREFU?=
 =?utf-8?B?TC9TOVRRbGl2NWhLaWJMekxNTXpEMWJlWnk1NGpEMmdqakFXYWZaSVlVTUdq?=
 =?utf-8?B?K3NxaXFKMER0enhsZEFqdHB3dnkzbHpaQlljNVNybElzR1QxZktWMFFQU1BL?=
 =?utf-8?B?aCthVC9VOHJtTldDY2EvbDdmZG5JK0NZd0JVZmhxTEVMSkV5Wm9yMjhGdFo4?=
 =?utf-8?B?UGRNNXcvTmRMTjJxNkRLZGlaU0VSSTk5ZU9XTG9HeUQycHdndXZ2UHFrZENQ?=
 =?utf-8?B?ZElqOU9TdWdZSW1oNXVlS0Vnd0NCSHBCa2QwRk5qb28yVXgyeHZ1ZTlFV1Fn?=
 =?utf-8?B?RktKKzE0SlVDbFFPaVRsQkZmaGdCZEJCOTI4QTdUN2tJU2x1MXFBTzArKzR4?=
 =?utf-8?B?RCtXcjMySXlQeGNQU25WWTAzUmxocUxuSEl0SHppT2pKVzdpRWpUdnhxSmNJ?=
 =?utf-8?B?cm5lV0s4dDBRWkRGNXpDUXdwckxZb05JbWovK3ZIWkpUeW1HRHhyVitVc0NY?=
 =?utf-8?B?NXB4VjdzQ2RabmtxWjd0RjErVkd2am5XMHN1bXNVKzg1M3BlQkpwYjVOVkNu?=
 =?utf-8?B?RURyc2c5WWt0MjZwYzhIdWp4a2VYcVZ4QndrMkJZcDVjN1dzT3YwNEpzMUVs?=
 =?utf-8?B?WFRXbHF1Z3pwamhnMUdiWGJwZ3lPL2dsbjJVUkE5VzQwYU9MRWdxQy92MW1r?=
 =?utf-8?B?RkhWNlR3VjZuNFNqZU5Iak5Va3JmSGU0YUswSmNJUWkzNXRRbkR1QUFNYzZw?=
 =?utf-8?B?enp1ditSVThYV0lqa2NwSElMT0ZwTndRMlY2dFZzSEFVSWRYQWFXa0hkcnJG?=
 =?utf-8?B?TmlQUUZhbFUrYmRxOGRLZjhDQmszM3h6cU5DdHVNWmFtM1JlV0thVldFUXJU?=
 =?utf-8?B?NlVxeDBsQkJQNm9xemF2MURPSlNpRFQwRnpiM3FRSTkva0V3bWNLWWhhTUlo?=
 =?utf-8?B?V0xaQW00ZVlEVEtydTdVQVdFVlVRVUFLNWV2UmI0NjNZTGlwMy93R1JocTcv?=
 =?utf-8?Q?h/tmGOcxvxdQ/myM+yLEFt3c0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HFYLvClihX13VsrQeacV61Jq5QBHEyaGD6nXSFmPb914vW6khd1XPIMTaj3km3pqf7TtTjPhJv6hBHBxv5vN+w5hznB8Qu5/YC9CdIM1d38J6Ba7nCbL1hu/SaW7DxLZEqRPtKPV8H0WK/g/FV/recDwZ6q+cA0IsgXQn0OBDzmSbsm1YtM1g/CI2DbbV3hdZSZS4vNqLHpqPpBd7kcVQoAJdA4vb/d/2bZhY3hDnxH0DS0wNuHUUaenGtxkhwxRT0KoGLSF2Y2P7vhYtBQ4YU1vD6xP7cGNFrW8+Uk/lwHRky/eBHW6ptR4b09pu0fLXVDwfgMqM8Cg01zDOiwas1tqJYGVfEIIrKIbL1dViaiVxGomXw/E3AdJbP0wJvO7i7BP3rnzePy4uMV+cP7d0UBIblLSMzaHg2O4TD2Xp+OpbWrPPEJSDCVIE3NymPE2ft32na0KxZTomb5cMDI+aVIA6V/sPFW7faqhcBoQOu8ZIlZirU/AyEThy4GhdbNvzsemzt+7ze1hTVnBj+ECMk7tEL4LKM9ya/MQEnWXScUW1rVj+OkAq+uvNAdCBNOOfowlrEUiIlm+U532ksECnb7zTAbNO+4UnKRoUeSrCIgyqJKoINUAWB2pqagWHfahfbOh38UuDf9rVjKUTDA+RcA1yKHMDNDGTeenntmnPWT4hjxVfSE2JVrfaYMDKE3kRRfi7rfTQIwEnrDilVFEa1Ejt++J1v8m0HF0Dot8Iwdq1j1vHznPTUPnqHV6Mz67o1J+bIwujEzsMbHsSH4kcCv5wy7p/WefE6S6Smwz9q9iC74WGVLbVi4TlutJaDViAaTBO6TkljnY09le9OgIPmtqKilQrAldIP/MES8Uzps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ad6996-ff56-46bb-571e-08db1c397cbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 22:49:03.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqF9GgqdFLPKijPFXHyazhKmlNvKU8dvRwBZ6ElaSxrkLFihSK3iJ+iAeO3LT6+841YAUxsE9L9A0ShsyA4LFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_05,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030193
X-Proofpoint-GUID: -bVaP1UAKZgUtFb-XVMCPjLh_GpFsg3_
X-Proofpoint-ORIG-GUID: -bVaP1UAKZgUtFb-XVMCPjLh_GpFsg3_
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> Return the conaining struct btrfs_bio instead of the less type safe
> struct bio from btrfs_bio_alloc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Anand Jain <anand.jain@oracle.com>


-	struct bio *bio;
+	struct btrfs_bio *bbio;

Here, dereferenced for bio from %bbio appears more than once.
I am curious why you didn't choose to initialize the bio instead.
