Return-Path: <linux-btrfs+bounces-7797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9016D96A662
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 20:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85EAB214BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB611917EC;
	Tue,  3 Sep 2024 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RstG/XqM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CAD191477
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387644; cv=none; b=NWnXB1sAKFCxk3DhDp18kRLTDLl6jlxJnvgv0X+lKpN6V7CjqrY6L7WmGiOoQyiY2YYcojsuJX3XEEW9DawrYycbvKHzBe3bpVcsgHVR7+jX6q2yqaxzq7Ox275XDY59BSG2L0C6oVjmMdlaYBVwwTUl7pEl+/An7FOpEybSswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387644; c=relaxed/simple;
	bh=clbmW1IBOaDLzgD9lVizc5tzFAeT7qVHCtvJ6QkBNT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MscTMHIIiAVC7FvthMs/QIWWkhxUkXA19ZJC38UeIXew2oaEPgt2fjX12TiUFeLmGj0mX80jcy81dYB1v9+crcMf53s4XKkGB0wRu8J4XBvemBIFKGDuKh4Reg9taZJyDu5LtXckfSb8vQbl4VaQTyRIVuRVvuUwkaba16x7Ovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RstG/XqM; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-5df9a9f7fe2so3549920eaf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387640; x=1725992440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xbSRqu1Ja0gILZro/cH2E2bBk7KK/AeI8IlJAsCAks=;
        b=RstG/XqMRljECboj4jSpFoe6XeVrGEiVa3K/w10u3rrBWG+Fks4LWQ8lRNWdIJtER8
         qxQRGoFInWUyI0RA3OHK2unUiM3PB2C0E1zIU2wxjrZSlXvTAAOD8JmEb0DUvNnBzGv/
         Yz7ocbGpTahXKAZHqpljfci0ExFU55XPg4TtEvvoXJXlgHWVbUR7/CMnxRXWEThVoC06
         5b2IkNJ8ucZmR57U6f+UbEsl+kFQIoc0ipEdm1v+xfdtCNwexX9sbw4ZnTPx05t02/Ai
         2aTqXGY01dxw+g2sMORltnGFDaMQKbwkuiY+w54RHxQU/vMGpU/rCys7Jz9zPPvpa66e
         sjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387640; x=1725992440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xbSRqu1Ja0gILZro/cH2E2bBk7KK/AeI8IlJAsCAks=;
        b=jpDSu+vOJB4D4rxNI7UVny4zKvK6JcoFdEtObbfbjawwolaye3gcgFlOiAiO1we+0b
         Yj05Rk5jhbUOavP1Whzke58ldFslno3Du/OOnyGo/Q3EhNdiicaLwvd4N3eMTQbZRwqK
         5veIZrLhwbuToCmz5hIODaRSjImJ0ZfMkjoTlt0BNbuJUGVs2FGMV9xOqrL3OGBZ3HC+
         OIiHrgE29efeYA5USmFQJW+FeCG4su2T4EOJwelUbrUDPeKbwqpKk+jBidqovqGpvwVK
         4gscAccGXWZsNmKClQk/U7t9VLpHi/4ksqWnfauUw/uVyeinEgQM1NPCRvi6N6I+JzEE
         Ua1g==
X-Gm-Message-State: AOJu0YxzW8wa0rsV/FxdzpYhpzJxHp6kPLPqVCF7HH5tWMdqt4lIea8y
	JbfbNHWOO5z8V3EE8Ao7oPnD15tWpbreTP+jbq8BINNNNcrQ/10UEFbc7w9F
X-Google-Smtp-Source: AGHT+IH5uYYKrCfDGyD8Wh8hNJxqaNHu0a/8RleZgMX2jOFogsl1OCHlToHTsgblW8GUSkAopqFqoA==
X-Received: by 2002:a05:6820:168d:b0:5da:9bde:1c0b with SMTP id 006d021491bc7-5dfacc16c7cmr16848333eaf.0.1725387640471;
        Tue, 03 Sep 2024 11:20:40 -0700 (PDT)
Received: from localhost (fwdproxy-eag-112.fbsv.net. [2a03:2880:3ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dfa049d050sm2159128eaf.18.2024.09.03.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:20:40 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 1/3] btrfs: DEFINE_FREE for btrfs_free_path
Date: Tue,  3 Sep 2024 11:19:05 -0700
Message-ID: <0d93fe7692452725d0ec550b7b01ed0a68b9c600.1725386993.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1725386993.git.loemra.dev@gmail.com>
References: <cover.1725386993.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CHANGELOG:
Move BTRFS_PATH_AUTO_FREE macro definition next to btrfs_path struct.

Add a DEFINE_FREE for btrfs_free_path. This defines a function that can
be called using the __free attribute. Defined a macro
BTRFS_PATH_AUTO_FREE to make the declaration of an auto freeing path
very clear.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/ctree.c | 2 +-
 fs/btrfs/ctree.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index c8568b1a61c43..7a7b051e994ac 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_CTREE_H
 #define BTRFS_CTREE_H
 
+#include "linux/cleanup.h"
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
@@ -84,6 +85,9 @@ struct btrfs_path {
 	unsigned int nowait:1;
 };
 
+#define BTRFS_PATH_AUTO_FREE(path_name) \
+	struct btrfs_path *path_name __free(btrfs_free_path) = NULL;
+
 /*
  * The state of btrfs root
  */
@@ -598,6 +602,7 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 void btrfs_release_path(struct btrfs_path *p);
 struct btrfs_path *btrfs_alloc_path(void);
 void btrfs_free_path(struct btrfs_path *p);
+DEFINE_FREE(btrfs_free_path, struct btrfs_path *, btrfs_free_path(_T))
 
 int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   struct btrfs_path *path, int slot, int nr);
-- 
2.43.5


