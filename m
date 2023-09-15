Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0844D7A21E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjIOPEx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjIOPE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 11:04:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B379272D
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 08:04:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA79C433C9
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694790240;
        bh=R81sj7K18FD7eQG5m4VnpHhVGhFxfJLbnQQtJkGV6tY=;
        h=From:To:Subject:Date:From;
        b=KWOt/4514g/CHvConAUuFhkMpFFyPvaaI0zhXM0jdt57Sbp/rdmrYbr3VOAivW1mM
         rAAuovK5KS5TVQdGT8sihCYRIoX2LWeUFda7dBnZiajQRm7v4JwEaUJsz9ivkUz3nX
         vA1m5AZF1fXhdCv6518PVLv71fu2h2IQbvoQqVEwdT3j6iJjyG5OGd+9nY3Ol0biKj
         Fw8Z4i/Vq/IPnQ460l2abpN/eigagxdXH9Qqv7KUQzEx76JfTf/a6d2GFHdtm/gO3p
         INUMEyQXKI0pW9L8tTMJznoKWh1bljKzrKNpe4XI2A+0IyH+wy+muo1CozMFgwVAMs
         UPjvZIjgQuoYQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove useless comment from btrfs_pin_extent_for_log_replay()
Date:   Fri, 15 Sep 2023 16:03:57 +0100
Message-Id: <46c6009d05086ab67d5f2d8c0ebe7d749f1d8cea.1694790077.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The comment on top of btrfs_pin_extent_for_log_replay() mentioning that
the function must be called within a transaction is pointless as of
commit 9fce5704542c ("btrfs: Make btrfs_pin_extent_for_log_replay take
transaction handle"), since the function now takes a transaction handle
as its first argument. So remove the comment because it's completely
useless now.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1701aadbfea3..adffeae41c0d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2566,9 +2566,6 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-/*
- * this function must be called within transaction
- */
 int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    const struct extent_buffer *eb)
 {
-- 
2.40.1

