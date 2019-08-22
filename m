Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4F99F85
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391670AbfHVTLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42282 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391583AbfHVTLW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so8948055qtp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=REZjaWdYz4cAnlPWw0OHqoelYEM3w54t+UYa94PyMJU=;
        b=HBWnAYr4IV/3krFvnBBw81RULBqkT2SvQ+8BNiH34+USmH1bOx9qLozhZe86gZHWwx
         v/8MvJLYM7Rlg5wJQZfQLUmhQgXtW+O3UDoUI4Zv8GsTTxJj2cYmo91QB7FbqS28qdS7
         csinF4uLduCfbv/8y6/50c+LuPQC2zBtSBTyqPSNgKQg+THeieXtGeY3Gy+1AO4o1tuu
         6jYs5c0OnUctvnfsfs+m+I7kq8QRlMdRPhGC6oZQ2Q9KaAkfvS4kU2kXdFzvJIzNaivh
         56pLr908nvl8D4/kcHCUA00jZmAqLbKvc+vYTGZQ8oPTS7lv7Ba4zw5BpN6fw0U1Aehr
         /Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REZjaWdYz4cAnlPWw0OHqoelYEM3w54t+UYa94PyMJU=;
        b=tNnYSrZoJkz5kkCL1toOTJpwUkca24LOpRJzBqjeUEq5ySN3p8seUNCwPd7muKABf+
         9PZb/8H5W2MKL36d37tHGbpTnMdRMDFBLR2fVpjz4zSmL0JG44amCZ0jgFomwy3LXfIg
         W2h/ZXDB14xIx9EXT09kQ7aJN+Rndcpv0vVWhH/0yCo+VZNXv5Z341icjfPwDBByPXDW
         D5+yh2HIujAG6MrCg9nR1Mo+5M3C9N73Qar85sjOKUrhOALMe9imqyOUGeX473mtkTpp
         GRHs3tKOSwGccSn/Z3B0x2FgOOmKbCLxLRDNTFwAxYxWtY9hmvBpJrROOnvN38eA0QKq
         e3Jg==
X-Gm-Message-State: APjAAAUQgGIdb3sX6FGElywX6yfpWmA2bbeqNBLr18jUXV9AM3+xmAfn
        1lOR76yPfuxh2Q3iPpB26x8/ZA==
X-Google-Smtp-Source: APXvYqyAs2FxLMExcQ08YfmuYyTKuyPhGIzvHBStgesb3Bxd0ZGNyWHYfV+4nu30YH2FhUpKqPzYTg==
X-Received: by 2002:ad4:41c2:: with SMTP id a2mr852442qvq.224.1566501080856;
        Thu, 22 Aug 2019 12:11:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z1sm338160qkg.103.2019.08.22.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: rename btrfs_space_info_add_old_bytes
Date:   Thu, 22 Aug 2019 15:11:02 -0400
Message-Id: <20190822191102.13732-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This name doesn't really fit with how the space reservation stuff works
now, rename it to btrfs_space_info_free_bytes_may_use so it's clear what
the function is doing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c   | 5 +++--
 fs/btrfs/delayed-ref.c | 2 +-
 fs/btrfs/space-info.h  | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index c64b460a4301..60f313888a7d 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -54,8 +54,9 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 			spin_unlock(&dest->lock);
 		}
 		if (num_bytes)
-			btrfs_space_info_add_old_bytes(fs_info, space_info,
-						       num_bytes);
+			btrfs_space_info_free_bytes_may_use(fs_info,
+							    space_info,
+							    num_bytes);
 	}
 	if (qgroup_to_release_ret)
 		*qgroup_to_release_ret = qgroup_to_release;
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 9a91d1eb0af4..3822edbf54a7 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -158,7 +158,7 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
 					      0, num_bytes, 1);
 	if (to_free)
-		btrfs_space_info_add_old_bytes(fs_info,
+		btrfs_space_info_free_bytes_may_use(fs_info,
 				delayed_refs_rsv->space_info, to_free);
 }
 
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index d61550f06c94..c93fe9808dc0 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -130,9 +130,9 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info);
 
 static inline void
-btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
-			       struct btrfs_space_info *space_info,
-			       u64 num_bytes)
+btrfs_space_info_free_bytes_may_use(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 num_bytes)
 {
 	spin_lock(&space_info->lock);
 	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
-- 
2.21.0

