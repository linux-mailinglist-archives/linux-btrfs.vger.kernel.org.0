Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC602D12ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLGOAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLGOAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:08 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24AC061A53
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:21 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z11so3318766qkj.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNOtAisk0hN8omuiH6mLCn6ZjHq8m2odxb3m+HFyoKQ=;
        b=THqFh4Kb3Y870xi8ZTJmYZJkbHvg7ep+m+hbmBIJBxcazEdf0r7yTwSsSPE9P9ahvp
         Y0iQNOmCCvkEqOcfLkBjZd/Hqm/ipOR04O3t8vhOefSt9uKxSc18v7PcL6GnMQvRjLSN
         rtxnRGxk3lHxqS8U7bQWy/aNNA7QTO3DbVtcdukb4dw0Crv+10VZYidiQH9XFqtl2axI
         LrxQV4Cdo1g7TFQVVghoGDBas9X2Yp2h/toKtnRceNC5T0LaHcznxJthmk6ORviGXuFJ
         op6uvHwXQsGgLco73o2OE2qU6wphD2Tp58rFKx4f8aRuYsdO4+OdjztQNfuSToOkJrvX
         JR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNOtAisk0hN8omuiH6mLCn6ZjHq8m2odxb3m+HFyoKQ=;
        b=Ms4/7ClJ6/IBFMCzM7IOmeiYpxAamkGIRNvnUgbeyLSXJYdxNYQS0vk9QQ4GOcnuYU
         pFBEfWM0YDKmTOqMNEX6XBnl/Xrwd9aZCoEeOyUxEUVYIUoyD38A6C1ehedItEJzGDXW
         SEc9PL/2j2ThVMjoLFwi/7HNqus5HhZRwFC+l3gjzYeGMzR9N8UOmu5/UEYzf3dGp6dl
         5WAgfD+5HZIB6C+g6NrbP/yJlF7Dya2Wn6aw3gvx9WYb58Yon2vx/Q0WPj9joFsB36CY
         60ic82yek+IB5UYw4qbse3WWauW2zbtiL/lJSZCZm/IkgibjUacOjtO0BvhGa+7oRUI5
         fsUg==
X-Gm-Message-State: AOAM532s3tP8ZVxi/qjPdi/TLz6iBjwN2LJBWhLV520bozyaXBgsXS35
        7/MCA5wkXYHrDCFeSxGiOOCD5gl39OCAyH0d
X-Google-Smtp-Source: ABdhPJwOCNZEIIhTBBrI3NNwsWxmjbP17sn5PSdUfOfQFjvy1AaFNN6qQSATo04WxN0I7SsBj7+7Xw==
X-Received: by 2002:a37:8384:: with SMTP id f126mr11180982qkd.500.1607349560927;
        Mon, 07 Dec 2020 05:59:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l5sm1067758qkc.93.2020.12.07.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v5 49/52] btrfs: do not WARN_ON() if we can't find the reloc root
Date:   Mon,  7 Dec 2020 08:57:41 -0500
Message-Id: <efdaeb31364dac5dcc1d35832fbfecc184320b9a.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any number of things could have gone wrong, like ENOMEM or EIO, so don't
WARN_ON() if we're unable to find the reloc root in the backref code.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 56f7c840031e..525815d2914b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2617,7 +2617,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		/* Only reloc backref cache cares about a specific root */
 		if (cache->is_reloc) {
 			root = find_reloc_root(cache->fs_info, cur->bytenr);
-			if (WARN_ON(!root))
+			if (!root)
 				return -ENOENT;
 			cur->root = root;
 		} else {
-- 
2.26.2

