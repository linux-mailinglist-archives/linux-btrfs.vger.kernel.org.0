Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCB4D3EC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiCJBc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiCJBc5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:32:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F1127562
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:31:57 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r12so3513704pla.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wA3C9eQvVwlN3P7ZSXVndDpYplqRN8fVf/ZXWJbg3N4=;
        b=4IFdELrl6oJfhhjh0yNFVEE8SMlrh/vJA+QNf8ECobXJxebhAPTFM1KE/5/dbkKbZX
         04t7IeLJMmosCRl8ACV7iqy5FJBbLBD9Ylp03y+n2AwMchcr5PgMiTJ4l6FX8aIIS5Zn
         CLSH+YIPzp8uk5WN+r7LFsYi5roV73rgta5RDe0Q7sBwt4Ky/bZcG+X1eNjHx/5DjxsB
         cvh8ELjUZm1qU8b/lgD+LT0tZN9pIVWqu22axFgV4T5vZgjz1S8Z8lOoXeTeBtT3rakE
         66OoRT41UKr1Xutdre6oxBB1tEOAqTGoGMbgpPcUqIJ6Qukn/XkEi4K0xEmOHqHAVynH
         5J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wA3C9eQvVwlN3P7ZSXVndDpYplqRN8fVf/ZXWJbg3N4=;
        b=7bfysMhAsmi4yPrj03xQYFmFZmn1XPCo8/Bisy2pM14MbUqxxs2M+O66wY2lMxfHmE
         XdXf7eJH/2TTz9fvwl3rPLsGF8WZNLyNdcQQRrUyRHJWxDt/o8RiIK554AUBkdR8Cl4a
         BupqqclYjgdJQyHOwVC+Hnt2jukhBUF7kLodYQ2lJ3sddHtFGtPLehqm4WowY/mNtIzb
         wswe8IIiwZaMqy8xqnq9S2+D4yw5N4ciEID4dpT9QAMw4DkhrwsZG53sRDVpCs8GpA3r
         LqRT/+UMK3eizAsiGORYxYpD+PpY7PCKpjDH2P+/i4RMwhk3v1O6Rx8tLHdWxsJsBQH4
         uoEA==
X-Gm-Message-State: AOAM533cE3IG076LPYI4+zOOQ05M4suVb64Af+mRqh44cm+1LUteM0v2
        Q0g03H36eCeLJJszokfOFwuwhND6RuaT9w==
X-Google-Smtp-Source: ABdhPJyaM3ywZThv/bBqaEmSxl+47yVRVfSBZUQf92sRv8VUgv0K4RzaJmWRtxBwq/mK1AkBZA8agg==
X-Received: by 2002:a17:90b:3b42:b0:1bf:b72:30e9 with SMTP id ot2-20020a17090b3b4200b001bf0b7230e9mr13300846pjb.135.1646875916751;
        Wed, 09 Mar 2022 17:31:56 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:31:56 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 03/16] btrfs: fix anon_dev leak in create_subvol()
Date:   Wed,  9 Mar 2022 17:31:33 -0800
Message-Id: <ee5528d299d357f225a228c394830d88e6eda17c.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When btrfs_qgroup_inherit(), btrfs_alloc_tree_block, or
btrfs_insert_root() fail in create_subvol(), we return without freeing
anon_dev. Reorganize the error handling in create_subvol() to fix this.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ioctl.c | 49 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 238cee5b5254..d04870ea6a21 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -561,7 +561,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	struct timespec64 cur_time = current_time(dir);
 	struct inode *inode;
 	int ret;
-	dev_t anon_dev = 0;
+	dev_t anon_dev;
 	u64 objectid;
 	u64 index = 0;
 
@@ -571,11 +571,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 
 	ret = btrfs_get_free_objectid(fs_info->tree_root, &objectid);
 	if (ret)
-		goto fail_free;
-
-	ret = get_anon_bdev(&anon_dev);
-	if (ret < 0)
-		goto fail_free;
+		goto out_root_item;
 
 	/*
 	 * Don't create subvolume whose level is not zero. Or qgroup will be
@@ -583,9 +579,13 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	 */
 	if (btrfs_qgroup_level(objectid)) {
 		ret = -ENOSPC;
-		goto fail_free;
+		goto out_root_item;
 	}
 
+	ret = get_anon_bdev(&anon_dev);
+	if (ret < 0)
+		goto out_root_item;
+
 	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
 	 * The same as the snapshot creation, please see the comment
@@ -593,26 +593,26 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	 */
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 8, false);
 	if (ret)
-		goto fail_free;
+		goto out_anon_dev;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		btrfs_subvolume_release_metadata(root, &block_rsv);
-		goto fail_free;
+		goto out_anon_dev;
 	}
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 
 	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
 	if (ret)
-		goto fail;
+		goto out;
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, objectid, NULL, 0, 0, 0,
 				      BTRFS_NESTING_NORMAL);
 	if (IS_ERR(leaf)) {
 		ret = PTR_ERR(leaf);
-		goto fail;
+		goto out;
 	}
 
 	btrfs_mark_buffer_dirty(leaf);
@@ -667,7 +667,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 		btrfs_tree_unlock(leaf);
 		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
 		free_extent_buffer(leaf);
-		goto fail;
+		goto out;
 	}
 
 	free_extent_buffer(leaf);
@@ -676,19 +676,18 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	key.offset = (u64)-1;
 	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
 	if (IS_ERR(new_root)) {
-		free_anon_bdev(anon_dev);
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
-	/* Freeing will be done in btrfs_put_root() of new_root */
+	/* anon_dev is owned by new_root now. */
 	anon_dev = 0;
 
 	ret = btrfs_record_root_in_trans(trans, new_root);
 	if (ret) {
 		btrfs_put_root(new_root);
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, mnt_userns);
@@ -696,7 +695,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	if (ret) {
 		/* We potentially lose an unused inode item here */
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
 
 	/*
@@ -705,28 +704,28 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	ret = btrfs_set_inode_index(BTRFS_I(dir), &index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
 
 	ret = btrfs_insert_dir_item(trans, name, namelen, BTRFS_I(dir), &key,
 				    BTRFS_FT_DIR, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
 
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
 	ret = btrfs_update_inode(trans, root, BTRFS_I(dir));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
 
 	ret = btrfs_add_root_ref(trans, objectid, root->root_key.objectid,
 				 btrfs_ino(BTRFS_I(dir)), index, name, namelen);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto fail;
+		goto out;
 	}
 
 	ret = btrfs_uuid_tree_add(trans, root_item->uuid,
@@ -734,8 +733,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 
-fail:
-	kfree(root_item);
+out:
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
 	btrfs_subvolume_release_metadata(root, &block_rsv);
@@ -751,11 +749,10 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 			return PTR_ERR(inode);
 		d_instantiate(dentry, inode);
 	}
-	return ret;
-
-fail_free:
+out_anon_dev:
 	if (anon_dev)
 		free_anon_bdev(anon_dev);
+out_root_item:
 	kfree(root_item);
 	return ret;
 }
-- 
2.35.1

