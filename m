Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE860E8B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiJZTLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiJZTL0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:26 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B313C1E7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:53 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d13so11383177qko.5
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npK5Wby4ibwkD3yZhZ93zyFJvP5HC1zTrarDA/5ewAA=;
        b=bYyyd/6MMmfnMPzssJpxmm1XCvWQNwGMYL0OrRGV6oNYstALxbzPXU5anDQ8gqtTNK
         MyIOvB7yZNOrav4PFazB1g6eT4pI4tfZFQUCd+IffKCqM+ZvrxGUVWAJb6cGEgxAzpnO
         WG9XMoHgA5OF3jkksGB3qut/bFeH/v+3HgKDiXWPvFHrjfOICwShwn6lDYzn8KmR93eD
         cCzf4YoKoTJ+vUGu4eh2DJRMpGOwDs0OVlNdtTYjommOmOvakVPTMjvrM/2goZATI2t4
         VS2AJmOhc3mztSqi/OvMLZdqbMUtQ1sQABnDXsI6kTU8WeL5bTSoueQ1ymlqu7vfBSra
         NshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npK5Wby4ibwkD3yZhZ93zyFJvP5HC1zTrarDA/5ewAA=;
        b=7k7Jm2kdFIWpgxtKhEALZnvRYxKtJ+v/VOLEYRddv2J2hh3a72cS3E17gBKKCzq1KF
         eeuz9OpSLSjmmlstCAZel1nkXNXk5XIoBq4ZGiQdEbP888HND3/NV2YZNXvcAdSsAgsC
         A42OgvaWCm5KAcEw+SKCxqpL6mLBrLTkpXHOyQ6A9e7uF4WxKo5NR5SxoeXS46rM56z/
         VC9g++FQrUjFkHiyXTQADGk+AplhJkIk2uXS3uCba4bAs4l0GpAkV9HUYlV8PS1/mDfV
         dirWsFQj2FnrtKm1R7ddO1+pntr3tgvh5+AxzQykjoLqZfovnJIymlXtgNxNdiZ45oPw
         y6ag==
X-Gm-Message-State: ACrzQf19j/tfXuxBQld7XzftDnMRn8QLSw11XNW6DmIUCifeZqu/HPJO
        7xwK8T463ltjBv5dcbblBGa65g7LKBHWgQ==
X-Google-Smtp-Source: AMsMyM5OL2CwR3mZO5K8U/vI84fBGCX5bwKNewqFlFWV0bfivkUN3KRLQylBsp/Tg86r+wp7p2l8FA==
X-Received: by 2002:a05:620a:1505:b0:6e9:168f:76a5 with SMTP id i5-20020a05620a150500b006e9168f76a5mr31772378qkk.142.1666811331895;
        Wed, 26 Oct 2022 12:08:51 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006eed75805a2sm4496359qkp.126.2022.10.26.12.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/26] btrfs: move inode prototypes to btrfs_inode.h
Date:   Wed, 26 Oct 2022 15:08:21 -0400
Message-Id: <7b658188a43153b53922a640c4c996fc552d93ba.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I initially wanted to make a new header file for this, but these
prototypes do naturally fit into btrfs_inode.h.  If we want to extract
vfs from pure btrfs code in the future we may need to split this up, but
btrfs_inode embeds the vfs_inode, so it makes sense to put the
prototypes in this header for now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h | 137 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h       | 137 -----------------------------------------
 2 files changed, 137 insertions(+), 137 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 530a0ebfab3f..3b6d59776f85 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -410,4 +410,141 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
+
+void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num);
+void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
+			int mirror_num, enum btrfs_compression_type compress_type);
+int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
+			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
+int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
+			  u32 bio_offset, struct page *page, u32 pgoff);
+unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
+				    u32 bio_offset, struct page *page,
+				    u64 start, u64 end);
+int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
+			  u32 bio_offset, struct page *page, u32 pgoff);
+noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
+			      u64 *orig_start, u64 *orig_block_len,
+			      u64 *ram_bytes, bool nowait, bool strict);
+
+void __btrfs_del_delalloc_inode(struct btrfs_root *root,
+				struct btrfs_inode *inode);
+struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
+int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
+int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
+		       struct btrfs_inode *dir, struct btrfs_inode *inode,
+		       const struct fscrypt_str *name);
+int btrfs_add_link(struct btrfs_trans_handle *trans,
+		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
+		   const struct fscrypt_str *name, int add_backref, u64 index);
+int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry);
+int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
+			 int front);
+
+int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
+int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
+			       bool in_reclaim_context);
+int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
+			      unsigned int extra_bits,
+			      struct extent_state **cached_state);
+struct btrfs_new_inode_args {
+	/* Input */
+	struct inode *dir;
+	struct dentry *dentry;
+	struct inode *inode;
+	bool orphan;
+	bool subvol;
+
+	/*
+	 * Output from btrfs_new_inode_prepare(), input to
+	 * btrfs_create_new_inode().
+	 */
+	struct posix_acl *default_acl;
+	struct posix_acl *acl;
+	struct fscrypt_name fname;
+};
+int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
+			    unsigned int *trans_num_items);
+int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
+			   struct btrfs_new_inode_args *args);
+void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
+struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
+				     struct inode *dir);
+ void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
+			        u32 bits);
+void btrfs_clear_delalloc_extent(struct inode *inode,
+				 struct extent_state *state, u32 bits);
+void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
+				 struct extent_state *other);
+void btrfs_split_delalloc_extent(struct inode *inode,
+				 struct extent_state *orig, u64 split);
+void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
+vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
+void btrfs_evict_inode(struct inode *inode);
+struct inode *btrfs_alloc_inode(struct super_block *sb);
+void btrfs_destroy_inode(struct inode *inode);
+void btrfs_free_inode(struct inode *inode);
+int btrfs_drop_inode(struct inode *inode);
+int __init btrfs_init_cachep(void);
+void __cold btrfs_destroy_cachep(void);
+struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
+			      struct btrfs_root *root, struct btrfs_path *path);
+struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root);
+struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
+				    struct page *page, size_t pg_offset,
+				    u64 start, u64 end);
+int btrfs_update_inode(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root, struct btrfs_inode *inode);
+int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
+				struct btrfs_root *root, struct btrfs_inode *inode);
+int btrfs_orphan_add(struct btrfs_trans_handle *trans,
+		struct btrfs_inode *inode);
+int btrfs_orphan_cleanup(struct btrfs_root *root);
+int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size);
+void btrfs_add_delayed_iput(struct inode *inode);
+void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info);
+int btrfs_wait_on_delayed_iputs(struct btrfs_fs_info *fs_info);
+int btrfs_prealloc_file_range(struct inode *inode, int mode,
+			      u64 start, u64 num_bytes, u64 min_size,
+			      loff_t actual_len, u64 *alloc_hint);
+int btrfs_prealloc_file_range_trans(struct inode *inode,
+				    struct btrfs_trans_handle *trans, int mode,
+				    u64 start, u64 num_bytes, u64 min_size,
+				    loff_t actual_len, u64 *alloc_hint);
+int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
+		u64 start, u64 end, int *page_started, unsigned long *nr_written,
+		struct writeback_control *wbc);
+int btrfs_writepage_cow_fixup(struct page *page);
+void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
+					  struct page *page, u64 start,
+					  u64 end, bool uptodate);
+int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
+					     int compress_type);
+int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
+					  u64 file_offset, u64 disk_bytenr,
+					  u64 disk_io_size,
+					  struct page **pages);
+ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
+			   struct btrfs_ioctl_encoded_io_args *encoded);
+ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
+			     const struct btrfs_ioctl_encoded_io_args *encoded);
+
+ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_before);
+
+extern const struct dentry_operations btrfs_dentry_operations;
+
+/* Inode locking type flags, by default the exclusive lock is taken */
+enum btrfs_ilock_type {
+	ENUM_BIT(BTRFS_ILOCK_SHARED),
+	ENUM_BIT(BTRFS_ILOCK_TRY),
+	ENUM_BIT(BTRFS_ILOCK_MMAP),
+};
+
+int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags);
+void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
+void btrfs_update_inode_bytes(struct btrfs_inode *inode,
+			      const u64 add_bytes,
+			      const u64 del_bytes);
+void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end);
+
 #endif
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0afd3b2dca0f..c81fc444780d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -763,143 +763,6 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_size);
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
-/* inode.c */
-void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num);
-void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
-			int mirror_num, enum btrfs_compression_type compress_type);
-int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
-			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff);
-unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
-				    u32 bio_offset, struct page *page,
-				    u64 start, u64 end);
-int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff);
-noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict);
-
-void __btrfs_del_delalloc_inode(struct btrfs_root *root,
-				struct btrfs_inode *inode);
-struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
-int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
-int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
-		       struct btrfs_inode *dir, struct btrfs_inode *inode,
-		       const struct fscrypt_str *name);
-int btrfs_add_link(struct btrfs_trans_handle *trans,
-		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
-		   const struct fscrypt_str *name, int add_backref, u64 index);
-int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry);
-int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
-			 int front);
-
-int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context);
-int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
-			       bool in_reclaim_context);
-int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
-			      unsigned int extra_bits,
-			      struct extent_state **cached_state);
-struct btrfs_new_inode_args {
-	/* Input */
-	struct inode *dir;
-	struct dentry *dentry;
-	struct inode *inode;
-	bool orphan;
-	bool subvol;
-
-	/*
-	 * Output from btrfs_new_inode_prepare(), input to
-	 * btrfs_create_new_inode().
-	 */
-	struct posix_acl *default_acl;
-	struct posix_acl *acl;
-	struct fscrypt_name fname;
-};
-int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
-			    unsigned int *trans_num_items);
-int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
-			   struct btrfs_new_inode_args *args);
-void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
-struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
-				     struct inode *dir);
- void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
-			        u32 bits);
-void btrfs_clear_delalloc_extent(struct inode *inode,
-				 struct extent_state *state, u32 bits);
-void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
-				 struct extent_state *other);
-void btrfs_split_delalloc_extent(struct inode *inode,
-				 struct extent_state *orig, u64 split);
-void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
-vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
-void btrfs_evict_inode(struct inode *inode);
-struct inode *btrfs_alloc_inode(struct super_block *sb);
-void btrfs_destroy_inode(struct inode *inode);
-void btrfs_free_inode(struct inode *inode);
-int btrfs_drop_inode(struct inode *inode);
-int __init btrfs_init_cachep(void);
-void __cold btrfs_destroy_cachep(void);
-struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
-			      struct btrfs_root *root, struct btrfs_path *path);
-struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root);
-struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 end);
-int btrfs_update_inode(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct btrfs_inode *inode);
-int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root, struct btrfs_inode *inode);
-int btrfs_orphan_add(struct btrfs_trans_handle *trans,
-		struct btrfs_inode *inode);
-int btrfs_orphan_cleanup(struct btrfs_root *root);
-int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size);
-void btrfs_add_delayed_iput(struct inode *inode);
-void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info);
-int btrfs_wait_on_delayed_iputs(struct btrfs_fs_info *fs_info);
-int btrfs_prealloc_file_range(struct inode *inode, int mode,
-			      u64 start, u64 num_bytes, u64 min_size,
-			      loff_t actual_len, u64 *alloc_hint);
-int btrfs_prealloc_file_range_trans(struct inode *inode,
-				    struct btrfs_trans_handle *trans, int mode,
-				    u64 start, u64 num_bytes, u64 min_size,
-				    loff_t actual_len, u64 *alloc_hint);
-int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
-		u64 start, u64 end, int *page_started, unsigned long *nr_written,
-		struct writeback_control *wbc);
-int btrfs_writepage_cow_fixup(struct page *page);
-void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
-					  struct page *page, u64 start,
-					  u64 end, bool uptodate);
-int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
-					     int compress_type);
-int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
-					  u64 file_offset, u64 disk_bytenr,
-					  u64 disk_io_size,
-					  struct page **pages);
-ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
-			   struct btrfs_ioctl_encoded_io_args *encoded);
-ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
-			     const struct btrfs_ioctl_encoded_io_args *encoded);
-
-ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter, size_t done_before);
-
-extern const struct dentry_operations btrfs_dentry_operations;
-
-/* Inode locking type flags, by default the exclusive lock is taken */
-enum btrfs_ilock_type {
-	ENUM_BIT(BTRFS_ILOCK_SHARED),
-	ENUM_BIT(BTRFS_ILOCK_TRY),
-	ENUM_BIT(BTRFS_ILOCK_MMAP),
-};
-
-int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags);
-void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
-void btrfs_update_inode_bytes(struct btrfs_inode *inode,
-			      const u64 add_bytes,
-			      const u64 del_bytes);
-void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end);
-
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-- 
2.26.3

