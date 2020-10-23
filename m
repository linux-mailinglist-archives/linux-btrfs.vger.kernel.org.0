Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3FD2970F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373430AbgJWN6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372968AbgJWN6Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:16 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCF6C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:15 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w9so722752qvj.0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7WuzjlE0G17n6fXLNoW/DGqQfUNZELT0J7f8+45tXiA=;
        b=OFS+rB3AKhmy4OHiw7VrSdvlvw+r0wyqpdRf8nl8Q/LE4bAEy6GUJd8PTTf797Xbhw
         t3GV2tx8rZPHk705lZ73aIYHv6AyI9coTRDchHor7OaakOGeWTCsOasNbm70OCRRGT2l
         90QW68bnWT+rTpixE1lrzMCqruciDfgbveO7QQZ+PY5YktWqTS5J385pbxfCNZeLpf5R
         u4dHdWCWQMyZjxpRY3dIrNH7YyzMUiRpv2UoG0jguY3D3b1HOTJR1GY5yeiVtGnnj6ST
         1I/fOUeMFOKqXNHj7VD44X92xWfqT100yZkoztAzJIvsy0klJdsQdb57gdIeMWFh/VUc
         kO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7WuzjlE0G17n6fXLNoW/DGqQfUNZELT0J7f8+45tXiA=;
        b=Q1gi9xvRbo16UakD24Qu3vZ6Bja0hpMXBjJlp2clEGmhnC7orYP27XF3v+ToAaD/oM
         ceSGx6Jv/5cl1IsyNJ/+t37mRgT1qO3qzqoP9CTQ+3LCic3Jdu8VtYvf31Ss3FwShZLa
         CxuIP/Vrxa5GLjA8SkNdyj/r0ZvfRP5Zrt7b5vlxXqP4e4b+AVzS3pJ3SWctb606wQq3
         +dg5Aabk+stYn1YiBgEViOyDXmfvh5Tc5Wr7riwb+7lHLZ/fOFt7OG5l1yCqKbJyuzf+
         U/MJpURCD0rdv6OZoeOcwz1+Oasa3mWSaZ0nbWq+KejQsaIl4DLIwoVoPi9J4aP7DOXg
         vVSg==
X-Gm-Message-State: AOAM530AG1eEW42z0CAmDdHbMc5Rz1yRNdEee8kJR0xSO+dMPOT8BrkO
        u+ncisIqrWHBpZd3OIvyv+c1xk0JSGy2iaYK
X-Google-Smtp-Source: ABdhPJxFTl9kJdGy5zd1bpiD7Rn7IPgwZH9xiU+HHy1QrJe8b3Zr9WiKrP/4D0w2vlx0vlsPBOZleQ==
X-Received: by 2002:a0c:cc12:: with SMTP id r18mr2454470qvk.2.1603461494722;
        Fri, 23 Oct 2020 06:58:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p136sm775873qke.25.2020.10.23.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: do not shorten unpin len for caching block groups
Date:   Fri, 23 Oct 2020 09:58:04 -0400
Message-Id: <1e88615a596a6d811954832a744d105f94e42645.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While fixing up our ->last_byte_to_unpin locking I noticed that we will
shorten len based on ->last_byte_to_unpin if we're caching when we're
adding back the free space.  This is correct for the free space, as we
cannot unpin more than ->last_byte_to_unpin, however we use len to
adjust the ->bytes_pinned counters and such, which need to track the
actual pinned usage.  This could result in
WARN_ON(space_info->bytes_pinned) triggering at unmount time.  Fix this
by using a local variable for the amount to add to free space cache, and
leave len untouched in this case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5fd60b13f4f8..a98f484a2fc1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2816,10 +2816,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		len = cache->start + cache->length - start;
 		len = min(len, end + 1 - start);
 
-		if (start < cache->last_byte_to_unpin) {
-			len = min(len, cache->last_byte_to_unpin - start);
-			if (return_free_space)
-				btrfs_add_free_space(cache, start, len);
+		if (start < cache->last_byte_to_unpin && return_free_space) {
+			u64 add_len = min(len,
+					  cache->last_byte_to_unpin - start);
+			btrfs_add_free_space(cache, start, add_len);
 		}
 
 		start += len;
-- 
2.26.2

