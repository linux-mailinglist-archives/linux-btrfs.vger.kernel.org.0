Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD021109038
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfKYOkV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 09:40:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39527 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOkV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 09:40:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so8032993qtj.6
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KkWiOv6Ez2X48idC8HSRbI2sow1xz7eA9KxdDPJgIf0=;
        b=g+bR4rnGzmlcxS3uIYOnzcoYAP57fkxqDKcRmhL8ynjX+gJbK2s6gMnIbMI3v/Zxl0
         gpABam91ncsxIi/ZNEoW29QhNKaCAVKJeq15rVkxQ8rp9U+Y7mUiIviz7AwwTvug6Lbm
         ZTxyPEcm286yeDNQCpU/byUlUwrk13LSL3LYO9UwawSc+tiw2wjnZX9HWC478vEF0oqZ
         h97eEoAnfGNvyf51a8cXGdYKonBzGILaeUDhi/SqUuqDQOvxd8V/HooIDDTbCPDC1JuX
         OTSdknW+kuKJBvZ2nQbOr+XpvA08bQ2m1S8PYl7cqMoLWg1n7I0t3DAtWz37m/oXW+dr
         lo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkWiOv6Ez2X48idC8HSRbI2sow1xz7eA9KxdDPJgIf0=;
        b=p7ucR+nfiapG+JvzW0RkilQT377uO2b/E7Ct4bfuVuL17yUL9Fd0nJWMXegd4zBSu0
         J1Yf50fvYDvKEYTvxPYu85dVf6sU7SxhsmuZo3a8oMWk7js9K/EJzohGPRKZakcRNc0k
         OBLBF70LeYdkFsdmQXoe5w1dIeSDeWtxbZhWqj1XF7j3v+Xnxf9GuH7yZ/oJfG3EM07W
         R7Hx22VX/vBcLxeQRVGH1awU9vGXMK80/H1RLjGUFPSMBJF7c+ls8wr/yzyfEEcNEEaf
         wbHGP5XVrQoP5nRDZ4TK1bgBHepFkDFur+8zWlrmfgCwxXTfFxD4g1jS20AKzB3t/eGQ
         JhNQ==
X-Gm-Message-State: APjAAAV4i0II+zbYXV6e6G6uIwwq8L+IeUVBvshQHyrZOX0VelwJ4P30
        ATCGYxUZjaBZu08bFuXdSjt70ciE287I2g==
X-Google-Smtp-Source: APXvYqwnJAKJ/AvkNJY3t1chvrvJOv0Fd1twbRkdvTqTrH+TBwuEIPzJ1sIyfzArgpwu/Lk+wK/Chg==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr13480690qtp.7.1574692820083;
        Mon, 25 Nov 2019 06:40:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o124sm3421392qkf.66.2019.11.25.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:40:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: [PATCH 3/4] btrfs: fix force usage in inc_block_group_ro
Date:   Mon, 25 Nov 2019 09:40:10 -0500
Message-Id: <20191125144011.146722-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125144011.146722-1-josef@toxicpanda.com>
References: <20191125144011.146722-1-josef@toxicpanda.com>
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
---
 fs/btrfs/block-group.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index db539bfc5a52..3ffbc2e0af21 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1190,8 +1190,10 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 
-	if (cache->ro) {
+	if (cache->ro || force) {
 		cache->ro++;
+		if (list_empty(&cache->ro_list))
+			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
 		ret = 0;
 		goto out;
 	}
@@ -2063,7 +2065,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		}
 	}
 
-	ret = inc_block_group_ro(cache, !do_chunk_alloc);
+	ret = inc_block_group_ro(cache, false);
 	if (!do_chunk_alloc)
 		goto unlock_out;
 	if (!ret)
-- 
2.23.0

