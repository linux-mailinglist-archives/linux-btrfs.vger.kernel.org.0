Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E74CED51
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfJGUSM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37106 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbfJGUSL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id e15so6257337qtr.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=btKJ6g9fTO1tYKb8F6/OgOsQXGTbh+3K3gbcTVgRpv8=;
        b=mueRn1SNW1DtS3SWPCrP5Nh7tOPic28Otuy/v0vw6Dspa0U7r+RRHDNExNwC0oECyS
         0nFX8epiTzXwp3Pr0ymK/EUiu2jLzaoHtoBDirHenSUi10myxD17+oMM+OrulACgaZ/6
         xJGouliyEbtS72PsYaueu+r+BL+5pxUxUvrmXbpBif0s83Mtks+OCCMfsLZSzt4quJXx
         EopZGrOrnKVT3ZMJ5r+q4DzJ9jSn/BJ9wtPJoBE2XDOV8d/FA+IFf+thTS2+uF4pcmRh
         Rlk3bPy9Z/myNACtN5HHLVnw8OZRUuP3j9YPKrnN2G+c3hMjPWl6518dQe4DaFxojN5M
         jjKg==
X-Gm-Message-State: APjAAAU6rAian8wZCQbAl9ZCypkAlSZCk3WiEVNqmr8arvqF4db+uDVW
        5Q29WqsWuOi/xGwLfruDTj4=
X-Google-Smtp-Source: APXvYqyVid1DQ637aoxSO6T4UHyz0+tHRWlO6WzbTiHs/H1xQdWg1tBxZoUoPV+2S7Vs7LNBtxjVZQ==
X-Received: by 2002:ac8:43cc:: with SMTP id w12mr22481392qtn.301.1570479490571;
        Mon, 07 Oct 2019 13:18:10 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:09 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 15/19] btrfs: load block_groups into discard_list on mount
Date:   Mon,  7 Oct 2019 16:17:46 -0400
Message-Id: <31ce602fac88f25567a0b3e89037693ec962c1c7.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Async discard doesn't remember the discard state of a block_group when
unmounting or when we crash. So, any block_group that is not fully used
may have undiscarded regions. However, free space caches are read in on
demand. Let the discard worker read in the free space cache so we can
proceed with discarding rather than wait for the block_group to be used.
This prevents us from indefinitely deferring discards until that
particular block_group is reused.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/block-group.c |  2 ++
 fs/btrfs/discard.c     | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 73e5a9384491..684959c96c3f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1859,6 +1859,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 						&info->discard_ctl, cache);
 			else
 				btrfs_mark_bg_unused(cache);
+		} else if (btrfs_test_opt(info, DISCARD_ASYNC)) {
+			btrfs_add_to_discard_list(&info->discard_ctl, cache);
 		}
 	}
 
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 0e4d5a22c661..d99ba31e6f3b 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -246,6 +246,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	int discard_index = 0;
 	u64 trimmed = 0;
 	u64 minlen = 0;
+	int ret;
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
@@ -254,6 +255,19 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	if (!cache || !btrfs_run_discard_work(discard_ctl))
 		return;
 
+	if (!btrfs_block_group_cache_done(cache)) {
+		ret = btrfs_cache_block_group(cache, 0);
+		if (ret) {
+			remove_from_discard_list(discard_ctl, cache);
+			goto out;
+		}
+		ret = btrfs_wait_block_group_cache_done(cache);
+		if (ret) {
+			remove_from_discard_list(discard_ctl, cache);
+			goto out;
+		}
+	}
+
 	minlen = discard_minlen[discard_index];
 
 	if (btrfs_discard_bitmaps(cache)) {
@@ -291,6 +305,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 		}
 	}
 
+out:
 	spin_lock(&discard_ctl->lock);
 	discard_ctl->cache = NULL;
 	spin_unlock(&discard_ctl->lock);
-- 
2.17.1

