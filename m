Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2068D33984A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhCLU0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhCLU0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:05 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC5C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:05 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g185so25702386qkf.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E6Xvr1LrflFwI9jG+01DM44XXVT2pjNp6gb40lzlE3g=;
        b=x+C7Sd9eYbLTr4Jxp65CF5dS/HkpRQ5OWx6cVDITGn3gyRq9gB55fTMI1yCuGMZ3+C
         xxwlqgqbunpylzzgfKCJMIOeEeBRVwIVoC8CWD8HeUMSkniVzuJVOiCk6iVCBDy3iqSN
         482/g1du07aVY0p6b5kqO1gGyfLxy0IBx/YB4oGDRGKWziDSUX5wS8s5HB59ytUKu7JF
         c+muvNNQpwOPgTSr/cWVVOaFxY2gm03Kr2n3kJFakKUd3zLuW40DftgGWpGpv/P4fbOq
         nfT6OjGG0Ry7+AFxoCAmJX7fG/ar5LBxUPBO8TdHFd8ryNevm+FlIZa/2mZ3kANSwJc+
         4emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6Xvr1LrflFwI9jG+01DM44XXVT2pjNp6gb40lzlE3g=;
        b=q8ke2KQejfi7bg1SqgGg4qa67ETg4NMVebjLWptXnLHNdRLmOOi9xAhFYv5UYg0BYR
         AFosdOdu7iBwFqNpAsZk+LqrB/AyF+Auh6E1Crbi04dop5mosSWsLf8MlDeJlEXtgd3/
         xKl7/zd7u4AO8V6HDPCnYCgfjeKc+IhgHvMLiIHwliWqzSiHF2VzYMyIeofvloTQ8WCI
         wBFuO99PQKQkn4GlxtYLeeMRyfzRHJbFbj2Z5Yl0pNJcVRlb832Ws72bOBl1RGICB2Ao
         UMyPQMLF3PKPibcXkPDFHlXHYhc2k60oJI1uTpcqbpUKVeFMav1N8ChhZvjIieYK5XTy
         YBqQ==
X-Gm-Message-State: AOAM531VN2xWxXsM+X4Wd7cc+BDLBjJ5kuogJJ8V/4b6xmFTYbaY8xPg
        Do4W+Pk/41B/z/mkAGLzg80QXIMjYY2sF1MR
X-Google-Smtp-Source: ABdhPJyJeTWzt3ukEPek5UfUnFfPkGLwoKO9T5XqiP9plVPJMWgtpDibm+6jey2x2qPvpic3XRzk2Q==
X-Received: by 2002:a37:e01:: with SMTP id 1mr14236989qko.286.1615580764035;
        Fri, 12 Mar 2021 12:26:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8sm5225916qkk.116.2021.03.12.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 18/39] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Fri, 12 Mar 2021 15:25:13 -0500
Message-Id: <e76c70d7580a57637b1105e1e995b888853b0a50.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 7ca7ab3d40e2..9a028376f475 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -856,9 +856,14 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
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

