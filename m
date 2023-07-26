Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84DC763BC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjGZP6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjGZP51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E012D100
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1D261B75
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A42C433C9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387044;
        bh=4+n3KxUhVCZKLqWI3dldkFfStdBhGB7Ax1bGWpiopOM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QjdqSeezjkXQpS8Rgdnke8EBSfgzR3D79e/V4rKXTCEg/8tkNjAIZrjIYiEUIG9Jb
         6a/IJ6b8sP9yL/HJurdKkKl94C+d/shsuwR1k9gKHoIzNhCxVy8vo7Lu+3JzEBoWKC
         8ChL/9rY4D5kHPh28eUpAexFaz5WGVHXrcpV1t45h4VCraMpp4OTMxb5w7ivG81g5N
         qKkEQHgG2cEuVbK8/xP1Q0jpB67elKEHQBiWdVARANZAlhzGxfuzOgDffRtuNNX4nN
         1VqY0dEq+K2JDd1+IrMf8HLu6t4ZpAljFcBZ5gIJ+SzZRQ44CGWQTk6qkbbE7tnIdG
         /b11RW+Db7Efg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/17] btrfs: store the error that turned the fs into error state
Date:   Wed, 26 Jul 2023 16:57:04 +0100
Message-Id: <3b4d1fdb1ce36910c59c58ec6b63c8abcba5da04.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently when we turn the fs into an error state, typically after a
transaction abort, we don't store the error anywhere, we just set a bit
(BTRFS_FS_STATE_ERROR) at struct btrfs_fs_info::fs_state to signal the
error state.

There are cases where it would be useful to have access to the specific
error in order to provide a more meaningful error to users/applications.
This change adds a member to struct btrfs_fs_info to store the error and
removes the BTRFS_FS_STATE_ERROR bit. When there's no error, the new
member (fs_error) has a value of 0, otherwise its value is a negative
errno value.

Followup changes will make use of this new member.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c  |  2 +-
 fs/btrfs/fs.h       | 12 ++++++++----
 fs/btrfs/messages.c | 10 +++++++---
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b4495d4c1533..cad79d4eecdf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3211,7 +3211,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	/* check FS state, whether FS is broken. */
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
-		set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
+		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
 
 	/*
 	 * In the long term, we'll store the compression type in the super
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..ef07c6c252d8 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -46,8 +46,6 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  * Runtime (in-memory) states of filesystem
  */
 enum {
-	/* Global indicator of serious filesystem errors */
-	BTRFS_FS_STATE_ERROR,
 	/*
 	 * Filesystem is being remounted, allow to skip some operations, like
 	 * defrag
@@ -686,6 +684,12 @@ struct btrfs_fs_info {
 	bool qgroup_rescan_running;
 	u8 qgroup_drop_subtree_thres;
 
+	/*
+	 * If this is not 0, then it indicates a serious filesystem error has
+	 * happened and it contains that error (negative errno value).
+	 */
+	int fs_error;
+
 	/* Filesystem state */
 	unsigned long fs_state;
 
@@ -962,8 +966,8 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
 }
 
-#define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
-						   &(fs_info)->fs_state)))
+#define BTRFS_FS_ERROR(fs_info)	(READ_ONCE((fs_info)->fs_error))
+
 #define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info)				\
 	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
 			   &(fs_info)->fs_state)))
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 23fc11af498a..e3c9d2706341 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -10,14 +10,13 @@
 #ifdef CONFIG_PRINTK
 
 #define STATE_STRING_PREFACE	": state "
-#define STATE_STRING_BUF_LEN	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT)
+#define STATE_STRING_BUF_LEN	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT + 1)
 
 /*
  * Characters to print to indicate error conditions or uncommon filesystem state.
  * RO is not an error.
  */
 static const char fs_state_chars[] = {
-	[BTRFS_FS_STATE_ERROR]			= 'E',
 	[BTRFS_FS_STATE_REMOUNTING]		= 'M',
 	[BTRFS_FS_STATE_RO]			= 0,
 	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
@@ -37,6 +36,11 @@ static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
 	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
 	curr += sizeof(STATE_STRING_PREFACE) - 1;
 
+	if (BTRFS_FS_ERROR(info)) {
+		*curr++ = 'E';
+		states_printed = true;
+	}
+
 	for_each_set_bit(bit, &fs_state, sizeof(fs_state)) {
 		WARN_ON_ONCE(bit >= BTRFS_FS_STATE_COUNT);
 		if ((bit < BTRFS_FS_STATE_COUNT) && fs_state_chars[bit]) {
@@ -155,7 +159,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	 * Today we only save the error info to memory.  Long term we'll also
 	 * send it down to the disk.
 	 */
-	set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
+	WRITE_ONCE(fs_info->fs_error, errno);
 
 	/* Don't go through full error handling during mount. */
 	if (!(sb->s_flags & SB_BORN))
-- 
2.34.1

