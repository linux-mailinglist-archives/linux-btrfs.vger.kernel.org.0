Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1697C435FB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhJUKwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 06:52:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62678 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230105AbhJUKwe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 06:52:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LAkSda013134;
        Thu, 21 Oct 2021 10:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=j7cnZGlvRfjASzvZQw4AI0DL24mYVdvTTZ2tTZlbjeY=;
 b=XMpoUMdVbZ3VfxwaiovbPt5mRntRzGpNNe70KmcqWMD3K02ab8n6Z1MGF3gexbbyIUNk
 XyqHOyYXksFqq65EGofjgLF06KaIohMOTFdnGfdBmUX3ITn5nYy2md3+jUeoi8gqyDZi
 TPI9A3KmopJvNy7JYucPIrno4wqC/uEyZZfZHxLX0aln4HOBjCTrwY1RyeYFNEF0NlZj
 +z3lCWvWGgJ4qT02fxoYISE4U8i0NHD/fKP5OoDalf4MhviEfUEwGTDLzr2TDcsIpUNk
 GzOb2PcDg4HG83G7bRZe1MbT0e9qmJ4U8LWxv9xOWB1zEpSpjMznJWj83C8Gtdw64kEq BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkx9x12s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 10:50:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LAktCd131618;
        Thu, 21 Oct 2021 10:50:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3030.oracle.com with ESMTP id 3bqmshxvca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 10:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9UhEE7lNVMIGebz6nJB/dhfGtaX314N2VgTnkYHB1qpQmgHtZTVfTISNaB9ihMwBSP7a+KAlaFrs7qji/oVbkaofOzg2gkb6U3toFJSmeW8AATIwqf6ZUnxl7RO27y+tw3vBp7cqKeKxu5zzN8gG5kX+STubHIFwF3DG47BboI6NI5MwevgR07r/gwFeIKNsyRYvEk5H0N1b8pww0mSBMaHx2HvxIO4by3qopJYrf0LxdVpTCL2SaN/3MTJlXMY++gAPmOzxapC/iCAlM3iJfM5Bdu13XpqRDgfphGwKKp8bxRaaIlpDKmZanAv4Ei3R+CqMCf7ClNG/7zEf7rsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7cnZGlvRfjASzvZQw4AI0DL24mYVdvTTZ2tTZlbjeY=;
 b=g+VM+XaU3kHENiHZs2uGgMxYkyR1PPhYmjglZghcdRwllQLTXlJMvvAcRhT1Chh6CEEswUjLqkilu1GuJ2uvieRHlE1t7qHXZmKdW37HFKJYl5PKZSse+W/bmCZbVy5L11z0zG4brJcSumEwvbs/AbFUMEc3V8XL1QoXU95Jf++55PX/6LzxJZ2B5tbVfPMxueeppBtcn0NpRPrPJ+gTwskrkpFlERTTwtCA+/z4CW1hVXNope/kDoiAH3Z+n20KY2M1EYWeqNVJy5H9OAmoMq/OQfC9fciYXawqfAptvZPezAjCwrKzjlYpMJ1qRN++kvZItyryqxEnCB/IGjm0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7cnZGlvRfjASzvZQw4AI0DL24mYVdvTTZ2tTZlbjeY=;
 b=x9P65pxemBkQD6/rY6rkAjfrkakeMchqwY9w7/4VLfMbShGDj6ofIWlNOmyTg/DY7VXjQKHiFjy/Ejm1a0tyQq8kOwUDRrjhSeOpbs6H8K0JoTr2RMqliep0RjnBVX99VLHhPEDLFf1mFHVoHjZeFSl4snDdOMS+yCDLQ8ewMaQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DM6PR10MB3371.namprd10.prod.outlook.com (2603:10b6:5:1ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 10:50:13 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 10:50:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Thu, 21 Oct 2021 18:49:57 +0800
Message-Id: <8afc1ed3ef688557bbb0dfae1e23d47e53cb645f.1634813005.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To DM6PR10MB4123.namprd10.prod.outlook.com
 (2603:10b6:5:210::10)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0011.apcprd01.prod.exchangelabs.com (2603:1096:4:191::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 10:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4739a09b-ab81-408f-087b-08d994808f5f
X-MS-TrafficTypeDiagnostic: DM6PR10MB3371:
X-Microsoft-Antispam-PRVS: <DM6PR10MB3371FADE9D8D9F74E95623B5E5BF9@DM6PR10MB3371.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2ox/PbelnUhxT9c2Z+23ArY1zwG5bdGaXuxcKq1hAj2VfqUuY+4l3cBLWRZAKz8svm18rzr3qQ2zdufu8fLmjjVLS/bm/gqX1WKwv0FUtBefORvLoB2t9HhHBI9mHf2UjrRLDP7Now4iMoeAtj6gasLr/4NTVgoZIAq8tnvBEBr0sNwmcTBDYBT9t0pJczC4SLa3movTGmlgupCglp0f55Y6CFC1DEwe59UkZoIm3GkmI4p/EplIKup9T5LewNDjZ33+wf9+Wen65b7QFnnMPIwqn0XBIeBKV1cjJA+RY2rAkHH3HsTk/1fCtM6lpnHa/W1KNqRQ83SgyMYNixQiztI8DWrmpj583FbY8zvTJXSyfRQX81Xaa1TMpBP/+1W8F3pudojF5j2hOMNSZMIn8ivVlB139iUyiruYlFsMz3hlDxsHIAh7Ndvv7+0KibTHDiaLk+Pv6gCwSXBjfojT5kbcld4eel8U6+MdZVZM+YnSxQINflar2y5zaFa3Zy8ivdlSDJU8gkUu4gZjsffhGc0WDoTW1VqeR6XPEFlW4fOKM/J39Su1thrI2r7ByHHVj9542yM6nDxzxLYKdidQ3ZlFc1AfaaUE2uAgp2F+Nsd7k/BixECK4JC+htBd4JMCPV6IC//SRlcEwxlsz8HR1aI8AvMzYrXxZJ2MJNMZtqnsawlt1h+/qiKqzSWGKhqkVr3TsLZeZCDc7GyMkMxHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8676002)(8936002)(186003)(6512007)(38100700002)(38350700002)(44832011)(316002)(956004)(26005)(66556008)(2906002)(66476007)(66946007)(52116002)(6666004)(86362001)(4326008)(6916009)(83380400001)(6506007)(6486002)(5660300002)(508600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZDzyN9iAspjVi+G81EEHL82g7c7AknnhgSEzo+l8dED+xV1QeZJAkpnLJGDg?=
 =?us-ascii?Q?+MNoeOE9As/9+RMeALXfPPZ06dhsqk47RA5biCC85OcbO/INBCYQ+mdienjM?=
 =?us-ascii?Q?fsW2JaVGd2RTeQQVh7pk18FMQxuMPzJfwWKdhPAenHVizS7IWqL6+hVIaazP?=
 =?us-ascii?Q?aePGbDzY0hfoz64YO/53SqyFd2ORbiP93knDG1lgo7CLnrtB4UGT3gnMTVUO?=
 =?us-ascii?Q?59v6Slz6peoOD+rN4UBwM30DT0H8AOpdTLViEDNGZO+7zZtquXA4amnexUGj?=
 =?us-ascii?Q?bIRxIt07TRjBK6CufpToQ+oqa/DMQZ5jfXQ9bSquA9qtXJItjyAQPDGhDQBE?=
 =?us-ascii?Q?Sbwwvq9+ltNXQ6wabf0dHrE94++cKYn7FlPcdCmQ2zyJTcqQws9EpIdAmYg0?=
 =?us-ascii?Q?rFxwwoRMmMKQd2yoIjjU6D0tBvgP5oBlwOfxLVkSl6ATvAF6tXLLDF90QVF7?=
 =?us-ascii?Q?pzG/w7NRm9K1QJKK9KcJ92ULSY1XL+5jbiFS6nLvnd5e/ZSlOvxZZObFpx1U?=
 =?us-ascii?Q?0SgVaGK5koTUT6rTQvb/W6ue8y6uJASr0h7CV3nYrbxQpoXfVd+tTkPiufLs?=
 =?us-ascii?Q?Eii2KcfutOL71axLDGH2CwLjaoHv/1/KCXTkWYjSrNrVO8ejq7cR8j9E6CnP?=
 =?us-ascii?Q?x70G6KcsGtZjjscIVOTbe8a/zicIhlfmE/pN41/e4OlMaxptVdDligpCCH2R?=
 =?us-ascii?Q?CduttoIkjCjeWmFoCDbiGKPNeLs7bIjNdKIrpFMpVIHvgH3HFxy7B+cDesAr?=
 =?us-ascii?Q?F39MGxX0K0VU43+/WBNxb+TYpxVe5EK/OOzqG8x+CNN8khStAnrgTyV0enmd?=
 =?us-ascii?Q?UYhmB0Xe1QYDWT0WRWtE1X7AiSc40P78HyhIv2rXdr1iCwMx1BAaIwbraUI/?=
 =?us-ascii?Q?w1oA1a60axTZ28zQ1tRadRwtqtMDKs6PvyEpFU168ilHT5ANWdVLNxcpAhUy?=
 =?us-ascii?Q?L3tQcg32DabhENw2ihVf5omX3HmI4vf06MdGVd6wunesA0ayhC86NmJjXdsb?=
 =?us-ascii?Q?nSk6bmQbNXVyvopeTywz2vWlU4hITawpNDykQmZG3P/dI1YN618qp2+3jNLm?=
 =?us-ascii?Q?TFrbXIOwAoF08FLHsSo57iJvHRXAf2idd+yBUWq4aN5dCiaIQXyzSLMTIq5Y?=
 =?us-ascii?Q?GD/monwSYV/egmJuB52bGipMfj7zQQoF+KlSUwGVw/LOrlWx8QVfP1F/lYJ0?=
 =?us-ascii?Q?ebNjrb9iX7ZzGzMOG/+i15tqJxEdFIgxux1jLLe5ML/FBfCzsGGuYYVd2uzx?=
 =?us-ascii?Q?C/fhCvnNMsNQb+NXKaxt2XEVYFwnM2/+ktWssBYbGs/asf2Xbm4dgDuaedrB?=
 =?us-ascii?Q?q8yDU1eAzqmNGGws8tQrdS23?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4739a09b-ab81-408f-087b-08d994808f5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 10:50:13.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3371
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210055
X-Proofpoint-ORIG-GUID: KT6cDL0Uu5V86oUCChlxZk2h1EE6FjAY
X-Proofpoint-GUID: KT6cDL0Uu5V86oUCChlxZk2h1EE6FjAY
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
so that its parent function btrfs_init_new_device() can add the new sprout
device to fs_info->fs_devices.

Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
device_list_mutex. But they are holding it sequentially, thus creates a
small window to an opportunity to race. Close this opportunity and hold
device_list_mutex common to both btrfs_init_new_device() and
btrfs_prepare_sprout().

This patch splits btrfs_prepare_sprout() into btrfs_init_sprout() and
btrfs_setup_sprout(). This split is essential because device_list_mutex
shouldn't be held for allocs in btrfs_init_sprout() but must be held for
btrfs_setup_sprout(). So now a common device_list_mutex can be used
between btrfs_init_new_device() and btrfs_setup_sprout().

This patch also moves the lockdep_assert_held(&uuid_mutex) from the
starting of the function to just above the line where we need this lock.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v9:
 Moved back the lockdep_assert_held(&uuid_mutex) to the top of the func
   per Josef comment.
 Add Josef RB.

v8:
 Change log update:
 s/btrfs_alloc_sprout/btrfs_init_sprout/g
 s/btrfs_splice_sprout/btrfs_setup_sprout/g
 No code change.

v7:
 . Not part of the patchset "btrfs: cleanup prepare_sprout" anymore as
 1/3 is merged and 2/3 is dropped.
 . Rename btrfs_alloc_sprout() to btrfs_init_sprout() as it does more
 than just alloc and change return to btrfs_device *.
 . Rename btrfs_splice_sprout() to btrfs_setup_sprout() as it does more
 than just the splice.
 . Add lockdep_assert_held(&uuid_mutex) and
 lockdep_assert_held(&fs_devices->device_list_mutex) in btrfs_setup_sprout().

v6:
 Remove RFC.
 Split btrfs_prepare_sprout so that the allocation part can be outside
 of the device_list_mutex in the parent function btrfs_init_new_device().

 fs/btrfs/volumes.c | 71 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9eab8a741166..6aad62c9a0fb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2422,21 +2422,15 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 	return device;
 }
 
-/*
- * does all the dirty work required for changing file system's UUID.
- */
-static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
+static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *old_devices;
 	struct btrfs_fs_devices *seed_devices;
-	struct btrfs_super_block *disk_super = fs_info->super_copy;
-	struct btrfs_device *device;
-	u64 super_flags;
 
 	lockdep_assert_held(&uuid_mutex);
 	if (!fs_devices->seeding)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Private copy of the seed devices, anchored at
@@ -2444,7 +2438,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	 */
 	seed_devices = alloc_fs_devices(NULL, NULL);
 	if (IS_ERR(seed_devices))
-		return PTR_ERR(seed_devices);
+		return seed_devices;
 
 	/*
 	 * It's necessary to retain a copy of the original seed fs_devices in
@@ -2455,7 +2449,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	old_devices = clone_fs_devices(fs_devices);
 	if (IS_ERR(old_devices)) {
 		kfree(seed_devices);
-		return PTR_ERR(old_devices);
+		return old_devices;
 	}
 
 	list_add(&old_devices->fs_list, &fs_uuids);
@@ -2466,7 +2460,41 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
 
-	mutex_lock(&fs_devices->device_list_mutex);
+	return seed_devices;
+}
+
+/*
+ * Splice seed devices into the sprout fs_devices.
+ * Generate a new fsid for the sprouted readwrite btrfs.
+ */
+static void btrfs_setup_sprout(struct btrfs_fs_info *fs_info,
+			       struct btrfs_fs_devices *seed_devices)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_super_block *disk_super = fs_info->super_copy;
+	struct btrfs_device *device;
+	u64 super_flags;
+
+	/*
+	 * We are updating the fsid, the thread leading to device_list_add()
+	 * could race, so uuid_mutex is needed.
+	 */
+	lockdep_assert_held(&uuid_mutex);
+
+	/*
+	 * Below threads though they parse dev_list they are fine without
+	 * device_list_mutex:
+	 *   All device ops and balance - as we are in btrfs_exclop_start.
+	 *   Various dev_list read parser - are using rcu.
+	 *   btrfs_ioctl_fitrim() - is using rcu.
+	 *
+	 * For-read threads as below are using device_list_mutex:
+	 *   Readonly scrub btrfs_scrub_dev()
+	 *   Readonly scrub btrfs_scrub_progress()
+	 *   btrfs_get_dev_stats()
+	 */
+	lockdep_assert_held(&fs_devices->device_list_mutex);
+
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
 			      synchronize_rcu);
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
@@ -2482,13 +2510,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	generate_random_uuid(fs_devices->fsid);
 	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
 	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	super_flags = btrfs_super_flags(disk_super) &
 		      ~BTRFS_SUPER_FLAG_SEEDING;
 	btrfs_set_super_flags(disk_super, super_flags);
-
-	return 0;
 }
 
 /*
@@ -2579,6 +2604,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct super_block *sb = fs_info->sb;
 	struct rcu_string *name;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *seed_devices;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int seeding_dev = 0;
@@ -2662,18 +2688,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
-		ret = btrfs_prepare_sprout(fs_info);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
+
+		/* GFP_KERNEL alloc should not be under device_list_mutex */
+		seed_devices = btrfs_init_sprout(fs_info);
+		if (IS_ERR(seed_devices)) {
+			btrfs_abort_transaction(trans, (int)PTR_ERR(seed_devices));
 			goto error_trans;
 		}
+	}
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	if (seeding_dev) {
+		btrfs_setup_sprout(fs_info, seed_devices);
+
 		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
 						device);
 	}
 
 	device->fs_devices = fs_devices;
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_add_rcu(&device->dev_list, &fs_devices->devices);
 	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
@@ -2735,7 +2768,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 		/*
 		 * fs_devices now represents the newly sprouted filesystem and
-		 * its fsid has been changed by btrfs_prepare_sprout
+		 * its fsid has been changed by btrfs_sprout_splice().
 		 */
 		btrfs_sysfs_update_sprout_fsid(fs_devices);
 	}
-- 
2.31.1

