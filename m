Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5C67D71F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjAZVBZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjAZVBX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:23 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC04C6DE
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:13 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j9so2421476qtv.4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+QTAavJpS9U43VEUJKI5UZJNTE7fRPJLg0dzoOIJ8w=;
        b=BVkoGkKKVTIczjjjIe1cWQVhYWFCmRWtNTntR6Sil2hjQ/QhediMDz2mOK8mLKXsLt
         rDyHfgdUVMCaDeSo77zn2eFtWCbIKpv8kj+/6BdKjk1ABv3D2g2Oe3UwelBNL2ZNIEUf
         u0LMQbWS17Ht5pnNELDDKN7XgWZleN20YfoMqV101tkCh0uJ52IRxh3uOJq11RdMLK3U
         TJUhADgu4oD3KzXPTA9WLhgaNm2e/aMxCMwbLb+pxwBmQJFb8rz4UOFwKYUMZpd+IHnz
         hJx4hXUwlOyXIIqtzGrPAbo97+20NVhNF6YQSuxamSmaQWp+aqTGXcVJ4RoOENFgFn4L
         Gdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+QTAavJpS9U43VEUJKI5UZJNTE7fRPJLg0dzoOIJ8w=;
        b=U6JY7ms4vT5TVs/a5MW4NUNmIYWnOnmaKW1BwQpGYgSFi8+Xx0lTlqYewjkTACMh0v
         8yJ2rwblLvrl+goyQXhs4vjjVBSKxfIxM4LyguJ4Fng7cFkTPf3fMvYrfnfn8+H+pUO2
         crozvDr0RKuyQeD6VleELSZuxiCYjoMXpuhEPlp9Vn2b8FoNeFMkRQK0e6ef8s5lWgen
         QUFYclEbB4ZqJXoQg8Z6tbihHk4Zj8P4mFogCdIcWQEd6AYh0J2MmvNnZFDBRS8p020A
         15fUmFQnCnwPQuynnUZBZnA5s2KWEECvwV9cPk1j3SSnJYxn73/b+btEiWp2sMM3SHVS
         1/Kw==
X-Gm-Message-State: AFqh2kqqiXCZ5qzHqJ2Hsp4H0Slnj3tJjthnjqbbpel+MiFopM4OhqoV
        HcbA5B5yhR1bKzT66As2OkvgH8Sz0HZ++xoWfq8=
X-Google-Smtp-Source: AMrXdXssy+RgYfuMsYTtzFaZRwjIeDVlclXGI0zsLCuNCeZ1+VcrzUNILOjspUOry9y6NUfQvrFStg==
X-Received: by 2002:ac8:4b50:0:b0:3b6:8b52:1358 with SMTP id e16-20020ac84b50000000b003b68b521358mr38454593qts.9.1674766872265;
        Thu, 26 Jan 2023 13:01:12 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s39-20020a05622a1aa700b003a7e38055c9sm1405423qtc.63.2023.01.26.13.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 7/7] btrfs: remove btrfs_wait_tree_block_writeback
Date:   Thu, 26 Jan 2023 16:01:00 -0500
Message-Id: <5b5da95a6da7abda53004950ab0e293d99fd3a07.1674766637.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
References: <cover.1674766637.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used in the tree-log code and is a holdover from previous
iterations of extent buffer writeback.  We can simply use
wait_on_extent_buffer_writeback here, and remove
btrfs_wait_tree_block_writeback completely.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 050ae214fb4f..11141a981533 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -278,12 +278,6 @@ void btrfs_end_log_trans(struct btrfs_root *root)
 	}
 }
 
-static void btrfs_wait_tree_block_writeback(struct extent_buffer *buf)
-{
-	filemap_fdatawait_range(buf->pages[0]->mapping,
-			        buf->start, buf->start + buf->len - 1);
-}
-
 /*
  * the walk control struct is used to pass state down the chain when
  * processing the log tree.  The stage field tells us which part
@@ -2637,7 +2631,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				btrfs_tree_lock(next);
 				btrfs_clear_buffer_dirty(trans, next);
-				btrfs_wait_tree_block_writeback(next);
+				wait_on_extent_buffer_writeback(next);
 				btrfs_tree_unlock(next);
 
 				if (trans) {
@@ -2706,7 +2700,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				btrfs_tree_lock(next);
 				btrfs_clear_buffer_dirty(trans, next);
-				btrfs_wait_tree_block_writeback(next);
+				wait_on_extent_buffer_writeback(next);
 				btrfs_tree_unlock(next);
 
 				if (trans) {
@@ -2787,7 +2781,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			btrfs_tree_lock(next);
 			btrfs_clear_buffer_dirty(trans, next);
-			btrfs_wait_tree_block_writeback(next);
+			wait_on_extent_buffer_writeback(next);
 			btrfs_tree_unlock(next);
 
 			if (trans) {
-- 
2.26.3

