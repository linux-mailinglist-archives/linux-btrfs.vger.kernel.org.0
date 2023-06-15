Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C037316FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbjFOLjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 07:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjFOLim (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 07:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E92967;
        Thu, 15 Jun 2023 04:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED4F63948;
        Thu, 15 Jun 2023 11:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46538C433CB;
        Thu, 15 Jun 2023 11:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829084;
        bh=wt89E2zvd//pr6N38PwZsdGNGiF/Mbbhvn6+II2neb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFNA74QQ65QpvYcIeSKAsNQmM3PImjHGXvGjX+fwHW7QKkUuDiPw9PlUFY3ezubhl
         Jw56CAWIMkBZelAJc++2MsILk87qhXqygIjqaVd/DaWBEvkx+fxBG0zXpxAbEpk2vK
         cGGzpVoC/Ic86YMbXZ16wgbVo93HND4WV/OIilTkqDjTjuUJ/37B7vfF0o2eZFVpGR
         bG+CFtow2hzz5nGMTgWSwA/gdlXdgCi1mxiraC+cZp+RNhmWl7wNgRLdkU0sdajJwG
         XU8vvL7cNd7z2fuqLQa1LLb//AwEDz0ReWXd8uFN0toZC4GWKJDKJd5akJksklKTtz
         8P5NpG6xhjQ+w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shida Zhang <zhangshida@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 13/19] btrfs: fix an uninitialized variable warning in btrfs_log_inode
Date:   Thu, 15 Jun 2023 07:37:13 -0400
Message-Id: <20230615113719.648862-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113719.648862-1-sashal@kernel.org>
References: <20230615113719.648862-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

[ Upstream commit 8fd9f4232d8152c650fd15127f533a0f6d0a4b2b ]

This fixes the following warning reported by gcc 10.2.1 under x86_64:

../fs/btrfs/tree-log.c: In function ‘btrfs_log_inode’:
../fs/btrfs/tree-log.c:6211:9: error: ‘last_range_start’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 6212 |       first_dir_index, last_dir_index);
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../fs/btrfs/tree-log.c:6161:6: note: ‘last_range_start’ was declared here
 6161 |  u64 last_range_start;
      |      ^~~~~~~~~~~~~~~~

This might be a false positive fixed in later compiler versions but we
want to have it fixed.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 200cea6e49e51..b91fa398b8141 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6163,7 +6163,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *log = inode->root->log_root;
 	const struct btrfs_delayed_item *curr;
-	u64 last_range_start;
+	u64 last_range_start = 0;
 	u64 last_range_end = 0;
 	struct btrfs_key key;
 
-- 
2.39.2

