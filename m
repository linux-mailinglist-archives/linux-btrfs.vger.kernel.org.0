Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B82D2F8C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgLHQ0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgLHQ0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:05 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EDEC0619DE
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:21 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id w79so5387222qkb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+LR/EgxO8kjgzxcJtus24AZos3z4J2yhdfKJsApHJ3M=;
        b=wUxlpcnynRaUKV/3+JQrBh0bDBrsnHGgOu1uK4yPLtQyRuz6LDNZtcpyZRGm27FKPS
         w7ROUXDLK7qjy5GjwYs6c7IoWjPo/wdlb8xKm+Jmmg4DPyF2hEHqqytNGBm4kLuHTG64
         6XVDsXmLdGorn8LZrqf8Ow1YKnbz38hHgMBKU9EHsIE6aBRzUwkSwLNIH7wt8VIHNHzy
         UTUJXumHR4hHkvGx2PMYIoApD/BDIOOKAXNZmba9ozEoznkjLryalxqDG0h4L7iydlR6
         ngSXTwvteDV09dKQ6v7kKlDefZhCQBN2RuKShSJfOHL3zWtZmsV4N6PQSXjrb4VjfUW2
         LkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+LR/EgxO8kjgzxcJtus24AZos3z4J2yhdfKJsApHJ3M=;
        b=CGT7nhlDeadp/0JSD1/aymZw77f9fyhzOCXaFdIM924px5maUnbXCaZU7SAnBAPZhZ
         9A9Rv2hBxhtAbHof1yfJ6Nt4on9couI3APVLpUqTQ1aEOgPkAX/8bWox5FOvg6ZqVKpj
         Mcj6ebmyXypi47pSFDxF84avgLFzwWgsghaZXjnhQpY9T5Tqa+e+VoXMl1DAOUr7H8UY
         pra+QFxas7TcHoMZz5XH/p1WIpRaTg0UqJsz42pkRXCpLbrwmOvVZJRUar12suSvLKi7
         8iiHKGRUgaxMutILfRbxe6+08alenHtBQRahcQ7usOrJN7fLk11ccaGxzMlSb4s8ySBz
         h9Cg==
X-Gm-Message-State: AOAM5303PU5c7X5iJ/1ikJlajp8lPrY7T13W62nIpY2ZozMML9ZpKD6T
        ffL4K1sND3BUGrylV8Q2xfAW2l6pEMV43LA0
X-Google-Smtp-Source: ABdhPJyAl6mBy6TVnUnPQxt9SAPt8IKXgs2GS/ZOfVfUTn4IGvLeVAd8qCXXX9D41GRWAwTrwVmuxA==
X-Received: by 2002:a05:620a:13ea:: with SMTP id h10mr19459897qkl.125.1607444720430;
        Tue, 08 Dec 2020 08:25:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y35sm15819004qty.58.2020.12.08.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 36/52] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Tue,  8 Dec 2020 11:23:43 -0500
Message-Id: <5a7133ad782b52bc2798107df24cf5d7a8c41329.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index 49caecd897d4..1f1dfa9c74be 100644
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

