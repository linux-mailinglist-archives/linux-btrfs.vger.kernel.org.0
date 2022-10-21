Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4374A607101
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJUHZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 03:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJUHZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 03:25:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F517C554
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 00:25:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OwjI019257;
        Fri, 21 Oct 2022 07:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7LuvZ3F1D+m4h8C0I+j3a+84N60FmlbBTfwVkzW9Vtk=;
 b=pfwfm7IHwxtpZWGcKxuW685Fl1OsdUpRztOVovZPVTx+452+tKX2SHklBcJNXm4mD5dS
 Rm9TjBhSZjr0LOUJHidsURpjC/Kh8JXCsHAgb4TyAw7hiWADomDubM4AeI/+WRiMQstH
 1gtBVnat3BupDQW6jyZFPVloR8/hIHV9aZG8V/wHgoBJXa/TLYXOkkn3dgkp2NC3O3ZQ
 UN4s7WzmPT2V/eneATm0RN0Rur4gSSu6UvkeBKiyYDt+GVfZmstBBxG67tuFgXPqgydB
 +m/zaGJvl8DigCFeofnuZcSSlnYUOVGZ9uLEh2iedSvqp5SXHxN32O2kfup71SU0PGv0 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9awwattm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:25:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L53Vjg027376;
        Fri, 21 Oct 2022 07:25:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htkbgcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpiz7w67XXb5cxpmWsn2frprX2NZUnE2IlQdoFT/1w1yIu4J9qqYug/PVMgipFGu/jgbQCSECN63/D69b3tSbslzbHEQPiF7NmFlwrMq6+xBoEGbWs7oqbDP6/L72puZClnq/kaehWBpO8tIjThaBy1na74/EPXO9+U1Z0fmO/ogHy2Q62u2iXUHCmQtEJSMpkNFx2WJVoYUxEEAXEQVwQlNH1HSxQ6Opmh5jgYzvWmyFM6CgryZ2OwKkODBrF/6J4XqHwDo0mNDkA9VML6gCLQlPirlwN/Kcso+3tXofyAQnpv+z4rpc67b3CSX9G3nn11dhff5fKJP5lbGGnKMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LuvZ3F1D+m4h8C0I+j3a+84N60FmlbBTfwVkzW9Vtk=;
 b=eM5nCAMXjq6gq5kzdyx549E/5e7YYjEoO/wAwwg298paNKxlJvVj4G2LApuP5J1ina4JWssWcITk8Yyt/uHDECx9xtRd7goGNpjyEsonesszbFUgNqAG4bf7ZpSfbGwJZVHpI4PzK4OBIaYQkEkFhDUvycCQdRfQOHi9JBXvK4zTDcnRPkdXXiASm9IgqP1J+EZMHyHdYGDZxsFTv4p6JAkObn8Yx0LX7rLF8/wQQU22hZ5aggsTukFLSCgnJKbKYwn/hok9SBqPTsmwpp8FF3ISGCi40Cv7Lz8X8mYmKUDSLPHzb1uo3zwISPnh0omtXB6XNskcwBFBz1++0g2HGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LuvZ3F1D+m4h8C0I+j3a+84N60FmlbBTfwVkzW9Vtk=;
 b=nJ7d+mG/PV4EYL8B8CP1WxMRogM+cw7Oq0Wb2i9zFPbX/4BsfXp6ohbSaNbpckkeBfLU6jIqYcbl98bObY+TaMgkfZ8pg+dHzOzJRIFBEgBWEfi/m2l9lfKf2ge39doaR8x2GFpkDD6nOqi/mejc2vGav67HRF3WiuCHe2ibIzA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 07:25:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 07:25:30 +0000
Message-ID: <d1df1a33-473a-c6c8-5c6d-48f6957a9109@oracle.com>
Date:   Fri, 21 Oct 2022 15:25:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 15/15] btrfs: remove temporary btrfs_map_token
 declaration in ctree.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1666190849.git.josef@toxicpanda.com>
 <5cfd74155b651c5a4305511e59c3aa1f20090293.1666190850.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5cfd74155b651c5a4305511e59c3aa1f20090293.1666190850.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c37367-d5cd-4801-8c05-08dab3356ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJ2uWv6tv4vFB08lXg4rE5yy5yeGggTkYqY6g8BCymMR4r5Mq1+nBmwriB3J1uCjTNKPMh1XolnVi3MO3jGWDdsZeu3TuK6sZnEcDvQ8NsVe1xDPGY2l51cn9wANFc/sR11sqsydeMTJXsWU9XE5fmUSPG5G0Z7PGmbJu+1q1ermhh2YrVcQSxAOFUandqXU5XaZgqEhK5EtXS8Ha18nB+L4mzCMM0a3c3mrbceM89Pgh/D5kjhV8TifyIs/6vrYd/p0WwZWDcrkDfEiT8y6ehHKOTiNzzLrdfS/C5O2KCqDLckD1XisfZNuDEggvfZf27e7BnZgoQoX4dcs8A+sttpTGSKTE7wgJ4h35HxcJ4x+UinslrcnvGHZh86eIgmaHpJj4ZTKDdSQIu/YJuGXyiCY7VFKwv5gP4AZvtJR2JNpp21HWiO/ZmfcwfvxmCNB7Yr5xWSAPsrgkC7OtTpxwZbJ2P1rZfIL7x/glhMsvJn2ik02SoFYQi986G03TL7KcWXw9v0rnntg4p/hCbQ3cnFmfHQkbI2qv5cCzyugByKTDuqGWQEdldeBKHDHy8B9RNYnNzaaFbf30gxB1/3hCfdG36xyNg6+oxIuik46Xsds1xsOHzUqb6plgkS6k+zn/+F0+FCZkUCc7zHB0SR8Lu2DTCJVB/2ma8suPLmVKazhZxwWYfU4sFNWmJkS4GDA4DozAyfW1dALSgCZwndVe9UNjwsCNh58vJBEZa3ETA1yzhDuAmKzi0oi/pbahc76poGBszE255v4A63pPmCobPdIU+igN3966iKV7wu/zX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(558084003)(186003)(6486002)(38100700002)(2906002)(2616005)(478600001)(66556008)(66476007)(86362001)(66946007)(8676002)(44832011)(8936002)(6512007)(6666004)(31686004)(26005)(6506007)(36756003)(41300700001)(31696002)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFpteXdVcDc0WmloZGdLbHV6RHc5RUJMT3Q4MHMvVHBvclF2dFRVL0JNR3da?=
 =?utf-8?B?c2xEUHVpMnBQZjRnbDY1R0sxQWVDSEdmNCtNY3BpVXo5QmFQaEZnbmg3bllM?=
 =?utf-8?B?MHRCY21SK2Vwd3I4SktHbThac1hoU1dVREZHUmhzWUhNNkV0UDVrMU9YaUxF?=
 =?utf-8?B?cVFaN2llaHdJdkVha29ueFQ3cXNtUnFTckZTd2o0ZDBTQXkzNGdiMmJLVzZI?=
 =?utf-8?B?YUgreHQ3aE0ycW40Q09MbVh5NE5PdTkzSmtKZkkxZkQranpBV2drTURFc0V3?=
 =?utf-8?B?YVVvNmxWM3pCeWtqWGJJTUpBblpuVUV6dWhaRzRDMUhPTy9hcUJXaW9yV3lu?=
 =?utf-8?B?R1hrSTRKUG9GaCt4bW5MUTlsazdNTnNZUzlSWk1yclZUaW9WOGJaNFRnRXVy?=
 =?utf-8?B?VEhlL2JLdm95ekMyUWtwc2hXOHJvaGNsY1p0aWJZUmFKbEYzK1BNOW9NZ2Fy?=
 =?utf-8?B?b3UvRnUxT3piREZzRUtJeHJ2TFBCUEVQRE13UVlHMEJUNFBNeXZiang2bHNK?=
 =?utf-8?B?UzZmNGUvTkRRVFVOQjJIa1dNbm5zdFp5QlpUczBxWUpGMGxYSlEzN1NPb1JM?=
 =?utf-8?B?SE13cTlZRFdmKzl3ckpjaUY2QUNnL1F1akF5M2VzbngwcGpkR0FYQnJRa250?=
 =?utf-8?B?eFB2dCs3cklRR0NreHJNZFdVQXR5aHZvOTRYREdENERsY21rK0Qvb0NXYS9l?=
 =?utf-8?B?dHFLbEZId3VZUU5ZQ2pzY2FXa3J2Qi9Xa280OXhVaUx1cTFJbUY5SWZQazV1?=
 =?utf-8?B?dkxIczVDM1FMOWthendBRFUyT05ZZVFYN1hWOEdHNDVsQjZ6T1RtT29rbnJy?=
 =?utf-8?B?Vm55NTZYSitSekJJV1hlemk4TFk2djFMdlZQWjcxOUVXMVp1ZXRiK0JpNEJm?=
 =?utf-8?B?TGZ3SVV6Z0haY1MrZFlLR002TzZKbzdFcU1jVzNPWU9kR2dEY29vYXd6OXZI?=
 =?utf-8?B?YTlCK1AzR1RwM0RuZExRdHVseHQyd0xwTGptK2RrNHZkT0ZyNFhaRHhTT2c1?=
 =?utf-8?B?WmVLOC9FUytvVjRYM1N0M1ZkQ0cxeXduVDdUNU9Ob0dpK3FteHVxT3ErdDBy?=
 =?utf-8?B?Y1gyL0ZPSEpPQW5ma3paV2lzRi9TczNwZnBCN1JhK0grQlBIY0N1NzFIOW5o?=
 =?utf-8?B?Um9oNUVPNkhBNmV1Y1dDYnBXUzlodWNYcSt2eFh3QmZXOTgzZ1FPVm1XYlBm?=
 =?utf-8?B?M0cvZ1dKS1NOUXI2UitZeTVuK1JQZjVOQWxXcEZTRldHV252MzdFdW1tNGtL?=
 =?utf-8?B?RGdFR0REK010NGlWNjRwVitmUDZyMG5obkM4NlZKbXY5cTgyM3JQaSs0VTFK?=
 =?utf-8?B?M3BWZlNJbXBmRWZORTdwQlJpVWswSjlvOUxIY0pqRC9nS3NEeHBWUHg5cUo1?=
 =?utf-8?B?aUswNGIxLzhnbzlxdzgrclNmTVNqendMUWZNK0Y0MGYrSnNoZkJmdVdQVE82?=
 =?utf-8?B?YU9EMTBGcEZGU0FScjY0cDd2dTRRNkRqWVNCMDUxZ1dVbXpXRU93NnNTNTF4?=
 =?utf-8?B?NzZpQXVET0FQU2NFRTdRdDZld2wyL0IyNDBLY2QyTzJ4cWNyLzREck9jSFhJ?=
 =?utf-8?B?alJIOFJkWXBERnpNRjUzZVEzSlVJVnduWEozMFhld1FRZGlJRDVwbUw4SlhF?=
 =?utf-8?B?MlNaYVFCYVBOaVRTeWplNHpLeFFmb3QzckRmWFJ0eWwvdHVXKzVkSDZERU5w?=
 =?utf-8?B?eldLL2FYdFZHRFg4em1tL3IzeFRCS0NiUEprWlB5VHY3emNzOGVxanlhWG5z?=
 =?utf-8?B?U1U1Z3dNUWNFVHBJTmllclZMK0F3eDRtUjNwZlFKZlp3YmZ4NWNPc0g5ZkNM?=
 =?utf-8?B?aWJjZHRQMHhWU1R0Q1M1OWxvY1pzVG83SU5aMzVYNW5JelZUUitkR3FQU0Rs?=
 =?utf-8?B?bkdoWTVlVDk1ZzBGd3A5aTYzdXVaNXk0L0lGdHpaUjFHM0ovQVZGK0NzblRh?=
 =?utf-8?B?Y0NvMnUrTVppVzZpWVB4YnlZZTFibjk4M3FCV0VBYk1VcjZ1T1I5Ulo3M2J4?=
 =?utf-8?B?K1dJUENzbnVDdklrTmRMZnZwckRXcjdMWE1ibEVINFkydEcza2d6VDA1QUNJ?=
 =?utf-8?B?cW1nOHF0SnNpbmFFeThxbmw2cUdZY2VpcHNhRDZyei9YRnU2aDhldjVyYXli?=
 =?utf-8?Q?OaY6D5Qmmg3W8vDIDP1cV+UPE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c37367-d5cd-4801-8c05-08dab3356ec5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:25:30.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWpo+3DPAEJchQuvFxwa3TzxFcO6vB+sf8+LYjQS7ar3CqeM0GLJRnkGfIoU7eo2dDOSgNnmEF9vc1S+MCJBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210043
X-Proofpoint-GUID: qPgHh4WVGKPV6wfFktAR8bzyGcCrpskB
X-Proofpoint-ORIG-GUID: qPgHh4WVGKPV6wfFktAR8bzyGcCrpskB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

same as v1.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
