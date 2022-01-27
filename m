Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8149EB6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 20:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbiA0T5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 14:57:20 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:54804 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245663AbiA0T5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 14:57:17 -0500
Received: from venice.bhome ([78.14.151.50])
        by santino.mail.tiscali.it with 
        id nvxE2600k15VSme01vxGqk; Thu, 27 Jan 2022 19:57:16 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/3] Rename btrfs_device->type to flags
Date:   Thu, 27 Jan 2022 20:57:07 +0100
Message-Id: <c927104a44592131b7752872f1ede98acd431e3d.1643313144.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643313144.git.kreijack@inwind.it>
References: <cover.1643313144.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643313436; bh=CAQPtjvqCWotgRYhnxRQ23RBAgwimGtz+gup4Fql+2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=SYbccM6KkzwOBZvjFN11ND/vLoMtHTQUTsCxbAftT1AQwcV7WOXKdFdHICnJo9rxd
         Bn2uFNO/taEOPolMJ59LuJfeSOcnDYjLJx0uIIS2eesAq962uQswchM7j6d1bksSw8
         Fw7so/bob6bFGPk/AgrxaGdg9CmjwtagJAV1lldQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

As did in the kernel, rename the device->type to device->flag.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/rescue-chunk-recover.c | 2 +-
 common/device-scan.c        | 4 ++--
 convert/common.c            | 2 +-
 image/main.c                | 6 +++---
 kernel-shared/ctree.h       | 8 ++++----
 kernel-shared/disk-io.c     | 2 +-
 kernel-shared/print-tree.c  | 4 ++--
 kernel-shared/volumes.c     | 6 +++---
 kernel-shared/volumes.h     | 4 ++--
 mkfs/common.c               | 2 +-
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index da24df4c..5d6c907b 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1187,7 +1187,7 @@ static int __rebuild_device_items(struct btrfs_trans_handle *trans,
 		key.offset = dev->devid;
 
 		btrfs_set_stack_device_generation(dev_item, 0);
-		btrfs_set_stack_device_type(dev_item, dev->type);
+		btrfs_set_stack_device_flags(dev_item, dev->flags);
 		btrfs_set_stack_device_id(dev_item, dev->devid);
 		btrfs_set_stack_device_total_bytes(dev_item, dev->total_bytes);
 		btrfs_set_stack_device_bytes_used(dev_item, dev->bytes_used);
diff --git a/common/device-scan.c b/common/device-scan.c
index 39b12c0e..d87172c9 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -155,7 +155,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	uuid_generate(device->uuid);
 	device->fs_info = fs_info;
 	device->devid = 0;
-	device->type = 0;
+	device->flags = 0;
 	device->io_width = io_width;
 	device->io_align = io_align;
 	device->sector_size = sectorsize;
@@ -193,7 +193,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 
 	btrfs_set_super_bytenr(disk_super, BTRFS_SUPER_INFO_OFFSET);
 	btrfs_set_stack_device_id(dev_item, device->devid);
-	btrfs_set_stack_device_type(dev_item, device->type);
+	btrfs_set_stack_device_flags(dev_item, device->flags);
 	btrfs_set_stack_device_io_align(dev_item, device->io_align);
 	btrfs_set_stack_device_io_width(dev_item, device->io_width);
 	btrfs_set_stack_device_sector_size(dev_item, device->sector_size);
diff --git a/convert/common.c b/convert/common.c
index 00a7e553..c73c3b62 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -336,7 +336,7 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
-	btrfs_set_device_type(buf, dev_item, 0);
+	btrfs_set_device_flags(buf, dev_item, 0);
 
 	/* Super dev_item is not complete, copy the complete one to sb */
 	read_extent_buffer(buf, &super.dev_item, (unsigned long)dev_item,
diff --git a/image/main.c b/image/main.c
index 3125163d..209bdd75 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2942,7 +2942,7 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 	struct btrfs_super_block disk_super;
 	char dev_uuid[BTRFS_UUID_SIZE];
 	char fs_uuid[BTRFS_UUID_SIZE];
-	u64 devid, type, io_align, io_width;
+	u64 devid, flags, io_align, io_width;
 	u64 sector_size, total_bytes, bytes_used;
 	int fp = -1;
 	int ret;
@@ -2972,7 +2972,7 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 		goto out;
 	}
 
-	type = btrfs_device_type(leaf, dev_item);
+	flags = btrfs_device_flags(leaf, dev_item);
 	io_align = btrfs_device_io_align(leaf, dev_item);
 	io_width = btrfs_device_io_width(leaf, dev_item);
 	sector_size = btrfs_device_sector_size(leaf, dev_item);
@@ -2997,7 +2997,7 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 
 	dev_item = &disk_super.dev_item;
 
-	btrfs_set_stack_device_type(dev_item, type);
+	btrfs_set_stack_device_flags(dev_item, flags);
 	btrfs_set_stack_device_id(dev_item, devid);
 	btrfs_set_stack_device_total_bytes(dev_item, total_bytes);
 	btrfs_set_stack_device_bytes_used(dev_item, bytes_used);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 628539c0..720ecbab 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -249,8 +249,8 @@ struct btrfs_dev_item {
 	/* minimal io size for this device */
 	__le32 sector_size;
 
-	/* type and info about this device */
-	__le64 type;
+	/* device flags (e.g. allocation hint) */
+	__le64 flags;
 
 	/* expected generation for this device */
 	__le64 generation;
@@ -1605,7 +1605,7 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 	s->member = cpu_to_le##bits(val);				\
 }
 
-BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_FUNCS(device_flags, struct btrfs_dev_item, flags, 64);
 BTRFS_SETGET_FUNCS(device_total_bytes, struct btrfs_dev_item, total_bytes, 64);
 BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
 BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
@@ -1619,7 +1619,7 @@ BTRFS_SETGET_FUNCS(device_seek_speed, struct btrfs_dev_item, seek_speed, 8);
 BTRFS_SETGET_FUNCS(device_bandwidth, struct btrfs_dev_item, bandwidth, 8);
 BTRFS_SETGET_FUNCS(device_generation, struct btrfs_dev_item, generation, 64);
 
-BTRFS_SETGET_STACK_FUNCS(stack_device_type, struct btrfs_dev_item, type, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_device_flags, struct btrfs_dev_item, flags, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_device_total_bytes, struct btrfs_dev_item,
 			 total_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_device_bytes_used, struct btrfs_dev_item,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index e9d945ec..1a9e797a 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2099,7 +2099,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info)
 			continue;
 
 		btrfs_set_stack_device_generation(dev_item, 0);
-		btrfs_set_stack_device_type(dev_item, dev->type);
+		btrfs_set_stack_device_flags(dev_item, dev->flags);
 		btrfs_set_stack_device_id(dev_item, dev->devid);
 		btrfs_set_stack_device_total_bytes(dev_item, dev->total_bytes);
 		btrfs_set_stack_device_bytes_used(dev_item, dev->bytes_used);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index bd75ae51..9bb0bd42 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -304,7 +304,7 @@ static void print_dev_item(struct extent_buffer *eb,
 	       btrfs_device_io_align(eb, dev_item),
 	       btrfs_device_io_width(eb, dev_item),
 	       btrfs_device_sector_size(eb, dev_item),
-	       (unsigned long long)btrfs_device_type(eb, dev_item),
+	       (unsigned long long)btrfs_device_flags(eb, dev_item),
 	       (unsigned long long)btrfs_device_generation(eb, dev_item),
 	       (unsigned long long)btrfs_device_start_offset(eb, dev_item),
 	       btrfs_device_group(eb, dev_item),
@@ -2052,7 +2052,7 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	       cmp_res ? "[match]" : "[DON'T MATCH]");
 
 	printf("dev_item.type\t\t%llu\n", (unsigned long long)
-	       btrfs_stack_device_type(&sb->dev_item));
+	       btrfs_stack_device_flags(&sb->dev_item));
 	printf("dev_item.total_bytes\t%llu\n", (unsigned long long)
 	       btrfs_stack_device_total_bytes(&sb->dev_item));
 	printf("dev_item.bytes_used\t%llu\n", (unsigned long long)
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 4274c378..82102723 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -992,7 +992,7 @@ int btrfs_add_device(struct btrfs_trans_handle *trans,
 	device->devid = free_devid;
 	btrfs_set_device_id(leaf, dev_item, device->devid);
 	btrfs_set_device_generation(leaf, dev_item, 0);
-	btrfs_set_device_type(leaf, dev_item, device->type);
+	btrfs_set_device_flags(leaf, dev_item, device->flags);
 	btrfs_set_device_io_align(leaf, dev_item, device->io_align);
 	btrfs_set_device_io_width(leaf, dev_item, device->io_width);
 	btrfs_set_device_sector_size(leaf, dev_item, device->sector_size);
@@ -1050,7 +1050,7 @@ int btrfs_update_device(struct btrfs_trans_handle *trans,
 	dev_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_item);
 
 	btrfs_set_device_id(leaf, dev_item, device->devid);
-	btrfs_set_device_type(leaf, dev_item, device->type);
+	btrfs_set_device_flags(leaf, dev_item, device->flags);
 	btrfs_set_device_io_align(leaf, dev_item, device->io_align);
 	btrfs_set_device_io_width(leaf, dev_item, device->io_width);
 	btrfs_set_device_sector_size(leaf, dev_item, device->sector_size);
@@ -2302,7 +2302,7 @@ static int fill_device_from_item(struct extent_buffer *leaf,
 	device->devid = btrfs_device_id(leaf, dev_item);
 	device->total_bytes = btrfs_device_total_bytes(leaf, dev_item);
 	device->bytes_used = btrfs_device_bytes_used(leaf, dev_item);
-	device->type = btrfs_device_type(leaf, dev_item);
+	device->flags = btrfs_device_flags(leaf, dev_item);
 	device->io_align = btrfs_device_io_align(leaf, dev_item);
 	device->io_width = btrfs_device_io_width(leaf, dev_item);
 	device->sector_size = btrfs_device_sector_size(leaf, dev_item);
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 5cfe7e39..1dd873c9 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -66,8 +66,8 @@ struct btrfs_device {
 	/* minimal io size for this device */
 	u32 sector_size;
 
-	/* type and info about this device */
-	u64 type;
+	/* device flags (e.g. allocation hint) */
+	u64 flags;
 
 	/* physical drive uuid (or lvm uuid) */
 	u8 uuid[BTRFS_UUID_SIZE];
diff --git a/mkfs/common.c b/mkfs/common.c
index 9608d27f..2ebba7f3 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -445,7 +445,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
-	btrfs_set_device_type(buf, dev_item, 0);
+	btrfs_set_device_flags(buf, dev_item, 0);
 
 	write_extent_buffer(buf, super.dev_item.uuid,
 			    (unsigned long)btrfs_device_uuid(dev_item),
-- 
2.34.1

