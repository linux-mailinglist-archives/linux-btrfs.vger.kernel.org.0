Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF162B2051
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKMQYq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgKMQYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:45 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1927C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:45 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b16so6803537qtb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Dt8e4mYaMgFtEhSgYgpB3WOAgQoEmIMxZPdL6YFdRzU=;
        b=ZzmsrjHkskv09fzsbKDqzaI3X6f5wi0CCPfKnGNM27eq9pVpdIVD934v4e07oINq0O
         UqcWYrJ7qc9Ky4Fj/N7NGcL7267bHTgOhsBB23fT9u3O7vNslCIAl8t4N6PJxocY8PHg
         BNcCLjCDLSHaEvUMH3F3jxlervj8Oqg7tr+mazQjirrvGUcNtzPuKiW2svoFJvwdUhvJ
         g/5YYtlWlkw8xwSUhh4tKXOZKR9h3VsdbSB5uJPEe7p05vzJdZZ+EeZlEPWXtWXuM3iX
         FWIQScyoWbWUjW7Vc7GLp9JkbV/K3tS9WPzykVYIU4pOlgUpt/i5y/aAOiKrHc9B/Gc1
         pFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dt8e4mYaMgFtEhSgYgpB3WOAgQoEmIMxZPdL6YFdRzU=;
        b=UeipQ2HqcqgxDoIfICtpFKnqFG/Lt7Hzvz6s92+RzEZSlWSduDO9Kv1HfZ6G3Blrvr
         fFrYzwSQ5Z6pd1sjGan9huFbl4Pm8O5DowXBmkdUa7aIKU9V66pitnKHdmMro/Nmlvkt
         o2j34mJ1fnvRqZPDNOOHu31v9+ZG7AuA9WHqO2ROuvlRg0sWkMw37Xy3Wp9P12u5rJcl
         jjSgPJdiDpivLEDO9ds2+nmP8QP1DNj8jMGjL+QZFoDRYeh+5+ps3HyPuExvRRGdvI4s
         TLD5WLexQU0ZaM1x6s6I/y3jy6xx1kWi8jLkYom+/S6oIzZGuWr3rOUC8G6yxHt+s0o5
         BLkQ==
X-Gm-Message-State: AOAM5306QcCj4d/qGc3V7DurIMKBmZkQg4z1aWNPx/A64EBHq53Puk8E
        +iTtee8yKjW40aIW7yPbYFicis4N19PFQg==
X-Google-Smtp-Source: ABdhPJz/PoXbuqOBKiSZwHhAuyXojfJtB7Ce8JlLRFcEmveoQxkDHmeydl5EHVkZhfoxhnSOC0SWEg==
X-Received: by 2002:aed:3264:: with SMTP id y91mr2645913qtd.308.1605284679400;
        Fri, 13 Nov 2020 08:24:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm2454774qkj.61.2020.11.13.08.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 35/42] btrfs: remove the extent item sanity checks in relocate_block_group
Date:   Fri, 13 Nov 2020 11:23:25 -0500
Message-Id: <dc84ac988e7d6e74065c0b5778464f85db39adc8.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These checks are all taken care of for us by the tree checker code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bc63c4bb4057..8a9c946302cd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3337,20 +3337,6 @@ static void unset_reloc_control(struct reloc_control *rc)
 	mutex_unlock(&fs_info->reloc_mutex);
 }
 
-static int check_extent_flags(u64 flags)
-{
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if (!(flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    !(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-		return 1;
-	return 0;
-}
-
 static noinline_for_stack
 int prepare_to_relocate(struct reloc_control *rc)
 {
@@ -3402,7 +3388,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	u32 item_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -3451,19 +3436,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_extent_item);
-		item_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
-		if (item_size >= sizeof(*ei)) {
-			flags = btrfs_extent_flags(path->nodes[0], ei);
-			ret = check_extent_flags(flags);
-			BUG_ON(ret);
-		} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-			err = -EINVAL;
-			btrfs_print_v0_err(trans->fs_info);
-			btrfs_abort_transaction(trans, err);
-			break;
-		} else {
-			BUG();
-		}
+		flags = btrfs_extent_flags(path->nodes[0], ei);
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
-- 
2.26.2

