Return-Path: <linux-btrfs+bounces-16034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B25B23C30
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 01:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64091AA6870
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871EE2D97B0;
	Tue, 12 Aug 2025 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="habhd/Yh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175D25A651
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039890; cv=none; b=B7uqqbPYLvoZPw1wv+KsX/+osltXtHo+E+sra4rfJppxFajvY0Quy+i/W+KZy+S9Da+Mv+tXN2cXpxdB1eP9UbWr+QoGbiINp+BmLCjGEDJ8qv4QrmlNp0ctmQ7N3/DGMJokbr9O1uMt3qe+HJ1UhzhBdBVyvk0Ogic+4iTUpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039890; c=relaxed/simple;
	bh=7Gt340sP/jC0Yjl8aOzE5A2rijA/j8QzkqyEvBcupNo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuzZDSURV7OpULRdAOEnR2xxqaUtjnD8Nc5zRrkeXpV4HW0k0z0SqwG5vTs0uo8sA4pKJTBdVFdhOIDIJECvFzUVgc6bQqOfYi4Ah7Dh4idnmNuBGWxER/zSzWAZsfOxE8XaPhhhJVu2B8+kFTDxJ/ovo535wTeo8023LEARnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=habhd/Yh; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8d96ff2dfaso5430632276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755039888; x=1755644688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlkPD45YHLVMerpSO49y2DlGY/erSjsHHH035NoRJt8=;
        b=habhd/Yhx5lIwxvTBjN8cXXIoLJC49OyVIkDpS88oDHfhWmTKqrW+4IuN/mCd0eT+V
         CvCZ9V/MMYkuYAz54eK44WsJGaakFFahmqmQV59n5BRrEODF8Cp4TOAX5yvsfPRJlOM6
         O6HD/fAgnETjjaEyNmMSvIc0cjRPIHsZvLvvZE5YUkA5ity9iHphadY7l5vRIdPF6MCU
         3iFrpQyg8UwvGC9k1I1XE7KdM580uzxKCUBYY+LXtb+kkvx/iVl1jn3YSOWfL8Cy3l2L
         un6+/EWBPURThjFu+p/1R/yVfB362JiGd71PrSoSPY3bvqjnj407rcf5DPjpOWrH07Nb
         XiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755039888; x=1755644688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlkPD45YHLVMerpSO49y2DlGY/erSjsHHH035NoRJt8=;
        b=aoJrRhi5U9QLL0DQblSl0YcvJzniINTmtKuuRIZL3PC0qIwmk63tLxnbHmwu0Bf50o
         tUhhTEvpGcRTu8dbi+/MfGwEyKVvH0N3VJqsN2CbWjHH9kGQHdRWcK6ncxsU0xyQMM57
         fqd83cV5Mdm962R75gvmW2HsiJy+sg8EnPnYpoYY7xfv1C6T/7ggQV77clZWvZjnp6fl
         52lrccmXO6BW7htC8+6T2poorY++5ovIl7Cpd8WqJ5HTOSQLj8/7zUnt2tg7FtixWizk
         LFR9QnGoP5iyap2CnNCJJosspEOBBdSitYsMdsb4wlsNirFN4cTwk9NOgUM5e/HhjYfe
         50FA==
X-Gm-Message-State: AOJu0Ywc/eT2h/Lc2Y9JaJ6U4AU9lIBAzqRVJP+4wBVSQE4Quv1si0uE
	rz4BrDzWVbJocyHEcx0E8PrxN3qAh9F9LGN3oEfY0qeOLCvSZoUfvz2jSiAqMNv+
X-Gm-Gg: ASbGnctESd2TZZf14RGDr2AwCfWxabBq00zFBe1nwqsfOqewMBBI7qmY8S3rCHlTdVs
	ndu9oFEXsA95gLB/Q3BeFQVm7XXu7IYF0YVlUbv2u5RiZohkbWY82hd5Fgq9Rfbxi8HwQgkGFnx
	yxhRh1m5B/IM0yJNhBV4+FZwMCVoVUVNZGIC2vfQ+YrnVdOkQPmr98ePzYTXiA0kGaWqfhCdlF9
	WNaEB7R3Q2EUucTIzVygf2VvsJISdMvYimKkA35jyn3CM5uHrgOa7agGAnn5ovojWQiw6+i5MOg
	AGm3kO62Hhket+QmhUJhW8yEM/ZnxOYWj2Q1ymOnM0I40t1cqiDkglUj5wHBpuFp1fVpelqC6dq
	e8AcNj7sOZBvCDC4IgA==
X-Google-Smtp-Source: AGHT+IEk+OtT/o+VWO+I8j8sCHm6V6LdK2NLB+KxKcgBHoJ0zYDCsG95AjvGxlLMRnR9TOqoZLpLcg==
X-Received: by 2002:a05:690c:700b:b0:71c:44eb:fae9 with SMTP id 00721157ae682-71d4e3f6901mr12045187b3.4.1755039888013;
        Tue, 12 Aug 2025 16:04:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bd21323c8sm42499877b3.23.2025.08.12.16.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 16:04:47 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 2/3] btrfs: print leaked references in kill_all_delayed_nodes
Date: Tue, 12 Aug 2025 16:04:40 -0700
Message-ID: <55b208aa0121b1edb285bd9de91937422c6d7f1c.1755035080.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755035080.git.loemra.dev@gmail.com>
References: <cover.1755035080.git.loemra.dev@gmail.com>
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
index a01f2ab59adb..651cefcc78a4 100644
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


