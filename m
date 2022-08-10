Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E23E58E7BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiHJHTa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 03:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHJHT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 03:19:29 -0400
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF383F20;
        Wed, 10 Aug 2022 00:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660115950; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RxMn3xhtySPHHmYbaVUpjDXCeWBLh/KrHKMNZaItUrjHjWzMkleJbRV8AZfTPFlmeSrXmhX6/iVx9TYG09TBp+jGYbKXjuURb12BJUqEUDnvEM/pZZ/qdFL/mYzj3aFoTYHKkBmCh1Hst93HkwOWdsEXfiMcWayn+iL/0sIqDkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660115950; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject; 
        bh=G1h2kfsonmQROx/nWn0qAOswazpcP5SKYTg1aII5grM=; 
        b=W2WCTB+7v5vC8Cu5uqdVTLAgnuwL+vcO/0+RTkYTLedbobpw21w8vjTQThWOJhafpPVUQ6ASE1dFl4SESuYWhOXpEIrO6O+KQXrcCPT/dUvAbYwjK63wARdMybbcNnxaYosmZPAFghK1P5n1ybWA+f/pz+Q6loBdl6L5qJak5SA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=hmsjwzb@zoho.com;
        dmarc=pass header.from=<hmsjwzb@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:mime-version; 
  b=PvXswgk0FGqyogt11grdqRnYzSBppIuGhNSIsMdDLTQlaGnTHXPJ5KLGhnlBGscir+urF4tzjw1P
    F340AQ+bT+i8tGlp5Bc1I2M/CXpaU8XIKTzfSTIIeDO59ujCAczd  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660115950;
        s=zm2022; d=zoho.com; i=hmsjwzb@zoho.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=G1h2kfsonmQROx/nWn0qAOswazpcP5SKYTg1aII5grM=;
        b=UQmAg3FCVFqnho0eOURkKKYose871QDJ6wA2ueMuFANI30dQWG/FQ1REMDP8hpCZ
        qcGKJITUzRm82iQAwJ/0LYWvI7Bu7MndH2mPfiuH4pd1vBJMsf0ylRXZBfgppU1OKzm
        GnMEHQ71KSiZkLLoSz9xOOedINhkMeWDXncQabC8=
Received: from localhost.localdomain (58.247.201.219 [58.247.201.219]) by mx.zohomail.com
        with SMTPS id 1660115949246223.26820277952663; Wed, 10 Aug 2022 00:19:09 -0700 (PDT)
From:   "Flint.Wang" <hmsjwzb@zoho.com>
Cc:     anand.jain@oracle.com, nborisov@suse.com, strongbox8@zoho.com,
        hmsjwzb@zoho.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH]        Fix btrfs_find_device for btrfs/249
Date:   Wed, 10 Aug 2022 15:18:17 +0800
Message-Id: <20220810071817.4435-1-hmsjwzb@zoho.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-ZohoMail-Owner: <20220810071817.4435-1-hmsjwzb@zoho.com>+zmo_0_hmsjwzb@zoho.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

testcase btrfs249 failed.
[How to reproduce]
mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
btrfstune -S 1 /dev/sdb
wipefs -a /dev/sdb
mount -o degraded /dev/sdc /mnt/scratch
btrfs device add -f /dev/sdd /mnt/scratch
btrfs filesystem usage /mnt/scratch

[Root cause]
mkfs.btrfs -f -d raid1 -m raid1 /dev/sdb /dev/sdc
btrfstune -S 1 /dev/sdb
wipefs -a /dev/sdb
mount -o degraded /dev/sdc /mnt/scratch

In the above commands, btrfstune command set the sdb and sdc to seeding device.
After that you wipe the filesystem on sdb. After mount, you will find the status of sdb is missing.

btrfs device add -f /dev/sdd /mnt/scratch:
This command will invoke btrfs_setup_sprout to do the job.
It put the devices on fs_devices->devices to seed_devices list.
So only sdd is on the fs_devices->devices list. sdb(missing), sdc on the seed_devices list.
But when we look into the btrfs_find_devices function, it find devices both in devices list and seed_devices list.

btrfs filesystem usage /mnt/scratch
This command use ioctl to get device info. The assertion is triggered because it finds the number of devices is inconsistent.

[My fix solution]
1. Add noseed argument to btrfs_find_device. It force the function only look into devices list.
2. Add a new ioctl request(BTRFS_IOC_DEV_INFO_NOSEED) in case some application may depend the original ioctl behavior on BTRFS_IOC_DEV_INFO
3. Modify load_device_info and load_chunk_and_device_info in btrfs-prog for appropriate ioctl call.

After the change, btrfs249 passed.

Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
---
 fs/btrfs/dev-replace.c     |  8 ++++----
 fs/btrfs/ioctl.c           | 10 ++++++----
 fs/btrfs/scrub.c           |  4 ++--
 fs/btrfs/volumes.c         | 22 ++++++++++++----------
 fs/btrfs/volumes.h         |  5 ++++-
 include/uapi/linux/btrfs.h |  2 ++
 6 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f43196a893ca3..49d3c587c2948 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -101,7 +101,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		 * We don't have a replace item or it's corrupted.  If there is
 		 * a replace target, fail the mount.
 		 */
-		if (btrfs_find_device(fs_info->fs_devices, &args)) {
+		if (btrfs_find_device(fs_info->fs_devices, &args, false)) {
 			btrfs_err(fs_info,
 			"found replace target device without a valid replace item");
 			ret = -EUCLEAN;
@@ -163,7 +163,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		 * We don't have an active replace item but if there is a
 		 * replace target, fail the mount.
 		 */
-		if (btrfs_find_device(fs_info->fs_devices, &args)) {
+		if (btrfs_find_device(fs_info->fs_devices, &args, false)) {
 			btrfs_err(fs_info,
 			"replace devid present without an active replace item");
 			ret = -EUCLEAN;
@@ -174,9 +174,9 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
-		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices, &args);
+		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices, &args, false);
 		args.devid = src_devid;
-		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices, &args);
+		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices, &args, false);
 
 		/*
 		 * allow 'btrfs dev replace_cancel' if src/tgt device is
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fe0cc816b4eba..bdf1578839c99 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2039,7 +2039,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	}
 
 	args.devid = devid;
-	device = btrfs_find_device(fs_info->fs_devices, &args);
+	device = btrfs_find_device(fs_info->fs_devices, &args, false);
 	if (!device) {
 		btrfs_info(fs_info, "resizer unable to find device %llu",
 			   devid);
@@ -3721,7 +3721,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 }
 
 static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
-				 void __user *arg)
+				 void __user *arg, bool noseed)
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct btrfs_ioctl_dev_info_args *di_args;
@@ -3737,7 +3737,7 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 		args.uuid = di_args->uuid;
 
 	rcu_read_lock();
-	dev = btrfs_find_device(fs_info->fs_devices, &args);
+	dev = btrfs_find_device(fs_info->fs_devices, &args, noseed);
 	if (!dev) {
 		ret = -ENODEV;
 		goto out;
@@ -5468,7 +5468,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_FS_INFO:
 		return btrfs_ioctl_fs_info(fs_info, argp);
 	case BTRFS_IOC_DEV_INFO:
-		return btrfs_ioctl_dev_info(fs_info, argp);
+		return btrfs_ioctl_dev_info(fs_info, argp, false);
 	case BTRFS_IOC_TREE_SEARCH:
 		return btrfs_ioctl_tree_search(inode, argp);
 	case BTRFS_IOC_TREE_SEARCH_V2:
@@ -5570,6 +5570,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_ENCODED_WRITE_32:
 		return btrfs_ioctl_encoded_write(file, argp, true);
 #endif
+	case BTRFS_IOC_DEV_INFO_NOSEED:
+		return btrfs_ioctl_dev_info(fs_info, argp, true);
 	}
 
 	return -ENOTTY;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3afe5fa50a631..4b734d76776ca 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4143,7 +4143,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		goto out_free_ctx;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, &args);
+	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
 	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
 		     !is_dev_replace)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -4321,7 +4321,7 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 	struct scrub_ctx *sctx = NULL;
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	dev = btrfs_find_device(fs_info->fs_devices, &args);
+	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
 	if (dev)
 		sctx = dev->scrub_ctx;
 	if (sctx)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 272901514b0c1..1abd75e90cd9e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -808,7 +808,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		};
 
 		mutex_lock(&fs_devices->device_list_mutex);
-		device = btrfs_find_device(fs_devices, &args);
+		device = btrfs_find_device(fs_devices, &args, false);
 
 		/*
 		 * If this disk has been pulled into an fs devices created by
@@ -2075,7 +2075,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	if (ret)
 		return ret;
 
-	device = btrfs_find_device(fs_info->fs_devices, args);
+	device = btrfs_find_device(fs_info->fs_devices, args, false);
 	if (!device) {
 		if (args->missing)
 			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
@@ -2381,7 +2381,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 
 	if (devid) {
 		args.devid = devid;
-		device = btrfs_find_device(fs_info->fs_devices, &args);
+		device = btrfs_find_device(fs_info->fs_devices, &args, false);
 		if (!device)
 			return ERR_PTR(-ENOENT);
 		return device;
@@ -2390,7 +2390,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 	ret = btrfs_get_dev_args_from_path(fs_info, &args, device_path);
 	if (ret)
 		return ERR_PTR(ret);
-	device = btrfs_find_device(fs_info->fs_devices, &args);
+	device = btrfs_find_device(fs_info->fs_devices, &args, false);
 	btrfs_put_dev_args_from_path(&args);
 	if (!device)
 		return ERR_PTR(-ENOENT);
@@ -2551,7 +2551,7 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 				   BTRFS_FSID_SIZE);
 		args.uuid = dev_uuid;
 		args.fsid = fs_uuid;
-		device = btrfs_find_device(fs_info->fs_devices, &args);
+		device = btrfs_find_device(fs_info->fs_devices, &args, false);
 		BUG_ON(!device); /* Logic error */
 
 		if (device->fs_devices->seeding) {
@@ -6821,7 +6821,7 @@ static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
  * only devid is used.
  */
 struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
-				       const struct btrfs_dev_lookup_args *args)
+				       const struct btrfs_dev_lookup_args *args, bool noseed)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *seed_devs;
@@ -6832,6 +6832,8 @@ struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices
 				return device;
 		}
 	}
+	if (noseed)
+		return NULL;
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
 		if (!dev_args_match_fs_devices(args, seed_devs))
@@ -7095,7 +7097,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 				   btrfs_stripe_dev_uuid_nr(chunk, i),
 				   BTRFS_UUID_SIZE);
 		args.uuid = uuid;
-		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, &args);
+		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, &args, false);
 		if (!map->stripes[i].dev) {
 			map->stripes[i].dev = handle_missing_device(fs_info,
 								    devid, uuid);
@@ -7226,7 +7228,7 @@ static int read_one_dev(struct extent_buffer *leaf,
 			return PTR_ERR(fs_devices);
 	}
 
-	device = btrfs_find_device(fs_info->fs_devices, &args);
+	device = btrfs_find_device(fs_info->fs_devices, &args, false);
 	if (!device) {
 		if (!btrfs_test_opt(fs_info, DEGRADED)) {
 			btrfs_report_missing_device(fs_info, devid,
@@ -7884,7 +7886,7 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	args.devid = stats->devid;
-	dev = btrfs_find_device(fs_info->fs_devices, &args);
+	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	if (!dev) {
@@ -8026,7 +8028,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	}
 
 	/* Make sure no dev extent is beyond device boundary */
-	dev = btrfs_find_device(fs_info->fs_devices, &args);
+	dev = btrfs_find_device(fs_info->fs_devices, &args, false);
 	if (!dev) {
 		btrfs_err(fs_info, "failed to find devid %llu", devid);
 		ret = -EUCLEAN;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5639961b3626f..4b6bcc777f752 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -609,7 +609,10 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
 		      struct btrfs_device *device, u64 new_size);
 struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
-				       const struct btrfs_dev_lookup_args *args);
+				       const struct btrfs_dev_lookup_args *args,
+				       bool noseed);
+struct btrfs_device *btrfs_find_device_noseed(const struct btrfs_fs_devices *fs_devices,
+					      const struct btrfs_dev_lookup_args *args);
 int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
 int btrfs_balance(struct btrfs_fs_info *fs_info,
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7ada84e4a3ed1..880b565479a12 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1078,6 +1078,8 @@ enum btrfs_err_code {
 				       struct btrfs_ioctl_scrub_args)
 #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
 				 struct btrfs_ioctl_dev_info_args)
+#define BTRFS_IOC_DEV_INFO_NOSEED _IOR(BTRFS_IOCTL_MAGIC, 30, \
+				       struct btrfs_ioctl_dev_info_args)
 #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
 			       struct btrfs_ioctl_fs_info_args)
 #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
-- 
2.37.0

