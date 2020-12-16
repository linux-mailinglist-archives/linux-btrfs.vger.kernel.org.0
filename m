Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789CF2DC403
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgLPQXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgLPQXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:40 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEBCC061282
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:29 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id az16so9480083qvb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lINNY+enDQiOYg4MKLN9xSMq5gDRM8FwVQd+/AJ8z1w=;
        b=KYqeppygPP2FlwTup8ZTHtzsL/yxzSGLkkHrB3dDEowjSOkmx8MRbTim3NiACf2Xdm
         yt1Q8wCKvCXmcPA3IEuV3g07PswgX/mVrveoUUEURwFvSbyYoZPpkV37eVag9aDrF3ab
         deXmgv7TEQbY1gmF9qwK3Cz3Z/OyZ04thMMZrAJ7Ox2zOfz1BPpTbz4d0Scp/KpjO57E
         uIw7MrHSabXmkm2p4pkgoZ0yVyz7kIkv4FyK80Sei9obNV+KDteCAm9OFLrbAk+LaHZ2
         YozvE4Di2ViRqroCy7+6VKqa+L3fThZQLhVvwSJgndZFER0SLllmtBTp+PTDO//dzHEy
         LLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lINNY+enDQiOYg4MKLN9xSMq5gDRM8FwVQd+/AJ8z1w=;
        b=UwCDKbGnPznntkGgGxRfIhwbZH5q92Og6AQLXVwvs57mTlfocavMjvUGl42bKUg0VY
         2SmQVyYpyWc59kN8O1xHdARoo6ixfiC6Q77EyRK9V9WpbD/ayPDxO97CFovaBA3rRoH9
         Pe17AgHb/vK5d8X81v5LfVH2EivL3tElldfONs0AeUppNXHjcb8hhlH7K0TEzFoGBwvT
         PO1OxAormyWsf11ABwa2Os5JEJfiTtdkOR0PSrTjabZb56ZZbkr9Hr0JA4G4br1mss4O
         3rLHYDUsAnV+QXtnagIuk47aaQ/xwvftr1+Wvsl5NQqcwU/FV2zQJP7bu5qVWv3TrUT3
         rgWA==
X-Gm-Message-State: AOAM530mOVJRcavpwJ5PVurEpWEmKHH9FrRP3MuYgtfDrq/KZStN5z+Q
        ySuxET/NwsQGul89qibHNm2mi5KLzjo8H04f
X-Google-Smtp-Source: ABdhPJwnk4AuJVxBY9/YtmhIblrF4gN3Fh5dVnq7mP2OPLbL0GKQ/1fACPJI9dKzwQ0UVwL7IrzM3w==
X-Received: by 2002:a0c:cc12:: with SMTP id r18mr44394539qvk.51.1608135748115;
        Wed, 16 Dec 2020 08:22:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a22sm1299266qkl.121.2020.12.16.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH 05/13] btrfs: do not WARN_ON() if we can't find the reloc root
Date:   Wed, 16 Dec 2020 11:22:09 -0500
Message-Id: <d11a0c1770a96bdf382cc3f41eb71fb790650aa5.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
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
index 02d7d7b2563b..f0877d2883f9 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2624,7 +2624,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
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

