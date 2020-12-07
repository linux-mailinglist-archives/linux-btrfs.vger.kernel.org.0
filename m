Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2A2D12DA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgLGN7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgLGN7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:52 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C4C09424E
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:56 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id l7so1140313qvt.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ3N5Xz5HqHBUZlvTRm0YcZnf8FPKOJb+gKET8jp7xc=;
        b=oDoHiLCv0aEMGGp8MoOcAccLlgkftPvhWIPRmBXzXjcOenLAx9Q9LCwrwcdeOpuwTL
         n+5evArLDrMtOWrrxhC5tDbjRcOPrcJrysbiX2z24mmxOXKYeYN9X5vKRwencGzEIvqk
         R6hMmlKGn1U4KyO1v9r1MX93ZiRnmRo+smlkHp/qmWIKnN+CaKjpKelG/xtOwL5Irky6
         2TafG94ZXSqU6Tp9RZRjw9vr2ZHdJM24U80VMmO9KIiJHmlgcx7yU99DXdmN4DXwZnNa
         Tb/cyG4KYYa3Ep0IrwKk2Hs8Byd0+jebQ6BIFQX0Nwy9RsUpUdO9e0NpA1FqsFzLGwyn
         Nmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ3N5Xz5HqHBUZlvTRm0YcZnf8FPKOJb+gKET8jp7xc=;
        b=hB+V9BmqBdC2ey6NTH5DB/pSbhuZP4MjqscZLQyFZGDwEQbrUILv7m/QgtiOvm+DrI
         wWxXRr06w0+pYQelAhHepRm+G3YQdZUbwNPc0N9wve7wtW1SGM3kI8TQZm6X/SLnhtk3
         EjqZ7TYZttsNq5XDQDwkYnSAxnwND3aMOXr5zX3isAHXRG6vhYws+0u/F7ixV1asaetN
         5druAy1VW35VtUFIxh8PEKUwJhS5tSrzGn7KZ3LQ1ts5RjG+ot+Co+bkmmHW5M19Mm9O
         c6wpDSQKKECQjexGsyrMuv5BFUFo6yRrYljyhcKXdl7LXxchfO2AWDTLqYAArz5oLAHb
         dh/Q==
X-Gm-Message-State: AOAM532r2go2SlznBjr9Ot4FF30ksidVSP1Or2lAlaaEKKf9qWxICTVT
        Fe4XSwtMKrHYWpNtwYuFVEaxs9Q6FekvSiiE
X-Google-Smtp-Source: ABdhPJwSpEfGL7h5HlPfAyiva7Ej3GR2ECCHGdkfD4BldUFlhZeEeWkOIM0NvzZLCGhdHWZJy681Gg==
X-Received: by 2002:ad4:5687:: with SMTP id bc7mr21476988qvb.61.1607349534973;
        Mon, 07 Dec 2020 05:58:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q73sm3940028qke.16.2020.12.07.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 35/52] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Mon,  7 Dec 2020 08:57:27 -0500
Message-Id: <e2bffb4ab2aa4123a6b199732fba10bb4b188211.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call btrfs_update_root in btrfs_update_reloc_root, which can fail for
all sorts of reasons, including IO errors.  Instead of panicing the box
lets return the error, now that all callers properly handle those
errors.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b4ced3a0ca6f..ee175d2a5abe 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -894,7 +894,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!have_reloc_root(root))
-		goto out;
+		return 0;
 
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
@@ -927,10 +927,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
-	BUG_ON(ret);
 	btrfs_put_root(reloc_root);
-out:
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.26.2

