Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E52CDD91
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502088AbgLCSZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502052AbgLCSZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:26 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E6C061A55
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:32 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r6so2069050qtm.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9W27EU5c/W9JoMK7FbTrJDDA2siIbBOwfExuF0aKAto=;
        b=TRtMv6A2xVHUTkdCnonnCKTpKpai9d8GdPM1yQqhgDUGTc1gPJ1HumyujXOK8erUND
         SQ76gBhfXTiRVkF/J5jO10BtFACKCrb2lCaYBaldohuZaDAuW5zG7K+ovg5ZGbJtwOt3
         xJ6aG+vB8VkpxYepeOT+477iwNTnhBN/jUL3lOBlneGNmiX5gj302+CzyAkS+9yIxlE5
         0biPEhNgybu+t5Vl1AgrHxDp8J/vkOm+skopGcgopZf3GqMAXUeCTbOeygfOPl19ONLY
         TSVIk5iVeBLo+Nn+5LicOGrdMWn9C8i0jIxGPqgl8CKqD7i948v3QPuyU1Wlk27imP8q
         D61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9W27EU5c/W9JoMK7FbTrJDDA2siIbBOwfExuF0aKAto=;
        b=qNzZC75iEF2VilRwxGH2tFufZNGNoqQXws3v6D2huMvmd4VzRQB0AJPf0T/m/kv7K3
         howKtubC5WQQyysEIz/aYDVZTEf0XPl+otfTxxNUoIfdy0XdCgG9IOtfZ0AseRNfsDMI
         1Z3u+ebo49NyOBwW3M5hPWimwu5wyLDJP6zPCpjs0J1qa85ReGMNxpAui/6k/8WKayyt
         w2HidJO8kJ2fWhGJySR/cD7QYC9RUjKAvkQZbXUrrHujLkYdZRz43K0s6zCiRVcA7EQn
         vfbZE0TMDJTzqYZvVG0shJfDsnllvNVAUbUt+lwqdERlvNutgxuVTasEJFj6DZZalkWN
         /Bvg==
X-Gm-Message-State: AOAM533E9Yyku/5UgY/4+lzCECCNgQDu+R1AxmNHqUDiDT9Yir5J2mq0
        gE0NfFHTjQI87oOmnLCZdnj1McXHr27YIU7H
X-Google-Smtp-Source: ABdhPJwETq2b37d5CozQwlxoux4RQQfbu/yMx2xJkuQaQ6yrs+DU2k6oWxuwZI0RL8iSmXzBT3sDUg==
X-Received: by 2002:ac8:787:: with SMTP id l7mr4540911qth.137.1607019871732;
        Thu, 03 Dec 2020 10:24:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a85sm2238928qkg.3.2020.12.03.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 52/53] btrfs: fix reloc root leak with 0 ref reloc roots on recovery
Date:   Thu,  3 Dec 2020 13:22:58 -0500
Message-Id: <ff8b458f78b382790ac48a668d141d07d3a61a08.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
index 38002f47e962..01b7b35be3f3 100644
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

