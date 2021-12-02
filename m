Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E3466175
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356991AbhLBKeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:34:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50514 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356975AbhLBKeL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:34:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9D33CE2207
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C449C53FCB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638441046;
        bh=59xhs2+h70b9yFRcwtESXYasR/N9z/s/vqBCBRwZtVI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Dxo+XrORERohez+0j6tdkCVtwTbq+doVnCEoNUIpNrrJ2RXhNrLt6mUvh48YV/EQK
         6YLhHmGdjv8kEZJe1nzBnPdTJAKbxfcg3zc0H3t1suKYD5ZD9EKLE/GUuf8MFrGFVs
         iMm+HN5/mG41tVLj5lszuE6K5HHALa88qL+2qba8xINrGvBpneTn0zTeJQOxCLjDy3
         SfuAsxQxxp0K9JFn6enNWxHyfhiLCgcpgyO2aHYAoqvrGE0T5ImkpNwI1n4yPhz8+6
         sBxBNXUkBkXuEdgS6WKTmtHELwS0QrSoIe8JM9dagNwDRP8xgldZtKYWIUty7/hrW5
         /KNP5q7vZZQCQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: remove useless condition check before splitting leaf
Date:   Thu,  2 Dec 2021 10:30:37 +0000
Message-Id: <0f1bed5dede2ac134033ca79e899ddd5dec833b1.1638440535.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When inserting a key, we check if the write_lock_level is less than 1,
and if so we set it to 1, release the path and retry the tree traversal.

However that is unnecessary, because when ins_len is greater than 0, we
know that write_lock_level can never be less than 1.

The logic to retry is also buggy, because in case ins_len was decremented,
due to an exact key match and the search is not meant for item extension
(path->search_for_extension is 0), we retry without incrementing ins_len,
which would make the next retry decrement it again by the same amount.

So remove the check for write_lock_level being less than 1 and add an
assertion to assert it's always >= 1.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 62066c034363..9439c8606835 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1968,11 +1968,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				ins_len -= sizeof(struct btrfs_item);
 			}
 			if (ins_len > 0 && leaf_free_space < ins_len) {
-				if (write_lock_level < 1) {
-					write_lock_level = 1;
-					btrfs_release_path(p);
-					goto again;
-				}
+				ASSERT(write_lock_level >= 1);
 
 				err = split_leaf(trans, root, key,
 						 p, ins_len, ret == 0);
-- 
2.33.0

