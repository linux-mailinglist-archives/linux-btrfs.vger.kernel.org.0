Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB643F1FCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhHSSTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 14:19:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15152 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234489AbhHSSTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 14:19:42 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JIGf4B021671;
        Thu, 19 Aug 2021 18:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fv9WCsTSP/MEhwBqEHL2mgUWdwR69iUGY7Eli61V34k=;
 b=o9Ey355t980XxV4D035Ck5l2J33p6as9kIbvBhhJKFc8W6NX8DwzLM078YdAePc1tlux
 fy2ZWc/tYrufGCIy8xlRX4xFBTz9p/jpEapihAkuoDBBjorlAcxugpSwD2JdMlmTWv7/
 X4PLkiFyILpHo84R7bGUXqm/j2JMxA8uJdcymDF1Mr16Wqx1myAftWygZTMVfgDTh785
 JefILswThkUBgky5SS+6yW9LTMmzqyiYp15FcuFnIWSpa9YC9uTGVg7x21ju/LTv/5Og
 yqeax/9Ms4EyiUa2c8LUKvh9NY6vVer97xBOzvcCQt9+VPcqAm3sNPPPtAY1YzwU2qOd eA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=fv9WCsTSP/MEhwBqEHL2mgUWdwR69iUGY7Eli61V34k=;
 b=O/IY+JSj+KulWaVF7lUGsbgSQjD5FEzsOWDthsWBDE0fX89KP1oGWhHPBXLRAFX2aI2H
 LiDRfv3Q3rlO/Pt/QbODb23xYDU1Bu/vhngBOFkZGTwk3VbPuriaAsGihRe6SGvTgZuI
 sktk1aiMul+/QCc0xJkVCCsR9ORvsgwQ8j0w8BfiM5HGDrPZHZHm5XSFJdLsAre40yGz
 +MoA0Bk+Zj5auHIDz+6KGL24gDctFnPTbvlCb3qT45QlYfsJxc5vvsC0Biqk5G6XOWdZ
 lr6bX1Wxtlgp2KQhxviT9caMBGy9i/PyPyzg5HuPZFPILpCFa56qTj0XVSLxXjiJvTB/ 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahsxd0dpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JIEuxY194531;
        Thu, 19 Aug 2021 18:18:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 3ae5nc0q3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr/yIRQYjIbNNmKmXInO7mJYVgaanFgO6GFsjJnv2DXqpxc9wum36RQDuoxYEdvuWWSXhC5ggrsZo4jd5NUUlSFdThR9Q+1FNTXm6FrF0yY4mD3H4dI7skzwJOmEwzyJhHtk04XZUP+Orty2dLFOV7df7xS+9ukeBzQIA+PonevwoE4CrNt7GKuVXGclX8l8HWMWEbjOeyqomjMw1YaEGjSBPd+SyAcwXjYVaoqBi8dBKX729Gvgthi0RipI6ZBpiJLku3qBurPBv05R2XnuK3pf+3tCr459vCNmUQpyi+su4wV6CdlwQuawbpoZuqoOcmX/i9POkSY5NURGxwDplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv9WCsTSP/MEhwBqEHL2mgUWdwR69iUGY7Eli61V34k=;
 b=Gv3zeYqoLyl4clttk1ueDry34ZCaxx8Jn57E3Zq6M0Y3Or6GBX0F0944PSH4vbpxxzJdSKixcfpYmwgZQbpll6GSGxrSCBz3+YH4IkMh2I7bWgUo/WheHRb5F/bomkvPqoAHeQKj6bqCwBSSd9ZCODUw0ZPubhgz1RgdklbQMTK9o+L2ybkdaM3WwJ94vovqTsDxdsu1zri0eqz00j1caB6njEouIXPquIvEpZQuMKSXGh4Gmew73hYG862klEAAEKHwpx81DST5gFvbnZnFmjS0OUkTxZUHdYxjx/0DwYl2TuCjRlEmKPza1veYc0uv1gNZXDdXLwX1SzCPDqRfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv9WCsTSP/MEhwBqEHL2mgUWdwR69iUGY7Eli61V34k=;
 b=d/juXw1VMe4gwwIMCYWO0XtXmuNCXlWxw3m3WbEBZiXgC9/ClF0/qQ5u/qTtsFCpXXnjmKIAG209ilAiYQppDp2u4YQS4MR6LvOf1Zxjkq8OcEnsQa95iWPPwHcuZb2ahuMDae5Wa88m6YAu+27SmzwoaXHgPp5kfk8sSOZR24E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3966.namprd10.prod.outlook.com (2603:10b6:208:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 18:18:56 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 18:18:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH RFC 3/3] btrfs: use latest_bdev in btrfs_show_devname
Date:   Fri, 20 Aug 2021 02:18:14 +0800
Message-Id: <9a06b04b9003f86c3300e497b35b0ef0310c84c0.1629396187.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629396187.git.anand.jain@oracle.com>
References: <cover.1629396187.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (203.116.164.13) by SG2PR01CA0114.apcprd01.prod.exchangelabs.com (2603:1096:4:40::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:18:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60bc09ef-055b-4e61-19fd-08d9633dcec5
X-MS-TrafficTypeDiagnostic: MN2PR10MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR10MB396648182139674865706C0EE5C09@MN2PR10MB3966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdM7TtwSb0NaMEyPjAJzKIcP8+bduuhdt24NtbEnpmpJbtrFWEf3yGo0qN2OnlvnoVAJ2Y2w4YdRhgOil2a3UIylFUfqo2moq+kqjTRf963tY3XO0Q6Bnl3flAqXOuKdt6qKhRPpbTNiuxbv7toqaqXr3jN7ARQ8ED5csBjP+PR8jbwgVHZceGSVf691VMOxun0vd2WcLWWP/E7oDbVMCjTvuaRRL2Eb8MdGy6exdePDVF6M6VMEttp3FjnBPczm3aOVl9VG10vOAZ/QxMv1I0WSS3cvppzZM2kbAgWcDxqvQGLEl2rQO22kxRb9nKkVqNLYTy/sMCSjQ7QZ+P2GCQgaqPCL0i9AGJ8e54s/CpFXba3fg9LZZoaqLVG1TRaqPnaLrJLGuZaOOQQ8lGBqDtV9nP+EoTO+prSYFt7VJjufB3aotMSoKxo0u0lnrIWl+jl95E+a8Jw5BhEorr+ywZkzMFGGDdP3MuIv4ObNWx82oA/Ah0B//so1ocxHmv5HtJOqUMTYu6N89CDWi3xx+VDNEItX92Yg0R1OYJjGbG0cW/0iqK6YAbsaEQV1HbIJz9MabAJP2kRfxRGT/SreHI02KzQnT1ihvG9+UHUMIgusj9cJBmfEM6w5Exof/1lM7ddf/syMlq/zfRFAYFEGYeuEx9a8HVo/lyW4qgIpiPSLwJfVgDRs38H+3Ks0efzIIGNImPtZEkUQMJzG3/dZpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(38100700002)(316002)(86362001)(38350700002)(83380400001)(6666004)(66476007)(6512007)(4326008)(186003)(2906002)(44832011)(66946007)(66556008)(478600001)(6916009)(52116002)(8676002)(2616005)(36756003)(6486002)(5660300002)(956004)(26005)(8936002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SHcDW66LMjioUcBR8sZhAr0q2SN5+ZLtKJhuG++bXlXd3AYCa9IBzvooAhxV?=
 =?us-ascii?Q?/yAXtCE75gvMKeKDuOggr/CzcaxW6ojH7RTzrEMiWiVBUdNuV5jap6jsi9qf?=
 =?us-ascii?Q?SZga35uWctx6JcK2GpeqlXPfI3k5JmiQkkR3Tk/KZdAWqEqrgD62LMuhz2VZ?=
 =?us-ascii?Q?8/iCSPq3+79xNAg94DEpXJrecMzhrbOiuyvpUKNd04TVVmqa8amZR6sbif7W?=
 =?us-ascii?Q?GQKQuPt+OPG0aTytRifUQFU1JagHVpOcaecGypTczkMPwNPc+ZPHAsfgsfsm?=
 =?us-ascii?Q?rG7R88GxaQ3lo8V3IW5XYCzxISJAWV2UXVBvTvyFaicOoZj2uemQ50xgy2I7?=
 =?us-ascii?Q?4JFibKzLgBepG43wqBkteVircbtmsYbsMl/BmSY7aXX8ZamwWR4NltTqIum4?=
 =?us-ascii?Q?fyGxg8LMLaDdYI8oezYeMx9l3PEUDB+631jbyScKKaqb92yyjeEjodqNxH37?=
 =?us-ascii?Q?QyZZgZFwWxbb8UJ17U4xMu/NP3BAJ2zzHcZ5lT6PPTpgxrryfyXFVEXk5eou?=
 =?us-ascii?Q?hHAcbXLe6nj95dY3/egAeQGK0TGA3ILTUqWU6SDzGloxgQcfjVDG0bjm6mPH?=
 =?us-ascii?Q?FA6c/QpMh+Kw/OkDEH1ZnqzJoV6eGIa2Wf8acLKybF7o+bgz0b98MFL3MHRI?=
 =?us-ascii?Q?2LxYPqiw1/OgiyZwyJwmHZobkOLEbQdXPkaqcO4x0tyXKJ9W8n3CETaIG2Vn?=
 =?us-ascii?Q?mSe71AMdl8R/A6cVrleTCxphchuti2oS/TKEKxxEpHBJy35zCFc8jDAqELQ5?=
 =?us-ascii?Q?tuRnvn8nduYSlALVM2zlVWCE8+GzSmwSICRrow0xJpfXUlLBCEWHSgy00dzj?=
 =?us-ascii?Q?rSpiNkkFr8VQ7NSqQYEM2omJJAdnLNQmyuP02dG3ii8fyub8XGDVrD5x2Azp?=
 =?us-ascii?Q?lomc5l54Z7odgMjo311YYOI7eqBSrcI0Z8t9CP3NSmXEExgQPdLTHWZjc5z9?=
 =?us-ascii?Q?sUjxZRv065lxHAGlkyLhO0oQBu2MjcA0EjQmv6l8o0W9WwCy7czgKglgyxkc?=
 =?us-ascii?Q?Z7MgRIwMU71wb4VOvg/rt330/p4QpWMNd0dfmbbqiHhmIgDqfRZBQ2GW7EKn?=
 =?us-ascii?Q?F59dF5RWxBcnNlnd3mU9vhvaomYZz7ZIQyCcGfCzDZzfO62oUq6qjYySrTT1?=
 =?us-ascii?Q?vux1SZVxFitosC3kemX+CQol3MU0QB3GMV+wrYyVrB0ICtwVa0xi20Sr22Dd?=
 =?us-ascii?Q?P8aHnhNnaFWL+Z8dFLldZZoOc4Zo/PSK5FzTqZbygY8EtnMHjYrJeBgy7+5o?=
 =?us-ascii?Q?k+Z56cgjc+7WGnK2ZcHLcUlqvlC6QG2b72iqtFKuKLnxOru+vMhQyJSKlOTm?=
 =?us-ascii?Q?IVxB9fgsnr8BBQmJOn8Mnl6u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bc09ef-055b-4e61-19fd-08d9633dcec5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:18:56.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9BAI7tbQjQAavgiI6bl5+PzEq4UwtISayQVUTQneq1XpCcoCFlEy4I2d+Wcf2ZdsuBsNs3cAxFsr7dRm9FdiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3966
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190107
X-Proofpoint-GUID: pi4tue81Ly7rxyUThuirtkpEWZE-nvZo
X-Proofpoint-ORIG-GUID: pi4tue81Ly7rxyUThuirtkpEWZE-nvZo
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

latest_bdev is updated according to the changes to the device list.
That means we could use the latest_bdev to show the device name in
/proc/self/mounts. So this patch makes that change.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

RFC because
1. latest_bdev might not be the lowest devid but, we showed
the lowest devid in /proc/self/mount.
2. The device's path is not shown now but, previously we did.
So does these break ABI? Maybe yes for 2 howabout for 1 above?

 fs/btrfs/super.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1f9dd1a4faa3..4ad3fe174c41 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2464,30 +2464,11 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
-	struct btrfs_device *dev, *first_dev = NULL;
+	char name[BDEVNAME_SIZE];
 
-	/*
-	 * Lightweight locking of the devices. We should not need
-	 * device_list_mutex here as we only read the device data and the list
-	 * is protected by RCU.  Even if a device is deleted during the list
-	 * traversals, we'll get valid data, the freeing callback will wait at
-	 * least until the rcu_read_unlock.
-	 */
-	rcu_read_lock();
-	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
-		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
-			continue;
-		if (!dev->name)
-			continue;
-		if (!first_dev || dev->devid < first_dev->devid)
-			first_dev = dev;
-	}
+	seq_escape(m, bdevname(fs_info->fs_devices->latest_bdev, name),
+		   " \t\n\\");
 
-	if (first_dev)
-		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
-	else
-		WARN_ON(1);
-	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.31.1

