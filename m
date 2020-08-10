Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD1240AA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHJPm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgHJPm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:42:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38097C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n129so3059044qkd.6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k29rfO9jImGMkQYEDetd52uDVjlEqbnDITP48bTNKus=;
        b=bY6GU4hJZ5Tj8duY47Q8wrjaeEPdEaRnV8pP14M7IrutABnoWVTzlosJIA2GUfEpqp
         q35KF8ZEBBGzW/UyIuN9uhzRnYMGsGlt7srkY+W4HCC/WapLQYboCeN61pqWD2unuJD4
         okIJi693dY65Cvi8+UL6+haqQYZXPFGaezSYqw76GzhePWZm8GEPoswPD0/bYXUubUdO
         ZVj+DwuyAY8DSEK2agd7+bi6ddw6NFOHigXEa6ZuV6tl8Rel8PhZtcGTx0VFVJBSZ3Kt
         J+V6O0OYVAgL6NNzQh9l4ze4r6YO8/nEeVMJTkvF+oNLmk2s1FBZpnZbFAal1mWTpS+v
         mCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k29rfO9jImGMkQYEDetd52uDVjlEqbnDITP48bTNKus=;
        b=LYlASo7oUobl99df9nEdULOleB6EJfQ/4N/viLX9nVNLJVszBeKregyV62QiI80xSg
         6Kph6dewpcUyB7pYwMz3wTmUy2E9k3GRpCC/2NFYJbCjOKlP4JDQokxn17ypXrgLS/rQ
         9GCH321Ztf+lexZoXi1jsxNqEEiDYtHm5/EFR8fL+jq89gfBOn3nje2IUi2tUWbyUC73
         Z1j3ESJRiiA9udlzKmmLD4WXnI5cQ/nfK+rW2wD44id59nQ27B9roj9eiAB6dSADgMS9
         NLX8x2CJ3dQ4a0vE6oM70adT4bHKhnGkoN27UWSqMuEXI2Qn9eBuRn/N1jcJz27aYXCQ
         4xhA==
X-Gm-Message-State: AOAM533AyH1CwYipTweGa6iUPs1YMDqbLghmt27ZWM8I4W6wJjoF1235
        yHGG6lWr1ESSUNENSZqALiC1c+uQAvJp6w==
X-Google-Smtp-Source: ABdhPJyTbS5uf/YRwViRUgcOg5gl8XsnO9MlJoz9sdYi7J+leqFP6y9+OQCuMJ5IzgSx01Tqtyy1tw==
X-Received: by 2002:a05:620a:1285:: with SMTP id w5mr25590676qki.21.1597074177147;
        Mon, 10 Aug 2020 08:42:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 20sm15848317qtp.53.2020.08.10.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:42:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/17] btrfs: set the lockdep class for log tree extent buffers
Date:   Mon, 10 Aug 2020 11:42:31 -0400
Message-Id: <20200810154242.782802-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are special extent buffers that get rewound in order to lookup
the state of the tree at a specific point in time.  As such they do not
go through the normal initialization paths that set their lockdep class,
so handle them appropriately when they are created and before they are
locked.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 70e49d8d4f6c..cbacf700b68b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1297,6 +1297,8 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	btrfs_tree_read_unlock_blocking(eb);
 	free_extent_buffer(eb);
 
+	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
+				       eb_rewin, btrfs_header_level(eb_rewin));
 	btrfs_tree_read_lock(eb_rewin);
 	__tree_mod_log_rewind(fs_info, eb_rewin, time_seq, tm);
 	WARN_ON(btrfs_header_nritems(eb_rewin) >
@@ -1370,7 +1372,6 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 
 	if (!eb)
 		return NULL;
-	btrfs_tree_read_lock(eb);
 	if (old_root) {
 		btrfs_set_header_bytenr(eb, eb->start);
 		btrfs_set_header_backref_rev(eb, BTRFS_MIXED_BACKREF_REV);
@@ -1378,6 +1379,9 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 		btrfs_set_header_level(eb, old_root->level);
 		btrfs_set_header_generation(eb, old_generation);
 	}
+	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb), eb,
+				       btrfs_header_level(eb));
+	btrfs_tree_read_lock(eb);
 	if (tm)
 		__tree_mod_log_rewind(fs_info, eb, time_seq, tm);
 	else
-- 
2.24.1

