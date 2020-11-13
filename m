Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F492B2043
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgKMQYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKMQYU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:20 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1693DC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:20 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id h15so9245160qkl.13
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zHEkblRt/Sx2DmeauqEOAtWBI32FUoNFZpoH1q/bPg4=;
        b=sJT7BFFtvirloeUhfasXjQHWnNjxH1gkW3I9zBBJEJ6LtSWJKto7VYurjAmzvokoLy
         z36T+KTLWhPxlOOC84MEy2QKkZWc81wAp1jW0nXQfmBQ9UAHkjHCCeqbBmgM9ZjuEwCD
         hlUnXS9mg0CAZf8KVpl88oiNJ7Dh9pgoHg9U99E+eECNyZm88VlmoDT+LTlCqsE+o49V
         s1v4iWP3S+a8vh+/fr4ZJfPqqui+zaa1vwzLZl64A4fHB0Y9/ceOFWw9+6DFvrFI+0Cf
         hrhU6Gbdpl2IuFMV5dEwor6YRPm0n+8mon5Y8leWJwV+hs0H9hTkLyNvFQQzR8r2u3u2
         1soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHEkblRt/Sx2DmeauqEOAtWBI32FUoNFZpoH1q/bPg4=;
        b=kwyxBXgM0Mu24oXqJHf6l/WUEgayUFf/XESsUn29qV9KQtNM6tsFo016+xLQncMzmP
         rGr3Lvr9HdQF47uCC9WQVJHwOoCSz6FG8ti/7bE8sciELkXlPGxc8zX0vsOUfa5LMVIw
         Lz4IJUrxBgcv01gMcFF8uHjE0uSbg1/8Dw3rqfkt7KzfyUaEl/VlsPaAyzQRQ9J9w2wC
         SoGnl8PITUHI56UZhmBz9C3pk8ixyNSZVW+D32v1aQUNK0et/1OQKKaO/XTaSgm3gOcU
         xgxnY1vsySPyQCK+Jk9H99d2b0SDsc1a9ad5l/WqWUV4Ey0hZBWBp0wjDooI+9wDiw4I
         X8HQ==
X-Gm-Message-State: AOAM532Iksu2Z6ucwrkbmzA2ltsmnd+9Ry0xoDG8eF6nfXE3hD2GF4Mf
        hvNmCFVTJVShYtZMojDb0GH2PV6M57FreA==
X-Google-Smtp-Source: ABdhPJzIRtOYpC1irzgXe4B+RTc3MWdYKJ2B+IpezvRX/p1IVCiYxJizQ9NGjGg9yOBmtnM/tGALSA==
X-Received: by 2002:a37:7e43:: with SMTP id z64mr2850872qkc.184.1605284654088;
        Fri, 13 Nov 2020 08:24:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h9sm6308218qth.78.2020.11.13.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 21/42] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Fri, 13 Nov 2020 11:23:11 -0500
Message-Id: <95d76970dcca9b6f1d523339b8ec62429813a0fd.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

create_reloc_root will return errors in the future, and __add_reloc_root
can return -ENOMEM or -EEXIST, so handle these errors properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 63f42aa43fa3..4afba27419f0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -860,9 +860,14 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
 	if (clear_rsv)
 		trans->block_rsv = rsv;
+	if (IS_ERR(reloc_root))
+		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
-- 
2.26.2

