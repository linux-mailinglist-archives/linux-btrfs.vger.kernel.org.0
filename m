Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1B2CDD84
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502054AbgLCSZT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502047AbgLCSZR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:17 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3139C061A53
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:52 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so3002520qkk.10
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OjSJwdT0JFQIv9nKJ1FZxFDxGJCV49ejVoo5IbSve4Q=;
        b=1Veavp+iLmAiIEBFxh2zRgx3OIOQe9xt/gpH4gUnZLFeJx7UOkgeHuSX0mNRsl/qv2
         M3Jt7aIP0T7H9XDHBagn+xQKMtECDFKwq49XBhsf/h2jRvnQCbibrzH6TQgR9L05NEMl
         IK2Tqnn+ONE4wtdRv0egZdN6fK61E9qazc7oa/hUI/q7l2WQRtRv285tvIoFjNGjzL32
         rY6p0k2lp9aoDNgckugfbpBxQ1eTBsReC+8Mvh8rDZbBeItctIySVhY2/x8+H4Owi2mx
         G7+vQXwHilxMBnZmGBNjeWBMdDJEUlL/XR64AkAr18AEY/EL/HSXwFpxl6Fof0EDs6sN
         SIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjSJwdT0JFQIv9nKJ1FZxFDxGJCV49ejVoo5IbSve4Q=;
        b=BPZevmiEhEpSTrFfpaJq1582TFQM0I3EkCtRkrO4P83no+l+zv+cfLDbNZkwPE6qUx
         dLmNRpOdRe0AmjaSn0T8+HaIetE8vAfmCuAuCrsU86K227tvMBap7JPBBPfImwG6lPo3
         oVJHggrOkw7AC9azSjB1h5y0cWufGwadQsXvBBDyJ+4HJKWB3s3zML1h7OOJuSmBYBIB
         2oORUPwtAxvdat0olKqsZf4X7IydktveLY8jEkY5v9fxXzXbaYz9jLLEWOMdrzunXJ3o
         +nQD79WBuecm2DlrHi+2ihSb4nMtRiSciw5i7BOQDRx+B1d8mhFaAb2P/Gm98gO3OJF/
         Zq1Q==
X-Gm-Message-State: AOAM530BHMn0NaSnpHeAkFRgtj8DtBuxEu8BPSYwaIiTiCvETKu6VzQI
        VPPxQjvTdqYgQSx25d5kC6Ndqvaueb0x2buo
X-Google-Smtp-Source: ABdhPJwVcJDIkg4qxkDvZ3300M+8QP1z8OjCpntjC9x3RPXlyhWTEOVLYHto7UzDi0y95yAFfBC6BQ==
X-Received: by 2002:a05:620a:218b:: with SMTP id g11mr4335928qka.190.1607019831890;
        Thu, 03 Dec 2020 10:23:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z23sm1950280qtq.66.2020.12.03.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 29/53] btrfs: have proper error handling in btrfs_init_reloc_root
Date:   Thu,  3 Dec 2020 13:22:35 -0500
Message-Id: <0cfd5682c79058aa62da679130bc3e2e961715ea.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
index a68ae34596d2..265b34984701 100644
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

