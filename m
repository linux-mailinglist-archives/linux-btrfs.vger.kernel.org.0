Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B5798B60
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbjIHRUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbjIHRUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6901FD5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E55C433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193646;
        bh=0NQR0PFuMgzDjpJKs1IOmYS7XDZV+BTPRN8OFVvCerU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OjO7DsxEliXZGQfSJdrL3GqGHOrR1PLdDkXkDxsq8QhtsWpK76AjBHpDdI0vD8J6L
         m9JqeM5l5njMypbW8e8/S3+jD8d4Xbzk61o5c6ZhLA6wwTmG9qYOfFaSzQPKv8s3zO
         re3eZdQ+Zar5D8XT3FDA+dgagFB6Wjo/CQfixS6xOD9wMCuAzshQD2x1ObQlilwZy2
         bQaN7W7EL1qOS/JIb8aCMqGT4lOu1uLgkf8N3PwJXQYQbNAxLOk/it3TveUgTCxdg9
         8fUEO15kPAIL8ebdfD/9iSM7chZ5ia0drHADxPoCXTHUm7euVZHysKnRZY2vEhMkfi
         ggJ4GFpxuSlIw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/21] btrfs: remove the refcount warning/check at btrfs_put_delayed_ref()
Date:   Fri,  8 Sep 2023 18:20:22 +0100
Message-Id: <3d8c3c336dbda73eeb118f1ecc9cee796a1eaf28.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_put_delayed_ref(), it's pointless to have a WARN_ON() to check if
the refcount of the delayed ref is zero. Such check is already done by the
refcount_t module and refcount_dec_and_test(), which loudly complains if
we try to decrement a reference count that is currently 0.

The WARN_ON() dates back to the time when used a regular atomic_t type
for the reference counter, before we switched to the refcount_t type.
The main goal of the refcount_t type/module is precisely to catch such
types of bugs and loudly complain if they happen.

This also reduces a bit the module's text size.
Before this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1612483	 167145	  16864	1796492	 1b698c	fs/btrfs/btrfs.ko

After this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1612371	 167073	  16864	1796308	 1b68d4	fs/btrfs/btrfs.ko

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index fd9bf2b709c0..46a1421cd99d 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -338,7 +338,6 @@ btrfs_free_delayed_extent_op(struct btrfs_delayed_extent_op *op)
 
 static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
 {
-	WARN_ON(refcount_read(&ref->refs) == 0);
 	if (refcount_dec_and_test(&ref->refs)) {
 		WARN_ON(!RB_EMPTY_NODE(&ref->ref_node));
 		switch (ref->type) {
-- 
2.40.1

