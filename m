Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60D22DC448
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgLPQ3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgLPQ3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:29:02 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7136EC0617B0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:46 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 4so11588234qvh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBxhSXf0g0tkUWQgt8A8W+l2b0PLsImw4twm29Ha+i0=;
        b=hk7o7ShR1ZvicwFYVjq6p0rsm5TceOT6GU+WAQEvzKkhXuqPB2jnpQ0LN50E39rUQY
         A0rtjK1cM94rtLTtrepO1ulwddoDfXehCgnXOruUni6xIGO8lORWea2nVfUb1xOD2tS6
         X4HfNwDuYgcPsp0W3BS8HeteWxUsFynwkU/xdaX1cba2mMA9I7nTx7KhJ1f6Ez1NHe0m
         H99GbHWusWU/SGEDXg8aF2PbBwtNozWAkvE2/P8d+11vaMN7wEsVU9dQ9uYrCq1inn8j
         cLU6n2rFNW6ijmiy9lQod8GlwzNLtbJ+yy1I0mN/5ggzrmM98rKfbQ7/B9lzPbYEER+j
         fjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBxhSXf0g0tkUWQgt8A8W+l2b0PLsImw4twm29Ha+i0=;
        b=rLiCslEAi5R8MzyWoCzCQbz6dZBk1B9Fsm3ca5R7dX41bVpdodoFcFjMjygRIftzZZ
         IMoux+QsiB91rkCpBc7TgFsJAzl+u4udphlnrzMwV1h2SGC8cCcaQwVOUA9d3zYzwwY/
         E7mPBoLLVpT7BPxGzqZXYhKt5ogdZ7O+80vdegvtKBjF0GqZVKFHDFfywHispnxOO6bU
         DGi3s6koLd3XnjD6+UQtK96n5rC5MiRrXO9/GCfRqEWHFXorWCHK0qsCHPQ0UPIWiN0f
         c1Ogt3wn8zosM0HNVup0voWVmihOteb2xMvfYnHCxKBhMegqShtM7c2yfDn29lWs6A3C
         xZBw==
X-Gm-Message-State: AOAM5330DeaPybaCdN8vyKGBXl9Nki5TTcXOJ9+mQrf/jkdnTeJfWZey
        1Fno+TRktJHsWAA/JDwhY3Y6E490hPSuCV1+
X-Google-Smtp-Source: ABdhPJx8K+3jFzSvuCljlm1uKsKdJUBwTT0K54TMMmN0J8tV6z8w7RI57lWC4aEXjsHZJvpD7Z0oNw==
X-Received: by 2002:ad4:4c44:: with SMTP id cs4mr29093057qvb.25.1608136065419;
        Wed, 16 Dec 2020 08:27:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k73sm1438265qke.63.2020.12.16.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 28/38] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Wed, 16 Dec 2020 11:26:44 -0500
Message-Id: <a3143a77b0e8cd4aa42e395caf6e4005bbae3d9c.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d43603ae5570..8101cae374cf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1324,7 +1324,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

