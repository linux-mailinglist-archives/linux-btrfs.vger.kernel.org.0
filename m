Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28228F87C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbgJOS0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 14:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733071AbgJOS0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 14:26:08 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE40C061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:07 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id bl9so1553797qvb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gJv/kCOWP4iDyQljzkiUrIv6nJWAOkxDtMaJOZ2KEhU=;
        b=jWLuGLlKhWnkYiCRYW23AcwQeiI/nXcZo32MPijgqAoWErfW7IETxDJ4sljsMBgdfN
         hx4AQd7SvSVbRT5kWCmU+VcIWi6/Nz9cBlqe5Yf2EXUhxMOh3tzv8m9nAaXi7z1Ct2OC
         8hj12KCPHyjYaHTF7x7hUVdWX+BXhEOUjqI1vmzPjK3F0y6ykFZAnqzDJs3qmDBr0pnT
         w/CGTwj/cRFQwvXtwGTd3Pr9xeqsHcqo6cwJL5ouVPmiII24gmkd8k+/Zz5NqSbgdVnO
         1Dk1MC7WHX8wrALlyVCcavnJ8dfSjSv7REymg/+sZEeJK+FYEO6j7V/rh8ootgK5ot0l
         kTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJv/kCOWP4iDyQljzkiUrIv6nJWAOkxDtMaJOZ2KEhU=;
        b=s1suG3tWC+XtLisaXRapDkpFPS2Byyo1TmwHL9Lm6YnP4nd26E4PnC3z4aHkrfWW1B
         DBnxnwu4x4+ol5n72T4/1+/Z5VWRjhjYdaAYhAS2L9jKvlOLRL624GPLPk7bcXcQ6GIE
         Sg7y3se906JqLct//zqpQ0K/aqUFre580wj8/uiN9/zlFZB6P6FkBthwqYzRhEi7XBk8
         creI/dWFEy3UEGp8HgHmMyaBPAgAuNazFGaP4JbhAIfW/hvny5fv8mDNMOPlMbauKtlD
         terNhWIuxGuNVKGqow1mkMMlpVEWh7IVIN5T50wyHM7cd7gHy+fnT7aERkGt0i11Ivvw
         rlfQ==
X-Gm-Message-State: AOAM5302s45pDyfgavxoHwb2vvL9f+LoMKOv34nRlQuIjj/fBW2GS+HW
        uVvwth+lUhNCGq0niOfydHmU3BMsK5Zc3NYK
X-Google-Smtp-Source: ABdhPJzC86XRey6EeVcdsS6dhi1w6OJipR2jO2CdOsuJGLieZx3FxPLTyzrk260+QGfJnz8PIo9E4w==
X-Received: by 2002:ad4:5191:: with SMTP id b17mr186577qvp.0.1602786366559;
        Thu, 15 Oct 2020 11:26:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e8sm21430qti.88.2020.10.15.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:26:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/6] btrfs: do not block on deleted bgs mutex in the cleaner
Date:   Thu, 15 Oct 2020 14:25:57 -0400
Message-Id: <f759df3376d2b478196c9724b26683289e8e5625.1602786206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602786206.git.josef@toxicpanda.com>
References: <cover.1602786206.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running some stress tests I started getting hung task messages.
This is because the delete unused bg's code has to take the
delete_unused_bgs_mutex to do it's work, which is taken by balance to
make sure we don't delete block groups while we're balancing.

The problem is a balance can take a while, and so we were getting hung
task warnings.  We don't need to block and run these things, and the
cleaner is needed to do other work, so trylock on this mutex and just
bail if we can't acquire it right away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0f1d6818df7..5e0e5843edf9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1333,6 +1333,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	/*
+	 * Long running balances can keep us blocked here for eternity, so
+	 * simply skip deletion if we're unable to get the mutex.
+	 */
+	if (!mutex_trylock(&fs_info->delete_unused_bgs_mutex))
+		return;
+
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->unused_bgs)) {
 		int trimming;
@@ -1352,8 +1359,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
 
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
-
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 
@@ -1499,11 +1504,11 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 end_trans:
 		btrfs_end_transaction(trans);
 next:
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 		btrfs_put_block_group(block_group);
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 	return;
 
 flip_async:
-- 
2.24.1

