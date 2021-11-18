Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470C5455F70
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhKRP3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 10:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhKRP3U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 10:29:20 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5711FC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 07:26:20 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 8so6388102qtx.5
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lEbx4DeltFgyrn3Lhvo0QuW9YTuUmnld5yNKG2uTCCc=;
        b=27yLSKGhiX7BIg1q/lgdKAqSrzXVYcY6dcGpf/5Kt+x/X6P+8mEMdnjzY9tOpVkJhO
         7+geISywK8Jr3ju1eJKWyL9FPw3T8iPtrJ4RY0ykBSpxVpZmgqcUVFKqlZBZuQ9iCzmN
         E2V5ZPCeNUzifaUKCzDt66JCZNFbHFa9ADmBEhITSPpljbGIdYKitmiuYnenQYHocAsK
         H8QXX5VBvQdI8skcSzD8XMLP1wbALNYDI5lL0EPuX2S4/6Cu5a2fQByhV8AFg2sWaYmR
         ERA9mc9L3CGi8gDuM5qE2JyzhU1Q7if+arhgnodF6P2Hm/Tn2zmmD0TEsCnBRx8ZPEu9
         5zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lEbx4DeltFgyrn3Lhvo0QuW9YTuUmnld5yNKG2uTCCc=;
        b=5Mm4SA2ko8uFx7IKqY/I2imLqQpr/L8CXGl6o6RpEH3W9lG5buXwvG1ldUcoErgSfa
         v/vFvR2ydlUNMOE1XWsShgAsfbhLr1itOu59uy9J8T+rRLTqVlH5af/aS7uMAeM67oXo
         JI0KamV/OQPkjv1j9u5cNZMtSZrANc568cfvlWZAZ689lxO8NbdEmW39zuokg7o0HvEe
         xt8v+QSOwHQEEnBPtTC7IV95c0NZQ2txsfT2AQ67IGBEO3lOUObv1sDFfdqeYeXH+ix3
         2+Gh954EyxTmVt0SSS5li9HEanmpIRUtYeQL6hUVYit91FPvpeeR3e7HZOMRtnl+gi8x
         dreg==
X-Gm-Message-State: AOAM532FEexpvUbhnOBwZN1Fp2SadDRksKkiEpUf4PDXXvMMtpszWIR6
        Ps3Uzx37alK4vyYwC9z6ZPFTGhLbOsuunw==
X-Google-Smtp-Source: ABdhPJzi7hhOubr4sQKmBQmogd/FYUZEwHMcjzAtE8sMaO+VMi+y1TPC4UsNwawKzY0FvyOQSVsV2A==
X-Received: by 2002:a05:622a:3ca:: with SMTP id k10mr26557354qtx.198.1637249179148;
        Thu, 18 Nov 2021 07:26:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o126sm91601qke.11.2021.11.18.07.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 07:26:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 1/2] btrfs: only use ->max_extent_size if it is set in the bitmap
Date:   Thu, 18 Nov 2021 10:26:15 -0500
Message-Id: <6f41496c1404e6b4b61bbe86fc81b883a25d36a6.1637248994.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637248994.git.josef@toxicpanda.com>
References: <cover.1637248994.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While adding self tests for my space index change I was hitting a
problem where the space indexed tree wasn't returning the expected
->max_extent_size.  This is because we will skip searching any entry
that doesn't have ->bytes >= the amount of bytes we want.  However we'll
still set the max_extent_size based on that entry.  The problem is if we
don't search the bitmap we won't have ->max_extent_size set properly, so
we can't really trust it.

This doesn't really result in a problem per-se, it can just result in us
not finding contiguous area that may exist.  Fix the max_extent_size
helper to return ->bytes if ->max_extent_size isn't set, and add a big
comment explaining why we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f3fee88c8ee0..543394acec44 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1870,9 +1870,33 @@ static int search_bitmap(struct btrfs_free_space_ctl *ctl,
 	return -1;
 }
 
+/*
+ * This is a little subtle.  We *only* have ->max_extent_size set if we actually
+ * searched through the bitmap and figured out the largest ->max_extent_size,
+ * otherwise it's 0.  In the case that it's 0 we don't want to tell the
+ * allocator the wrong thing, we want to use the actual real max_extent_size
+ * we've found already if it's larger, or we want to use ->bytes.
+ *
+ * This matters because find_free_space() will skip entries who's ->bytes is
+ * less than the required bytes.  So if we didn't search down this bitmap, we
+ * may pick some previous entry that has a smaller ->max_extent_size than we
+ * have.  For example, assume we have two entries, one that has
+ * ->max_extent_size set to 4k and ->bytes set to 1M.  A second entry hasn't set
+ * ->max_extent_size yet, has ->bytes set to 8k and it's contiguous.  We will
+ *  call into find_free_space(), and return with max_extent_size == 4k, because
+ *  that first bitmap entry had ->max_extent_size set, but the second one did
+ *  not.  If instead we returned 8k we'd come in searching for 8k, and find the
+ *  8k contiguous range.
+ *
+ *  Consider the other case, we have 2 8k chunks in that second entry and still
+ *  don't have ->max_extent_size set.  We'll return 16k, and the next time the
+ *  allocator comes in it'll fully search our second bitmap, and this time it'll
+ *  get an uptodate value of 8k as the maximum chunk size.  Then we'll get the
+ *  right allocation the next loop through.
+ */
 static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
 {
-	if (entry->bitmap)
+	if (entry->bitmap && entry->max_extent_size)
 		return entry->max_extent_size;
 	return entry->bytes;
 }
-- 
2.26.3

