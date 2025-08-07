Return-Path: <linux-btrfs+bounces-15915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B211EB1DFDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 01:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E317F61F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 23:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5662701D6;
	Thu,  7 Aug 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNue68xP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0126B76C
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754610848; cv=none; b=go+BWf2PmbZzNsXi4xKDR36H75cmLxkiSRGI962VSz0L+1tpcY/m5czM3iNcVUMs/E2PrTJgalj6ac+NCrpZXGcwuRmJai2AdgwfXXoJR3gxAUJyLjF8jtlfOERIBJ17uGHsUtSQRf2jkjKzvwtVYhXNhAXAVYgvdKoGgciv2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754610848; c=relaxed/simple;
	bh=c4+0OXDqN22Z2tayCceLUVZARx4vYSQEOAWoNpt9IqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exQrgIFK3NLEdTWCBwjGzW/IQKShzB4RyvMDfk66YUUYWo5buDJp1SHlyaEaLiel17GbfKgXF5hN2tQ3AOCFaaAJTKIt4Ck/+CJyg4GsLrUf8d/oQ2Ikb8omMjbHPPLIOqABDxlfokvU/XZIQHsKrHxYzCPmX0cu6Z9OtuXPo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNue68xP; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e8bbb605530so2201982276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754610844; x=1755215644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTVbQKeRpw4+LA88ftizBizOc0PBdRI/TITlWBFmIYg=;
        b=dNue68xPd2HucWqlONsdIELyw3gtTBNdl8pFcwxZliHE1R5MHeHL+473Ke8LD1heQ8
         9bLTUanzHzla9CMkQg8PqAzk99AUVWZRY/ZfaMmuRcklQ0pndM//brRmv0rm8d9eM5RP
         SnIdhOfuBT1j6Crx1+ftUoG7KZ9pyFYNkJ/S/uG5DgkdrjLZ5/KYZpeSNzeE8wbiRHck
         vLk3ztlM2NteVGXMB9RX8gIQg4THgEoJSxUkv/hYCdjdovMn1Dm6CZrDpC0lYXy30lxE
         9uiGkAOqyiS8Be6R3nRLTq6PyFeQijEBPU9KrBKd0z3Jq7wtYlxX6XCLtfdTp3gF1M7W
         4qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754610844; x=1755215644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTVbQKeRpw4+LA88ftizBizOc0PBdRI/TITlWBFmIYg=;
        b=BmzCzKwbGQDQprAI6DHN67VYajYSmVtS3vA1pUYWUozeeB5FPDwnaG2phpRdUWNPPd
         OwRrgbLcBsSC1X7vuXb9R4WiztOQKIcP49m0SEVBv+oxbKqlei3y0ocvpexorMgQXhi1
         y2q877xk0+f187KNqip6Nv31dAViEfALgACr4MfkWnbTDRYkhqgy/nDx34e4fZWAg/CM
         YUc75w5MinDD4YqNxf5YfVDfg8SKrb3JXrLmE04j73cBVnmKGnG5ParxA6jYcJr+onjg
         4K2SsainQfdy09TrEvaWZlQkVP5/QMbsVofEKuxT/YjjTAsxKd7lOWwqFrPJWAOjamnH
         Tb4A==
X-Gm-Message-State: AOJu0YxE2IWHgIkJ/Qt1utWgfq+YmnAFYnHUZCNlyLY30P+5XQHGnc9X
	6AXpGHnI2PZl7x8XonX5q2/1GtodLuvNugfoTzGF/FzlOxVmzUuwOESaEN34UT5j
X-Gm-Gg: ASbGnctiQ1eC8iHeEiLfumzYTXUEFmiNqUt8y4hqRReSixhcetqN8Bfu+Ko5u767zZR
	Rlethlrt6kijFeZpFcm+70iJnb9LjS4JKL1CNGfavaAFoISMDHrPXfBQPi6ocpReDlCHMYk2Wyr
	CkPTd6Os4AZJ8FjXgsXn0szpi0rZGcbipkxNHH5LlBwstFAPmJk3wjREvruZuZx0sE5Us+iQ0Aj
	zFQ8fORrmMRoxD5UA0KhTZ9zwpGl5AeO4917+sRH4PhkRsmXSApAHQkB/wDiXh4iBiDWmmH4stf
	OFdFRvLyhUMAgnVwR0m+QpvpwPD8TqqCSTwfhItJxaq6SmOnNH37nXlp0ZcZT+1QC+Rk9b1vDky
	MnsSpQcyBTB9pdrwslUcaprBXQ0A=
X-Google-Smtp-Source: AGHT+IGHz4g949OWNlQQguGJ7cImzAa7CpwkMaPs+bf4YSk5+jpWdkx04Ai5TDUhD4woDLU4j/CbyQ==
X-Received: by 2002:a05:690c:6708:b0:713:fe84:6f96 with SMTP id 00721157ae682-71bdaf7479dmr67782967b3.14.1754610844144;
        Thu, 07 Aug 2025 16:54:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5984fasm49477837b3.44.2025.08.07.16.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 16:54:03 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 2/3] btrfs: print leaked references in kill_all_delayed_nodes
Date: Thu,  7 Aug 2025 16:53:55 -0700
Message-ID: <4a0d08a0294e5df84d379102d850507f95de35c9.1754609966.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1754609966.git.loemra.dev@gmail.com>
References: <cover.1754609966.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are seeing softlockups in kill_all_delayed_nodes due to
a delayed_node with a lingering reference count of 1. Printing
at this point will reveal the guilty stack trace. If the
delayed_node has no references there should be no output.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.c | 1 +
 fs/btrfs/delayed-inode.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c4696c2d5b34..f665434e1963 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -2129,6 +2129,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
 			__btrfs_kill_delayed_node(delayed_nodes[i]);
 			btrfs_release_delayed_node(delayed_nodes[i],
 						   &delayed_node_trackers[i]);
+			btrfs_delayed_node_ref_tracker_dir_print(delayed_nodes[i]);
 		}
 	}
 }
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 171b75eb1850..d62811db2a38 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -208,6 +208,12 @@ static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_
 	ref_tracker_dir_exit(&node->ref_dir.dir);
 }
 
+static inline void btrfs_delayed_node_ref_tracker_dir_print(struct btrfs_delayed_node *node)
+{
+	ref_tracker_dir_print(&node->ref_dir.dir,
+			      BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT);
+}
+
 static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
 						       struct btrfs_ref_tracker *tracker,
 						       gfp_t gfp)
@@ -225,6 +231,8 @@ static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_
 
 static inline void btrfs_delayed_node_ref_tracker_dir_exit(struct btrfs_delayed_node *node) { }
 
+static inline void btrfs_delayed_node_ref_tracker_dir_print(struct btrfs_delayed_node *node) { }
+
 static inline int btrfs_delayed_node_ref_tracker_alloc(struct btrfs_delayed_node *node,
 						       struct btrfs_ref_tracker *tracker,
 						       gfp_t gfp)
-- 
2.47.3


