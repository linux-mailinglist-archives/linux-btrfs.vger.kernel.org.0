Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF506C2FF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCULOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCULOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD2028EA8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA2D61B10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE6BC4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397251;
        bh=wi8WzEaa5CZM6UYEBnIhoz1+oiXhj+nLb95eqfZaJCk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XnIo/J5uycRRaATA9sOUT/OuHcOGFf1AXKuTQ+grZ52OLvr90hw1khlGVgaP3ZRBx
         LFP/rbHSnE2PIohWfXIes3ozP7wL1HSHqt3BiSC0JTqoHBwnczPTPi69/paUQWJ2Pf
         1hD8tGTxlx+zT81829p9iMypNda/tjhvJ+f7Y2R+RJfVQ4NQjem+2vX+ECdNx6/7Dh
         1wCVGp+8i1Tz/oR1TEirGE7qURdbJLlbgLiw8a++v5OmC7Yku3W5tzKbPXfmWzm/H7
         exY+0iPbth+GnmXibUGOHqEGf7wssFeCmtdJzJgZut4fMz2k4E+g1TC+eFgFMYJFeA
         98tT/Ykf/0oLw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/24] btrfs: simplify btrfs_should_throttle_delayed_refs()
Date:   Tue, 21 Mar 2023 11:13:43 +0000
Message-Id: <5c0f23a3f7c8fe4c3c6fde9c1d0f4baa80babbfd.1679326431.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_should_throttle_delayed_refs() returns 1 or 2 in case the
delayed refs should be throttled, however the only caller (inode eviction
and truncation path) does not care about those two different conditions,
it treats the return value as a boolean. This allows us to remove one of
the conditions in btrfs_should_throttle_delayed_refs() and change its
return value from 'int' to 'bool'. So just do that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 6 ++----
 fs/btrfs/delayed-ref.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 83e1e1d0ec6a..3fdee91d8079 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -53,7 +53,7 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
+bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 {
 	u64 num_entries =
 		atomic_read(&trans->transaction->delayed_refs.num_entries);
@@ -63,10 +63,8 @@ int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 	smp_mb();
 	avg_runtime = trans->fs_info->avg_delayed_ref_runtime;
 	val = num_entries * avg_runtime;
-	if (val >= NSEC_PER_SEC)
-		return 1;
 	if (val >= NSEC_PER_SEC / 2)
-		return 2;
+		return true;
 
 	return btrfs_check_space_for_delayed_refs(trans->fs_info);
 }
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 2eb34abf700f..316fed159d49 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -385,7 +385,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       struct btrfs_block_rsv *src,
 				       u64 num_bytes);
-int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
+bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
 /*
-- 
2.34.1

