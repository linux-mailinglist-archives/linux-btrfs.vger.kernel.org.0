Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE448446A03
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhKEUtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhKEUsz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFACEC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bm28so9873434qkb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O6Js92v4mWwWzxhWJTuiturFVEFfGsnUr+zndkZZRFM=;
        b=jY5ON/G/rqC6oNZeX9NErxbhAavhSZ0kL1k5MIStIqfpmqkUh9Jtbl9bMxxE1+FWc4
         XQ+jjj1VSSA/1iZnU9vRov/RrjVimAyiU8OOQFosWHFJfk5VZ/XS+vcW02yDIyY6PGSL
         goXcOjtBWevm/6iCkYcXcQbJsm55TcTa2TFi07HqNH2F5PPVGNhdjh2hyHKhi6DXtQu5
         00C4ROMBKNUhZYB8gCRVDXGdtaSzjXKuUCPuDRnqeMWpwD2vu3Vky7WTbzK7FhgfdzmB
         lViJb/M2VCgZdISLz2mfrjmtsYlYF+1K1Cu5TchM2NDEOtzH18nL7/FmkoksYU1LABaF
         0S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6Js92v4mWwWzxhWJTuiturFVEFfGsnUr+zndkZZRFM=;
        b=DJ4wLGMDpnYjIA4QuzjkDV47nVgalfxKrkUIo1CmzHwLKTdd93Myfu8Z4T7C66BDWQ
         B/JWtExgfQan96qUHRWrvZIbBV/mnURxB/ldEEowSvYxJWdIY2ugkb+LExx20VLZz02Y
         Mg5sI+NRN+PqVXz7fxm0cpVhVxNeka5T7o9B1OYb155cROte0YsjDmAujT/Ebn3nOGZN
         h+2K5HwODyLW0BceVg+2UizAZVaq7wERzA4EZSIy5T0OhkPehbUEZNlRt6pMFXoK5KHf
         AMrHXF9yxTtMEXP6G/LDTRlbFeaVzj96iuCKJ3bcFhckzxCC/xEVTl8MRjwSror0JAqo
         O4jw==
X-Gm-Message-State: AOAM530RiSVO05R886dag7NZAnRT7zqKLV8MxUZi8nWfMteRfQGj1GMx
        fIuhIKSxqgj3Z5HnNuOsbYRoRl0LGlzxIQ==
X-Google-Smtp-Source: ABdhPJwgyzQH4++0kV4x738Vl7/YzZdGpXSH80wCpiokmTebIJlVK49xxdTTmy+bY+mtgrlXO70dGA==
X-Received: by 2002:a05:620a:1317:: with SMTP id o23mr2516186qkj.189.1636145173823;
        Fri, 05 Nov 2021 13:46:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m68sm5961656qkb.105.2021.11.05.13.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/25] btrfs: don't use the extent root in btrfs_chunk_alloc_add_chunk_item
Date:   Fri,  5 Nov 2021 16:45:41 -0400
Message-Id: <5727e025cd94712c10decf691db251d935a128ed.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're just using the extent_root to set the chunk owner to
root_key->objectid, which is BTRFS_EXTENT_TREE_OBJECTID, so use that
directly instead of using the root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 546bf1146b2d..85842eb1f7b1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5502,7 +5502,6 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_root *chunk_root = fs_info->chunk_root;
 	struct btrfs_key key;
 	struct btrfs_chunk *chunk;
@@ -5574,7 +5573,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_set_stack_chunk_length(chunk, bg->length);
-	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
+	btrfs_set_stack_chunk_owner(chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_stack_chunk_stripe_len(chunk, map->stripe_len);
 	btrfs_set_stack_chunk_type(chunk, map->type);
 	btrfs_set_stack_chunk_num_stripes(chunk, map->num_stripes);
-- 
2.26.3

