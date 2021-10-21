Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657AB436AF7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhJUTBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhJUTA7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 15:00:59 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1532C0613B9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 77so2413162qkh.6
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NfirQ2rk3PuvkTMJycjhT2x77oa+NiJXwW4evvFHpqs=;
        b=s4N9DuSkq8bo4UN5n7Ym1Mk05k/IKCL/oFDKfP+P0hdUFJseS8jXr9WkyCq2LvJFsg
         6nnX4LtXSvSKGItMAahnYQtO8DEQWmh0snwxVFCljubdNrj/GsPgyaYM6wJOIOFqhLhq
         qOA4gx+RsmyqdqSMortS5n1VHukOxs4p5ZSiBZEJ10rCAV7Zk1LScUELh+KNUqia9OiK
         FdrmhwXNVJFms/bqwXxtw2fRJzwF1JaiOyIKGBtvK7lz0JodXUXmRtTOBZlQpuit3Z39
         Jc444qzXnYva5yHIBnIcuLFf9ds6CE/HxngtMicHWXhwv1lBppn4h9rXLLhew9p9xZ3h
         eS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfirQ2rk3PuvkTMJycjhT2x77oa+NiJXwW4evvFHpqs=;
        b=BJskZyh8reK9rOa8oRS+2ZJ5CQ5XQkuwMLi+ydKobOMbkls8MaDxqaZNGwy0/Gl9te
         VyZrq0HpugC3auCMbMUFw2JQJU8woSloEop4xOxYSISF9waoigYa5j87SXHmR8ws0Fie
         dLlptrqdSh7XEkL9x75zuhM5kXLMnDhwQV7adKeNnWRookGYjiTkHZlIPRQkMPrI3Hpt
         MbI6zVSgZ1HWs2NOac3HdIQj5LWiPcjhIcilGJaXJbiyyqJbkGvcMIZReafd89GMgkrD
         2rzmSa9TF5FpTszs/UcC+WHjEwhFQcU9lWTcvDOMks+FkDg4YzTMmHAUgaUeZAQ3ejIy
         6HRQ==
X-Gm-Message-State: AOAM531N4UOEeJKlxN/OyTotdIMePATWA/oFaPTv8v8gsvh9A3DGgUoR
        1pCKGXO9T7bldr4/4yiuKbGT7GCRPAkEAw==
X-Google-Smtp-Source: ABdhPJyMrjmxI/+DkaF+LQMj+IYEPAduypR8A992VldlwRT+Is5eM+P3WURtFX4sA961br+ioWCx8w==
X-Received: by 2002:ae9:dcc7:: with SMTP id q190mr6149372qkf.194.1634842721584;
        Thu, 21 Oct 2021 11:58:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bk7sm3029745qkb.72.2021.10.21.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:58:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/7] btrfs: add btrfs_set_item_*_nr() helpers
Date:   Thu, 21 Oct 2021 14:58:32 -0400
Message-Id: <cd6d369cecab84630b68319940346b401237181e.1634842475.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have the pattern of

item = btrfs_item_nr(slot);
btrfs_set_item_*(leaf, item);

in a bunch of places in our code.  Fix this by adding
btrfs_set_item_*_nr() helpers which will do the appropriate work, and
replace those calls with

btrfs_set_item_*_nr(leaf, slot);

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 24 +++++++++---------------
 fs/btrfs/ctree.h | 12 ++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ec8b1266fd92..6f89dbc2cb31 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3479,9 +3479,7 @@ static noinline int split_item(struct btrfs_path *path,
 			       unsigned long split_offset)
 {
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
-	struct btrfs_item *new_item;
-	int slot;
+	int orig_slot, slot;
 	char *buf;
 	u32 nritems;
 	u32 item_size;
@@ -3491,7 +3489,7 @@ static noinline int split_item(struct btrfs_path *path,
 	leaf = path->nodes[0];
 	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
 
-	item = btrfs_item_nr(path->slots[0]);
+	orig_slot = path->slots[0];
 	orig_offset = btrfs_item_offset_nr(leaf, path->slots[0]);
 	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
 
@@ -3514,14 +3512,12 @@ static noinline int split_item(struct btrfs_path *path,
 	btrfs_cpu_key_to_disk(&disk_key, new_key);
 	btrfs_set_item_key(leaf, &disk_key, slot);
 
-	new_item = btrfs_item_nr(slot);
-
-	btrfs_set_item_offset(leaf, new_item, orig_offset);
-	btrfs_set_item_size(leaf, new_item, item_size - split_offset);
+	btrfs_set_item_offset_nr(leaf, slot, orig_offset);
+	btrfs_set_item_size_nr(leaf, slot, item_size - split_offset);
 
-	btrfs_set_item_offset(leaf, item,
-			      orig_offset + item_size - split_offset);
-	btrfs_set_item_size(leaf, item, split_offset);
+	btrfs_set_item_offset_nr(leaf, orig_slot,
+				 orig_offset + item_size - split_offset);
+	btrfs_set_item_size_nr(leaf, orig_slot, split_offset);
 
 	btrfs_set_header_nritems(leaf, nritems + 1);
 
@@ -3661,8 +3657,7 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 			fixup_low_keys(path, &disk_key, 1);
 	}
 
-	item = btrfs_item_nr(slot);
-	btrfs_set_item_size(leaf, item, new_size);
+	btrfs_set_item_size_nr(leaf, slot, new_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
@@ -3726,8 +3721,7 @@ void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 
 	data_end = old_data;
 	old_size = btrfs_item_size_nr(leaf, slot);
-	item = btrfs_item_nr(slot);
-	btrfs_set_item_size(leaf, item, old_size + data_size);
+	btrfs_set_item_size_nr(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(leaf);
 
 	if (btrfs_leaf_free_space(leaf) < 0) {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 140126898577..69c04636e605 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1990,6 +1990,18 @@ static inline u32 btrfs_item_size_nr(const struct extent_buffer *eb, int nr)
 	return btrfs_item_size(eb, btrfs_item_nr(nr));
 }
 
+static inline void btrfs_set_item_size_nr(struct extent_buffer *eb, int nr,
+					  u32 val)
+{
+	btrfs_set_item_size(eb, btrfs_item_nr(nr), val);
+}
+
+static inline void btrfs_set_item_offset_nr(struct extent_buffer *eb, int nr,
+					    u32 val)
+{
+	btrfs_set_item_offset(eb, btrfs_item_nr(nr), val);
+}
+
 static inline void btrfs_item_key(const struct extent_buffer *eb,
 			   struct btrfs_disk_key *disk_key, int nr)
 {
-- 
2.26.3

