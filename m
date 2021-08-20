Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ACF3F2B3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhHTL3x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:29:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64074 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239257AbhHTL3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:29:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KBG0DR006305;
        Fri, 20 Aug 2021 11:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=2GT4HmMbU1C0g5b7SYN3u4fgADm46rBj5yW2Op7EpXs=;
 b=1L2biIxSsDz2VM90oWPWPGR25hxe4rcLA/iAV//CzJ6hfFLv3fRfVKZ7CGYZ1t+BzgGu
 BOZZ9sxXtXtKcngwFHRzLeG16sd6Nlp7eAC41PiFt/F09LYV7w8v3a8NrLGaXvjfvWlz
 yjZI2Aid3lKSR5h4TGgsc8pcKftdEM5D1R4R18nWhLmrx6tEUsY/nRu4mPaZqdwK03kJ
 au4kpqoNhSSsrDCIHV4OrZetYyL028bU0L8bzjiwEGyYiatrjQFcnI9KpxbIKgJV+pJZ
 B+4kYSsGuOLu+IP6Wd00gRttI4Btcn57gijLWZ0zbdRJ+1lrCWb9zlrvn3cjN261F0Rr eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=2GT4HmMbU1C0g5b7SYN3u4fgADm46rBj5yW2Op7EpXs=;
 b=hF+EpGcpb0Sf4y4M3A7UlTiozv086UT2FxeVob1VPUPbpZMBYZWFqigJqKEqT0QXEpj6
 n+m7CL3DVrB2GDqMuHhgl0DTUKqFSB7wUnyW9+div3cSd7jqNQgrsgKHItsQYdS+BO2p
 a3YQIfwUXGQqZVBw8kDhyLesBSooBtFN+bcKmnZ8Gw0bvFsPmOd7k//ofRVH0z+aH1rb
 HlOXu5kBwzjVYPnMkGf+nwWlh8nmX+QZO1MLKvfNpsKZJSBO+XeRCr/SSbZh4HS/8HlF
 qFP/oi8VLfeLVz7GBvnTciTVEG16TEKmwzW2iRt51dY9gmt7ok9ldIc8ga8mr5nlX8l7 Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmnqr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KBF6N7008113;
        Fri, 20 Aug 2021 11:29:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 3ae3vncmds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRioRNGasmYy39bmlUSGoLL0I8b781oU0zZzw6IAErFxRoVKS0Lcd4szB4Gol7WR6MAXx43BAurEVNeam8mdbJX/ZCF+yje+2zR/uliMgqTptsV/Tjs9qXG12vSiffNrSwhQ+BqZRDzsVb69HRMdhV4ow7dL5hGYazOVdkAGj6b17nYSOedydYy9dDGXzvnNpCeeo1k69apQsudK8dgDK6vFmVj2wh/V1uLvVHDd9a6J9vE1IfYHN0l0GOIoG1YZEJxhtmDUdQhuWwH2ogvXQQZGpJDxR2igUTbjTzKI82+4pD8PmaDaR0dDkBQ32nhWtD+InT20sMMD3qvWYCp3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GT4HmMbU1C0g5b7SYN3u4fgADm46rBj5yW2Op7EpXs=;
 b=fjlQS2WmNq+lu4duAlaa3GBblwgCk3uTG93xHOyYHgGWlxQ2aaIdBsX6croFaq9K8fecga9rDXHAtqYx6ksudA4hTs3rL/IjRIXjqdTW/GpwX2YgMo1sQDTBv/xnHRj6jyg/x3k/lMy3R7dh/Lj2aZdmOdkwFLmZT/VghklETBp/NMPo4r5G2zvrJ+tR90OXIyrzBrMzUYA8J6LlQgz4UGwFxNf+D+IOtdwOnvRhwbwNyXHzYbPtEy4WkhnJ8SQ6MsO6Uyp0V90BL3SidPnz0YfM34fttuVW+L4srGM9rB03YxJC60J93Z8jTBuuljAX20YrqLbuoo6M5CDeWx6UYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GT4HmMbU1C0g5b7SYN3u4fgADm46rBj5yW2Op7EpXs=;
 b=YVSnUbK/SdMnNsUttoUNelzlBVdisbwZ43gfxPwvVFf6Rb0eGaCZVNt7Y5X6YgBM2M7GCwp8ZBOqWGykXoAVP5bgR1xjqTic0zrKzTQ228fwVW5YOdWSVusx1r4nZ6+tD0TpBhJ0Hox8gS0wqi3k3BZu2HXtypTceIuzjXGWN+E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 11:29:05 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:29:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v3 3/4] btrfs: use latest_dev in btrfs_show_devname
Date:   Fri, 20 Aug 2021 19:28:41 +0800
Message-Id: <1ffa15f29c6913e51a60c48b1040d8306daa6e67.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:29:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40d5ed39-5fc1-41a5-9962-08d963cdb7a5
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB409491F7610540D4D062B21EE5C19@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbZGjb8ab276trVU29IZysGhATylpApnGzc9uCq/lxr8b3yO5+rcD3bBoqF2hIBxslaCarsoFq52Go6uHpwNKq8AtsUOjmWWI12NWmmpITFKlbeH3rOWcilvqQ0ST94aWQK2PpgIFI+bIjwl2pUKj/p6KdB1j4XESg9DkmYTWUNBxv+E3P79zTwD1DlWy69b26f8tfsrRujpmv4KexV/xmcRAlc8IhALCPhwujBjdSKgGbmUMdA0UtDuFxn3VUqYOdHT3obBl/MfrsM8v+wxpqKeqM/7ddA+o+Oh4zHhZXta0Jo73iBifulmmJCZZ4/x+JGtarh+NSAdqlk6qq7mRsptXDK3a/RELjFpb1KNGUZLGSO8WklOzdoJjXNEd3KsCCm5LuP+hAW/Lz0PpIGwlWthQx+mwCSJFss1ggSLoze+C2l0BNIrOx2aMbvqD0jPoFjtMTr16kgAYPnqh/JlV+W+IoEzYTopTn40DLm5ghqaXVKXyY4qSTqApw/ze7/ILXmtdhXWO8hQILscUnSBz92a+45YCh7XPp6jUtfofaThWBP3SaO139pM0JEMtcd9tRKsthHG8OWegP8uzn5pZrPPcEx457ixpqckGBBwHQisK50ao6Tl3S7Gf2z738Ys5bO5rb9wlLPGnOlrQky2tvM45OcgoD1eZFuc65WdtHh/0QA342StXbo9AR44rcf+lGhQ63aGqswfEmnExAN8tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(136003)(366004)(376002)(5660300002)(956004)(44832011)(8676002)(8936002)(2616005)(478600001)(83380400001)(6916009)(6506007)(6486002)(4326008)(316002)(2906002)(38100700002)(38350700002)(52116002)(36756003)(6512007)(86362001)(66476007)(66556008)(186003)(66946007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2mAEcIa9FLtJmdqIjIdcr+DZOywNx8nZS2jcgLBXVy+PTwJIWYpAdsB4sdjV?=
 =?us-ascii?Q?/+iDI10Cs4civ+GgGw58B4suCRO3mZoR944+U52J0BwQLQBU+RdY7CSBqf9I?=
 =?us-ascii?Q?K9lLQTeV6I5ZTkzZtXjijBogx4s82MjWmVnKQDSZK/dx0gLN5rwcCKNQ0Rqh?=
 =?us-ascii?Q?tUuIZgY9XIElUOk67mixlS3BxKpk/R6VGiz8jWGqi1KuACuMKAG6mhgNC8lG?=
 =?us-ascii?Q?VdMzkgcZfBOz3JqSPCnkBG7qu7L/yAc2P03VolJYZ1OJp7i/AlPsXPbsYmIk?=
 =?us-ascii?Q?6lwlY8NPI37xCEt3lc9bx60CVMxBgYAVBkYEtWZw4BAoJvEXTR8r9iXHnLeA?=
 =?us-ascii?Q?kQzfBG81+xk6q8RGrv/9G5j6eJEfOZvL7/ZwjzxKFKWJ66oP2WBcSO8uQvho?=
 =?us-ascii?Q?hyvPmPY1cmAjYbvtloBgbuPuS2sMoW8OAWt0+SlxA9iarK7Ayv0Qfjpk4piw?=
 =?us-ascii?Q?hY6rwgCs+D4NES8IcVMj1+l5FP5TY3foLOkLzFueXYjOSrD1LvWVMl8XJ7pI?=
 =?us-ascii?Q?EKCfRWBEWdFxwhRzZOYEOpv5kolMyu+PBQAMJZ3sXF/hKNSHRrB7Ldo7WAmI?=
 =?us-ascii?Q?wDaXTieo7VfcX6XGih7mseMcldz1kcAGbN4bdiAl+/agUJifPkepbE0m5nhT?=
 =?us-ascii?Q?JPAKRU49635ytf9Nu2aS1N8fgX+9UpLg11WBVKnbPE7QGYNHjFPdRYLCcNwA?=
 =?us-ascii?Q?CfadQsFH59WCHXwtN8yKzMX/gwruLZhtcZAJ2N3nG6HOG3bgiduGQ3/JNibh?=
 =?us-ascii?Q?nA4Jln02c870sbJ4Q0qOkxJjRhPKqRCEzbnnDSBSMA94lIey+Xepqw59J0qC?=
 =?us-ascii?Q?dHNf3vUZva/LzyqQiUAIFcI6WPoMc4hhF0EziOXGfzDXxBJOM08iai29Hvnj?=
 =?us-ascii?Q?hPM4yAB/R0issEZxNdDNsEo5cB7wieP+P7hk80Fii2KWCqS4/raUQeQRInVq?=
 =?us-ascii?Q?5+Ht2LOmdCoQn+uM60/9YrD3vwoAVKIsycfcKlywZa7X4zDg03JLHZBtXCoc?=
 =?us-ascii?Q?Sc5DyZnclChw8UC/xQPNl2ekrjaMYoUIWw1TuiMnzTxplaQhCQBiOT1nBS9n?=
 =?us-ascii?Q?HBEn2bSjUwpVJCakb1FKvQVVq9HpxSGwZwmw8ph8bhf0BxLc2WpuhJ/GCgm3?=
 =?us-ascii?Q?gTqtctE+pVo6clkFTNOIVXgwCcp1/PbznrcqzUzr3S13qsutKLSR6vj5rcCZ?=
 =?us-ascii?Q?LFZxbhzVJxQXimi4+LE9IbZqJzZeSZxDbTNweEVrusRmNg7EcrvDNQPNbICH?=
 =?us-ascii?Q?GoL9EB71IizqTuLebqblUlMLcJ0frTDMBS/9BoYVCisayme1VuJ7Pc3Gvktc?=
 =?us-ascii?Q?qTra6i2lQg80hFbsZg310KYA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d5ed39-5fc1-41a5-9962-08d963cdb7a5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:29:05.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLtXI9AVIurWU/rLBqxey6Xw7FGA9lFik9Wh26bCpmhPPKBNMzbh6nyJJUkDJ4BrmtvkcTc/xn/SmYYMkOkPoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200061
X-Proofpoint-ORIG-GUID: G0V_iIDlgarOo3OmEmlkjbMm-0EaMbxQ
X-Proofpoint-GUID: G0V_iIDlgarOo3OmEmlkjbMm-0EaMbxQ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

latest_dev is updated according to the changes to the device list.
That means we could use the latest_dev->name to show the device name in
/proc/self/mounts. So this patch makes that change.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because,
With this patch, /proc/self/mounts might not show the lowest devid
device as we did before.  We show the device that has the greatest
generation and, we used it to build the tree. Are we ok with this change
and, it won't affect the ABI? IMO it should be ok.
 
v2 use latest_dev so that device path is also shown
v3 add missing rcu_lock in show_devname

 fs/btrfs/super.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 64ecbdb50c1a..61682a143bf3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2464,30 +2464,12 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
-	struct btrfs_device *dev, *first_dev = NULL;
 
-	/*
-	 * Lightweight locking of the devices. We should not need
-	 * device_list_mutex here as we only read the device data and the list
-	 * is protected by RCU.  Even if a device is deleted during the list
-	 * traversals, we'll get valid data, the freeing callback will wait at
-	 * least until the rcu_read_unlock.
-	 */
 	rcu_read_lock();
-	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
-		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
-			continue;
-		if (!dev->name)
-			continue;
-		if (!first_dev || dev->devid < first_dev->devid)
-			first_dev = dev;
-	}
-
-	if (first_dev)
-		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
-	else
-		WARN_ON(1);
+	seq_escape(m, rcu_str_deref(fs_info->fs_devices->latest_dev->name),
+		   " \t\n\\");
 	rcu_read_unlock();
+
 	return 0;
 }
 
-- 
2.31.1

