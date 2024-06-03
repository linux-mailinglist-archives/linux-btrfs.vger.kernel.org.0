Return-Path: <linux-btrfs+bounces-5416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B18D8621
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136A81F21C93
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2077E130A49;
	Mon,  3 Jun 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCfe9dnk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6712D205
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428858; cv=none; b=CX1mv4xRs4PTIkkRpTGm6pjpGHC0BY2gA4PqRf485gfe0fLbo8sI7iv9Vf806Ut27VoagtZ8Zv/vRzbFJz57YbsDWXeK+t6oO1VRcu4IrPK3/Cmh8TP/6YtnaGLYancfO93oeVK3G7O8O8QQx7rtLru/D4jccimDvnRDk0ufWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428858; c=relaxed/simple;
	bh=OGrysEvNZapKt99f/BZauox477mnP9wsVkR1OJEKrqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5oTMJwfuwMng98gkgJPu8x/o6srmbqDnDfjS5sgQe9wshN4IkQ14K2ytPn43Bsdk9T4somnA/oJ4dBo2Lrg7G9I27i8JxHTk/sSblCPOlsmWs5ofMiZylGWDk88kiM2snxGaBm2fuT8s/cvu9o5MEJyuU7InE6gIV+7Etg3Pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCfe9dnk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d0dso36121995ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2024 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717428856; x=1718033656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShcCjlwWqwkgc2gG8CxupGvYCwRRHuZ3p3PTt/ooU0g=;
        b=nCfe9dnkTdfu/VbPhd1L/TTF1Ey4IOvutmh8DvFP/xedyP/DBrFAf5f8v/nlAf5/A1
         Gz/eCN1eT4FPNNp1S1xVl0SdBF+5Wj56WsaW5ZtximzhD7p4YQ+wc37qExRKmuhvbbRn
         JZkYpoLQqMin/7gErIm2WApt3bS8WFOqBrodCEcXaFRp5OSvsG4hSoIZVKcOYpjKDM1Q
         UVRC5de7e213ORBxsxGnMfEkp2d9KlTmGwrKL2q1pG7QbjQFGyJiHOEovq38XvI+LfoQ
         nGgAu8YgmRn15jZGDDX/EqhACvoIJ2giqxhpJ+bibBbXvJ4iHe46M+tqKSy04+8surSY
         dTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717428856; x=1718033656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShcCjlwWqwkgc2gG8CxupGvYCwRRHuZ3p3PTt/ooU0g=;
        b=WXKEbooQ7AkojCGlz/UANmryAVipMlRNYmUTwq7kt1kuDnmZDpXlia76SV1XOqSR1M
         LBdPnDlWV/KcBSwPyGQKLbcwp/l6TbKi/4qV0zjAIA39zXQRVUfN36ZUYH0AVEHWWUDC
         vchVVBXSEJmoAvwtgb0MW1V7V1SGQ6R3DWjI4wnr26fB51L3xh4l5g3THYYCQVyMsZr8
         5eEMhDNKKfOHgA0mMQcXeLtN8tJSx+tiTRypZTgviWshk3bxcXL58BQe7/ABFBfUhCXI
         yTtI/fNI46E5fA0HsuPa0l1sYErW/YJMqBqUcBdXGC3rWNnpBsIfNtk5iDYme8B+IIq6
         BVRA==
X-Gm-Message-State: AOJu0Yy6FLfR3hxb9m+QdxMKK3Q/DN11Ads4dgoMjmtxJLMT4cvVpxwf
	83VuJ4yIrB4Ty5Vbw5v+1edE+RZ0xeq1vZZD91DanTbYtlXXm4FZfOEDIZIxb34=
X-Google-Smtp-Source: AGHT+IGES9u3Ju0v49P7+vY6kOD3yLGzNutqFissi8iZnIR5XQqZpsNhuKYEWPcC42W7FipF/33YXg==
X-Received: by 2002:a17:903:2304:b0:1f2:fd49:9fcc with SMTP id d9443c01a7336-1f63701f268mr121491085ad.34.1717428855755;
        Mon, 03 Jun 2024 08:34:15 -0700 (PDT)
Received: from localhost ([36.112.198.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232ddddsm67562535ad.15.2024.06.03.08.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 08:34:15 -0700 (PDT)
From: Junchao Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	Junchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] btrfs: Adjust the layout of the btrfs_inode structure to save memory.
Date: Mon,  3 Jun 2024 11:34:10 -0400
Message-Id: <20240603153410.79244-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using pahole, we can see that there are some padding holes in
the current btrfs_inode structure. Adjusting the layout of
btrfs_inode can reduce these holes, decreasing the size of
the structure by 8 bytes (although there are still 5 bytes of padding).

Here is the output generated by pahole:

        u8                         defrag_compress;      /*    26     1 */

        /* XXX 5 bytes hole, try to pack */

        spinlock_t                 lock;                 /*    32    64 */
	...
        unsigned int               outstanding_extents;  /*   432     4 */

        /* XXX 4 bytes hole, try to pack */

        spinlock_t                 ordered_tree_lock;    /*   440    64 */
	...
        u64                        i_otime_sec;          /*   800     8 */
        u32                        i_otime_nsec;         /*   808     4 */

        /* XXX 4 bytes hole, try to pack */

        struct list_head           delayed_iput;         /*   816    16 */

Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
---
 fs/btrfs/btrfs_inode.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 7f7c5a92d2b8..184c31bbf2df 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -118,14 +118,6 @@ struct btrfs_inode {
 	/* held while logging the inode in tree-log.c */
 	struct mutex log_mutex;
 
-	/*
-	 * Counters to keep track of the number of extent item's we may use due
-	 * to delalloc and such.  outstanding_extents is the number of extent
-	 * items we think we'll end up using, and reserved_extents is the number
-	 * of extent items we've reserved metadata for. Protected by 'lock'.
-	 */
-	unsigned outstanding_extents;
-
 	/* used to order data wrt metadata */
 	spinlock_t ordered_tree_lock;
 	struct rb_root ordered_tree;
@@ -260,6 +252,14 @@ struct btrfs_inode {
 	u64 i_otime_sec;
 	u32 i_otime_nsec;
 
+	/*
+	 * Counters to keep track of the number of extent item's we may use due
+	 * to delalloc and such.  outstanding_extents is the number of extent
+	 * items we think we'll end up using, and reserved_extents is the number
+	 * of extent items we've reserved metadata for. Protected by 'lock'.
+	 */
+	unsigned outstanding_extents;
+
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
 
-- 
2.39.2


