Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE396539F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Dec 2022 00:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLUX7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 18:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUX7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 18:59:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A2E0D0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 15:59:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3DEF5FCAA;
        Wed, 21 Dec 2022 23:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671667175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IQfzz8DGpEsIg1Y401AvIAOx9rE9v9Fy1ZdWB+9QG78=;
        b=WLLxo8Vvpk7DIqBkfp1wtP5KRM2PwoDnFQNg4+AprAUEI1bvDm+3RpXXpBX7JxzSBURj7S
        Jv56S1lm5v8RkvIRdN+1hFjVzvwNDMklIlG5JABkjt5kz3Be4RkyFj2R1/KGcMDgAh+jlR
        tcmWvFhhvvss/gbG2NyfIw3JO8CMaco=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C57791330B;
        Wed, 21 Dec 2022 23:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UTeUI+ado2PvdwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 21 Dec 2022 23:59:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chung-Chiang Cheng <shepjeng@gmail.com>
Subject: [PATCH v3] btrfs: fix compat_ro checks against remount
Date:   Thu, 22 Dec 2022 07:59:17 +0800
Message-Id: <e343fbf122d17f6d74e3630b197f7b344bbdaff1.1671667128.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
flags handling"), btrfs can still mount a fs with unsupported compat_ro
flags read-only, then remount it RW:

  # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
  compat_ro_flags		0x403
			( FREE_SPACE_TREE |
			  FREE_SPACE_TREE_VALID |
			  unknown flag: 0x400 )

  # mount /dev/loop0 /mnt/btrfs
  mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
         dmesg(1) may have more information after failed mount system call.
  ^^^ RW mount failed as expected ^^^

  # dmesg -t | tail -n5
  loop0: detected capacity change from 0 to 1048576
  BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 transid 7 /dev/loop0 scanned by mount (1146)
  BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
  BTRFS info (device loop0): using free space tree
  BTRFS error (device loop0): cannot mount read-write because of unknown compat_ro features (0x403)
  BTRFS error (device loop0): open_ctree failed

  # mount /dev/loop0 -o ro /mnt/btrfs
  # mount -o remount,rw /mnt/btrfs
  ^^^ RW remount succeeded unexpectedly ^^^

[CAUSE]
Currently we use btrfs_check_features() to check compat_ro flags against
our current mount flags.

That function get reused between open_ctree() and btrfs_remount().

But for btrfs_remount(), the super block we passed in still has the old
mount flags, thus btrfs_check_features() still believes we're mounting
read-only.

[FIX]
Replace the existing @sb argument with @is_rw_mount.

As originally we only use @sb to determine if the mount is RW.

Now it's callers' responsibility to determine if the mount is RW, and
since there are only two callers, the check is pretty simple:

- caller in open_ctree()
  Just pass !sb_rdonly().

- caller in btrfs_remount()
  Pass !(*flags & SB_RDONLY), as our check should be against the new
  flags.

Now we can correctly reject the RW remount:

  # mount /dev/loop0 -o ro /mnt/btrfs
  # mount -o remount,rw /mnt/btrfs
  mount: /mnt/btrfs: mount point not mounted or bad option.
         dmesg(1) may have more information after failed mount system call.
  # dmesg -t | tail -n 1
  BTRFS error (device loop0: state M): cannot mount read-write because of unknown compat_ro features (0x403)

Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags handling")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add a comment on why @rw_mount is calculated this way
  This will cover RW->RW and RW->RO remount cases, but since the
  fs is already RW, we should not has any unsupported compat_ro flags
  anyway.

v3:
- Use @is_rw_mount to replace @sb argument completely
  This should make the code easier to read and reduce the argument list.
---
 fs/btrfs/disk-io.c | 8 +++++---
 fs/btrfs/disk-io.h | 2 +-
 fs/btrfs/super.c   | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0888d484df80..8aa7d79a341a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3381,6 +3381,8 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 /*
  * Do various sanity and dependency checks of different features.
  *
+ * @is_rw_mount:	If the mount is read-write.
+ *
  * This is the place for less strict checks (like for subpage or artificial
  * feature dependencies).
  *
@@ -3391,7 +3393,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
  * (space cache related) can modify on-disk format like free space tree and
  * screw up certain feature dependencies.
  */
-int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
+int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 {
 	struct btrfs_super_block *disk_super = fs_info->super_copy;
 	u64 incompat = btrfs_super_incompat_flags(disk_super);
@@ -3430,7 +3432,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
 		incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
 
-	if (compat_ro_unsupp && !sb_rdonly(sb)) {
+	if (compat_ro_unsupp && is_rw_mount) {
 		btrfs_err(fs_info,
 	"cannot mount read-write because of unknown compat_ro features (0x%llx)",
 		       compat_ro);
@@ -3633,7 +3635,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
-	ret = btrfs_check_features(fs_info, sb);
+	ret = btrfs_check_features(fs_info, !sb_rdonly(sb));
 	if (ret < 0) {
 		err = ret;
 		goto fail_alloc;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 363935cfc084..f2f295eb6103 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -50,7 +50,7 @@ int __cold open_ctree(struct super_block *sb,
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 			 struct btrfs_super_block *sb, int mirror_num);
-int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb);
+int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
 struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
 struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d5de18d6517e..433ce221dc5c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	if (ret)
 		goto restore;
 
-	ret = btrfs_check_features(fs_info, sb);
+	ret = btrfs_check_features(fs_info, !(*flags & SB_RDONLY));
 	if (ret < 0)
 		goto restore;
 
-- 
2.39.0

