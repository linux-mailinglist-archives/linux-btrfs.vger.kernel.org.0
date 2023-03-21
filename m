Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E3A6C30FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCULzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCULz1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:55:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6220EF74C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:55:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiF6j012408;
        Tue, 21 Mar 2023 11:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Wu1bsYrbEuj6KMmqaXHCOC0cNt0jKK1/vQuqWHkEABM=;
 b=oVzsu5jtoY/GwxTvoUPo1iYf1YZdnnIy8qeAbyFXrAWy90G7a7qfsyFjpRoqmrR+WjN+
 u6F4zQLfzEMD69abx7/FnVUJZDFjAKV3D1J4TTO6BWQHZ5o3cL3bDXmCcLejKaKxsCRJ
 FEmK9S0Q/XNhH1oqyv1ynEIL/JFPyFNZjd2A1cFcLZLe0RXWoQ0H5Fa0LU6urt4Md7Io
 +pkyVNepVGXhassU5tIwvbaQVCgKrE7Ttg4voVu6241lT5UIb09kZlyUCLTKm2CG57dT
 bKzXyCrKWi3uPImHMOaIKxm8km7N8eyEdL3EOBGUQjzccDpXlqYeiey1qkHUtPHJhpaO dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt5ygj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:54:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LBCgch011027;
        Tue, 21 Mar 2023 11:54:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3peqjnnmx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 11:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhkLxQmrM8+s+sBXkYXF6BhwT0y/lk3Kgh1jJ+oyF4SR8ldDCodL0d8ycni+5ZvM1OR1AdpdpETEH4r1gHhQh06N1mEUz1XBSbJHOkeEwp1VLRKeFuf26Aj20mh4lnGv78wwewlKyTM1hjQVaI1ZZt/o6KkSf5cI1ERM/A4hPFDvJZ+h+HP+CudS3gINiaPB1aPUdsabuz9uSpaV1oC/ctkGAVCtnFJAXHn4CZO2B19Co9s90YKvX7SacNNc62azLhtVEksw6nuk7IibYou00DdaogvMUleCcnhOsU4PJTajkt/jISfGmKCSIWPX5H9xUBxP66OpKRgfWvj0mwbJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu1bsYrbEuj6KMmqaXHCOC0cNt0jKK1/vQuqWHkEABM=;
 b=iNHlqkfVxiLIv4RP9MJsoR6i+B6sKN7m2F7Cp2LS1U7saED9//Lr9rOngRhlbjU5FAIcfTPxO4xGmtJlwfHIStvTNnFRsM7vghg1veLxvs0CcKrpudaADKQfE8/Z0basPnt+SryGJYjqHCeM1vX2KK+eZAVd3FoRlE/Le4POi3JplfXpefK7rg6RlVKb2WmK9lW5EqYXLuKCGZ7Q2DedtIhru+Q8BJeJSMRCkqh1g1jR+bDSIK5k8ahC56EVx17SQFuwzpZkNRwP74mQZZLIK5QJAgmSdqplofJpDm6WprFK54e6nLGI2lwY5EjgiTDAzdHhj53b7WWSqPGcicER+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu1bsYrbEuj6KMmqaXHCOC0cNt0jKK1/vQuqWHkEABM=;
 b=DnzM/eO+je6XPnZJ6OJum8HiUGyeiRsxD+wl2XtNe3n7NoY2PKlIFbr3Y+LYcH+SvvHGmcOgTe57EYI6FWkW6W6Xx+9E3meKD2HYqh9Z7NKYvAr/hjcwKvQvCMS4oLzIfbq6OiqVrKSLSG+vXGd2GydROiuuoJxOfO/rJNt7OsM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:54:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:54:54 +0000
Message-ID: <fdb7939d-250a-1b5b-ff0b-64b7a48c1f61@oracle.com>
Date:   Tue, 21 Mar 2023 19:54:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 03/24] btrfs: remove check for NULL block reserve at
 btrfs_block_rsv_check()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <8a7ecbeffe854a442aacb7c5c0c97b9f44528ebe.1679326430.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8a7ecbeffe854a442aacb7c5c0c97b9f44528ebe.1679326430.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c29f955-efb5-427e-82e8-08db2a0315f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwAHysp+KzIVfxcS62hFc/ncaXQ/KGo6/iUJeZc/WroJUUz8TNhzc3922xlehWAdmWg9n2axJmIUz8mqSKE38VOS1DxVtfFuEfe2waKvUGOK4ceHFLl54p7hWOuwyvcno5ZCLaXsUSCqyQ5JksDXeK26E9bxbTTNLt0MnVmK2tXvY9zMYCk3BA/kDYOGiYZz+nH/c3ICg9+pcM3QJNTb1kJlKUbGDdu9yssZrIChLgW7zzI1G+c0ipvYig8RlysVyI9bAUljKszkav7qoCLefpRa4UFQUVeBYEhaFzP3ODqrvw8FewxAU+zKneiAA0R5CP3nfbH2NqwL2Fq/jzQ6nTjDjXMK5YD80ZachHSpTt3cmblA1i69n9P3C/8b7+GKA/sOh7yFIyIRQ4dhb4JE+tk3rM+8niqhQTlkhIBU1XHpRo8rK8OmD6ai4ZQv943c4XsBjWk1I512W1fISu8UU9nfjDyRyD3lypqKA1dWH9NmNsLuZWziQQiAvRve4HEw4ysLfbVaKvgaaMkPE7T38AEm3TMD/n8YTflK6uOHxAGbV2g91bEE+DMHa4RMP+4fTwpqQq/JL2KrQiB6Tx7DFX4VyTkUWAedWlvbqF5q2p1pip1gvLzqH6D/jABMrLsAWTDwLyRgtmDKNV/GPCHn25jJjIsZKM6VKsLU9wylXmX7yXwAMIXY3tdripyKHaybk1Lr597JPgh5Ga8jZmwah+/rQ6j4pXxsCQHKH/HJiY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199018)(41300700001)(31686004)(2906002)(8936002)(8676002)(66476007)(66556008)(66946007)(44832011)(5660300002)(86362001)(316002)(31696002)(6486002)(478600001)(36756003)(6666004)(6512007)(26005)(53546011)(6506007)(186003)(83380400001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODV1L3VFL3FZRHU0RVFyL3k2UnVmY3RJSG1ZWUdCZ3REZVF5RW1hM1czc1ZO?=
 =?utf-8?B?eWR6bEFSODk3Z3dlVXZmaXMrQ0g0dDFqQUpuTkRLVXFyL2E0eXdZWm5HdHVI?=
 =?utf-8?B?K3VKTEI2WkZHaGY2SmJ4L2dWVjZoK0FGU1VONXVaSURBc3BHOWtjSEVBOUh2?=
 =?utf-8?B?Vm9JUVpkT3JsRDVQRldaK01iVlA1RmtMNU1lNmFkajh5R2ZMdWNNOE1XRlRr?=
 =?utf-8?B?cndxWG5tUU13d3krOVRZL29rbXRqZDh0R3MwaWQ2ZzkvVlBLSFpNR3JrQ25B?=
 =?utf-8?B?ZEwxV3plYlNHM2dmZGQ5UFlvMHlIUUJvRGhhdUN4dkpxdlpkRWZCcXZBVW9M?=
 =?utf-8?B?MUtXVGMyTkx1ZzFBZUFyaEFxSzZ6NFE1UGdJeC93b25oaUg1bE4yVVZCTTJx?=
 =?utf-8?B?bkZLQ3ZOZ3RxaVBHU3FXMWxjN0R1VmQ2dmNpTmh3TEhHemp5VVAramxOSW1o?=
 =?utf-8?B?TWVoMm1VNWFETEFYY3FWcVJSQk43aXdNUWxGSWtiR2Z4LzBLeDlYSGlReFk5?=
 =?utf-8?B?QXE3bGltbnJaL2RUUkJKSXBEY2xrNkR1eTFxb3FSbjlrd2MwOExlTXFrdlRB?=
 =?utf-8?B?SEhzTWs5azBlOFAyczVybWNycHdXYkV3N0tHWEpiazZ3emV0VjZGK2VOOGpU?=
 =?utf-8?B?d2JMM1FwVHYyOWptcEFhQnNyNlpRNTZvUUV0NG5YdXdhc0VjaVdubTVpMEJV?=
 =?utf-8?B?QTVZWnNSU0JKL29hYWpRSmFiVG12TWRpSTlFaUVkU3JXclBjWU9UaVVyMUpJ?=
 =?utf-8?B?T1BydDkrZzlDcndiaTAzb3U4QkxFY2k5bmFFZ1NIak41Qm51dzFZVzBOYngv?=
 =?utf-8?B?YUpjckJIcFBXMjhMUjB5REltVWg2dHJQN3J1ckxsdFNKOEx2ek9aMXd5bDBk?=
 =?utf-8?B?MjcvZ3JxY2x1VEhCS1U1RDNrK1dtR3FxMEVqTG9SdWlTVTN1Q2M4V2p3OU5L?=
 =?utf-8?B?NjJia3JpVGFsVXJsUDh4ZlJOZURGSDErdTY5eE5yK3g2THpPNVZpVllZTUo3?=
 =?utf-8?B?WFhoTER1Q08xdCthS05xb3BVTkFGczNZblEvdHpBbDR3RXgvV05lTFNlL1M1?=
 =?utf-8?B?djBhQnhpRFJMM3FsMllHOHAxTlNuRm5UTDRtS2tpMlBEV2dZcUt6L1ZXZ3p0?=
 =?utf-8?B?RVFrcnFSSWZPTU1DL3B3K3N0WHJWV1dyMzRXcThLa0JIdFUweGhZOE1vODdZ?=
 =?utf-8?B?Z3ZRdzlpTzhTcEpIQ3V2L0ZkT0tZZlc0WGEwYmYxVmVRaERKc25CQm9YSHZK?=
 =?utf-8?B?YnFVeThUZldUbkNCUnNsV1hheTVtR3ZCOHF5VU9OYUpYSDJZTlpUcnhxUTdj?=
 =?utf-8?B?cWhBbjBMRWVOdFUrdjNTOVR1VWZTRytUYkxOWkwvMHJHQXpVK0Q5ajNVNFR1?=
 =?utf-8?B?azdnbFlNbkFLZHh0S3FEeGJwY291VUNSOFE4VzlnZzhYdm44eHZrNjQrNGg0?=
 =?utf-8?B?azJZU01nYUdyZXdjMTg5b21GSTRUcXVWclFISVdMUHV5QlMrMERPck1EbElP?=
 =?utf-8?B?MVJJK1VWS0hnYjROZUhxL0trVDUyeEthbjNtMlVFUW1DekVoYjVMU0JNZ2xu?=
 =?utf-8?B?dFJlOTVuSVpFZ3FmYmhLR1lSa0dxMExzb1VzZmc1NTdUcHltcGJ4eXM4QkQ0?=
 =?utf-8?B?OHlFNnZXdXc4UW55RHlQMXcyRytjdGEwbTAzTHExSFZlRW5GTDFmWWVuNG03?=
 =?utf-8?B?VHVNVTYwWjhCTGkwWGZWMDlla1RQYzNwdVh1V3RXWG05bm91SHhBWkFreGV6?=
 =?utf-8?B?ZFZmc3k2aTRDVlJzcDRDSzZ3bi95MDB0Z1p5Smk4bVhPcFd3c2h4TFlkMmlt?=
 =?utf-8?B?Q2RFTHVhaEtwNXdEL09Wb28xeEJqaEd3MU9ycktTc29EeG94VHU5MjVOeGN1?=
 =?utf-8?B?L2cvamFxM2l5MC9sOVRJYWdUbHdjTFo4cUVqcVpGbTZwZnhSeDg5aGFRNFRD?=
 =?utf-8?B?SkZvOTgyMHpOd2tFNlJUWW1PTU9SVTcvMGZLR1BoVzRMQU9sSXp0d3V4MWY5?=
 =?utf-8?B?UWxLVWVrUG1WWjhqSWFaYmdMNjA3Si9ZS256TVl3ZUhZSXdmQTVYU2VFSkFB?=
 =?utf-8?B?WGxqY3F1SC9FWDJCdVVpMGJnY1dVV2pZYjVFRVJEcDNNbVQ0dis1VFhsMlJm?=
 =?utf-8?Q?erPHuaschSZmluUCNWLmIZN7i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rxW22WD3klGXG1YV5L2W8x7EexS4HScNvlD4sdAlp0Fpy9/3BDmGo2K29OYLN8ydZ0BWSl5TnHUzsaqQYu4pCxwSbVAolms62UCOUJL4mafkZInbPd/SN0kbJuPb+Adc5uj9mrDBvAamPzF7P/AObDNquOH/NZasKhvGdcTzS8JzDbk+elvySOFWpRTi+a7AyGhbImS5p7Q7pfWzPtMlbr9VE9L+v2K1TKP8+b9N3ZmmAiibpFeGFAfVhr6v5NAqbgU/Mhz4JDynYZ6+Qk0cvmswzUdRo5a9ieeyFP4Qxs66xpOyS2Qge6P5T7UOsqoPCGHi9Pfko8OI5ZkooSmr11e0an+XPO/+XxK1N8X/E1Gve617OkVZvX7xusvP1V7itPSWebIAAIFiADpwGgWnkw9JzopQ3Fix2zFmSO0rqq/rrjdMNGUbAk/OIT/fkBbomuyY+5hL/Citn4AU7Ua9yi1IZ9M+68baT42wbLbDLHTfLFGJlb6NAriPUH9z3i8eYrCJHQEXqfeH+jtun4H/bTQWEMlkCvPrLMTXLr83Ra4i2qY6M0Trcvk0EL70QnF3DCxLD3bvjfNuVvHVigqGJM5dyEK+xjiu4GFP2jLwd3eCc/+7Pr5u5K2QgHNtD9XBmaXeemweLzBi3f4nYAfqVd/qAdL6Lo9FvtMGE7IDXGocRc5Sni0LD+Fk5YnT/lCUYWb5UhunwKGL7yeAC6KqzvKpvDOL5OD3F/nXh6lAFrdI49TV8/f97dCLNJDB6ROQAqXUUYkqLYcBEFLkMh1uJyCW7g91BXKM4AVwXPGQqlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c29f955-efb5-427e-82e8-08db2a0315f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:54:54.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoSqwJ+YlkWKpXW3nO1ZAyXpqau9uJBmExfD9/qFkkQydXkg8aeICNqJ8jJIMPv5FhhXAOqV0bzPFzv2IAeHEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210093
X-Proofpoint-GUID: p-07ykOmK7WWwxPxoXhjbpKWuPZ7Oxoj
X-Proofpoint-ORIG-GUID: p-07ykOmK7WWwxPxoXhjbpKWuPZ7Oxoj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/21/23 19:13, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The block reserve passed to btrfs_block_rsv_check() is never NULL, so
> remove the check. In case it can ever become NULL in the future, then
> we'll get a pretty obvious and clear NULL pointer dereference crash and
> stack trace.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/block-rsv.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 5367a14d44d2..364a3d11bf88 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -232,9 +232,6 @@ int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_percent)


I havn't checked the whole series. Is there a need for
btrfs_block_rsv_check() to return an integer? It seems that only
parent, should_end_transaction(), does not care about the error codes.
So return bool shall suffice.

Thanks, Anand


>   	u64 num_bytes = 0;
>   	int ret = -ENOSPC;
>   
> -	if (!block_rsv)
> -		return 0;
> -
>   	spin_lock(&block_rsv->lock);
>   	num_bytes = mult_perc(block_rsv->size, min_percent);
>   	if (block_rsv->reserved >= num_bytes)

