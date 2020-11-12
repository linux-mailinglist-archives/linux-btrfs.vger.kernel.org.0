Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF0A2B0FFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKLVTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgKLVTw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:52 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9078EC061A04
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:52 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so5241309qtx.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jcLyRf0Dc73Ou9XTjqBKTFWBOrdSaRmJBPy6Gn7ZjU0=;
        b=fKDuaN7pUADjw2uQmjhkIP0EPq/eiEg4dBXNuoZ31t6MUqi2DB6sarDJYOb3c+8bot
         Hu1FVxoA6nHyVHfq4/zR0H/TxUYdfQPyCzV4wNR2cst4agIW7SpYZFryFgMp8PVcuGsT
         YySoHwxjqDoFCTDWYrg5onLJQFHqU2TrAJvkwvucR3UI3dBKQuiTinTPhduA+b3iH1Eh
         RWWAyCOtObYrDTw4DeleQRfuUs4Gj+o3h5WTD1WTL8l4W16eiKs51Parm64JG3D63Eer
         7cVn6I779URl3h/UGueRwWFZlG+pFZFzf5+uvfnnfjQR+5aifvtoXrtc4i7yqnk/VZR9
         4/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcLyRf0Dc73Ou9XTjqBKTFWBOrdSaRmJBPy6Gn7ZjU0=;
        b=mE9J6Hd8CiW9lERc/8p3HQ4skMXqbiGZ04G9SmgbDDUAsiUV7fN2fEsha1hGpUP8Be
         V/MxfR97If7F0pl9zF36Yfc4bfDeawxgHTpbbp5RWkWWQssZc+Ah8k6jg1n6n8CQ3dR+
         PFmKH1qgaT0m2hEIIKMqUNbT1s1qbz6fF23CmRx7QnX02tGQEIxmzlrugyG6eXe5rUfM
         R40i8IxoKjzRWKe1a2k+5sliKvjeSFSZusyw2nI+uiRDHIwpZsFVSct50AOAlLAuvBgU
         +57wCKz+IyN3whcKMi3BS6xr5VfK5z5qoSs7jSfDNn18afe9VcExLvaNopaZIaz1t8JQ
         qNog==
X-Gm-Message-State: AOAM533PIOosYXDb+zDqVAxRJu39QmSXkE80krWIiStVgKJjzBx1VRME
        XOEzpt9MbFShS0dEQDck18fDV100uAx0mw==
X-Google-Smtp-Source: ABdhPJy5mV0Nlnng0d7c5XXDABfWk0PYdCwV+jFsCKcDU5gavBeJ2suAnPgagla5x9IUfi3w5kAbBg==
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr1193346qtr.179.1605215991466;
        Thu, 12 Nov 2020 13:19:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g13sm5551437qth.27.2020.11.12.13.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/42] btrfs: do not panic in __add_reloc_root
Date:   Thu, 12 Nov 2020 16:18:47 -0500
Message-Id: <1fcb0ba77d7d8adbf89a726e6d5aea81dc2346c8.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have a duplicate entry for a reloc root then we could have fs
corruption that resulted in a double allocation.  This shouldn't happen
generally so leave an ASSERT() for this case, but return an error
instead of panicing in the normal user case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4d6f898025e5..1627e1378b35 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -637,10 +637,12 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 	rb_node = rb_simple_insert(&rc->reloc_root_tree.rb_root,
 				   node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
+	ASSERT(rb_node == NULL);
 	if (rb_node) {
-		btrfs_panic(fs_info, -EEXIST,
+		btrfs_err(fs_info,
 			    "Duplicate root found for start=%llu while inserting into relocation tree",
 			    node->bytenr);
+		return -EEXIST;
 	}
 
 	list_add_tail(&root->root_list, &rc->reloc_roots);
-- 
2.26.2

