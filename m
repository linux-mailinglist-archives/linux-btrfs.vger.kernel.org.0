Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E2391064
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 08:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhEZGLx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 02:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhEZGLu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 02:11:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE8C061574;
        Tue, 25 May 2021 23:10:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m190so70275pga.2;
        Tue, 25 May 2021 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HmLaQWhJqHPnSlCjFaBhRZNGbkeDs33ImoQZxW9wzeI=;
        b=f13p3RacrOUXkixVzVVDKsVIpgyYT7GjO5EOC1i2OQs05H93f/FyTiAA1uIaUbAsUZ
         Mi1zCJuDwmMPabWAzIsmDzexxLSIwppdPBkTSMxOx1tTiKHGYIPKtY5vP8qpU033jGV1
         3oecxyUa65cQWMn9qMj2sx0QYUrEENcymvoijYSNmCZBsxwqHZ6Yj3DoQI7fI7TLQ4S5
         o+VqYvVfriycWzsk+IfMqXojGW9+WwYH85Rd2Hz4G0p+UbaWuazyZvmlsv+kKsN4NtY8
         naXHr3nWrqtGirW2x89EfnHiU2CMrVQNwlPv907LHgpRUW6jkRP6dHvyBDBmi8xPhT6w
         nwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HmLaQWhJqHPnSlCjFaBhRZNGbkeDs33ImoQZxW9wzeI=;
        b=Sjg4YE0J7BadlqN2cQziBS9sTeaWTE8x7kyKEnqJyZGlliYzoyWYIBbqgpPxyMYOP3
         rA86J+SWSGTSw6GI4gYL6mjALobWR8senaMTf2TGl2Es0bvWkZGJPeQIM9gnJtqdT/OV
         S2yBFeUJ3kBb0CJzLUm9oeAwZHFUiIFQ5jqkvPF1ffcfWGo0ZBqg7lo/nk0b0HPJZ81T
         soZtAH10uIhrelJeUz4goUZ2A0VAQ9W8Z8XoO53prFis+DjzgJ5EWDdb2Zrl4kAADG9B
         iBdp0tk02B4HK+lOeEfBHCZglep1VZWFoAhR1WVO4l7ZSdULbvLvonsmVgtTzF+rq2+O
         j1Zg==
X-Gm-Message-State: AOAM530CBPTdGZbQxIkmqKD5Q5SdQI4GwY9Z3Ipo2p9s5mOMFSieUsy/
        yELQgNOI/SMCtbIj8KuQo8w=
X-Google-Smtp-Source: ABdhPJxcwNyvk3IMg+GkkWYAS8xI5m93Fg+lGgyk+kIG++wRKFDqhZHyaTdPTfw8dUvJ/NsTWb43Tw==
X-Received: by 2002:a05:6a00:813:b029:27f:fb6a:24b5 with SMTP id m19-20020a056a000813b029027ffb6a24b5mr29908326pfk.18.1622009418804;
        Tue, 25 May 2021 23:10:18 -0700 (PDT)
Received: from localhost (natp-s01-129-78-56-229.gw.usyd.edu.au. [129.78.56.229])
        by smtp.gmail.com with ESMTPSA id 185sm15499572pfb.184.2021.05.25.23.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 23:10:17 -0700 (PDT)
From:   Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     Baptiste Lepers <baptiste.lepers@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: relocation: fix misplaced barrier in reloc_root_is_dead
Date:   Wed, 26 May 2021 16:09:47 +1000
Message-Id: <20210526060947.26159-1-baptiste.lepers@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix a misplaced barrier in reloc_root_is_dead. The
BTRFS_ROOT_DEAD_RELOC_TREE bit should be checked before accessing
reloc_root.

The fix forces the order documented in the original commit:
"In the cross section C-D, either caller gets the DEAD bit set, avoiding
access reloc_root no matter if it's safe or not.  Or caller get the DEAD
bit cleared, then access reloc_root, which is already NULL, nothing will
be wrong."

static bool reloc_root_is_dead()
    smp_rmb(); <--- misplaced
    if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
          return true;
    return false;
}

static bool have_reloc_root(struct btrfs_root *root)
{
       if (reloc_root_is_dead(root))
               return false;
       <--- the barrier should happen here
       if (!root->reloc_root)
               return false;
       return true;
}

Fixes: 6282675e6708e ("btrfs: relocation: fix reloc_root lifespan and access")
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
---
 fs/btrfs/relocation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b70be2ac2e9e..8cddcce56bf4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -289,15 +289,14 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 
 static bool reloc_root_is_dead(struct btrfs_root *root)
 {
+	bool is_dead = test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 	/*
 	 * Pair with set_bit/clear_bit in clean_dirty_subvols and
 	 * btrfs_update_reloc_root. We need to see the updated bit before
 	 * trying to access reloc_root
 	 */
 	smp_rmb();
-	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
-		return true;
-	return false;
+	return is_dead;
 }
 
 /*
-- 
2.17.1

