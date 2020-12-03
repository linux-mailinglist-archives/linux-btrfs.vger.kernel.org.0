Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475A2CDD6E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgLCSY4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbgLCSYz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:55 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A8C094252
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:01 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id l7so2045145qtp.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=veWjAVm1EUr4XAlzMRvjKGkkM3ajrvwj5nc9cZ/TPV8=;
        b=exr9L2s7T354e0+vAxuUTBGs/6Y++0xKh+G1DjmIi7bWCjhxg+f6Eg2AAjC253jl2R
         gKYPyNIKenTkpxo2Yzsn5/SUabK618Ic/INX9DHZrc9bfnL7h+/1u0n5cY0NdLEYVyEf
         L0CzsIZ27JDZ0FXWepnWOwBNH9pOG93iP517kv7lM9crh4UyXDUC8gMusxZ885OTkWmE
         X7N0fIz98DdNT6KREGqk3VN691O0JkP8aJZE2/h89BpzTzgRxfltSCqLSjlyGiNRZ2/2
         4q11RkEZm9K1CuhW6md7QKbXHGL9fuzmV7R/rQv8lSrOtCc+mQZgrF4mb/wgsiu3GFdX
         R1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veWjAVm1EUr4XAlzMRvjKGkkM3ajrvwj5nc9cZ/TPV8=;
        b=aGMkhsHSZcJ/gO1Qb5byaIdVNQwpeJ6yLZNXWJCeWdN654rJUHi8JxeN3fYuwL0Mam
         3h3z4AKxTG4g9GtsAZTIt486tmJ2TsV/LGTy0E2a+kbDhdodpmrAzrNfgleCWe8P2JC0
         LaNwDMJqygounUtPpRKZxk7QNCqCC8Supnzf7Csr5q2XsC5NSaXl0RnjR/lacPDz8YZ0
         YbUy8fAKgZeC0GLUOBAEzN7NVF4bgHij3nBvAX5Q/qMVtDPrI1q3+oIaicdb6DuVhky+
         Jro+wA4bOITeI4b2WZTfnhkj7wW2pzXVz3yavra5f9pYxT85aqOc2L7VkzvVuTcJzbxH
         QZzg==
X-Gm-Message-State: AOAM5307DLRUYMAwzVx+nKUWeCALwy5xZjpNfo9c4K8ytP3srxWVedyO
        aidb6aqSfkO45ZjlDaiTAYGKhkadGGq/7jPj
X-Google-Smtp-Source: ABdhPJwQUhahOssPOOIufEAO23bdTQfhdVnmImUQBgRYAiOLBP008uZQcWGpEZB2XcYxeLQqr7rYbQ==
X-Received: by 2002:ac8:4818:: with SMTP id g24mr845754qtq.252.1607019840554;
        Thu, 03 Dec 2020 10:24:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s68sm2272104qkc.43.2020.12.03.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 34/53] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Thu,  3 Dec 2020 13:22:40 -0500
Message-Id: <c0a876105179f8b16b2a143603f0eee798cb3226.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in insert_dirty_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f41044d2b032..f329903024b0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1562,6 +1562,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
+	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
 	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
@@ -1572,7 +1573,9 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		sizeof(reloc_root_item->drop_progress));
 	btrfs_set_root_drop_level(reloc_root_item, 0);
 	btrfs_set_root_refs(reloc_root_item, 0);
-	btrfs_update_reloc_root(trans, root);
+	ret = btrfs_update_reloc_root(trans, root);
+	if (ret)
+		return ret;
 
 	if (list_empty(&root->reloc_dirty_list)) {
 		btrfs_grab_root(root);
-- 
2.26.2

