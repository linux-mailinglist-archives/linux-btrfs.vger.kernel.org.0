Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED8706602
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjEQLEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEQLEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765EA5FC5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A2064530
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6488CC433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321349;
        bh=8eaTwPW33xYiIHV0bMNfLMK0l/ot9dU3u+tCXXQA9YM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j9NVCMYkI8o+/z7FPauPkI+8aGTViywx6E2TkJl7cKDK8a/hq/h9HuRWcUAVUCGk4
         ZISp49nwQu5AFYkp7DM5abfBQI+rZjlSOd2Sz0EUwuPIEc+I9ocdE8WyDXqbCRaxrq
         LlOVZwr2zoX9iez9a429Qfu5fqUJDE11CFo58uxTtfj3+fRk5cL5dplSVw2uhQr/6G
         YEoqXAPDWQN/4x+7QGbAVDt30IzqKdAowYEBE+wyItcObzqYgjvSBMfR1nSfoVJomN
         RRTs28RQOnpUaOI6JCtYjlVG06Lt5xM5kjhj4oGuPu6SCc0LlNxE3auWxfHu0sObDv
         QuTEx4hBjv3tw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: remove pointless label and goto at btrfs_record_unlink_dir()
Date:   Wed, 17 May 2023 12:02:15 +0100
Message-Id: <2b34194bd933805013e221c5ce35916677a6a304.1684320689.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684320689.git.fdmanana@suse.com>
References: <cover.1684320689.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's no point of having a label and goto at btrfs_record_unlink_dir()
because the function is trivial and can just return early if we are not
in a rename context. So remove the label and goto and instead return
early if we are not in a rename.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 225497b07eb7..061b132d3f96 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7325,6 +7325,9 @@ void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 	inode->last_unlink_trans = trans->transid;
 	mutex_unlock(&inode->log_mutex);
 
+	if (!for_rename)
+		return;
+
 	/*
 	 * If this directory was already logged, any new names will be logged
 	 * with btrfs_log_new_name() and old names will be deleted from the log
@@ -7350,13 +7353,6 @@ void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 	 * properly.  So, we have to be conservative and force commits
 	 * so the new name gets discovered.
 	 */
-	if (for_rename)
-		goto record;
-
-	/* we can safely do the unlink without any special recording */
-	return;
-
-record:
 	mutex_lock(&dir->log_mutex);
 	dir->last_unlink_trans = trans->transid;
 	mutex_unlock(&dir->log_mutex);
-- 
2.34.1

