Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB20569E1C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 14:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjBUN5Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 08:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjBUN5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 08:57:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1113298D5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 05:57:22 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDkdBf013874;
        Tue, 21 Feb 2023 13:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=c4an24bQCotXdiCmLzuP2/K4+Yxkm976xbAQ3nrem7M=;
 b=iiXSoDrz0xcpHB5bm1dPLwaiC57dv2fWbUAMWhi1Lo7+0e4nyCZDZ/KjHY16AJHP80RD
 lxEujFDMM+GuatK4Whjps+jRA6SxqnIn0J0Ohy8cPOPfewZUoM/+p4oMQaJU4kTtdeMB
 /KCWlw28PVAvaRYRB8KdQ8YE/NKyCab5RL6wTVH9vOykfO8nWfVR0LyH+tH4ZH2fawoE
 6CbPE7/Yn7MOBEApO+5gZUz/32MsXMM4O8tUCb3xrCo0J8fOglWY59Yry6/htMBiVHph
 5eieGdOwNGzCfoeKufvmEYGIiAyvHLcFsJDfq8VlGj/Y/K21CFi0PdAiSKkzkyB29owf Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbn60c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 13:57:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LD0eeV023252;
        Tue, 21 Feb 2023 13:57:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn455ax4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 13:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5HVnCy+lSwLvuFW5Dd3UR+4Q6xpB81vUm81fQqf7SF/VHL6y5XWPkVEIDptpZacD6vxYZHHl2e2toE8Ma1rXXkGPk5KppL/Ko5uSy4tdRQKCTaKAjp9hgcXzjBOqYW0Zj5zlJuoE7wNWj62Kh5dyvg7Q0LC0MSVKH/ba2WoLZlpfnIW+INbb6LQC/ZagCQlsZFtmHOFVdETKwIA81DLXRxN3SdzsTrgqrtj5siHFFMUJnQ7+JNp1DVKF1puq9hhPezLiEpxUZy3JyMR2Aggs5PZY42lRXouo/ZkmQUdGJbVAyenHehdrx22yTmtOn50utloE9+zlDbVW9a91fwLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4an24bQCotXdiCmLzuP2/K4+Yxkm976xbAQ3nrem7M=;
 b=BUw1+5n7zAqsNb914JFOSXwnrMHed0bOskps3x2eOdekwJrBm0BRqVanqbMvHBvjPegDfbAJv7AofTHd5syEST8eOx0HL8Je97yeVL2qYGbhn7nsThrRtRtJvv5l5cZ8j3GW2QXwC4QDZnKFcgFvYt/o5MTiu0ePzXV4PoVvvku0h6OwtIr+BvJu2Kvzly8EDQ/aK7e4wqHG27fvV/BXrn4J53ivVzd4CHiqtOUXK8fRlXV7mrxXdrqDg6XD83VijPHz2luygifxdHGgmRu1sfap/m2yyUvw1UEJN72RGUNnWqefzRpXRe2XmOyP6q4lH7thdp5zvuDi82Xkxl5Yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4an24bQCotXdiCmLzuP2/K4+Yxkm976xbAQ3nrem7M=;
 b=B/U+/wsjLvmzLJOpSjR6dTg9BPR2QImBWMck2APyy26gZYE6CpgqDDp4GgKKTVk6T0XMZ2vWYXk8OSscqm/sQJvgcrrBQeqxBARv2eCNjsHYIST/hkuPHfM5aqoWUARF4BaHsu4cYfs+fWrCtf8/ig+yVUpcMjnzOkmSPa5ieog=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB7062.namprd10.prod.outlook.com (2603:10b6:510:283::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 13:57:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Tue, 21 Feb 2023
 13:57:19 +0000
Message-ID: <b92f9adf-111e-0640-849a-8d85b2a171c8@oracle.com>
Date:   Tue, 21 Feb 2023 21:57:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: reflow calc_bio_boundaries
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbb4325-3076-4dec-24bc-08db14138bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50UoOn2CoycDhOwVEoNLizK0o5R4zJRyijTx+fita+IqWUV/u1Oa/SFmCC9ifWO/fFchLWIN2X4ss2Y4UDbp+BAwuS5R8oda0pJsupjevb1eQAH2TjE1hj2rYaMTERl6vLbAGB36a5N6eFBWieBI1dh1MBLCpPYvlw5U5k+ubTARUOxA76B9bFUahDr9Z/tX3RvrxJ7MX9DMfE+zkWQFeXVNhC+HdujqDT3LMrc4Byc7TAS/Tx4Uxi4BnXV4ovlsp76duvKFbqU58K1lMdYP1Ncwgi3veI0QcFBmzRwmaor6IXV+mPxhaM4Wto86OXoK0nXaFInvgN5qEJQQY1ofjY+nFxPfgJMuoCJ2cqWGW18469OSTfxsKUlhvBTZIduWo15x8RIVtrifcC8Z+2pkwSc9mvk59xUBKfeedWCRq/WXF/VQx+WRfpWfZHw3RDkTZpj1uSmFYgAtTMxMdK+T+kUN4r9X8QzCDqwNgfGf2YN2c7dR6/kdWOZvWxDxoqA2dTIy6GVam1t19vuYcGZzKqx41fWuc7qq6lvR5/BSrGbQtd2kQ3cgXR0sVXgUMtc1Rm4yXV83JxTTyfvg0Btng5aSK5PI2ehl6G1TCZbteKT3eQ0nF00lzbFCs9j4aL9efQ3lVJt0dgZVuF41ozEB2ZaTdYedPeCmNnToiutiMGycJb+6kMBGPl/e6pe19fB9k4myOuPT2/luCUmCENtkKNZGnXnPEXJkuW0J/X9pj14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(83380400001)(31686004)(66556008)(26005)(8676002)(66946007)(478600001)(316002)(66476007)(6506007)(6666004)(186003)(6512007)(36756003)(86362001)(38100700002)(31696002)(6486002)(2906002)(41300700001)(53546011)(8936002)(5660300002)(44832011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtHdTNXTThHci9QMHhhSlJTSFVGK0dUUzU5QkxoRWRrTWpuS2UrTkZ6OGk3?=
 =?utf-8?B?dTR0VFh3S1pSTGFKUGJkbzFtUEdJRlJjUm1DOGJoaG5LMmRKTlZEaFd0MmlG?=
 =?utf-8?B?TExqM2IzQ24yYm5TVm8vRHA0Y2xXanMwUVNuSEI5VkN2S3YxNXhWZjFVMUVo?=
 =?utf-8?B?MlZKSmNEb1k1b0w3OTNtU3U4bU8zT1BXQUZBNStqaHJjSG9Vb2hrajAzQ0dF?=
 =?utf-8?B?M2d4aVJTanAzSzQxOTNpRE1NTjkzWFloeTBIN2cyZy9lU2pWM0dtWHBLY1Zj?=
 =?utf-8?B?OUVvTU1WVlpKc0F2a1BtcmY5OUlldTBPcmRZU3B3YUxCWXNQYW00cEJvQ01P?=
 =?utf-8?B?M0k4cVBlT2txcXU2WlFpYWxvKzlyR0loRmw1dDRYTlk4M3pOYkxRRDFWRHhZ?=
 =?utf-8?B?cnE3V0k5QVZneVlpN25ndjJzaEZsK2l1TlhaN2krMTMyeS9FZEtDT3Q1Zzh5?=
 =?utf-8?B?Q2c3UTdwMnpmOHU0aDBZTGQ2Vy9ybmZBZjM5NFVPRlYvRkRwWGVNR1NwUTha?=
 =?utf-8?B?RjhQSnQrUmtmOUNhOWRIbm5oOVZlb2ZRQ1hRTXNlM283cWNOc3NyY1hJL25a?=
 =?utf-8?B?U252YjBVYTFXaVcrYzZiQzliVzBBZVNqV2JSdDRua1Q4SGkvNDYrYVNjQjFY?=
 =?utf-8?B?U1JCQkhWbjVUVitBZEhjaE1YelVsSS9WQ3RvOWx1a0NnNWw2MDZSVjM5aytj?=
 =?utf-8?B?K0pIZ2pRYkhidmE5OVFuYm11TVpCZ3huaHRyTk94YkphaE1kanFTT2VmdkZR?=
 =?utf-8?B?SVJiYWFXTTdLWEFqUlY5U0JFNndTU2pIR3dtQkd1ekJzbVNGaG1KU0JvTTd2?=
 =?utf-8?B?Y1AwOXA1YVFSUXEwR3NFZTIyRUpjeksxTzRGNzZZVTY0b1QxTGVSYnQvOFox?=
 =?utf-8?B?U2Zkd2ZNMjhCcHU2bG9DTktOM2lReGhMdVphN1JicmhSM2FyMFQ3N3pHMTJS?=
 =?utf-8?B?TkNVMFl5dVdyeUhkSEZ2aWRjb1UyaFU5SzJzR1o5dW5WMTMvUUV2eUZId3RP?=
 =?utf-8?B?ejFZUy9MRC9jWU9lS05ZMWFuU1NsNjN5UUl5NkIyaXpxQVRYZVdjbGordmNL?=
 =?utf-8?B?eGtuVm1pVG5pRkpKM05PL3dZdlIvYW40NmhYYXNnSGlMVTBEb2tRWlQ0Nk1U?=
 =?utf-8?B?QUJEMWh6SHFzd0RucXdyQzdITWpISHNEc1ZNRzBSY3hDbzdVRnB4VmZLV2Ft?=
 =?utf-8?B?V3EvVU9uRG9aUFRoZXBPdGNVdGhyQnV5S1d3YUdmbWNhenlCYjdCb2YwamNY?=
 =?utf-8?B?cW1EbUVDVmVNS2VmcXA5dzVoYThMaCt1R2pCdnpabzluNXRteDJFWUh2QTlL?=
 =?utf-8?B?bkI0c2RORVJsMFAwSERVWlVhbHA3MHM0akZvbFZrMFlndXdRSXhSQ293dVJH?=
 =?utf-8?B?eUl5MVV4dnZZMHhka2c1NDh2TU0zWHVWdzByb0dVVzJ2dHY0UCtzU2ZvR2hu?=
 =?utf-8?B?ejVsTVNQTUkxdHZBd1ZjM3o4NXd1QlRZMGw4RFlCT3VUOFJ5Vk1LVW1WZlRl?=
 =?utf-8?B?SHQzVFIxOGhacmRMNmoyaFBiWWlFMWh1UTB2RTFDRC9SMFc5b2lGMlh2Q1NE?=
 =?utf-8?B?WklvSktMdlJRU3poVXhxbkttQVlmbTJqRXh3Zit1d0dSSnBnUGIzQm9JbnN4?=
 =?utf-8?B?TTVuVVAvam1iaW9VZzhoYXpBdi9GRUpHSFdPY0krTTZVdE1VdXJ4SHpoUzNZ?=
 =?utf-8?B?ZTNUTklTeDlMekw5MkxIYUFvRCsxZHBQbkZnR2xlaDZSdndPa2x6RmxlK0hz?=
 =?utf-8?B?VHlzOWlGQjhiZXJYemhWOEVJSGwxVURTSVR5eXJJYUMyNGh6Y1FmNkVwRk9N?=
 =?utf-8?B?N2JtODZTV0MvV0xyR29RSndhMDduOW42aS9iRkZ5eXdYZ1MzUnh2cE1wekJ3?=
 =?utf-8?B?YWhtODJteWJsVVh4djltL0xDdzFJdUxTV0JJcURBa3JiT2xJMi9LZkZoT3Y1?=
 =?utf-8?B?SlV5aC9KL2J4UTh0REttQ3cyNStBcmdWTHlDSktmZlowcUdwRkJYRzFIdndH?=
 =?utf-8?B?SDdBS01nZE8wc3JtMEkwTEJhWDIyVE8zRUNnOHJ5RzZ0ZDllV0FSRmpXblF0?=
 =?utf-8?B?Z2hxVjduUjF2ZEFpU2xaaW1yTmUvZTVKemZFY0lONmlVVlBWUEpKUWhIQ09R?=
 =?utf-8?Q?RFCVB/e4wjv4R2B8EwovjZ9iU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RBx1/40SseCaDHOGWG53kWUBVMV6PeAQFutZP3rjvIFgiOUGitpdui79+DhWnmf9N8J+3T0wQNQNwtLMue4K3JmhOldI5BVBBABWH0ALyWgr309S2EuClIVM6RBguFs//yBak8ZZhBxTUNAufvBL8RaaI+MTGnKAEvH2m2kXmMwibWJN8o1s4TT7JejstzeGWY+tipzOIWXGR6A8GFz6c2ItFGRr6l9WNBNPTqyrRKK5J2L9fh429G27kQSXKAvorygWypvuSn1PZRHKdmXEx9j+JQjxmZtC8l4ujIxJ8KgzwdJve4cdmaaWxEwLnKKh69j9tuyoNuCKimu1h56grd86kTZ7qw2BPW5Bj4PE5TWQYTXH+OlCbut0ExgWVsa9L2vFS0qzTXDIS1eQ5K35AUWont9nwu5TPO0BS1AGZyvLfBfeHGeiDfCOBS4vjjoj29Y5RsZtGfNHL+yjzY7XIRPurSRtqL+GFlKAra0OosFTWPCgT1jUQrza7CdP80wh3bqeA2TrR/DgrVKWtchE+BXXUUZTtIpR5LDrsTSCSjgwHm9fzGE+wG0XhsaH7LUYXyDttR9Gcx+awc+s79fnPsEJaJFWVGvV6DSa6eIJ7MyPpI5mCOwPWToBP9upQvRZz/d6aEEGDaJgQMR3H5CzMPWihZhATcV9/xWSg4qdPmtnSwu7tIM70k8MxJFMFkJwfQmPzabRW/Y3W60RU1Wxk7RyWc7YB6lGSdWRTRm6GsmY9ktLKVieZvj20EKYJ5d2WLF7PGjDEbdh2W/sR9grQiYMW1mvP/32DukZyDhgahA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbb4325-3076-4dec-24bc-08db14138bf7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 13:57:19.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY2TeeCsKi99ywQXGw/HT55PVBAP6a92dy4IRPf/u6Ifg4l8Zeil+G/rNUaYFuXZ55GGQv/xI3eaFijpaXr0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210118
X-Proofpoint-GUID: dfqgKZeO7Zujac2Tav9VktEApYtLvUCy
X-Proofpoint-ORIG-GUID: dfqgKZeO7Zujac2Tav9VktEApYtLvUCy
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/21/23 21:25, Johannes Thumshirn wrote:
> calc_bio_boundaries() is only used for guaranteeing the one bio equals to one
> ordered extent rule for uncompressed Zone Append bios.
> 
> Re-flow the function to exit early in case we're not operating on an
> uncompressed Zone Append and then calculate the boundary.
> 
> This imposes no functional changes but improves readability.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/extent_io.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c25fa74d7615..c0442f2ed150 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -956,19 +956,22 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>   	 * Compressed bios aren't submitted directly, so it doesn't apply to
>   	 * them.
>   	 */
> -	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
> -	    btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio))) {
> -		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
> -		if (ordered) {
> -			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,

> +	bio_ctrl->len_to_oe_boundary = U32_MAX;

Should bio_ctrl->len_to_oe_boundary be set here?
It appears to be unused until its value is overwritten a
few lines later.

> +
> +	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> +		return;
> +
> +	if (!btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio)))
> +		return;
> +
> +	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
> +	if (!ordered)
> +		return;
> +

> +	bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
>   					ordered->file_offset +
>   					ordered->disk_num_bytes - file_offset);


Here.

Thanks, Anand

> -			btrfs_put_ordered_extent(ordered);
> -			return;
> -		}
> -	}
> -
> -	bio_ctrl->len_to_oe_boundary = U32_MAX;
> +	btrfs_put_ordered_extent(ordered);
>   }
>   
>   static void alloc_new_bio(struct btrfs_inode *inode,

