Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372B37BEBE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjJIUpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJIUo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 16:44:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D2792;
        Mon,  9 Oct 2023 13:44:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46609C433C8;
        Mon,  9 Oct 2023 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696884298;
        bh=xqPPlteo+/irwg1A8Nmsg7I8TpquWpmsFmUvKGKyQHo=;
        h=Date:From:To:Cc:Subject:From;
        b=ZEZGlqkuZvJF2yg5oonzytBzx9hYOgBwyLTgVN0/S7cA1HKqyN7f84BevW/PYUGjZ
         jm+fg16/Eoqtk5lixQKPZ1rb3J4iK1kAHnHvdi6G8QezxsgYveuaxfWqx9OwnvqiYI
         aQGXJ8B+DRU9+0zi2Aa/G//zaR+6hzBdIZbsqevBzeBgCWE4h56/16MJHw8z5LqO4X
         QdyEhvT8Fg/n9I4q5cLU0fSwzw6sJPWRc+vpRkqjLl1uZlLzMwCibT1ZPvklAcmTsi
         D+u7jNb0ZgmaruYQcPbHlVcReX40dDp2VQhJFJZ5dRN47OZdKB7m6AVVbOvRw5shLm
         qKhW28wJqYPSQ==
Date:   Mon, 9 Oct 2023 14:44:54 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] btrfs: Add __counted_by for struct btrfs_delayed_item
 and use struct_size()
Message-ID: <ZSRmRj7leOsdUmJm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/btrfs/delayed-inode.c | 2 +-
 fs/btrfs/delayed-inode.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 35d7616615c1..4f364e242341 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -313,7 +313,7 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
 {
 	struct btrfs_delayed_item *item;
 
-	item = kmalloc(sizeof(*item) + data_len, GFP_NOFS);
+	item = kmalloc(struct_size(item, data, data_len), GFP_NOFS);
 	if (item) {
 		item->data_len = data_len;
 		item->type = type;
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index d050e572c7f9..5cceb31bbd16 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -95,7 +95,7 @@ struct btrfs_delayed_item {
 	bool logged;
 	/* The maximum leaf size is 64K, so u16 is more than enough. */
 	u16 data_len;
-	char data[];
+	char data[] __counted_by(data_len);
 };
 
 static inline void btrfs_init_delayed_root(
-- 
2.34.1

