Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829D6CA089
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjC0Jx7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjC0Jx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 05:53:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42F14C3A
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 02:53:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R9nDQt011081
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=D6ZjvdMUcwA+RPZwvj7qu5+PfrttsT7GgR2nXGZh1HM=;
 b=dyzANK/AxI2wz1udOvJq1KnnDPiFhsuPNS8K8cco143m6oc7BmMz0ys9Iq4XR8eRvsGV
 MKPev212eVCyu16fftHGWdgGu2osbBM4XgFfj2e9Zp5tUH1abnF1b3CxWlpaZUG1hNan
 AVmZSUt3JxzlqIZhmWYn54Y8G2/6xNPEmZL54hKBVmdMlFzHaRuLcw1EWRKtHR+HgGze
 9HcZyJ+lazhQ7kAK5EUdw35pE6zB4B//b4nuk08Ixmrk4NB4t3HdG+e9EQWcRnVmCpnr
 VWOj7z6fwl2uTsc93wEnhSeuPdSPupGRYFXfSyN4KsdebIfLMQeq2mCI/iNQ2OUpZYl5 kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk8ug00fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:53:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R9bsZq008707
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:53:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdb0tc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 09:53:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkzihac+pI4696MPIwVY7kxd+o+zzQVvwn6FPFSey+nPZEvIo6s32fTlbZ+tt/YMfsextRDMtlzEort0hFNX5AgZr0QNF4UfE6XxkVKKk+XuZscrd/mYPUDm+wmDZkr33/JXIs2ucHjhaWyYJdHjk94ifKOpeZc5Lnr39QXtLHxZkLhuc8bnc6lBLVsB0kz8LkTa1Bv1AaL6uPrAV3qDybI16946GelNtgslzicLITSqxr+ZCpWh1xOjZwRG1OQ6lkVTHKkc2yAUdWgYqgV1RTuTYbFvFj63x4/PDLAYud4kFWfqnBbqrqmm7W3SsJexTpdpFVHw9HWWxHMaHfNj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6ZjvdMUcwA+RPZwvj7qu5+PfrttsT7GgR2nXGZh1HM=;
 b=COC+o/HWMDfzaj1NB4Y2RQfDCKPmdfwC8GsbZUqaqqPN8Q6axSXDZP53yYknvmubiujg0SPzaTBPLHia9rY7hZhSlxcKIUg9XMGTiCzHt3zl9YvuvSKb0CT1avVxmrSljVhe31ayL4Jl+KB+kBVjkLEPQAG5Ujv2KB+Wo0we1w4JX8squ6v50SxwWc+3xkjoNO/vVU46eVzhpvlfKG0OGm0pAjI8Eyji5PrCStS8d6PRhXwM+X0RtG9iMh4Fmq/ZRS5TXjjn0025ywKSpPdPhWGkxacHm/qsheW6cXfJjcdsjePCcSLgnl8p0JuXmRpPXlW8pfaBj9xtxCo6grenig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6ZjvdMUcwA+RPZwvj7qu5+PfrttsT7GgR2nXGZh1HM=;
 b=Ud3NZTu6YNNTCfe3C9exfM9Y74iZ8y1OTN8jubjx+gSz6fMsnhKODeaXeO8TbtSfPVFRFEHV1njolhlc+0QFFpSJkdIQjMVqnmuwZ8RYgdinwTsvssCVPeynASlKD/JjxWNFvx22RBZ90wNonXKdvjZPjyXsWaNFJEnxvh9JF4s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6452.namprd10.prod.outlook.com (2603:10b6:806:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 09:53:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 09:53:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/4] btrfs: optimize disks flush code 
Date:   Mon, 27 Mar 2023 17:53:06 +0800
Message-Id: <cover.1679910087.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0173.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: d8aadba9-a00c-4723-346f-08db2ea92c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYeljTtIpSl1qq4/2QDxqQQrW2jwLRciicU6fxqeovJK0S7PPgwr+KZhPKRBlKttoElMKoMfHsE61RX+tSF7wARIFPxFGpPwpt8rz1En2xZL+Y3VhGj42xNx8c8eyf0uE6NGHh8o3cjogtNeDKFAFq00FmTkatRZFQITMM/HsfdWKMsYYZ5ZaH3xlrSc1EGm0D8BkcKLt1loz3AzaY3buCVq+2l3QlzF6lCIesDFguYEmnwV0pYx4atbW95xkAXNm8Bx3NXMN/6RoreFNnZeSpb/MzDfoByxu3ViMq3JWeFIX8l6AdnxX10/lZU6kYRqDlv02ddTC1JJ7xVp92KmPMwZMUPoSvSp/OBRM04vXLshAlky7zB//hL02qsyJNLgKAjRGGkFDVD2XfYvDkghge14Mph0wd1b5AyX2S0biMYRgC4pvTIeR6oafQIuyyj+grtqaditLhTP/oaZ89j5hvMAp6F6/7E3al2JeIm6vz3KBh9n8LHYS6fWQNdV0In/DKe/SmKFrlWbYT71eKkf0V8kasCD1UVLivheWfsbK35l1RHTVfsf7w6odsP87SIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(2616005)(83380400001)(66476007)(2906002)(4326008)(6916009)(8676002)(66946007)(66556008)(6486002)(478600001)(6512007)(4743002)(186003)(6506007)(316002)(107886003)(6666004)(4744005)(44832011)(86362001)(36756003)(41300700001)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B4+M5jhIk0d6cznj6NIc1pa9MNjIL7lchz49l6UmHLMqE7tmTWagj8wJwegj?=
 =?us-ascii?Q?IDZvMRzo5G1AhIX8XbxRJwrppPjt+ZvVB4kmDwDfNFsTS9LACswO+dtu2Ilb?=
 =?us-ascii?Q?m9UUuBXSzIn+OhaZTXKNF6U/rtijGO9JJeQg8VAfvObZ7JqButAOw5Nlk2Ze?=
 =?us-ascii?Q?0EGZ4yq9bTKXgjEmGR8JYQLYkl8xrfnvq/kr4d8BNQEuglxarLIpMCTsBXW4?=
 =?us-ascii?Q?aO7Nq017FeMOEV0zcAMkBh20I7ROPCAvloRdLKIgTIPugCYSyg19ZiKOnljE?=
 =?us-ascii?Q?i2ka4+Xeyx3gbUfnoMxb6w5WviCF9olSCuzoyAcd91HU5/Y/ZfFo2Uwry3qm?=
 =?us-ascii?Q?k2DAgF15hF4IC/tZKPiZDz8fp2kJ+rxJwdXHAlEoMBeBtefs/cw+4EO01X1n?=
 =?us-ascii?Q?lTt4I5ho9DE/u2GGWocWYIRAdGaFNZC6PKRAZzUdfj6jE63aC2pLtGE3GDv3?=
 =?us-ascii?Q?SinywEi3xzc5Eb7y+N+R1SYuVRq1S4ibc+zNHnz7iTjO/TSPrJAJukXlMEtM?=
 =?us-ascii?Q?sZZ/8oJ8F/SfKFMb383b0FdwYDmrtETLLmeGOQnlscXj+DkTyIUsa5ce0tJC?=
 =?us-ascii?Q?Nl1uXgJ9gtSQO1gGlQoK1u1MWFxa/W3Lfguhh3NdtATVZeq53Je5PCNtzIV7?=
 =?us-ascii?Q?MHOTIHkrvEN+FVf8hmanFxyg2eB/o1jAwtzd1OzWaR/Dpnj53q9zceHqIZ9B?=
 =?us-ascii?Q?3ng2qxCL0f5PlCntkKrk6cbM/L/IDTLJ73fKngZsRVYr0Brz+vczHFRyxztK?=
 =?us-ascii?Q?PqvMuWiNjRJ8EI9V439j9Rs0oRKtz9DcxGP9YN2+Y7yNY1IHTmyVWr51yRTp?=
 =?us-ascii?Q?YY6T3LgV1zsRm5+q7pHyWhGyAdHHgKuz/biwLY70VE8WUseXube2kEXBcpkv?=
 =?us-ascii?Q?mFZDRLEAH5xQH7xmo1G/kTGmDYs2VABZ2yztE5E+veU0IAsCgAk8ePTNdqIX?=
 =?us-ascii?Q?DjZZyXU4y72hKTt49CKAlRDExzR+/FJKWcah9DBWB0EZWZ1A3o+Y3GyF9Qwg?=
 =?us-ascii?Q?iaXtLv1KPcYGyureUomu8WvpCbfRUKm/jcN9ky6T0kkV/Kj2dEJWI5GPiqrD?=
 =?us-ascii?Q?znmMi4YgwJf7BNRCx3py5ZEMWeynl6/G3KsRGHUpNQ4QYFGKInjid83R1Bo0?=
 =?us-ascii?Q?EOiLU6y4WVuouv0axETRh2cfCJSU9YWDYNrxIGEbOJcMoNfEljW5LzUiuTzh?=
 =?us-ascii?Q?hGMKOq8odD6KdzokXUhLRmUTU2dUP9AenL8GJXBiwOYIzoEujn1UtXZC5Hg9?=
 =?us-ascii?Q?37IOdYwarJKNPHp16MTj56XktjGcuwfN5bBQaXOTf6III8C5w72ehKSf5mq9?=
 =?us-ascii?Q?2EWJYbNEzUZaVJaszrZNNrQskGpn52sx2CGHH7fT1UxPwNaBAH+s0hTelJ4D?=
 =?us-ascii?Q?CT8osmLPU4WUGYfY1F95PTeZwV8EdDbESgOclqai9ZXiwsOVUcyT/hbOniJh?=
 =?us-ascii?Q?4+Z+xl+kg8eKAM0Vu9JlT8P4XqW0wqYPEMABiLGUAtTmg9hase/yCHHimMIe?=
 =?us-ascii?Q?/uNCPuneJo0Sdfk2axWjQc1hnKurV0UhuwW/I15OISMIjWvknv7odxOVJTha?=
 =?us-ascii?Q?sl1TbmODI7krzhRnWX9CuWvghWx+ptepwd/foVjxn6BRQ58/cbbTXyakQWgH?=
 =?us-ascii?Q?K2t8yJwxUByMHqYhaULpWxI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7qpDiBxFmVp3tGdxuH/a1+MZzHVJHzAR5tvcBrSYoaqjIeZt29hDTPz4Fn5F+XXUxsGkp+zjRLrkmEOrKHzQuYxejPWagTBa2K9nDCmnLqvBIccMdKCU7OOjcnvB8nh4Qqp+KXSsRXOxuI1zAHn3pZogAetLJRzQQQQ3kNfqQf+lXxVj6++3+LLzgCRJK0NVIoxNaTlY3QvoDs0Zx+Lb2jI/VvTXfd45O87TqQ1tVeNOBRMO5AT+kcobBUkW4KD0RgDCzJsYkWH5ekolU1tvnm5+Ekw7niqARNEKPcWR+W81dSQ4QwbuCOEvwmbLkBKsElrtIfB0Dnlc6/Fa7wO1MEsnwe3JsUd+yCVyIYmyFSoXIcZe4QfiSeI87jTAW5JTxnK0vPyQOPHcsl5KhfpOJeWIagsZNkBr2ZND1t72NHTsoxpZzbSIhxUyQa+f3//qtTSCB2G3I+E+maZcP1VMwiuTz+qbikSxjoNiqJ5+QrnzyJf21qhODY1wAGofZfl+nDgkaPED+pU5Zu/1XZXU7smNfhJtcymf4oYXUUzQWnShhEehqP03ZzrDAL3ADgsMukUdir9F7MNYtRjPe219prlduXZC7hYbV2jutyjiN+Do/HqGBkaR3qHAg7btODpsFWu0Ukh8lBmjPpDd57ARrN4UWutmkCf0fb0b8CDL9/a74zig8lpTRESKnbJLipuJA3v+DdPmhy78rJswFiV4pA277NVCE2yuPOYy9MC/NPH8G+jFkB4uaYlQBGoTHQFbylM/yt/vQvWUzuAd03BAhg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aadba9-a00c-4723-346f-08db2ea92c9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 09:53:53.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zD+hCe+8GS7WuJhTKCO0HpL+JzCr+2COAm01nKkDyGCqoALZ5n7B6BW6mJSnStu58WLKLiKQp2KKV5wWxTyZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=540 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270080
X-Proofpoint-ORIG-GUID: d-HfKWyhy-b7vkNQ3XhFlV39f3WhNT1D
X-Proofpoint-GUID: d-HfKWyhy-b7vkNQ3XhFlV39f3WhNT1D
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few items were identified that could be optimized and simplified in
wait_dev_flush() and wait_dev_flush().

Anand Jain (4):
  btrfs: move last_flush_error to write_dev_flush and wait_dev_flush
  btrfs: opencode check_barrier_error()
  Btrfs: change wait_dev_flush() return type to bool
  btrfs: use test_and_clear_bit() in wait_dev_flush()

 fs/btrfs/disk-io.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

-- 
2.39.2

