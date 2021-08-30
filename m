Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC13FB6C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhH3NMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 09:12:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65302 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230119AbhH3NMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 09:12:22 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UBNiW8002200
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=N2SX8024xAMH4Qmwf4OIu87qS9muzH690lpQjnEc+D4=;
 b=M4LYo23eBLZBluh4g3NT5yF1LprFDWB6uU0Z7am9SOe0kHLpfqMzNJEaypcl4lGrpXlL
 L7lDIg/kGAfbvzE+WRadHjR0Cm9wmZYcHq0zscXRdvYy81haDCHR3i6sGlkzx8y2Ry8m
 VGOdw3DQyJO6ORu0BN6QRUIowUfR1u0ceILxxy19IyeElh3Z9vi6AO8VvUt6nDbOX7/6
 6U6Spntzk8dfJZvluW9Zo0zeyUZJfmAhkWG4SN4UCChzcYx7ODP6R1PnecfpTqPKyHS3
 0hXYdnS96cnRJ1cGf0YxFzGZp8rQZbI98t+Z29jOWa3WL7y1Nu0t6Wv1wvUzDTZFx42B 7w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=N2SX8024xAMH4Qmwf4OIu87qS9muzH690lpQjnEc+D4=;
 b=lJ+zs2YfbctuOOvrV+DcbvLorTBBgYf85Gj2FpdD817p2xBLYfJueALyS/tpNcPqWA46
 mItGhmDLKYaqdZObDwifU4XNeD3iNE2/uOhnkblQ125FwPVyw+J70VW2rTG/LAaA8phW
 gTPXwysqTMyA+/s3m1uGkGtiJRn/GnnFFIFOSX/yEUqC7yay27yH+vi7B3hCCN9zf4p9
 GxKpaWPDpRLCFROHReuH6GHNrrA03tC3sDWexdxOvumnfgWp2a+A3SqwSENuT7ZF5vfD
 tBYN+0zzLWpHbMLC+ayOVgXXRg9Uk4tZRkQb9tSDsupM925O33z8j3Wn9LeK5/uFG5rq wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arc1a1gup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:11:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UD5fjg046852
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:11:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3aqcy2t7xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 13:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIayjfmGNsBec7PO4Gzh0EExXpykuURQ4yxrsewgkplGkXLKBDoH4/t+aW1ClKUMO4MXBbe3Mdbv2Ym/C6P5kxXJiKhAvtLooRw5HT9dm8fpRRlTQVxXFij8fn9dTjb0VC3wTPM0O56cgaky+3xK7zwjkDibSBCtKaGpyVfTulziRqxh6MaYfLc0zo377J9j+VXBOnqF48F200DYgeJcV3tB61pmXjjqFyU8ygPD+75sPUN2jOlVR8O/LJ45aGquNxbWQYjVethUUyI/JvhXYFjJcKLBEh15AmzMPS79cxVPe555xSOsA6du0eiB7MjDWEF5GDj4aNP45MiYsyTcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2SX8024xAMH4Qmwf4OIu87qS9muzH690lpQjnEc+D4=;
 b=abdiyCv11cIE8uuru5N6RBuVqNtv1OP+OoMFUvsWqGWLaJiA8hIz2HDb3DnDhdvWgF5qDw59ezYLhJvBe4mqgIu3M4csVW/EWk/zZC35cPsnzaydnFSUBl1YJ3kPiCwbdKzTl5L0NdNj300KJyyUtRtTS2HU99mB76vtuGAlSriQHnilqJlVG9C8KYf+jwPadoTTJ1/ibjt/KVqTMZ9wWpkPXPwRkMw7GOSMlfsGd5QzqbcjUMJlQ15traXd10LVoUrJncAZi4nudTowfGb7GtrIZ912OMH3ZfIxOx8vair4MRrIwEKNd55j82FSSLkR0DNrFKSag42GQyngHckeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2SX8024xAMH4Qmwf4OIu87qS9muzH690lpQjnEc+D4=;
 b=PjPzBklNUl6vuongOZ6NBMO/BZV6N+AN2liIL4rtvYMDzTPLM0ypVauSfrEWU06FtsBfHbwMLY1/NlvlGguCwsAH/YUpb7AO4iOMXlzNI6s+UmIIbb3gwXy+DtycxMeqVQuddnmT0RMa/5rD4KZBeybbyV44pXYZ0bHwdk2n2HY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4351.namprd10.prod.outlook.com (2603:10b6:208:1d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 13:11:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 13:11:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: open_ctree: call btrfs_check_rw_degradable only if there is a missing device
Date:   Mon, 30 Aug 2021 21:11:09 +0800
Message-Id: <dcf8a95ecd21656604202d904d5fad2ff9e96ea0.1630328821.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0146.apcprd04.prod.outlook.com
 (2603:1096:3:16::30) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR04CA0146.apcprd04.prod.outlook.com (2603:1096:3:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 13:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f15c16-6546-4056-a919-08d96bb7ab6b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4351:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4351EFC60B6132209641A471E5CB9@MN2PR10MB4351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20dsB8oK5KXshL8FsJ+rCRjuXWyKvyAojxwhCpjx9qqJizqMB82+jJMWE/ar1REFulxsgmW1PnRh2UuSAaoYdrNC/y3m0Bnfers26ZhCf1IPg4mKAmPTU5V4GDHVGZaz/M9Zi/yek5fD/8dgu/OtdpRsaq2kYVuv0dxw+VxxfyX0RAnSIM88t6sW2TFEBzZjg7hfZI5Z1Yoz4x14gND2LNakrffIbSTH0b70lm8bP63MnV6nu0D3nqvIS20V3gB0LUas8Pmciyebcuw6gDwL8wM65MrRwCJxBZMVa/8TKPbIx+eMorkIzQ/Kxkmr7EtuDcDavXsUkqe7g7dy/bVY9AldXdW4RDmI6Tc7ART9JqjAIaEl7cMu7sbq+r5IbSX8uhQjjQoEMxZBTGSeyWd8HHNWY2yxWZpE28ebdhdC1mEL5QS2ZCrRN/fK0QYdc4XSaKoSwaSUQpmy6ecaLPDufOGIKNgwLc5aBKZC64v27cTwRXoV0SBkv4ufoDatG7ZTPZlJGzQZvk7O6p2qC2K1vQ+J/S7FNh1qSWJf3Lbp6wx3y9eudKCZ7HyVdGPeaf87N3X8VudUuHFaZJwIiu5OO+g74G2gB+k1yJNwqiSHgWle9FprBSuiG0lhBQ1GC8teSgvqJe9+9noh2F7Zup0MIGaXUgqsdFop+ba4XQqUBtaKHBfB+RdYaMU+p1RIEswbxNvu31pNCf+sz3B+dwEjig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(5660300002)(26005)(6486002)(8936002)(8676002)(6506007)(6512007)(6666004)(316002)(2616005)(956004)(186003)(44832011)(38350700002)(38100700002)(83380400001)(6916009)(66556008)(66476007)(52116002)(36756003)(2906002)(66946007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KXxfw6Lk5v6N/a0iR5htsBWzZmkH4dYWf8etAYcfDCKY7P7KfnyWTik3Dr54?=
 =?us-ascii?Q?i1+akjKwP/DH5ZxVPeTAn1cl3rR0+o3OAiNnIxCXeaM4Dj7CGC8MRe1CwYrL?=
 =?us-ascii?Q?n4P3UvRu00mB4eXBnVCtm2/5utR9PCIwOhpIOuPAzht/90q3ms0HMZ+6zm2m?=
 =?us-ascii?Q?CJpny8IyAuEJfyitNIlDwnVIc933y554zw6NIoJzDqSgQC6cDEKWyqN/48sS?=
 =?us-ascii?Q?Yza9eApstAdkMXU+90E3+QYEujOrWbtNrcoOqaHBWJ99NSprIK97XaWOOCAm?=
 =?us-ascii?Q?aKc/g4ULGg2R2qrG2USwTyLIC/zGZopTFZK3aUDa2sm4/pP5vLhRisAzpTDh?=
 =?us-ascii?Q?lhDvaUuIILFx98GBfmJw9X373XIa26xUo2t2WHtO6UrP/lJ3LVJrlNovJc+w?=
 =?us-ascii?Q?ACMPmyInFTJMee5o9hoPHAZmrrIoyXrF8e/mRtCPSCF6gfsCVN6Z5+t+CtRT?=
 =?us-ascii?Q?kQcwRJA3fMqF2s/4pKif9Tz9n7MecitKfOK1GRfOQ0Qv1+SNtqfTjEpCVNtZ?=
 =?us-ascii?Q?7jBnRhhd2UaubF8elCUlXd25Osdk8ZXMZaN9iTXZAkVEN4qUFZJAlmFU5Cff?=
 =?us-ascii?Q?0vExiI3IpGqznDna/AjKw+VIffOsoIBWXVLbyaGi+P8rCjIC4cXvFTd266ZO?=
 =?us-ascii?Q?CGnOJh5wekS0CAmAeeTfHwSR066jaLGBoD/wZ7j9l9Wa411+myVPX6Kqiboh?=
 =?us-ascii?Q?bEu95k2QRxNdnGbTji9i2d0fq+YDqoBwQNtRCbV5BAwf+EcHfB47zgHNDiRO?=
 =?us-ascii?Q?U/00QA9qF6jL8qUOT0TtT1mZrxI/1C7JV2Omfx7p1Tn73cvB/LNOP/qYHOnA?=
 =?us-ascii?Q?zrcE7C52ixF9XIanyExxCHuSTDxLohLUR936sEdDOMDfZTo8/qL6NkpV+D5G?=
 =?us-ascii?Q?Y+p+6oXmNeGQBB8jfXBSJC6isBjp0VRn8GlHhO9nfUvxMMezzYspM6QHeXmR?=
 =?us-ascii?Q?q2RLZt/2clqMcmhGHPdtbBpDdti4PnMTCqN6DJO1HC/o64kwg+wjvkH+S0Ld?=
 =?us-ascii?Q?KlMd/gD4gQnlTCFk2vSVEo6a//w0QgAcLaeOAe2sgZt21U/reBDsHuL5fnms?=
 =?us-ascii?Q?pZ+9yUAkl+993qCpxmxbNb7T2tYVToOymiI2EHsEgUIRjkqUvvgK16iNomY7?=
 =?us-ascii?Q?+WhWpG+PgsvlrZuyWvIGrmrDMY+NTUD+Acx2Gh2/kiEFpkNrwwaJXmJ3HpqU?=
 =?us-ascii?Q?zdSYsCAxn1zpIo4+GJf7HXqJEUbm5wvKXGsyTF2TBJKZR9SFjYHlmLMZa5QO?=
 =?us-ascii?Q?iFH1OILjADUj4PoAVdiYlYRFuEopuWFDFFT6uIDkU5VQx02NUZ5ZM/CDTZOi?=
 =?us-ascii?Q?VJyvKP1pK8oOxghpUWqARxuo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f15c16-6546-4056-a919-08d96bb7ab6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 13:11:25.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0Oo8cpU1H+IOjWy1no2NXGao0Y9WDgqYdAjKzUqSVaPfK16WyQnnr36DEk+dUOzASibku1JcihlucS10UkcHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4351
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300094
X-Proofpoint-GUID: JhzcCzemDeAcECdlcertOzQBmmCUfTUA
X-Proofpoint-ORIG-GUID: JhzcCzemDeAcECdlcertOzQBmmCUfTUA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In open_ctree() in btrfs_check_rw_degradable() [1], we check each block
group individually if at least the minimum number of devices is available
for that profile. However, if all the devices are available, then we don't
have to check degradable.

 [1]
 open_ctree()
 ::
 3559 if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {

Also before calling btrfs_check_rw_degradable() in open_ctee() at the
line number shown below [2] we call btrfs_read_chunk_tree() and down to
add_missing_dev() to record number of missing devices.

 [2]
 open_ctree()
 ::
 3454         ret = btrfs_read_chunk_tree(fs_info);

 btrfs_read_chunk_tree()
  read_one_chunk() / read_one_dev()
   add_missing_dev()

So, check if there is any missing device before btrfs_check_rw_degradable()
in open_ctree().

With this, in an example, the mount command could save ~16ms.[3] in the
most common case, that is no missing device.

[3]
 1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4f38a657a30e..0ef3a8660ebd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3556,7 +3556,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
-	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
+	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
+	    !btrfs_check_rw_degradable(fs_info, NULL)) {
 		btrfs_warn(fs_info,
 		"writable mount is not allowed due to too many missing devices");
 		goto fail_sysfs;
-- 
2.31.1

