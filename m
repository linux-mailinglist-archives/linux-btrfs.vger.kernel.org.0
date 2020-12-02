Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204722CC730
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbgLBTx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbgLBTx1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:27 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13327C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:56 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f27so1979819qtv.6
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TJ3iBofDfTQayLrbdSBBBumqFj8IhCBlom9HqaVoYTU=;
        b=bNQs3L2rsBXWKAgCO8vwOaYEynwU1c+fnA5iCqWUYKqRgpEQGsEOb+xFEaULZiz55M
         K9XOLtCieC5lathw+PxtBJondNQHPx5xf21aZq8g6MKXcWphxcfsGHsSDW/VwFsb/m42
         d0u2z8ZLnikUDmJ0E4ecsBFSQs95djUPePk7y+W4loC147Y71bvFaM1J3GGIFwDBxKzX
         FaebB46JGb6TiuZzNiq6mMlKFxBJXb5ifJqyuxjyA1EguPyfsF/YbizKi2P0Dl5IO0YA
         WEi+cIrmpT807rrT33rQcZdqbzFRR3liHN6Q4bdMqfexm8b9YRNCM0CPkBFXH92XPZcG
         +Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJ3iBofDfTQayLrbdSBBBumqFj8IhCBlom9HqaVoYTU=;
        b=pu6td0qqFmWVGziU3KD3nJ/eLcVosJrqa3PPvBDwC9Z7e2IViw1dXnpgTCVrhFj+zk
         tw3LacaTUvOR/jor3B2LO28kvpTCHzDta4KBbC5ifd8uYQ5wxHYw/xcDduFAb7DTcnWk
         J4xXqWtCdi/eSRBE43I9hImnoccQh3XkWkAkakMrpr24md6KhHxir4emyGD5n3I0zHfx
         x7XzyvESWHZpg6xznOtyDNb4uSbL620oH1BodXr4Gg2GmS3773ZX4h8FG3cABRWTz3Zq
         sz9U+B7kxU4Ak170WhIuha58HgpETpWn+Ve0jB4bjLXUpeGf8FsU+tvOOQjXmh9BlXz7
         0EJA==
X-Gm-Message-State: AOAM532w8u7Nf/RSJA28qbFbB/p/MhqPtN7067eZjv/S7rCftLjH9uAF
        1rjJFeX580Xk8k9ODraP3TS33yRl9OfypA==
X-Google-Smtp-Source: ABdhPJwZdfdd7Qc+WBVbCBB6cwXyRRNUKdt9CV0RKTgyzdx425AauhVbZ/wAJTB1REhx+w479POUxg==
X-Received: by 2002:ac8:6b9a:: with SMTP id z26mr706178qts.200.1606938714670;
        Wed, 02 Dec 2020 11:51:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o23sm2685584qkk.84.2020.12.02.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 22/54] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Wed,  2 Dec 2020 14:50:40 -0500
Message-Id: <fc86b367066e2853db86aabae066318a7346bafb.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in relocate_tree_block.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5a4b44857522..e9d445899818 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2559,7 +2559,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 				ret = -EUCLEAN;
 				goto out;
 			}
-			btrfs_record_root_in_trans(trans, root);
+			ret = btrfs_record_root_in_trans(trans, root);
+			if (ret)
+				goto out;
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

