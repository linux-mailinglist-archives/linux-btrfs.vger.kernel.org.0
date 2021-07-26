Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27D03D5781
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhGZJsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232508AbhGZJsi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2DF960F5A;
        Mon, 26 Jul 2021 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295347;
        bh=EmWXnuUwapnNj3nOmJY5fYmfycpsJ9kC2X5HUVUECzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QqyytyfM6F7ll8lBOWJ5SdyVZ8P6CWlyJATRV4ytrlIklcHy3zX9F3xxIFEfAhQkX
         wCENLRf3U1cTNXUqU8/8DObiAxMB8ZVcuh/DHvtZczunjBrYFsMIfMNkpRAaGoKnBY
         QmD5CEUp4zGOmE0QFQrfgwcTS46wRW4JqenZ7JxHwxNBdVgV/60GtjlhmP2F+lYfwL
         ZpwwJzYwImHWRNyhfMUI1sF5NYCcgL4MqduqRDe3YpsI43DafDC1Aag473DxAJADQC
         vzbWLz5PdbSGpyd+Eh5/roh54xzCitiUuUfn4rHQHBu4MiT9RIXgc6gjQDmyA127Zq
         IBN6BRbr9PaJA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 07/21] btrfs/inode: allow idmapped mkdir iop
Date:   Mon, 26 Jul 2021 12:28:02 +0200
Message-Id: <20210726102816.612434-8-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; h=from:subject; bh=8dKc0vp/o4w5iCOw41sKb42s/5SKTV0Dwz6fsqZNTuY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zOy4Gr+Z8uvpyo28ZRey6/jamk39gkqbfxcdsvaZFkW 69x9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMx+MXIMOuOpa/r94sFDDNibP4+j8 k96VIbN9Plr9Gzrr+Xt4eZNzL8M/2x51rklL+Sc35oGnxzWMtZV/iovm5bZN6hb2/2brS6ww4A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mkdir() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ffbb995de590..bb50e21a4569 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6874,7 +6874,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid,
 			S_IFDIR | mode, &index);
-- 
2.30.2

