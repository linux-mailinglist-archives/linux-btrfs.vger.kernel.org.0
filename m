Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09029048D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfHPPU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:20:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43670 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHPPU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:20:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so4976908qkd.10
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ynhRgJ4uDXwvvYSLcHfqM8iEnjxROfQZHfHlR2ApWA4=;
        b=0AzSjqnerkwDfB9kFWGC1BY28ApilHu+YNi0oe1F6S6evL1faS/Pr8nRtI5YfCtQnt
         621hiUCI87URMhg53iGr2s+GXRqjwg6D8C/TtAPsS9y7fGPLuMkqT/HtrdyNlpcrulPc
         4osDmLElzHwq8Od5+CoLeeQkJZ1K+W4rd8V1tC00P+CLMOi0Am7jMZmCHEiGRQEyTC6Y
         r1T9YJZerXL9DSdxFQhbTlTyia3O37BTvPwh6Jbiv8o6Dc0d9PWrzyuNPd+CqH5YHLkQ
         XBgXMO/R+Gc538r6vFXvc1H4revmfPjhj7A2YFWGLpgKVw4xf7TksOej3jTpKBpgWWXF
         1s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ynhRgJ4uDXwvvYSLcHfqM8iEnjxROfQZHfHlR2ApWA4=;
        b=Cd7FaPGsfrU5ypo4Ll8YyYHNug09orNtKBboYDpP/VqjLRKOhO12QdzYIG1BqTbMuY
         j/NawZ7NL+v9xTm9IhPPC/Ty1z1Sp/cn3Istnq2+P11ccD+ryno1gyWwL0c/qEUBOZUi
         o8uda06DyadP37PZTkLhCqol+UZbrndSF5Ac31Fhf6KUu1ZLE5pri5sBS1kfRUpnzgVh
         CVWhdhWPq5V3LM9ttWfEJ18EjGyjqn1AilNnPc2mqI1FbagwymYPzvCjIMZhvW5yVNi7
         FNLJyKr45PvUvdYlrfBaIfWXzDqYOPJ4vlkAdUVc/6J/uu4heaJrxSnifyBieyp2rnl4
         4RSA==
X-Gm-Message-State: APjAAAUCExYY8D3ZchUtTKk4NDnGRhfWSTM7c8OAGSx5MjhRpNPRQALQ
        j1yGx1pk2gJ32xkjoMShEPNKyIP4Si5YbA==
X-Google-Smtp-Source: APXvYqx5t35wi4UcMeMgmLAOMNfxPrG0eVnN+7F81eqbGSG7lqA4hpHAhFXqfVzKC+PeIibJ+NB2Mw==
X-Received: by 2002:a37:b982:: with SMTP id j124mr9168482qkf.251.1565968827316;
        Fri, 16 Aug 2019 08:20:27 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p126sm3454653qkc.84.2019.08.16.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:20:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: use add_old_bytes when updating global reserve
Date:   Fri, 16 Aug 2019 11:20:17 -0400
Message-Id: <20190816152019.1962-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816152019.1962-1-josef@toxicpanda.com>
References: <20190816152019.1962-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have some annoying xfstests tests that will create a very small fs,
fill it up, delete it, and repeat to make sure everything works right.
This trips btrfs up sometimes because we may commit a transaction to
free space, but most of the free metadata space was being reserved by
the global reserve.  So we commit and update the global reserve, but the
space is simply added to bytes_may_use directly, instead of trying to
add it to existing tickets.  This results in ENOSPC when we really did
have space.  Fix this by returning the space via
btrfs_space_info_add_old_bytes.  The global reserve _can_ be using
overcommitted space, but the add_old_bytes checks this and won't add the
reservation if we're still overcommitted, so we are safe in this regard.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 18a0af20ee5a..394b8fff3a4b 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -258,6 +258,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	struct btrfs_space_info *sinfo = block_rsv->space_info;
 	u64 num_bytes;
+	u64 to_free = 0;
 	unsigned min_items;
 
 	/*
@@ -300,9 +301,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
 						      num_bytes);
 	} else if (block_rsv->reserved > block_rsv->size) {
-		num_bytes = block_rsv->reserved - block_rsv->size;
-		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-						      -num_bytes);
+		to_free = block_rsv->reserved - block_rsv->size;
 		block_rsv->reserved = block_rsv->size;
 	}
 
@@ -313,6 +312,9 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 	spin_unlock(&block_rsv->lock);
 	spin_unlock(&sinfo->lock);
+
+	if (to_free)
+		btrfs_space_info_add_old_bytes(fs_info, sinfo, to_free);
 }
 
 void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
-- 
2.21.0

