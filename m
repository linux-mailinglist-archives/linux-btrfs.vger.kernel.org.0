Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD10446A01
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhKEUs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhKEUsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:54 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ADBC06120C
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j9so8035135qvm.10
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y3EH2S1uEdEQIUVMGMRkKsAHb4F1HDuXnPK5IewSzcE=;
        b=qV/FxelZvqjtXCDsCzREBbiI1UO0SgoyOax4AOGfzWuQ7WephlFsBiprfjFR9PMcFb
         byXKepubQEo5v1F1N4W4TQkVPehG7h40toyd1bnM08gfmF7Zlgr2rONFBanV1/quRWqT
         x9VX6yx3kv3igOBVVqUe5CBVygjSmM1Ki27Ekfo4u7fLpa0KWM1hIFwKV3jCWPNWXbwM
         RKI9TSECZ2u2ZidNL1iUxwgyh2bsB9Az327LgDy/bGLHY+XMhII/gwYfgff1tOlQ2nwx
         9wVo5BobTDg9uqAAUq6hmM9vOBcCu9PjNg3T8tycnbkgTSI9MEShO9ddShcdV32pOyco
         Guag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3EH2S1uEdEQIUVMGMRkKsAHb4F1HDuXnPK5IewSzcE=;
        b=N9qfhKPojZHeWxBdHGmR9ZTVcp4rydAGMsul9jK/kgWga1qCLk1u8a9/X3DhWehgv/
         x2u49rzAjI3kXLLvZTICUqF7IgDu3yl5ZxZkKBonGR/x6Gqmd9VqjDkKYL52Q4GKQPNa
         Ire6IRn8jSEiR+cAaSil4WGiVDtJhLidXUoK0WdXsuhw3zDlRWZmhY6Py7mzMnXxk8JM
         HNGZKRB5S5754tHgPeu03w3SN3xAg3oEiyCZ2f1KWA5F25XkR68m+3XBWGMkz7PmKIss
         sKhes/f+0sEEo7VVE0cSeYuytFrVPGQK//cUO9TTsClLC4rgMUphHQNQ+h8j4XIWJ7Yg
         Jypg==
X-Gm-Message-State: AOAM532bOrB1oMUs7j6ndYiFlb0m1jydy+fEuUFysCjTMTis01k925KT
        oa6OliIstdRpd+58Fl05fuRQSnzymYCO/Q==
X-Google-Smtp-Source: ABdhPJxZEbbjrpWIKPlhLMDWA+GAZNbwrhMPFnOfXaFNBeYpH9GAL1jtoFbKVv/c4e1g+Cd+AusvWA==
X-Received: by 2002:a05:6214:e8b:: with SMTP id hf11mr5215148qvb.40.1636145169762;
        Fri, 05 Nov 2021 13:46:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h14sm6665758qth.23.2021.11.05.13.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/25] btrfs: use chunk_root in find_free_extent_update_loop
Date:   Fri,  5 Nov 2021 16:45:38 -0400
Message-Id: <ded3b6f8c2730943739f2c88f88241994ce53612.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're only using this to start the transaction with to possibly allocate
a chunk.  It doesn't really matter which root to use, but with extent
tree v2 we'll need a bytenr to look up a extent root which makes the
usage of the extent_root awkward here.  Simply change it to the
chunk_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c33f3dc6b322..f40b97072231 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3977,7 +3977,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					struct find_free_extent_ctl *ffe_ctl,
 					bool full_search)
 {
-	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_root *root = fs_info->chunk_root;
 	int ret;
 
 	if ((ffe_ctl->loop == LOOP_CACHING_NOWAIT) &&
-- 
2.26.3

