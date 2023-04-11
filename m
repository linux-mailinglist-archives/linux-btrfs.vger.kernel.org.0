Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E596DE47C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 21:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDKTLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDKTLE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 15:11:04 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A440D5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 12:11:00 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E619E802BD;
        Tue, 11 Apr 2023 15:10:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1681240260; bh=C2k/uUMEixpYiaHgCSf0Mi2d/UL4h4cn6n6VNqkZOvI=;
        h=From:To:Cc:Subject:Date:From;
        b=Cvf6bq60L/cQH8rNAq4HeRf1h/7RWNZZr6CVrx17b7omenlSevT3gQhK5fEk0lDv8
         iLnE5D3scZq/KQY/BN6sLa9ecR+26m5HotphR0K2hXu/Q4xGkChz1O2DIk6RBy3a5o
         CaSl8CwbBieSAX9KxytgTcBzeZTkRyKw2SsOVop4khSUvTKsl4gnuu2QNmL3uLJANw
         a6i4HpPD4e+KVRg7c1Hw1LSeVk1B2GFFzYYIqYUSgLPjdavD07YDwF69kE8F9yYeoW
         aububQrZiaNpMwcMWfONSGA7kiQz9YsEpM/DPGd3ThdELDxyhqtv9dG9OG9BVrMgu5
         QiaFmIJD9oqLw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] btrfs: don't commit transaction for every subvol create
Date:   Tue, 11 Apr 2023 15:10:53 -0400
Message-Id: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently a Meta-internal workload encountered subvolume creation taking
up to 2s each, significantly slower than directory creation. As they
were hoping to be able to use subvolumes instead of directories, and
were looking to create hundreds, this was a significant issue. After
Josef investigated, it turned out to be due to the transaction commit
currently performed at the end of subvolume creation.

This change improves the workload by not doing transaction commit for every
subvolume creation, and merely requiring a transaction commit on fsync.
In the worst case, of doing a subvolume create and fsync in a loop, this
should require an equal amount of time to the current scheme; and in the
best case, the internal workload creating hundreds of subvols before
fsyncing is greatly improved.

While it would be nice to be able to use the log tree and use the normal
fsync path, logtree replay can't deal with new subvolume inodes
presently.

It's possible that there's some reason that the transaction commit is
necessary for correctness during subvolume creation; however,
git logs indicate that the commit dates back to the beginning of
subvolume creation, and there are no notes on why it would be necessary.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ioctl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 25833b4eeaf5..a6f1ee2dc1b9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -647,6 +647,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	}
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
+	/* tree log can't currently deal with an inode which is a new root */
+	btrfs_set_log_full_commit(trans);
 
 	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
 	if (ret)
@@ -755,10 +757,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	trans->bytes_reserved = 0;
 	btrfs_subvolume_release_metadata(root, &block_rsv);
 
-	if (ret)
-		btrfs_end_transaction(trans);
-	else
-		ret = btrfs_commit_transaction(trans);
+	btrfs_end_transaction(trans);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
-- 
2.40.0

