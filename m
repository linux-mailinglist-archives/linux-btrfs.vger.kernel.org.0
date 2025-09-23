Return-Path: <linux-btrfs+bounces-17100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C355FB93CDB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 03:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2602E159A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173C1E501C;
	Tue, 23 Sep 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAELHpeb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC61DB54C
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590004; cv=none; b=FflAPScp5kyBskRG0pztpOCrN33yPzaF4wmnPkkUfPMRZjTvI2Izb5FG1Vy9aiQ6//AGlzcOaQ3oh//gyqn0VBIaBA9qn0gdO1YLdI3kJ+G0uOK7PyfE4q6pqrSN6keluwEroSqYOB7b2rOIdXiFkxgrsbSqibdNy+jDr64HC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590004; c=relaxed/simple;
	bh=PvmKEkofrgJIz28reYjVOEQ6K7wpCqj1YlAzvulspG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKzuL3iQk9XT9Y2VfnF/0i6wBM6hGLNk5c9lPkkS1qujNFI+86EGzwsVFDsbMlq/Go9XoH4lBzUCKE6eYPc1Gp+v1yJtQ+z9DWhMk9QKgOy/WuOo0++8NEhk0X1UdChJi97s/AV5yqpWVs+dOAZXdLw24VbVOe8R1wx0K94sSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAELHpeb; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71d6014810fso37619197b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 18:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758590001; x=1759194801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DumjeoZV7pwC3BgWNMW3QMQ+6FASmJ+L+JJW1v4cgFE=;
        b=nAELHpebVeN31Ny0nYoSt14+QCfyXWdD2Uc+dm3wuqgK8+4qPuvE1DXY8AfRB8XKsN
         RFWQVUifODO+9F3qB2C8jBXGoOSIvdIgJ7u39LUfm6diakXNh5DyTfbE3Ud5RGohYyzD
         5h/yJB/NActe8xpkdDoBtls/3YFdbFD838QxoOd3m1W2MaS9obA+uXJWuANYbyVKL1wq
         GTPZmysVo1bH24CGNrcQmTdcZATMu/9sVqIW9QvrUWyGHLOtmKWJkIxNTs81qZTNsKny
         OU2I5XQRfYmGL2TyCiAucrMOIdcoDESxHwmV1D72J1fFsnayCWvSGzf/g7IWClF6HQwM
         2dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590001; x=1759194801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DumjeoZV7pwC3BgWNMW3QMQ+6FASmJ+L+JJW1v4cgFE=;
        b=o7QFR7fqDeP4GcUiVa2mkoEGksY6hi90Cjhp6x0N1z6/BBeURllyczJv9WaUNl8uo+
         U8E+PXCdW7eSqQz0Ek+QxsRh5SxvlK2skTrI0MzVXQplhcnLGnOZfG14vv7fjti9c7Bp
         mWJvlVNl9Ll8PlSZdOpi8M8VvdAgVmlz2aY3muYxu4v9qS3a6jXAzcbyKWVVKXct9FWA
         yU3oongcIssJsFW3M3SBbz0aacYfLWbKBKmaWyzezK4B2fLjWfcw0jUmDZvi7gcg2Oyi
         88+Bze4a7WQXg5C1jaxDsz2MRWf5MKd0FoEIt6xJL5sG/0i8mNQb5GPyuAFvGD8Lbc6I
         +OlQ==
X-Gm-Message-State: AOJu0YxszDZmPxOISTlO9QWFcoxuVtGw/NJYYJaKEcEIWE/7+Yh765ZT
	HyTlBCbpAX2P2xkK5XUy6CucCP50J9WOgApBVSolUY3390Jwg8I6uu/p8Hje9r0+
X-Gm-Gg: ASbGncuphs7dEEtFesuHcYQ/SSeGLMNAqIa86ATbliizl7v/tEvryL+fdScKFJB/u2j
	ll1lhK4S7Ul3aNUvoK5VMUxdarpjDM80gOS82nE3PTxQsxgTYFGEdwWm7FyjFn5iKgNYjpXK3Dv
	9C/o2c9U+HchD6fm/VPohqfAlzFm1uJooZs+yZBqotG8quSpseszK3ws0pps5bPSGdklRQqrJZx
	2BGXwcuEty0Fy3AQwoxs6CeLGE9+zt6K815NyufCOMbmxv3CC5GY7ox5WM++ohNviooglO4xD1w
	khEW0wtNDfcUi9W+I8SWtERBfck0RDIsGNjXXisbF/ayLgMcrgwmSA4u/zFYGiS3JHGkKk8I9GH
	d6vQ5jmzc/Zm6IhZ8
X-Google-Smtp-Source: AGHT+IHqtIg1lBn/V8vBnahQylw88h69RPdLsJyaQDS0CzM/aOK8Hr7uMF+DkLMv3Q4NFAp2rX9XgA==
X-Received: by 2002:a05:690c:6c08:b0:71f:d792:608e with SMTP id 00721157ae682-75891d12c41mr7926147b3.10.1758590000973;
        Mon, 22 Sep 2025 18:13:20 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-73971887fe8sm37628867b3.50.2025.09.22.18.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:13:20 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: add tracing for find_free_extent skip conditions
Date: Mon, 22 Sep 2025 18:13:15 -0700
Message-ID: <7d0be9ae8855ddc20bc18f15234b9c527cf3d64a.1758587352.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1758587352.git.loemra.dev@gmail.com>
References: <cover.1758587352.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add detailed tracing to the find_free_extent() function to improve
observability of extent allocation behavior. This patch introduces:

- A new trace event 'btrfs_find_free_extent_skip' that captures
  allocation context and skip reasons
- Comprehensive set of FFE_SKIP_* constants defining specific
  reasons why block groups are skipped during allocation
- Trace points at all major skip conditions in the allocator loop

The trace event includes key allocation parameters (root, size, flags,
loop iteration) and block group details (start, length, flags) along
with the specific skip reason and associated error codes.

These trace points will help diagnose allocation performance
issues, understand allocation patterns, and debug extent allocator
behavior.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/extent-tree.c       | 36 +++++++++++++++++---
 fs/btrfs/extent-tree.h       | 18 ++++++++++
 include/trace/events/btrfs.h | 65 ++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 072d9bb84dd8..ed50f7357f19 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4425,8 +4425,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	}
 
 	ret = prepare_allocation(fs_info, ffe_ctl, space_info, ins);
-	if (ret < 0)
+	if (ret < 0) {
+		trace_btrfs_find_free_extent_skip(root, ffe_ctl, NULL,
+						  FFE_SKIP_PREPARE_ALLOC_FAILED, ret);
 		return ret;
+	}
 
 	ffe_ctl->search_start = max(ffe_ctl->search_start,
 				    first_logical_byte(fs_info));
@@ -4453,6 +4456,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 				 * target because our list pointers are not
 				 * valid
 				 */
+				trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+								  FFE_SKIP_HINTED_BG_INVALID, 0);
 				btrfs_put_block_group(block_group);
 				up_read(&space_info->groups_sem);
 			} else {
@@ -4464,6 +4469,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 				goto have_block_group;
 			}
 		} else if (block_group) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_HINTED_BG_INVALID, 0);
 			btrfs_put_block_group(block_group);
 		}
 	}
@@ -4478,6 +4485,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ffe_ctl->hinted = false;
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro)) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_READ_ONLY, 0);
 			if (ffe_ctl->for_treelog)
 				btrfs_clear_treelog_bg(block_group);
 			if (ffe_ctl->for_data_reloc)
@@ -4489,6 +4498,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ffe_ctl->search_start = block_group->start;
 
 		if (!block_group_bits(block_group, ffe_ctl->flags)) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_WRONG_FLAGS, 0);
 			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 			continue;
 		}
@@ -4508,6 +4519,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			 * error that caused problems, not ENOSPC.
 			 */
 			if (ret < 0) {
+				trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+								  FFE_SKIP_BG_CACHE_ERROR, ret);
 				if (!cache_block_group_error)
 					cache_block_group_error = ret;
 				ret = 0;
@@ -4517,18 +4530,26 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_CACHE_ERROR, -EIO);
 			if (!cache_block_group_error)
 				cache_block_group_error = -EIO;
 			goto loop;
 		}
 
-		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
+		if (!find_free_extent_check_size_class(ffe_ctl, block_group)) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_SIZE_CLASS_MISMATCH, 0);
 			goto loop;
+		}
 
 		bg_ret = NULL;
 		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
-		if (ret > 0)
+		if (ret > 0) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_DO_ALLOCATION_FAILED, ret);
 			goto loop;
+		}
 
 		if (bg_ret && bg_ret != block_group) {
 			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
@@ -4542,22 +4563,29 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		/* move on to the next group */
 		if (ffe_ctl->search_start + ffe_ctl->num_bytes >
 		    block_group->start + block_group->length) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_EXTENDS_BEYOND_BG, 0);
 			btrfs_add_free_space_unused(block_group,
 					    ffe_ctl->found_offset,
 					    ffe_ctl->num_bytes);
 			goto loop;
 		}
 
-		if (ffe_ctl->found_offset < ffe_ctl->search_start)
+		if (ffe_ctl->found_offset < ffe_ctl->search_start) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_FOUND_BEFORE_SEARCH_START, 0);
 			btrfs_add_free_space_unused(block_group,
 					ffe_ctl->found_offset,
 					ffe_ctl->search_start - ffe_ctl->found_offset);
+		}
 
 		ret = btrfs_add_reserved_bytes(block_group, ffe_ctl->ram_bytes,
 					       ffe_ctl->num_bytes,
 					       ffe_ctl->delalloc,
 					       ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS);
 		if (ret == -EAGAIN) {
+			trace_btrfs_find_free_extent_skip(root, ffe_ctl, block_group,
+							  FFE_SKIP_ADD_RESERVED_FAILED, -EAGAIN);
 			btrfs_add_free_space_unused(block_group,
 					ffe_ctl->found_offset,
 					ffe_ctl->num_bytes);
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index e970ac42a871..667581c454a3 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -23,6 +23,24 @@ enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
+/*
+ * Enum for find_free_extent skip reasons used in trace events.
+ * Each enum corresponds to a specific unhappy path in the allocator.
+ */
+enum {
+	FFE_SKIP_PREPARE_ALLOC_FAILED,
+	FFE_SKIP_HINTED_BG_INVALID,
+	FFE_SKIP_BG_READ_ONLY,
+	FFE_SKIP_BG_WRONG_FLAGS,
+	FFE_SKIP_BG_CACHE_FAILED,
+	FFE_SKIP_BG_CACHE_ERROR,
+	FFE_SKIP_SIZE_CLASS_MISMATCH,
+	FFE_SKIP_DO_ALLOCATION_FAILED,
+	FFE_SKIP_EXTENDS_BEYOND_BG,
+	FFE_SKIP_FOUND_BEFORE_SEARCH_START,
+	FFE_SKIP_ADD_RESERVED_FAILED,
+};
+
 struct find_free_extent_ctl {
 	/* Basic allocation info */
 	u64 ram_bytes;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 7e418f065b94..39544a706654 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -103,6 +103,18 @@ struct find_free_extent_ctl;
 	EM( COMMIT_TRANS,		"COMMIT_TRANS")			\
 	EMe(RESET_ZONES,		"RESET_ZONES")
 
+#define FIND_FREE_EXTENT_SKIP_REASONS						\
+	EM( FFE_SKIP_PREPARE_ALLOC_FAILED,	"PREPARE_ALLOC_FAILED")		\
+	EM( FFE_SKIP_HINTED_BG_INVALID,		"HINTED_BG_INVALID")		\
+	EM( FFE_SKIP_BG_READ_ONLY,		"BG_READ_ONLY")			\
+	EM( FFE_SKIP_BG_WRONG_FLAGS,		"BG_WRONG_FLAGS")		\
+	EM( FFE_SKIP_BG_CACHE_ERROR,		"BG_CACHE_ERROR")		\
+	EM( FFE_SKIP_SIZE_CLASS_MISMATCH,	"SIZE_CLASS_MISMATCH")		\
+	EM( FFE_SKIP_DO_ALLOCATION_FAILED,	"DO_ALLOCATION_FAILED")		\
+	EM( FFE_SKIP_EXTENDS_BEYOND_BG,		"EXTENDS_BEYOND_BG")		\
+	EM( FFE_SKIP_FOUND_BEFORE_SEARCH_START,	"FOUND_BEFORE_SEARCH_START")	\
+	EMe(FFE_SKIP_ADD_RESERVED_FAILED,	"ADD_RESERVED_FAILED")
+
 /*
  * First define the enums in the above macros to be exported to userspace via
  * TRACE_DEFINE_ENUM().
@@ -118,6 +130,7 @@ FI_TYPES
 QGROUP_RSV_TYPES
 IO_TREE_OWNER
 FLUSH_STATES
+FIND_FREE_EXTENT_SKIP_REASONS
 
 /*
  * Now redefine the EM and EMe macros to map the enums to the strings that will
@@ -1388,6 +1401,58 @@ DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
 	TP_ARGS(block_group, ffe_ctl)
 );
 
+TRACE_EVENT(btrfs_find_free_extent_skip,
+
+	TP_PROTO(const struct btrfs_root *root,
+		 const struct find_free_extent_ctl *ffe_ctl,
+		 const struct btrfs_block_group *block_group,
+		 int reason,
+		 s64 error_or_value),
+
+	TP_ARGS(root, ffe_ctl, block_group, reason, error_or_value),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root_objectid		)
+		__field(	u64,	num_bytes		)
+		__field(	u64,	empty_size		)
+		__field(	u64,	flags			)
+		__field(	int,	loop			)
+		__field(	bool,	hinted			)
+		__field(	int,	size_class		)
+		__field(	u64,	bg_start		)
+		__field(	u64,	bg_length		)
+		__field(	u64,	bg_flags		)
+		__field(	int,	reason			)
+		__field(	s64,	error_or_value		)
+	),
+
+	TP_fast_assign_btrfs(root->fs_info,
+		__entry->root_objectid	= btrfs_root_id(root);
+		__entry->num_bytes	= ffe_ctl->num_bytes;
+		__entry->empty_size	= ffe_ctl->empty_size;
+		__entry->flags		= ffe_ctl->flags;
+		__entry->loop		= ffe_ctl->loop;
+		__entry->hinted		= ffe_ctl->hinted;
+		__entry->size_class	= ffe_ctl->size_class;
+		__entry->bg_start	= block_group ? block_group->start : 0;
+		__entry->bg_length	= block_group ? block_group->length : 0;
+		__entry->bg_flags	= block_group ? block_group->flags : 0;
+		__entry->reason		= reason;
+		__entry->error_or_value	= error_or_value;
+	),
+
+	TP_printk_btrfs(
+"root=%llu(%s) len=%llu empty_size=%llu flags=%llu(%s) loop=%d hinted=%d size_class=%d bg=[%llu+%llu] bg_flags=%llu(%s) reason=%s error_or_value=%lld",
+		  show_root_type(__entry->root_objectid),
+		  __entry->num_bytes, __entry->empty_size, __entry->flags,
+		  __print_flags((unsigned long)__entry->flags, "|", BTRFS_GROUP_FLAGS),
+		  __entry->loop, __entry->hinted, __entry->size_class,
+		  __entry->bg_start, __entry->bg_length, __entry->bg_flags,
+		  __print_flags((unsigned long)__entry->bg_flags, "|", BTRFS_GROUP_FLAGS),
+		  __print_symbolic(__entry->reason, FIND_FREE_EXTENT_SKIP_REASONS),
+		  __entry->error_or_value)
+);
+
 TRACE_EVENT(btrfs_find_cluster,
 
 	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
-- 
2.47.3


