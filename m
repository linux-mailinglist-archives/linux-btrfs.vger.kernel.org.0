Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10482782632
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHUJZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHUJZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 05:25:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB88ED7;
        Mon, 21 Aug 2023 02:25:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KMk6Tg021045;
        Mon, 21 Aug 2023 09:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=RkMfc2FN7aKOw/NiODPDBmJrqDHVQjOQhDkF/eqIszcpHbJ5L619S7p1q1sGAmpAZDEC
 EdCJAk/mTMvxyCV1clpeTIHN8oWNiYUaZ1WTWwbLYcfCctdJlrKVLBAUgdlV1DDpAVoy
 hVUeDrx+t+Pe/CvlwI75LnW4jXMLFTgp2sBrb5ugAiIRjaD8403U2XRgE6EDV1T7nzbJ
 SUk6uiVnVdP6d1UdM+jiQ9sYBTbKQVGY51V2qtkg7NPW6tlD2ikW1IJhtE+AfJ9jXm09
 S8kQSMR+6wRfPmB55IPtbYKK3IpZUjNp+XbgV/JAT+qc46oSbv4at7v48p08ev8/6yoY DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma2e33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:25:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L88vGv030364;
        Mon, 21 Aug 2023 09:25:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm637m32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezZ1Y7sAJhPeQzj2qQGtfpg43aslJGuzn64ktX1n50t41x8OwY7gwde/rJwFXGYW6ldJ7EK5pb025y4+f7qsGC8XqM29fV/4P9KbUpzWrzqBhqR0uA7nWrioPIVDNN9odwDEpjbMlW0jzrwqi2czEFfYscBzHMQOKKDJlojboxED6h8yQvR2Ue6G2WVTXfGxJZ01a5K6dWJ6xsbS2Qqy1J69CChc+K8kthX6ioO0u5W7xq6DQFQJn8j4cZQHD9tapzRGSfnu/cC5aU1MHkztyBIVkOnJcrBbW9trmuJSFa7BPMuDIUvwICTK2ijHKitc6VCwojko3JZnIdGCf1ohnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=dQZ0SYP9nOMdt4ItdxzZi1nyJkneUHPPEHsuwuieFDXoaDPdBgs+RBGoecEMCYaY3sPYz/pj2YITSk+iJKqtRqvoOXL0uY4D9x2d2GGifaVUJigHlEujpSbH1ZWTy0kRONf1LCW0VXcd6wSplKeZ9k1fsZB2leyAIH4exLtCMGq+AG5/ScGEWKeYmkAVgB4oYD4w4eNTZ1QGOiDaEj+1ZHEL/calPcZbOrpUf1T8mjIo5K6BLps3knCZOpK9r0RLgoo1FE06WgpgMCUofADQhWm1P2hskwMgOziItEZTU2mGQClnQUBzC1M6NQdbrpE28CP5GZ0Ha7ifuJRs0zqMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=HsLjyLtFAVSBh/0Kap8bXGWhAuqheGMTl0fzeEhQwj9XzXL5t2X6LPqpllqNR0BGPGxWwJfWPjMzUeKVOkToRXreErpeKHaAeEPBo9eakjRJ8KjvwkLd1NQF+CwOqgwing++nssafghywM9219LyrnCk/gnWqFRMj7CQ+rJwJHI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5227.namprd10.prod.outlook.com (2603:10b6:610:c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:25:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 09:25:39 +0000
Message-ID: <8b8f90c4-000f-4662-1fc4-1306f50203b9@oracle.com>
Date:   Mon, 21 Aug 2023 17:25:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/3] btrfs/004: use shuf to shuffle the file lines
To:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1692600259.git.naohiro.aota@wdc.com>
 <2d118ed03559472a0bf878509a32a9dded03efb2.1692600259.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2d118ed03559472a0bf878509a32a9dded03efb2.1692600259.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: f38f2303-9821-480b-34a5-08dba2289548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slbA8rF8Hr3Ph8L4iX4WoSvtJqqcr2E2ik5BaeBv6s6YDFvecHGjNt1ARafAzZTHV+yFU/yvgfCDWZYOtK0ONgdFEZNnfJzO5ddTgQ6NBxNNv8sbB/3081DB0oJtWJ3qyiAia1/69jBpDZr0H94gLhp3xWpFgq8WICxyiWgFaLz99iMOoPhGU3K6CTXTFq7feuShg+hIn1uDnBzAAlRQsdEh/cLVBLTfyoNXmDXrlfv6l3zwg9kiSV97HQnNS/PcIyj8ZSA2cSPVDbIhNXHuhax5AaRkbg2tN5BDpylTJFcAFjehghYo+GwkMAo60ALh5En6ClwxLktd1sr2p+M+oobkEdeO+dgtBrPQNAvgcpIKuPhM5E1wSoJ6vzGAac2FYGPAxC3N0tsf8Zm+pJ34HCJVJu44ZXlJtbn3v801rh2qP2FFiwtAb2+UxK1CRMvSPt6REbjuZgeFQ66XYDUyWwMk/veqJgVno0C7xCOshGvxOAb+sA38UCt0LSGSR62D0anNSYdfJyBRpx/mx1CZkyxPOtHuCMVjUL56Vh/gACUut/0Tcy17fW39d0kFQhqwLMMed0vBZtBOI9gXlfZxaMe1IPCsA3CV6XLve7wQZphUFKqxUL6rQI5rqcmQcgMlQRpAVkBsElEQcMk/UI7MDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(558084003)(5660300002)(44832011)(4270600006)(26005)(86362001)(31686004)(31696002)(19618925003)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVdmZlJJNU9vVlg4WDRURlR0SDRKM0NkbWVBUUJTa2U3UEx3amxSQUJXOWdY?=
 =?utf-8?B?TFVZYmZEM3psTVlHR3RhZjlaSXJlYm0zeTJqVFE2WXE3bDJZSkV5ZkJWNzZs?=
 =?utf-8?B?UlZ4cE5mY3lnc2tJOHI2ZUErNEdTWGVwRU9nQ0p1RzlkL0tMZHR6SFVESEJO?=
 =?utf-8?B?aUxSaUczVHFFS0N4SGhrNEg1K29CZk1vTXdObWZRaWRiWUFsRC9kZTIydy9t?=
 =?utf-8?B?eml5S3p6eGRLWHQ4UmxBZ2FSWjVyUXRyWWVkMmQ1cUJNcVRTb251VjZTcTN2?=
 =?utf-8?B?V20yamhrTWdMRTdsOXc2MS9Tb0RXOGt4OEJ3WlM2eWtCWEt5Wnh6endMZEQx?=
 =?utf-8?B?dTFiVld0VTVwWVhGSWRYaTZPemxwaExTaGpETEhmMk80Y3AyOVplL0lRQXVB?=
 =?utf-8?B?U3FSYmRRSFl0dFY2V1FjTEgyM0xqMDA5RU9DWnkrSHNRUitSWGpuUjRYck9i?=
 =?utf-8?B?QmVFdEF1SjVKaVo1UnhydDRjU1NuWENmZ2hoNzNCQ2RBUzB3dlArMUx0a2Vo?=
 =?utf-8?B?ajVobjQrSjJiY0pVRjNJRzhrMUI2ZkxXU1NXcXhtRWRLOUVRRXdsMVl4VUlK?=
 =?utf-8?B?dnNhVkZJNjgyVGdxbzFpUy95QXlXcThab0x4bmFRS1o5YzliOG5EUDBQQ2JV?=
 =?utf-8?B?MEVWOHI4Q0lNRUlnNVgyOWRHSGdWT0hRQVNhT2hLY2FaU3k3QW5qemIwK0ph?=
 =?utf-8?B?SjFyNDdMcjJnTkhXakxMeUQwOXRka3BCMkRoY1c4bkhpVEVlVjduRmd6d1Vw?=
 =?utf-8?B?ajh5eVpMT0M3TmVFcU85anZFK3RMUTB4UGpIOEtMUGIxZW5adTdtbm1nSjdy?=
 =?utf-8?B?dUNod0dnaW9ld0FqbGpRdFh2NHA3NGkwQngrWG1sTGlLMklQWlQ4S3Y3RGpo?=
 =?utf-8?B?K280Y3l3Y2lNQU9HNUNuVVFpNFRjenNhVGpWLzZRTEFDM2VkaEh3U05nS0RI?=
 =?utf-8?B?VDU5endnaXNlUHFmK2xrMldBUEIyZE9JdERHdENQekRIcFhsM1hIdnZxU1hi?=
 =?utf-8?B?TCtwdUE1RE5OVzFMN3FuVndMNFNKN1piNkJiVTVoWExpUkFvTE0rNldWd29M?=
 =?utf-8?B?d0tKY2dueS9abjZSaVh4d3hieFYrQkFFNGcvTVRXVGhlL3o0UllRaE43L1dx?=
 =?utf-8?B?TVJYU3pzc250K3N5UmlUbGFSNzhhcTF4N2UzYzN1M3kvOEhZY2liQSs0VTVW?=
 =?utf-8?B?S2VpYUUzbzEvemRNT2o0T0Y3eTRpQzZNZHFDVjkwZlY0bVVESVlnTVNSMmF0?=
 =?utf-8?B?NmtYdnk2NFljdngxa0FvV0UrNGJlK1dIT3BVdGZsRjh1ZmZXdWFmTGdwbEpq?=
 =?utf-8?B?S1R0aUJxbHA4ckxGdTlJeDZnQmFUcUdvWU4yUGkwYlkvVjliR1FDNVVpZmcv?=
 =?utf-8?B?ODZ4cHBQd1NFY1FMUndTSUR0UERyd0k0Mmd4aDNHbGNtMmxKamI1WlVVN05i?=
 =?utf-8?B?WXhsMEtYVmczUHVWTWgvSGViTUxLMjJOQmtnSXJvank0Uy9LckJzdnZTWG83?=
 =?utf-8?B?V3BRVjhyT0MyMyt2Tkd5TXZackx0bjJ1UWhydUt2MVVnNkt2QU54eHlyVmo2?=
 =?utf-8?B?VDJQdWlPRGJEa1pLbzJPUldHa1hwaXd2SVYrS0gxV25MaDNhR05KRWR6U2Vs?=
 =?utf-8?B?a0JGdkRna0JRMmRvaDJOT0xPekZsL3JXVk9XakZNUllrbytqbHkzTk1HcHcx?=
 =?utf-8?B?S2trZVFIQ1hvYVVMTkxLUVp4YzR3M3ZWNWtUeVp2MTRvbTYwV3V6aFppMGFz?=
 =?utf-8?B?a2w4SlpFVUQvUDNMUThRVVVXR0NCZ2s2dHJHamVNdWFqSVcyaFRmOHZ1MmVX?=
 =?utf-8?B?clZONXpuRmtXMW84Yk81OUFFN3ZqWnd6VHZ2dDNkU213VVViRHh0czJ0UE04?=
 =?utf-8?B?bC84aFRENkpXR1p4NXhRMVBBZVE0Q0tDaENWUTNQQ3Z6L2RGTlVIMzc0Z041?=
 =?utf-8?B?ZmlIc1BURmMzckVtUm9NWWdwY0hQd3NrZ21tcC8rTjJUbWN2eDJrRmthQkpw?=
 =?utf-8?B?SUR0VkNRVS9qZmgzUFNyQVpPTm4xdHdTRlB5dlVsMEZpa1prNlV3WXdZUlJk?=
 =?utf-8?B?Q0o4eXNjR1VOaEM5b0JSRnVRNC9rTUNWcWl5OHFFZXV1andGSW9WNlJ6ZHp6?=
 =?utf-8?Q?6rP6dkc5m521IpvlOppSTBW0T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P5SdgFMOgYnjafskoSBCbnfIgE12ialhleE99pTZ/BgH0Hwj5a+tiTbBNzgcFnoMaCy+Ifzx4UtuOdx8jI5JzXdKXYA0YlPMVaiNaPGOxTy/mCGLv7CVlaSoypYY+un39a4iXO/Cd5mxamEwrPL6V/qw+WxUAqrI9sEIg12qMR3tsXrlg1MpYM4faPrjPpA+eNroVqjPbQPeN6sRurUFsfqJAxYy0ongybdmE7+AngrRNDQAXtoq/1mGcJP9MEclsV1SR2Uz/TEIuhcjotP/ZUJ2GwI+A1qo60O65rsTAepUS+e2hQYfpbpOIrXd9+pfJGo+8Lvpc9jgoFYEnKBsVrirh/f+te5DYZBSjpCxeot2I87sk+6cauGnboIzWFvLgozgJd1N5Fei+1EabNBDU4nNi/YomGZPX1+Jnb+tpiAGh6lPq9WnqpXW7sRlx2C4ZEXyIa3eVbtjOJkLstlWKjtIb+E286j7+AuXPiZ48dfPW89S3ZsDAHkhXRYwXgD3FwtV5FJqO/UWT32yDIQP3L/he2z6yMdz1i76QQO94OmVhPtseAHi9iSbvuiUkPte8S5RLBGmjn0x8ndJqukjlBlA9m669S21CC44OmGt43R/4z6DzhNg9b3hBDXRqYTEBQLYS1VSueVVxrK6M7Jh7n/Uvse12k/uu/8GrD9Wjx8Ttuhodm59lP/yrcM9bMmJIz07XwUnkY4GO+6miLReM5dv69DLRslGq7a8boTiLezpbU5J1UN25iZy01xYL/upYan70353sbOvTK1ZqfLeSsfdmkrgpNmwfh4a9nl/JbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38f2303-9821-480b-34a5-08dba2289548
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:25:39.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf8fCKiigwmb+4lWL+GmNNXw32xl50xpI/DYDHdR19RqpKHFfBVGMf0u6LQCxTJ3QYvbXjDDqBwTaWxrIvwRyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210086
X-Proofpoint-ORIG-GUID: hlrzuPD3XTMOd0hZ-f_xiY2EIyUIDMEL
X-Proofpoint-GUID: hlrzuPD3XTMOd0hZ-f_xiY2EIyUIDMEL
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
