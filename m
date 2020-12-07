Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B7A2D12D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgLGN7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLGN7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:35 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E0C08E860
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:18 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id c7so4220842qke.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZtS+/iNcUGZ7qi8wPR9jUj/YATP0ShgqNn+aX93evM=;
        b=OQP8Uyddqh9haAeZT7Z6aLOrqe+knibITLKdSCH3Zx1EP5LNeYz6nuZkPMELxs7Cc/
         Om1MPCGzXPyn64qn9hQ5kJrMkURjzWufbIMvuU8OX1EBuC87DzHOmRagZ0W2g4uQQa23
         VT6l3C22lKyrsvNgO4vXvgn0daU35J9JYmiVadEcCJmIPyW9LrLC/2ZOrLg4Ea1VAO8I
         ZvDOggllOMAZbng20v2VBSnJ0g1Nwsgu2Y+izNsds8WyfYOdW33oJFKvYb27so5r3yLg
         0cXoiHiP0wG74J4biIvlfP7UrUlLixm63Pkmi6mKjgkUF3rND5xc9RfGOi80/5QdHnv0
         kllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZtS+/iNcUGZ7qi8wPR9jUj/YATP0ShgqNn+aX93evM=;
        b=GP6WZBdqsVT4wJOW/ZDyDaoT56iNI6sszPZGREKgk7qo8LDMHJ/VLN/3INvlU6dn/k
         PdsENe0Yo8vTrWLN7RniS7rC5oNvJPsPtjI/WOJPbop9ueY74QdxjFI73WgSwjlJOAHJ
         FOaKTBu5uOCHE/uDem0HAWF5hJAkmhSKmp1oSEGZtb0eiRvAnMe/bvVMFy5CqSA6McI2
         /KYX/X4irWzg1QOLCKu/P6qeeVK0BoPtcov5uiMb+XPVFH4I5W/pg80LhWMgvL8Cp22D
         NR6TZaQXc5uy+0bYMUjrNrdwDh9I4avJjBoA0Zeklvg/4DQZjsXL+WnGRKXShMix4DBJ
         Xx9g==
X-Gm-Message-State: AOAM530UHzuDuSYEnZF3PVZz2mKU4bQM8znspj/xGlZg7WTQ11CkHV4S
        ZXocpMFF+Hn298+J3ORTFufd5ipc0QqEMG3i
X-Google-Smtp-Source: ABdhPJyoqyPpLRGmUqJ99zCdGyQZ5fRR9S8kIiS1qUZ88j/qtHWZix7oNIwsROFZpMwrJ9r9bHEc3A==
X-Received: by 2002:a37:4d58:: with SMTP id a85mr24628082qkb.324.1607349496620;
        Mon, 07 Dec 2020 05:58:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 70sm1487879qkk.10.2020.12.07.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 15/52] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Mon,  7 Dec 2020 08:57:07 -0500
Message-Id: <ca88279682628ac78511f5b94d7a5a093e5024b2.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will record the fs root or the reloc root in the trans in
select_reloc_root.  These will actually return errors in the following
patches, so check their return value here and return it up the stack.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 05b80b9ab1e1..a3ad44605695 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1990,6 +1990,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2025,11 +2026,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
-			record_reloc_root_in_trans(trans, root);
+			ret = record_reloc_root_in_trans(trans, root);
+			if (ret)
+				return ERR_PTR(ret);
 			break;
 		}
 
-		btrfs_record_root_in_trans(trans, root);
+		ret = btrfs_record_root_in_trans(trans, root);
+		if (ret)
+			return ERR_PTR(ret);
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-- 
2.26.2

