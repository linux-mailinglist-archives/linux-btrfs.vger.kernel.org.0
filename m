Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385C3A4385
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFKN5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:57:21 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:39710 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhFKN5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:57:06 -0400
Received: by mail-qk1-f174.google.com with SMTP id j184so30985547qkd.6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YJqZvDX2aWDsMv11OujpS3WgmA8xXQjeRrN0oDTZ2f4=;
        b=TmAbIie4iualFihNpP2ivV5obpPqihYz/8IGtnGBqps9K/v71AdYLe4byQvxCUC3Fi
         3g8SqQp/Wia7nLagpaMhjAbfZJKPjy53CXUIKxsIda7In5OxmuLe4xw6REQUINw6IHRA
         /8bed+TUIwiAvGJ1oACyQdKVFckCBMhuXkhH2XLFRptCMEFkKfpOOsRS3Rviv1g+G7ec
         eIG8974zILoztDMbCPiQ+s333WQbr8bVzDbiYaEoifrKcBEDModOShPHlK44xcGI9FQ6
         Wa7bfhoYEWdqGLhkrAjB4+lIT2858dbDa37EQtDpqSUAqAJc2u1EYSAr1/npXasUkkRJ
         8QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJqZvDX2aWDsMv11OujpS3WgmA8xXQjeRrN0oDTZ2f4=;
        b=fnY+YfHy5LL6Y+sP4LGNOjA3R2kTyXRbK/3P40/74g44HGla5jYk5fzMhPFHsZk+2X
         iMtsyn9XOEdS19i0qUTy1dolBJcFGfNis5oC7j6KjsmIOkKofD6rwz0E85STMclET4ZD
         ZjFSgI4bmVNwLeQ6AyqhgCWIgUshB6BYY+0tngqRqMMZkSf5gQumG2PpQOhqsdaoqggU
         xe4aQXBechNpJxo6FTiPZdsF5ACphZFxBxcqlsrATQdPUg/N01jhmtaFcpQ5IAXfqwqa
         joAJHRX5dg5cY9pLDy0f8oqDRe77abzOeoN1wq8rGT6+hb8XeXUKShPZjgtasjSuDmJM
         i93w==
X-Gm-Message-State: AOAM531Kby8LPDHHcNUeEBwlxoVnvxKExVeBBc/xRcGUja3LBomBAFE4
        nT0e3K90OcE68T+vgzNhThyvX88+Aa8+ZQ==
X-Google-Smtp-Source: ABdhPJyfL1inLyic/7nQZvcN5IpNviF3kHrz+Oz7UulE54WLhhv7qmomp0DOEFr47DjDfCff8oQnRw==
X-Received: by 2002:ae9:ee12:: with SMTP id i18mr3835487qkg.440.1623419647565;
        Fri, 11 Jun 2021 06:54:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h22sm214892qkn.87.2021.06.11.06.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:54:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
Date:   Fri, 11 Jun 2021 09:54:00 -0400
Message-Id: <bcf08d20f1894052eb6edc4c3f37bd44f6dcab60.1623419155.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1623419155.git.josef@toxicpanda.com>
References: <cover.1623419155.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sync_inode() has some holes that can cause problems if we're under heavy
ENOSPC pressure.  If there's writeback running on a separate thread
sync_inode() will skip writing the inode altogether.  What we really
want is to make sure writeback has been started on all the pages to make
sure we can see the ordered extents and wait on them if appropriate.
Switch to this new helper which will allow us to accomplish this and
avoid ENOSPC'ing early.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c37271df2c6d..93d113991e2c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9680,7 +9680,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 			btrfs_queue_work(root->fs_info->flush_workers,
 					 &work->work);
 		} else {
-			ret = sync_inode(inode, wbc);
+			ret = filemap_fdatawrite_wbc(inode->i_mapping, wbc);
 			btrfs_add_delayed_iput(inode);
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
-- 
2.26.3

