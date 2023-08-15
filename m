Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69177C823
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjHOGxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjHOGwq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 02:52:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5552410DD
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 23:52:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOi8L031591
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 06:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=3jOOoUIa7v/G7bKqOUGSR3N/cCpBS55iDEzrPPxg/YY=;
 b=D5Co3fX4WzXJoafImo8FOWlnEizy/jJd2rSdhhlwUp5tG3XxW0ohpaJTg4Lzk6FMDEd6
 g153k/re52xfcSi1Im+n/9HgG4/iiuV+3aWRV27iSKJqOwP6PcL87wwZAIJFXm2XdZuA
 FRhGNlcLqwDjhimiYK1ibBQOzjc7PdaSiP5iUZgRWXNXVYQCGIcI+E+mS3D1w6v7UIIm
 /j3nUYZ3+96hFKhLLod1KURYPgyLqrWNsrl3g1NdpPmVwGc5jcBafyYrzd21n7p6ZoKb
 Jw6tTOll1OLsIBVLDw1WNIouZL3jw3XQkpHqZdJaioBMlk5n5/F6aduHwzY8ru2FZrrk jA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se31444s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 06:52:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F6ICqr027390
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 06:52:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rs8tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 06:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx8FWkmbHPr9oL9pLoV7kAQwk660dvL6Gh2rzyQUiFC000Klkeb1SuSa24I1k4dHVP86anuGvCDppMtRugpWGfEtcOB4V3hcEYTMeo8h7+YWFZ2aENyhOsn2gPWjMT6D3+WXw/9uvhsyDKZz4qRPPgS/rNv4WdkJ8s6j2JQl5fZx9KwzgyCbFWdVD54Ksu+rU/bAsqSkm+Z35pjeJRUdpg2X/alvMwe61nMxkLGzYqtcfhoKooNxnxLITwqVTtrrU8LIallnopQFZ04ovB0Qqg7qTeu4DLlDbL9kHaYRM2QoDyNPofNA4H/ftg+3miPvLDlC1ctj2YYuQq5bTwkSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jOOoUIa7v/G7bKqOUGSR3N/cCpBS55iDEzrPPxg/YY=;
 b=iTH8P8/QnA0YPHkTi9CWLp6XRiqw2PsaqLQaSjU74O3eqyUqjDjBd6yF1E/FHegMo/hO6fOvPbhmyJeeTj/9cshcWq/qrtARMNLLXsEbQ4c0IS1DSs7+0xip8iEYQGbobwFoj2PM6j3MYqtjXmxsJ4Yu1WtVnR3CIIoOf70QFzkVh7oz6nGME4F7O+ImhzKU+IdIdF41l/VJrHMHrGfidrFvggA4zKorh1uZ5j9NvK8PsCp9MULiQJbL7fL6LJ+l3wUkgpQ+udIqRk0A0WMUltkjq1c2+okUANGeOtMa8GnNVI2HImDHT3RdmnJg9yxlrdM5aq48EJFB37a91rZPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jOOoUIa7v/G7bKqOUGSR3N/cCpBS55iDEzrPPxg/YY=;
 b=uSqhAi9r0xnG+GF7RKNFu/D2tfyALhPg16hfixrmtGblIR4mAHnGGGI89MSfeU5lLv1Y21bYUwpJP2DB55lbXWgvzKJeoz0fiv6g//LqoyEjVx7agVXYWgplflC39OhmDahHPa3gCnT1nVozxwlZLB2pV8JeLtJtpCj4Ru9Aitg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:52:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 06:52:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: simplify alloc_fs_devices() remove arg2
Date:   Tue, 15 Aug 2023 14:52:30 +0800
Message-Id: <338a56ae484b9c91ccfb2d2d5dd710d5c363ebfa.1692082136.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230811154512.GU2420@twin.jikos.cz>
References: <20230811154512.GU2420@twin.jikos.cz>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7abf17-5a02-42ca-2cda-08db9d5c3685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/lnWhiUCcKn3Vq0/HPZY1b1BLURw4PUST5PtNQiJY+WvtF7hvYsY20H2hejv3Jka5UQdB8ns8lGiihjWQWIV1yuOAFae3bWYgXZIPdVobZICVzyG2vqvGtd0oh4n7A0D9dKLKYKXXfgB4syXUC8h+Uo5lDSjfK2jKBbrkBrceLQUYB0UXZKAUr1PWN7cBN8U8AUP4yL80sM4TzWNms8sOLlGPsdl6z0/O5nrQl2m0E263h9LyR7EIUNAoyIdv+Myw9Ltf8Hra1P7O5AWw0WJUBulXATmgv1tCroLunoqH/8s0ybDxZmJT+L9lwDy5uWmDqSuDt3nlpbBraxrNXE3OK/3LIdqrBnckn58qcvyOMSvc5Xlc0IqDRrKRs06Y3Oa0tkbD3BJ3HV34u4jDJ/16s8GAA+46Nd02+MuTx0RU79GBsfWJt7gg1FOPaSmn3w/X5bhEcWYwqHfRHaUFE3oH4VKqECcoKWD2CTtDMyaZ9a8kGInVuzf2vPYfDXhwfoTdog7tQ3Adck1w28jHULXEj8WXPwPn279CzZt8liKpKidWVGYxBuBRYCOYaj4vum
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(136003)(39860400002)(1800799006)(186006)(451199021)(6486002)(6666004)(6512007)(6506007)(478600001)(2616005)(2906002)(26005)(83380400001)(66556008)(41300700001)(6916009)(316002)(66476007)(44832011)(66946007)(5660300002)(8936002)(8676002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bVUWUWI8fVsDWB6VeY7nuWVbIokHonyhx/hxkQxNdmq4RZ3RRp0dfZULYrnM?=
 =?us-ascii?Q?VXu+93biCXjjH0bCQ62a19imZ67jlz3yHU2S0f1xedxXo3mjgpHJRW+/QMxu?=
 =?us-ascii?Q?/Vf4QV6DRvOscskOuzYJGyVzGQNZEbFN/jJhbU60M6cwl3qwvaPHqYfumIIf?=
 =?us-ascii?Q?EKHfIqC6jttdHsv5b5tMmlAhTbCfOL9ezHXsouE6yg5rMxQHn7FHS5cNKt/y?=
 =?us-ascii?Q?cUfoHB8/MNEuST3mxQQDzVoE1LEDruGAWAadAe1RTMpM063/2hqxMLY1/xZ3?=
 =?us-ascii?Q?LG8XVTxX55uue/xud3p50ZYfiiaiwoK2e5fECb0ZUSGjQ5bpXxPev5eTvDa4?=
 =?us-ascii?Q?AG0F8RZBcsjR7+DjSroMwBW/bI40xZMnwTKrsBq2c2RYyzGOZitZb6qVNq5D?=
 =?us-ascii?Q?SIzTUuzT0gZfxerWkJAqNf47CWMQQ/wYSDpczBuw3m9odqWk55fX/Ovw1Kuk?=
 =?us-ascii?Q?loW694dDjsUR7ZaMu5Fzcn5tKTcHIqT4OKQHeL6LSPEe6BpIcfy9kez+YK6a?=
 =?us-ascii?Q?t+M5gMi5rH/LlFCK7jrzgudgv+BfUyDUaC/blx/cuaM/dB3BDPg+3QwV5Gjq?=
 =?us-ascii?Q?DrJeey6pLDYirzOYMvdZ45imnLKbnjBKc1+6RywVsI+nAnBGPrNYoBMf+M1/?=
 =?us-ascii?Q?4mM06c4G9BFkwl2qWdUtUSzfRpVTjEjrWc7ROLY9NWOxp690+mwjwt7RRatL?=
 =?us-ascii?Q?K3yDQ7QQF6gSuerCLPC4QwqoaN55m767p5R3VA1CegErV4+jUr9hjqmeFTxg?=
 =?us-ascii?Q?4o3WF/aBvHYXiftcXw4gNzruQSJmhfQP2T38DWNrbm0Oj3Qzq5yacG/BiKUL?=
 =?us-ascii?Q?BXLHgsDPhtN9FB6bW2iD6p8JGBRje3lwgP/q8G4dnAPEEnDQgvh1T4GY0zSq?=
 =?us-ascii?Q?JZnfkoon3x1LLF8+3v+eHzlTiDKQgNGz7nzpmFKiwX7SYDn2XuaUBO4BmOZ9?=
 =?us-ascii?Q?V20OrQ3SC6eEdMOCMuLlaXmXdyYfKYiJx7c2kPDdHdJ3Hvi6Ol9aGItwdUcp?=
 =?us-ascii?Q?MIeRVsBM3YfGERq0jGjrrYdrqBFKBHiHufHBM031CP+WZ8IG0A3LdFidRkGs?=
 =?us-ascii?Q?RjPi3UujKYEO1MySwyiXvyiw+ewht6nf4X3ET5Fd2ChWwIEHJSHqihrV8CLu?=
 =?us-ascii?Q?QcRq+OMLnqnYDWxMS9ZQ1f2Sx1cykPrSPWFoNsBAfoD6m0rh744S3H395a8Z?=
 =?us-ascii?Q?cYhnfU1a1SBCE2U3NYwQ5slBpqJQSp6+iPXAR0oaZPp1GZ1h6qhM0Tr3sctA?=
 =?us-ascii?Q?Kuja5HveJqe/Tb7atdiVv6cjr2R1u2e3IHgJt7LQIkUqoUYtKqDQ/4lLnUNO?=
 =?us-ascii?Q?PJQK3xiyqYqBYW4/roBwJybtkeANrY8afxZ7n0Ar9UvswKfCf8aj1mri5rah?=
 =?us-ascii?Q?h9LxWWRtWZKMU567Y3+udYTsbHmuGoTtQRx2rXOAmrEpqIbPMMvdWN5EQ6Dq?=
 =?us-ascii?Q?51/z/YTDMSVq6Wm7VdgBe4xrEt2HPE6chNl/zCIt4z85DPoCpr3bebZ9A7PE?=
 =?us-ascii?Q?TBbQMKhe5Wz0rjaijMHX3W5upX+FvQG8H5ds8j4ns59Bn22JftCboUtZr6ah?=
 =?us-ascii?Q?dSAKXbCS2zAMg2Twh9sps0cRnkQHCpqnQdvsUs/gD+Q/qCMp18U8oR1fXJh2?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b6ROr7hJP6IkOVZ3chyBgnaCxAiC0n1T+AJjQcjrKl7mKqWKaKiQKz2oHylefUSrdDRJAZvzg3Om7rD3tLbrKEWGrLrf4euVI8J27PqtFHp2G1jUNsTWWls6H6xnXyXAq+C330qP0wvl+7rqKoMbBzM2K7fPHyaZcTis5t3ZTYnLB3UPcX7f9E81CblXITknDKRI/okBIUHK2cQwnULD3YFY3GMSBsYPXDqQAHHZ5zNAha/OjZ5dXs3Id3i2XIKBJ5iEMMipKSwijJXT+unXUtgrDjonTOtwkomLecz+mMiQgLu/C365chJ1JIj7XZ9Zhj9locqOnTPGBV4VHG6Zd365viSAGYbn2fZZzHwPw1FC07jv3KS1TloKkU04wi+IhK9HwyJocCGto3CVsvgSUkp+juNRXgUWP/tZ27SUqJxD5n7x6mMZ/EyBCPOkFttNS3SquZe+UzTpJMfIr3gHiv/xyA9DlUH/KrX+MTJ6G+amShGudZTq82IeYQASknHvM0G0GN2yNpk+v1qjQxueHBfy4GzgzQB7wvhJws3Spfx3RcBtSa/HS0nDuKucu9s/e6TCh2TJ0piFXVSCzpHDMrzLq8yflyGBSYRqxxlZD2wEtiC3o5fpF6oaIBoqfBDH+cWCIMeJGocZr1s6ZDnM8M6LvuDL8oGK2KIexnrId0VCN9RUjXzrYgIwTzsDq3h32M8vCtPAOGUjHjCqiD8yz/yAH3gUTjd7NjiH2uj4vl0RgRQEdEgMVgLURzAaBSyFvszH49ysqmb4u3Bx4QIDPg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7abf17-5a02-42ca-2cda-08db9d5c3685
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:52:38.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXM1WRej9g0vij42sX5cDeHCIs1HbJsOK6ybolXWR5JgqnMLZxu6fse+SD0fplF1bsnMdty5nxzrAHarlvM9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_05,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150061
X-Proofpoint-GUID: mgvGr7tYMtYtl-oDOfqdYJoesQxRGA3w
X-Proofpoint-ORIG-GUID: mgvGr7tYMtYtl-oDOfqdYJoesQxRGA3w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Among all the callers, only the device_list_add() function uses the
second argument of alloc_fs_devices(). It passes metadata_uuid when
available; otherwise, it passes NULL. And in turn, alloc_fs_devices()
is designed to copy either metadata_uuid or fsid into
fs_devices::metadata_uuid.

So eliminate the second argument in alloc_fs_devices(), and copy the
fsid alway. In the caller device_list_add() function, we will overwrite
it with metadata_uuid when it is available.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c |  7 ++++---
 fs/btrfs/volumes.c | 25 ++++++++++++-------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0a96ea8c1d3a..9858c77b99e6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -318,9 +318,10 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
 			   BTRFS_FSID_SIZE);
 
 	/*
-	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
-	 * metadata_uuid is unset in the superblock, including for a seed device.
-	 * So, we can use fs_devices->metadata_uuid.
+	 * alloc_fsid_devices() copies the fsid into fs_devices::metadata_uuid.
+	 * This is then overwritten by metadata_uuid if it is present in the
+	 * device_list_add(). The same true for a seed device as well. So use of
+	 * fs_devices::metadata_uuid is appropriate here.
 	 */
 	if (memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE) == 0)
 		return false;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 189da583bb67..852590e06d76 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -358,20 +358,17 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)
 
 /*
  * alloc_fs_devices - allocate struct btrfs_fs_devices
- * @fsid:		if not NULL, copy the UUID to fs_devices::fsid
- * @metadata_fsid:	if not NULL, copy the UUID to fs_devices::metadata_fsid
+ * @fsid:		if not NULL, copy the UUID to fs_devices::fsid and to
+ * 			fs_devices::metadata_fsid
  *
  * Return a pointer to a new struct btrfs_fs_devices on success, or ERR_PTR().
  * The returned struct is not linked onto any lists and can be destroyed with
  * kfree() right away.
  */
-static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
-						 const u8 *metadata_fsid)
+static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid)
 {
 	struct btrfs_fs_devices *fs_devs;
 
-	ASSERT(fsid || !metadata_fsid);
-
 	fs_devs = kzalloc(sizeof(*fs_devs), GFP_KERNEL);
 	if (!fs_devs)
 		return ERR_PTR(-ENOMEM);
@@ -385,8 +382,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 
 	if (fsid) {
 		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
-		memcpy(fs_devs->metadata_uuid,
-		       metadata_fsid ?: fsid, BTRFS_FSID_SIZE);
+		memcpy(fs_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE);
 	}
 
 	return fs_devs;
@@ -812,8 +808,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 
 	if (!fs_devices) {
-		fs_devices = alloc_fs_devices(disk_super->fsid,
-				has_metadata_uuid ? disk_super->metadata_uuid : NULL);
+		fs_devices = alloc_fs_devices(disk_super->fsid);
+		if (has_metadata_uuid)
+			memcpy(fs_devices->metadata_uuid,
+			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
+
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
@@ -997,7 +996,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 
 	lockdep_assert_held(&uuid_mutex);
 
-	fs_devices = alloc_fs_devices(orig->fsid, NULL);
+	fs_devices = alloc_fs_devices(orig->fsid);
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
@@ -2454,7 +2453,7 @@ static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 	 * Private copy of the seed devices, anchored at
 	 * fs_info->fs_devices->seed_list
 	 */
-	seed_devices = alloc_fs_devices(NULL, NULL);
+	seed_devices = alloc_fs_devices(NULL);
 	if (IS_ERR(seed_devices))
 		return seed_devices;
 
@@ -6905,7 +6904,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		if (!btrfs_test_opt(fs_info, DEGRADED))
 			return ERR_PTR(-ENOENT);
 
-		fs_devices = alloc_fs_devices(fsid, NULL);
+		fs_devices = alloc_fs_devices(fsid);
 		if (IS_ERR(fs_devices))
 			return fs_devices;
 
-- 
2.38.1

