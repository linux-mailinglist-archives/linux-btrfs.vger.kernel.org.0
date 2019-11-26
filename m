Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD610A209
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfKZQ0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:26:08 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41725 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfKZQ0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:26:08 -0500
Received: by mail-qv1-f65.google.com with SMTP id g18so7518248qvp.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeA6WJ1m1X/FsjhFDoSYS5Sd8TFRDZGGQQcmzfH+1gc=;
        b=NKTCXSWkB4JSBtSKIGNW3doJV/0V/UemKU1cmdHH+IDco6PV5fNVysBorzIK4+TWg5
         Emkho9YmGTey7MP7NGwatgaoiGL+VgX6zZXx4wy4M8QAq6tzfGb1I9wOxEkygkQtJ0k8
         mC9eAFiVzi1QWz6sBKQy3yv8wCalksFHqz/WpLmM1F14sxj/krVfgdnIlDowve8VFrLh
         dCEOrXcEWoIe93h1mFoeAaQO3gLkamUOQ6jPj8Cxvw3WYbqwIDgvhqi5A/BePR6eJ4ut
         S3nqaRqFV+9Rl2etuev1EzYbj+ZV6qIRbC+3PQJQNBTUp0+p10pLWKDuM/mLoszRKCvu
         YzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeA6WJ1m1X/FsjhFDoSYS5Sd8TFRDZGGQQcmzfH+1gc=;
        b=ugH9xvEKNX95yBrcDyyLt12lLZg8NleCsGhOPOFzPlOU9n0ACGUjIeGqaojKGHteJL
         XwY0cxtV5ufA0fUniVZpNTCMKPKWFS/hHFWP73dBi6aqS+6NcCrspL/Mn0Bek3yqnqc+
         NyvlcIJuA/JZ+wXy7zQjPYqNOYTveeZEbjrBn4KzFlTNKmubyUWLj6WnsWD9PmuFoi46
         zK0HfyYhq5C8n7tXC/WzMUR9YuRkaQ459u7s/PF5I0Z7v0L9T9hsv2J+58bM3iVlPWWM
         i1oJkDG562GzlNZrxIxt6Q4zxVM/6zapll+roqUwUvSO8n5cbOD+zOLsiTi0+aX34F5H
         AAdg==
X-Gm-Message-State: APjAAAUp19GUEa18xZ7EM8cXJw4Qz/bOCsgJslAkBatGtdv+CNQ6weOh
        53qO946EvQRmQC9jl4Ly+ktnPzoIyLyYyA==
X-Google-Smtp-Source: APXvYqxlpHXT6zOl8KtRrjpBl5s2Hi1FfLNYMz62mp9cSbwj91IJgZ/dDcpIECmYvkpqsf2DZemQbQ==
X-Received: by 2002:ad4:53ab:: with SMTP id j11mr8349070qvv.47.1574785565644;
        Tue, 26 Nov 2019 08:26:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v184sm5277530qkd.63.2019.11.26.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:26:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: fix force usage in inc_block_group_ro
Date:   Tue, 26 Nov 2019 11:25:55 -0500
Message-Id: <20191126162556.150483-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126162556.150483-1-josef@toxicpanda.com>
References: <20191126162556.150483-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For some reason we've translated the do_chunk_alloc that goes into
btrfs_inc_block_group_ro to force in inc_block_group_ro, but these are
two different things.

force for inc_block_group_ro is used when we are forcing the block group
read only no matter what, for example when the underlying chunk is
marked read only.  We need to not do the space check here as this block
group needs to be read only.

btrfs_inc_block_group_ro() has a do_chunk_alloc flag that indicates that
we need to pre-allocate a chunk before marking the block group read
only.  This has nothing to do with forcing, and in fact we _always_ want
to do the space check in this case, so unconditionally pass false for
force in this case.

Then fixup inc_block_group_ro to honor force as it's expected and
documented to do.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 66fa39632cde..5961411500ed 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1190,8 +1190,15 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 
-	if (cache->ro) {
+	if (cache->ro || force) {
 		cache->ro++;
+
+		/*
+		 * We should only be empty if we did force here and haven't
+		 * already marked ourselves read only.
+		 */
+		if (force && list_empty(&cache->ro_list))
+			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
 		ret = 0;
 		goto out;
 	}
@@ -2063,7 +2070,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		}
 	}
 
-	ret = inc_block_group_ro(cache, !do_chunk_alloc);
+	ret = inc_block_group_ro(cache, false);
 	if (!do_chunk_alloc)
 		goto unlock_out;
 	if (!ret)
-- 
2.23.0

