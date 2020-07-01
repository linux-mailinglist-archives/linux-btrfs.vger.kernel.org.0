Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3662211441
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGAUWZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 16:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGAUWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 16:22:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C10C08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 13:22:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so19500542qtr.7
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ycnan31b5bH8D+Gz2crFLVczfjyOhX/6wtqGo9DnGEU=;
        b=zVpZaVTVqYJ5jxCMrvzchyFxEwS71de51gv8YYiBKOwlgL/em1Ih88mgEX8rGR1LyZ
         pSpvR9oChjj6pGZDz0N7pZARyvbQHwzau45eOiFpUmf4qInJRjCZNXI+fyhPSwl60Qx2
         7LEXz1BdNg9hxUqT4oBv2DIm9Hmi0L6KdOFTNglQNwpsqGEffIl9SnpidFhC7ts4ZXBR
         +MKNsldQRC9SxOJ4jzPDu2y73i69WYE6hTrsDLWrfohMOe7P2pYW4wulyIPush6ubNcz
         YgvTsalkrIEXu2N3lLKKMONWeosOrUITUKmgxymzBpdB15mdEfNnGMtAcycXrIkcpV5m
         KrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ycnan31b5bH8D+Gz2crFLVczfjyOhX/6wtqGo9DnGEU=;
        b=U4BFqaAOdOOXgcgA63OzYqSLAzYnlxMAa/lSG/cx2IbVKqaPXVsRy4j2uK9f1zeeo+
         9LbIU1RihykKJ9626XQ1xQ4+FuNgG1Sky0sdDtkB7LlR/oa9c80P10EopOH9OEQBpJ20
         dcGjc+72tNIz2pEGCjdqom72Xlir55l2/EIvb7O0TFb5LGV8KEm26jSvUyU9hAEiPlth
         nT0EwcahX0zQhHMh1k1l0i811R/ywQjJ8ytUY7210Q8BVhn34LJNPQKp0uE4kY5Dxt22
         v0nqZPYXmUZrop+fawVY6JNGfmUzQHfIoITmcx81A0VK7mo34YKtn5HK6npE0TA9GoAA
         xuhQ==
X-Gm-Message-State: AOAM532a8mzW0TjVYbjQkmm8pt7hqDj3cC156lKiCM0SXjcYggHrZrRq
        HzO+d/OQ6CEsNb/tb4gZwBqb2k1tb23o9A==
X-Google-Smtp-Source: ABdhPJyA9lz7sRyeBpOeWetfT+pQ0nw70lX0sw33753ZURTAbFjebWS2v9xlxk11suIrCwDHdvy+yQ==
X-Received: by 2002:ac8:44ad:: with SMTP id a13mr20922782qto.387.1593634943195;
        Wed, 01 Jul 2020 13:22:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w1sm6140741qkf.73.2020.07.01.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 13:22:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: fix block group UAF bug with nocow
Date:   Wed,  1 Jul 2020 16:22:19 -0400
Message-Id: <20200701202219.11984-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200701202219.11984-1-josef@toxicpanda.com>
References: <20200701202219.11984-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While debugging a patch that I wrote I was hitting UAF panics when
accessing block groups on unmount.  This turned out to be because in the
nocow case if we bail out of doing the nocow for whatever reason we need
to call btrfs_dec_nocow_writers() if we called the inc.  This puts our
block group, but a few error cases does

if (nocow) {
    btrfs_dec_nocow_writers();
    goto error;
}

unfortunately, error is

error:
	if (nocow)
		btrfs_dec_nocow_writers();

so we get a double put on our block group.  Fix this by dropping the
error cases calling of btrfs_dec_nocow_writers(), as it's handled at the
error label now.

Fixes: 762bf09893b4 ("btrfs: improve error handling in run_delalloc_nocow")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d301550b9c70..cb18b1a13dca 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1694,12 +1694,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			ret = fallback_to_cow(inode, locked_page, cow_start,
 					      found_key.offset - 1,
 					      page_started, nr_written);
-			if (ret) {
-				if (nocow)
-					btrfs_dec_nocow_writers(fs_info,
-								disk_bytenr);
+			if (ret)
 				goto error;
-			}
 			cow_start = (u64)-1;
 		}
 
@@ -1715,9 +1711,6 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
-				if (nocow)
-					btrfs_dec_nocow_writers(fs_info,
-								disk_bytenr);
 				ret = PTR_ERR(em);
 				goto error;
 			}
-- 
2.24.1

