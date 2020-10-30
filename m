Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD692A0FDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgJ3VDP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4080C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so5126422qtp.13
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WauWhR/+pt1gJWtIc3vo/FkfYt8/jl6mKnEG7cOK4es=;
        b=qGDqiKbzxY5TxLwkGQbtoDOgSfdPC41tAvvN1VcKgiCCutOOYM9NKAs27wV17e5FUe
         +UZOEcOC5fmN+WYuB3299e3ZtfMpg9P+fgMvwaPEWj/7GKCIDUS4sRVvJGm31s7nNL0L
         0mhCwJZkFMXbbyT0XzLN+SdpysXepW9YEsoG/Xq31cm9IS/QMCWKAkugZrO4r14Q0FrE
         iHW4frh3ZrLfc3J5hx8AmBeVQakUpeex5WO+L2qXXpscWxd0PJA6sEUOEBBwld3aFlUA
         /jP+6fxbzGUljOCW8mtDM9D/SMLar+3bHRX41rEfWLhDpAPRtNnqr9DMtUK/R2KZABvO
         24VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WauWhR/+pt1gJWtIc3vo/FkfYt8/jl6mKnEG7cOK4es=;
        b=F+hJs74vSmz7nj0j/PkXDpHixGL307z3o+vAezLvdA+uDnO+7Huhxwz/NXBJSCzUZY
         JLXneAVLgRpV2HRI8GcXeeWXxctuRQQk2n9SnB7xlnCMyKc/4p6MVKfJKhdRKW1kkRF+
         HxVYchbMLcP9HB3A9AMLUZw2c04v34/aCr6fS3FRIWqSmaNuDbq8/ALjnslyFQ0ERyvQ
         nQ8mWuCmh6k7TkE0eEoTJLgaESownGTf4OuoepHcmst7uFv2RQAh7wc2j30gQP7YH9bc
         0FqjFRS4OXXSSz/N5x+wu1VbaUz/eqwWrmQN0sWhya2RcL5kK/63txwnnEPPkiZq6d5G
         oDFA==
X-Gm-Message-State: AOAM5306mzVCKL1IeTsLoy6Diwi61TEH6NwX4tMpdoIXM+n1Auiz8HNd
        sUfKs6V1gLgAKbdudKP63W7cOMjS3ttYTBRY
X-Google-Smtp-Source: ABdhPJwHvbX84881scvmshQTaJfmbeDX4R2hi0CA69oo0HzCClSWCHP8k3x2x7NOpgf7Bu10fhxakw==
X-Received: by 2002:ac8:58c8:: with SMTP id u8mr4060487qta.63.1604091793867;
        Fri, 30 Oct 2020 14:03:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r133sm1160660qke.23.2020.10.30.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/14] btrfs: use btrfs_read_node_slot in btrfs_realloc_node
Date:   Fri, 30 Oct 2020 17:02:55 -0400
Message-Id: <2e17fbd6cb092191a3e1a87bf538375747e5dd7a.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this giant open-coded nightmare in btrfs_realloc_node that does
the same thing that the normal read path does, which is to see if we
have the eb in memory already, and if not read it, and verify the eb is
uptodate.  Delete this open coding and simply use btrfs_read_node_slot.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f8a7416d8a24..000f18923c5a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1578,7 +1578,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *cur;
 	u64 blocknr;
-	u64 gen;
 	u64 search_start = *last_ret;
 	u64 last_block = 0;
 	u64 other;
@@ -1587,7 +1586,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	int i;
 	int err = 0;
 	int parent_level;
-	int uptodate;
 	u32 blocksize;
 	int progress_passed = 0;
 	struct btrfs_disk_key disk_key;
@@ -1607,7 +1605,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	btrfs_set_lock_blocking_write(parent);
 
 	for (i = start_slot; i <= end_slot; i++) {
-		struct btrfs_key first_key;
 		int close = 1;
 
 		btrfs_node_key(parent, &disk_key, i);
@@ -1616,8 +1613,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 
 		progress_passed = 1;
 		blocknr = btrfs_node_blockptr(parent, i);
-		gen = btrfs_node_ptr_generation(parent, i);
-		btrfs_node_key_to_cpu(parent, &first_key, i);
 		if (last_block == 0)
 			last_block = blocknr;
 
@@ -1634,31 +1629,9 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 			continue;
 		}
 
-		cur = find_extent_buffer(fs_info, blocknr);
-		if (cur)
-			uptodate = btrfs_buffer_uptodate(cur, gen, 0);
-		else
-			uptodate = 0;
-		if (!cur || !uptodate) {
-			if (!cur) {
-				cur = read_tree_block(fs_info, blocknr, gen,
-						      parent_level - 1,
-						      &first_key);
-				if (IS_ERR(cur)) {
-					return PTR_ERR(cur);
-				} else if (!extent_buffer_uptodate(cur)) {
-					free_extent_buffer(cur);
-					return -EIO;
-				}
-			} else if (!uptodate) {
-				err = btrfs_read_buffer(cur, gen,
-						parent_level - 1,&first_key);
-				if (err) {
-					free_extent_buffer(cur);
-					return err;
-				}
-			}
-		}
+		cur = btrfs_read_node_slot(parent, i);
+		if (IS_ERR(cur))
+			return PTR_ERR(cur);
 		if (search_start == 0)
 			search_start = last_block;
 
-- 
2.26.2

