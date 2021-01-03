Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8402E8B7C
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 10:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhACJ3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 04:29:19 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:42858 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhACJ3N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Jan 2021 04:29:13 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id EDB1845074C;
        Sun,  3 Jan 2021 11:28:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1609666102; bh=sCdz5YTBEacN8K1ciFEBITmLYV9ENqQjQxUblPjnLko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=etl/YdeIH66G2tCo0HfV0iDcasa/+1U2jaPx/w0f0gXH/Y5vhWETPLeGPgK+j9OR/
         jztuhNoB2pxPuSW9fe/8ZxCZ+aKijmcD8XtDwWktLtjLi5f5IyWOgR02EwlgeIB3uf
         xIbSwqErTo/gulOIrciFUW3MpAvco9FtW5L4egZ0=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id D3EB345073F;
        Sun,  3 Jan 2021 11:28:21 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id NuBwAqKI52D2; Sun,  3 Jan 2021 11:28:21 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 9684E45073C;
        Sun,  3 Jan 2021 11:28:21 +0200 (EET)
Received: from localhost.localdomain (unknown [211.106.132.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 1FBC21BE00CF;
        Sun,  3 Jan 2021 11:28:19 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH v2 1/2] btrfs: prevent NULL pointer dereference in extent_io_tree_panic()
Date:   Sun,  3 Jan 2021 17:28:03 +0800
Message-Id: <20210103092804.756-2-l@damenly.su>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210103092804.756-1-l@damenly.su>
References: <20210103092804.756-1-l@damenly.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mlotPBD+kjECgQHnABwY1s1k6UZaH55TE3V0G3GeYQiOGYip5XRGxnW10RX+5ujkX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some extent io trees are initialized with NULL private member(e.g., btrfs_devi
ce::alloc_state and btrfs_fs_info::excluded_extents). Dereference of a NULL
@tree->private as struct inode * will cause kernel panic.

Just pass @tree->fs_info as parameter to extent_io_tree_panic() directly.
Let it panic as expected at least.

Fixes: 05912a3c04eb ("btrfs: drop extent_io_ops::tree_fs_info callback")
Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e3b72e63e42..c9cee458e001 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -676,9 +676,7 @@ alloc_extent_state_atomic(struct extent_state *prealloc)
 
 static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
 {
-	struct inode *inode = tree->private_data;
-
-	btrfs_panic(btrfs_sb(inode->i_sb), err,
+	btrfs_panic(tree->fs_info, err,
 	"locking error: extent tree was modified by another thread while locked");
 }
 
-- 
2.29.2

