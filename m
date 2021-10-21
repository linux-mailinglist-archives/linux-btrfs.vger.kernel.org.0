Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCFA43585B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 03:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJUBnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 21:43:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40624 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhJUBm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 21:42:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27D321FDA2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634780441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZuTXjxbwhFXkyQWLLeYKgz0aFkTVsz5iLeIN01D0O28=;
        b=acnMlrCZkPgRgJGQLNvhllMdzgaf21FVGnUvEUXJCInwkGDj3Rk8L1KjpQ8txXebwdabpo
        lFzuok5MhP0/H23BKzKO4BYnFAb/W4oXxAeQgO8PC1nUzPK6qrFmmfoBHIuYKxmuQKscbS
        DdXarUIOTdZQOoJnxXTBa5gW/K0dpRM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68C0413F8A
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mD5eDBjFcGFYIQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: remove temporary buffer for super block
Date:   Thu, 21 Oct 2021 09:40:19 +0800
Message-Id: <20211021014020.482242-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211021014020.482242-1-wqu@suse.com>
References: <20211021014020.482242-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are a lot of call sites where we use the following code snippet:

	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
	struct btrfs_super_block *sb;
	u64 ret;

	sb = (struct btrfs_super_block *)super_block_data;

The reason for this is, structure btrfs_super_block was smaller than
BTRFS_SUPER_INFO_SIZE.

Thus for anything with csum involved, we have to use a proper 4K buffer.

Since the recent unification of sizeof(struct btrfs_super_block), we no
longer needs such workaround, and can use struct btrfs_super_block
directly to do any operation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem-usage.c     |  8 ++--
 cmds/inspect-dump-super.c   | 11 ++----
 cmds/rescue-chunk-recover.c | 20 +++++-----
 cmds/rescue-super-recover.c | 11 +++---
 common/device-scan.c        | 23 ++++-------
 common/utils.c              |  8 ++--
 convert/common.c            | 79 +++++++++++++++++--------------------
 convert/main.c              | 29 ++++++--------
 image/main.c                | 14 +++----
 kernel-shared/disk-io.c     | 35 ++++++++--------
 kernel-shared/volumes.c     | 14 +++----
 mkfs/common.c               |  8 ++--
 12 files changed, 112 insertions(+), 148 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 7f810cd0c5ac..1ba48fafce0d 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -668,8 +668,7 @@ static int cmp_device_info(const void *a, const void *b)
 
 int dev_to_fsid(const char *dev, u8 *fsid)
 {
-	struct btrfs_super_block *disk_super;
-	char buf[BTRFS_SUPER_INFO_SIZE];
+	struct btrfs_super_block disk_super;
 	int ret;
 	int fd;
 
@@ -679,13 +678,12 @@ int dev_to_fsid(const char *dev, u8 *fsid)
 		return ret;
 	}
 
-	disk_super = (struct btrfs_super_block *)buf;
-	ret = btrfs_read_dev_super(fd, disk_super,
+	ret = btrfs_read_dev_super(fd, &disk_super,
 				   BTRFS_SUPER_INFO_OFFSET, SBREAD_DEFAULT);
 	if (ret)
 		goto out;
 
-	memcpy(fsid, disk_super->fsid, BTRFS_FSID_SIZE);
+	memcpy(fsid, disk_super.fsid, BTRFS_FSID_SIZE);
 	ret = 0;
 
 out:
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 04e81d8c3b60..d8435624df90 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -33,13 +33,10 @@
 static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		int force)
 {
-	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
-	struct btrfs_super_block *sb;
+	struct btrfs_super_block sb;
 	u64 ret;
 
-	sb = (struct btrfs_super_block *)super_block_data;
-
-	ret = sbread(fd, super_block_data, sb_bytenr);
+	ret = sbread(fd, &sb, sb_bytenr);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		/* check if the disk if too short for further superblock */
 		if (ret == 0 && errno == 0)
@@ -52,11 +49,11 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 	}
 	printf("superblock: bytenr=%llu, device=%s\n", sb_bytenr, filename);
 	printf("---------------------------------------------------------\n");
-	if (btrfs_super_magic(sb) != BTRFS_MAGIC && !force) {
+	if (btrfs_super_magic(&sb) != BTRFS_MAGIC && !force) {
 		error("bad magic on superblock on %s at %llu",
 				filename, (unsigned long long)sb_bytenr);
 	} else {
-		btrfs_print_superblock(sb, full);
+		btrfs_print_superblock(&sb, full);
 	}
 	return 0;
 }
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index cdf0fe1864cd..35c6f66548fd 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1506,8 +1506,7 @@ static int recover_prepare(struct recover_control *rc, const char *path)
 {
 	int ret;
 	int fd;
-	struct btrfs_super_block *sb;
-	char buf[BTRFS_SUPER_INFO_SIZE];
+	struct btrfs_super_block sb;
 	struct btrfs_fs_devices *fs_devices;
 
 	ret = 0;
@@ -1517,23 +1516,22 @@ static int recover_prepare(struct recover_control *rc, const char *path)
 		return -1;
 	}
 
-	sb = (struct btrfs_super_block*)buf;
-	ret = btrfs_read_dev_super(fd, sb, BTRFS_SUPER_INFO_OFFSET,
+	ret = btrfs_read_dev_super(fd, &sb, BTRFS_SUPER_INFO_OFFSET,
 			SBREAD_RECOVER);
 	if (ret) {
 		fprintf(stderr, "read super block error\n");
 		goto out_close_fd;
 	}
 
-	rc->sectorsize = btrfs_super_sectorsize(sb);
-	rc->nodesize = btrfs_super_nodesize(sb);
-	rc->generation = btrfs_super_generation(sb);
-	rc->chunk_root_generation = btrfs_super_chunk_root_generation(sb);
-	rc->csum_size = btrfs_super_csum_size(sb);
-	rc->csum_type = btrfs_super_csum_type(sb);
+	rc->sectorsize = btrfs_super_sectorsize(&sb);
+	rc->nodesize = btrfs_super_nodesize(&sb);
+	rc->generation = btrfs_super_generation(&sb);
+	rc->chunk_root_generation = btrfs_super_chunk_root_generation(&sb);
+	rc->csum_size = btrfs_super_csum_size(&sb);
+	rc->csum_type = btrfs_super_csum_type(&sb);
 
 	/* if seed, the result of scanning below will be partial */
-	if (btrfs_super_flags(sb) & BTRFS_SUPER_FLAG_SEEDING) {
+	if (btrfs_super_flags(&sb) & BTRFS_SUPER_FLAG_SEEDING) {
 		fprintf(stderr, "this device is seed device\n");
 		ret = -1;
 		goto out_close_fd;
diff --git a/cmds/rescue-super-recover.c b/cmds/rescue-super-recover.c
index 1eaa87298b2e..d78f5052f076 100644
--- a/cmds/rescue-super-recover.c
+++ b/cmds/rescue-super-recover.c
@@ -114,9 +114,8 @@ static int
 read_dev_supers(char *filename, struct btrfs_recover_superblock *recover)
 {
 	int i, ret, fd;
-	u8 buf[BTRFS_SUPER_INFO_SIZE];
 	u64 max_gen, bytenr;
-	struct btrfs_super_block *sb = (struct btrfs_super_block *)buf;
+	struct btrfs_super_block sb;
 
 	/* just ignore errno that were set in btrfs_scan_fs_devices() */
 	errno = 0;
@@ -128,13 +127,13 @@ read_dev_supers(char *filename, struct btrfs_recover_superblock *recover)
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
 
-		ret = btrfs_read_dev_super(fd, sb, bytenr, SBREAD_DEFAULT);
+		ret = btrfs_read_dev_super(fd, &sb, bytenr, SBREAD_DEFAULT);
 		if (!ret) {
-			ret = add_superblock_record(sb, filename, bytenr,
+			ret = add_superblock_record(&sb, filename, bytenr,
 							&recover->good_supers);
 			if (ret)
 				goto out;
-			max_gen = btrfs_super_generation(sb);
+			max_gen = btrfs_super_generation(&sb);
 			if (max_gen > recover->max_generation)
 				recover->max_generation = max_gen;
 		} else if (ret != -ENOENT){
@@ -142,7 +141,7 @@ read_dev_supers(char *filename, struct btrfs_recover_superblock *recover)
 			 * Skip superblock which doesn't exist, only adds
 			 * really corrupted superblock
 			 */
-			ret = add_superblock_record(sb, filename, bytenr,
+			ret = add_superblock_record(&sb, filename, bytenr,
 						&recover->bad_supers);
 			if (ret)
 				goto out;
diff --git a/common/device-scan.c b/common/device-scan.c
index 4c54ee3b7254..39b12c0e02c4 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -269,34 +269,25 @@ int btrfs_register_all_devices(void)
 int btrfs_device_already_in_root(struct btrfs_root *root, int fd,
 				 int super_offset)
 {
-	struct btrfs_super_block *disk_super;
-	char *buf;
+	struct btrfs_super_block disk_super;
 	int ret = 0;
 
-	buf = malloc(BTRFS_SUPER_INFO_SIZE);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	ret = sbread(fd, buf, super_offset);
+	ret = sbread(fd, &disk_super, super_offset);
 	if (ret != BTRFS_SUPER_INFO_SIZE)
-		goto brelse;
+		goto out;
 
 	ret = 0;
-	disk_super = (struct btrfs_super_block *)buf;
 	/*
 	 * Accept devices from the same filesystem, allow partially created
 	 * structures.
 	 */
-	if (btrfs_super_magic(disk_super) != BTRFS_MAGIC &&
-			btrfs_super_magic(disk_super) != BTRFS_MAGIC_TEMPORARY)
-		goto brelse;
+	if (btrfs_super_magic(&disk_super) != BTRFS_MAGIC &&
+			btrfs_super_magic(&disk_super) != BTRFS_MAGIC_TEMPORARY)
+		goto out;
 
-	if (!memcmp(disk_super->fsid, root->fs_info->super_copy->fsid,
+	if (!memcmp(disk_super.fsid, root->fs_info->super_copy->fsid,
 		    BTRFS_FSID_SIZE))
 		ret = 1;
-brelse:
-	free(buf);
 out:
 	return ret;
 }
diff --git a/common/utils.c b/common/utils.c
index aee0eedc15fc..d81e79144790 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -438,8 +438,7 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 	memset(fi_args, 0, sizeof(*fi_args));
 
 	if (path_is_block_device(path) == 1) {
-		struct btrfs_super_block *disk_super;
-		char buf[BTRFS_SUPER_INFO_SIZE];
+		struct btrfs_super_block disk_super;
 
 		/* Ensure it's mounted, then set path to the mountpoint */
 		fd = open(path, O_RDONLY);
@@ -460,14 +459,13 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 		/* Only fill in this one device */
 		fi_args->num_devices = 1;
 
-		disk_super = (struct btrfs_super_block *)buf;
-		ret = btrfs_read_dev_super(fd, disk_super,
+		ret = btrfs_read_dev_super(fd, &disk_super,
 					   BTRFS_SUPER_INFO_OFFSET, 0);
 		if (ret < 0) {
 			ret = -EIO;
 			goto out;
 		}
-		last_devid = btrfs_stack_device_id(&disk_super->dev_item);
+		last_devid = btrfs_stack_device_id(&disk_super.dev_item);
 		fi_args->max_id = last_devid;
 
 		memcpy(fi_args->fsid, fs_devices_mnt->fsid, BTRFS_FSID_SIZE);
diff --git a/convert/common.c b/convert/common.c
index 5e7a1d6bea5a..00a7e55361b8 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -91,15 +91,13 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 			    u64 root_bytenr, u64 chunk_bytenr)
 {
 	unsigned char chunk_uuid[BTRFS_UUID_SIZE];
-	char super_buf[BTRFS_SUPER_INFO_SIZE];
-	struct btrfs_super_block *super = (struct btrfs_super_block *)super_buf;
+	struct btrfs_super_block super = {};
 	int ret;
 
-	memset(super_buf, 0, BTRFS_SUPER_INFO_SIZE);
 	cfg->num_bytes = round_down(cfg->num_bytes, cfg->sectorsize);
 
 	if (*cfg->fs_uuid) {
-		if (uuid_parse(cfg->fs_uuid, super->fsid) != 0) {
+		if (uuid_parse(cfg->fs_uuid, super.fsid) != 0) {
 			error("could not parse UUID: %s", cfg->fs_uuid);
 			ret = -EINVAL;
 			goto out;
@@ -108,43 +106,43 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 		 * Caller should make sure the uuid is either unique or OK to
 		 * be duplicate in case it's copied from the source filesystem.
 		 */
-		uuid_copy(super->metadata_uuid, super->fsid);
+		uuid_copy(super.metadata_uuid, super.fsid);
 	} else {
-		uuid_generate(super->fsid);
-		uuid_unparse(super->fsid, cfg->fs_uuid);
-		uuid_copy(super->metadata_uuid, super->fsid);
+		uuid_generate(super.fsid);
+		uuid_unparse(super.fsid, cfg->fs_uuid);
+		uuid_copy(super.metadata_uuid, super.fsid);
 	}
 	uuid_generate(chunk_uuid);
 	uuid_unparse(chunk_uuid, cfg->chunk_uuid);
 
-	btrfs_set_super_bytenr(super, cfg->super_bytenr);
-	btrfs_set_super_num_devices(super, 1);
-	btrfs_set_super_magic(super, BTRFS_MAGIC_TEMPORARY);
-	btrfs_set_super_generation(super, 1);
-	btrfs_set_super_root(super, root_bytenr);
-	btrfs_set_super_chunk_root(super, chunk_bytenr);
-	btrfs_set_super_total_bytes(super, cfg->num_bytes);
+	btrfs_set_super_bytenr(&super, cfg->super_bytenr);
+	btrfs_set_super_num_devices(&super, 1);
+	btrfs_set_super_magic(&super, BTRFS_MAGIC_TEMPORARY);
+	btrfs_set_super_generation(&super, 1);
+	btrfs_set_super_root(&super, root_bytenr);
+	btrfs_set_super_chunk_root(&super, chunk_bytenr);
+	btrfs_set_super_total_bytes(&super, cfg->num_bytes);
 	/*
 	 * Temporary filesystem will only have 6 tree roots:
 	 * chunk tree, root tree, extent_tree, device tree, fs tree
 	 * and csum tree.
 	 */
-	btrfs_set_super_bytes_used(super, 6 * cfg->nodesize);
-	btrfs_set_super_sectorsize(super, cfg->sectorsize);
-	super->__unused_leafsize = cpu_to_le32(cfg->nodesize);
-	btrfs_set_super_nodesize(super, cfg->nodesize);
-	btrfs_set_super_stripesize(super, cfg->stripesize);
-	btrfs_set_super_csum_type(super, cfg->csum_type);
-	btrfs_set_super_chunk_root(super, chunk_bytenr);
-	btrfs_set_super_cache_generation(super, -1);
-	btrfs_set_super_incompat_flags(super, cfg->features);
+	btrfs_set_super_bytes_used(&super, 6 * cfg->nodesize);
+	btrfs_set_super_sectorsize(&super, cfg->sectorsize);
+	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
+	btrfs_set_super_nodesize(&super, cfg->nodesize);
+	btrfs_set_super_stripesize(&super, cfg->stripesize);
+	btrfs_set_super_csum_type(&super, cfg->csum_type);
+	btrfs_set_super_chunk_root(&super, chunk_bytenr);
+	btrfs_set_super_cache_generation(&super, -1);
+	btrfs_set_super_incompat_flags(&super, cfg->features);
 	if (cfg->label)
-		__strncpy_null(super->label, cfg->label, BTRFS_LABEL_SIZE - 1);
+		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
 
 	/* Sys chunk array will be re-initialized at chunk tree init time */
-	super->sys_chunk_array_size = 0;
+	super.sys_chunk_array_size = 0;
 
-	ret = write_temp_super(fd, super, cfg->super_bytenr);
+	ret = write_temp_super(fd, &super, cfg->super_bytenr);
 out:
 	return ret;
 }
@@ -295,13 +293,12 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 {
 	struct btrfs_disk_key disk_key;
 	struct btrfs_dev_item *dev_item;
-	char super_buf[BTRFS_SUPER_INFO_SIZE];
 	unsigned char dev_uuid[BTRFS_UUID_SIZE];
 	unsigned char fsid[BTRFS_FSID_SIZE];
-	struct btrfs_super_block *super = (struct btrfs_super_block *)super_buf;
+	struct btrfs_super_block super;
 	int ret;
 
-	ret = pread(fd, super_buf, BTRFS_SUPER_INFO_SIZE, cfg->super_bytenr);
+	ret = pread(fd, &super, BTRFS_SUPER_INFO_SIZE, cfg->super_bytenr);
 	if (ret < BTRFS_SUPER_INFO_SIZE) {
 		ret = (ret < 0 ? -errno : -EIO);
 		goto out;
@@ -342,9 +339,9 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 	btrfs_set_device_type(buf, dev_item, 0);
 
 	/* Super dev_item is not complete, copy the complete one to sb */
-	read_extent_buffer(buf, &super->dev_item, (unsigned long)dev_item,
+	read_extent_buffer(buf, &super.dev_item, (unsigned long)dev_item,
 			   sizeof(*dev_item));
-	ret = write_temp_super(fd, super, cfg->super_bytenr);
+	ret = write_temp_super(fd, &super, cfg->super_bytenr);
 	(*slot)++;
 out:
 	return ret;
@@ -357,12 +354,10 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 {
 	struct btrfs_chunk *chunk;
 	struct btrfs_disk_key disk_key;
-	char super_buf[BTRFS_SUPER_INFO_SIZE];
-	struct btrfs_super_block *sb = (struct btrfs_super_block *)super_buf;
+	struct btrfs_super_block sb;
 	int ret = 0;
 
-	ret = pread(fd, super_buf, BTRFS_SUPER_INFO_SIZE,
-		    cfg->super_bytenr);
+	ret = pread(fd, &sb, BTRFS_SUPER_INFO_SIZE, cfg->super_bytenr);
 	if (ret < BTRFS_SUPER_INFO_SIZE) {
 		ret = (ret < 0 ? ret : -EIO);
 		return ret;
@@ -391,7 +386,7 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 	btrfs_set_stripe_devid_nr(buf, chunk, 0, 1);
 	/* We are doing 1:1 mapping, so start is its dev offset */
 	btrfs_set_stripe_offset_nr(buf, chunk, 0, start);
-	write_extent_buffer(buf, &sb->dev_item.uuid,
+	write_extent_buffer(buf, sb.dev_item.uuid,
 			    (unsigned long)btrfs_stripe_dev_uuid_nr(chunk, 0),
 			    BTRFS_UUID_SIZE);
 	(*slot)++;
@@ -403,18 +398,18 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 		char *cur;
 		u32 array_size;
 
-		cur = (char *)sb->sys_chunk_array
-			+ btrfs_super_sys_array_size(sb);
+		cur = (char *)sb.sys_chunk_array
+			+ btrfs_super_sys_array_size(&sb);
 		memcpy(cur, &disk_key, sizeof(disk_key));
 		cur += sizeof(disk_key);
 		read_extent_buffer(buf, cur, (unsigned long int)chunk,
 				   btrfs_chunk_item_size(1));
-		array_size = btrfs_super_sys_array_size(sb);
+		array_size = btrfs_super_sys_array_size(&sb);
 		array_size += btrfs_chunk_item_size(1) +
 					    sizeof(disk_key);
-		btrfs_set_super_sys_array_size(sb, array_size);
+		btrfs_set_super_sys_array_size(&sb, array_size);
 
-		ret = write_temp_super(fd, sb, cfg->super_bytenr);
+		ret = write_temp_super(fd, &sb, cfg->super_bytenr);
 	}
 	return ret;
 }
diff --git a/convert/main.c b/convert/main.c
index 223eebad2e72..ccfa826ed0d5 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1066,27 +1066,23 @@ err:
 static int migrate_super_block(int fd, u64 old_bytenr)
 {
 	int ret;
-	struct extent_buffer *buf;
-	struct btrfs_super_block *super;
+	struct btrfs_super_block super;
+	u8 result[BTRFS_CSUM_SIZE] = {};
 	u32 len;
 	u32 bytenr;
 
-	buf = malloc(sizeof(*buf) + BTRFS_SUPER_INFO_SIZE);
-	if (!buf)
-		return -ENOMEM;
-
-	buf->len = BTRFS_SUPER_INFO_SIZE;
-	ret = pread(fd, buf->data, BTRFS_SUPER_INFO_SIZE, old_bytenr);
+	ret = pread(fd, &super, BTRFS_SUPER_INFO_SIZE, old_bytenr);
 	if (ret != BTRFS_SUPER_INFO_SIZE)
 		goto fail;
 
-	super = (struct btrfs_super_block *)buf->data;
-	BUG_ON(btrfs_super_bytenr(super) != old_bytenr);
-	btrfs_set_super_bytenr(super, BTRFS_SUPER_INFO_OFFSET);
+	BUG_ON(btrfs_super_bytenr(&super) != old_bytenr);
+	btrfs_set_super_bytenr(&super, BTRFS_SUPER_INFO_OFFSET);
 
-	csum_tree_block_size(buf, btrfs_super_csum_size(super),
-			     0, btrfs_super_csum_type(super));
-	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
+	btrfs_csum_data(NULL, btrfs_super_csum_type(&super),
+			(u8 *)&super + BTRFS_CSUM_SIZE, result,
+			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+	memcpy(&super.csum[0], result, BTRFS_CSUM_SIZE);
+	ret = pwrite(fd, &super , BTRFS_SUPER_INFO_SIZE,
 		BTRFS_SUPER_INFO_OFFSET);
 	if (ret != BTRFS_SUPER_INFO_SIZE)
 		goto fail;
@@ -1095,12 +1091,12 @@ static int migrate_super_block(int fd, u64 old_bytenr)
 	if (ret)
 		goto fail;
 
-	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
+	memset(&super, 0, BTRFS_SUPER_INFO_SIZE);
 	for (bytenr = 0; bytenr < BTRFS_SUPER_INFO_OFFSET; ) {
 		len = BTRFS_SUPER_INFO_OFFSET - bytenr;
 		if (len > BTRFS_SUPER_INFO_SIZE)
 			len = BTRFS_SUPER_INFO_SIZE;
-		ret = pwrite(fd, buf->data, len, bytenr);
+		ret = pwrite(fd, &super, len, bytenr);
 		if (ret != len) {
 			fprintf(stderr, "unable to zero fill device\n");
 			break;
@@ -1110,7 +1106,6 @@ static int migrate_super_block(int fd, u64 old_bytenr)
 	ret = 0;
 	fsync(fd);
 fail:
-	free(buf);
 	if (ret > 0)
 		ret = -1;
 	return ret;
diff --git a/image/main.c b/image/main.c
index b40e0e5550f8..8929e94cb6e6 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2927,12 +2927,11 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 	struct extent_buffer *leaf;
 	struct btrfs_path path;
 	struct btrfs_dev_item *dev_item;
-	struct btrfs_super_block *disk_super;
+	struct btrfs_super_block disk_super;
 	char dev_uuid[BTRFS_UUID_SIZE];
 	char fs_uuid[BTRFS_UUID_SIZE];
 	u64 devid, type, io_align, io_width;
 	u64 sector_size, total_bytes, bytes_used;
-	char buf[BTRFS_SUPER_INFO_SIZE];
 	int fp = -1;
 	int ret;
 
@@ -2982,10 +2981,9 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 		goto out;
 	}
 
-	memcpy(buf, info->super_copy, BTRFS_SUPER_INFO_SIZE);
+	memcpy(&disk_super, info->super_copy, BTRFS_SUPER_INFO_SIZE);
 
-	disk_super = (struct btrfs_super_block *)buf;
-	dev_item = &disk_super->dev_item;
+	dev_item = &disk_super.dev_item;
 
 	btrfs_set_stack_device_type(dev_item, type);
 	btrfs_set_stack_device_id(dev_item, devid);
@@ -2996,9 +2994,9 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 	btrfs_set_stack_device_sector_size(dev_item, sector_size);
 	memcpy(dev_item->uuid, dev_uuid, BTRFS_UUID_SIZE);
 	memcpy(dev_item->fsid, fs_uuid, BTRFS_UUID_SIZE);
-	csum_block((u8 *)buf, BTRFS_SUPER_INFO_SIZE);
+	csum_block((u8 *)&disk_super, BTRFS_SUPER_INFO_SIZE);
 
-	ret = pwrite64(fp, buf, BTRFS_SUPER_INFO_SIZE, BTRFS_SUPER_INFO_OFFSET);
+	ret = pwrite64(fp, &disk_super, BTRFS_SUPER_INFO_SIZE, BTRFS_SUPER_INFO_OFFSET);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		if (ret < 0) {
 			errno = ret;
@@ -3010,7 +3008,7 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 		goto out;
 	}
 
-	write_backup_supers(fp, (u8 *)buf);
+	write_backup_supers(fp, (u8 *)&disk_super);
 
 out:
 	if (fp != -1)
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3b3c4523e65e..30f16f4da126 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1619,8 +1619,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 	u8 fsid[BTRFS_FSID_SIZE];
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 	int fsid_is_initialized = 0;
-	char tmp[BTRFS_SUPER_INFO_SIZE];
-	struct btrfs_super_block *buf = (struct btrfs_super_block *)tmp;
+	struct btrfs_super_block buf;
 	int i;
 	int ret;
 	int max_super = sbflags & SBREAD_RECOVER ? BTRFS_SUPER_MIRROR_MAX : 1;
@@ -1629,7 +1628,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 	u64 bytenr;
 
 	if (sb_bytenr != BTRFS_SUPER_INFO_OFFSET) {
-		ret = sbread(fd, buf, sb_bytenr);
+		ret = sbread(fd, &buf, sb_bytenr);
 		/* real error */
 		if (ret < 0)
 			return -errno;
@@ -1638,13 +1637,13 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 		if (ret < BTRFS_SUPER_INFO_SIZE)
 			return -ENOENT;
 
-		if (btrfs_super_bytenr(buf) != sb_bytenr)
+		if (btrfs_super_bytenr(&buf) != sb_bytenr)
 			return -EIO;
 
-		ret = btrfs_check_super(buf, sbflags);
+		ret = btrfs_check_super(&buf, sbflags);
 		if (ret < 0)
 			return ret;
-		memcpy(sb, buf, BTRFS_SUPER_INFO_SIZE);
+		memcpy(sb, &buf, BTRFS_SUPER_INFO_SIZE);
 		return 0;
 	}
 
@@ -1657,31 +1656,31 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 
 	for (i = 0; i < max_super; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = sbread(fd, buf, bytenr);
+		ret = sbread(fd, &buf, bytenr);
 
 		if (ret < BTRFS_SUPER_INFO_SIZE)
 			break;
 
-		if (btrfs_super_bytenr(buf) != bytenr )
+		if (btrfs_super_bytenr(&buf) != bytenr )
 			continue;
 		/* if magic is NULL, the device was removed */
-		if (btrfs_super_magic(buf) == 0 && i == 0)
+		if (btrfs_super_magic(&buf) == 0 && i == 0)
 			break;
-		if (btrfs_check_super(buf, sbflags))
+		if (btrfs_check_super(&buf, sbflags))
 			continue;
 
 		if (!fsid_is_initialized) {
-			if (btrfs_super_incompat_flags(buf) &
+			if (btrfs_super_incompat_flags(&buf) &
 			    BTRFS_FEATURE_INCOMPAT_METADATA_UUID) {
 				metadata_uuid_set = true;
-				memcpy(metadata_uuid, buf->metadata_uuid,
+				memcpy(metadata_uuid, buf.metadata_uuid,
 				       sizeof(metadata_uuid));
 			}
-			memcpy(fsid, buf->fsid, sizeof(fsid));
+			memcpy(fsid, buf.fsid, sizeof(fsid));
 			fsid_is_initialized = 1;
-		} else if (memcmp(fsid, buf->fsid, sizeof(fsid)) ||
+		} else if (memcmp(fsid, buf.fsid, sizeof(fsid)) ||
 			   (metadata_uuid_set && memcmp(metadata_uuid,
-							buf->metadata_uuid,
+							buf.metadata_uuid,
 							sizeof(metadata_uuid)))) {
 			/*
 			 * the superblocks (the original one and
@@ -1691,9 +1690,9 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 			continue;
 		}
 
-		if (btrfs_super_generation(buf) > transid) {
-			memcpy(sb, buf, BTRFS_SUPER_INFO_SIZE);
-			transid = btrfs_super_generation(buf);
+		if (btrfs_super_generation(&buf) > transid) {
+			memcpy(sb, &buf, BTRFS_SUPER_INFO_SIZE);
+			transid = btrfs_super_generation(&buf);
 		}
 	}
 
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 6c1e6f1018a3..de3a95d0c2e5 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -528,22 +528,20 @@ int btrfs_scan_one_device(int fd, const char *path,
 			  struct btrfs_fs_devices **fs_devices_ret,
 			  u64 *total_devs, u64 super_offset, unsigned sbflags)
 {
-	struct btrfs_super_block *disk_super;
-	char buf[BTRFS_SUPER_INFO_SIZE];
+	struct btrfs_super_block disk_super;
 	int ret;
 	u64 devid;
 
-	disk_super = (struct btrfs_super_block *)buf;
-	ret = btrfs_read_dev_super(fd, disk_super, super_offset, sbflags);
+	ret = btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags);
 	if (ret < 0)
 		return -EIO;
-	devid = btrfs_stack_device_id(&disk_super->dev_item);
-	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_METADUMP)
+	devid = btrfs_stack_device_id(&disk_super.dev_item);
+	if (btrfs_super_flags(&disk_super) & BTRFS_SUPER_FLAG_METADUMP)
 		*total_devs = 1;
 	else
-		*total_devs = btrfs_super_num_devices(disk_super);
+		*total_devs = btrfs_super_num_devices(&disk_super);
 
-	ret = device_list_add(path, disk_super, devid, fs_devices_ret);
+	ret = device_list_add(path, &disk_super, devid, fs_devices_ret);
 
 	return ret;
 }
diff --git a/mkfs/common.c b/mkfs/common.c
index 5c8d6ac13a3b..0a1fda2ac72e 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -804,19 +804,17 @@ static int check_btrfs_signature_zoned(const char *device)
 {
 	int fd;
 	int ret;
-	char buf[BTRFS_SUPER_INFO_SIZE];
-	struct btrfs_super_block *sb;
+	struct btrfs_super_block sb;
 
 	fd = open(device, O_RDONLY);
 	if (fd < 0)
 		return -1;
-	ret = pread(fd, buf, BTRFS_SUPER_INFO_SIZE, 0);
+	ret = pread(fd, &sb, BTRFS_SUPER_INFO_SIZE, 0);
 	if (ret < 0) {
 		ret = -1;
 		goto out;
 	}
-	sb = (struct btrfs_super_block *)buf;
-	if (btrfs_super_magic(sb) == BTRFS_MAGIC)
+	if (btrfs_super_magic(&sb) == BTRFS_MAGIC)
 		ret = 1;
 	else
 		ret = 0;
-- 
2.33.0

