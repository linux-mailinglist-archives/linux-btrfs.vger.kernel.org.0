Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F61E6969
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405886AbgE1SfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:35:11 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:56501 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405870AbgE1SfC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:35:02 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id eNMjjt6vcLNQWeNMnjtDem; Thu, 28 May 2020 20:34:58 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590690898; bh=io4q/CZppc3rzuMZdLaJcjQk4LkA0G6TnXDUVBTpuc0=;
        h=From;
        b=ZYmhVbB1sFdAG1M91ZL4J+tz9hhpOMztzmGOTaCYjsGM6vr6oJKl9uTJd/PLXtSYy
         Qskh8do4Qedm/W5jm8xtksMMaNtQaVaPuF/9yBnHW+HFhce0lgUIq9K9Bomb7GCrwP
         XLSD5E5RiL7b30jwf398JNW2y9hAeTHRihdlRQWkiA2O7BNviGOD64W4FDFjvyeujE
         l3QQ/vZ9z1uIz9kGCLqOrrlR4JBBUshaAbiH4qqut/iRtIbxDEW3uI9Q4oHx7iBht0
         kzVLC43nzWrquKJ2gU6cJm5EltQR5nvVzaWcvgpD/+DvqdpT2vBoG4n5mHmInKxjPd
         PcL56Y5qS6Fqg==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=rNnOEDRGF8liazhjtn8A:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/4] btrfs: add preferred_metadata mode
Date:   Thu, 28 May 2020 20:34:51 +0200
Message-Id: <20200528183451.16654-5-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200528183451.16654-1-kreijack@libero.it>
References: <20200528183451.16654-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJoKuwSWQ65alJRJ1383fXcluNbC2GX9Cd1hsEu+1jou/2ulgVaoSSVXhf4wPoUbtnp0vLc0/g1EnsEDVQv7aP5RBLz9Xjqv7mykjtVOVSUO+JvMlqEo
 jEOsExz1RyHAxHxC4Io9ukosAs9tILZvkSXJWp1qb4DK2LwenteLEGInq0Me7GfoBdf0OSNX+cI+/yqXnRvKIfhoxoDLz1w0EwYynAofsiqkWRkAc/0SGmJ7
 j4SViwOzq5cQw0ufLX0rZwxvcjhgJh4pp9sqb5bAE/b8KVkn+BKG7EpmZ+cQNMW3Bj2/lZH5ieBk9wp5nYz3bFKWuijh9dBZ9GG78nKe/XiVdnIBFhU8u/MW
 Vi2/eN6WZGE9I8Yj2rwizijcmNlC/ThYIbn/Hi8pxhmDsw9dJEInwOhCtkVJykaVI+sT/AjWq3oih78qqfeVSblcdBm0Sg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

When this mode is enabled, the allocation policy of the chunk
is so modified:
- allocation of metadata chunk: priority is given to preferred_metadata
  disks.
- allocation of data chunk: priority is given to a non preferred_metadata
  disk.

When a striped profile is involved (like RAID0,5,6), the logic
is a bit more complex. If there are enough disks, the data profiles
are stored on the non preferred_metadata disks; instead the metadata
profiles are stored on the preferred_metadata disk.
If the disks are not enough, then the profile is allocated on all
the disks.

Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
non preferred_metadata ones.
A data profile raid6, will be stored on sda, sdb, sdc, sde, sdf (sde
and sdf are not enough to host a raid5 profile).
A metadata profile raid6, will be stored on sda, sdb, sdc (these
are enough to host a raid6 profile).

To enable this mode pass -o dedicated_metadata at mount time.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/super.c   |  8 +++++
 fs/btrfs/volumes.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h |  1 +
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 03ea7370aea7..779760fd27b1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1239,6 +1239,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_PREFERRED_METADATA	(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 438ecba26557..80700dc9dcf8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -359,6 +359,7 @@ enum {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
 #endif
+	Opt_preferred_metadata,
 	Opt_err,
 };
 
@@ -430,6 +431,7 @@ static const match_table_t tokens = {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	{Opt_ref_verify, "ref_verify"},
 #endif
+	{Opt_preferred_metadata, "preferred_metadata"},
 	{Opt_err, NULL},
 };
 
@@ -881,6 +883,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, REF_VERIFY);
 			break;
 #endif
+		case Opt_preferred_metadata:
+			btrfs_set_and_info(info, PREFERRED_METADATA,
+					"enabling preferred_metadata");
+			break;
 		case Opt_err:
 			btrfs_err(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
@@ -1403,6 +1409,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, PREFERRED_METADATA))
+		seq_puts(seq, ",preferred_metadata");
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	seq_puts(seq, ",subvol=");
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5265f54c2931..c68efb15e473 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4770,6 +4770,56 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
 	return 0;
 }
 
+/*
+ * sort the devices in descending order by preferred_metadata,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* metadata -> preferred_metadata first */
+	if (di_a->preferred_metadata && !di_b->preferred_metadata)
+		return -1;
+	if (!di_a->preferred_metadata && di_b->preferred_metadata)
+		return 1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
+/*
+ * sort the devices in descending order by !preferred_metadata,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_data(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* data -> preferred_metadata last */
+	if (di_a->preferred_metadata && !di_b->preferred_metadata)
+		return 1;
+	if (!di_a->preferred_metadata && di_b->preferred_metadata)
+		return -1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
@@ -4885,6 +4935,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int nr_preferred_metadata = 0;
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -4937,15 +4988,49 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+		devices_info[ndevs].preferred_metadata = !!(device->type &
+			BTRFS_DEV_PREFERRED_METADATA);
+		if (devices_info[ndevs].preferred_metadata)
+			nr_preferred_metadata++;
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
+	BUG_ON(nr_preferred_metadata > ndevs);
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-	     btrfs_cmp_device_info, NULL);
+	if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
+	     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
+	    !btrfs_test_opt(info, PREFERRED_METADATA)) {
+		/* mixed bg or PREFERRED_METADATA not set */
+		sort(devices_info, ctl->ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info, NULL);
+	} else {
+		/*
+		 * if PREFERRED_METADATA is set, sort the device considering
+		 * also the kind (preferred_metadata or not). Limit the
+		 * availables devices to the ones of the same kind, to avoid
+		 * that a striped profile, like raid5, spreads to all kind of
+		 * devices.
+		 * It is allowed to use different kinds of devices if the ones
+		 * of the same kind are not enough alone.
+		 */
+		if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
+			int nr_data = ctl->ndevs - nr_preferred_metadata;
+			sort(devices_info, ctl->ndevs,
+				     sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_data, NULL);
+			if (nr_data >= ctl->devs_min)
+				ctl->ndevs = nr_data;
+		} else { /* non data -> metadata and system */
+			sort(devices_info, ctl->ndevs,
+				     sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_metadata, NULL);
+			if (nr_preferred_metadata >= ctl->devs_min)
+				ctl->ndevs = nr_preferred_metadata;
+		}
+	}
 
 	return 0;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0ac5bf2b95e6..d39c3b0e7569 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -347,6 +347,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int preferred_metadata:1;
 };
 
 struct btrfs_raid_attr {
-- 
2.27.0.rc2

