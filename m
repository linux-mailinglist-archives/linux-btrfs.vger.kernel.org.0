Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE541EDDA
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 14:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhJAMyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 08:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231442AbhJAMyV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 08:54:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD86461A8B
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Oct 2021 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092757;
        bh=p855rFOr65qw7hGfuBpjjKVrL1nf6fT/fnIha5BAViM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a3iaDdQDqNLZrjuopEMI/ed2s4GDo3y/WGGKoYuYrrtbD3AD60RmCvoknOASfRQrF
         N1oq3CRg0z30R9o+igaHbFEpJyGJacrrmGbfS90atjQgVF/ug99qGzfqiRt07P/z6E
         6lXUv2IL2cUhlkgLJkVk1kllnLpGfNd/K9iZNd1fDMYTKjcUd+51dQs0zoY6rFVMYd
         1grGbHW2BJz29gZFdVv4KzNeQ2UENrumV48qflTvzly2UQVkhPh//UD7Lu68sbzL3E
         ONy3RETpIlZzaHXeY0Awz0lnTzqqFfLK2xz+14rGHH1+r7kavf2sSIemOLrAcxRdT2
         kBYqzTyw8F19w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: deal with errors when replaying dir entry during log replay
Date:   Fri,  1 Oct 2021 13:52:31 +0100
Message-Id: <a227a1f2393ad8cc1a342045c0a438a4492d389b.1633082623.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633082623.git.fdmanana@suse.com>
References: <cover.1633082623.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At replay_one_one(), we are treating any error returned from
btrfs_lookup_dir_item() or from btrfs_lookup_dir_index_item() as meaning
that there is no existing directory entry in the fs/subvolume tree.
This is not correct since we can get errors such as, for example, -EIO
when reading extent buffers while searching the fs/subvolume's btree.

So fix that and return the error to the caller when it is not -ENOENT.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 79d7cca704fb..61bcd09feedc 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2016,7 +2016,14 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (IS_ERR_OR_NULL(dst_di)) {
+
+	if (dst_di == ERR_PTR(-ENOENT))
+		dst_di = NULL;
+
+	if (IS_ERR(dst_di)) {
+		ret = PTR_ERR(dst_di);
+		goto out;
+	} else if (!dst_di) {
 		/* we need a sequence number to insert, so we only
 		 * do inserts for the BTRFS_DIR_INDEX_KEY types
 		 */
-- 
2.33.0

