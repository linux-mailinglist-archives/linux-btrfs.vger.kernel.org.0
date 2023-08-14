Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E735E77BCFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjHNP3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjHNP3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BE10D1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:28:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECidhA024711
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=xGOHjhJ2zH/5xxSFKdN6JvADkFlE/J4T1BsNMNyjSyQ=;
 b=h8R5BsFqxw0HoXxHtb8ytPAGJ4oPcCUBI0BSsL+gB3gdh6/Zg+4rMFU6AZHpf/qao25+
 rZnH/RU8jMKcZYqgJl/EQY6ymHFyyyG4ocYYeEXWKSz2Y186tIyUgDyOO8vQRnkdyccb
 ITTTEfwfWZ6hCG5I+7g270mPKq/gNokX4MRbO/wki2TKvJhwgtQzAI3YPN/Kd/Mb4wyv
 FfXvItCS0nAXEdsQIqny8Qlkyt+S8eY/ZkZYyXP/ZWSc37C+fqrOgDhFjiw/WOgDKw5X
 WAwx/pS8bwq0fUrSOIkHthsNa4FSfOCTVTimegn7f+QD8erXCLVvvPvRBlknntaQJB2v UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3142vex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEqq2A005488
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2c1s15-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icHU6g7GfIF+M+dudE1Y7GYPvCu4kNpHHXG+n2Zrep+Mz5xBTni4hFTqTqWIsexwfxrcz86F+bJl1955B9RJ+m65m+r/UuzmbBaBofehL1ydWJe4Y9vR1bzJ/H4fqhRrAE/BFDiBYxncV9FzIz4cZzqm0KWUh+Kc0oMYF4+SazuA5bckt6/SePS2bKulGMVOoOz4nRFXzh6DmB1aqb9hDaN0Y9WH0MkcvBSes86aepz3KWSyEZsjLlXBSQZZRACnoniAWw0cu6gZZU8jngcFkX8H1zAkPRL2Bh58+oNRn7b7cJLSxfTVb5MrXp1itgKEKS5QvpGogOnpee0gxEMwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGOHjhJ2zH/5xxSFKdN6JvADkFlE/J4T1BsNMNyjSyQ=;
 b=WzeNnXNUOFNcELvqIQgiFCi/1qXYjMKUILHEO0Hp487q9eUYdRqyTQlxf0V/hdSKU2r3Fim5La6gaDAmxm8hT85oyEZL6l2erydws25BW/cPBYWY0eKYGZXVv+Xs6BGnpO+EK9pIgfH3wtczSX5TYJ4nCFFNLW/BpnYhkrxIMV4yzaxftLAdTuVwTVoNSYhLug791LNhZHcuKCFUytfRBLpGZPe4Q0F9ZctsHTQ9YGh2eCt+FRIwVgWekQoTIS+WB1cgHKGSWKPELuE/W2AImVcwPKc7fm6UhlqUBPAMdMblGFEbbZiLTkCncjP4WKFsVa+pRYFUGRsiJKGUefTwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGOHjhJ2zH/5xxSFKdN6JvADkFlE/J4T1BsNMNyjSyQ=;
 b=Kbx7SwlieXIvws971tf/J3IfW/wU2v/sRfnOPCywY4Xwvo4ij3/QFqjq6NG9IWl5OgLqfW1xxbTb0azuHSI+LW6LSUs95lenV31sfxlsP7A3JolHBPCQzqUEpmSk9HXdkonoRMERXLzXdgB1FqeCyiHI1klbv5DpitE4oSJbMec=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:28:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:28:48 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs-progs: rename set_metadata_uuid new_fsid to fsid
Date:   Mon, 14 Aug 2023 23:28:00 +0800
Message-Id: <ada69ed5f097b75732cc371412ed8567b4a6057e.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 9569ba41-f353-4aa7-3e0b-08db9cdb27e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4Mad+FflIN6hA1Nl12IQQW6a3szi1s2T/qB7p6T90OQmwgx6eolwUxjkNB7+WvYf0Z6A1vnGq0MXZVdC3umu9oEQvDk4n1/I1NXddhV/NQmlZbSF6Q6c91yzyxTzr9qtEUQCqWEqt+AyvB/UpmJACM+XpSx1LDRT1+lFiTHyEUkn1uvEcR4mWq53ehdqhS5fFY5SiUNlbUMuADL/fD7whLbn7JLmUfa+rKjWqzSXHbcYoSDGjin47o0a6crStdo6KUMQu2T/1oBd8VynZBYugL/brKOK4YcNbuLoqPZODNxRtguityZY8AG/g49K+Em254u5xCTMMf7YOIAAaWCNy0k/FNfU2E+iJ9V223JUrV+RpopvGLXhodaUCwPeruq2Z1ATIiFAdhIVyqlF6EM7SlOI0TL0c6oHcXVq//vj6E1AmG7JxZmW+HaJdudbPCJHdHy1V7ttKBAzg5NxPBKOCLe/D/dNwm+X0O9huqwYCUrfZAKjHn94lA70dueEkf4XwyHIaUdSSgfAYAxaHq7Z0Rbep0+BIBFV+P9UOLC7Bv70B7CfSLNj+0s99I6LlIt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BcftO2uMR289+aqZpTQXVCY9jUlYQnBINSpdl0gpmxf0lCmPtxPESLO5HCvY?=
 =?us-ascii?Q?Wvsbf9DWuqRCm3NboqAGPqswC9BaBBQFNKPgCifpAO535W0Nj3hfPBYl75fZ?=
 =?us-ascii?Q?H0rODQvOE6QMJKHFctL+73469No5GHuwJptZapK6wfC1WrUQDNUY4kA0CcVc?=
 =?us-ascii?Q?CxPfq0PFdARGd768dr4Bz9FcKkxexkNpPU+MDkp6GT5YUxTprNSCk45R1E/b?=
 =?us-ascii?Q?YiEZrW5uw6ac1UOaZavHIMZUPxE+eHOT+gymzjnYgVA30rSmBeDwbbNh1lsn?=
 =?us-ascii?Q?AsBY7u9FS3KlARXQpINnPLyK87VQXGpWNoQmL0YTiJ/xcKClue8G25Rl+t14?=
 =?us-ascii?Q?LeO7XOjOqhmEZZr4mi9fkBQqQIafG4WSx0GqOeZQNKl+KmKLpbEc8rnHF/fI?=
 =?us-ascii?Q?V9198Cz6zn5lWeBdWnYi6brIPUn2nCYO+BMYmLoeRKUmUATu1IOv0pbSRSnG?=
 =?us-ascii?Q?MNkI5JsLv7FOhzSUIGcB/hlXWB0I1mmnNl0l+CUUGs69BRwT7ca9SVrZDjaO?=
 =?us-ascii?Q?YXD0ZehdRtdPo5JbYyxy7Cbf476qVGl5LjUjv8CixAnTANDveit522+yu0M7?=
 =?us-ascii?Q?ojgYcClVLGcQR3+ctDucVlM8NZyyw7jfPkHCKyfe06ZWhqPCOI3B7v7GXeV9?=
 =?us-ascii?Q?0vkFrK8QtkNoCElnI8yIqa94R5pveWu3jiEl0JCLn7QTjrstFZrfpB4I5W0+?=
 =?us-ascii?Q?z88+vqbim8kFplbLs4aCF5B30YFR8X6GcIG1unp0hyKz7VLqO4GxWScgLUB0?=
 =?us-ascii?Q?h70vEIQbi+Cbe7OL9DlxtaisDncdJSkQ/n2dYNluES1K/bsI3WXCGzWhu//d?=
 =?us-ascii?Q?4rVQoqI9ObhRLrf4p3aUoQrVPKimJrf+6KStWFTSA9ib8xDDd7POhFMLd/Gb?=
 =?us-ascii?Q?d1RmzYj1zl1aXL/SkRm+hPcrJI/UH8LJK3tnwBuHPWoxjaxlWjxJTMu0UCyr?=
 =?us-ascii?Q?xyktWGjLxtxnaZJDcFHOAdQl6BDY8CFFEqFXGhrHwWwzlaThA4jD8Z3DtTEU?=
 =?us-ascii?Q?61Lk0VANkzVYt4Bv/EGN5CPdcRvHvqkSPECw82HSSFysFFtbMp9/xmdxwWSm?=
 =?us-ascii?Q?yWFS2Ak20uFRVot6qKb8m6hIMOtNOIol73J4AL4EPgz8mdLyrwK+EEXThTMc?=
 =?us-ascii?Q?T9eF6aSZfCHmc5T1ZcRN4PkugWX34S3evL9NxP2FYc/LjXKW6V8e5fxOtIiH?=
 =?us-ascii?Q?rotyC0ftCwKuUGyKTcYSxKAS3JZvroLp87WtjFImDbS+5FPmxhpk0V/2jIC+?=
 =?us-ascii?Q?XCgenluDZKX0vMA6X1PBk92OmdBxHy5UsSnRbPnlMf1Ptg6qpywfEajp8+CN?=
 =?us-ascii?Q?zNBIYyknfF6O5Oj2dUyEJ0eLl112YHklb4s653W4xnX20juFkUhq73dfu/93?=
 =?us-ascii?Q?mRKcXFjWydwyWdgkSLL704csUBHUdXXFHr3at4u0U7hlP16NTJMv9eaoW8sm?=
 =?us-ascii?Q?B/oShAJ1tQNz5xSIzojs9oeNOiwL31M1Pmf87RFECZuEW9ktMv4vAWM9EpBp?=
 =?us-ascii?Q?+KbFy27ChDHayvuET/EKhQ/Lja6LOVyH6zAEtE3rMmRowWZjsntY2Uu/oJ8i?=
 =?us-ascii?Q?IR13Dikz+mmzQxUciIaiVIVs3MIAAdhDkw4cQkOa6LdxDMuYvW5sCc5hK/Bu?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mxug6EykqeDLafRqLhcRdsdRZyESo7/kUQxVwQtZYi2HT5AVpr77u40xs/2CaMNYyy1w+RXsm65SCn2Oy3xw1pzTFYsFPdrQegV2VEUaje8pMDCg82W5ZKXWQ5EKqbckIv/3PqNKOw7d3Ht16y23OGQFeBFvKjtYGxdYnJAX9uRf5Pk0+SipHm+wyv8LU3djgpkaJAmyNXKgmHQEe1smYOT931Svvoc4eKt0zLyLxyUQVC3YWjeBwlfhWti3J2QlWtwHBzMJ2Df93EmWQoYNYMG8W7TRWrZkNckdDbNUOb91L6omd/6vyjvcIh/5FLzd2xLq4FcGY0vcPCRwkyV67yk/OgSZDuZINQ2qHZait1kr3cPnprSHh1KL+tcnGR8z7cwNROf+oVlFH9g7u1LcVNyZ/TLF9QgijW8B6IUHL24uwnFMIpQ0nQTRk9UvUwmEnN5FclZN3CNyWW4OTrSTreZhZzQwoxMCYpAgE8YiZCSa8dKX1YYrx581siW2zSHRAfMZADB5aMz+LFOJUAMATJkZkhvVZgzX/DJmqdhQLsry1uyjBlwb5VvVJfsByJTj8JJFl9OPgoOPNPy+eiet3byS2I52FMJo94smcaMM60hgmGiII7h/mfZer6hWLkz3KBBigDig9dzVrauVQq9xB/cYs1vYV7B3Plv1VI96/fEdoXZbam92w1GZAFClVP97ijuNZkfWEuUwTaFetLDmmQFZhjV+83t4G78cZGXVl4inmHP/A8NG25gQw6AeV9msXFxDlNhyDK7PbJi7nZ3i0g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9569ba41-f353-4aa7-3e0b-08db9cdb27e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:28:48.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55LBcwD6AdISg9Om6G3BvBdCcWymHYoYbC+364UlnNYCN1NlO2r9M2gfFK030g/eevL5bMer7mCwIGXGeI/YGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-GUID: S0BlYuCmZYH-t3HSwvZh7HL97R8KnHS0
X-Proofpoint-ORIG-GUID: S0BlYuCmZYH-t3HSwvZh7HL97R8KnHS0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The %new_fsid is not only new it can be the fsid from the passed disk
so just rename it to %fsid. Also, in the next patch the %new_fsid will
be a bool variable to indicate if the %fsid is new from the fsid in the
disk.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index f356de8b57ce..0e5760194b54 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -27,7 +27,7 @@
 int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 {
 	struct btrfs_super_block *disk_super;
-	uuid_t new_fsid, unused1, unused2;
+	uuid_t fsid, unused1, unused2;
 	struct btrfs_trans_handle *trans;
 	bool new_uuid = true;
 	u64 incompat_flags;
@@ -51,11 +51,11 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 	}
 
 	if (new_fsid_string)
-		uuid_parse(new_fsid_string, new_fsid);
+		uuid_parse(new_fsid_string, fsid);
 	else
-		uuid_generate(new_fsid);
+		uuid_generate(fsid);
 
-	new_uuid = (memcmp(new_fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
+	new_uuid = (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
 
 	/* Step 1 sets the in progress flag */
 	trans = btrfs_start_transaction(root, 1);
@@ -66,23 +66,23 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		return ret;
 
 	if (new_uuid && uuid_changed && memcmp(disk_super->metadata_uuid,
-					       new_fsid, BTRFS_FSID_SIZE) == 0) {
+					       fsid, BTRFS_FSID_SIZE) == 0) {
 		/*
 		 * Changing fsid to be the same as metadata uuid, so just
 		 * disable the flag
 		 */
-		memcpy(disk_super->fsid, &new_fsid, BTRFS_FSID_SIZE);
+		memcpy(disk_super->fsid, &fsid, BTRFS_FSID_SIZE);
 		incompat_flags &= ~BTRFS_FEATURE_INCOMPAT_METADATA_UUID;
 		btrfs_set_super_incompat_flags(disk_super, incompat_flags);
 		memset(disk_super->metadata_uuid, 0, BTRFS_FSID_SIZE);
 	} else if (new_uuid && uuid_changed && memcmp(disk_super->metadata_uuid,
-						new_fsid, BTRFS_FSID_SIZE)) {
+						      fsid, BTRFS_FSID_SIZE)) {
 		/*
 		 * Changing fsid on an already changed FS, in this case we
 		 * only change the fsid and don't touch metadata uuid as it
 		 * has already the correct value
 		 */
-		memcpy(disk_super->fsid, &new_fsid, BTRFS_FSID_SIZE);
+		memcpy(disk_super->fsid, &fsid, BTRFS_FSID_SIZE);
 	} else if (new_uuid && !uuid_changed) {
 		/*
 		 * First time changing the fsid, copy the fsid to metadata_uuid
@@ -91,7 +91,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		btrfs_set_super_incompat_flags(disk_super, incompat_flags);
 		memcpy(disk_super->metadata_uuid, disk_super->fsid,
 		       BTRFS_FSID_SIZE);
-		memcpy(disk_super->fsid, &new_fsid, BTRFS_FSID_SIZE);
+		memcpy(disk_super->fsid, &fsid, BTRFS_FSID_SIZE);
 	} else {
 		/* Setting the same fsid as current, do nothing */
 		return 0;
-- 
2.39.3

