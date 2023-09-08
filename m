Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B17986C7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbjIHMJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjIHMJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF041BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4ADC433CD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174972;
        bh=g4IN8hTod7NDwJC7H55Jx+a6egC01OH6fqCkgOCIreM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QFhKxLZ3wcyCYVWAIHgSJjYKzrR6NsNjjK9HzJpBgTsOlZ/xBHUE6R5khtRR5ngCs
         qAzjVgwQWE6aeNKMBD2bWZv95UY/HKKtZw5FiiynhyxYIISB9SjA+pIxLH+Llm3KgY
         C8RQQBg1umrMrSjf1bvliWY4E9vPwUYM4hO6ksvePnXzIHjkJPm2Iba2x4SXRxGcnZ
         /q4KID0iDWxcm8cQLPgIWcLUOCl8vYvybkSXomrP+49rqonakJTLL4YDbSrJ5DF9tm
         tSER7IzEYPD/ZIF4FGZ1hcLJiOxIVZQlpafNZkkehMduFat5uB38oRQZfVmeeSYA5F
         nJrhNdsmGstUg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/21] btrfs: remove the refcount warning/check at btrfs_put_delayed_ref()
Date:   Fri,  8 Sep 2023 13:09:07 +0100
Message-Id: <d67dc2650159fbcbe0cafc5bb9ab390aa985ce11.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
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

