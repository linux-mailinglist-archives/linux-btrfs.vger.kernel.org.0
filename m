Return-Path: <linux-btrfs+bounces-7592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19A6961A18
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEDB22D5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3B1D4173;
	Tue, 27 Aug 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WabaKWnn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A11D1F59
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798528; cv=none; b=EvNV2ls774u+4yBglzsJHaIFOCd8kfq8bnqwTV6YJYQPNmYe4S+fAEQh2fBZlhYqwXEivYTFLgTjAA+Oh27N338o9xvRO8wliYgL5b4yBVhahBVym8+u09WsIHcDyVOp5cvQfCNmYZKjjX2/kqGHKFmJUGELOp4PReMsNSHRj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798528; c=relaxed/simple;
	bh=n5LbD98MyNqaSQ4tcqe2s26KYYC32K2UmgcnC+bmjsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqfuy1boh5GIJQpO23h7bA+5mTVaLl4L2t7xHKefoR78gHMTTnSi1tizIxjT8QiJxoFDctrPJxYaP9gH+ezQyQIC11NPozOB47rTlBTIoiK2EQ9/efT/YT83DxlXOAaeg9Mh4lrTlyIaHCsHXzQQ+KtIFsp7eD6xMZyASPWltoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WabaKWnn; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-5d5e97b8adbso4922654eaf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798526; x=1725403326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+YxbXppocQU2l4EFQo704T8jvOcTqNyJkKqw3tNp1o=;
        b=WabaKWnnFgITjSFyJ8jxPwTWYHzvEkjlDO3ATYj54eEmmpBQpPRRnifJcGuYT62crI
         lPHGt+o2Hz7uiwoHhFkQkvu1L7RngWGOlANWaS7OSsUajewZOYYd5XEH1NxrayC4vtRQ
         IUwO7QoG8782+vJ4vI0HwVViJ0ip5gH5x0fBV8RctPOK5BnHMjID2/NsIqPGs+djN1Wu
         3AxtL1HNfMaDTqYcKnHryQ6mK7EIRcpSxHqJmChd4k752NYCJVjsPtdKsa+jEZMmQ4fI
         eBw7+8MsQgY088yaIoLqJuzurRKGOW5R8KkOAowSWN127GRreJRfxUuuu+Hqxgf1YmYe
         hRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798526; x=1725403326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+YxbXppocQU2l4EFQo704T8jvOcTqNyJkKqw3tNp1o=;
        b=KdP9ydoFRVM2AWdIYEVZogObEJBORgy2AsOClCkR1WbSdfs280f8sIBaQvHgKdT2mM
         FOBvdKEvjf4iDafIB6p9rFtWL8b3/f1kUVm4TYc6vkRzOzfEFbWumi4xVMV6VK/8rMiK
         uQ+QAPkUahDb5Fn24iitTFiSZbsM9Dlqr0wxlPsBVOXWEU5lQXH5SgrIQydhb3pGqsk5
         D+Fw3A+zjwgXt2p+qqEsKJNMadnbw5ip4tzP0eU0G9SPRChR2OIJo+OaSWEPrb5ZYiLx
         LPVCKxclAVEsCcAUoMZMeNeVjfU7CV2mWTupxWti67FIcc42sQpYF/WURCESWuXYOqpT
         saMw==
X-Gm-Message-State: AOJu0YyWw51p42XWFl75gVmU//tyepVya/YuJGTKuZKT+enlCYw0Mvb9
	GLCYsRM+xAut466Hrg3FSRTSPLzLUow4DyrWOdyhcTRfGFojFFQBy0oH61kt
X-Google-Smtp-Source: AGHT+IE/3sPBoyZhbzBRYNCDJ0XPQpT1eKnjPdiAe92XgrM5wAavu+lrNkTmVWguTlZB+mR4sEmVeA==
X-Received: by 2002:a4a:ec41:0:b0:5c6:5f2d:8430 with SMTP id 006d021491bc7-5dcc5ec241amr15667420eaf.2.1724798526108;
        Tue, 27 Aug 2024 15:42:06 -0700 (PDT)
Received: from localhost (fwdproxy-eag-115.fbsv.net. [2a03:2880:3ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dcb5de7c83sm2699104eaf.14.2024.08.27.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:42:05 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Date: Tue, 27 Aug 2024 15:41:31 -0700
Message-ID: <02d02a785f1d71b41104c48fb38eee7488a672c6.1724792563.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724792563.git.loemra.dev@gmail.com>
References: <cover.1724792563.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
be called using the __free attribute. Defined a macro
BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
very clear.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/ctree.c | 2 +-
 fs/btrfs/ctree.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 451203055bbfb..f0bdea206d672 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -196,7 +196,7 @@ struct btrfs_path *btrfs_alloc_path(void)
 /* this also releases the path */
 void btrfs_free_path(struct btrfs_path *p)
 {
-	if (!p)
+	if (IS_ERR_OR_NULL(p))
 		return;
 	btrfs_release_path(p);
 	kmem_cache_free(btrfs_path_cachep, p);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 75fa563e4cacb..fbf1f8644faea 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_CTREE_H
 #define BTRFS_CTREE_H
 
+#include "linux/cleanup.h"
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
@@ -599,6 +600,9 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
+DEFINE_FREE(btrfs_free_path, struct btrfs_path *, btrfs_free_path(_T))
+#define BTRFS_PATH_AUTO_FREE(path_name) \
+	struct btrfs_path *path_name __free(btrfs_free_path) = NULL;
 
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   struct btrfs_path *path, int slot, int nr);
-- 
2.43.5


