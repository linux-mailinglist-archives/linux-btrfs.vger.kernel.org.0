Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2A1850DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCMVRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:17:18 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42590 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMVRS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:17:18 -0400
Received: by mail-qv1-f65.google.com with SMTP id ca9so5435650qvb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5adH6MggDAH55cINMwdcWIGtFjcV/w8PAQJMxEIYmNA=;
        b=HS7pMZs8FXYx2G42a1Y2oaMtTr6ct4KOfbY2aIYzgpx94pteMivi5sM5jmpMbLESng
         KVtFF/IfYlx7LAJmW3BHUhiYn/TfeqdTVu0vRDn5ATlULjwjFV0znzxea62NNg+Jj6Wg
         w5oA/GAlluJvLgFzTt7g8U5iBEFabzcaO17NorpsxSDyHFb0+vWyQas63g8zfB5436Ev
         pRZ5moPA/rRM0z00DLFVPFT2BMWBA+0d4dCDTGNPZFH0EkyL7WNjpqdiJ4jB2XMN+Wrf
         9fsG0LKnpyjMvYKsXX0ijkGTfXbdbtEgFHgUiLaFE7oWm/jZM583A6dOsqRimhtQf8B9
         2jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5adH6MggDAH55cINMwdcWIGtFjcV/w8PAQJMxEIYmNA=;
        b=mVV7UccFiYV2Zt6b35/UuuxfDSQ74oY9LsjyOwaLq+TqFSwatt5TspkguCa+a5W+aS
         soBxQEDbSMGpTTHvjMr5IsQtbU9cmp4bfGC5wJV807VTpOx+vP4sDQM96E+lt1bnW82j
         RPHmHN3voiypkb5ehnqNoVEPDjCVJL2eug0m/i7LMQ8QxXukY8PnE3Dfq4UsKAiqplvP
         oq88dIDAgMLVrHoP1fc1UDz1HWxU96BzYnuIaozygvNvf4IjaEaXlL1yekPCf5NlEr3Y
         A6USiCIdU45GuBOxvGI6/J3GvWx5WVCR6RdnLQDkKREMkwKMgQ1570F+y6xLGD+EqfyO
         6mEg==
X-Gm-Message-State: ANhLgQ1IXYaWXfPJOw7ZZnFhyYnuduWzQ14zFgVwp+P4X2B5nK9bWACn
        NdKybf2pbwtxqjMRqqdD4e4/8Ke/i0d0aA==
X-Google-Smtp-Source: ADFU+vsgO5iZwHoDkk9UpWN+vtlzsoghazTgPl6lFMTtLrHvGYyD8/o7DqukahWn2bqFOM0bbz6IEA==
X-Received: by 2002:a05:6214:1351:: with SMTP id b17mr14697308qvw.251.1584134235517;
        Fri, 13 Mar 2020 14:17:15 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m65sm10282659qke.109.2020.03.13.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:17:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: restart relocate_tree_blocks properly
Date:   Fri, 13 Mar 2020 17:17:07 -0400
Message-Id: <20200313211709.148967-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211709.148967-1-josef@toxicpanda.com>
References: <20200313211709.148967-1-josef@toxicpanda.com>
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

