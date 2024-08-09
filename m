Return-Path: <linux-btrfs+bounces-7077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60F94D907
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 01:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E28B2254F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4B616D4CA;
	Fri,  9 Aug 2024 23:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxefaP8i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442B16CD16
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245189; cv=none; b=Y7adpUGaBIoXqK/cAjMrBue4W9nnIGWt+X7zS/V869c1AzbJdZ1WJuO2iivdC5Bww1rbLyvLbighfZE2nvlzRdb8ozfHDVKmiMNHqK/ZaULF9W74e3UjvgOhfjvbNCKRp0e2J5bXgfThGzdelosXr2FlbPHAATktUG0q5RFuERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245189; c=relaxed/simple;
	bh=b3aE4OU31/P6Alr6f8pvKJScwtC6WMvFNKDVbkb7SN0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkP2Liwjm0je+Z78eMqjUKaC3h3tethFIGNBAmLc+wtwqTbhQnpZZN1bC4wMy4bTwDkxyWqhixfXRNv9D4NDfoaM7QQgt4Q5mvism7NCRzMa2Sucz1XcW7NQXxR6LoVhDh8XFV7xFjXIsr3lHaDq6VHAnf50hMOUfjWDXsgrqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxefaP8i; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso1780030fac.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723245187; x=1723849987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD9gIWmjwth9e80JD5TSQ9Qh3GmJGcSVMby3XxxnIGA=;
        b=NxefaP8iSm23MqY7FE0nOeTV4L9+Hx+xOi2ts9iftt8U+34qwx/l2VhPHW+SHlGzfq
         IjSJqqjWB8DAHBsaTM78cYUdB+oiQAGyLvjWUKs/qdFrMbPqbB2Zz8jZFIvwtwSJmiHb
         VEtv/YqgW/T+9AqEDM5Db6Bpjp3h/MfN9jCsw1DkwRY+9GRHdLuw11EDx6i9TcPkYt8h
         gmdR6+LE6UWIVPFWoGDmXBL4YnkL1wxbp5AxmGou3QQkCHP1z00CfXNjfdRGk7P3joxx
         3OBObDbyL7WbrpoTtOtXnK4AHQyrjA8sbGVqQGDneT7mP8H8zMplcnmPtIARIrshusnT
         RYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723245187; x=1723849987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD9gIWmjwth9e80JD5TSQ9Qh3GmJGcSVMby3XxxnIGA=;
        b=fmqFXwJHBl9LBcBeBAorU/T1v55Ra1/0cnMshmHWgBkklXKTyxtDsuXo2oVaLTlXfm
         0e7vRiGIv0HeyEZk+ClYkEM07/YMvklukmFAjrqVjVunXp9NxCkcbW43QPkr8lEO9ccR
         U9GoOAaPs+fxLTSZni3G5hcLg6E6EOLYuiCa7IkA406qbgbkih2RIk5O8y6V1bbhCYSS
         YxdNYc/QYr3cC3uHy1OT9I18wthFq9HwLETLarBhcNx8aCnTfKzdlf8FTTqUzgRda9JN
         f+YIkIeV3JbDzlvDPShVdGnWlc9ZgeRIdj6pAVvdCeN5SzwwKO6uLY1gFjhLCn85ZzXm
         YMaA==
X-Gm-Message-State: AOJu0Yw0YZkn8GkyKI8As4EgMsjgCbahhR/1YnqjnLJP/qAejtLxNC9g
	GuttD72RTLlYzZGY0WZv6eT9ixTFe64f9Bp0WWJw6H/JEc5AMKcA1RgtcAb5
X-Google-Smtp-Source: AGHT+IFxKCxPndPRm5oNl5TO2VzQly10cHZ/eOmaENKQMAXpbKND7ItTII3uciZC3iGdc/59tb053w==
X-Received: by 2002:a05:6870:b49f:b0:260:eb3a:1bc with SMTP id 586e51a60fabf-26c630218d5mr3895833fac.41.1723245186641;
        Fri, 09 Aug 2024 16:13:06 -0700 (PDT)
Received: from localhost (fwdproxy-eag-004.fbsv.net. [2a03:2880:3ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26c720918eesm279015fac.19.2024.08.09.16.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:13:06 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: use __free in linux/cleanup.h to reduce btrfs_free_path boilerplate
Date: Fri,  9 Aug 2024 16:11:48 -0700
Message-ID: <7e5f9aebbfdd190cdb4f12589a779d873f3fd91e.1723245033.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1723245033.git.loemra.dev@gmail.com>
References: <cover.1723245033.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch lays the groundwork for future improvements to the btrfs file
system code by introducing the __free(btrfs_free_path) attribute. This
attribute allows the kernel to automatically call btrfs_free_path() on
variables marked with it when they go out of scope, ensuring proper
memory management and preventing potential memory leaks.

Test Plan:
Built and booted the kernel with patch applied.
Ran btrfs/fstests to make sure that no regressions were introduced.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/ctree.c | 3 ++-
 fs/btrfs/ctree.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 451203055bbf..9938664d7dbb 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2007,2008 Oracle.  All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/rbtree.h>
@@ -196,7 +197,7 @@ struct btrfs_path *btrfs_alloc_path(void)
 /* this also releases the path */
 void btrfs_free_path(struct btrfs_path *p)
 {
-	if (!p)
+	if (IS_ERR_OR_NULL(p))
 		return;
 	btrfs_release_path(p);
 	kmem_cache_free(btrfs_path_cachep, p);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 75fa563e4cac..be4e14b6e39a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -599,6 +599,7 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
+DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (_T) btrfs_free_path(_T));
 
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   struct btrfs_path *path, int slot, int nr);
-- 
2.43.5


