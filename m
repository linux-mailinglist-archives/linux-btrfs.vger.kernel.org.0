Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6801676948A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjGaLSM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGaLSJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:18:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA124CD
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:18:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAiGH6008873
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=L5xpPWTukGxI/M2g1D0mNuphtzIrRRndRnvHTOut1kQ=;
 b=hxRUXirb8z04N9Cme7d/nMw6Z6aAKTxpLL7PvUjeCpftcmw1bX3qyH8nr55W1vczs4bd
 2jVxTK0hlyBXl+qUPpiIJnGom+JNqQn24eZyAI7sh0saUzeNVHoKAdC56l0yBlsepKci
 d0YDWHwVWAyqbp4/pHsSkstPFFm2tVJIWOXGuuYGXfDSJMxWXok+phaft5HXeHqwcnyP
 FNvJ21if35/AN+/AqdjdMqiHYDfPT9+nmItL4CkG5Q7PdjIPk59Jk4T8pF/OlwKRk43e
 gjsgLBQpDiDjU1Oti0922dvGVeL+9b35kvSjANFi8XLmpGq61GD9jIHz/bQLk/7sHObg tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcttavb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAvEsB001147
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7ad23y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJKOh17QqsiuV8hlMarUUvmJxeZFVl+OCK+fNgv1ohUF7vt/kS+FWpMlgLGA5Dmxqr5SxWu1f1W0WnKP3RaqSID1rZpkGImbXY/klq9MA64fGMAM8UvVQ0QcU/5n7QZGo7LTIkbG7xZlSk0onJUsdx7AOwYKiUO2a+lXDHNZoYFmMTQEXoPpWoZoTgMILAj6jdn+JP0iPDqcDgsos+6QyuxpcB/19xa45VvI/42mzReUvWhi4EGvTHVRjkBxT0s+K/rgkSVicR8CLzW69B7lRDiV/Ufu/VikuotlsW2oLWJcdezpPJHNAPVnau0z2go0J318PAnNElrPJ8yPiFXgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5xpPWTukGxI/M2g1D0mNuphtzIrRRndRnvHTOut1kQ=;
 b=W8N3ovBfIPWInBM86HLPaqXyef6/HWbHwZkoKZlbyvUCQREcVjkJCd4bZuX4nCWT7fDtZAEK9HL0jPki+Mx8yBXREveahJxrEbM0nzQr7etEX8frCtHmsrAUrknhPqvo588pHbNc552CJzcn5tnGZ5bp5kq8p4IgeXPe8pilECC8N9O5+dO0AY+rplKcYthonM9v++CK5r68eGlaxKx5/8uUIS3X9H+ceLn/P/7jEQaSPv4tJal+R3SxiuFbQyxGtik5mF22wgQmxK+PAj8LwoR/6qLlPp4pCUd6zTg/ShLuXgyJG/HGxQmHQX14d/EYq9GIBahiigOHsX48VUTy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5xpPWTukGxI/M2g1D0mNuphtzIrRRndRnvHTOut1kQ=;
 b=PGIMX9ZG65HLmqZouRDvNfJpqZfm+5yi7Yik4akLxE3D5Y0PzB0bshDoDI6/01TLnEELgYI1Txjt6N4TFKoeY/yGR/fAIXoE7tX3QUoCTk9QzC8QOHSoz2KsfBKdue+uFXmetJguXJxoepuBCuqGVQ4R7fMLr25wa2AqUTWTqsg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:18:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:18:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 5/7] btrfs: drop redundant check to use fs_devices::metadata_uuid
Date:   Mon, 31 Jul 2023 19:16:36 +0800
Message-Id: <92f71226c8eb0797931eda2c92ba243113104a69.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: d53f5fcc-6798-4cbc-e267-08db91b7cf9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2siKgcT+xEuWKwBRJC2NN+/oLYQLnWz6igQEdu7fNqzXEDdVsTaX0xQ7XK0/KGCkx+zKvxjhDCdr+X0F0w/HjtpwfMrXZKr9QUlYrcEB3Bge/JPzuL3kRV1ZZ4KvAj7IjiM0Wbao2xvyll6emVGUtjqxzDz0A6ZjYrDdvR+jNUc8TJSOp1gvUsj4aqVd182869VMcw/K2ZOkosO4CdQGHkw20GM6Qc2VP9KvzHg8W3m/yWvW8Rhdtl+3L2rYzhudYyWu4/B6r0FZWNRT5lgTyMPP6TyQNCA2g1TQQluZhQWtg+C7wXDJ94a7lmQrXgZk/im14HUKPc/AUZpSc3kOV6Ifwrjxh1XxjjPOd9rQ03HgEXSx5md6auIUD+Mjbb5Wh/51IN84IQ3iVZCAPn4SG5VKYd2bbKnPnsFAJATTzkVZYSM1qqKEJfINCeHw3mtCrBUa1ctCkdSk4K9DU1gkiEdQSYByElxamR4Cp98Kk2NIll7DtXIXlIK29kUgTR0nquBKpaT0ZVlnEh3kYyqdfYqa1eNT7aLrRUc06tAh7JIK+cZpX2kiGAKZA0VTUELk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwSVYQ+pmdPp4VZ35Se22N47lvt11g+sA8UjGuKiCUjRd23vltV3Cjv0r1Jd?=
 =?us-ascii?Q?0aQ/jJt3gYblZ8KCxqz9foLXh7HH2CAoG3V0oHZ6qXOx3h6Rj2qxCnraHYKr?=
 =?us-ascii?Q?M1KdFiCJHX/MjLzhMJrOVvk9DtH5j2ufAHZVkh91GYZ3q4wd9bar634VwMG0?=
 =?us-ascii?Q?bqqqQKDSKQji0TFWPEAK/v7qtEa4zumgs6FhJmPcnQUowCZXI1LypNooEO+6?=
 =?us-ascii?Q?x30P5WSKl8Wcw0do85R0p78iBZ08Y4qGnLvzCuBm1BkjLYS2BjAulCeF+7/g?=
 =?us-ascii?Q?K8TWHOEb9/KOCTh4VDxQAL0/ngFlaCvcZsuVLdeuGVelB4dSNtMbInv5Ru3c?=
 =?us-ascii?Q?VeltUYZJ3+xeSJ1j+4hGkyEA0coRgPJZGhfdib5vFsAMhlR50NGPWoI8cqLQ?=
 =?us-ascii?Q?+5QpDSg+hQAQh4haJtV4cQtoUcceYY9itnVIKY3xcaGrFFUML3W0UUy6u7hC?=
 =?us-ascii?Q?oEonuVkTr47LET7Sl6mdj//498Fnz35lx5W/wthhqoT69f1kMi8UV5rSp/aI?=
 =?us-ascii?Q?gjSBMwKZLqsZ9Wq/cdI8JRg+epJWF0/injLr6MPWr9uVEsyk5ZJGEXVFRtoR?=
 =?us-ascii?Q?N9BzEYqHGZDkHj9oGHkcNiHF5TPokjMD65TrvhSu6XIKbP2ZyGt9yiSOwPEq?=
 =?us-ascii?Q?6SmNZ3lkDisKu6p+Gq8l7kLnda1vFUHXygOFZBzr0nHduGU8g3Gi7i4Y640I?=
 =?us-ascii?Q?vNjckKlSANPmpr7gVpIgvrqOehU5FVH+l/+B1lAgmJT7Tj5Qd3sdXRXwDm/w?=
 =?us-ascii?Q?M0U3luHX+rRGyJew3190/7yejS+kUesWuwS/La/z/W+U7mDX+L05nTg4GByL?=
 =?us-ascii?Q?VPr9D+a2WIy5ZqNsZNA4JECg/rJDfVxOg6PPqwK/ceV1OeMU3jqYHrpYG7Lw?=
 =?us-ascii?Q?cR3bYismZcO5tT62MKeJCiqT/BGfB5XJrU1xbXuluv4iI9RwAxN84ITC9do5?=
 =?us-ascii?Q?ixWkAlPYgE8nCd/PtFb0vQR4ghSugDXIE8IjxZell/Oztlu8tflH4QzrDOnL?=
 =?us-ascii?Q?JNa46z3ppLB8EKAIfo+POnWmP3uxgASmwiHoPzm9Ih3gPzmGvaXAXtv/fb74?=
 =?us-ascii?Q?kykz4kITYV6cGxStTb/UbEXjyae1fkVbTxYrdy7ejCqw3Z2hIIFuy1e/4z4K?=
 =?us-ascii?Q?lzPiWnFkedADD8QrpsT5bX4rr/3z77VRE77omyxnv01afSnwfBMZzgf3/UYx?=
 =?us-ascii?Q?7pYIEHSl8akfZEoSmcXsFzhfllbEC0JjveyqKYBpfJD72ct9ir2MgL7/UOnJ?=
 =?us-ascii?Q?SXB1NHUFoyEXjicJRr2RCQBVnWGZbjJVoTKfVFjpWwm6vkoSW6Bj5rTG817Q?=
 =?us-ascii?Q?wc280QgOWPPEnA+jb/JB3N1mZISZXuZMTMZw8zPgKXoHD4nbYD8QJDNdXzn8?=
 =?us-ascii?Q?gOOF6Z1qb/u30h0WxcKXSbs5LJxRt5k7TpR561uCO0rlxEsU09c5Lp4pD97z?=
 =?us-ascii?Q?LsORrKe5FxQhRDzNZ8nZvkh2XypJ7Dwh1L2ggVozOhP7/rbLB7Rwe3pmGl2S?=
 =?us-ascii?Q?+MYMjstw8jOp1QZCWHzouQDXszsn9XM8QRFGyzxM/Hax52OxIbfa2UUiJhwa?=
 =?us-ascii?Q?Ty12OVkHK3i0Zy1UIJfJDICbuPoeJqmm18c3MAJO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V4qsQAM+FcqO5U/OPKHKl8Qqj9jx0HPR6htSnGGPYg/l4+R1ZCmWGMC6LPfXxmYARcl16ecRlQRjkl3nE+MYnvdAhJI8lRnk4XiQHNI2Vx4UywaIOriWEp0cbBr7Uu5TqqFr3h1USWpxFjtvNbCUBPzpIOgMjjyHL0sGVs0yoeFMLWLeZDs6Fr05igLrZqsl6XWvMP2WOOjLO/kKYJAVxn02j/ZwuSaWZRhEqzV0CexO1wbchkD6U8eziRkBzUe/piqaKCHPZCM52tLtsOYGSxoVknW6FsPQOnb+veSijWAuwDLxcdQG17N0u53fcIKD+xH+RW2OHl40qKMX67vyb1uh7oxxGucORyLfZaazEv8fGLv68EzL+cbmG4ezdsmjU71RbfvGa5htynsDZAlYpuBx+rHfNHpDc1yDcjxTfuSTJE/hYu80wj3PtDsLp+kRlbaro7rQgmPrwa322/MkF7W9wzcRmW2Xl4GA5gZVTUHoBvmUKjDMY5g+XtCgpZMRCPT/01xnp7YksLDudu1EaurAFA/6tqf83K4ZZYB9E9e8w/UJNVsA8TT0QsWkgkx/ftfiQihJoWQgtgQH8hhe8hIfXxO4a8hIsjv8/bhO2NRxzdfnQI2OqGXN1GpmcyiKXaCFgWLzZQDJx29tWZPl/Mg/v/lnj+9kybvsZranl1IaCZhD5Ku83O6M4M7r9MSg/orHoZE+ycQN058HtZpUnzPhhRsxJ+pAJ0+fW1rwLFoEx+6M/lWYEDTFbybJSVAbsJ3XelLQ0JMly/f0u1UATA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53f5fcc-6798-4cbc-e267-08db91b7cf9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:18:05.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxeN/cQ8nwJsK1q2sNBmW8nMKg3cQ2MLHr3N6fSx9tcshtBV9WMMWbl5UZQtoiT/LS78mWvW+SSyP9WZ0uo9FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310101
X-Proofpoint-GUID: oAKHTsOFubyvSbXWtVf1fbD2PDYGgjsr
X-Proofpoint-ORIG-GUID: oAKHTsOFubyvSbXWtVf1fbD2PDYGgjsr
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs_devices::metadata_uuid value is already updated based on the
super_block::METADATA_UUID flag for either fsid or metadata_uuid as
appropriate. So, fs_devices::metadata_uuid can be used directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e2fb11e89279..902dfc4aec53 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -313,21 +313,16 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	u8 fsid[BTRFS_FSID_SIZE];
-	u8 *metadata_uuid;
 
 	read_extent_buffer(eb, fsid, offsetof(struct btrfs_header, fsid),
 			   BTRFS_FSID_SIZE);
+
 	/*
-	 * Checking the incompat flag is only valid for the current fs. For
-	 * seed devices it's forbidden to have their uuid changed so reading
-	 * ->fsid in this case is fine
+	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
+	 * metadata_uuid is unset in the superblock, including for a seed device.
+	 * So, we can use fs_devices->metadata_uuid.
 	 */
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
-		metadata_uuid = fs_devices->metadata_uuid;
-	else
-		metadata_uuid = fs_devices->fsid;
-
-	if (!memcmp(fsid, metadata_uuid, BTRFS_FSID_SIZE))
+	if (!memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE))
 		return false;
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
-- 
2.39.2

