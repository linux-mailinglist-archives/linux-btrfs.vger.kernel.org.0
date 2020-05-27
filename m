Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0DE1E3EF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbgE0K2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:28:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:44544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387899AbgE0K2W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:28:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1D341ABE3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:28:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs-progs: print-tree: Export dump_superblock()
Date:   Wed, 27 May 2020 18:28:06 +0800
Message-Id: <20200527102810.147999-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527102810.147999-1-wqu@suse.com>
References: <20200527102810.147999-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

dump_superblock() is useful to debug btrfs-image error, like fsck/012-*
test case, where the superblock itself has something wrong from the
original image.

Export it so that we can call it in gdb.

Since we're exporting dump_superblock(), rename it to
btrfs_print_superblock() to following the existing naming schema.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect-dump-super.c | 454 +-------------------------------------
 print-tree.c              | 447 +++++++++++++++++++++++++++++++++++++
 print-tree.h              |   1 +
 3 files changed, 449 insertions(+), 453 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index f22633b99390..729af84cc93d 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -16,471 +16,19 @@
 
 #include "kerncompat.h"
 #include <stdio.h>
-#include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/stat.h>
-#include <ctype.h>
-#include <uuid/uuid.h>
 #include <errno.h>
 #include <getopt.h>
 
 #include "ctree.h"
 #include "disk-io.h"
 #include "print-tree.h"
-#include "transaction.h"
-#include "kernel-lib/list.h"
 #include "common/utils.h"
 #include "cmds/commands.h"
-#include "crypto/crc32c.h"
 #include "common/help.h"
 
-static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
-{
-	u8 result[BTRFS_CSUM_SIZE];
-
-	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
-			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-
-	return !memcmp(sb, result, csum_size);
-}
-
-static void print_sys_chunk_array(struct btrfs_super_block *sb)
-{
-	struct extent_buffer *buf;
-	struct btrfs_disk_key *disk_key;
-	struct btrfs_chunk *chunk;
-	u8 *array_ptr;
-	unsigned long sb_array_offset;
-	u32 num_stripes;
-	u32 array_size;
-	u32 len = 0;
-	u32 cur_offset;
-	struct btrfs_key key;
-	int item;
-
-	buf = malloc(sizeof(*buf) + sizeof(*sb));
-	if (!buf) {
-		error("not enough memory");
-		return;
-	}
-	write_extent_buffer(buf, sb, 0, sizeof(*sb));
-	buf->len = sizeof(*sb);
-	array_size = btrfs_super_sys_array_size(sb);
-
-	array_ptr = sb->sys_chunk_array;
-	sb_array_offset = offsetof(struct btrfs_super_block, sys_chunk_array);
-
-	if (array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
-		error("sys_array_size %u shouldn't exceed %u bytes",
-				array_size, BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
-		goto out;
-	}
-
-	cur_offset = 0;
-	item = 0;
-
-	while (cur_offset < array_size) {
-		disk_key = (struct btrfs_disk_key *)array_ptr;
-		len = sizeof(*disk_key);
-		if (cur_offset + len > array_size)
-			goto out_short_read;
-
-		btrfs_disk_key_to_cpu(&key, disk_key);
-
-		array_ptr += len;
-		sb_array_offset += len;
-		cur_offset += len;
-
-		printf("\titem %d ", item);
-		btrfs_print_key(disk_key);
-		putchar('\n');
-
-		if (key.type == BTRFS_CHUNK_ITEM_KEY) {
-			chunk = (struct btrfs_chunk *)sb_array_offset;
-			/*
-			 * At least one btrfs_chunk with one stripe must be
-			 * present, exact stripe count check comes afterwards
-			 */
-			len = btrfs_chunk_item_size(1);
-			if (cur_offset + len > array_size)
-				goto out_short_read;
-
-			num_stripes = btrfs_chunk_num_stripes(buf, chunk);
-			if (!num_stripes) {
-				error(
-			"invalid number of stripes %u in sys_array at offset %u",
-					num_stripes, cur_offset);
-				break;
-			}
-			len = btrfs_chunk_item_size(num_stripes);
-			if (cur_offset + len > array_size)
-				goto out_short_read;
-			print_chunk_item(buf, chunk);
-		} else {
-			error("unexpected item type %u in sys_array at offset %u",
-				(u32)key.type, cur_offset);
-			break;
-		}
-		array_ptr += len;
-		sb_array_offset += len;
-		cur_offset += len;
-
-		item++;
-	}
-
-out:
-	free(buf);
-	return;
-
-out_short_read:
-	error("sys_array too short to read %u bytes at offset %u",
-			len, cur_offset);
-	free(buf);
-}
-
-static int empty_backup(struct btrfs_root_backup *backup)
-{
-	if (backup == NULL ||
-		(backup->tree_root == 0 &&
-		 backup->tree_root_gen == 0))
-		return 1;
-	return 0;
-}
-
-static void print_root_backup(struct btrfs_root_backup *backup)
-{
-	printf("\t\tbackup_tree_root:\t%llu\tgen: %llu\tlevel: %d\n",
-			btrfs_backup_tree_root(backup),
-			btrfs_backup_tree_root_gen(backup),
-			btrfs_backup_tree_root_level(backup));
-	printf("\t\tbackup_chunk_root:\t%llu\tgen: %llu\tlevel: %d\n",
-			btrfs_backup_chunk_root(backup),
-			btrfs_backup_chunk_root_gen(backup),
-			btrfs_backup_chunk_root_level(backup));
-	printf("\t\tbackup_extent_root:\t%llu\tgen: %llu\tlevel: %d\n",
-			btrfs_backup_extent_root(backup),
-			btrfs_backup_extent_root_gen(backup),
-			btrfs_backup_extent_root_level(backup));
-	printf("\t\tbackup_fs_root:\t\t%llu\tgen: %llu\tlevel: %d\n",
-			btrfs_backup_fs_root(backup),
-			btrfs_backup_fs_root_gen(backup),
-			btrfs_backup_fs_root_level(backup));
-	printf("\t\tbackup_dev_root:\t%llu\tgen: %llu\tlevel: %d\n",
-			btrfs_backup_dev_root(backup),
-			btrfs_backup_dev_root_gen(backup),
-			btrfs_backup_dev_root_level(backup));
-	printf("\t\tbackup_csum_root:\t%llu\tgen: %llu\tlevel: %d\n",
-			btrfs_backup_csum_root(backup),
-			btrfs_backup_csum_root_gen(backup),
-			btrfs_backup_csum_root_level(backup));
-
-	printf("\t\tbackup_total_bytes:\t%llu\n",
-					btrfs_backup_total_bytes(backup));
-	printf("\t\tbackup_bytes_used:\t%llu\n",
-					btrfs_backup_bytes_used(backup));
-	printf("\t\tbackup_num_devices:\t%llu\n",
-					btrfs_backup_num_devices(backup));
-	putchar('\n');
-}
-
-static void print_backup_roots(struct btrfs_super_block *sb)
-{
-	struct btrfs_root_backup *backup;
-	int i;
-
-	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
-		backup = sb->super_roots + i;
-		if (!empty_backup(backup)) {
-			printf("\tbackup %d:\n", i);
-			print_root_backup(backup);
-		}
-	}
-}
-
-struct readable_flag_entry {
-	u64 bit;
-	char *output;
-};
-
-#define DEF_COMPAT_RO_FLAG_ENTRY(bit_name)		\
-	{BTRFS_FEATURE_COMPAT_RO_##bit_name, #bit_name}
-
-static struct readable_flag_entry compat_ro_flags_array[] = {
-	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE),
-	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE_VALID),
-};
-static const int compat_ro_flags_num = sizeof(compat_ro_flags_array) /
-				       sizeof(struct readable_flag_entry);
-
-#define DEF_INCOMPAT_FLAG_ENTRY(bit_name)		\
-	{BTRFS_FEATURE_INCOMPAT_##bit_name, #bit_name}
-
-static struct readable_flag_entry incompat_flags_array[] = {
-	DEF_INCOMPAT_FLAG_ENTRY(MIXED_BACKREF),
-	DEF_INCOMPAT_FLAG_ENTRY(DEFAULT_SUBVOL),
-	DEF_INCOMPAT_FLAG_ENTRY(MIXED_GROUPS),
-	DEF_INCOMPAT_FLAG_ENTRY(COMPRESS_LZO),
-	DEF_INCOMPAT_FLAG_ENTRY(COMPRESS_ZSTD),
-	DEF_INCOMPAT_FLAG_ENTRY(BIG_METADATA),
-	DEF_INCOMPAT_FLAG_ENTRY(EXTENDED_IREF),
-	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
-	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
-	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
-	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
-	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
-};
-static const int incompat_flags_num = sizeof(incompat_flags_array) /
-				      sizeof(struct readable_flag_entry);
-
-#define DEF_HEADER_FLAG_ENTRY(bit_name)			\
-	{BTRFS_HEADER_FLAG_##bit_name, #bit_name}
-#define DEF_SUPER_FLAG_ENTRY(bit_name)			\
-	{BTRFS_SUPER_FLAG_##bit_name, #bit_name}
-
-static struct readable_flag_entry super_flags_array[] = {
-	DEF_HEADER_FLAG_ENTRY(WRITTEN),
-	DEF_HEADER_FLAG_ENTRY(RELOC),
-	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
-	DEF_SUPER_FLAG_ENTRY(SEEDING),
-	DEF_SUPER_FLAG_ENTRY(METADUMP),
-	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
-};
-static const int super_flags_num = ARRAY_SIZE(super_flags_array);
-
-#define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
-				 BTRFS_HEADER_FLAG_RELOC |\
-				 BTRFS_SUPER_FLAG_CHANGING_FSID |\
-				 BTRFS_SUPER_FLAG_SEEDING |\
-				 BTRFS_SUPER_FLAG_METADUMP |\
-				 BTRFS_SUPER_FLAG_METADUMP_V2)
-
-static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
-				  int array_size, u64 supported_flags)
-{
-	int i;
-	int first = 1;
-	struct readable_flag_entry *entry;
-
-	if (!flag)
-		return;
-
-	printf("\t\t\t( ");
-	for (i = 0; i < array_size; i++) {
-		entry = array + i;
-		if (flag & entry->bit) {
-			if (first)
-				printf("%s ", entry->output);
-			else
-				printf("|\n\t\t\t  %s ", entry->output);
-			first = 0;
-		}
-	}
-	flag &= ~supported_flags;
-	if (flag) {
-		if (first)
-			printf("unknown flag: 0x%llx ", flag);
-		else
-			printf("|\n\t\t\t  unknown flag: 0x%llx ", flag);
-	}
-	printf(")\n");
-}
-
-static void print_readable_compat_ro_flag(u64 flag)
-{
-	/*
-	 * We know about the FREE_SPACE_TREE{,_VALID} bits, but we don't
-	 * actually support them yet.
-	 */
-	return __print_readable_flag(flag, compat_ro_flags_array,
-				     compat_ro_flags_num,
-				     BTRFS_FEATURE_COMPAT_RO_SUPP |
-				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
-				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
-}
-
-static void print_readable_incompat_flag(u64 flag)
-{
-	return __print_readable_flag(flag, incompat_flags_array,
-				     incompat_flags_num,
-				     BTRFS_FEATURE_INCOMPAT_SUPP);
-}
-
-static void print_readable_super_flag(u64 flag)
-{
-	return __print_readable_flag(flag, super_flags_array,
-				     super_flags_num, BTRFS_SUPER_FLAG_SUPP);
-}
-
-static bool is_valid_csum_type(u16 csum_type)
-{
-	switch (csum_type) {
-	case BTRFS_CSUM_TYPE_CRC32:
-	case BTRFS_CSUM_TYPE_XXHASH:
-	case BTRFS_CSUM_TYPE_SHA256:
-	case BTRFS_CSUM_TYPE_BLAKE2:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static void dump_superblock(struct btrfs_super_block *sb, int full)
-{
-	int i;
-	char *s, buf[BTRFS_UUID_UNPARSED_SIZE];
-	u8 *p;
-	u32 csum_size;
-	u16 csum_type;
-	bool metadata_uuid_present = (btrfs_super_incompat_flags(sb) &
-		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
-	int cmp_res = 0;
-
-
-	csum_type = btrfs_super_csum_type(sb);
-	csum_size = BTRFS_CSUM_SIZE;
-	printf("csum_type\t\t%hu (", csum_type);
-	if (!is_valid_csum_type(csum_type)) {
-		printf("INVALID");
-	} else {
-		printf("%s", btrfs_super_csum_name(csum_type));
-		csum_size = btrfs_super_csum_size(sb);
-	}
-	printf(")\n");
-	printf("csum_size\t\t%llu\n", (unsigned long long)csum_size);
-
-	printf("csum\t\t\t0x");
-	for (i = 0, p = sb->csum; i < csum_size; i++)
-		printf("%02x", p[i]);
-	if (!is_valid_csum_type(csum_type))
-		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
-	else if (check_csum_sblock(sb, csum_size, csum_type))
-		printf(" [match]");
-	else
-		printf(" [DON'T MATCH]");
-	putchar('\n');
-
-	printf("bytenr\t\t\t%llu\n",
-		(unsigned long long)btrfs_super_bytenr(sb));
-	printf("flags\t\t\t0x%llx\n",
-		(unsigned long long)btrfs_super_flags(sb));
-	print_readable_super_flag(btrfs_super_flags(sb));
-
-	printf("magic\t\t\t");
-	s = (char *) &sb->magic;
-	for (i = 0; i < 8; i++)
-		putchar(isprint(s[i]) ? s[i] : '.');
-	if (btrfs_super_magic(sb) == BTRFS_MAGIC)
-		printf(" [match]\n");
-	else
-		printf(" [DON'T MATCH]\n");
-
-	uuid_unparse(sb->fsid, buf);
-	printf("fsid\t\t\t%s\n", buf);
-	if (metadata_uuid_present) {
-		uuid_unparse(sb->metadata_uuid, buf);
-		printf("metadata_uuid\t\t%s\n", buf);
-	} else {
-		printf("metadata_uuid\t\t%s\n", buf);
-	}
-
-	printf("label\t\t\t");
-	s = sb->label;
-	for (i = 0; i < BTRFS_LABEL_SIZE && s[i]; i++)
-		putchar(isprint(s[i]) ? s[i] : '.');
-	putchar('\n');
-
-	printf("generation\t\t%llu\n",
-	       (unsigned long long)btrfs_super_generation(sb));
-	printf("root\t\t\t%llu\n", (unsigned long long)btrfs_super_root(sb));
-	printf("sys_array_size\t\t%llu\n",
-	       (unsigned long long)btrfs_super_sys_array_size(sb));
-	printf("chunk_root_generation\t%llu\n",
-	       (unsigned long long)btrfs_super_chunk_root_generation(sb));
-	printf("root_level\t\t%llu\n",
-	       (unsigned long long)btrfs_super_root_level(sb));
-	printf("chunk_root\t\t%llu\n",
-	       (unsigned long long)btrfs_super_chunk_root(sb));
-	printf("chunk_root_level\t%llu\n",
-	       (unsigned long long)btrfs_super_chunk_root_level(sb));
-	printf("log_root\t\t%llu\n",
-	       (unsigned long long)btrfs_super_log_root(sb));
-	printf("log_root_transid\t%llu\n",
-	       (unsigned long long)btrfs_super_log_root_transid(sb));
-	printf("log_root_level\t\t%llu\n",
-	       (unsigned long long)btrfs_super_log_root_level(sb));
-	printf("total_bytes\t\t%llu\n",
-	       (unsigned long long)btrfs_super_total_bytes(sb));
-	printf("bytes_used\t\t%llu\n",
-	       (unsigned long long)btrfs_super_bytes_used(sb));
-	printf("sectorsize\t\t%llu\n",
-	       (unsigned long long)btrfs_super_sectorsize(sb));
-	printf("nodesize\t\t%llu\n",
-	       (unsigned long long)btrfs_super_nodesize(sb));
-	printf("leafsize (deprecated)\t%u\n",
-	       le32_to_cpu(sb->__unused_leafsize));
-	printf("stripesize\t\t%llu\n",
-	       (unsigned long long)btrfs_super_stripesize(sb));
-	printf("root_dir\t\t%llu\n",
-	       (unsigned long long)btrfs_super_root_dir(sb));
-	printf("num_devices\t\t%llu\n",
-	       (unsigned long long)btrfs_super_num_devices(sb));
-	printf("compat_flags\t\t0x%llx\n",
-	       (unsigned long long)btrfs_super_compat_flags(sb));
-	printf("compat_ro_flags\t\t0x%llx\n",
-	       (unsigned long long)btrfs_super_compat_ro_flags(sb));
-	print_readable_compat_ro_flag(btrfs_super_compat_ro_flags(sb));
-	printf("incompat_flags\t\t0x%llx\n",
-	       (unsigned long long)btrfs_super_incompat_flags(sb));
-	print_readable_incompat_flag(btrfs_super_incompat_flags(sb));
-	printf("cache_generation\t%llu\n",
-	       (unsigned long long)btrfs_super_cache_generation(sb));
-	printf("uuid_tree_generation\t%llu\n",
-	       (unsigned long long)btrfs_super_uuid_tree_generation(sb));
-
-	uuid_unparse(sb->dev_item.uuid, buf);
-	printf("dev_item.uuid\t\t%s\n", buf);
-
-	uuid_unparse(sb->dev_item.fsid, buf);
-	if (metadata_uuid_present) {
-		cmp_res = !memcmp(sb->dev_item.fsid, sb->metadata_uuid,
-				 BTRFS_FSID_SIZE);
-	} else {
-		cmp_res = !memcmp(sb->dev_item.fsid, sb->fsid, BTRFS_FSID_SIZE);
-	}
-	printf("dev_item.fsid\t\t%s %s\n", buf,
-	       cmp_res ? "[match]" : "[DON'T MATCH]");
-
-	printf("dev_item.type\t\t%llu\n", (unsigned long long)
-	       btrfs_stack_device_type(&sb->dev_item));
-	printf("dev_item.total_bytes\t%llu\n", (unsigned long long)
-	       btrfs_stack_device_total_bytes(&sb->dev_item));
-	printf("dev_item.bytes_used\t%llu\n", (unsigned long long)
-	       btrfs_stack_device_bytes_used(&sb->dev_item));
-	printf("dev_item.io_align\t%u\n", (unsigned int)
-	       btrfs_stack_device_io_align(&sb->dev_item));
-	printf("dev_item.io_width\t%u\n", (unsigned int)
-	       btrfs_stack_device_io_width(&sb->dev_item));
-	printf("dev_item.sector_size\t%u\n", (unsigned int)
-	       btrfs_stack_device_sector_size(&sb->dev_item));
-	printf("dev_item.devid\t\t%llu\n",
-	       btrfs_stack_device_id(&sb->dev_item));
-	printf("dev_item.dev_group\t%u\n", (unsigned int)
-	       btrfs_stack_device_group(&sb->dev_item));
-	printf("dev_item.seek_speed\t%u\n", (unsigned int)
-	       btrfs_stack_device_seek_speed(&sb->dev_item));
-	printf("dev_item.bandwidth\t%u\n", (unsigned int)
-	       btrfs_stack_device_bandwidth(&sb->dev_item));
-	printf("dev_item.generation\t%llu\n", (unsigned long long)
-	       btrfs_stack_device_generation(&sb->dev_item));
-	if (full) {
-		printf("sys_chunk_array[%d]:\n", BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
-		print_sys_chunk_array(sb);
-		printf("backup_roots[%d]:\n", BTRFS_NUM_BACKUP_ROOTS);
-		print_backup_roots(sb);
-	}
-}
-
 static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		int force)
 {
@@ -507,7 +55,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		error("bad magic on superblock on %s at %llu",
 				filename, (unsigned long long)sb_bytenr);
 	} else {
-		dump_superblock(sb, full);
+		btrfs_print_superblock(sb, full);
 	}
 	return 0;
 }
diff --git a/print-tree.c b/print-tree.c
index 38cf8d34ac2e..6fa3440b813c 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -19,6 +19,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <uuid/uuid.h>
+#include <ctype.h>
 #include "kerncompat.h"
 #include "kernel-lib/radix-tree.h"
 #include "ctree.h"
@@ -1550,3 +1551,449 @@ void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse)
 		bfs_print_children(eb);
 	return;
 }
+
+static bool is_valid_csum_type(u16 csum_type)
+{
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_XXHASH:
+	case BTRFS_CSUM_TYPE_SHA256:
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
+{
+	u8 result[BTRFS_CSUM_SIZE];
+
+	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+
+	return !memcmp(sb, result, csum_size);
+}
+
+struct readable_flag_entry {
+	u64 bit;
+	char *output;
+};
+
+#define DEF_COMPAT_RO_FLAG_ENTRY(bit_name)		\
+	{BTRFS_FEATURE_COMPAT_RO_##bit_name, #bit_name}
+
+static struct readable_flag_entry compat_ro_flags_array[] = {
+	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE),
+	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE_VALID),
+};
+static const int compat_ro_flags_num = sizeof(compat_ro_flags_array) /
+				       sizeof(struct readable_flag_entry);
+
+#define DEF_INCOMPAT_FLAG_ENTRY(bit_name)		\
+	{BTRFS_FEATURE_INCOMPAT_##bit_name, #bit_name}
+
+static struct readable_flag_entry incompat_flags_array[] = {
+	DEF_INCOMPAT_FLAG_ENTRY(MIXED_BACKREF),
+	DEF_INCOMPAT_FLAG_ENTRY(DEFAULT_SUBVOL),
+	DEF_INCOMPAT_FLAG_ENTRY(MIXED_GROUPS),
+	DEF_INCOMPAT_FLAG_ENTRY(COMPRESS_LZO),
+	DEF_INCOMPAT_FLAG_ENTRY(COMPRESS_ZSTD),
+	DEF_INCOMPAT_FLAG_ENTRY(BIG_METADATA),
+	DEF_INCOMPAT_FLAG_ENTRY(EXTENDED_IREF),
+	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
+	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
+	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
+	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
+	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
+};
+static const int incompat_flags_num = sizeof(incompat_flags_array) /
+				      sizeof(struct readable_flag_entry);
+
+#define DEF_HEADER_FLAG_ENTRY(bit_name)			\
+	{BTRFS_HEADER_FLAG_##bit_name, #bit_name}
+#define DEF_SUPER_FLAG_ENTRY(bit_name)			\
+	{BTRFS_SUPER_FLAG_##bit_name, #bit_name}
+
+static struct readable_flag_entry super_flags_array[] = {
+	DEF_HEADER_FLAG_ENTRY(WRITTEN),
+	DEF_HEADER_FLAG_ENTRY(RELOC),
+	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
+	DEF_SUPER_FLAG_ENTRY(SEEDING),
+	DEF_SUPER_FLAG_ENTRY(METADUMP),
+	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
+};
+static const int super_flags_num = ARRAY_SIZE(super_flags_array);
+
+#define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
+				 BTRFS_HEADER_FLAG_RELOC |\
+				 BTRFS_SUPER_FLAG_CHANGING_FSID |\
+				 BTRFS_SUPER_FLAG_SEEDING |\
+				 BTRFS_SUPER_FLAG_METADUMP |\
+				 BTRFS_SUPER_FLAG_METADUMP_V2)
+
+static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
+				  int array_size, u64 supported_flags)
+{
+	int i;
+	int first = 1;
+	struct readable_flag_entry *entry;
+
+	if (!flag)
+		return;
+
+	printf("\t\t\t( ");
+	for (i = 0; i < array_size; i++) {
+		entry = array + i;
+		if (flag & entry->bit) {
+			if (first)
+				printf("%s ", entry->output);
+			else
+				printf("|\n\t\t\t  %s ", entry->output);
+			first = 0;
+		}
+	}
+	flag &= ~supported_flags;
+	if (flag) {
+		if (first)
+			printf("unknown flag: 0x%llx ", flag);
+		else
+			printf("|\n\t\t\t  unknown flag: 0x%llx ", flag);
+	}
+	printf(")\n");
+}
+
+static void print_readable_compat_ro_flag(u64 flag)
+{
+	/*
+	 * We know about the FREE_SPACE_TREE{,_VALID} bits, but we don't
+	 * actually support them yet.
+	 */
+	return __print_readable_flag(flag, compat_ro_flags_array,
+				     compat_ro_flags_num,
+				     BTRFS_FEATURE_COMPAT_RO_SUPP |
+				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+				     BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID);
+}
+
+static void print_readable_incompat_flag(u64 flag)
+{
+	return __print_readable_flag(flag, incompat_flags_array,
+				     incompat_flags_num,
+				     BTRFS_FEATURE_INCOMPAT_SUPP);
+}
+
+static void print_readable_super_flag(u64 flag)
+{
+	return __print_readable_flag(flag, super_flags_array,
+				     super_flags_num, BTRFS_SUPER_FLAG_SUPP);
+}
+
+static void print_sys_chunk_array(struct btrfs_super_block *sb)
+{
+	struct extent_buffer *buf;
+	struct btrfs_disk_key *disk_key;
+	struct btrfs_chunk *chunk;
+	u8 *array_ptr;
+	unsigned long sb_array_offset;
+	u32 num_stripes;
+	u32 array_size;
+	u32 len = 0;
+	u32 cur_offset;
+	struct btrfs_key key;
+	int item;
+
+	buf = malloc(sizeof(*buf) + sizeof(*sb));
+	if (!buf) {
+		error("not enough memory");
+		return;
+	}
+	write_extent_buffer(buf, sb, 0, sizeof(*sb));
+	buf->len = sizeof(*sb);
+	array_size = btrfs_super_sys_array_size(sb);
+
+	array_ptr = sb->sys_chunk_array;
+	sb_array_offset = offsetof(struct btrfs_super_block, sys_chunk_array);
+
+	if (array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
+		error("sys_array_size %u shouldn't exceed %u bytes",
+				array_size, BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
+		goto out;
+	}
+
+	cur_offset = 0;
+	item = 0;
+
+	while (cur_offset < array_size) {
+		disk_key = (struct btrfs_disk_key *)array_ptr;
+		len = sizeof(*disk_key);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+
+		btrfs_disk_key_to_cpu(&key, disk_key);
+
+		array_ptr += len;
+		sb_array_offset += len;
+		cur_offset += len;
+
+		printf("\titem %d ", item);
+		btrfs_print_key(disk_key);
+		putchar('\n');
+
+		if (key.type == BTRFS_CHUNK_ITEM_KEY) {
+			chunk = (struct btrfs_chunk *)sb_array_offset;
+			/*
+			 * At least one btrfs_chunk with one stripe must be
+			 * present, exact stripe count check comes afterwards
+			 */
+			len = btrfs_chunk_item_size(1);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+
+			num_stripes = btrfs_chunk_num_stripes(buf, chunk);
+			if (!num_stripes) {
+				error(
+			"invalid number of stripes %u in sys_array at offset %u",
+					num_stripes, cur_offset);
+				break;
+			}
+			len = btrfs_chunk_item_size(num_stripes);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+			print_chunk_item(buf, chunk);
+		} else {
+			error("unexpected item type %u in sys_array at offset %u",
+				(u32)key.type, cur_offset);
+			break;
+		}
+		array_ptr += len;
+		sb_array_offset += len;
+		cur_offset += len;
+
+		item++;
+	}
+
+out:
+	free(buf);
+	return;
+
+out_short_read:
+	error("sys_array too short to read %u bytes at offset %u",
+			len, cur_offset);
+	free(buf);
+}
+
+static int empty_backup(struct btrfs_root_backup *backup)
+{
+	if (backup == NULL ||
+		(backup->tree_root == 0 &&
+		 backup->tree_root_gen == 0))
+		return 1;
+	return 0;
+}
+
+static void print_root_backup(struct btrfs_root_backup *backup)
+{
+	printf("\t\tbackup_tree_root:\t%llu\tgen: %llu\tlevel: %d\n",
+			btrfs_backup_tree_root(backup),
+			btrfs_backup_tree_root_gen(backup),
+			btrfs_backup_tree_root_level(backup));
+	printf("\t\tbackup_chunk_root:\t%llu\tgen: %llu\tlevel: %d\n",
+			btrfs_backup_chunk_root(backup),
+			btrfs_backup_chunk_root_gen(backup),
+			btrfs_backup_chunk_root_level(backup));
+	printf("\t\tbackup_extent_root:\t%llu\tgen: %llu\tlevel: %d\n",
+			btrfs_backup_extent_root(backup),
+			btrfs_backup_extent_root_gen(backup),
+			btrfs_backup_extent_root_level(backup));
+	printf("\t\tbackup_fs_root:\t\t%llu\tgen: %llu\tlevel: %d\n",
+			btrfs_backup_fs_root(backup),
+			btrfs_backup_fs_root_gen(backup),
+			btrfs_backup_fs_root_level(backup));
+	printf("\t\tbackup_dev_root:\t%llu\tgen: %llu\tlevel: %d\n",
+			btrfs_backup_dev_root(backup),
+			btrfs_backup_dev_root_gen(backup),
+			btrfs_backup_dev_root_level(backup));
+	printf("\t\tbackup_csum_root:\t%llu\tgen: %llu\tlevel: %d\n",
+			btrfs_backup_csum_root(backup),
+			btrfs_backup_csum_root_gen(backup),
+			btrfs_backup_csum_root_level(backup));
+
+	printf("\t\tbackup_total_bytes:\t%llu\n",
+					btrfs_backup_total_bytes(backup));
+	printf("\t\tbackup_bytes_used:\t%llu\n",
+					btrfs_backup_bytes_used(backup));
+	printf("\t\tbackup_num_devices:\t%llu\n",
+					btrfs_backup_num_devices(backup));
+	putchar('\n');
+}
+
+static void print_backup_roots(struct btrfs_super_block *sb)
+{
+	struct btrfs_root_backup *backup;
+	int i;
+
+	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
+		backup = sb->super_roots + i;
+		if (!empty_backup(backup)) {
+			printf("\tbackup %d:\n", i);
+			print_root_backup(backup);
+		}
+	}
+}
+
+void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
+{
+	int i;
+	char *s, buf[BTRFS_UUID_UNPARSED_SIZE];
+	u8 *p;
+	u32 csum_size;
+	u16 csum_type;
+	bool metadata_uuid_present = (btrfs_super_incompat_flags(sb) &
+		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	int cmp_res = 0;
+
+
+	csum_type = btrfs_super_csum_type(sb);
+	csum_size = BTRFS_CSUM_SIZE;
+	printf("csum_type\t\t%hu (", csum_type);
+	if (!is_valid_csum_type(csum_type)) {
+		printf("INVALID");
+	} else {
+		printf("%s", btrfs_super_csum_name(csum_type));
+		csum_size = btrfs_super_csum_size(sb);
+	}
+	printf(")\n");
+	printf("csum_size\t\t%llu\n", (unsigned long long)csum_size);
+
+	printf("csum\t\t\t0x");
+	for (i = 0, p = sb->csum; i < csum_size; i++)
+		printf("%02x", p[i]);
+	if (!is_valid_csum_type(csum_type))
+		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
+	else if (check_csum_sblock(sb, csum_size, csum_type))
+		printf(" [match]");
+	else
+		printf(" [DON'T MATCH]");
+	putchar('\n');
+
+	printf("bytenr\t\t\t%llu\n",
+		(unsigned long long)btrfs_super_bytenr(sb));
+	printf("flags\t\t\t0x%llx\n",
+		(unsigned long long)btrfs_super_flags(sb));
+	print_readable_super_flag(btrfs_super_flags(sb));
+
+	printf("magic\t\t\t");
+	s = (char *) &sb->magic;
+	for (i = 0; i < 8; i++)
+		putchar(isprint(s[i]) ? s[i] : '.');
+	if (btrfs_super_magic(sb) == BTRFS_MAGIC)
+		printf(" [match]\n");
+	else
+		printf(" [DON'T MATCH]\n");
+
+	uuid_unparse(sb->fsid, buf);
+	printf("fsid\t\t\t%s\n", buf);
+	if (metadata_uuid_present) {
+		uuid_unparse(sb->metadata_uuid, buf);
+		printf("metadata_uuid\t\t%s\n", buf);
+	} else {
+		printf("metadata_uuid\t\t%s\n", buf);
+	}
+
+	printf("label\t\t\t");
+	s = sb->label;
+	for (i = 0; i < BTRFS_LABEL_SIZE && s[i]; i++)
+		putchar(isprint(s[i]) ? s[i] : '.');
+	putchar('\n');
+
+	printf("generation\t\t%llu\n",
+	       (unsigned long long)btrfs_super_generation(sb));
+	printf("root\t\t\t%llu\n", (unsigned long long)btrfs_super_root(sb));
+	printf("sys_array_size\t\t%llu\n",
+	       (unsigned long long)btrfs_super_sys_array_size(sb));
+	printf("chunk_root_generation\t%llu\n",
+	       (unsigned long long)btrfs_super_chunk_root_generation(sb));
+	printf("root_level\t\t%llu\n",
+	       (unsigned long long)btrfs_super_root_level(sb));
+	printf("chunk_root\t\t%llu\n",
+	       (unsigned long long)btrfs_super_chunk_root(sb));
+	printf("chunk_root_level\t%llu\n",
+	       (unsigned long long)btrfs_super_chunk_root_level(sb));
+	printf("log_root\t\t%llu\n",
+	       (unsigned long long)btrfs_super_log_root(sb));
+	printf("log_root_transid\t%llu\n",
+	       (unsigned long long)btrfs_super_log_root_transid(sb));
+	printf("log_root_level\t\t%llu\n",
+	       (unsigned long long)btrfs_super_log_root_level(sb));
+	printf("total_bytes\t\t%llu\n",
+	       (unsigned long long)btrfs_super_total_bytes(sb));
+	printf("bytes_used\t\t%llu\n",
+	       (unsigned long long)btrfs_super_bytes_used(sb));
+	printf("sectorsize\t\t%llu\n",
+	       (unsigned long long)btrfs_super_sectorsize(sb));
+	printf("nodesize\t\t%llu\n",
+	       (unsigned long long)btrfs_super_nodesize(sb));
+	printf("leafsize (deprecated)\t%u\n",
+	       le32_to_cpu(sb->__unused_leafsize));
+	printf("stripesize\t\t%llu\n",
+	       (unsigned long long)btrfs_super_stripesize(sb));
+	printf("root_dir\t\t%llu\n",
+	       (unsigned long long)btrfs_super_root_dir(sb));
+	printf("num_devices\t\t%llu\n",
+	       (unsigned long long)btrfs_super_num_devices(sb));
+	printf("compat_flags\t\t0x%llx\n",
+	       (unsigned long long)btrfs_super_compat_flags(sb));
+	printf("compat_ro_flags\t\t0x%llx\n",
+	       (unsigned long long)btrfs_super_compat_ro_flags(sb));
+	print_readable_compat_ro_flag(btrfs_super_compat_ro_flags(sb));
+	printf("incompat_flags\t\t0x%llx\n",
+	       (unsigned long long)btrfs_super_incompat_flags(sb));
+	print_readable_incompat_flag(btrfs_super_incompat_flags(sb));
+	printf("cache_generation\t%llu\n",
+	       (unsigned long long)btrfs_super_cache_generation(sb));
+	printf("uuid_tree_generation\t%llu\n",
+	       (unsigned long long)btrfs_super_uuid_tree_generation(sb));
+
+	uuid_unparse(sb->dev_item.uuid, buf);
+	printf("dev_item.uuid\t\t%s\n", buf);
+
+	uuid_unparse(sb->dev_item.fsid, buf);
+	if (metadata_uuid_present) {
+		cmp_res = !memcmp(sb->dev_item.fsid, sb->metadata_uuid,
+				 BTRFS_FSID_SIZE);
+	} else {
+		cmp_res = !memcmp(sb->dev_item.fsid, sb->fsid, BTRFS_FSID_SIZE);
+	}
+	printf("dev_item.fsid\t\t%s %s\n", buf,
+	       cmp_res ? "[match]" : "[DON'T MATCH]");
+
+	printf("dev_item.type\t\t%llu\n", (unsigned long long)
+	       btrfs_stack_device_type(&sb->dev_item));
+	printf("dev_item.total_bytes\t%llu\n", (unsigned long long)
+	       btrfs_stack_device_total_bytes(&sb->dev_item));
+	printf("dev_item.bytes_used\t%llu\n", (unsigned long long)
+	       btrfs_stack_device_bytes_used(&sb->dev_item));
+	printf("dev_item.io_align\t%u\n", (unsigned int)
+	       btrfs_stack_device_io_align(&sb->dev_item));
+	printf("dev_item.io_width\t%u\n", (unsigned int)
+	       btrfs_stack_device_io_width(&sb->dev_item));
+	printf("dev_item.sector_size\t%u\n", (unsigned int)
+	       btrfs_stack_device_sector_size(&sb->dev_item));
+	printf("dev_item.devid\t\t%llu\n",
+	       btrfs_stack_device_id(&sb->dev_item));
+	printf("dev_item.dev_group\t%u\n", (unsigned int)
+	       btrfs_stack_device_group(&sb->dev_item));
+	printf("dev_item.seek_speed\t%u\n", (unsigned int)
+	       btrfs_stack_device_seek_speed(&sb->dev_item));
+	printf("dev_item.bandwidth\t%u\n", (unsigned int)
+	       btrfs_stack_device_bandwidth(&sb->dev_item));
+	printf("dev_item.generation\t%llu\n", (unsigned long long)
+	       btrfs_stack_device_generation(&sb->dev_item));
+	if (full) {
+		printf("sys_chunk_array[%d]:\n", BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
+		print_sys_chunk_array(sb);
+		printf("backup_roots[%d]:\n", BTRFS_NUM_BACKUP_ROOTS);
+		print_backup_roots(sb);
+	}
+}
diff --git a/print-tree.h b/print-tree.h
index 92ed5fb7c270..0ce8d92fa305 100644
--- a/print-tree.h
+++ b/print-tree.h
@@ -39,4 +39,5 @@ void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk);
 void print_extent_item(struct extent_buffer *eb, int slot, int metadata);
 void print_objectid(FILE *stream, u64 objectid, u8 type);
 void print_key_type(FILE *stream, u64 objectid, u8 type);
+void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
 #endif
-- 
2.26.2

