Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43D22911CB
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Oct 2020 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437865AbgJQMNG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Oct 2020 08:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437852AbgJQMNF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Oct 2020 08:13:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC938C061755;
        Sat, 17 Oct 2020 05:13:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so3072119pgl.2;
        Sat, 17 Oct 2020 05:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ruSfbwiFHP3Eq9VOsgPCaQqVVjbaLLVtHNrQXQOVVtE=;
        b=YllacpTSo2ofPyvyocDL10TuVJUzZJSXMjGFMCWkknsF8hqstKdJl0oDWPxZph/Znu
         5i1/JaN5gr3Y42NdPtBkImtQZJ8dgcyRTM00fjnM3DwAcVviy0lKg34MMhVumBgGTwcu
         X2CeoNhI1qUD9N6eNp+S/zDvMOxpfDH0slFzXt/1R5fBUWSJDdL83erEBaTOfN9m76f9
         JwLw9QmwUvuxYkDU0cQJIERi7D1iU/EsNz7N3EqRiN0/N6D41xhDJgnETwYfsV1Ffl65
         6/PYSPOv/H1dvOa+Q5JxLj83V+FLPpY9RO8BHZFgMQvGwPqmXMo8gBoJmH+uzpQ8PbPt
         yk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ruSfbwiFHP3Eq9VOsgPCaQqVVjbaLLVtHNrQXQOVVtE=;
        b=S2mM3gVyPTadUhXk8WzrEAZ+ym8Omh4LiThJHSr9Pk5or+zkjUoHBDxWqUz28U1lPc
         sTEekUkcvb1gmGaaxyLiHGkSJiq0kspCro7/RSapaeyCuOPjEvvh/Md/K8pLqsrT1LXQ
         CqFoszV4aKGPuejdP0hpxkXxz+avBffQjWi5wST4Bapdv9uKqnaSAFPoDBdhb27oi25z
         y+SDK/zGbbDjdY+JD9Os+2vuhBrHkmQaYMn72iozddws7eUSGZ4+P1VyoArGc7RZdI7H
         jK0xKHl31f+8tRTHUK6cV1TWt14Du/3WdxUQK34ZrGflZdZSvdMkOIxRTtTGvZUCPmsM
         mYKQ==
X-Gm-Message-State: AOAM5338AfvFx1qJMN60hOdfcghIffDMraI3vG5dldGlvcLYQK3Q1TjR
        W0pbA8H1fReWCaHRRcNGtA==
X-Google-Smtp-Source: ABdhPJyfu4pwqoI6JEuDgCy+ZFO6mndmcTGPYkSfDydQyidrJRJQnprqKOwJwabNhsWolU0nAi1xxA==
X-Received: by 2002:a63:5c5f:: with SMTP id n31mr6456292pgm.397.1602936785356;
        Sat, 17 Oct 2020 05:13:05 -0700 (PDT)
Received: from localhost.localdomain ([47.242.169.164])
        by smtp.gmail.com with ESMTPSA id e1sm5812701pfd.198.2020.10.17.05.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 05:13:04 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pujin Shi <shipujin.t@gmail.com>
Subject: [PATCH v2] fs: btrfs: Fix incorrect printf qualifier
Date:   Sat, 17 Oct 2020 20:12:49 +0800
Message-Id: <20201017121249.1261-1-shipujin.t@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch addresses a compile warning:
fs/btrfs/extent-tree.c: In function '__btrfs_free_extent':
fs/btrfs/extent-tree.c:3187:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'unsigned int' [-Wformat=]

Fixes: 1c2a07f598d5 ("btrfs: extent-tree: kill BUG_ON() in __btrfs_free_extent()")
Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3b21fee13e77..5fd60b13f4f8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3185,7 +3185,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		struct btrfs_tree_block_info *bi;
 		if (item_size < sizeof(*ei) + sizeof(*bi)) {
 			btrfs_crit(info,
-"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %lu",
+"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %zu",
 				   key.objectid, key.type, key.offset,
 				   owner_objectid, item_size,
 				   sizeof(*ei) + sizeof(*bi));
-- 
2.18.1

