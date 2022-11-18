Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0DF62FE89
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 21:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiKRUGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 15:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKRUGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 15:06:13 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965115F88
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 12:06:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l2so3836134qtq.11
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 12:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTHpyfnzknUuvpIDKfPOnypacMMGO1NnHWNZ5npNuAc=;
        b=yUNyqdOmaM63q9hTTCFxciS96dGDae2uF03n3Z+dIZx/9P+8bg4Bnr2oUvq8X5VHu6
         tEw9LkQf28bmEeid2NUVS9z1zuqpECWl2QifDdTtBx8cvEnCIOqun3OZnww+y98MbI6U
         bmujo+m5pq8eTngR20yc5LZklja9vstyfz0Zc9qiITgRGzzZ7qPR991ljDiswzJ9p0xQ
         zS2qEUyejYI+QUoy7AR4WgrwVUScawCzzQC7BKnfWU11Nu3OFD1P2Ratje3DItSG4vQH
         VptYdyvJV5DvneTK4wa/9J1L0qmnIiFXz4y+97pj8Bu1cP7WqHwxTBIh2+TtWAUgA/n6
         MVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTHpyfnzknUuvpIDKfPOnypacMMGO1NnHWNZ5npNuAc=;
        b=eMr97egv9jmin5vGMKHan/42/54t+V9YhgEd2RS/DmxO7t01MkqIA+cMk/gTh4jck6
         09S9g5tGJBv68utyWLWaGCAy91HCSNDVB1xmUw10tHcBythOk6QEQcJ1n48+lxzoh03z
         ozeS3yJREWsXgZnyG/bxA7sWbjJO0t9C1MhjGxO22aoFsU3qy+kJpvdH1jhtAzAdATJB
         9viNOzX2ZDTvVP6KLkoOa8gIWi2TO8c1EkiPZcoGtW0aNgKU/GIS6YWzMkyWNTupB87z
         kUd71xD2tLBR3YGID8zSrf7bFwBPUcFiV5A9dNPOgkJrCxONdnX80nHpUUAZusTRYH3I
         4DhA==
X-Gm-Message-State: ANoB5pkIQ05nJidMOQ9z2ldZAyR8CXEOBwQEiynmHFS8f8Whc0OB6ma2
        d7oQhTklAE+5rAG8VOJHthEpnzYA78FxOA==
X-Google-Smtp-Source: AA0mqf4VobypecqAY+pn7RCVkSv8zLUM8OkX/erW4cPQi3NrcHZRbqdjwHKQM5VE7Aor5lIwLP7Nsg==
X-Received: by 2002:a05:622a:4c05:b0:3a5:274c:6118 with SMTP id ey5-20020a05622a4c0500b003a5274c6118mr8004372qtb.425.1668801971316;
        Fri, 18 Nov 2022 12:06:11 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006e702033b15sm3120794qkn.66.2022.11.18.12.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:06:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix uninitialized parent in insert_state
Date:   Fri, 18 Nov 2022 15:06:09 -0500
Message-Id: <9292ce2f2a9cadb80337cc350716ad9fc244ac2f.1668801961.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

I don't know how this isn't caught when we build this in the kernel, but
while sync'ing extent-io-tree.c into btrfs-progs I got an error because
parent could potentially be uninitialized when we link in a new node,
specifically when the extent_io_tree is empty.  This means we could have
garbage in the parent color.  I don't know what the ramifications are of
that, but it's probably not great, so fix this by init'ing parent to
NULL.  I spot checked all of our other usages in btrfs and we appear to
be doing the correct thing everywhere else.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 285b0ff6e953..25215667a3de 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -395,7 +395,7 @@ static int insert_state(struct extent_io_tree *tree,
 			u32 bits, struct extent_changeset *changeset)
 {
 	struct rb_node **node;
-	struct rb_node *parent;
+	struct rb_node *parent = NULL;
 	const u64 end = state->end;
 
 	set_state_bits(tree, state, bits, changeset);
-- 
2.26.3

