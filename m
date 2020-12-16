Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF92DC40C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLPQXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgLPQXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:47 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F40FC0611CD
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 22so12805701qkf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5wsUbZ3Az+ViTcPjzf17bxGV8a/MRj0OYQL0Iy2j8k=;
        b=T7dPHdlh1nqhZN3o+cUzvPAGyCt8W83rkUsUhspglzvJCV8yXZegsnMaEaDZnigukR
         qspXr+d3nNpYmuEQGTTZK7sGtSfmXGDwTiWFgRG3bcfiv7hqaa7Tw/JW9C9DvFbMIWXO
         704Il4XWFaoOonlPfLRTteRtKPPfzSWg5yOb/sMmNevldPByscFjHA2bQ2ecsA72r3Ic
         orXg3FqY6mKdxr3eu9n6H8R3t3XjsVN0c/rbDFxu/kBgTbXxEnXL7F08KiM8MdqPZLKz
         Z1cfDueFaXfGZs9UVNwMZIq/9oErZJn2gpPv8Vl4R5DgfNznZxeCI6MjxaNmcT5NNnfH
         zx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5wsUbZ3Az+ViTcPjzf17bxGV8a/MRj0OYQL0Iy2j8k=;
        b=Bu5h7tANZmsJpF2GDs0y/1esmuo1/GE30St8xMXhWEaNk3PLmo800eyA7BVJf48YoA
         ppj+rBsbvtHdx10su9/jrAXU5oz7rSmEqitVDCY2b5fc9taH9cBZJW/d539htY6lqBjF
         DmhAGF5R5OHYOlLLmsd6y+tR4+P/elfhkB8wsjqgxDnMKMxJAkSKet7QDSBYXvt47URl
         ir88Lfyn3dgyJSqSP0u9CQO7J4vR7M5kXuuvrSDYu6x26ASGg5dWKZlkPeJcBv6m8mzT
         rDxHI00jy3LHReh7k13+Xkfm3xFSpQVkJPef+tRF4+T84cIJA9EkyWDgBTiGtr9zT54i
         5PsA==
X-Gm-Message-State: AOAM533m1qqR0bTJsnBgVGe09VqLmEcmRJWZkJOOqylzH2MA0VueYNRE
        9++9ZKjnXMkf+k8g9alYM+5bNKRBUOIbRtsw
X-Google-Smtp-Source: ABdhPJy97Pv3Yeuab3reZOfyMlH9fPfu5CCM5EC71g6MSL1Zu7LP/BIiDJUUCkO3zkI9EnHXuCFgWg==
X-Received: by 2002:a37:66ce:: with SMTP id a197mr5423559qkc.312.1608135764065;
        Wed, 16 Dec 2020 08:22:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm1319622qke.123.2020.12.16.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 13/13] btrfs: don't clear ret in btrfs_start_dirty_block_groups
Date:   Wed, 16 Dec 2020 11:22:17 -0500
Message-Id: <08fff1cc055306c3fdf16ee20071851b6c59e043.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to update a block group item in the loop we'll break, however
we'll do btrfs_run_delayed_refs and lose our error value in ret, and
thus not clean up properly.  Fix this by only running the delayed refs
if there was no failure.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 69f8a306d70d..5cfa52b1a3b8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2669,7 +2669,8 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 	 * Go through delayed refs for all the stuff we've just kicked off
 	 * and then loop back (just once)
 	 */
-	ret = btrfs_run_delayed_refs(trans, 0);
+	if (!ret)
+		ret = btrfs_run_delayed_refs(trans, 0);
 	if (!ret && loops == 0) {
 		loops++;
 		spin_lock(&cur_trans->dirty_bgs_lock);
-- 
2.26.2

