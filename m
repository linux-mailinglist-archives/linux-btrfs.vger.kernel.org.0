Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D905979D0A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjILMEx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 08:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjILMEo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 08:04:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F110DA
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 05:04:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20A2C433C9
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 12:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694520280;
        bh=L8pZ7QkxhNNdgBk4hnuDEp7Ac3veDs3oaqOhKBl4I0I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k8LCy0XiLaxMs7KpXsuoxZo7YybY/u4KanWdhBBoBt+TMp4newFcJvHafPKbAF8N8
         qtJRgyAkw2LkYwpnsx1mpf0Y6oRM1Zx8t9PAz2hGn6P2oRexfipnXVlM1AGuBR+Myt
         ogWMHyi0QLjKqdRiSvosZYlZGLdy2F11NiDXCmFQ/0N3hiWJAnmPBQh4Pn9hqGiRdX
         LL+qtosowW+H6yGdYpIlqE7p0rKxN6Zvk0fqEyZl+Iv4Wx/2z9CLhIDteY/X4K/JB1
         Oen3aKz9GqqjTfE290jbf8L+xlbEFYYNHub9fg4NUneD6/i5Ne5FddYEC8SbgWa0F4
         L/B3In6NfTvrQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use btrfs_crit at btrfs_mark_buffer_dirty()
Date:   Tue, 12 Sep 2023 13:04:30 +0100
Message-Id: <a27eae99c07f016de2d585e42a985307096c2ccb.1694519544.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694519543.git.fdmanana@suse.com>
References: <cover.1694519543.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There's no need to use WARN() at btrfs_mark_buffer_dirty() to print an
error message, as we have the fs_info pointer we can use btrfs_crit()
which prints device information and makes the message have a more uniform
format. As we are already aborting the transaction we already have a stack
trace printed as well. So replace the use of WARN() with btrfs_crit().

Also slightly reword the message to use 'logical' instead of 'block' as
it's what is used in other error/warning messages.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 05282a2f0f5b..d906368a2d3f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4404,9 +4404,10 @@ void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
 	ASSERT(trans->transid == fs_info->generation);
 	btrfs_assert_tree_write_locked(buf);
 	if (transid != fs_info->generation) {
-		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
-			buf->start, transid, fs_info->generation);
 		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+"dirty buffer transid mismatch, logical %llu found transid %llu running transid %llu",
+			   buf->start, transid, fs_info->generation);
 	}
 	set_extent_buffer_dirty(buf);
 }
-- 
2.40.1

