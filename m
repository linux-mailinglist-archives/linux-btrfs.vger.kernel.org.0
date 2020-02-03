Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB01A15114F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBCUuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:07 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43771 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id j20so15670129qka.10
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6I+xp02X/JD3iHfzrWtjMJkBBWxQ9LOIvKViwUqQCE=;
        b=PRxHfM92Uy1WGaO8sz3IW0gGZvXafDMAbZdkTSV+IEY+XQx4e8h9DqlXil3BAD9GQq
         ezclG9ilF4AGssCQDn7Vqme7IoU1QVqK/vWaiuV3AdlwntbSSDHKNNdxRNupXGo3tUx6
         KNXGOsbfGVWYHUhdNwVNNG+0vejc0RYPndXJcrfQXtk1HdhRjnQvOGxKgLfgNj1oyyf3
         rTqSXqkgaVfqULodAK4R0+iGLS9pQ1Bj/AHyhrNmS9PPy17d/pLqjoD1+8lhguULbLXq
         lzktMVHQSsLrjrzso04nYu4qeWnXW+KeLGAgMTJKzoiDm5Tqm2XBVRFvxAwiEsB7wPG9
         It/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6I+xp02X/JD3iHfzrWtjMJkBBWxQ9LOIvKViwUqQCE=;
        b=NMRm7nTOWAS5WaNZ6psNa4fQnUB8IxFZIYQxbU2+KvxL8Hh3fcEBNieYkUqVSE6Fd2
         RunBWL7M5OOxaCojKnbN1EJFtiWJjkXQ3LPYvMd0kA2OHrCQNJx8+HHJxNWiKKc8yhmx
         7DvrktPHa+wwAe4OW25CE0yLV3w4HaayNAW54wIEgXkxmhB05q3I7nPxWZJRMzc455zr
         pJHGIef++BFSFAehsAMaHML6s8b3AUFH4+X+rBihJBYOu2uDyEqWYWF+gQxO+NLYN2O0
         BCd/9FEasU01LQ+Tc22UpIOLUEWabMvGq7L0qt1dWrV4qO8Bn4i/Ao9Xk5Gzj8UbTPzH
         sqaw==
X-Gm-Message-State: APjAAAXr8tE8R8ze4SgF9ATOwTmcXUJnZTd0Rj64kLxh4KIt9oGXGdq2
        mwdgJGUIVMLisVp81Mk5l4xW8OMl1SElFQ==
X-Google-Smtp-Source: APXvYqwetGfZ2qP518u5SoWtYWiKnHl6J+dchJ0HBo6GPw2Da2+4He7ezBQ577IyHbD1C7CGxFXFTg==
X-Received: by 2002:a05:620a:1fa:: with SMTP id x26mr25371449qkn.311.1580763004344;
        Mon, 03 Feb 2020 12:50:04 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 206sm10007394qkf.132.2020.02.03.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/24] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Mon,  3 Feb 2020 15:49:33 -0500
Message-Id: <20200203204951.517751-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were missing a call to btrfs_try_granting_tickets in
btrfs_free_reserved_bytes, so add it to handle the case where we're able
to satisfy an allocation because we've freed a pending reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 77ec0597bd17..616d0dd69394 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2932,6 +2932,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	if (delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
+
+	btrfs_try_granting_tickets(cache->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.24.1

