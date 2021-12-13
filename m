Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEED347232F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhLMIpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 03:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhLMIpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 03:45:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61231C06173F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 00:45:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC0F5CE0B0B
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603B1C341CA
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639385120;
        bh=tTnrcz8SseaJQB4dzUUq1Dt47Vm+vi2Vik9PcjTC/xo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UGNHzw7N8KjrStLNIc5h/CPeli6mbHam+UlJw/Wsa5ih8WhSxtup5sZyZ5Hqi8X84
         MtJ8r0vUvopudstJ8PneakwTVD1KZUzutU/J4EC5mOJpGkJE0Af0n4TreA6g0fyURL
         +OwNrgNYn0HfjcCz618SsVGSDmLnzac1NVJTnpp/rG6vHvci7Xvbce+LMenxghqqpM
         YBm3kyj2hWQ6o4qNfm3XPAkfUigfAp+9iJ25S0q0/LUecAV0MgLUNeX1ydReUqXKGm
         r0b6AC5jGAEtmAj6dhOo9wQqgWwAssGEndHoGurXjq/EnIW+7vqRR8S168pPVzKGHJ
         2qLY3hjMGfoqw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: skip transaction commit after failure to create subvolume
Date:   Mon, 13 Dec 2021 08:45:14 +0000
Message-Id: <ce18f34525b95ad07579d8da6f6d854d301e1e59.1639384875.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1639384875.git.fdmanana@suse.com>
References: <cover.1639384875.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At ioctl.c:create_subvol(), when we fail to create a subvolume we always
commit the transaction. In most cases this is a no-op, since all the error
paths, except for one, abort the transaction - the only exception is when
we fail to insert the new root item into the root tree, in that case we
don't abort the transaction because we didn't do anything that is
irreversible - however we end up committing the transaction which although
is not a functional problem, it adds unnecessary rotation of the backup
roots in the superblock and unnecessary work.

So change that to commit a transaction only when no error happened,
otherwise just call btrfs_end_transaction() to release our reference on
the transaction.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7565b667f4fc..a5bd6926f7ff 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -544,7 +544,6 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	struct timespec64 cur_time = current_time(dir);
 	struct inode *inode;
 	int ret;
-	int err;
 	dev_t anon_dev = 0;
 	u64 objectid;
 	u64 index = 0;
@@ -724,9 +723,10 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	trans->bytes_reserved = 0;
 	btrfs_subvolume_release_metadata(root, &block_rsv);
 
-	err = btrfs_commit_transaction(trans);
-	if (err && !ret)
-		ret = err;
+	if (ret)
+		btrfs_end_transaction(trans);
+	else
+		ret = btrfs_commit_transaction(trans);
 
 	if (!ret) {
 		inode = btrfs_lookup_dentry(dir, dentry);
-- 
2.33.0

