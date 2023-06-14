Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6673F72F654
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbjFNH3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjFNH3f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 03:29:35 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0F11BD3
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 00:29:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgxrV6fBZzBQJYn
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 15:29:30 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686727770; x=1689319771; bh=v5CWFfBcMe/rqPjkRkZsB9WF6E9
        Nw+B3pSIn9Cr5M2c=; b=lRXg8NkscEoky/TQTG3kX/EBZZA5TLk5XvrKlZuOCto
        YM9icH23ivN7c6VYRs3jdhAIHCPKNOOxi9VqRnfGmfmYlh87ouXupPm0QYjSc8e/
        uQxhQP1fLdesevpAJZd7oCLcT+rj8fPh+UMfAojE4riv5kooGk0RtAYprhDKAXMS
        bgxgWsicNZPMjbo5zumIkCCuuNNzZwXDtL0IjqOZID3e74r4tNnylHSohn+XgkoU
        iGKHCggjqeaqnu3k5hiYCCtshZF/5kRrTdhqWz2wLJfe9MqChK8+D7SRIJbELKLe
        9fn+idByhlt14H51E43m6bukBQCggEqB4LbbQmLqoZA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S8U0rfUzvvy2 for <linux-btrfs@vger.kernel.org>;
        Wed, 14 Jun 2023 15:29:30 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgxrV3yzVzBJLB3;
        Wed, 14 Jun 2023 15:29:30 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 15:29:30 +0800
From:   baomingtong001@208suo.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: make unpin_extent_cache return void
In-Reply-To: <20230614072710.34392-1-luojianhong@cdjrlc.com>
References: <20230614072710.34392-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <a478eebcb05b6eebc6bab8996641c2ed@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The return value of unpin_extent_cache is always 0,
and its caller does not check its return value.

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  fs/btrfs/extent_map.c | 3 +--
  fs/btrfs/extent_map.h | 2 +-
  2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index f3e9aaeb9956..845994b47998 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -292,7 +292,7 @@ static void try_merge_map(struct extent_map_tree 
*tree, struct extent_map *em)
   * to the generation that actually added the file item to the inode so 
we know
   * we need to sync this extent when we call fsync().
   */
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 
len,
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 
len,
                 u64 gen)
  {
      struct extent_map *em;
@@ -326,7 +326,6 @@ int unpin_extent_cache(struct extent_map_tree *tree, 
u64 start, u64 len,
      free_extent_map(em);
  out:
      write_unlock(&tree->lock);
-    return 0;

  }

diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 35d27c756e08..486a8ea798c7 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -97,7 +97,7 @@ struct extent_map *alloc_extent_map(void);
  void free_extent_map(struct extent_map *em);
  int __init extent_map_init(void);
  void __cold extent_map_exit(void);
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 
len, u64 gen);
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 
len, u64 gen);
  void clear_em_logging(struct extent_map_tree *tree, struct extent_map 
*em);
  struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
                       u64 start, u64 len);
