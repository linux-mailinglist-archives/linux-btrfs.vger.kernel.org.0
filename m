Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BAF6FC501
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjEIL3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbjEIL3E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:29:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C746BD;
        Tue,  9 May 2023 04:29:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34972Y9Y002898;
        Tue, 9 May 2023 11:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : references : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PBR2ldHq9LMyoVy/gBU8lQ8D5liElF5dj2GNkVsUSHc=;
 b=oww1QABE80RXdn3Ad1N/gdus+c+y/E7DpkVHXQD0RgrSPY3Lc6GlJ4Sfbiw4C6sVb7fG
 oQDtFyHLbbwJXQ3LJTi2uy+xkcY8F02jAD+wfsLj4YLtpuhOtkTmRlgpbgCDhFv38gz/
 tAdKdZmPZdPEHpf8jLgt6Jz2e/kjV3E3Lga5zQuv152/MxTjWEUPKNiwQg+PQ1Byh9j4
 TQZ25UbeGI14YSaFQSPVz8xbQ5/AYWv6LDLKFmRZgfhjx02a+KrJmqXaVg2eoohtYkeW
 /ruGZnFa2lC9NjdOHlgDz+83nxbU10KR2/Ci3oYoi9aeRTqQLOxyOl/ShRlXOnsxUWhu ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77c1hym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 11:28:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349AAuBH015273;
        Tue, 9 May 2023 11:28:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77fubjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 11:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWI/pogx3y+P8MlSVuWAyV0I1UIF+r1qubLTHCXrh16oHUO5I5G7a+jcfG8t11C7Om3x43Z8xWOYL5clec7lNQbNcHniBuAsrOd2WXp5/OlklXkZSsDA134fTL6V4gzhCrBs8B7n+iEhHTFYhg4TgneRXcYgJjzDL0mM9OjNyGhH7v7fIMGSPIt2ZjkSlnq5y3viDeDJVm5HnWbaTwym54+sYjkFshyTcTfDSitemNxO1v9uj5ZB7c9Vz0iNP5eTl0i6VVMhSb/4lFTthdHDe/U+SXqs70goZlc0ai5U07003e6vI1hXxrVJaxoQzw9FYGnrZXO1za4nGISvxgY+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBR2ldHq9LMyoVy/gBU8lQ8D5liElF5dj2GNkVsUSHc=;
 b=mOB+uy2kXTRY/wwum9oD3/90lnSsvVQryDue461g7D8ipUfHpZD4SA6SVvXJFXanS8qepzM+uEKauliKp8RSOIYQD38JA5vIj1KZ47gOdk7/DiEiRjgLUm682WwyNjW7KpqggeGCZwcwVarvUSECS2PHmYqIwi+pjqYolZBILMvAquvzqVdP1b2alKzRLEj+49U7fkI1uPxhypGJjx6DAu2WCrZSvS5wDXDz7iX2/+MPIY04ASvglcDjxh+1phytQLq+HoNxpzNadjYuWWIdevnCSEULBjYAIc7s3mrAeOurG0kRuTSw0pZwXS4tIJNkelTBFJJ/HC/GJ/OqJ3IIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBR2ldHq9LMyoVy/gBU8lQ8D5liElF5dj2GNkVsUSHc=;
 b=m7O61zokW/uoUNvLdChhxX6af5a/AXysBxwMsxmGdKIUin6YTSU8dUumpf9kChPXADiApNbumCo+Gy32hRKksbgVih/VcJaG8u2b/Pn6ccl2JJ40cYoH4Y4/x4pzauEKlPAUG0iH9WiK3nA36fqy5NJYHorF/zere3bTG/O4IS8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB5916.namprd10.prod.outlook.com (2603:10b6:930:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 11:28:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 11:28:38 +0000
Message-ID: <30710fb8-00cb-34de-4ba4-6b3d364e4093@oracle.com>
Date:   Tue, 9 May 2023 19:28:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: add a test case to check btrfs won't crash on
 certain corruption
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
References: <20230225091438.55728-1-wqu@suse.com>
Content-Language: en-US
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20230225091438.55728-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0073.apcprd02.prod.outlook.com
 (2603:1096:4:90::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af27313-5e5b-4790-3507-08db508088ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysnTl1ytSY49RlTLoN0FE6L2CX7VDmws1LlIaQmlrThUsvl9WAwZ9L9uthP5AOQVsutEmy577CfGlAnSBJHKqBi9q7FsHStZudOisWpHJLkU8VUkXbVnG56ID8X3jwyY0WNHybAN6DsmbM58KUT8HGdp7TdM/nElsxaMDeffDKRAEC65DvTTLAbg54CrSKBB9AXwBkoAVV+eV54UyK6Nn6o9VPnkFKiTYvXrk9OjuIo5Jiwr8X2Yt5N9ahyQECl6J2KyJWa4wN/4p0OiYWTS+3D88PT5kdQZffCDAOThyRHPjq7KU3pud/FvMzV7Hs9YDw/TMMk7PJwlXPCZHGoa62F/4lDGVsLUt2oh/Vx3VhsWlfyCaSPVsjUiGDiiuVI5/6fELuzt0iRSDisYAEZNLSKjpR+cqNciFsomqTO8MEWW5rjt9IGMCN7l3lrvyd6+q+97MUdk1gtxDYsHoFv+/6PKj/RxjnrL8Fp2MlFd5RlguEUonkaWScScPWVFmx6lqxr6gJ73RtomVrUF/4Z4VOYO/ER2HRaoHVXjQgVXQ4wzuJ7Rhr7b3z7Dew9z4+pQEEsFPBd3zP7vg0uChadwrFyd15R3+xhdbdKncGxWUCu5jQAqzx2KXv0IR9LPrxgnb0GJS4OAa1hTbN6H/okRTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(186003)(6486002)(478600001)(6666004)(44832011)(86362001)(53546011)(26005)(6512007)(6506007)(31696002)(2906002)(38100700002)(4326008)(31686004)(41300700001)(83380400001)(5660300002)(2616005)(8936002)(8676002)(316002)(36756003)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1JWVlpQWHNubEI3c2M4V3Jza2F2Sys1b3ZEOVlybGExUHJyUFUyWE5MdXNm?=
 =?utf-8?B?cmJQQ2g1WHBPcmN3TitTZ0x5dUdWaWJDT0RDeWNGS3hIbHZ4UVZpeVhCeHE2?=
 =?utf-8?B?cjhGUG1PdlBHOWdVZ3F2V2YyTWdkN1lRZnBrd1VWWUNWcng2cU45NHdxakQ3?=
 =?utf-8?B?VEs5VUxJcWNwT1RDN2tQSUlxclVwcXZrZXZ4K1Y2bUZmYUJSenlyY2x4SnpZ?=
 =?utf-8?B?R0hUbFNqOGJJc1lOdkp1cVZBbmR3NzZ0MndxZjZQV0Y1Z2hPb2hhZmwxc3pq?=
 =?utf-8?B?ODNxaitqNXZVcnQwSTg5OHZyTlI5cGJyUGZKV3dFN0V2bkVGVTgySEQwY09Z?=
 =?utf-8?B?N3JMV1ROdXRsWUZuaTRNdEhwVWQrYnVkcDJtbExBQ0JRcStQbVp2L2ZZZ2dN?=
 =?utf-8?B?UDRiZlBRUTVOSDRxVmNHL2ZsVHZuUDB0NzdLWkthRzhlL1Zwb2lxY1U0RFd5?=
 =?utf-8?B?Sm1VQlZxUmtvL3pTOEkzcHIzL0FsTzN1d2hPTWREVGtqY2g3cC9iL0lybkEv?=
 =?utf-8?B?S1VpbEJpbWlndCtQSDdFalVTTkxvbDdod1U4UjdaMGNTWiszZDZ4Z0NUMnow?=
 =?utf-8?B?MWxhN0IycHBVQ2xHTVNnU1ZBdllVeDFHMmk0ZnB2Q0M5SVRKVUZRSkJkT2VQ?=
 =?utf-8?B?VEtlczYwa3MwSnkwTHM1SE1qQmNLbzVOeEpaRktMSFRveGFieUF2QTZrbFJu?=
 =?utf-8?B?WEZYb2dERWlMQlRXZ2lGRkc0UmNBaHBPWGtEV3RGTGpjRGZkNDZFODRFUVJx?=
 =?utf-8?B?bFF1bUpCVzNnL3FhL1Y0MW5YUURHWm5FZlg3dDhxQzg3Vzc2QVJrSWQ0aEpq?=
 =?utf-8?B?TU9ZeHNuR1FlVlNYcGZQL0pvMk03T1V6RVFtNjhyTHc3eEhCZmFQdVc5ZXFX?=
 =?utf-8?B?L1pCSHFuaktDU1ZaQzR0Vkt1eVpDUWFpV0t1U2R2MllSUTFLV25MaVhKTUI0?=
 =?utf-8?B?Y2VUUWZqZkhZNXhkRjY0QW9udzBRb3QwZ2NlaFlIQlJtaGQ4aUhxaFlldTRh?=
 =?utf-8?B?ZzN2U0U5bTBsNzhKaDlkNHp2bEVaQVoyMDFDR2pVWSt6R3hsUmNmL3dkQ01v?=
 =?utf-8?B?SU1PMmJTUmxFS2JjN1U1cStVQmdKWU9TN1RkSGFLWVRlajZUaFlQMnpFTkNh?=
 =?utf-8?B?NDdjOXkrMlpIMDNhQm1YZ2FiRjR1dWVjcThWVmJiT3AyaXk2c2kwL0JaL3J1?=
 =?utf-8?B?anVNOXZnb1l2ZnpDZy92aFlEellXYWpuOTV6dUZSNFpMdzVONWI1UlprS2hx?=
 =?utf-8?B?QXhlQTJrOWRnMEEzeGpJVWd3WkN2SndwWHB6OVJFeUJiSmIzSTdwZEJrMGlW?=
 =?utf-8?B?Q1U4YktlMzAyYVpPSWRDSWNRMkxTSTVhNUJSaWMxWWlQN2lURG15bDNZSm5G?=
 =?utf-8?B?OTJoRWRxL0l6VEpaSytCN3k0MlZHdGlja05tVG4vMy9pd1VjQytWejhiYUtZ?=
 =?utf-8?B?L1B2Q3NVbWhVN3VWN3Q0Mk15czdvcjNjSkRORlN1ZzJtTDRFeEtBZkZpRlBZ?=
 =?utf-8?B?TENyeXc2UlEzbEljVldncUFzRnYwWmlUTlk1TCtxdFdxTUlpYzVLUUJGK3Jj?=
 =?utf-8?B?VDU3RVFucGFuRFdvTFJuYVh5OTlMaktmLzlabDVnQXErSWs1ZjZhUU1vSEVE?=
 =?utf-8?B?WGwzYWpvbEVXckFXMWZBcXhVT1h6bTVPbmNOQzdlRzdDZ201R0JFMzNMaHYz?=
 =?utf-8?B?Qm82V1hCSE9mYjNuRmtxUHFiMFFUaTI4ajE4dU54MFRtTDFsTEVob2k1RUs3?=
 =?utf-8?B?S2tlVXFzWnROME1wZWZkZDdqbVlSU205bDNBVTNUaHFBa3ZBUjdhSjR0V3NO?=
 =?utf-8?B?dkZiTC94cXRhZEkxcXFhZ0R2ZDE3bFFaQWk3RC9PYnNXS2xXWWwvVTkxM3lz?=
 =?utf-8?B?S0RGNEphM1M0KzBlNzk3YVB4djRxRkNWajBscEg1c3d6Uk9RWkJMZjBsMHJD?=
 =?utf-8?B?WTZ5MEdLbGdnL3ZIM093TnVoNXk0ZE4zK3ZMRVlzblJEQXM1ODFHQVdpem0z?=
 =?utf-8?B?eDZCUXEvd2hUTUFZMFUyMGRlSjZ1cEFZa0lwa0VpV2orV2pnUXNUM1o3TENR?=
 =?utf-8?B?RTRoejUxeXlSV1k2R28zNzlNOTZURDdyQVB5NEttM0kwQVhvL3dqdlJaVkV1?=
 =?utf-8?Q?/JSagHyXyKXaaod9xF1nVc782?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VmWIxJHKiu8S4QA+NGiiAnVI/R4I1CDs7opP/2ZCIgVUPmgz4LoJk7B7FUx10jLgiGp9nMpU7PiUmVqPAI1vh5t8IGRjtA8PRHJ6qnx3iISGk7J1DIM5EL3APNAeRcruNgeCZWX3RrS9fzZRdv4/71zH6vo92W3+6mS9dkGN++XEtYqEGfbj5jAQ84/oqqH2Dbp7h/w8OcVoQbD9jwOet14b+zCJjMa97vEYDmqDaQtB1SeJL3BvbfQPkUmq8gTEZD7eAad1JtzeQnee69zwTnsEde5waiR4vGURsEmIoY4xqR88L5TXRNrcrF+IOkrEnwMB4lTfTZRyd84qtryc+MxVBdlSzTPZAJq76Un4HPyLTPoybnF9yAqlvSHwA7RZZqEeT4uPEnGypFc3p1f/SmxA+eAG0QAXwiZHMKTExNm5wuy9R9b4ZVAEWlZh+FFjS7M6ucPNYFsVhDLPj5aPwJk7dCe7P+xnXz7wLv0fc9wjKQyRPnZ9EQXd76+kD6xEO7cUhJiz+Aoroo20bN0Z35CFYQetFOkdJMH2dc3y34YkXfvavuPWnXi6aX5WP0wTzUYj2GZzLiwfO/3V43yPkjm2MW5GH6Fz4cT5nHwzCmca7fKBZiH2BWBdPP3uSgh+DXhNsX6pYuIODDRXroL8a6+5k+Otm7E3hTIJma9ACkBILukfe+RpDJr7cvhKBSO+cm4nlS5T27yJaqHEMouiHsvAq9PsbE06qw3VVP9dhs0N2dQd8caPPxjJ/EPIrwnEc4p8b+D7F0pPRWXf1ZSAgQ843mXnsbAkHOEBk0QsNfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af27313-5e5b-4790-3507-08db508088ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:28:38.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D/cd6x63fJL2PDeY/sZOSS4f4uJegjzNX1ElK52sHy/LNqyZgm4NEIc/qH1Kf3fiFq7zHBTsFfhKQjCVb3daA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090092
X-Proofpoint-GUID: uyebfINQxbCLrIbo_Ikmpp7_pPLpSkiS
X-Proofpoint-ORIG-GUID: uyebfINQxbCLrIbo_Ikmpp7_pPLpSkiS
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




  Added to local branch with the following changed. Under testing.

On 25/02/2023 17:14, Qu Wenruo wrote:
> There seems to be a newly introduced regression that btrfs no longer
> properly handles critical errors during mount.
> 
> Such regression lead to crash when mounting an fs with a corrupted tree
> root.
> 

We can now remove this, as we have identified and resolved a regression
in a local branch. The fix went into

   [PATCH] btrfs: move all btree initialization into btrfs_init_btree_inode


> The test case would reproduce the situation by creating an empty fs,
> with SINGLE metadata profile, then corrupt the tree root manually.
> Finally try mounting the corrupted fs, the mount should fail while our
> kernel should not fail.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> The fix is titled "btrfs: fix the mount crash caused by confusing return
> value", and is already submitted to the btrfs list.
> 
> Unfortunately git blame doesn't give a good enough clue on which commit
> introduced the regression.

> ---
>   tests/btrfs/288     | 37 +++++++++++++++++++++++++++++++++++++
>   tests/btrfs/288.out |  2 ++
>   2 files changed, 39 insertions(+)
>   create mode 100755 tests/btrfs/288
>   create mode 100644 tests/btrfs/288.out
> 
> diff --git a/tests/btrfs/288 b/tests/btrfs/288
> new file mode 100755
> index 00000000..029603c8
> --- /dev/null
> +++ b/tests/btrfs/288
> @@ -0,0 +1,37 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 288
> +#
> +# Make sure btrfs handles critical errors gracefully during mount.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dangerous
> +
> +. ./common/filter
> +_supported_fs btrfs
> +_require_scratch
> +
> +# Use single metadata profile so we only need to corrupt one copy of tree block
> +_scratch_mkfs -m single > $seqres.full
> +

> +logical_root=$($BTRFS_UTIL_PROG inspect dump-tree -t root "$SCRATCH_DEV" | grep leaf | head -n1 | cut -f2 -d\  )

  Fixed 80-char length.

> +physical_root=$(_btrfs_get_physical $logical_root 1)
> +
> +echo "tree root logical=$logical_root" >> $seqres.full
> +echo "tree root physical=$physical_root" >> $seqres.full
> +
> +_pwrite_byte 0x00 "$physical_root" 4 $SCRATCH_DEV > $seqres.full

  Append $seqres.full

> +
> +# For unpatched kernel, the mount may lead to crash

  Fix comment.

> +_try_scratch_mount >> $seqres.full 2>&1
> +
> +echo "Silence is golden"
> +
> +# Re-create the fs to avoid false alert from the corrupted fs.
> +_scratch_mkfs -m single > $seqres.full

  Append $seqres.full

Thanks, Anand

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/288.out b/tests/btrfs/288.out
> new file mode 100644
> index 00000000..2958a5c3
> --- /dev/null
> +++ b/tests/btrfs/288.out
> @@ -0,0 +1,2 @@
> +QA output created by 288
> +Silence is golden

