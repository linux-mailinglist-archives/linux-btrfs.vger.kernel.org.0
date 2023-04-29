Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F46F2633
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjD2UHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjD2UHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:34 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE71A8
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:32 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-559f1819c5dso6576517b3.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798851; x=1685390851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aSmFHZ4x981jc/aRz86iFY60O70iUdZ9L2e7nsJuh4=;
        b=wBsLgYwur74cSZ3YPWdHPYzxtKBAHE2WnrWSLUZKmMnyORwany2ak1VK184wrhgYUP
         ExC5k19d1/gKIOo7mxiSoR9JEcCPA8Wmwg70G60LZz6zDlX4hVQ0oVY3SXGQkvMbTuZU
         HhkeQaoj0fF96qQlu0b0fbeAZ0UelDcedhU8hrMEu5Ta2V88w0WQlvKTvyy3k3WrnD3s
         zLteljjN1uMCF6ir7RrMJ2NY7q9stfso+iOV2wQ6wKHHY7g6jEXghJ+phgrraVpbqNHa
         H4Gik1dbs1clqhK/zlMHHW3/25l3qPAUPXefrLK2hO334u/WcGn9ryHaygawQdOMTKlY
         rayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798851; x=1685390851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aSmFHZ4x981jc/aRz86iFY60O70iUdZ9L2e7nsJuh4=;
        b=A4lqVrUBAW5lNmqWyoKtYfpfsu5pjNGBqzJyY8NTemof39B7wzGoChb3FKuVeFLoYc
         0NbE1IrqMWZbSf0EUKFUSEeAJHJEiksLq21brf4sIfFgSEdSWcblzUQ5al37D79cgQt1
         LzejC5m8hlqRjLjGTZXy8YZlN3THtbOUpBDjYJIFZkujBTb+kP2eOweW0bdEHl5jRr5g
         jpIXel4bUTy/gSnRFJAZiyOpp27AUKKf1fZwDLxZZ4SG4tZ+MUwmJRIOMIpiZfS7ojZb
         Zl/BzkOspNtDg5PgPRnW5VzK7iQg71kF7IpBdAKVna3HHuKWwV7j5i5Tp7rtV4vbGYDS
         Fqew==
X-Gm-Message-State: AC+VfDzGWWstVuWSGcWx/C4PNALFXtIokA5KtQkWNrJGNbMDCQnP1J3N
        tkbP4CcDTRSCKrWaVtgTxDS6U91H/uDE2B9Xr/IZuQ==
X-Google-Smtp-Source: ACHHUZ631mGwnAj072QM43gFwQTojXwY/ZzczuUF90F77rP++SqIwQtEe34hKMZ3PL9kgo8BkKZW+w==
X-Received: by 2002:a81:4ed6:0:b0:54f:b112:7680 with SMTP id c205-20020a814ed6000000b0054fb1127680mr7677209ywb.41.1682798851389;
        Sat, 29 Apr 2023 13:07:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h196-20020a816ccd000000b0055a00e6542asm212995ywc.9.2023.04.29.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/12] btrfs: remove level argument from btrfs_set_block_flags
Date:   Sat, 29 Apr 2023 16:07:11 -0400
Message-Id: <64d597ef424891ea0f3af9cdbc3284cd222302eb.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We just pass in btrfs_header_level(eb) for the level, and we're passing
in the eb already, so simply get the level from the eb inside of
btrfs_set_block_flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       | 5 +----
 fs/btrfs/extent-tree.c | 7 +++----
 fs/btrfs/extent-tree.h | 2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2ff2961b1183..7071f90c23e3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -464,10 +464,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 				return ret;
 		}
 		if (new_flags != 0) {
-			int level = btrfs_header_level(buf);
-
-			ret = btrfs_set_disk_extent_flags(trans, buf,
-							  new_flags, level);
+			ret = btrfs_set_disk_extent_flags(trans, buf, new_flags);
 			if (ret)
 				return ret;
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5cd289de4e92..df8181ccb57b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2155,10 +2155,10 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				struct extent_buffer *eb, u64 flags,
-				int level)
+				struct extent_buffer *eb, u64 flags)
 {
 	struct btrfs_delayed_extent_op *extent_op;
+	int level = btrfs_header_level(eb);
 	int ret;
 
 	extent_op = btrfs_alloc_delayed_extent_op();
@@ -5102,8 +5102,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
 		BUG_ON(ret); /* -ENOMEM */
-		ret = btrfs_set_disk_extent_flags(trans, eb, flag,
-						  btrfs_header_level(eb));
+		ret = btrfs_set_disk_extent_flags(trans, eb, flag);
 		BUG_ON(ret); /* -ENOMEM */
 		wc->flags[level] |= flag;
 	}
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 0c958fc1b3b8..429d5c570061 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -141,7 +141,7 @@ int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int full_backref);
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				struct extent_buffer *eb, u64 flags, int level);
+				struct extent_buffer *eb, u64 flags);
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
-- 
2.40.0

