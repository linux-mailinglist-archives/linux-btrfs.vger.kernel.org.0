Return-Path: <linux-btrfs+bounces-7572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C557A9617C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD6D1F236FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24581D3191;
	Tue, 27 Aug 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWAwSRtM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849B1CFECE
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785791; cv=none; b=EnmmvTt7rhOPV8AjiWBxgddsG12wnYem0tL/aCHe26opCgDVyTCge1ElGbfG1p3AMhmuwKr1JjuDXHGH9zBO5Wlt/CrGLxmXq+XNxx2g7AWwiunsiV1PxcbScqlYJPSP3CO4pZ2ZSEyDxiAlaNcJ/IBAlOCYSeOlOI4MY5ekD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785791; c=relaxed/simple;
	bh=ckxYPzrPQlT9vM2ZhhYrmMzB2ZLZnvY6nV1orUAS1kc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH+eD4D1ebn2NJtlRvzFHAIYcWeSVYzQzq9dRQD+UgdBmuNoKEQ5caOC0LaDsU3ksLDuIaBPucGVheo4kfOR5Wg1aGYVhkbhRXDSTCOIdI0KlgtiyPnkIX3dKBVgDkmQxms3hWulSSdw7ilWEJC/7mgW559JLj2RXMY/WtJuq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWAwSRtM; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3db51133978so675583b6e.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785788; x=1725390588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaakoZrOtarCzY3JxedCLrPGLwHUEONAWAetO9xbe1g=;
        b=PWAwSRtMCQuyuTQxIxEWoUTEEMM06NJXsrcxscbxHa/83FA6qiw/j2sgmWLNYaHZ0/
         AjEJAS9FGqj4uG6gypif3tUcytt4zLoQM+Q3Mb6XkKs/8zCi7UjbI1JwUPxBgqCMdH+G
         CVqs8whJXWRDVycnLNrfQA3NRgJzNJSIOf7pp4riEGR0CI1iVyLYPiK5REF0IvM6nYZ6
         fanZ171Jn+IswK2MhaSTGwH+zhawCHZb11v77uojoZyzrtc3oxUj4SS1hsoqfTs/nzdx
         9VLqRJTQ5+/N4dbzAESycF4HCpF2DMyiBWgfZGN+Re7yOi42JNhGSOZglGnBdBRQOPaV
         fUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785788; x=1725390588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaakoZrOtarCzY3JxedCLrPGLwHUEONAWAetO9xbe1g=;
        b=tExxEGrUNonb1uiqJLNvQ/Ja+ETwPNY3QtYH6wUochnrqbu0oQNSQDJqVNTWee8H2o
         nP1baPhJpGK9wLENRUWmtRCGS3+Y0IWnetstAEZLbj2biEt4G3MzCGTKp7t61hUo2nGk
         E604oGfeD8ypDe42cxuBYmUNJy4cnAkAssolcByaAym5FGmopitiSLngcbkicUBpvJOt
         28OLZpun6GpkwMMcruhm2mzHlCLwrdUUVeVvyEOlryPVlHN7/5RaMap1nK5BxrTdJ9ee
         R2WSNpVtSnJBgkvtyYBiEYpSqlgybT+rs64iQbYJ/bkr9SSLxPmRVsa9BFLnuLf6l0/3
         DyUg==
X-Gm-Message-State: AOJu0YwLlolCVhDmIMw4rUCnBngIf8zqmoOAKz8k6Wl7DSxaZNpROCS5
	93Y+018aNZ+c7BAj15tHZmCt+svX8+semxIKieANP00SIS6D3eO4wpV5g/9K
X-Google-Smtp-Source: AGHT+IEX7B9gQFnWN3biJR4a7lNuEo8XHUMKPw//m2QJ/CNo1xTKWk8RH7+Adqw84XxTeIKhcSYWCw==
X-Received: by 2002:a05:6808:3c93:b0:3d9:4163:654f with SMTP id 5614622812f47-3def3faa314mr4399503b6e.32.1724785788361;
        Tue, 27 Aug 2024 12:09:48 -0700 (PDT)
Received: from localhost (fwdproxy-eag-003.fbsv.net. [2a03:2880:3ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225c95c3sm2672159b6e.46.2024.08.27.12.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:09:48 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Date: Tue, 27 Aug 2024 12:08:43 -0700
Message-ID: <6951e579322f1389bcc02de692a696880edb2a7e.1724785204.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1724785204.git.loemra.dev@gmail.com>
References: <cover.1724785204.git.loemra.dev@gmail.com>
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
index 75fa563e4cacb..babc86af564a2 100644
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
+DEFINE_FREE(btrfs_free_path, struct btrfs_path *, if (!IS_ERR_OR_NULL(_T)) btrfs_free_path(_T))
+#define BTRFS_PATH_AUTO_FREE(path_name) \
+	struct btrfs_path *path_name __free(btrfs_free_path) = NULL;
 
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   struct btrfs_path *path, int slot, int nr);
-- 
2.43.5


