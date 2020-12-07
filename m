Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7EB2D12D8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLGN7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLGN7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:49 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1BEC09424F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:58 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id l7so1140370qvt.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EH5zLvg1xCtS+DbKeTE1Z4oPb6z73SdFjMASUwOdAQg=;
        b=XmYqxzcihCA2NupxA9PHRLJFI2ZdXg4FseHU5JZruGzVvEdT/qVf9gioiLNrytAGWr
         rIWYF6A6BXgjp6x5o1RpI2iMB2qhZ0+RX0I9UY0xODX3ZjsT3V1mA+L9pM6uPHb9MVGy
         yhiIZqhNytNF6cUjwhGacaufWg0IR+HduM02qMIAyklWyWcRz3xHMolxjiYfNWhY0OOl
         xPzWeOrpDRIvq5s2WG9QfCYKUpKcXz0S+qYfU1xtl4npB2sQaAP8yl2Olm0sk8MkSx/1
         k8iYH4mKqRTEuhzLu1tU4hQRX9aFy1SbWdYBP9e2K/sA7SrKlRYnnGYu8bdzBdeBIc+s
         llzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EH5zLvg1xCtS+DbKeTE1Z4oPb6z73SdFjMASUwOdAQg=;
        b=SCT9aqrC5OI7Ydw1H1kgWD8YeHfKAW+8Y7Gupt1kneYPYvgLJMrx+2DuMzIndw9QXm
         C/tK7pFWrKj6q8eMo3zT1gJnr1YreApiDko58sLfCkpRPQLalHBcFKNIbWqJ1guh8faf
         E+5Ryvo6aSwSKYerCISH3mi2huIOnDi89a3fLGn2dLy0Yq5QKm2AR1fkSUZaYv4Uc5jY
         y857MCEDsBoVe0qhM1OC6CA9ixMRJA+FpXGeiCNfOh0mM+RQXRfUNCWytggfLp6GFWrq
         HF0GqOUg0/6GEIwjm61MPBPHWz4ypfpMrjFxpnK19zecZzCMucy8DSh6FlHzArfiAUVJ
         7dBw==
X-Gm-Message-State: AOAM533AtqkjXtc0qmUCmfuxTNi8+bA0jkDB1uuAdombN96rPUoy9Vq9
        8CLUYow7jXPdyNwFQHF7USZgNRCnKgPgjvzm
X-Google-Smtp-Source: ABdhPJzRgHPUzEUGw5fSsTsnLYp73W7URoiEl3XrgMWv9nmkspY10Oofl8a7ER10rvmU5EB6JCIs4g==
X-Received: by 2002:a05:6214:15c1:: with SMTP id p1mr9130891qvz.8.1607349537093;
        Mon, 07 Dec 2020 05:58:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 8sm6019531qkr.28.2020.12.07.05.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 36/52] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Mon,  7 Dec 2020 08:57:28 -0500
Message-Id: <e3a125b7da1ecec91c2813a30ac12ce23aa96421.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few BUG_ON()'s in replace_path are purely to keep us from making
logical mistakes, so replace them with ASSERT()'s.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ee175d2a5abe..30a022f26cb8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1202,8 +1202,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	BUG_ON(src->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
-	BUG_ON(dest->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1234,7 +1234,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	parent = eb;
 	while (1) {
 		level = btrfs_header_level(parent);
-		BUG_ON(level < lowest_level);
+		ASSERT(level >= lowest_level);
 
 		ret = btrfs_bin_search(parent, &key, &slot);
 		if (ret < 0)
-- 
2.26.2

