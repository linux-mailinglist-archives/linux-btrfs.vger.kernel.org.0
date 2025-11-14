Return-Path: <linux-btrfs+bounces-18988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5505C5BC88
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 08:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA6B5347786
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390BC2BE632;
	Fri, 14 Nov 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgOo2HSo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EE2EB840
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105233; cv=none; b=TNYHeNxjPFtLhRPmRUveMKcax+CmU7Oe+SYmvdjJ4qhyRuKhXyccnyhrVAFAyU/DybDobMYkgiFMBqd2Yq1vEkq9WB3VPcIa52K8tWJsWjDe3QVE6TB1+DLGKgqfHMXBJkt+uv7poch5EpICoG+3PrwkOzpWg+o9KQ88eOfQZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105233; c=relaxed/simple;
	bh=15RTtqoaCA+1DwpC0ue8InjZHei1/eVhAyao45t4NL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtSU0MwNSc/K4t8zUVcSlA4On/MIPOqKdX/7BADpxMM0r8dxRzX2Mb9R5u+BvF/gtI6wG4TZLCsew1u78A8JURsekxIbt8V2/Aoh+KWe8wr+ASt0O6V71P99LN5Ra4Z9qfKTXxZbftIiiHYU+pzc5gC8jw5nCO0u1+t1eznnE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgOo2HSo; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b8ba3c8ca1so127086b3a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 23:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763105231; x=1763710031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm08G7XbbTfy1gSFFnhFHG1FSmyMHbiFrpURmj9pYh4=;
        b=mgOo2HSonwC4bPIZREiioXc3nHAESHZOYTaIovRfGZ97wwQ4UtCCYxRubb3K4YJQu7
         qA6MW/rCZdO3RJwmnclsOsysA6ZkQamE2mZQGcjBvj9WYBpXooQm3kiHwxLVmr8eWwNb
         HLkKIh4nw77YS1Q4gS+ow4+FDF5lHI9Mxu9USRHfMcC3ILYcS4U3jxxdUuNDF+FH6ka6
         KcYLlmYtP7v4Y7kBDvkJUN/m7+gkVKH50nC6JYpOWZ1OX0dcEwCQGFr4MYwS65kY7yxq
         I5id1bl3fuX7987rTTnLA9FjTc7wqttEHhXUSu7PdXvyw4HjTyNUDMQWMj9FH+nqXxht
         EreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105231; x=1763710031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dm08G7XbbTfy1gSFFnhFHG1FSmyMHbiFrpURmj9pYh4=;
        b=w7pz5gLRYg1YlWTEKuZuQkygEhGw7j2B/0JTvAH0XnyBtmx7dfCrkIZ7fu5NuY8cXo
         Y20oeteaMNfhou47efad/0J2kr7HvtTkLRmHVCPd7nTo1/sq8P3teEoW8yrPECAtDPCe
         2+/67P/YnRlby4D+lUwQ4e5VyKFWe7g/AN5/zP5c08HKBFyzm57mHLYlca1frnCioUaz
         qtiBseTSx47DKJAdHe7kXrxxhMxHQ9RYLUwFT+7pN8HepBjyywdXrJt9Naqp+QgbBkeb
         RJ5uvLHn54Nl1uB+HOTWo3vQF5Og0dTr33XXfJ1IIhsT9qGXy5hz1cAysj94lV0l5KcX
         ptbw==
X-Gm-Message-State: AOJu0Yx6r48XJYfo542GeF2DVmna7qwnCbLL3W73HxJJrsQ5vYO5NAL0
	BjJhmJ/o5fTEkWViFCTl3PdAPLp8xW1xr90TA9RddJjMCsPGQvVPQatzIWY0B1qWNJPrGUK9
X-Gm-Gg: ASbGncv/4tTo2JXBpaKfO6OeON4+UPnDHC36Uh5NJHITiv/h2DKRTV81HdjTM38tybc
	nZYoGwWzSUQgHguN1WPtxbfdQ+qj0uKrtdWaXqoDaF3L8Yygd2m8zBuLZ4iGyzsOWSpEztq7UpC
	Rjd74Yk/EsncN4kUatLSIg/3SQUEYS+qeqJ9kZIaPegFPqLeFdapseTsbeiZ0qYMM/JN3QYfD1v
	hBExufacauFWY8fqgmAyfE4+9EsZJpCSsRJnYfuSmhtQiY/LUEJ5SKSqo2tAWotwJ/20w9/T6sQ
	3kZWBL3/MEJaj/l2/4RZ3V4pAlxecZ7chp2pzFurQKH2RLd+qLcFqQ1RQaYuN9QEVvbDYOkKj8s
	ItkhkUMUuay84e0eFXhx7AvGTW1SPNEwLN38+1oMqZAiTxSEvJxrhbLR4c9DrJc96glwfLLqrmj
	kut+7WiwDOWPoxiO9aiywQL0wugbqRj5UFtygZmS/cwRviGhU=
X-Google-Smtp-Source: AGHT+IFhVkfAWDwi5/LHnNE07wOWlfLh1gCUAIkwBdq8hu0ThmUzp7xC7QEART8e6tJ9RahOhhS6ng==
X-Received: by 2002:a05:6a20:3c8e:b0:334:8d22:f95d with SMTP id adf61e73a8af0-35bd72f59a8mr1287430637.2.1763105231253;
        Thu, 13 Nov 2025 23:27:11 -0800 (PST)
Received: from SaltyKitkat (160.16.142.119.v6.sakura.ne.jp. [2001:e42:102:1707:160:16:142:119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f42eb0esm3947084a12.13.2025.11.13.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:27:10 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 3/4] btrfs: simplify leaf traversal after path release in btrfs_next_old_leaf()
Date: Fri, 14 Nov 2025 15:24:47 +0800
Message-ID: <20251114072532.13205-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114072532.13205-1-sunk67188@gmail.com>
References: <20251114072532.13205-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After releasing the path in btrfs_next_old_leaf(), we need to re-check the leaf
because a balance operation may have added items or removed the last item. The
original code handled this with two separate conditional blocks, the second
marked with a lengthy comment explaining a "missed case".

Merge these two blocks into a single logical structure that handles both
scenarios more clearly.

Also update the comment to be more concise and accurate, incorporating the
explanation directly into the main block rather than a separate annotation.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a477839cf22c..0ef80f2a2a8b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4858,34 +4858,22 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 
 	nritems = btrfs_header_nritems(path->nodes[0]);
 	/*
-	 * by releasing the path above we dropped all our locks.  A balance
-	 * could have added more items next to the key that used to be
-	 * at the very end of the block.  So, check again here and
-	 * advance the path if there are now more items available.
-	 */
-	if (nritems > 0 && path->slots[0] < nritems - 1) {
-		if (ret == 0)
-			path->slots[0]++;
-		ret = 0;
-		goto done;
-	}
-	/*
-	 * So the above check misses one case:
-	 * - after releasing the path above, someone has removed the item that
-	 *   used to be at the very end of the block, and balance between leafs
-	 *   gets another one with bigger key.offset to replace it.
+	 * By releasing the path above we dropped all our locks.  A balance
+	 * could have happened and
 	 *
-	 * This one should be returned as well, or we can get leaf corruption
-	 * later(esp. in __btrfs_drop_extents()).
+	 * 1. added more items after the previous last item
+	 * 2. deleted the previous last item
 	 *
-	 * And a bit more explanation about this check,
-	 * with ret > 0, the key isn't found, the path points to the slot
-	 * where it should be inserted, so the path->slots[0] item must be the
-	 * bigger one.
+	 * So, check again here and advance the path if there are now more items available.
 	 */
-	if (nritems > 0 && ret > 0 && path->slots[0] == nritems - 1) {
-		ret = 0;
-		goto done;
+	if (nritems > 0 && path->slots[0] <= nritems - 1) {
+		if (ret == 0 && path->slots[0] != nritems - 1) {
+			path->slots[0]++;
+			goto done;
+		} else if (ret > 0) {
+			ret = 0;
+			goto done;
+		}
 	}
 
 	while (level < BTRFS_MAX_LEVEL) {
-- 
2.51.0


