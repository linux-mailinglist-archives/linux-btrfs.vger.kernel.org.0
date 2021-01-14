Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91A2F6A6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbhANTDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 14:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANTDg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 14:03:36 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B2C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:56 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p14so9324697qke.6
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jc8YR0zu5PjIFMhCvHnPVshxUh6dCcrJVPY2apQ0+lw=;
        b=cCDijPMMiSo+JTKqBxqm/Pv6orQ+zGQO+rz9reX5Ex7bc1bundmYF79PDeDaEbeS6E
         vOSL3B3FAXTwLiKmH9z2iMAMGpRC+IV983yR0flQfUQrz7Cu/q3SYHZ7c0vH8JGwUL5M
         rrXCt2HWxLQj4VTHh1WojGoJiX3acFMkDETGwuG6/zMVII3iOHVeWgah0Xz5tNRN/Rzj
         8drQUEp3OJjnrVHO4qj6fWadVj8GWv0tDtRwIr15tWq4SO/F7YHRUAutT5+DVNq1UwI1
         3vLiyvxzsUkPC28q0ZE/W+JbRCej027GMc1181Wlwk2FnLBrQPoDd5l0YJSMuYFtG/Uq
         6nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jc8YR0zu5PjIFMhCvHnPVshxUh6dCcrJVPY2apQ0+lw=;
        b=TeOXfdFYcjdWnTBNg6V7c1aKFESHBUK71B1d2xFlGpCdC1yWqaSPWCcIUcjNvrFgwd
         QiSyK0sPLLL6F32dov1pbTeehzyRRyq2WD6ARlOq7lpmq9LtFfrS2VKf9He9MW+uOt/v
         4IyJD4ObJASC6XZejZktshDb3OAofhb6PkhOOcUNkvJ/4OJkHJS2PMasqRfayIwOh1Hz
         Pvi4Ar4yUcMKoqikqY83gCnrdMxwezNR3C9ZMoDj1IKP7vJb7ma7DrMbhQ5FQi9gowbm
         FEf3O7cwblhzJVV9gM2TUBY2IPuyZ9StwnweWRBSaSNMz829X3gmr0h2NE4jIDf7fwip
         u8xg==
X-Gm-Message-State: AOAM533H6yujL2s4pUOQZ/bQTGvWXYgdqRDnbFbL4pLnGQln2Cf1EZPz
        U6hcbBe6u52bKHZSQ0KUc93gG1Arl3gUJolt
X-Google-Smtp-Source: ABdhPJwnieqHHF1LINJdFnwMmu7p0lK1IyIkgyTvCYu2iZf5kCmUKxlZYBV35QBnl5g92zfLPaNWSQ==
X-Received: by 2002:a05:620a:645:: with SMTP id a5mr8556267qka.335.1610650975356;
        Thu, 14 Jan 2021 11:02:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s8sm3345177qtq.32.2021.01.14.11.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:02:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v2 3/5] btrfs: do not WARN_ON() if we can't find the reloc root
Date:   Thu, 14 Jan 2021 14:02:44 -0500
Message-Id: <9d01716b2a0c481f78285f59c27971ae5606e65d.1610650736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1610650736.git.josef@toxicpanda.com>
References: <cover.1610650736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The backref code is looking for a reloc_root that corresponds to the
given fs root.  However any number of things could have gone wrong while
initializing that reloc_root, like ENOMEM while trying to allocate the
root itself, or EIO while trying to write the root item.  This would
result in no corresponding reloc_root being in the reloc root cache, and
thus would return NULL when we do the find_reloc_root() call.

Because of this we do not want to WARN_ON().  This presumably was meant
to catch developer errors, cases where we messed up adding the reloc
root.  However we can easily hit this case with error injection, and
thus should not do a WARN_ON().

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ef71aba5bc15..7ac59a568595 100644
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

