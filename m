Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E876D2D2F9C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgLHQ0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHQ0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA41C0611CD
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:56 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id c7so8157925qke.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xDWc0fpV3efm1xVsQoYUGj3PoMHicnjEzg/gWc5cKb8=;
        b=CBbE5pY9qhdk0lUB+Bm04YU9PDNg2/zCpuPmzHtWL3YGaYN0A60Xd341QvU9jtIHry
         BbKtjN5wvRUkVYq9WzpUT6b48DoA2111S9TmxC7hVutx4X7JGACtxagk5yi4clL7Gig4
         jAwTmkFCTGCdzQ3qnRLfC6xFZ3D8Cwp7VVVwnFAZrcI6KY1JlwF5Ok66fMUJKYeI53a0
         eYymBVcNfuadTkj5zYoBzlbZ5QEPUyOkJhMC8uUgejAS2leuhKz6OHXBUyzLq/1bceik
         iEus518YIOVxlrW9q11YarqVQ7nKua1VkmsDa+gI8Zf2oqMqwQjktEY6E+4Oni0murWg
         OFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDWc0fpV3efm1xVsQoYUGj3PoMHicnjEzg/gWc5cKb8=;
        b=Ko97nZ+BGGRCIl10PJDHiJcaL7Fs1qOoNBpoDoMEpkFZosh+o2BQeLR2cLWrY5HU8Q
         xdN3O+h7EAbTQlvNsX3tF9zIC1OAmci8+/vQUcNp7iJvxNbNzDwQuZgjySu7vk89Wv3y
         EN3AD/giAzJ2iGVw/o7xf5SnLh65rr2oSFkIMXAcR8cMX1URQFMtEKUF2jkR0JB90f7d
         JmPKL6+BGIV2g3OqfBQLsgr2c3QlTVKZILekITRxR57wki1EaB6e5DdlZU9+BbK1kHvY
         35Sv8Tg4Uwi5KX2alfHliVzurz3VRzGUet6pnHa2G/ohD7oqIwk+3U9yLXksRI7LgGCV
         DcJQ==
X-Gm-Message-State: AOAM5329F69GR4FZOkSaRa3Omhy0ya0f/pdkX/pvCj1K2bAiufONyByq
        7oJTjHMtosErze7aEXPHD3Vq7hRzQhvqPaPH
X-Google-Smtp-Source: ABdhPJxcoBchCx6ZGRiGJD8OT0r3xJtuxXSwJIXPHsFZ9KkpdzzRlzGe1rag6EXaTChLVSb4bT1dMg==
X-Received: by 2002:a37:b642:: with SMTP id g63mr30898085qkf.297.1607444755554;
        Tue, 08 Dec 2020 08:25:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l20sm1273808qtu.25.2020.12.08.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 51/52] btrfs: fix reloc root leak with 0 ref reloc roots on recovery
Date:   Tue,  8 Dec 2020 11:23:58 -0500
Message-Id: <171de0b5ee4bc8aabf463fc0ed759da0559e3781.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When recovering a relocation, if we run into a reloc root that has 0
refs we simply add it to the reloc_control->reloc_roots list, and then
clean it up later.  The problem with this is __del_reloc_root() doesn't
do anything if the root isn't in the radix tree, which in this case it
won't be because we never call __add_reloc_root() on the reloc_root.

This exit condition simply isn't correct really.  During normal
operation we can remove ourselves from the rb tree and then we're meant
to clean up later at merge_reloc_roots() time, and this happens
correctly.  During recovery we're depending on free_reloc_roots() to
drop our references, but we're short-circuiting.

Fix this by continuing to check if we're on the list and dropping
ourselves from the reloc_control root list and dropping our reference
appropriately.  Change the corresponding BUG_ON() to an ASSERT() that
does the correct thing if we aren't in the rb tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3ecb09c5d65f..9f16e9932595 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -671,9 +671,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 			RB_CLEAR_NODE(&node->rb_node);
 		}
 		spin_unlock(&rc->reloc_root_tree.lock);
-		if (!node)
-			return;
-		BUG_ON((struct btrfs_root *)node->data != root);
+		ASSERT(!node || (struct btrfs_root *)node->data == root);
 	}
 
 	/*
-- 
2.26.2

