Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8664976947E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjGaLRt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjGaLRm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:17:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812EF10C3
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:17:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAiSq2009152
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nWKPc/BUfUg67DabtGQJk8kFA9sObk04PqH2t/XSQG8=;
 b=tyf/00RCNxeqhdDEzMbVm0FE2LXk5Ap9835CodTkM2NGyzZx6GEpRGuJ8WJP3X213sd9
 Z5tKw87+sfg/J9NU8upWFAW/DOuO6ZCVY7oMpZvAhspzt6+3XaLE3DZtIsERAYUAflz3
 XVm9g3aD5Z8T1JET8cuyp39PVmW082jYhUweoPmpzSkY3/MpEFYWTlhnoSMWFbxI/dop
 5+uMP5m02agEXmyw4MfA6lCBE2otHiiRiu/I5q0wmZ/fUtlhd1KHwvs4VflpEPoVjxr2
 hQoYhPDFI4xudO6S5tCGdIgCbA+TYY27OVehk4UcJS4oqAn4pgIfiT7v+g73nQFTGVsm eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uaut9y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9ijpA008576
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7aw23t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIqfonZEEBrOFBDuzzoQuP4PXGDtc/Uu3cZkqiw+1ys5pDKFf4aTmY+OiacoC/CThdCRmeVk3nHLR8Y0gUhR6d1EBjAWgVNwNayhJloLZaz4HXW/L6PhnRF4hzEHWFfjcME5HTkjmkF/UU+q2MIFKG50Zd64zlmNDnwCVzD3htHS5sYYuAbmXlmx0q/Q3w3zujj8MY0+rrdwO7BZPWej9nOtduxJ0WZyapQyDmqXwgh0OrFZj0n02x5yFCKGyew0sdr9AkTZDCV6HaZX/hIRClKAUmE+uI04t21fqERwlisBr7QWlUKmAaKMs7EG73xo92IG+GrrCyQtiNrReMyWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWKPc/BUfUg67DabtGQJk8kFA9sObk04PqH2t/XSQG8=;
 b=gxpzMumEReGBNovftNivcFKgQe4VyNFGN0ViCttqLBlmM02hMnTsFPMCymJISDGG8a/DTBpjUEdTlC8cesDJk2GA3jLKubrY4BDpib3biqLWQdS8t8gktLwpYTsRwCb/AN004kAJUMkhKYvRREpgy/rruW8V2bpG9UtFG+ghDIz8+MlhcXhBwstPsGFZrKmrIq5R0uA85XbmjJZuCFj0aLrx6WxWJkT7PsYZR05UtN9y4fA4bXoZqsdNfWpD/0dTX1cvdYuFhBMUIA5vZAQ7dKhP+kBhMZQr5Y4aPDMHlv2TInWN7TK/emTi2sHKaj2VkvTnbnZDRM86zLkES2VSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWKPc/BUfUg67DabtGQJk8kFA9sObk04PqH2t/XSQG8=;
 b=R1fnqfaS7JnAKe+coedcwLhce21jhqxcQGPggSoGUN0Lrc5Q24DYBEMpYN6kLSyghyvcbEtmPCx0iGLGXkrX38snTy4GqyTIJxBBdyyXeha386cyuDQj0nqBVxMe5614Uny+VwQq7Vr7ldMQxqOIKquNLNmokn7hKD95XhlQ0oE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:17:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:17:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/7] btrfs: add a helper to read the superblock metadata_uuid
Date:   Mon, 31 Jul 2023 19:16:32 +0800
Message-Id: <1cd0b6f911758c85fd135c24d88c3b0b9f0f85a4.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 6285f2ad-40c1-49c0-62b9-08db91b7bf31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbU6y8LD3lu9fE3e21B5Q3ADAPmid1uCa6bYmPSvRTKLUhIrmxcVdqam/AbXmEeJkAEjIw0hgMKMJNRwBxREEIeCFLJUGTM4wlLqHAe6fCypBKMqz4EiknmD+/vLlJnG8cWlgSk2Yt/UJdhOoxvzehnXknuBtxGuH1WDNN3Ez2pRlL17rnHjPgJnj/p3bBTrhckm7Enm89uUmENgxF2F5bSXtiqtzY1koPSrcRDXWYuBA4LVI9VC6lI/aDC2FduGoWAXh1yOT00BEDtE/5XskA8aeJbvUteA1tf0bqlkpi5WsubfkABWfHYENepXlJkgpJ5a4UymDyDeBGOEnGfzix4jUzniJkQKqkVXqzVZGRuTXQZcmyAjfOT/5ptiRCC1jHUpQkTo9k7n8R/Zl/FZE5u9fhFavFsON/OjmwlVjd2QUP28LY3+YuA/14EjLv8ONg/UxmmCrrdQdHeN41CptwtjtRrq7JCtJ+VJqc4i/kEhHJlpPRxrK73i4kaYju/GfmSqfWcFPWMRUqWin72GY1/8+x6SFjZZ3FBzo+h8DDOTaz4inpS6TiPtUdFht+49
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4FZdbdr83ERqGAaJQQQj8v5fu2UwuxjI6arfMOUXsbnHvz7hJMbZy5RxIM5b?=
 =?us-ascii?Q?kyb4w4gi1JSDETqaFLCqVRMw6QZcpwb2cA93qqhfnx2GWQfvM/UCkCqg8tiO?=
 =?us-ascii?Q?kPac5quOCJjzRYj9LQe2onBF45rBBIk0Hdj4b7zSR4wQV0YxA6ZIvWYwCPEf?=
 =?us-ascii?Q?eqcfQmrWxsUAxblhbX5Pizmj0r0d6FKcXbACOY0/oOdieq4Eyb1Rh74ENZZK?=
 =?us-ascii?Q?obum+Y6NpMe/UZfrAH0lIrMS4yKO2Ww8GPQrq1ehjzANRe/JWG0fiuGsnwx1?=
 =?us-ascii?Q?wS35svHnDRLbFZ9d6nV8XdJJ49XdZuDhFA1kLN7tE1JFSoTLdlQdYCT9eCKQ?=
 =?us-ascii?Q?MHdbRapJGFFqV/OxCzuAPvkYmkcfzhpuYWzlG7UQRuV6Aa5j18ZuYOHSgSGg?=
 =?us-ascii?Q?r4UhXbVyBQHDp5LKFdUZ0X1k8Ds2Y1yAkT0+QufsfuHD0leM05LkMDWMDHPH?=
 =?us-ascii?Q?v6UxNt2dtHwqagOCSlXmvSIEfecoCbKGWxVElLtCHp2NFxxJI87o53ErhYXK?=
 =?us-ascii?Q?W0iMcwshbGOPFMJy3BkfYX+Ar1QC5j1SHES6DDBDChC37ZluoJt6Vlwp7IHy?=
 =?us-ascii?Q?ukLCot2tbw5HDwwOVG7t7UsPpYPqnJuKJAaJ4ZfY/SBp44WOBZ/CPVgAnZMf?=
 =?us-ascii?Q?yaSTAmeoq8frVqLSzTgbYUrMhuCEqgcy6UnHh37pI4rPPO+zYew8jCPJTgif?=
 =?us-ascii?Q?IM31nmbpLdTgOqwlH8NDhbUxLJeGiiLl42t/ulve2GTusF5sYYRM62lphYrW?=
 =?us-ascii?Q?J8HNx1xr8axK7LieFxF3e0zN0T78rxCzZl/vGlndJ7AtrIRAUJiDR4jKsUAF?=
 =?us-ascii?Q?u87uM0Ly9Xgi9d36X9KEBJNUAUU4lr/o5sMjmoQBmn6oO5pzWXcXd0sfs4x2?=
 =?us-ascii?Q?mEzS5S/NrQxMvn7mLgluuYKeqEeMyC/P3sNiInomAEwPAEkOiJabJjSWMF0/?=
 =?us-ascii?Q?rR64qIjdjtZOjUahJSnkeFiI0HOVOGB+SXHroeNdLAruCW13IYGjUc+QWVOc?=
 =?us-ascii?Q?NdJonmrjQTIdLvS1z4QQLd3Mtdfa9ElUBP810AkgAzHkPSpijvMxJg3kbFTF?=
 =?us-ascii?Q?nO7ABrHUOd2CIboTsME4AxyE7azVbfJ++cEdvbUZor6otaCVy7gQiGUbMJD+?=
 =?us-ascii?Q?YXT2AMs5soI1Ze8o69+tu/31Z/qIGWznuIRLOVf7V9UQxmJV1qT3UF9Bcco4?=
 =?us-ascii?Q?YC/lxaq7Q1a1GzNQ6chMTwF76jKRIEs+l9DRskoUiU1lgcNOTesBLyxFgDQy?=
 =?us-ascii?Q?CGfmZucgArAwATOys6DTTNdlgi9rjpmAsMBysfblnTLyhX+8cz/i1O3WRcJQ?=
 =?us-ascii?Q?P5Jpf26kWhhpnRZgoodSetP6SyBo+cUouvboNm1KtotMlO1smn4HQpAQg/KG?=
 =?us-ascii?Q?2esPKxrhQRslSHLP/QJkeCUdFqA1uVJz9df0C2B7MTZgWSZiB9DOPYXf/WoD?=
 =?us-ascii?Q?lCkH712GyCDVLYFZl10K7oDS7zDT+JGlBWrG8D1ZXx31FWwBH4pnEh+i9sPW?=
 =?us-ascii?Q?iMkQ44vq6QPMpRI8qHsEfKiwK5n66pTKqBbp0vcjRQmH4zhDQ2D1gb4GF9Lp?=
 =?us-ascii?Q?AjhGLk6+yxQGexJZN1qde0OVMdUd3K9lDkJ8PNa0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L/N2HtHVxqupydIBnf+5S2zoWDdkUJDALYZ8q+0cSW8fe0fkCj6gZNwfp/3k7coaz/Sb9ojIT1jdyIdzvXOEBexkU4oIc1LJCDGGsj3Z1Ld9VwmW8bsPuWKkvZDYwcWER/mRNINyP9Fh8WRj/AunMgJdaAP3WBn8X+pKoFC/MNHT4LtqPQLwliBwD1vgt92WrFTfwBBl6u+peDcfXd/4sxRvry90kT+YiawYU98jIPzm/HWl1zq6g7GKmvvNR3VR7S127oj605ysepcfMLBZhlqu9wPB/bci+3FMB/WnRt2sydRpWx8+YF7NelsE3WlOL7PS7zcSI6xcnWr1k1igKFgSYCLVsqKd2EDdk9i7NNcqF8RPYgWNaehYXIs//0pUSs1TqUJlc2y0vdlbYATAxI7pu7xFmJ3p5La7Gc2URIgZNdR17kh2x8FhM/ksXHMpYSWVcRm8vaR6I458q1DDSFjBYVojnAW/FfBJ3E8b6tAeCBK4vR9LMN+v4+a7DkTvDvxJiGL+vnQK24QT93DgMuKwPBIlxNZ4eNOw957vwdxIy+a8Rlowz4kaRal8h1JqqTXhg872ppG5VQvWogASScZomt7vilGWqnWMQHo380FA4zZxdha9t0Zwhoa+bK7kMU7Or2FW3IrTBOQAWeOxIFVLhm2wXEWQriTDwqwXX++noCyS8k7uKCLI44mYeSr4p4vxJ/ALZ9RjcB9wF/BW9M/YHQ833y0wEzeoIhp8U3LhCdotYVw5JTmYqTqIuNqpkLO5OSUmlySdVnIKH8fZPg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6285f2ad-40c1-49c0-62b9-08db91b7bf31
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:17:37.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ki6OH2IVpIjRfG/tjpSltH/lJU1x2JK7fmOV3xsiTLBnxD5qDteCtgDPUYz3IUjzESC9fiQ48ZUuHfE76tZIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310101
X-Proofpoint-ORIG-GUID: Quo136c0xaTh8nvNPw-urlDSoDxutROe
X-Proofpoint-GUID: Quo136c0xaTh8nvNPw-urlDSoDxutROe
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In some cases, we need to read the FSID from the superblock when the
metadata_uuid is not set, and otherwise, read the metadata_uuid. So,
add a helper.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++++++++
 fs/btrfs/volumes.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70d69d4b44d2..2020b1fac764 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -681,6 +681,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	return -EINVAL;
 }
 
+u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
+}
+
 /*
  * Handle scanned device having its CHANGING_FSID_V2 flag set and the fs_devices
  * being created with a disk that has already completed its fsid change. Such
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b8c51f16ba86..0f87057bb575 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -749,5 +749,6 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
+u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb);
 
 #endif
-- 
2.39.2

