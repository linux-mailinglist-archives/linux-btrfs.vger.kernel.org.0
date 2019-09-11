Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D17AFFF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfIKP0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 11:26:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38465 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfIKP0X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id x5so21179263qkh.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RdMFM5EyLGo6ACskPGKsm1c2Ep25VwRVdtwJosf3JeU=;
        b=TnHvF1EIdfsjQILIuXoCtocbJdg2SZo8pmfb61qDAiPWbLnC+rKc2R7UR7IimfOHHG
         3hx3ND+v9XqoJQJ3sqbGOxYJpKJhmTyO3oIaK3xbsgAhFB25RoNX7yS1Lyqcc4mLJ/bR
         L1R6gzg4vdkvgokn7TIkuEPxv3pzHt0CBISjq6+FoDVtA4PNPlvoHCGVEIMee1x/Qzlr
         VejwDOhcpxVJY1GQ/yEj51MmawS61o/9bFj/sVqqAGGchAUA01nBE0JgHjR3iwpCan9t
         fr7fUJcWiNGnKiKtyULxwL2XDEqV16vNQc71HzETHY7pYafr/T227Eci6hrl0QrFHaUZ
         Wakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdMFM5EyLGo6ACskPGKsm1c2Ep25VwRVdtwJosf3JeU=;
        b=gIAn2AJPZQvZ7ZcBXRgxcMdx09Kqg12/UWpsZ6TzgeHd1rS+K6AeC6EVSU/jgmpHNW
         sdxb4gq4AO5c/spgMCLVSNetl0Gt4Fd/kTB7d2Nq3ZOS5bzx04q7YOcBfb57dZjeHGQ3
         bOPdXvE7Rwlg2IxIX8mgebik7kjyJqYmPyoqG969i9KroJSEHYeoHJaZEZq9riV7L5fJ
         efDWNQcONsfaYmriXkVlD9x1agry+QwGARGEHHFovUNXhR7m7UMo4pf28KjFO8wmb3b4
         YBi6d1H5eSlv7o6Z48TfZZRrxidW74QPZ8753aEKvofmR+51uQy5GW6FQ7EZgd7cpkx3
         Bbjg==
X-Gm-Message-State: APjAAAVVzwzY1Jmi4Pj+VIp51XH01xwq/blLfAGIN2jyYKIHAGcAonPW
        HZRU5pCSQIsucSL8nxJUK9o0ddeQ3328vg==
X-Google-Smtp-Source: APXvYqyKNE798AMtvf8/AMJRlQXOXnKVLW0rQaAmmJAWmu3S347px1BitGXu1oAdkB6vM8gktLPVjw==
X-Received: by 2002:a05:620a:40f:: with SMTP id 15mr34986566qkp.274.1568215581707;
        Wed, 11 Sep 2019 08:26:21 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 29sm11582848qkp.86.2019.09.11.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 08:26:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: export find_delalloc_range
Date:   Wed, 11 Sep 2019 11:26:06 -0400
Message-Id: <20190911152611.3393-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911152611.3393-1-josef@toxicpanda.com>
References: <20190911152611.3393-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This utilizes internal stuff to the extent_io_tree, so we need to export
it before we move it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h | 2 ++
 fs/btrfs/extent_io.c      | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6f53387445ca..1c301681babe 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -223,5 +223,7 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, unsigned bits);
 int extent_invalidatepage(struct extent_io_tree *tree,
 			  struct page *page, unsigned long offset);
+bool find_delalloc_range(struct extent_io_tree *tree, u64 *start, u64 *end,
+			 u64 max_bytes, struct extent_state **cached_state);
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f5945f0a06da..751353c88203 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1687,9 +1687,8 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
  *
  * true is returned if we find something, false if nothing was in the tree
  */
-static noinline bool find_delalloc_range(struct extent_io_tree *tree,
-					u64 *start, u64 *end, u64 max_bytes,
-					struct extent_state **cached_state)
+bool find_delalloc_range(struct extent_io_tree *tree, u64 *start, u64 *end,
+			 u64 max_bytes, struct extent_state **cached_state)
 {
 	struct rb_node *node;
 	struct extent_state *state;
-- 
2.21.0

