Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0702DC3F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgLPQXC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgLPQXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:02 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E9AC06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:21 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g24so5178359qtq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r01wEU0mWNGGDEvQTJ4iY+sz3aHS/yrLZMrZ44+tCbU=;
        b=SNCQ0AlQDk1nKzgG6ERs3x/9Xt25INXjykNrVf/yfhHo7T08VcbPYrfDuezKWdu1/i
         XGcMVjZetw0fcSGV2QnQOXXk1P1kvabC/mWrTu2FfTKmZLZ5USwaEGRN1AnY8kJCKlnq
         dbgTQIPikOwxTvUedwlkyoqKl74mfe5+H9I9m0AvSQ57XEaIHqQ0ZD4gJix+2RlOnM4C
         nxzKHSB4qQPT9Dks630nXLrgDcl/T+7orZrNcyk4uCRjYnUBolLqc68od0S7lDEO+eKp
         bkI6K/Yiy9zUs6OzgRX9ngJxL9r68xR8gOewNM5NqIkdIqZIMpjlcCD4gx1tIOZphqNo
         UZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r01wEU0mWNGGDEvQTJ4iY+sz3aHS/yrLZMrZ44+tCbU=;
        b=PsCbA8y5M3nEda0URjGcHk9zzjC1+wdhKw47H0pJUfpl3K7+D8g5lRq9Bq41LhtMxY
         dhzQZT4m3mq6xzSMofe2c1VF/Ay6AkRHKeExHeuayQERscJR4dnU83Tw8gpX0MWhxupZ
         gu9XhXaaYxXrMCvef1LDEuaoDayNy45EN50LPdyJpm/O4QxP8GSE+bT6zw1nOVC4zfgS
         aG9qW8C4ACaq9XSYGjWqQUElCR8nvYobNNWp8TjOsG1SWlkQ+US8B/YHRd1wepMSkS7b
         VLmI1AO+XAzAuW+uAIohuh8Inplm3qZuPvao9fxDJojhlS0ORlI32nTRzgnf+K+irZEJ
         sY/A==
X-Gm-Message-State: AOAM532s7uObpIYbFQjVmduBK/pZbz/I2JpprpIFwE7JGPQjH+xgC9CF
        eoDdq0gwOUOub7LNAxoXV3g80x/vM5wbFOwv
X-Google-Smtp-Source: ABdhPJytg185Wtx6lkfuVHxUNhDxKj6BTGyNw6t91Ltkb+o399ydLGz41N7iGx0O2e7FvbziWumL8A==
X-Received: by 2002:ac8:b47:: with SMTP id m7mr43524921qti.287.1608135740848;
        Wed, 16 Dec 2020 08:22:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f129sm1415938qkb.22.2020.12.16.08.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/13] btrfs: don't get an EINTR during drop_snapshot for reloc
Date:   Wed, 16 Dec 2020 11:22:05 -0500
Message-Id: <8813454a8863263bf7d0dd3724b7b1d7014482c5.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was partially fixed by f3e3d9cc35252, however it missed a spot when
we restart a trans handle because we need to end the transaction.  The
fix is the same, simply use btrfs_join_transaction() instead of
btrfs_start_transaction() when deleting reloc roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d79b8369e6aa..08c664d04824 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5549,7 +5549,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 				goto out_free;
 			}
 
-			trans = btrfs_start_transaction(tree_root, 0);
+			if (for_reloc)
+				trans = btrfs_join_transaction(tree_root);
+			else
+				trans = btrfs_start_transaction(tree_root, 0);
 			if (IS_ERR(trans)) {
 				err = PTR_ERR(trans);
 				goto out_free;
-- 
2.26.2

