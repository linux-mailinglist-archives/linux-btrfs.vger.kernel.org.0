Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588992CDD74
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgLCSZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731594AbgLCSZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:02 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02191C094255
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:07 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f27so2048361qtv.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EH5zLvg1xCtS+DbKeTE1Z4oPb6z73SdFjMASUwOdAQg=;
        b=AAbDdUyaR3+zStB632o9ADXhMlx3Ur0gAP9TGb+sdLdg2NeXhKh8fm9zHIHvCqERk4
         IVYSCneSsN/0qFpWrJjjQ7J+crRqOGBzlQGaq6hMoNKXGCFiqbS5Rf11tYNIIgLKmQNw
         mgb5szgK/lySRseVbyMWNcBRkfQlT/zq+juocAqeCinymlg2Zyc6Eou3WDPXo/5admj2
         9kKLFMOkUsh74HiEFcnimmVFv4aUeeXcReCheGeUSmD2qLpLDr4etU3ZtvUqEFNgwRQC
         +S+eXK6g9PiGUjkavQPVoLT/e2dCOG+FX/SC5tL7oYBSPlU+wCHExAzF7El3gO3U78po
         tSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EH5zLvg1xCtS+DbKeTE1Z4oPb6z73SdFjMASUwOdAQg=;
        b=PVTdvmY5GVZ6KgRMMtYoFooCRzGINUlLc+LyG4xh5ExSXkUbgUan/xElvURpbxmMbC
         t7F/Rc0gwc3rqlLGo3ZTpTpmqrK+ENLCACTcPD61BWIDh5A94/jBnV0myKNEBdaRb1zL
         uYlqKkxS9Ugz9/h5CwxXvqJ2+1c1rxX5W/cq/+Dq8ck7Ojp7KSneQPCT/1R67qK0PUSU
         ppIFIitmUBg4Hmw7jIZxmgd8byyLEl78WCs5+weRzI1/OC1Eo09cAeKUQalxrUqGJDaL
         YuG90TOy0r2fsaIRCESZZij1mdX67flweZj8Y2x8h0drgUiviTjJAbsNzybMLpi8pkZ/
         of6w==
X-Gm-Message-State: AOAM533v6dVCo0hrMXlYzOBJKv18VaYkK4rNhJoUohpziS6VoXk5zmpv
        IZSoXYrCQgcl7sDe9Zcb2wlFa+gMSihvwRbe
X-Google-Smtp-Source: ABdhPJwueqgAB/9sAopzy9Fo9Y5jPJX8oJjt7Ba8sjnHf2buGs3q4vRV5vRdoKKYRxU2IemEerUWXA==
X-Received: by 2002:a05:622a:d:: with SMTP id x13mr4621830qtw.374.1607019845939;
        Thu, 03 Dec 2020 10:24:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c138sm2190973qke.95.2020.12.03.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 37/53] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Thu,  3 Dec 2020 13:22:43 -0500
Message-Id: <6fe88f7da4bfa2569e3213d54ef1dbc7a877f24f.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few BUG_ON()'s in replace_path are purely to keep us from making
logical mistakes, so replace them with ASSERT()'s.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ee175d2a5abe..30a022f26cb8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1202,8 +1202,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	BUG_ON(src->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
-	BUG_ON(dest->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1234,7 +1234,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	parent = eb;
 	while (1) {
 		level = btrfs_header_level(parent);
-		BUG_ON(level < lowest_level);
+		ASSERT(level >= lowest_level);
 
 		ret = btrfs_bin_search(parent, &key, &slot);
 		if (ret < 0)
-- 
2.26.2

