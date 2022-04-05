Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157F4F22FD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 08:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiDEGW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 02:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDEGW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 02:22:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4171313F47
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 23:20:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C8E7210FC
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 06:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649139654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tcj2OGryqTaFZgmhxIdC26nNzetbYUJUie6Qac4SwSc=;
        b=H4Q5ao/Ta7DZs9UOxhAYtaImByacb3ly/j0MG6f5AeINnxYlOkMomSPk1RbOTHhJG8DWTb
        hE/7xhFw4zrs0fv4wcGBkgKgVqdT44xDLQcNLMIzz/839QPynqJ4827SMvUA9pNoH8z1qT
        3XOaai7CzVzO+xNruh62ugEWKQbMSZE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CD5D13A30
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 06:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hTwZBsXfS2KbVAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 06:20:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: remove unnecessary type casting in format string
Date:   Tue,  5 Apr 2022 14:20:34 +0800
Message-Id: <777369c2a3f197c8bea951f7b9ece8c9f7722c4d.1649139626.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There seems to be a bad practice of doing unnecessary type casting for
printf format string.

I know sometimes it can be hard to determine the correct format, but
with recent compiler improvement, it's super easy to get the correct
format.

Just remove all these unnecessary casting.

Since we're here, also merge the format string if it's split for the
80-char width requirement.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c            |  15 +-
 btrfs-sb-mod.c                   |  19 +-
 btrfs-select-super.c             |   3 +-
 check/main.c                     | 198 ++++++++------------
 check/mode-common.c              |   7 +-
 check/qgroup-verify.c            |  13 +-
 cmds/balance.c                   |  42 ++---
 cmds/device.c                    |   3 +-
 cmds/filesystem-du.c             |   2 +-
 cmds/filesystem-usage.c          |   4 +-
 cmds/filesystem.c                |   5 +-
 cmds/inspect-dump-super.c        |   6 +-
 cmds/inspect-dump-tree.c         |  42 ++---
 cmds/inspect-tree-stats.c        |   2 +-
 cmds/inspect.c                   |   4 +-
 cmds/qgroup.c                    |   3 +-
 cmds/receive.c                   |   3 +-
 cmds/replace.c                   |   5 +-
 cmds/rescue-chunk-recover.c      |   5 +-
 cmds/rescue.c                    |   5 +-
 cmds/subvolume-list.c            |   4 +-
 cmds/subvolume.c                 |  24 +--
 common/parse-utils.c             |   6 +-
 common/send-utils.c              |   4 +-
 convert/common.c                 |  46 ++---
 convert/main.c                   |  13 +-
 convert/source-ext2.c            |   8 +-
 image/main.c                     |  27 ++-
 kernel-shared/ctree.c            |   7 +-
 kernel-shared/disk-io.c          |  23 +--
 kernel-shared/extent-tree.c      |  28 ++-
 kernel-shared/extent_io.c        |   2 +-
 kernel-shared/free-space-cache.c |   8 +-
 kernel-shared/inode.c            |   7 +-
 kernel-shared/print-tree.c       | 308 ++++++++++++++-----------------
 kernel-shared/uuid-tree.c        |   3 +-
 kernel-shared/volumes.c          |  17 +-
 libbtrfs/send-utils.c            |   8 +-
 mkfs/common.c                    |   8 +-
 mkfs/main.c                      |  10 +-
 mkfs/rootdir.c                   |  12 +-
 random-test.c                    |  14 +-
 tests/fsstress.c                 |   3 +-
 tests/fssum.c                    |   2 +-
 44 files changed, 409 insertions(+), 569 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index fb1f15f0c7a2..8162c0dfd554 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -52,9 +52,7 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 				      &multi, mirror_num, NULL);
 		if (ret) {
 			error("cannot map block %llu length %llu mirror %d: %d",
-					(unsigned long long)eb->start,
-					(unsigned long long)length,
-					mirror_num, ret);
+				eb->start, length, mirror_num, ret);
 			return ret;
 		}
 		device = multi->stripes[0].dev;
@@ -64,8 +62,7 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 
 		fprintf(stdout,
 			"mirror %d logical %llu physical %llu device %s\n",
-			mirror_num, (unsigned long long)bytenr,
-			(unsigned long long)eb->dev_bytenr, device->name);
+			mirror_num, bytenr, eb->dev_bytenr, device->name);
 		free(multi);
 
 		if (!copy || mirror_num == copy) {
@@ -73,7 +70,7 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot read eb bytenr %llu: %m",
-					(unsigned long long)eb->dev_bytenr);
+					eb->dev_bytenr);
 				return ret;
 			}
 			printf("corrupting %llu copy %d\n", eb->start,
@@ -83,7 +80,7 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot write eb bytenr %llu: %m",
-					(unsigned long long)eb->dev_bytenr);
+					eb->dev_bytenr);
 				return ret;
 			}
 			fsync(eb->fd);
@@ -147,7 +144,7 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
 
 	fprintf(stderr,
 		"corrupting keys in block %llu slot %d swapping with %d\n",
-		(unsigned long long)eb->start, slot, bad_slot);
+		eb->start, slot, bad_slot);
 
 	if (btrfs_header_level(eb) == 0) {
 		btrfs_item_key(eb, &bad_key, bad_slot);
@@ -1522,7 +1519,7 @@ int main(int argc, char **argv)
 			if (!eb) {
 				error(
 		"not enough memory to allocate extent buffer for bytenr %llu",
-					(unsigned long long)logical);
+					logical);
 				ret = 1;
 				goto out_close;
 			}
diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index f56388bd06ab..6538ddc01e55 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -380,20 +380,19 @@ int main(int argc, char **argv)
 
 	ret = pread(fd, buf, BLOCKSIZE, off);
 	if (ret <= 0) {
-		printf("pread error %d at offset %llu\n",
-				ret, (unsigned long long)off);
+		printf("pread error %d at offset %lu\n", ret, off);
 		exit(1);
 	}
 	if (ret != BLOCKSIZE) {
-		printf("pread error at offset %llu: read only %d bytes\n",
-				(unsigned long long)off, ret);
+		printf("pread error at offset %lu: read only %d bytes\n",
+			off, ret);
 		exit(1);
 	}
 	hdr = (struct btrfs_header *)buf;
 	/* verify checksum */
 	if (!check_csum_superblock(&hdr->csum)) {
-		printf("super block checksum does not match at offset %llu, will be corrected after write\n",
-				(unsigned long long)off);
+		printf("super block checksum does not match at offset %lu, will be corrected after write\n",
+			off);
 	} else {
 		printf("super block checksum is ok\n");
 	}
@@ -436,13 +435,13 @@ int main(int argc, char **argv)
 		update_block_csum(buf);
 		ret = pwrite(fd, buf, BLOCKSIZE, off);
 		if (ret <= 0) {
-			printf("pwrite error %d at offset %llu\n",
-					ret, (unsigned long long)off);
+			printf("pwrite error %d at offset %lu\n",
+				ret, off);
 			exit(1);
 		}
 		if (ret != BLOCKSIZE) {
-			printf("pwrite error at offset %llu: written only %d bytes\n",
-					(unsigned long long)off, ret);
+			printf("pwrite error at offset %lu: written only %d bytes\n",
+				off, ret);
 			exit(1);
 		}
 		fsync(fd);
diff --git a/btrfs-select-super.c b/btrfs-select-super.c
index d8b54e9b3457..0f42cf23daeb 100644
--- a/btrfs-select-super.c
+++ b/btrfs-select-super.c
@@ -102,8 +102,7 @@ int main(int argc, char **argv)
 	 * transaction commit.  We just want the super copy we pulled off the
 	 * disk to overwrite all the other copies
 	 */
-	printf("using SB copy %llu, bytenr %llu\n", (unsigned long long)num,
-	       (unsigned long long)bytenr);
+	printf("using SB copy %llu, bytenr %llu\n", num, bytenr);
 	close_ctree(root);
 	btrfs_close_all_devices();
 	return ret;
diff --git a/check/main.c b/check/main.c
index dbf0a6b00564..954d02413f82 100644
--- a/check/main.c
+++ b/check/main.c
@@ -582,8 +582,7 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 		fprintf(stderr, "reloc");
 	}
 	fprintf(stderr, "root %llu inode %llu errors %x",
-		(unsigned long long) root_objectid,
-		(unsigned long long) rec->ino, rec->errors);
+		root_objectid, rec->ino, rec->errors);
 
 	if (errors & I_ERR_NO_INODE_ITEM)
 		fprintf(stderr, ", no inode item");
@@ -2056,7 +2055,7 @@ static int add_missing_dir_index(struct btrfs_root *root,
 		return PTR_ERR(trans);
 
 	fprintf(stderr, "repairing missing dir index item for inode %llu\n",
-		(unsigned long long)rec->ino);
+		rec->ino);
 
 	btrfs_init_path(&path);
 	key.objectid = backref->dir;
@@ -2110,9 +2109,8 @@ static int delete_dir_index(struct btrfs_root *root,
 		return PTR_ERR(trans);
 
 	fprintf(stderr, "Deleting bad dir index [%llu,%u,%llu] root %llu\n",
-		(unsigned long long)backref->dir,
-		BTRFS_DIR_INDEX_KEY, (unsigned long long)backref->index,
-		(unsigned long long)root->objectid);
+		backref->dir, BTRFS_DIR_INDEX_KEY, backref->index,
+		root->objectid);
 
 	btrfs_init_path(&path);
 	di = btrfs_lookup_dir_index_item(trans, root, &path, backref->dir,
@@ -2155,11 +2153,9 @@ static int create_inode_item(struct btrfs_root *root,
 	nlink = root_dir ? 1 : rec->found_link;
 	if (rec->found_dir_item) {
 		if (rec->found_file_extent)
-			fprintf(stderr, "root %llu inode %llu has both a dir "
-				"item and extents, unsure if it is a dir or a "
-				"regular file so setting it as a directory\n",
-				(unsigned long long)root->objectid,
-				(unsigned long long)rec->ino);
+			fprintf(stderr,
+"root %llu inode %llu has both a dir item and extents, unsure if it is a dir or a regular file so setting it as a directory\n",
+				root->objectid, rec->ino);
 		mode = S_IFDIR | 0755;
 		size = rec->found_size;
 	} else if (!rec->found_dir_item) {
@@ -2255,9 +2251,9 @@ static int repair_inode_backrefs(struct btrfs_root *root,
 				ret = PTR_ERR(trans);
 				break;
 			}
-			fprintf(stderr, "adding missing dir index/item pair "
-				"for inode %llu\n",
-				(unsigned long long)rec->ino);
+			fprintf(stderr,
+			"adding missing dir index/item pair for inode %llu\n",
+				rec->ino);
 			ret = btrfs_insert_dir_item(trans, root, backref->name,
 						    backref->namelen,
 						    backref->dir, &location,
@@ -3049,7 +3045,7 @@ static int check_inode_recs(struct btrfs_root *root,
 
 			fprintf(stderr,
 				"root %llu missing its root dir, recreating\n",
-				(unsigned long long)root->objectid);
+				root->objectid);
 
 			ret = btrfs_make_root_dir(trans, root, root_dirid);
 			if (ret < 0) {
@@ -3062,8 +3058,7 @@ static int check_inode_recs(struct btrfs_root *root,
 		}
 
 		fprintf(stderr, "root %llu root dir %llu not found\n",
-			(unsigned long long)root->root_key.objectid,
-			(unsigned long long)root_dirid);
+			root->root_key.objectid, root_dirid);
 	}
 
 	while (1) {
@@ -3112,10 +3107,9 @@ static int check_inode_recs(struct btrfs_root *root,
 				backref->errors |= REF_ERR_NO_DIR_INDEX;
 			if (!backref->found_inode_ref)
 				backref->errors |= REF_ERR_NO_INODE_REF;
-			fprintf(stderr, "\tunresolved ref dir %llu index %llu"
-				" namelen %u name %s filetype %d errors %x",
-				(unsigned long long)backref->dir,
-				(unsigned long long)backref->index,
+			fprintf(stderr,
+"\tunresolved ref dir %llu index %llu namelen %u name %s filetype %d errors %x",
+				backref->dir, backref->index,
 				backref->namelen, backref->name,
 				backref->filetype, backref->errors);
 			print_ref_error(backref->errors);
@@ -3370,7 +3364,7 @@ static int check_root_refs(struct btrfs_root *root,
 				continue;
 			errors++;
 			fprintf(stderr, "fs tree %llu not referenced\n",
-				(unsigned long long)rec->objectid);
+				rec->objectid);
 		}
 
 		error = 0;
@@ -3393,19 +3387,17 @@ static int check_root_refs(struct btrfs_root *root,
 
 		errors++;
 		fprintf(stderr, "fs tree %llu refs %u %s\n",
-			(unsigned long long)rec->objectid, rec->found_ref,
-			 rec->found_root_item ? "" : "not found");
+			rec->objectid, rec->found_ref,
+			rec->found_root_item ? "" : "not found");
 
 		list_for_each_entry(backref, &rec->backrefs, list) {
 			if (!backref->reachable)
 				continue;
 			if (!backref->errors && rec->found_root_item)
 				continue;
-			fprintf(stderr, "\tunresolved ref root %llu dir %llu"
-				" index %llu namelen %u name %s errors %x\n",
-				(unsigned long long)backref->ref_root,
-				(unsigned long long)backref->dir,
-				(unsigned long long)backref->index,
+			fprintf(stderr,
+"\tunresolved ref root %llu dir %llu index %llu namelen %u name %s errors %x\n",
+				backref->ref_root, backref->dir, backref->index,
 				backref->namelen, backref->name,
 				backref->errors);
 			print_ref_error(backref->errors);
@@ -3943,25 +3935,21 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 			if (back->is_data) {
 				dback = to_data_backref(back);
 				fprintf(stderr,
-"data backref %llu %s %llu owner %llu offset %llu num_refs %lu not found in extent tree\n",
-					(unsigned long long)rec->start,
-					back->full_backref ?
-					"parent" : "root",
+"data backref %llu %s %llu owner %llu offset %llu num_refs %u not found in extent tree\n",
+					rec->start,
+					back->full_backref ? "parent" : "root",
 					back->full_backref ?
-					(unsigned long long)dback->parent :
-					(unsigned long long)dback->root,
-					(unsigned long long)dback->owner,
-					(unsigned long long)dback->offset,
-					(unsigned long)dback->num_refs);
+					dback->parent : dback->root,
+					dback->owner, dback->offset,
+					dback->num_refs);
 			} else {
 				tback = to_tree_backref(back);
 				fprintf(stderr,
-"tree backref %llu %s %llu not found in extent tree\n",
-					(unsigned long long)rec->start,
+			"tree backref %llu %s %llu not found in extent tree\n",
+					rec->start,
 					back->full_backref ? "parent" : "root",
 					back->full_backref ?
-					(unsigned long long)tback->parent :
-					(unsigned long long)tback->root);
+					tback->parent : tback->root);
 			}
 		}
 		if (!back->is_data && !back->found_ref) {
@@ -3971,11 +3959,10 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 			tback = to_tree_backref(back);
 			fprintf(stderr,
 				"backref %llu %s %llu not referenced back %p\n",
-				(unsigned long long)rec->start,
+				rec->start,
 				back->full_backref ? "parent" : "root",
 				back->full_backref ?
-				(unsigned long long)tback->parent :
-				(unsigned long long)tback->root, back);
+				tback->parent : tback->root, back);
 		}
 		if (back->is_data) {
 			dback = to_data_backref(back);
@@ -3985,16 +3972,12 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 					goto out;
 				fprintf(stderr,
 "incorrect local backref count on %llu %s %llu owner %llu offset %llu found %u wanted %u back %p\n",
-					(unsigned long long)rec->start,
-					back->full_backref ?
-					"parent" : "root",
+					rec->start,
+					back->full_backref ? "parent" : "root",
 					back->full_backref ?
-					(unsigned long long)dback->parent :
-					(unsigned long long)dback->root,
-					(unsigned long long)dback->owner,
-					(unsigned long long)dback->offset,
-					dback->found_ref, dback->num_refs,
-					back);
+					dback->parent : dback->root,
+					dback->owner, dback->offset,
+					dback->found_ref, dback->num_refs, back);
 			}
 			if (dback->disk_bytenr != rec->start) {
 				err = 1;
@@ -4002,8 +3985,7 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 					goto out;
 				fprintf(stderr,
 "backref disk bytenr does not match extent record, bytenr=%llu, ref bytenr=%llu\n",
-					(unsigned long long)rec->start,
-					(unsigned long long)dback->disk_bytenr);
+					rec->start, dback->disk_bytenr);
 			}
 
 			if (dback->bytes != rec->nr) {
@@ -4012,9 +3994,7 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 					goto out;
 				fprintf(stderr,
 "backref bytes do not match extent backref, bytenr=%llu, ref bytes=%llu, backref bytes=%llu\n",
-					(unsigned long long)rec->start,
-					(unsigned long long)rec->nr,
-					(unsigned long long)dback->bytes);
+					rec->start, rec->nr, dback->bytes);
 			}
 		}
 		if (!back->is_data) {
@@ -4030,9 +4010,7 @@ static int all_backpointers_checked(struct extent_record *rec, int print_errs)
 			goto out;
 		fprintf(stderr,
 	"incorrect global backref count on %llu found %llu wanted %llu\n",
-			(unsigned long long)rec->start,
-			(unsigned long long)found,
-			(unsigned long long)rec->refs);
+			rec->start, found, rec->refs);
 	}
 out:
 	return err;
@@ -4298,8 +4276,7 @@ static int delete_bogus_item(struct btrfs_root *root,
 		return -1;
 
 	printf("Deleting bogus item [%llu,%u,%llu] at slot %d on block %llu\n",
-	       (unsigned long long)key.objectid, key.type,
-	       (unsigned long long)key.offset, slot, buf->start);
+	       key.objectid, key.type, key.offset, slot, buf->start);
 	memmove_extent_buffer(buf, btrfs_item_nr_offset(buf, slot),
 			      btrfs_item_nr_offset(buf, slot + 1),
 			      sizeof(struct btrfs_item) *
@@ -4360,7 +4337,7 @@ again:
 			continue;
 
 		printf("Shifting item nr %d by %u bytes in block %llu\n",
-		       i, shift, (unsigned long long)buf->start);
+		       i, shift, buf->start);
 		offset = btrfs_item_offset(buf, i);
 		memmove_extent_buffer(buf,
 				      btrfs_leaf_data(buf) + offset + shift,
@@ -4498,7 +4475,7 @@ static int check_block(struct btrfs_root *root,
 		if (status != BTRFS_TREE_BLOCK_CLEAN) {
 			ret = -EIO;
 			fprintf(stderr, "bad block %llu\n",
-				(unsigned long long)buf->start);
+				buf->start);
 		} else {
 			/*
 			 * Signal to callers we need to start the scan over
@@ -4741,11 +4718,8 @@ static int add_extent_rec(struct cache_tree *extent_cache,
 			if (rec->extent_item_refs) {
 				fprintf(stderr,
 			"block %llu rec extent_item_refs %llu, passed %llu\n",
-					(unsigned long long)tmpl->start,
-					(unsigned long long)
-							rec->extent_item_refs,
-					(unsigned long long)
-							tmpl->extent_item_refs);
+					tmpl->start, rec->extent_item_refs,
+					tmpl->extent_item_refs);
 			}
 			rec->extent_item_refs = tmpl->extent_item_refs;
 		}
@@ -4831,18 +4805,14 @@ static int add_tree_backref(struct cache_tree *extent_cache, u64 bytenr,
 		if (back->node.found_ref) {
 			fprintf(stderr,
 	"Extent back ref already exists for %llu parent %llu root %llu\n",
-				(unsigned long long)bytenr,
-				(unsigned long long)parent,
-				(unsigned long long)root);
+				bytenr, parent, root);
 		}
 		back->node.found_ref = 1;
 	} else {
 		if (back->node.found_extent_tree) {
 			fprintf(stderr,
 	"extent back ref already exists for %llu parent %llu root %llu\n",
-				(unsigned long long)bytenr,
-				(unsigned long long)parent,
-				(unsigned long long)root);
+				bytenr, parent, root);
 		}
 		back->node.found_extent_tree = 1;
 	}
@@ -4930,13 +4900,9 @@ static int add_data_backref(struct cache_tree *extent_cache, u64 bytenr,
 	} else {
 		if (back->node.found_extent_tree) {
 			fprintf(stderr,
-"Extent back ref already exists for %llu parent %llu root %llu owner %llu offset %llu num_refs %lu\n",
-				(unsigned long long)bytenr,
-				(unsigned long long)parent,
-				(unsigned long long)root,
-				(unsigned long long)owner,
-				(unsigned long long)offset,
-				(unsigned long)num_refs);
+"Extent back ref already exists for %llu parent %llu root %llu owner %llu offset %llu num_refs %u\n",
+				bytenr, parent, root, owner, offset,
+				num_refs);
 		}
 		back->num_refs = num_refs;
 		back->node.found_extent_tree = 1;
@@ -6944,12 +6910,10 @@ static int record_extent(struct btrfs_trans_handle *trans,
 		}
 		fprintf(stderr,
 "adding new data backref on %llu %s %llu owner %llu offset %llu found %d\n",
-			(unsigned long long)rec->start,
+			rec->start,
 			back->full_backref ? "parent" : "root",
-			back->full_backref ? (unsigned long long)parent :
-					     (unsigned long long)dback->root,
-			(unsigned long long)dback->owner,
-			(unsigned long long)dback->offset, dback->found_ref);
+			back->full_backref ? parent : dback->root,
+			dback->owner, dback->offset, dback->found_ref);
 	} else {
 		u64 parent;
 		struct tree_backref *tback;
@@ -7787,7 +7751,7 @@ out:
 
 	if (!ret)
 		fprintf(stderr, "Repaired extent references for %llu\n",
-				(unsigned long long)rec->start);
+			rec->start);
 
 	btrfs_release_path(&path);
 	return ret;
@@ -7832,7 +7796,7 @@ retry:
 			goto retry;
 		}
 		fprintf(stderr, "Didn't find extent for %llu\n",
-			(unsigned long long)rec->start);
+			rec->start);
 		btrfs_release_path(&path);
 		btrfs_commit_transaction(trans, root);
 		return -ENOENT;
@@ -7843,11 +7807,11 @@ retry:
 	flags = btrfs_extent_flags(path.nodes[0], ei);
 	if (rec->flag_block_full_backref) {
 		fprintf(stderr, "setting full backref on %llu\n",
-			(unsigned long long)key.objectid);
+			key.objectid);
 		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
 	} else {
 		fprintf(stderr, "clearing full backref on %llu\n",
-			(unsigned long long)key.objectid);
+			key.objectid);
 		flags &= ~BTRFS_BLOCK_FLAG_FULL_BACKREF;
 	}
 	btrfs_set_extent_flags(path.nodes[0], ei, flags);
@@ -7856,7 +7820,7 @@ retry:
 	ret = btrfs_commit_transaction(trans, root);
 	if (!ret)
 		fprintf(stderr, "Repaired extent flags for %llu\n",
-				(unsigned long long)rec->start);
+			rec->start);
 
 	return ret;
 }
@@ -8192,7 +8156,7 @@ static int check_extent_refs(struct btrfs_root *root,
 		if (rec->num_duplicates) {
 			fprintf(stderr,
 				"extent item %llu has multiple extent items\n",
-				(unsigned long long)rec->start);
+				rec->start);
 			cur_err = 1;
 		}
 
@@ -8214,19 +8178,19 @@ static int check_extent_refs(struct btrfs_root *root,
 		}
 		if (rec->refs != rec->extent_item_refs) {
 			fprintf(stderr, "ref mismatch on [%llu %llu] ",
-				(unsigned long long)rec->start,
-				(unsigned long long)rec->nr);
+				rec->start,
+				rec->nr);
 			fprintf(stderr, "extent item %llu, found %llu\n",
-				(unsigned long long)rec->extent_item_refs,
-				(unsigned long long)rec->refs);
+				rec->extent_item_refs,
+				rec->refs);
 			fix = 1;
 			cur_err = 1;
 		}
 
 		if (!IS_ALIGNED(rec->start, gfs_info->sectorsize)) {
 			fprintf(stderr, "unaligned extent rec on [%llu %llu]\n",
-				(unsigned long long)rec->start,
-				(unsigned long long)rec->nr);
+				rec->start,
+				rec->nr);
 			ret = record_unaligned_extent_rec(rec);
 			if (ret)
 				goto repair_abort;
@@ -8237,15 +8201,15 @@ static int check_extent_refs(struct btrfs_root *root,
 
 		if (all_backpointers_checked(rec, 1)) {
 			fprintf(stderr, "backpointer mismatch on [%llu %llu]\n",
-				(unsigned long long)rec->start,
-				(unsigned long long)rec->nr);
+				rec->start,
+				rec->nr);
 			fix = 1;
 			cur_err = 1;
 		}
 		if (!rec->owner_ref_checked) {
 			fprintf(stderr, "owner ref check failed [%llu %llu]\n",
-				(unsigned long long)rec->start,
-				(unsigned long long)rec->nr);
+				rec->start,
+				rec->nr);
 			fix = 1;
 			cur_err = 1;
 		}
@@ -8259,7 +8223,7 @@ static int check_extent_refs(struct btrfs_root *root,
 
 		if (rec->bad_full_backref) {
 			fprintf(stderr, "bad full backref, on [%llu]\n",
-				(unsigned long long)rec->start);
+				rec->start);
 			if (repair) {
 				ret = fixup_extent_flags(rec);
 				if (ret)
@@ -10412,7 +10376,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				}
 				bytenr = btrfs_sb_offset(((int)num));
 				printf("using SB copy %llu, bytenr %llu\n", num,
-				       (unsigned long long)bytenr);
+				       bytenr);
 				break;
 			case 'Q':
 				qgroup_report = 1;
@@ -10891,24 +10855,18 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		err |= !!ret;
 	}
 out:
-	printf("found %llu bytes used, ",
-	       (unsigned long long)bytes_used);
+	printf("found %llu bytes used, ", bytes_used);
 	if (err)
 		printf("error(s) found\n");
 	else
 		printf("no error found\n");
-	printf("total csum bytes: %llu\n",(unsigned long long)total_csum_bytes);
-	printf("total tree bytes: %llu\n",
-	       (unsigned long long)total_btree_bytes);
-	printf("total fs tree bytes: %llu\n",
-	       (unsigned long long)total_fs_tree_bytes);
-	printf("total extent tree bytes: %llu\n",
-	       (unsigned long long)total_extent_tree_bytes);
-	printf("btree space waste bytes: %llu\n",
-	       (unsigned long long)btree_space_waste);
+	printf("total csum bytes: %llu\n", total_csum_bytes);
+	printf("total tree bytes: %llu\n", total_btree_bytes);
+	printf("total fs tree bytes: %llu\n", total_fs_tree_bytes);
+	printf("total extent tree bytes: %llu\n", total_extent_tree_bytes);
+	printf("btree space waste bytes: %llu\n", btree_space_waste);
 	printf("file data blocks allocated: %llu\n referenced %llu\n",
-		(unsigned long long)data_bytes_allocated,
-		(unsigned long long)data_bytes_referenced);
+		data_bytes_allocated, data_bytes_referenced);
 
 	free_qgroup_counts();
 	free_root_recs_tree(&root_cache);
diff --git a/check/mode-common.c b/check/mode-common.c
index 26e2c0c98b45..a906a5852a46 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -390,10 +390,9 @@ int insert_inode_item(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_inode(trans, root, ino, &ii);
 	ASSERT(!ret);
 
-	warning("root %llu inode %llu recreating inode item, this may "
-		"be incomplete, please check permissions and content after "
-		"the fsck completes.\n", (unsigned long long)root->objectid,
-		(unsigned long long)ino);
+	warning(
+"root %llu inode %llu recreating inode item, this may be incomplete, please check permissions and content after the fsck completes.",
+		root->objectid, ino);
 
 	return 0;
 }
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 0b7799303770..eabe54fb4ba6 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -340,14 +340,13 @@ static int find_parent_roots(struct ulist *roots, u64 parent)
 	ref = find_ref_bytenr(parent);
 	if (!ref) {
 		error("bytenr ref not found for parent %llu",
-				(unsigned long long)parent);
+		      parent);
 		return -EIO;
 	}
 	node = &ref->bytenr_node;
 	if (ref->bytenr != parent) {
 		error("found bytenr ref does not match parent: %llu != %llu",
-				(unsigned long long)ref->bytenr,
-				(unsigned long long)parent);
+		      ref->bytenr, parent);
 		return -EIO;
 	}
 
@@ -364,7 +363,7 @@ static int find_parent_roots(struct ulist *roots, u64 parent)
 			if (prev->bytenr == parent) {
 				error(
 				"unexpected: prev bytenr same as parent: %llu",
-						(unsigned long long)parent);
+				      parent);
 				return -EIO;
 			}
 		}
@@ -640,8 +639,7 @@ static void print_tree_block(u64 bytenr, struct tree_block *block)
 	struct ref *ref;
 	struct rb_node *node;
 
-	printf("tree block: %llu\t\tlevel: %d\n", (unsigned long long)bytenr,
-	       block->level);
+	printf("tree block: %llu\t\tlevel: %d\n", bytenr, block->level);
 
 	ref = find_ref_bytenr(bytenr);
 	node = &ref->bytenr_node;
@@ -1264,8 +1262,7 @@ static void print_fields(u64 bytes, u64 bytes_compressed, char *prefix,
 			 char *type)
 {
 	printf("%s\t\t%s %llu %s compressed %llu\n",
-	       prefix, type, (unsigned long long)bytes, type,
-	       (unsigned long long)bytes_compressed);
+	       prefix, type, bytes, type, bytes_compressed);
 }
 
 static void print_fields_signed(long long bytes,
diff --git a/cmds/balance.c b/cmds/balance.c
index 7abc69d92645..35b1ae2112e4 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -76,10 +76,10 @@ __attribute__ ((unused))
 static void print_range(u64 start, u64 end)
 {
 	if (start)
-		printf("%llu", (unsigned long long)start);
+		printf("%llu", start);
 	printf("..");
 	if (end != (u64)-1)
-		printf("%llu", (unsigned long long)end);
+		printf("%llu", end);
 }
 
 __attribute__ ((unused))
@@ -228,32 +228,30 @@ static void dump_balance_args(struct btrfs_balance_args *args)
 {
 	if (args->flags & BTRFS_BALANCE_ARGS_CONVERT) {
 		printf("converting, target=%llu, soft is %s",
-		       (unsigned long long)args->target,
+		       args->target,
 		       (args->flags & BTRFS_BALANCE_ARGS_SOFT) ? "on" : "off");
 	} else {
 		printf("balancing");
 	}
 
 	if (args->flags & BTRFS_BALANCE_ARGS_PROFILES)
-		printf(", profiles=%llu", (unsigned long long)args->profiles);
+		printf(", profiles=%llu", args->profiles);
 	if (args->flags & BTRFS_BALANCE_ARGS_USAGE)
-		printf(", usage=%llu", (unsigned long long)args->usage);
+		printf(", usage=%llu", args->usage);
 	if (args->flags & BTRFS_BALANCE_ARGS_USAGE_RANGE) {
 		printf(", usage=");
 		print_range_u32(args->usage_min, args->usage_max);
 	}
 	if (args->flags & BTRFS_BALANCE_ARGS_DEVID)
-		printf(", devid=%llu", (unsigned long long)args->devid);
+		printf(", devid=%llu", args->devid);
 	if (args->flags & BTRFS_BALANCE_ARGS_DRANGE)
 		printf(", drange=%llu..%llu",
-		       (unsigned long long)args->pstart,
-		       (unsigned long long)args->pend);
+		       args->pstart, args->pend);
 	if (args->flags & BTRFS_BALANCE_ARGS_VRANGE)
 		printf(", vrange=%llu..%llu",
-		       (unsigned long long)args->vstart,
-		       (unsigned long long)args->vend);
+		       args->vstart, args->vend);
 	if (args->flags & BTRFS_BALANCE_ARGS_LIMIT)
-		printf(", limit=%llu", (unsigned long long)args->limit);
+		printf(", limit=%llu", args->limit);
 	if (args->flags & BTRFS_BALANCE_ARGS_LIMIT_RANGE) {
 		printf(", limit=");
 		print_range_u32(args->limit_min, args->limit_max);
@@ -269,21 +267,21 @@ static void dump_balance_args(struct btrfs_balance_args *args)
 static void dump_ioctl_balance_args(struct btrfs_ioctl_balance_args *args)
 {
 	printf("Dumping filters: flags 0x%llx, state 0x%llx, force is %s\n",
-	       (unsigned long long)args->flags, (unsigned long long)args->state,
+	       args->flags, args->state,
 	       (args->flags & BTRFS_BALANCE_FORCE) ? "on" : "off");
 	if (args->flags & BTRFS_BALANCE_DATA) {
 		printf("  DATA (flags 0x%llx): ",
-		       (unsigned long long)args->data.flags);
+		       args->data.flags);
 		dump_balance_args(&args->data);
 	}
 	if (args->flags & BTRFS_BALANCE_METADATA) {
 		printf("  METADATA (flags 0x%llx): ",
-		       (unsigned long long)args->meta.flags);
+		       args->meta.flags);
 		dump_balance_args(&args->meta);
 	}
 	if (args->flags & BTRFS_BALANCE_SYSTEM) {
 		printf("  SYSTEM (flags 0x%llx): ",
-		       (unsigned long long)args->sys.flags);
+		       args->sys.flags);
 		dump_balance_args(&args->sys);
 	}
 }
@@ -353,8 +351,8 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	} else {
 		pr_verbose(MUST_LOG,
 			   "Done, had to relocate %llu out of %llu chunks\n",
-			   (unsigned long long)args->stat.completed,
-			   (unsigned long long)args->stat.considered);
+			   args->stat.completed,
+			   args->stat.considered);
 	}
 
 out:
@@ -745,8 +743,8 @@ static int cmd_balance_resume(const struct cmd_struct *cmd,
 	} else {
 		pr_verbose(MUST_LOG,
 			   "Done, had to relocate %llu out of %llu chunks\n",
-			   (unsigned long long)args.stat.completed,
-			   (unsigned long long)args.stat.considered);
+			   args.stat.completed,
+			   args.stat.considered);
 	}
 
 	close_file_or_dir(fd, dirstream);
@@ -833,10 +831,8 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 		printf("Balance on '%s' is paused\n", path);
 	}
 
-	printf("%llu out of about %llu chunks balanced (%llu considered), "
-	       "%3.f%% left\n", (unsigned long long)args.stat.completed,
-	       (unsigned long long)args.stat.expected,
-	       (unsigned long long)args.stat.considered,
+	printf("%llu out of about %llu chunks balanced (%llu considered), %3.f%% left\n",
+	       args.stat.completed, args.stat.expected, args.stat.considered,
 	       100 * (1 - (float)args.stat.completed/args.stat.expected));
 
 	if (bconf.verbose > BTRFS_BCONF_QUIET)
diff --git a/cmds/device.c b/cmds/device.c
index 7d3febff96c2..4c1b82faa9e3 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -303,7 +303,7 @@ static int _cmd_device_remove(const struct cmd_struct *cmd,
 				msg = strerror(errno);
 			if (is_devid) {
 				error("error removing devid %llu: %s",
-					(unsigned long long)argv2.devid, msg);
+					argv2.devid, msg);
 			} else {
 				error("error removing device '%s': %s",
 					argv[i], msg);
@@ -711,7 +711,6 @@ static int cmd_device_stats(const struct cmd_struct *cmd, int argc, char **argv)
 					printf("[%s].%-16s %llu\n",
 						canonical_path,
 						dev_stats[j].name,
-						(unsigned long long)
 						args.values[dev_stats[j].num]);
 				}
 				if ((check == 1)
diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 7ea2da852db4..3747be64cf5e 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -336,7 +336,7 @@ static int du_calc_file_space(int fd, struct rb_root *shared_extents,
 
 			if (ext_len == 0) {
 				warning("extent %llu has length 0, skipping",
-					(unsigned long long)fm_ext[i].fe_physical);
+					fm_ext[i].fe_physical);
 				continue;
 			}
 
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 01729e1886ac..e99f774189f0 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -721,7 +721,7 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
 		if (ndevs >= fi_args.num_devices) {
 			error("unexpected number of devices: %d >= %llu", ndevs,
-				(unsigned long long)fi_args.num_devices);
+				fi_args.num_devices);
 			error(
 		"if seed device is used, try running this command as root");
 			goto out;
@@ -761,7 +761,7 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 
 	if (ndevs != fi_args.num_devices) {
 		error("unexpected number of devices: %d != %llu", ndevs,
-				(unsigned long long)fi_args.num_devices);
+			fi_args.num_devices);
 		goto out;
 	}
 
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7cd08fcd5f62..452f7395cc8c 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -237,7 +237,7 @@ static void print_devices(struct btrfs_fs_devices *fs_devices,
 	list_sort(NULL, all_devices, cmp_device_id);
 	list_for_each_entry(device, all_devices, dev_list) {
 		printf("\tdevid %4llu size %s used %s path %s\n",
-		       (unsigned long long)device->devid,
+		       device->devid,
 		       pretty_size_mode(device->total_bytes, unit_mode),
 		       pretty_size_mode(device->bytes_used, unit_mode),
 		       device->name);
@@ -267,8 +267,7 @@ static void print_one_uuid(struct btrfs_fs_devices *fs_devices,
 
 	total = device->total_devs;
 	printf(" uuid: %s\n\tTotal devices %llu FS bytes used %s\n", uuidbuf,
-	       (unsigned long long)total,
-	       pretty_size_mode(device->super_bytes_used, unit_mode));
+	       total, pretty_size_mode(device->super_bytes_used, unit_mode));
 
 	print_devices(fs_devices, &devs_found, unit_mode);
 
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index d8435624df90..786a4348802f 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -43,7 +43,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 			return 0;
 
 		error("failed to read the superblock on %s at %llu",
-				filename, (unsigned long long)sb_bytenr);
+				filename, sb_bytenr);
 		error("error = '%m', errno = %d", errno);
 		return 1;
 	}
@@ -51,7 +51,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 	printf("---------------------------------------------------------\n");
 	if (btrfs_super_magic(&sb) != BTRFS_MAGIC && !force) {
 		error("bad magic on superblock on %s at %llu",
-				filename, (unsigned long long)sb_bytenr);
+				filename, sb_bytenr);
 	} else {
 		btrfs_print_superblock(&sb, full);
 	}
@@ -133,7 +133,7 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 			if (BTRFS_SUPER_MIRROR_MAX <= arg) {
 				warning(
 		"deprecated use of -s <bytenr> with %llu, assuming --bytenr",
-						(unsigned long long)arg);
+					arg);
 				sb_bytenr = arg;
 			} else {
 				sb_bytenr = btrfs_sb_offset(arg);
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index daa7f9255139..a4f3e1377c71 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -96,33 +96,33 @@ static void print_old_roots(struct btrfs_super_block *super)
 		backup = super->super_roots + i;
 		printf("btrfs root backup slot %d\n", i);
 		printf("\ttree root gen %llu block %llu\n",
-		       (unsigned long long)btrfs_backup_tree_root_gen(backup),
-		       (unsigned long long)btrfs_backup_tree_root(backup));
+		       btrfs_backup_tree_root_gen(backup),
+		       btrfs_backup_tree_root(backup));
 
 		printf("\t\t%s gen %llu block %llu\n", extent_tree_str,
-		       (unsigned long long)btrfs_backup_extent_root_gen(backup),
-		       (unsigned long long)btrfs_backup_extent_root(backup));
+		       btrfs_backup_extent_root_gen(backup),
+		       btrfs_backup_extent_root(backup));
 
 		printf("\t\tchunk root gen %llu block %llu\n",
-		       (unsigned long long)btrfs_backup_chunk_root_gen(backup),
-		       (unsigned long long)btrfs_backup_chunk_root(backup));
+		       btrfs_backup_chunk_root_gen(backup),
+		       btrfs_backup_chunk_root(backup));
 
 		printf("\t\tdevice root gen %llu block %llu\n",
-		       (unsigned long long)btrfs_backup_dev_root_gen(backup),
-		       (unsigned long long)btrfs_backup_dev_root(backup));
+		       btrfs_backup_dev_root_gen(backup),
+		       btrfs_backup_dev_root(backup));
 
 		printf("\t\tcsum root gen %llu block %llu\n",
-		       (unsigned long long)btrfs_backup_csum_root_gen(backup),
-		       (unsigned long long)btrfs_backup_csum_root(backup));
+		       btrfs_backup_csum_root_gen(backup),
+		       btrfs_backup_csum_root(backup));
 
 		printf("\t\tfs root gen %llu block %llu\n",
-		       (unsigned long long)btrfs_backup_fs_root_gen(backup),
-		       (unsigned long long)btrfs_backup_fs_root(backup));
+		       btrfs_backup_fs_root_gen(backup),
+		       btrfs_backup_fs_root(backup));
 
 		printf("\t\t%llu used %llu total %llu devices\n",
-		       (unsigned long long)btrfs_backup_bytes_used(backup),
-		       (unsigned long long)btrfs_backup_total_bytes(backup),
-		       (unsigned long long)btrfs_backup_num_devices(backup));
+		       btrfs_backup_bytes_used(backup),
+		       btrfs_backup_total_bytes(backup),
+		       btrfs_backup_num_devices(backup));
 	}
 }
 
@@ -506,10 +506,10 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	if (!(extent_only || uuid_tree_only || tree_id)) {
 		if (roots_only) {
 			printf("root tree: %llu level %d\n",
-			     (unsigned long long)info->tree_root->node->start,
+			     info->tree_root->node->start,
 			     btrfs_header_level(info->tree_root->node));
 			printf("chunk tree: %llu level %d\n",
-			     (unsigned long long)info->chunk_root->node->start,
+			     info->chunk_root->node->start,
 			     btrfs_header_level(info->chunk_root->node));
 			if (info->log_root_tree)
 				printf("log root tree: %llu level %d\n",
@@ -608,7 +608,7 @@ again:
 	if (ret < 0) {
 		errno = -ret;
 		error("cannot read ROOT_ITEM from tree %llu: %m",
-			(unsigned long long)tree_root_scan->root_key.objectid);
+			tree_root_scan->root_key.objectid);
 		goto close_root;
 	}
 	while (1) {
@@ -743,7 +743,7 @@ again:
 				btrfs_print_key(&disk_key);
 				if (roots_only) {
 					printf(" %llu level %d\n",
-					       (unsigned long long)buf->start,
+					       buf->start,
 					       btrfs_header_level(buf));
 				} else {
 					printf(" \n");
@@ -771,9 +771,9 @@ no_node:
 		print_old_roots(info->super_copy);
 
 	printf("total bytes %llu\n",
-	       (unsigned long long)btrfs_super_total_bytes(info->super_copy));
+	       btrfs_super_total_bytes(info->super_copy));
 	printf("bytes used %llu\n",
-	       (unsigned long long)btrfs_super_bytes_used(info->super_copy));
+	       btrfs_super_bytes_used(info->super_copy));
 	uuidbuf[BTRFS_UUID_UNPARSED_SIZE - 1] = '\0';
 	uuid_unparse(info->super_copy->fsid, uuidbuf);
 	printf("uuid %s\n", uuidbuf);
diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index 0731675cb94f..f8f6e6174320 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -179,7 +179,7 @@ static int walk_nodes(struct btrfs_root *root, struct btrfs_path *path,
 				stat->max_seek_len = distance;
 			if (add_seek(&stat->seek_root, distance)) {
 				error("cannot add new seek at distance %llu",
-						(unsigned long long)distance);
+					distance);
 				ret = -ENOMEM;
 				break;
 			}
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 1534f2040f4e..a94930efb639 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -335,7 +335,7 @@ static int cmd_inspect_subvolid_resolve(const struct cmd_struct *cmd,
 
 	if (ret) {
 		error("resolving subvolid %llu error %d",
-			(unsigned long long)subvol_id, ret);
+			subvol_id, ret);
 		goto out;
 	}
 
@@ -380,7 +380,7 @@ static int cmd_inspect_rootid(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	printf("%llu\n", (unsigned long long)rootid);
+	printf("%llu\n", rootid);
 out:
 	close_file_or_dir(fd, dirstream);
 
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 139dca970f6e..dd94eb2c0d3b 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -671,8 +671,7 @@ static struct btrfs_qgroup *get_or_add_qgroup(
 	ret = qgroup_tree_insert(qgroup_lookup, bq);
 	if (ret) {
 		errno = -ret;
-		error("failed to insert %llu into tree: %m",
-		       (unsigned long long)bq->qgroupid);
+		error("failed to insert %llu into tree: %m", bq->qgroupid);
 		free(bq);
 		return ERR_PTR(ret);
 	}
diff --git a/cmds/receive.c b/cmds/receive.c
index d106e55453c5..a97c690bc7cd 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -972,8 +972,7 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
 {
 	if (bconf.verbose >= 3)
 		fprintf(stderr, "update_extent %s: offset=%llu, len=%llu\n",
-				path, (unsigned long long)offset,
-				(unsigned long long)len);
+			path, offset, len);
 
 	/*
 	 * Sent with BTRFS_SEND_FLAG_NO_FILE_DATA, nothing to do.
diff --git a/cmds/replace.c b/cmds/replace.c
index 23f5dccaf46e..02deca28812f 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -501,9 +501,8 @@ static int print_replace_status(int fd, const char *path, int once)
 		if (!skip_stats)
 			num_chars += printf(
 				", %llu write errs, %llu uncorr. read errs",
-				(unsigned long long)status->num_write_errors,
-				(unsigned long long)
-				 status->num_uncorrectable_read_errors);
+				status->num_write_errors,
+				status->num_uncorrectable_read_errors);
 		if (once || prevent_loop) {
 			printf("\n");
 			break;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index ec5c206f85e7..61ba0d4f6093 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1920,7 +1920,7 @@ static int insert_stripe(struct list_head *devexts,
 		return -ENOENT;
 	if (btrfs_find_device_by_devid(rc->fs_devices, devext->objectid, 1)) {
 		error("unexpected: found another device with id %llu",
-				(unsigned long long)devext->objectid);
+		      devext->objectid);
 		return -EINVAL;
 	}
 
@@ -2223,8 +2223,7 @@ static int btrfs_recover_chunks(struct recover_control *rc)
 		ret = insert_cache_extent(&rc->chunk, &chunk->cache);
 		if (ret == -EEXIST) {
 			error("duplicate entry in cache start %llu size %llu",
-					(unsigned long long)chunk->cache.start,
-					(unsigned long long)chunk->cache.size);
+			      chunk->cache.start, chunk->cache.size);
 			free(chunk);
 			return ret;
 		}
diff --git a/cmds/rescue.c b/cmds/rescue.c
index ca1c6d741e30..b22e7898ef62 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -203,9 +203,8 @@ static int cmd_rescue_zero_log(const struct cmd_struct *cmd,
 
 	sb = root->fs_info->super_copy;
 	printf("Clearing log on %s, previous log_root %llu, level %u\n",
-			devname,
-			(unsigned long long)btrfs_super_log_root(sb),
-			(unsigned)btrfs_super_log_root_level(sb));
+		devname, btrfs_super_log_root(sb),
+		btrfs_super_log_root_level(sb));
 	btrfs_set_super_log_root(sb, 0);
 	btrfs_set_super_log_root_level(sb, 0);
 	ret = write_all_supers(root->fs_info);
diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 4418fdf0e136..4d439917946d 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -633,7 +633,7 @@ static int add_root(struct rb_root *root_lookup,
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to insert subvolume %llu to tree: %m",
-				(unsigned long long)root_id);
+			root_id);
 		exit(1);
 	}
 	return 0;
@@ -771,7 +771,7 @@ static int lookup_ino_path(int fd, struct root_info *ri)
 			return -ENOENT;
 		}
 		error("failed to lookup path for root %llu: %m",
-			(unsigned long long)ri->ref_tree);
+			ri->ref_tree);
 		return ret;
 	}
 
diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index fbf56566548e..ad1703c8ad95 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -811,7 +811,7 @@ static u64 find_root_gen(int fd)
 	ret = ioctl(fd, BTRFS_IOC_INO_LOOKUP, &ino_args);
 	if (ret < 0) {
 		error("failed to lookup path for dirid %llu: %m",
-			(unsigned long long)BTRFS_FIRST_FREE_OBJECTID);
+			BTRFS_FIRST_FREE_OBJECTID);
 		return 0;
 	}
 
@@ -896,7 +896,7 @@ static char *__ino_resolve(int fd, u64 dirid)
 	ret = ioctl(fd, BTRFS_IOC_INO_LOOKUP, &args);
 	if (ret < 0) {
 		error("failed to lookup path for dirid %llu: %m",
-			(unsigned long long)dirid);
+			dirid);
 		return ERR_PTR(ret);
 	}
 
@@ -1064,21 +1064,15 @@ static int print_one_extent(int fd, struct btrfs_ioctl_search_header *sh,
 	} else {
 		error(
 	"unhandled extent type %d for inode %llu file offset %llu gen %llu",
-			type,
-			(unsigned long long)btrfs_search_header_objectid(sh),
-			(unsigned long long)btrfs_search_header_offset(sh),
-			(unsigned long long)found_gen);
+			type, btrfs_search_header_objectid(sh),
+			btrfs_search_header_offset(sh), found_gen);
 
 		return -EIO;
 	}
-	printf("inode %llu file offset %llu len %llu disk start %llu "
-	       "offset %llu gen %llu flags ",
-	       (unsigned long long)btrfs_search_header_objectid(sh),
-	       (unsigned long long)btrfs_search_header_offset(sh),
-	       (unsigned long long)len,
-	       (unsigned long long)disk_start,
-	       (unsigned long long)disk_offset,
-	       (unsigned long long)found_gen);
+	printf(
+"inode %llu file offset %llu len %llu disk start %llu offset %llu gen %llu flags ",
+	       btrfs_search_header_objectid(sh), btrfs_search_header_offset(sh),
+	       len, disk_start, disk_offset, found_gen);
 
 	if (compressed) {
 		printf("COMPRESS");
@@ -1192,7 +1186,7 @@ static int btrfs_list_find_updated_files(int fd, u64 root_id, u64 oldest_gen)
 	}
 	free(cache_dir_name);
 	free(cache_full_name);
-	printf("transid marker was %llu\n", (unsigned long long)max_found);
+	printf("transid marker was %llu\n", max_found);
 	return ret;
 }
 
diff --git a/common/parse-utils.c b/common/parse-utils.c
index 062cb6931d84..10948765c739 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -76,8 +76,7 @@ int parse_range(const char *range, u64 *start, u64 *end)
 
 	if (*start > *end) {
 		error("range %llu..%llu doesn't make sense",
-			(unsigned long long)*start,
-			(unsigned long long)*end);
+			*start, *end);
 		return 1;
 	}
 
@@ -127,8 +126,7 @@ int parse_range_strict(const char *range, u64 *start, u64 *end)
 	if (parse_range(range, start, end) == 0) {
 		if (*start >= *end) {
 			error("range %llu..%llu not allowed",
-				(unsigned long long)*start,
-				(unsigned long long)*end);
+				*start, *end);
 			return 1;
 		}
 		return 0;
diff --git a/common/send-utils.c b/common/send-utils.c
index 4ed448b1f306..9cd84a83a309 100644
--- a/common/send-utils.c
+++ b/common/send-utils.c
@@ -215,14 +215,14 @@ static int btrfs_subvolid_resolve_sub(int fd, char *path, size_t *path_len,
 	if (ret < 0) {
 		fprintf(stderr,
 			"ioctl(BTRFS_IOC_TREE_SEARCH, subvol_id %llu) ret=%d, error: %m\n",
-			(unsigned long long)subvol_id, ret);
+			subvol_id, ret);
 		return ret;
 	}
 
 	if (search_arg.key.nr_items < 1) {
 		fprintf(stderr,
 			"failed to lookup subvol_id %llu!\n",
-			(unsigned long long)subvol_id);
+			subvol_id);
 		return -ENOENT;
 	}
 	search_header = (struct btrfs_ioctl_search_header *)search_arg.buf;
diff --git a/convert/common.c b/convert/common.c
index 0fb7b6c510c6..1dcd63ec219c 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -248,19 +248,10 @@ static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 	 */
 	if (!(root_bytenr < extent_bytenr && extent_bytenr < dev_bytenr &&
 	      dev_bytenr < fs_bytenr && fs_bytenr < csum_bytenr)) {
-		error("bad tree bytenr order: "
-				"root < extent %llu < %llu, "
-				"extent < dev %llu < %llu, "
-				"dev < fs %llu < %llu, "
-				"fs < csum %llu < %llu",
-				(unsigned long long)root_bytenr,
-				(unsigned long long)extent_bytenr,
-				(unsigned long long)extent_bytenr,
-				(unsigned long long)dev_bytenr,
-				(unsigned long long)dev_bytenr,
-				(unsigned long long)fs_bytenr,
-				(unsigned long long)fs_bytenr,
-				(unsigned long long)csum_bytenr);
+		error(
+"bad tree bytenr order: root < extent %llu < %llu, extent < dev %llu < %llu, dev < fs %llu < %llu, fs < csum %llu < %llu",
+		      root_bytenr, extent_bytenr, extent_bytenr, dev_bytenr,
+		      dev_bytenr, fs_bytenr, fs_bytenr, csum_bytenr);
 		return -EINVAL;
 	}
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
@@ -425,8 +416,8 @@ static int setup_temp_chunk_tree(int fd, struct btrfs_mkfs_config *cfg,
 	/* Must ensure SYS chunk starts before META chunk */
 	if (meta_chunk_start < sys_chunk_start) {
 		error("wrong chunk order: meta < system %llu < %llu",
-				(unsigned long long)meta_chunk_start,
-				(unsigned long long)sys_chunk_start);
+			meta_chunk_start,
+			sys_chunk_start);
 		return -EINVAL;
 	}
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
@@ -496,8 +487,8 @@ static int setup_temp_dev_tree(int fd, struct btrfs_mkfs_config *cfg,
 	/* Must ensure SYS chunk starts before META chunk */
 	if (meta_chunk_start < sys_chunk_start) {
 		error("wrong chunk order: meta < system %llu < %llu",
-				(unsigned long long)meta_chunk_start,
-				(unsigned long long)sys_chunk_start);
+			meta_chunk_start,
+			sys_chunk_start);
 		return -EINVAL;
 	}
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
@@ -698,22 +689,11 @@ static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 	if (!(chunk_bytenr < root_bytenr && root_bytenr < extent_bytenr &&
 	      extent_bytenr < dev_bytenr && dev_bytenr < fs_bytenr &&
 	      fs_bytenr < csum_bytenr)) {
-		error("bad tree bytenr order: "
-				"chunk < root %llu < %llu, "
-				"root < extent %llu < %llu, "
-				"extent < dev %llu < %llu, "
-				"dev < fs %llu < %llu, "
-				"fs < csum %llu < %llu",
-				(unsigned long long)chunk_bytenr,
-				(unsigned long long)root_bytenr,
-				(unsigned long long)root_bytenr,
-				(unsigned long long)extent_bytenr,
-				(unsigned long long)extent_bytenr,
-				(unsigned long long)dev_bytenr,
-				(unsigned long long)dev_bytenr,
-				(unsigned long long)fs_bytenr,
-				(unsigned long long)fs_bytenr,
-				(unsigned long long)csum_bytenr);
+		error(
+"bad tree bytenr order: chunk < root %llu < %llu, root < extent %llu < %llu, extent < dev %llu < %llu, dev < fs %llu < %llu, fs < csum %llu < %llu",
+		      chunk_bytenr, root_bytenr, root_bytenr, extent_bytenr,
+		      extent_bytenr, dev_bytenr, dev_bytenr, fs_bytenr,
+		      fs_bytenr, csum_bytenr);
 		return -EINVAL;
 	}
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
diff --git a/convert/main.c b/convert/main.c
index b72d1e51ee3e..bfc57ecdb617 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -135,8 +135,8 @@ static void *print_copied_inodes(void *p)
 		pthread_mutex_lock(&priv->mutex);
 		printf("Copy inodes [%c] [%10llu/%10llu]\r",
 		       work_indicator[count % 4],
-		       (unsigned long long)priv->cur_copy_inodes,
-		       (unsigned long long)priv->max_copy_inodes);
+		       priv->cur_copy_inodes,
+		       priv->max_copy_inodes);
 		pthread_mutex_unlock(&priv->mutex);
 		fflush(stdout);
 		task_period_wait(priv->info);
@@ -214,13 +214,11 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 	u32 datacsum = convert_flags & CONVERT_FLAG_DATACSUM;
 
 	if (bytenr != round_down(bytenr, root->fs_info->sectorsize)) {
-		error("bytenr not sectorsize aligned: %llu",
-				(unsigned long long)bytenr);
+		error("bytenr not sectorsize aligned: %llu", bytenr);
 		return -EINVAL;
 	}
 	if (len != round_down(len, root->fs_info->sectorsize)) {
-		error("length not sectorsize aligned: %llu",
-				(unsigned long long)len);
+		error("length not sectorsize aligned: %llu", len);
 		return -EINVAL;
 	}
 	len = min_t(u64, len, BTRFS_MAX_EXTENT_SIZE);
@@ -314,8 +312,7 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 	}
 
 	if (len != round_down(len, root->fs_info->sectorsize)) {
-		error("remaining length not sectorsize aligned: %llu",
-				(unsigned long long)len);
+		error("remaining length not sectorsize aligned: %llu", len);
 		return -EINVAL;
 	}
 	ret = btrfs_record_file_extent(trans, root, ino, inode, bytenr,
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 9fad4c50e244..b4b26923b66e 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -149,8 +149,8 @@ static int ext2_read_used_space(struct btrfs_convert_context *cctx)
 
 	block_nbytes = EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
 	if (!block_nbytes) {
-		error("EXT2_CLUSTERS_PER_GROUP too small: %llu",
-			(unsigned long long)(EXT2_CLUSTERS_PER_GROUP(fs->super)));
+		error("EXT2_CLUSTERS_PER_GROUP too small: %u",
+		      (EXT2_CLUSTERS_PER_GROUP(fs->super)));
 		return -EINVAL;
 	}
 
@@ -936,8 +936,8 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		p->cur_copy_inodes++;
 		pthread_mutex_unlock(&p->mutex);
 		if (ret) {
-			error("failed to copy ext2 inode %llu: %d",
-					(unsigned long long)ext2_ino, ret);
+			error("failed to copy ext2 inode %u: %d",
+			      ext2_ino, ret);
 			goto out;
 		}
 		/*
diff --git a/image/main.c b/image/main.c
index c6af0cc2f5bf..75f9203fab12 100644
--- a/image/main.c
+++ b/image/main.c
@@ -686,7 +686,7 @@ static int flush_pending(struct metadump_struct *md, int done)
 				free(async->buffer);
 				free(async);
 				error("unable to read superblock at %llu: %m",
-						(unsigned long long)start);
+					start);
 				return -errno;
 			}
 			size = 0;
@@ -702,7 +702,7 @@ static int flush_pending(struct metadump_struct *md, int done)
 				free(async->buffer);
 				free(async);
 				error("unable to read metadata block %llu",
-					(unsigned long long)start);
+					start);
 				return -EIO;
 			}
 			copy_buffer(md, async->buffer + offset, eb);
@@ -966,7 +966,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 
 		if (num_bytes == 0) {
 			error("extent length 0 at bytenr %llu key type %d",
-					(unsigned long long)bytenr, key.type);
+				bytenr, key.type);
 			ret = -EIO;
 			break;
 		}
@@ -986,7 +986,7 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
 						 is_data);
 				if (ret) {
 					error("unable to add block %llu: %d",
-						(unsigned long long)bytenr, ret);
+						bytenr, ret);
 					break;
 				}
 			}
@@ -1951,8 +1951,7 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 		if (btrfs_header_bytenr(eb) != bytenr) {
 			error(
 			"eb bytenr does not match found bytenr: %llu != %llu",
-				(unsigned long long)btrfs_header_bytenr(eb),
-				(unsigned long long)bytenr);
+				btrfs_header_bytenr(eb), bytenr);
 			ret = -EUCLEAN;
 			break;
 		}
@@ -1967,8 +1966,7 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 		}
 		if (btrfs_header_owner(eb) != BTRFS_CHUNK_TREE_OBJECTID) {
 			error("wrong eb %llu owner %llu",
-				(unsigned long long)bytenr,
-				(unsigned long long)btrfs_header_owner(eb));
+				bytenr, btrfs_header_owner(eb));
 			ret = -EUCLEAN;
 			break;
 		}
@@ -2907,8 +2905,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 			ret = ftruncate64(fileno(out), dev_size);
 			if (ret < 0) {
 				error(
-		"failed to enlarge result image file from %llu to %llu: %m",
-					(unsigned long long)st.st_size, dev_size);
+		"failed to enlarge result image file from %lu to %llu: %m",
+					st.st_size, dev_size);
 				ret = -errno;
 				goto out;
 			}
@@ -2960,9 +2958,7 @@ static int update_disk_super_on_device(struct btrfs_fs_info *info,
 
 	devid = btrfs_device_id(leaf, dev_item);
 	if (devid != cur_devid) {
-		error("devid mismatch: %llu != %llu",
-				(unsigned long long)devid,
-				(unsigned long long)cur_devid);
+		error("devid mismatch: %llu != %llu", devid, cur_devid);
 		ret = -EIO;
 		goto out;
 	}
@@ -3073,8 +3069,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 			num_threads = arg_strtou64(optarg);
 			if (num_threads > MAX_WORKER_THREADS) {
 				error("number of threads out of range: %llu > %d",
-					(unsigned long long)num_threads,
-					MAX_WORKER_THREADS);
+					num_threads, MAX_WORKER_THREADS);
 				return 1;
 			}
 			break;
@@ -3082,7 +3077,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 			compress_level = arg_strtou64(optarg);
 			if (compress_level > 9) {
 				error("compression level out of range: %llu",
-					(unsigned long long)compress_level);
+					compress_level);
 				return 1;
 			}
 			break;
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 758a38820797..42bbd50d86a1 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -528,8 +528,8 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	*/
 	if (trans->transid != root->fs_info->generation) {
 		printk(KERN_CRIT "trans %llu running %llu\n",
-			(unsigned long long)trans->transid,
-			(unsigned long long)root->fs_info->generation);
+			trans->transid,
+			root->fs_info->generation);
 		WARN_ON(1);
 	}
 	if (!should_cow_block(trans, root, buf)) {
@@ -3411,8 +3411,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	} else if (ret < 0) {
 		warning(
 		"inserting uuid item failed (0x%016llx, 0x%016llx) type %u: %d",
-			(unsigned long long)key.objectid,
-			(unsigned long long)key.offset, type, ret);
+			key.objectid, key.offset, type, ret);
 		goto out;
 	}
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4964cd3827e4..2a9b2681a043 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -185,8 +185,7 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 				btrfs_format_csum(csum_type, (u8 *)buf->data, wanted);
 				printk(
 			"checksum verify failed on %llu wanted %s found %s\n",
-				       (unsigned long long)buf->start,
-				       wanted, found);
+				       buf->start, wanted, found);
 			}
 			return 1;
 		}
@@ -275,9 +274,7 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 		goto out;
 	}
 	printk("parent transid verify failed on %llu wanted %llu found %llu\n",
-	       (unsigned long long)eb->start,
-	       (unsigned long long)parent_transid,
-	       (unsigned long long)btrfs_header_generation(eb));
+	       eb->start, parent_transid, btrfs_header_generation(eb));
 	if (ignore) {
 		eb->flags |= EXTENT_BAD_TRANSID;
 		printk("Ignoring transid failure\n");
@@ -985,9 +982,8 @@ int btrfs_check_fs_compatibility(struct btrfs_super_block *sb,
 	features = btrfs_super_incompat_flags(sb) &
 		   ~BTRFS_FEATURE_INCOMPAT_SUPP;
 	if (features) {
-		printk("couldn't open because of unsupported "
-		       "option features (%llx).\n",
-		       (unsigned long long)features);
+		printk("couldn't open because of unsupported option features (%llx).\n",
+		       features);
 		return -ENOTSUP;
 	}
 
@@ -1007,9 +1003,8 @@ int btrfs_check_fs_compatibility(struct btrfs_super_block *sb,
 			features &= ~BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE;
 		}
 		if (features & ~BTRFS_FEATURE_COMPAT_RO_SUPP) {
-			printk("couldn't open RDWR because of unsupported "
-			       "option features (0x%llx)\n",
-			       (unsigned long long)features);
+			printk("couldn't open RDWR because of unsupported option features (0x%llx)\n",
+			       features);
 			return -ENOTSUP;
 		}
 
@@ -1463,8 +1458,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	lseek(fd, 0, SEEK_SET);
 	if (sb_bytenr > dev_size) {
 		error("superblock bytenr %llu is larger than device size %llu",
-				(unsigned long long)sb_bytenr,
-				(unsigned long long)dev_size);
+			sb_bytenr, dev_size);
 		return -EINVAL;
 	}
 
@@ -1764,8 +1758,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 
 	/* This flags may not return fs_info with any valid root */
 	if (flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR) {
-		error("invalid open_ctree flags: 0x%llx",
-				(unsigned long long)flags);
+		error("invalid open_ctree flags: 0x%x", flags);
 		return NULL;
 	}
 	ocf.filename = path;
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 697a8a1e4dec..d4a8da8b844d 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -316,7 +316,7 @@ out:
 	cache = btrfs_lookup_block_group(root->fs_info, search_start);
 	if (!cache) {
 		printk("Unable to find block group for %llu\n",
-			(unsigned long long)search_start);
+			search_start);
 		return -ENOENT;
 	}
 	return -ENOSPC;
@@ -1425,7 +1425,7 @@ again:
 	if (ret != 0) {
 		btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
 		printk("failed to find block number %llu\n",
-			(unsigned long long)bytenr);
+			bytenr);
 		BUG();
 	}
 	l = path->nodes[0];
@@ -1643,10 +1643,9 @@ int update_space_info(struct btrfs_fs_info *info, u64 flags,
 		found->total_bytes += total_bytes;
 		found->bytes_used += bytes_used;
 		if (found->total_bytes < found->bytes_used) {
-			fprintf(stderr, "warning, bad space info total_bytes "
-				"%llu used %llu\n",
-			       (unsigned long long)found->total_bytes,
-			       (unsigned long long)found->bytes_used);
+			fprintf(stderr, "warning, bad space info total_bytes %llu used %llu\n",
+			       found->total_bytes,
+			       found->bytes_used);
 		}
 		*space_info = found;
 		return 0;
@@ -2012,22 +2011,19 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			}
 
 			if (ret) {
-				printk(KERN_ERR "umm, got %d back from search"
-				       ", was looking for %llu\n", ret,
-				       (unsigned long long)bytenr);
+				printk(KERN_ERR
+			"umm, got %d back from search, was looking for %llu\n",
+				       ret, bytenr);
 				btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
 			}
 			BUG_ON(ret);
 			extent_slot = path->slots[0];
 		}
 	} else {
-		printk(KERN_ERR "btrfs unable to find ref byte nr %llu "
-		       "parent %llu root %llu  owner %llu offset %llu\n",
-		       (unsigned long long)bytenr,
-		       (unsigned long long)parent,
-		       (unsigned long long)root_objectid,
-		       (unsigned long long)owner_objectid,
-		       (unsigned long long)owner_offset);
+		printk(KERN_ERR
+"btrfs unable to find ref byte nr %llu parent %llu root %llu  owner %llu offset %llu\n",
+		       bytenr, parent, root_objectid, owner_objectid,
+		       owner_offset);
 		printf("path->slots[0]: %d path->nodes[0]:\n", path->slots[0]);
 		btrfs_print_leaf(path->nodes[0], BTRFS_PRINT_TREE_DEFAULT);
 		ret = -EIO;
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index af09ade4025f..fba0b050a7e1 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -88,7 +88,7 @@ void extent_io_tree_cleanup(struct extent_io_tree *tree)
 		if (eb->refs) {
 			fprintf(stderr,
 				"extent buffer leak: start %llu len %u\n",
-				(unsigned long long)eb->start, eb->len);
+				eb->start, eb->len);
 			free_extent_buffer_nocache(eb);
 		} else {
 			free_extent_buffer_final(eb);
diff --git a/kernel-shared/free-space-cache.c b/kernel-shared/free-space-cache.c
index e74a61e44deb..6d7fee9c86fb 100644
--- a/kernel-shared/free-space-cache.c
+++ b/kernel-shared/free-space-cache.c
@@ -330,9 +330,8 @@ static int __load_free_space_cache(struct btrfs_root *root,
 		fprintf(stderr,
 		       "free space inode generation (%llu) did not match "
 		       "free space cache generation (%llu)\n",
-		       (unsigned long long)btrfs_inode_generation(leaf,
-								  inode_item),
-		       (unsigned long long)generation);
+		       btrfs_inode_generation(leaf, inode_item),
+		       generation);
 		btrfs_release_path(path);
 		return 0;
 	}
@@ -779,8 +778,7 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 		if (info->bytes >= bytes && !block_group->ro)
 			count++;
 		printk("entry offset %llu, bytes %llu, bitmap %s\n",
-		       (unsigned long long)info->offset,
-		       (unsigned long long)info->bytes,
+		       info->offset, info->bytes,
 		       (info->bitmap) ? "yes" : "no");
 	}
 	printk("%d blocks of free space at or bigger than bytes is \n", count);
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 8dfe5b0d4c16..6c2a4dbabe87 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -608,7 +608,7 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret <= 0) {
 		error("search for DIR_INDEX dirid %llu failed: %d",
-				(unsigned long long)dirid, ret);
+			dirid, ret);
 		goto fail;
 	}
 
@@ -633,7 +633,7 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	ret = btrfs_lookup_inode(trans, root, &path, &key, 1);
 	if (ret) {
 		error("search for INODE_ITEM %llu failed: %d",
-				(unsigned long long)dirid, ret);
+			dirid, ret);
 		goto fail;
 	}
 	leaf = path.nodes[0];
@@ -728,8 +728,7 @@ int btrfs_find_free_objectid(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	search_start = root->last_inode_alloc;
-	search_start = max((unsigned long long)search_start,
-				BTRFS_FIRST_FREE_OBJECTID);
+	search_start = max(search_start, BTRFS_FIRST_FREE_OBJECTID);
 	search_key.objectid = search_start;
 	search_key.offset = 0;
 	search_key.type = 0;
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9c12dfcb4ca5..517f97208a20 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -145,7 +145,7 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
 		len = (name_len <= sizeof(namebuf))? name_len: sizeof(namebuf);
 
 		printf("\t\tindex %llu namelen %u ",
-		       (unsigned long long)index, name_len);
+		       index, name_len);
 		if (eb->fs_info && eb->fs_info->hide_names) {
 			printf("name: HIDDEN\n");
 		} else {
@@ -239,10 +239,8 @@ void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 
 	bg_flags_to_str(btrfs_chunk_type(eb, chunk), chunk_flags_str);
 	printf("\t\tlength %llu owner %llu stripe_len %llu type %s\n",
-	       (unsigned long long)btrfs_chunk_length(eb, chunk),
-	       (unsigned long long)btrfs_chunk_owner(eb, chunk),
-	       (unsigned long long)btrfs_chunk_stripe_len(eb, chunk),
-		chunk_flags_str);
+	       btrfs_chunk_length(eb, chunk), btrfs_chunk_owner(eb, chunk),
+	       btrfs_chunk_stripe_len(eb, chunk), chunk_flags_str);
 	printf("\t\tio_align %u io_width %u sector_size %u\n",
 			btrfs_chunk_io_align(eb, chunk),
 			btrfs_chunk_io_width(eb, chunk),
@@ -270,8 +268,8 @@ void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 			BTRFS_UUID_SIZE);
 		uuid_unparse(dev_uuid, str_dev_uuid);
 		printf("\t\t\tstripe %d devid %llu offset %llu\n", i,
-		      (unsigned long long)btrfs_stripe_devid_nr(eb, chunk, i),
-		      (unsigned long long)btrfs_stripe_offset_nr(eb, chunk, i));
+		       btrfs_stripe_devid_nr(eb, chunk, i),
+		       btrfs_stripe_offset_nr(eb, chunk, i));
 		printf("\t\t\tdev_uuid %s\n", str_dev_uuid);
 	}
 }
@@ -298,15 +296,15 @@ static void print_dev_item(struct extent_buffer *eb,
 	       "\t\tseek_speed %hhu bandwidth %hhu\n"
 	       "\t\tuuid %s\n"
 	       "\t\tfsid %s\n",
-	       (unsigned long long)btrfs_device_id(eb, dev_item),
-	       (unsigned long long)btrfs_device_total_bytes(eb, dev_item),
-	       (unsigned long long)btrfs_device_bytes_used(eb, dev_item),
+	       btrfs_device_id(eb, dev_item),
+	       btrfs_device_total_bytes(eb, dev_item),
+	       btrfs_device_bytes_used(eb, dev_item),
 	       btrfs_device_io_align(eb, dev_item),
 	       btrfs_device_io_width(eb, dev_item),
 	       btrfs_device_sector_size(eb, dev_item),
-	       (unsigned long long)btrfs_device_type(eb, dev_item),
-	       (unsigned long long)btrfs_device_generation(eb, dev_item),
-	       (unsigned long long)btrfs_device_start_offset(eb, dev_item),
+	       btrfs_device_type(eb, dev_item),
+	       btrfs_device_generation(eb, dev_item),
+	       btrfs_device_start_offset(eb, dev_item),
 	       btrfs_device_group(eb, dev_item),
 	       btrfs_device_seek_speed(eb, dev_item),
 	       btrfs_device_bandwidth(eb, dev_item),
@@ -388,20 +386,20 @@ static void print_file_extent_item(struct extent_buffer *eb,
 	}
 	if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		printf("\t\tprealloc data disk byte %llu nr %llu\n",
-		  (unsigned long long)btrfs_file_extent_disk_bytenr(eb, fi),
-		  (unsigned long long)btrfs_file_extent_disk_num_bytes(eb, fi));
+		       btrfs_file_extent_disk_bytenr(eb, fi),
+		       btrfs_file_extent_disk_num_bytes(eb, fi));
 		printf("\t\tprealloc data offset %llu nr %llu\n",
-		  (unsigned long long)btrfs_file_extent_offset(eb, fi),
-		  (unsigned long long)btrfs_file_extent_num_bytes(eb, fi));
+		       btrfs_file_extent_offset(eb, fi),
+		       btrfs_file_extent_num_bytes(eb, fi));
 		return;
 	}
 	printf("\t\textent data disk byte %llu nr %llu\n",
-		(unsigned long long)btrfs_file_extent_disk_bytenr(eb, fi),
-		(unsigned long long)btrfs_file_extent_disk_num_bytes(eb, fi));
+		btrfs_file_extent_disk_bytenr(eb, fi),
+		btrfs_file_extent_disk_num_bytes(eb, fi));
 	printf("\t\textent data offset %llu nr %llu ram %llu\n",
-		(unsigned long long)btrfs_file_extent_offset(eb, fi),
-		(unsigned long long)btrfs_file_extent_num_bytes(eb, fi),
-		(unsigned long long)btrfs_file_extent_ram_bytes(eb, fi));
+		btrfs_file_extent_offset(eb, fi),
+		btrfs_file_extent_num_bytes(eb, fi),
+		btrfs_file_extent_ram_bytes(eb, fi));
 	printf("\t\textent compression %hhu (%s)\n",
 			btrfs_file_extent_compression(eb, fi),
 			compress_str);
@@ -453,8 +451,7 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata)
 	extent_flags_to_str(flags, flags_str);
 
 	printf("\t\trefs %llu gen %llu flags %s\n",
-	       (unsigned long long)btrfs_extent_refs(eb, ei),
-	       (unsigned long long)btrfs_extent_generation(eb, ei),
+	       btrfs_extent_refs(eb, ei), btrfs_extent_generation(eb, ei),
 	       flags_str);
 
 	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !metadata) {
@@ -489,23 +486,22 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata)
 			break;
 		case BTRFS_SHARED_BLOCK_REF_KEY:
 			printf("\t\tshared block backref parent %llu\n",
-			       (unsigned long long)offset);
+			       offset);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
 			printf("\t\textent data backref root ");
 			print_objectid(stdout,
-		(unsigned long long)btrfs_extent_data_ref_root(eb, dref), 0);
+				       btrfs_extent_data_ref_root(eb, dref), 0);
 			printf(" objectid %llu offset %llu count %u\n",
-			       (unsigned long long)btrfs_extent_data_ref_objectid(eb, dref),
+			       btrfs_extent_data_ref_objectid(eb, dref),
 			       btrfs_extent_data_ref_offset(eb, dref),
 			       btrfs_extent_data_ref_count(eb, dref));
 			break;
 		case BTRFS_SHARED_DATA_REF_KEY:
 			sref = (struct btrfs_shared_data_ref *)(iref + 1);
 			printf("\t\tshared data backref parent %llu count %u\n",
-			       (unsigned long long)offset,
-			       btrfs_shared_data_ref_count(eb, sref));
+			       offset, btrfs_shared_data_ref_count(eb, sref));
 			break;
 		default:
 			return;
@@ -525,9 +521,8 @@ static void print_root_ref(struct extent_buffer *leaf, int slot, const char *tag
 	namelen = btrfs_root_ref_name_len(leaf, ref);
 	read_extent_buffer(leaf, namebuf, (unsigned long)(ref + 1), namelen);
 	printf("\t\troot %s key dirid %llu sequence %llu name %.*s\n", tag,
-	       (unsigned long long)btrfs_root_ref_dirid(leaf, ref),
-	       (unsigned long long)btrfs_root_ref_sequence(leaf, ref),
-	       namelen, namebuf);
+	       btrfs_root_ref_dirid(leaf, ref),
+	       btrfs_root_ref_sequence(leaf, ref), namelen, namebuf);
 }
 
 /*
@@ -557,8 +552,7 @@ static void print_timespec(struct extent_buffer *eb,
 	localtime_r(&tmp_time, &tm);
 	strftime(timestamp, sizeof(timestamp),
 			"%Y-%m-%d %H:%M:%S", &tm);
-	printf("%s%llu.%u (%s)%s", prefix, (unsigned long long)tmp_u64, tmp_u32,
-			timestamp, suffix);
+	printf("%s%llu.%u (%s)%s", prefix, tmp_u64, tmp_u32, timestamp, suffix);
 }
 
 static void print_root_item(struct extent_buffer *leaf, int slot)
@@ -578,14 +572,14 @@ static void print_root_item(struct extent_buffer *leaf, int slot)
 	root_flags_to_str(btrfs_root_flags(&root_item), flags_str);
 
 	printf("\t\tgeneration %llu root_dirid %llu bytenr %llu byte_limit %llu bytes_used %llu\n",
-		(unsigned long long)btrfs_root_generation(&root_item),
-		(unsigned long long)btrfs_root_dirid(&root_item),
-		(unsigned long long)btrfs_root_bytenr(&root_item),
-		(unsigned long long)btrfs_root_limit(&root_item),
-		(unsigned long long)btrfs_root_used(&root_item));
+		btrfs_root_generation(&root_item),
+		btrfs_root_dirid(&root_item),
+		btrfs_root_bytenr(&root_item),
+		btrfs_root_limit(&root_item),
+		btrfs_root_used(&root_item));
 	printf("\t\tlast_snapshot %llu flags 0x%llx(%s) refs %u\n",
-		(unsigned long long)btrfs_root_last_snapshot(&root_item),
-		(unsigned long long)btrfs_root_flags(&root_item),
+		btrfs_root_last_snapshot(&root_item),
+		btrfs_root_flags(&root_item),
 		flags_str,
 		btrfs_root_refs(&root_item));
 	btrfs_disk_key_to_cpu(&drop_key, &root_item.drop_progress);
@@ -630,9 +624,9 @@ static void print_free_space_header(struct extent_buffer *leaf, int slot)
 	btrfs_print_key(&location);
 	printf("\n");
 	printf("\t\tcache generation %llu entries %llu bitmaps %llu\n",
-	       (unsigned long long)btrfs_free_space_generation(leaf, header),
-	       (unsigned long long)btrfs_free_space_entries(leaf, header),
-	       (unsigned long long)btrfs_free_space_bitmaps(leaf, header));
+	       btrfs_free_space_generation(leaf, header),
+	       btrfs_free_space_entries(leaf, header),
+	       btrfs_free_space_bitmaps(leaf, header));
 }
 
 void print_key_type(FILE *stream, u64 objectid, u8 type)
@@ -700,11 +694,11 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 		if (objectid == BTRFS_DEV_STATS_OBJECTID)
 			fprintf(stream, "DEV_STATS");
 		else
-			fprintf(stream, "%llu", (unsigned long long)objectid);
+			fprintf(stream, "%llu", objectid);
 		return;
 	case BTRFS_DEV_EXTENT_KEY:
 		/* device id */
-		fprintf(stream, "%llu", (unsigned long long)objectid);
+		fprintf(stream, "%llu", objectid);
 		return;
 	case BTRFS_QGROUP_RELATION_KEY:
 		fprintf(stream, "%llu/%llu", btrfs_qgroup_level(objectid),
@@ -712,7 +706,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 		return;
 	case BTRFS_UUID_KEY_SUBVOL:
 	case BTRFS_UUID_KEY_RECEIVED_SUBVOL:
-		fprintf(stream, "0x%016llx", (unsigned long long)objectid);
+		fprintf(stream, "0x%016llx", objectid);
 		return;
 	}
 
@@ -798,7 +792,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 		}
 		/* fall-thru */
 	default:
-		fprintf(stream, "%llu", (unsigned long long)objectid);
+		fprintf(stream, "%llu", objectid);
 	}
 }
 
@@ -821,7 +815,7 @@ void btrfs_print_key(struct btrfs_disk_key *disk_key)
 		break;
 	case BTRFS_UUID_KEY_SUBVOL:
 	case BTRFS_UUID_KEY_RECEIVED_SUBVOL:
-		printf(" 0x%016llx)", (unsigned long long)offset);
+		printf(" 0x%016llx)", offset);
 		break;
 
 	/*
@@ -847,7 +841,7 @@ void btrfs_print_key(struct btrfs_disk_key *disk_key)
 		if (offset == (u64)-1)
 			printf(" -1)");
 		else
-			printf(" %llu)", (unsigned long long)offset);
+			printf(" %llu)", offset);
 		break;
 	}
 }
@@ -864,8 +858,7 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
 		__le64 subvol_id;
 
 		read_extent_buffer(l, &subvol_id, offset, sizeof(u64));
-		printf("\t\tsubvol_id %llu\n",
-			(unsigned long long)le64_to_cpu(subvol_id));
+		printf("\t\tsubvol_id %llu\n", le64_to_cpu(subvol_id));
 		item_size -= sizeof(u64);
 		offset += sizeof(u64);
 	}
@@ -915,18 +908,18 @@ static void print_inode_item(struct extent_buffer *eb,
 	printf("\t\tgeneration %llu transid %llu size %llu nbytes %llu\n"
 	       "\t\tblock group %llu mode %o links %u uid %u gid %u rdev %llu\n"
 	       "\t\tsequence %llu flags 0x%llx(%s)\n",
-	       (unsigned long long)btrfs_inode_generation(eb, ii),
-	       (unsigned long long)btrfs_inode_transid(eb, ii),
-	       (unsigned long long)btrfs_inode_size(eb, ii),
-	       (unsigned long long)btrfs_inode_nbytes(eb, ii),
-	       (unsigned long long)btrfs_inode_block_group(eb,ii),
+	       btrfs_inode_generation(eb, ii),
+	       btrfs_inode_transid(eb, ii),
+	       btrfs_inode_size(eb, ii),
+	       btrfs_inode_nbytes(eb, ii),
+	       btrfs_inode_block_group(eb,ii),
 	       btrfs_inode_mode(eb, ii),
 	       btrfs_inode_nlink(eb, ii),
 	       btrfs_inode_uid(eb, ii),
 	       btrfs_inode_gid(eb, ii),
-	       (unsigned long long)btrfs_inode_rdev(eb,ii),
-	       (unsigned long long)btrfs_inode_sequence(eb, ii),
-	       (unsigned long long)btrfs_inode_flags(eb,ii),
+	       btrfs_inode_rdev(eb,ii),
+	       btrfs_inode_sequence(eb, ii),
+	       btrfs_inode_flags(eb,ii),
 	       flags_str);
 	print_timespec(eb, btrfs_inode_atime(ii), "\t\tatime ", "\n");
 	print_timespec(eb, btrfs_inode_ctime(ii), "\t\tctime ", "\n");
@@ -937,23 +930,23 @@ static void print_inode_item(struct extent_buffer *eb,
 static void print_disk_balance_args(struct btrfs_disk_balance_args *ba)
 {
 	printf("\t\tprofiles %llu devid %llu target %llu flags %llu\n",
-			(unsigned long long)le64_to_cpu(ba->profiles),
-			(unsigned long long)le64_to_cpu(ba->devid),
-			(unsigned long long)le64_to_cpu(ba->target),
-			(unsigned long long)le64_to_cpu(ba->flags));
+		le64_to_cpu(ba->profiles),
+		le64_to_cpu(ba->devid),
+		le64_to_cpu(ba->target),
+		le64_to_cpu(ba->flags));
 	printf("\t\tusage_min %u usage_max %u pstart %llu pend %llu\n",
-			le32_to_cpu(ba->usage_min),
-			le32_to_cpu(ba->usage_max),
-			(unsigned long long)le64_to_cpu(ba->pstart),
-			(unsigned long long)le64_to_cpu(ba->pend));
+		le32_to_cpu(ba->usage_min),
+		le32_to_cpu(ba->usage_max),
+		le64_to_cpu(ba->pstart),
+		le64_to_cpu(ba->pend));
 	printf("\t\tvstart %llu vend %llu limit_min %u limit_max %u\n",
-			(unsigned long long)le64_to_cpu(ba->vstart),
-			(unsigned long long)le64_to_cpu(ba->vend),
-			le32_to_cpu(ba->limit_min),
-			le32_to_cpu(ba->limit_max));
+		le64_to_cpu(ba->vstart),
+		le64_to_cpu(ba->vend),
+		le32_to_cpu(ba->limit_min),
+		le32_to_cpu(ba->limit_max));
 	printf("\t\tstripes_min %u stripes_max %u\n",
-			le32_to_cpu(ba->stripes_min),
-			le32_to_cpu(ba->stripes_max));
+		le32_to_cpu(ba->stripes_min),
+		le32_to_cpu(ba->stripes_max));
 }
 
 static void print_balance_item(struct extent_buffer *eb,
@@ -1016,10 +1009,10 @@ static void print_extent_data_ref(struct extent_buffer *eb, int slot)
 	dref = btrfs_item_ptr(eb, slot, struct btrfs_extent_data_ref);
 	printf("\t\textent data backref root ");
 	print_objectid(stdout,
-		(unsigned long long)btrfs_extent_data_ref_root(eb, dref), 0);
+		btrfs_extent_data_ref_root(eb, dref), 0);
 	printf(" objectid %llu offset %llu count %u\n",
-		(unsigned long long)btrfs_extent_data_ref_objectid(eb, dref),
-		(unsigned long long)btrfs_extent_data_ref_offset(eb, dref),
+		btrfs_extent_data_ref_objectid(eb, dref),
+		btrfs_extent_data_ref_offset(eb, dref),
 		btrfs_extent_data_ref_count(eb, dref));
 }
 
@@ -1054,13 +1047,12 @@ static void print_dev_extent(struct extent_buffer *eb, int slot)
 		BTRFS_UUID_SIZE);
 	uuid_unparse(uuid, uuid_str);
 	printf("\t\tdev extent chunk_tree %llu\n"
-		"\t\tchunk_objectid %llu chunk_offset %llu "
-		"length %llu\n"
+		"\t\tchunk_objectid %llu chunk_offset %llu length %llu\n"
 		"\t\tchunk_tree_uuid %s\n",
-		(unsigned long long)btrfs_dev_extent_chunk_tree(eb, dev_extent),
-		(unsigned long long)btrfs_dev_extent_chunk_objectid(eb, dev_extent),
-		(unsigned long long)btrfs_dev_extent_chunk_offset(eb, dev_extent),
-		(unsigned long long)btrfs_dev_extent_length(eb, dev_extent),
+		btrfs_dev_extent_chunk_tree(eb, dev_extent),
+		btrfs_dev_extent_chunk_objectid(eb, dev_extent),
+		btrfs_dev_extent_chunk_offset(eb, dev_extent),
+		btrfs_dev_extent_length(eb, dev_extent),
 		uuid_str);
 }
 
@@ -1074,10 +1066,10 @@ static void print_qgroup_status(struct extent_buffer *eb, int slot)
 	qgroup_flags_to_str(btrfs_qgroup_status_flags(eb, qg_status),
 					flags_str);
 	printf("\t\tversion %llu generation %llu flags %s scan %llu\n",
-		(unsigned long long)btrfs_qgroup_status_version(eb, qg_status),
-		(unsigned long long)btrfs_qgroup_status_generation(eb, qg_status),
+		btrfs_qgroup_status_version(eb, qg_status),
+		btrfs_qgroup_status_generation(eb, qg_status),
 		flags_str,
-		(unsigned long long)btrfs_qgroup_status_rescan(eb, qg_status));
+		btrfs_qgroup_status_rescan(eb, qg_status));
 }
 
 static void print_qgroup_info(struct extent_buffer *eb, int slot)
@@ -1088,13 +1080,11 @@ static void print_qgroup_info(struct extent_buffer *eb, int slot)
 	printf("\t\tgeneration %llu\n"
 		"\t\treferenced %llu referenced_compressed %llu\n"
 		"\t\texclusive %llu exclusive_compressed %llu\n",
-		(unsigned long long)btrfs_qgroup_info_generation(eb, qg_info),
-		(unsigned long long)btrfs_qgroup_info_referenced(eb, qg_info),
-		(unsigned long long)btrfs_qgroup_info_referenced_compressed(eb,
-								       qg_info),
-		(unsigned long long)btrfs_qgroup_info_exclusive(eb, qg_info),
-		(unsigned long long)btrfs_qgroup_info_exclusive_compressed(eb,
-								      qg_info));
+		btrfs_qgroup_info_generation(eb, qg_info),
+		btrfs_qgroup_info_referenced(eb, qg_info),
+		btrfs_qgroup_info_referenced_compressed(eb, qg_info),
+		btrfs_qgroup_info_exclusive(eb, qg_info),
+		btrfs_qgroup_info_exclusive_compressed(eb, qg_info));
 }
 
 static void print_qgroup_limit(struct extent_buffer *eb, int slot)
@@ -1105,11 +1095,11 @@ static void print_qgroup_limit(struct extent_buffer *eb, int slot)
 	printf("\t\tflags %llx\n"
 		"\t\tmax_referenced %lld max_exclusive %lld\n"
 		"\t\trsv_referenced %lld rsv_exclusive %lld\n",
-		(unsigned long long)btrfs_qgroup_limit_flags(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_max_referenced(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_max_exclusive(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_rsv_referenced(eb, qg_limit),
-		(long long)btrfs_qgroup_limit_rsv_exclusive(eb, qg_limit));
+		btrfs_qgroup_limit_flags(eb, qg_limit),
+		btrfs_qgroup_limit_max_referenced(eb, qg_limit),
+		btrfs_qgroup_limit_max_exclusive(eb, qg_limit),
+		btrfs_qgroup_limit_rsv_referenced(eb, qg_limit),
+		btrfs_qgroup_limit_rsv_exclusive(eb, qg_limit));
 }
 
 static void print_persistent_item(struct extent_buffer *eb, void *ptr,
@@ -1117,7 +1107,7 @@ static void print_persistent_item(struct extent_buffer *eb, void *ptr,
 {
 	printf("\t\tpersistent item objectid ");
 	print_objectid(stdout, objectid, BTRFS_PERSISTENT_ITEM_KEY);
-	printf(" offset %llu\n", (unsigned long long)offset);
+	printf(" offset %llu\n", offset);
 	switch (objectid) {
 	case BTRFS_DEV_STATS_OBJECTID:
 		print_dev_stats(eb, ptr, item_size);
@@ -1132,7 +1122,7 @@ static void print_temporary_item(struct extent_buffer *eb, void *ptr,
 {
 	printf("\t\ttemporary item objectid ");
 	print_objectid(stdout, objectid, BTRFS_TEMPORARY_ITEM_KEY);
-	printf(" offset %llu\n", (unsigned long long)offset);
+	printf(" offset %llu\n", offset);
 	switch (objectid) {
 	case BTRFS_BALANCE_OBJECTID:
 		print_balance_item(eb, ptr);
@@ -1154,14 +1144,13 @@ static void print_extent_csum(struct extent_buffer *eb,
 	 * don't have sectorsize for the calculation
 	 */
 	if (!fs_info) {
-		printf("\t\trange start %llu\n", (unsigned long long)offset);
+		printf("\t\trange start %llu\n", offset);
 		return;
 	}
 	csum_size = fs_info->csum_size;
 	size = (item_size / csum_size) * fs_info->sectorsize;
 	printf("\t\trange start %llu end %llu length %u\n",
-			(unsigned long long)offset,
-			(unsigned long long)offset + size, size);
+		offset, offset + size, size);
 
 
 	/*
@@ -1234,15 +1223,15 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 	if (btrfs_header_level(eb))
 		printf(
 	"node %llu level %d items %u free space %u generation %llu owner ",
-		       (unsigned long long)eb->start, btrfs_header_level(eb),
+		       eb->start, btrfs_header_level(eb),
 		       nr, (u32)BTRFS_NODEPTRS_PER_EXTENT_BUFFER(eb) - nr,
-		       (unsigned long long)btrfs_header_generation(eb));
+		       btrfs_header_generation(eb));
 	else
 		printf(
 	"leaf %llu items %u free space %d generation %llu owner ",
-		       (unsigned long long)btrfs_header_bytenr(eb), nr,
+		       btrfs_header_bytenr(eb), nr,
 		       btrfs_leaf_free_space(eb),
-		       (unsigned long long)btrfs_header_generation(eb));
+		       btrfs_header_generation(eb));
 	print_objectid(stdout, btrfs_header_owner(eb), 0);
 	printf("\n");
 	if (fs_info && (mode & BTRFS_PRINT_TREE_CSUM_HEADERS)) {
@@ -1358,7 +1347,7 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 
 			dlog = btrfs_item_ptr(eb, i, struct btrfs_dir_log_item);
 			printf("\t\tdir log end %llu\n",
-			       (unsigned long long)btrfs_dir_log_end(eb, dlog));
+			       btrfs_dir_log_end(eb, dlog));
 			break;
 			}
 		case BTRFS_ORPHAN_ITEM_KEY:
@@ -1614,8 +1603,7 @@ void btrfs_print_tree(struct extent_buffer *eb, unsigned int mode)
 		printf("\t");
 		btrfs_print_key(&disk_key);
 		printf(" block %llu gen %llu\n",
-		       (unsigned long long)blocknr,
-		       (unsigned long long)btrfs_node_ptr_generation(eb, i));
+		       blocknr, btrfs_node_ptr_generation(eb, i));
 		fflush(stdout);
 	}
 	if (!follow)
@@ -1955,7 +1943,7 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 		csum_size = btrfs_super_csum_size(sb);
 	}
 	printf(")\n");
-	printf("csum_size\t\t%llu\n", (unsigned long long)csum_size);
+	printf("csum_size\t\t%u\n", csum_size);
 
 	printf("csum\t\t\t0x");
 	for (i = 0, p = sb->csum; i < csum_size; i++)
@@ -1968,10 +1956,8 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 		printf(" [DON'T MATCH]");
 	putchar('\n');
 
-	printf("bytenr\t\t\t%llu\n",
-		(unsigned long long)btrfs_super_bytenr(sb));
-	printf("flags\t\t\t0x%llx\n",
-		(unsigned long long)btrfs_super_flags(sb));
+	printf("bytenr\t\t\t%llu\n", btrfs_super_bytenr(sb));
+	printf("flags\t\t\t0x%llx\n", btrfs_super_flags(sb));
 	print_readable_super_flag(btrfs_super_flags(sb));
 
 	printf("magic\t\t\t");
@@ -1998,59 +1984,39 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 		putchar(isprint(s[i]) ? s[i] : '.');
 	putchar('\n');
 
-	printf("generation\t\t%llu\n",
-	       (unsigned long long)btrfs_super_generation(sb));
-	printf("root\t\t\t%llu\n", (unsigned long long)btrfs_super_root(sb));
-	printf("sys_array_size\t\t%llu\n",
-	       (unsigned long long)btrfs_super_sys_array_size(sb));
+	printf("generation\t\t%llu\n", btrfs_super_generation(sb));
+	printf("root\t\t\t%llu\n", btrfs_super_root(sb));
+	printf("sys_array_size\t\t%u\n", btrfs_super_sys_array_size(sb));
 	printf("chunk_root_generation\t%llu\n",
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
+	       btrfs_super_chunk_root_generation(sb));
+	printf("root_level\t\t%u\n", btrfs_super_root_level(sb));
+	printf("chunk_root\t\t%llu\n", btrfs_super_chunk_root(sb));
+	printf("chunk_root_level\t%u\n", btrfs_super_chunk_root_level(sb));
+	printf("log_root\t\t%llu\n", btrfs_super_log_root(sb));
+	printf("log_root_transid\t%llu\n", btrfs_super_log_root_transid(sb));
+	printf("log_root_level\t\t%u\n", btrfs_super_log_root_level(sb));
+	printf("total_bytes\t\t%llu\n", btrfs_super_total_bytes(sb));
+	printf("bytes_used\t\t%llu\n", btrfs_super_bytes_used(sb));
+	printf("sectorsize\t\t%u\n", btrfs_super_sectorsize(sb));
+	printf("nodesize\t\t%u\n", btrfs_super_nodesize(sb));
 	printf("leafsize (deprecated)\t%u\n",
 	       le32_to_cpu(sb->__unused_leafsize));
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
+	printf("stripesize\t\t%u\n", btrfs_super_stripesize(sb));
+	printf("root_dir\t\t%llu\n", btrfs_super_root_dir(sb));
+	printf("num_devices\t\t%llu\n", btrfs_super_num_devices(sb));
+	printf("compat_flags\t\t0x%llx\n", btrfs_super_compat_flags(sb));
+	printf("compat_ro_flags\t\t0x%llx\n", btrfs_super_compat_ro_flags(sb));
 	print_readable_compat_ro_flag(btrfs_super_compat_ro_flags(sb));
-	printf("incompat_flags\t\t0x%llx\n",
-	       (unsigned long long)btrfs_super_incompat_flags(sb));
+	printf("incompat_flags\t\t0x%llx\n", btrfs_super_incompat_flags(sb));
 	print_readable_incompat_flag(btrfs_super_incompat_flags(sb));
-	printf("cache_generation\t%llu\n",
-	       (unsigned long long)btrfs_super_cache_generation(sb));
+	printf("cache_generation\t%llu\n", btrfs_super_cache_generation(sb));
 	printf("uuid_tree_generation\t%llu\n",
-	       (unsigned long long)btrfs_super_uuid_tree_generation(sb));
-	printf("block_group_root\t%llu\n",
-	       (unsigned long long)btrfs_super_block_group_root(sb));
+	       btrfs_super_uuid_tree_generation(sb));
+	printf("block_group_root\t%llu\n", btrfs_super_block_group_root(sb));
 	printf("block_group_root_generation\t%llu\n",
-	       (unsigned long long)btrfs_super_block_group_root_generation(sb));
-	printf("block_group_root_level\t%llu\n",
-	       (unsigned long long)btrfs_super_block_group_root_level(sb));
+	       btrfs_super_block_group_root_generation(sb));
+	printf("block_group_root_level\t%u\n",
+	       btrfs_super_block_group_root_level(sb));
 
 	uuid_unparse(sb->dev_item.uuid, buf);
 	printf("dev_item.uuid\t\t%s\n", buf);
@@ -2065,27 +2031,27 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	printf("dev_item.fsid\t\t%s %s\n", buf,
 	       cmp_res ? "[match]" : "[DON'T MATCH]");
 
-	printf("dev_item.type\t\t%llu\n", (unsigned long long)
+	printf("dev_item.type\t\t%llu\n",
 	       btrfs_stack_device_type(&sb->dev_item));
-	printf("dev_item.total_bytes\t%llu\n", (unsigned long long)
+	printf("dev_item.total_bytes\t%llu\n",
 	       btrfs_stack_device_total_bytes(&sb->dev_item));
-	printf("dev_item.bytes_used\t%llu\n", (unsigned long long)
+	printf("dev_item.bytes_used\t%llu\n",
 	       btrfs_stack_device_bytes_used(&sb->dev_item));
-	printf("dev_item.io_align\t%u\n", (unsigned int)
+	printf("dev_item.io_align\t%u\n",
 	       btrfs_stack_device_io_align(&sb->dev_item));
-	printf("dev_item.io_width\t%u\n", (unsigned int)
+	printf("dev_item.io_width\t%u\n",
 	       btrfs_stack_device_io_width(&sb->dev_item));
-	printf("dev_item.sector_size\t%u\n", (unsigned int)
+	printf("dev_item.sector_size\t%u\n",
 	       btrfs_stack_device_sector_size(&sb->dev_item));
 	printf("dev_item.devid\t\t%llu\n",
 	       btrfs_stack_device_id(&sb->dev_item));
-	printf("dev_item.dev_group\t%u\n", (unsigned int)
+	printf("dev_item.dev_group\t%u\n",
 	       btrfs_stack_device_group(&sb->dev_item));
-	printf("dev_item.seek_speed\t%u\n", (unsigned int)
+	printf("dev_item.seek_speed\t%u\n",
 	       btrfs_stack_device_seek_speed(&sb->dev_item));
-	printf("dev_item.bandwidth\t%u\n", (unsigned int)
+	printf("dev_item.bandwidth\t%u\n",
 	       btrfs_stack_device_bandwidth(&sb->dev_item));
-	printf("dev_item.generation\t%llu\n", (unsigned long long)
+	printf("dev_item.generation\t%llu\n",
 	       btrfs_stack_device_generation(&sb->dev_item));
 	if (full) {
 		printf("sys_chunk_array[%d]:\n", BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index 6de9a17860f7..c7d12a3dff8b 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -68,8 +68,7 @@ static int btrfs_uuid_tree_lookup_any(int fd, const u8 *uuid, u8 type,
 	if (ret < 0) {
 		fprintf(stderr,
 			"ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key %016llx, UUID_KEY, %016llx) ret=%d, error: %m\n",
-			(unsigned long long)key.objectid,
-			(unsigned long long)key.offset, ret);
+			key.objectid, key.offset, ret);
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index e24428db8412..4bf63266879b 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1592,7 +1592,7 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 
 	if (*start != round_down(*start, info->sectorsize)) {
 		error("DATA chunk start not sectorsize aligned: %llu",
-				(unsigned long long)*start);
+			*start);
 		return -EINVAL;
 	}
 
@@ -1627,16 +1627,13 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	ce = search_cache_extent(&map_tree->cache_tree, logical);
 	if (!ce) {
 		fprintf(stderr, "No mapping for %llu-%llu\n",
-			(unsigned long long)logical,
-			(unsigned long long)logical+len);
+			logical, logical+len);
 		return 1;
 	}
 	if (ce->start > logical || ce->start + ce->size < logical) {
 		fprintf(stderr, "Invalid mapping for %llu-%llu, got "
-			"%llu-%llu\n", (unsigned long long)logical,
-			(unsigned long long)logical+len,
-			(unsigned long long)ce->start,
-			(unsigned long long)ce->start + ce->size);
+			"%llu-%llu\n", logical, logical + len,
+			ce->start, ce->start + ce->size);
 		return 1;
 	}
 	map = container_of(ce, struct map_lookup, ce);
@@ -2137,8 +2134,8 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 		return -EIO;
 	}
 	if (btrfs_chunk_sector_size(leaf, chunk) != sectorsize) {
-		error("invalid chunk sectorsize %llu",
-		      (unsigned long long)btrfs_chunk_sector_size(leaf, chunk));
+		error("invalid chunk sectorsize %u",
+		      btrfs_chunk_sector_size(leaf, chunk));
 		return -EIO;
 	}
 	if (!length || !IS_ALIGNED(length, sectorsize)) {
@@ -2277,7 +2274,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 		if (!map->stripes[i].dev) {
 			map->stripes[i].dev = fill_missing_device(devid);
 			printf("warning, device %llu is missing\n",
-			       (unsigned long long)devid);
+			       devid);
 			list_add(&map->stripes[i].dev->dev_list,
 				 &fs_info->fs_devices->devices);
 		}
diff --git a/libbtrfs/send-utils.c b/libbtrfs/send-utils.c
index 13eff1dd28e1..ab6587acb4a0 100644
--- a/libbtrfs/send-utils.c
+++ b/libbtrfs/send-utils.c
@@ -303,14 +303,13 @@ static int btrfs_subvolid_resolve_sub(int fd, char *path, size_t *path_len,
 	if (ret < 0) {
 		fprintf(stderr,
 			"ioctl(BTRFS_IOC_TREE_SEARCH, subvol_id %llu) ret=%d, error: %m\n",
-			(unsigned long long)subvol_id, ret);
+			subvol_id, ret);
 		return ret;
 	}
 
 	if (search_arg.key.nr_items < 1) {
 		fprintf(stderr,
-			"failed to lookup subvol_id %llu!\n",
-			(unsigned long long)subvol_id);
+			"failed to lookup subvol_id %llu!\n", subvol_id);
 		return -ENOENT;
 	}
 	search_header = (struct btrfs_ioctl_search_header *)search_arg.buf;
@@ -524,8 +523,7 @@ static int btrfs_uuid_tree_lookup_any(int fd, const u8 *uuid, u8 type,
 	if (ret < 0) {
 		fprintf(stderr,
 			"ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key %016llx, UUID_KEY, %016llx) ret=%d, error: %m\n",
-			(unsigned long long)key.objectid,
-			(unsigned long long)key.offset, ret);
+			key.objectid, key.offset, ret);
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/mkfs/common.c b/mkfs/common.c
index 75680d032d30..01406df5d7b8 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -407,16 +407,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
 		if (cfg->blocks[blk] < first_free) {
 			error("block[%d] below first free: %llu < %llu",
-					i, (unsigned long long)cfg->blocks[blk],
-					(unsigned long long)first_free);
+				i, cfg->blocks[blk], first_free);
 			ret = -EINVAL;
 			goto out;
 		}
 		if (i > 0 && cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
 			error("blocks %d and %d in reverse order: %llu < %llu",
-				blk, blocks[i - 1],
-				(unsigned long long)cfg->blocks[blk],
-				(unsigned long long)cfg->blocks[blocks[i - 1]]);
+				blk, blocks[i - 1], cfg->blocks[blk],
+				cfg->blocks[blocks[i - 1]]);
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/mkfs/main.c b/mkfs/main.c
index a603ec5896f3..fd7543f6120f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -343,8 +343,7 @@ static int create_one_raid_group(struct btrfs_trans_handle *trans,
 			(BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA)) {
 		allocation->mixed += chunk_size;
 	} else {
-		error("unrecognized profile type: 0x%llx",
-				(unsigned long long)type);
+		error("unrecognized profile type: 0x%llx", type);
 		ret = -EINVAL;
 	}
 
@@ -1455,8 +1454,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	if (block_count && block_count > dev_block_count) {
 		error("%s is smaller than requested size, expected %llu, found %llu",
-		      file, (unsigned long long)block_count,
-		      (unsigned long long)dev_block_count);
+		      file, block_count, dev_block_count);
 		goto error;
 	}
 
@@ -1464,7 +1462,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	system_group_size = zoned ?  zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
-				(unsigned long long)system_group_size);
+			system_group_size);
 		goto error;
 	}
 
@@ -1602,7 +1600,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			device = container_of(fs_info->fs_devices->devices.next,
 					struct btrfs_device, dev_list);
 			printf("adding device %s id %llu\n", file,
-				(unsigned long long)device->devid);
+				device->devid);
 		}
 	}
 
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 92be32ea4238..ab9a24bea299 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -340,9 +340,8 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 
 		ret_read = pread64(fd, buffer, st->st_size, bytes_read);
 		if (ret_read == -1) {
-			error("cannot read %s at offset %llu length %llu: %m",
-				path_name, (unsigned long long)bytes_read,
-				(unsigned long long)st->st_size);
+			error("cannot read %s at offset %llu length %lu: %m",
+				path_name, bytes_read, st->st_size);
 			free(buffer);
 			goto end;
 		}
@@ -388,10 +387,9 @@ again:
 		ret_read = pread64(fd, eb->data, sectorsize, file_pos +
 				   bytes_read);
 		if (ret_read == -1) {
-			error("cannot read %s at offset %llu length %llu: %m",
-				path_name,
-				(unsigned long long)file_pos + bytes_read,
-				(unsigned long long)sectorsize);
+			error("cannot read %s at offset %llu length %u: %m",
+				path_name, file_pos + bytes_read,
+				sectorsize);
 			goto end;
 		}
 
diff --git a/random-test.c b/random-test.c
index a612bc02f417..ab97d42f7088 100644
--- a/random-test.c
+++ b/random-test.c
@@ -66,7 +66,7 @@ static int ins_one(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	unsigned long oid;
 	btrfs_init_path(&path);
 	ret = setup_key(radix, &key, 0);
-	sprintf(buf, "str-%llu\n", (unsigned long long)key.objectid);
+	sprintf(buf, "str-%llu\n", key.objectid);
 	ret = btrfs_insert_item(trans, root, &key, buf, strlen(buf));
 	if (ret)
 		goto error;
@@ -78,7 +78,7 @@ static int ins_one(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		goto error;
 	return ret;
 error:
-	printf("failed to insert %llu\n", (unsigned long long)key.objectid);
+	printf("failed to insert %llu\n", key.objectid);
 	return ret;
 }
 
@@ -93,11 +93,11 @@ static int insert_dup(struct btrfs_trans_handle *trans, struct btrfs_root
 	ret = setup_key(radix, &key, 1);
 	if (ret < 0)
 		return 0;
-	sprintf(buf, "str-%llu\n", (unsigned long long)key.objectid);
+	sprintf(buf, "str-%llu\n", key.objectid);
 	ret = btrfs_insert_item(trans, root, &key, buf, strlen(buf));
 	if (ret != -EEXIST) {
 		printf("insert on %llu gave us %d\n",
-		       (unsigned long long)key.objectid, ret);
+		       key.objectid, ret);
 		return ret;
 	}
 	return 0;
@@ -126,7 +126,7 @@ static int del_one(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		goto error;
 	return 0;
 error:
-	printf("failed to delete %llu\n", (unsigned long long)key.objectid);
+	printf("failed to delete %llu\n", key.objectid);
 	return ret;
 }
 
@@ -146,7 +146,7 @@ static int lookup_item(struct btrfs_trans_handle *trans, struct btrfs_root
 		goto error;
 	return 0;
 error:
-	printf("unable to find key %llu\n", (unsigned long long)key.objectid);
+	printf("unable to find key %llu\n", key.objectid);
 	return ret;
 }
 
@@ -167,7 +167,7 @@ static int lookup_enoent(struct btrfs_trans_handle *trans, struct btrfs_root
 	return 0;
 error:
 	printf("able to find key that should not exist %llu\n",
-	       (unsigned long long)key.objectid);
+	       key.objectid);
 	return -EEXIST;
 }
 
diff --git a/tests/fsstress.c b/tests/fsstress.c
index 884aabbc031a..3bfef7052b0d 100644
--- a/tests/fsstress.c
+++ b/tests/fsstress.c
@@ -1012,8 +1012,7 @@ check_cwd(void)
 		return;
 
 	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%llu) != top_ino (%llu)\n",
-		(unsigned long long) statbuf.st_ino,
-		(unsigned long long) top_ino);
+		statbuf.st_ino, top_ino);
 out:
 	assert(chdir(homedir) == 0);
 	fprintf(stderr, "fsstress: check_cwd failure\n");
diff --git a/tests/fssum.c b/tests/fssum.c
index 96dc1f0f0e12..3f1e58b48179 100644
--- a/tests/fssum.c
+++ b/tests/fssum.c
@@ -358,7 +358,7 @@ sum_file_data_strict(int fd, sum_t *dst)
 		if (verbose >= 2)
 			fprintf(stderr,
 				"adding to sum at file offset %llu, %d bytes\n",
-				(unsigned long long)pos, ret);
+				pos, ret);
 		sum_add_u64(dst, (uint64_t)pos);
 		sum_add(dst, buf, ret);
 		pos += ret;
-- 
2.35.1

