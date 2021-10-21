Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2DA436AFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJUTBG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhJUTBF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:01:05 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F97C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w2so1474522qtn.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6KjWRNERPtJK+Bm+rbONsAA4rTwhaz6Z4hgA8EjzlXs=;
        b=OG0FXVgyE8o/gfzOIO2ITiOJ2H+2GExn5+j+9oQTS9Jw+Omb+EerwOqe6akV3eJ/I4
         y7e/sNYiVadUZfWIpJfM+NrldNS8hgsxGgwwuvuWwFlnYsZjxW1zg/UojUwaCw9GWJLF
         sfbxKrZKQ/wwhkgSS+RE1jviKbNwY/LvIYrkz6wtnCmOrfYOLutykzPpm9IaKglbiOk8
         2y2JeIx6dRD9tObfKP3Wvyfq/sM5ZhMCiOrEiEsZCAm4hn6AWGX8D+p5YtzxfvWbK+ui
         U2OUxFNa7huwQ0SYWcJBAx/Pgk4hq1zIYax6Bby+lLYLoBS1i18oZs076LcuWCIZypIg
         xN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KjWRNERPtJK+Bm+rbONsAA4rTwhaz6Z4hgA8EjzlXs=;
        b=BgM69sYY6hykhCbkcoGamMNXmiAWaswmDOU+uQwTdaMi2/8eMN5xFXdOHfI4hJDEx3
         s4uamZSRhh0/xRMTJSw+C5MskVYXECf3Arr9GpYJkyPG6VSaly/gtavSYdaSgOByGNHp
         zl0wZFfpjXHTaI8gFXF0lfzaq446NRKBuQZnn12a9PjzaXSI9m0U+xsqi5pBosf1q7q1
         HQkK+igzmBSRmRF6Vf7qoOk7KBBfuityX/NVJXzJYnbkJ5Z7luH2cYqVnVQ4ZQAvQtDl
         lCGEw3YH3KcUzi/y/Kh37jGKkN/JU9q+/5QoB+FmA7p74XCxbKUf+XDCpm01uXJuVPak
         zojQ==
X-Gm-Message-State: AOAM532zeQSA4i5r8f2gs7m1oFXMVLeQ8E6cOe9JpQuWhTBe3oiwH0Cx
        Jbmfxa4FwmJkraIXUVoh/QbSp3tiFUVEUg==
X-Google-Smtp-Source: ABdhPJxLthQ2HvjKdq/Z5mhF/Sw3+aq4y4wfim2P1VcOW+NV5YLBD2NU9uZbEi+krSfFh8Kg5u56rQ==
X-Received: by 2002:ac8:4159:: with SMTP id e25mr8003031qtm.69.1634842728173;
        Thu, 21 Oct 2021 11:58:48 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d6sm2875806qkj.11.2021.10.21.11.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/7] btrfs: rename btrfs_item_end_nr to btrfs_item_data_end
Date:   Thu, 21 Oct 2021 14:58:37 -0400
Message-Id: <91c74fd16de52d27a379f51d602d1b20fa8dd952.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The name btrfs_item_end_nr() is a bit of a misnomer, as it's actually
the offset of the end of the data the item points to.  In fact all of
the helpers that we use btrfs_item_end_nr() use data in their name, like
BTRFS_LEAF_DATA_SIZE() and leaf_data().  Rename to btrfs_item_data_end()
to make it clear what this helper is giving us.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c        | 10 +++++-----
 fs/btrfs/ctree.h        |  2 +-
 fs/btrfs/tree-checker.c |  8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index b2b12d80ab86..bba7a1d43140 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2719,7 +2719,7 @@ static noinline int __push_leaf_right(struct btrfs_path *path,
 	/* push left to right */
 	right_nritems = btrfs_header_nritems(right);
 
-	push_space = btrfs_item_end_nr(left, left_nritems - push_items);
+	push_space = btrfs_item_data_end(left, left_nritems - push_items);
 	push_space -= leaf_data_end(left);
 
 	/* make room in the right data area */
@@ -3119,7 +3119,7 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 
 	nritems = nritems - mid;
 	btrfs_set_header_nritems(right, nritems);
-	data_copy_size = btrfs_item_end_nr(l, mid) - leaf_data_end(l);
+	data_copy_size = btrfs_item_data_end(l, mid) - leaf_data_end(l);
 
 	copy_extent_buffer(right, l, btrfs_item_nr_offset(0),
 			   btrfs_item_nr_offset(mid),
@@ -3130,7 +3130,7 @@ static noinline void copy_for_split(struct btrfs_trans_handle *trans,
 		     data_copy_size, BTRFS_LEAF_DATA_OFFSET +
 		     leaf_data_end(l), data_copy_size);
 
-	rt_data_off = BTRFS_LEAF_DATA_SIZE(fs_info) - btrfs_item_end_nr(l, mid);
+	rt_data_off = BTRFS_LEAF_DATA_SIZE(fs_info) - btrfs_item_data_end(l, mid);
 
 	btrfs_init_map_token(&token, right);
 	for (i = 0; i < nritems; i++) {
@@ -3682,7 +3682,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 		BUG();
 	}
 	slot = path->slots[0];
-	old_data = btrfs_item_end_nr(leaf, slot);
+	old_data = btrfs_item_data_end(leaf, slot);
 
 	BUG_ON(slot < 0);
 	if (slot >= nritems) {
@@ -3769,7 +3769,7 @@ static void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *p
 
 	btrfs_init_map_token(&token, leaf);
 	if (slot != nritems) {
-		unsigned int old_data = btrfs_item_end_nr(leaf, slot);
+		unsigned int old_data = btrfs_item_data_end(leaf, slot);
 
 		if (old_data < data_end) {
 			btrfs_print_leaf(leaf);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8c75224df83b..53571c6f35cb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1996,7 +1996,7 @@ static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,
 BTRFS_ITEM_SETGET_FUNCS(offset)
 BTRFS_ITEM_SETGET_FUNCS(size);
 
-static inline u32 btrfs_item_end_nr(const struct extent_buffer *eb, int nr)
+static inline u32 btrfs_item_data_end(const struct extent_buffer *eb, int nr)
 {
 	return btrfs_item_offset(eb, nr) + btrfs_item_size(eb, nr);
 }
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 09512d79e687..72e1c942197d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1691,10 +1691,10 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		else
 			item_end_expected = btrfs_item_offset(leaf,
 								 slot - 1);
-		if (unlikely(btrfs_item_end_nr(leaf, slot) != item_end_expected)) {
+		if (unlikely(btrfs_item_data_end(leaf, slot) != item_end_expected)) {
 			generic_err(leaf, slot,
 				"unexpected item end, have %u expect %u",
-				btrfs_item_end_nr(leaf, slot),
+				btrfs_item_data_end(leaf, slot),
 				item_end_expected);
 			return -EUCLEAN;
 		}
@@ -1704,11 +1704,11 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		 * just in case all the items are consistent to each other, but
 		 * all point outside of the leaf.
 		 */
-		if (unlikely(btrfs_item_end_nr(leaf, slot) >
+		if (unlikely(btrfs_item_data_end(leaf, slot) >
 			     BTRFS_LEAF_DATA_SIZE(fs_info))) {
 			generic_err(leaf, slot,
 			"slot end outside of leaf, have %u expect range [0, %u]",
-				btrfs_item_end_nr(leaf, slot),
+				btrfs_item_data_end(leaf, slot),
 				BTRFS_LEAF_DATA_SIZE(fs_info));
 			return -EUCLEAN;
 		}
-- 
2.26.3

