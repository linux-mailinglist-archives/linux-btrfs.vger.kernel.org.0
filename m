Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367A418D714
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCTSeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 14:34:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41622 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCTSep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 14:34:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id i3so1968816qtv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5adH6MggDAH55cINMwdcWIGtFjcV/w8PAQJMxEIYmNA=;
        b=MEulx42YKSkCa/dNOwGZayebaI/N0iLkORvsKQqKT9kTRQNQWmlhcl6aE31YqVczaV
         TrEYvXXpxXjJhGLW/OIAzGyzHEYyGnf82lbo5mC+1CUfKtdGcb5B7yOaw6lruUeV/Qzk
         112xwSJO3x/CU2Lux8e6Za3G4k9hqv81R6v8HY3Il/HuFiZRU8Mu2HjTanId1fzIYVfV
         wGI2U8tNNISQdNWQh1Pli4FGNprbwOof2T+DVb7VCECgMxYg4dnvQkHiwh2qeoaa3oA4
         CnqtXp4vYvV32h2ZqZlc/ErXFbYWeW9qkanqqOqjQcwEDzuMDVaIgAnP6QA4GLCeYIHO
         X5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5adH6MggDAH55cINMwdcWIGtFjcV/w8PAQJMxEIYmNA=;
        b=VkMGdhtlmOfZwZvXJrmzykeRS7h1x6cqES+qhL43oj8jxJ8nMPEqQCtr9bjgJi5AlD
         wcCsUYiErJMtEnPPv/IOTTQ7zneJKyDkc9qYV36jXdTLpU+KINn8kt82zc2pIL+pwqyF
         gKm7yBPx+Jn6YNAPB6xEVhMpgnZA4ufUeIbut5/AyLV51Lp6yatfxYqmhPP2mnhu34cP
         zTTMHUftQfq/wBMNWVeM3evD/xPRg/p5zJ/tFoXc2DAOn3S9VvbtFjrSCTxajA33orCP
         tqDRg/CCosihMY/MMp2mekjDqJAhuGecZt84zWJD9frF+GYxO4xbGZBvv4phZkjQJ9Cr
         Tlpw==
X-Gm-Message-State: ANhLgQ3WjttvvyuQ5+PzBCpd+nnCC+YUPlV3IFM4ZaVEU2n8Ntp6pBII
        EXQSXr6BE/Z56vs5CGX6e3CEwkspLbk1SQ==
X-Google-Smtp-Source: ADFU+vtxSpL49m5iXVewsf4oNCkLJEnDsOSHSoOSJ3QP3Fb7vjlwX1VOJTOd3lX/rSNVC9YFuPNkZA==
X-Received: by 2002:ac8:3f62:: with SMTP id w31mr9514048qtk.171.1584729283771;
        Fri, 20 Mar 2020 11:34:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z18sm5537216qtz.77.2020.03.20.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:34:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: restart relocate_tree_blocks properly
Date:   Fri, 20 Mar 2020 14:34:33 -0400
Message-Id: <20200320183436.16908-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320183436.16908-1-josef@toxicpanda.com>
References: <20200320183436.16908-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two bugs here, but fixing them independently would just result
in pain if you happened to bisect between the two patches.

First is how we handle the -EAGAIN from relocate_tree_block().  We don't
set error, unless we happen to be the first node, which makes 0 sense, I
have no idea what the code was trying to accomplish here.

We in fact _do_ want err set here so that we know we need to restart in
relocate_block_group().  Also we need finish_pending_nodes() to not
actually call link_to_upper(), because we didn't actually relocate the
block.

And then if we do get -EAGAIN we do not want to set our backref cache
last_trans to the one before ours.  This would force us to update our
backref cache if we didn't cross trans id's, which would mean we'd have
some nodes updated to their new_bytenr, but still able to find their old
bytenr because we're searching the same commit root as the last time we
went through relocate_tree_blocks.

Fixing these two things keeps us from panicing when we start breaking
out of relocate_tree_blocks() either for delayed ref flushing or enospc.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index df33649c592c..66a344df4f05 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3226,9 +3226,8 @@ int relocate_tree_blocks(struct btrfs_trans_handle *trans,
 		ret = relocate_tree_block(trans, rc, node, &block->key,
 					  path);
 		if (ret < 0) {
-			if (ret != -EAGAIN || &block->rb_node == rb_first(blocks))
-				err = ret;
-			goto out;
+			err = ret;
+			break;
 		}
 	}
 out:
@@ -4204,12 +4203,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		if (!RB_EMPTY_ROOT(&blocks)) {
 			ret = relocate_tree_blocks(trans, rc, &blocks);
 			if (ret < 0) {
-				/*
-				 * if we fail to relocate tree blocks, force to update
-				 * backref cache when committing transaction.
-				 */
-				rc->backref_cache.last_trans = trans->transid - 1;
-
 				if (ret != -EAGAIN) {
 					err = ret;
 					break;
-- 
2.24.1

