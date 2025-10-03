Return-Path: <linux-btrfs+bounces-17423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC4BB86D3
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A14A7AA3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80C27B330;
	Fri,  3 Oct 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSIR1aLF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A166276059
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534939; cv=none; b=A8TYxU6duGuzWAyjPpf+hpylfkDACev9vBVQRTkMzzbTZTB4llrncsZXcqXkbMqowZY4tOvCL34GRYoiSRE7Dbj8YsMT8XiauLr8LXwbi4JyzRzMjSeuTDmU/8btc9uBzlSAvUA8KfKUKhb0nMFrSMr+SuTe3uhzdrDgcvPldE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534939; c=relaxed/simple;
	bh=yD0V5TAIz7FVTUtN82rjTlVClMmVEr4jofra6F6i2aw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6jDkLsh7x4HieR7KFbeItV74Yzqv1Kv0QonYhWe2FMo2NJemWHrsw5tycBSEO8VnTNrl3eKeMm65OxRd4wDtwD4VYC5oj3MzF60Ahe1FS7GX86LMuqyc9+U9wNnKieAa28c+F2YAVOBryJ/tjvvSB9ATV9hgjFdYoHfBmDCHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSIR1aLF; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-636d5cefab2so4044846d50.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534936; x=1760139736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKKibHX17l43IGovFmmK0iuNqOcuVEDivov07keCNPk=;
        b=GSIR1aLFkM3o4bdqO6VgEHJOrnyEqxFNP2GK0ewoZq6i0UrQXuxgSslUyKfEX78wEB
         TfD6hKVnPYfn68rSFKdWwLCHlFlMTv/vIkyxzgSKdfHfXMD43oa95FTcZnbQae+3uu0s
         2UEoUQnLFTj1zhcgiMo+Q8N92cwzA4ajYjDZEw0mjd017iB7dJrirwybbEHcANQpDbaX
         yyA4czJrqXRasGUuTIEsqGGkQaJaCtRrMty+0l87dn0wTxgnZxQY3H2IDsOaSKAJ7qPh
         U+/wrvrCUVJtmOHJ1j2ZdT0IUbdd00W+FRxozYtYtnq/VZpftCqJl+Z2WJsLvPLjzWwR
         9aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534936; x=1760139736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKKibHX17l43IGovFmmK0iuNqOcuVEDivov07keCNPk=;
        b=XcchQqhfsCf7g4rSC3JO3XrkkoKNItSIdXyTbQV1YEmP26w3CHyncErH9eyw+cilKJ
         a8JT0Q3b7biM+sexXhqL8l3+IuJ8R2UwDtnEDwj2/SDcdSvyZxXi9M0WA08Slg27TnGh
         ZD/JrZWJVNLOJY29iudxqEKYUCdXFPZCEDhxXmMWpDwu1IwsuTXh4L/dmCMX2e1DJSFy
         Jr2UpeRv9obDM/h5m/J8s+GowFSyNNMWltPlo7PYKKn5Yqbd9/T/cXuuxUspeSyjZHLL
         F7jeV8ubiY18tEQ0Oap4vjYHZVyJfW3VA1whc0keTls7CyXdC+InjzhPW2yd+iAGMZO9
         iN3Q==
X-Gm-Message-State: AOJu0YxHlJNFk6nhlSsg9piMJwTsSAPz1MPL6VKW22iUJUoUn6RPqX0p
	SvIiHN1Y0aCJat3C4DasU7PSvrsoQfFYHwqcuW9TehEoOrxIWzGikku/V6cJXdrC
X-Gm-Gg: ASbGncselqHC3is87UIDwyCs69G0CvA129mY960/Lk41EN76EjPiXeSn+loTL4C7sE2
	VMG3H4iTJDusCdboroJZLnLglMfHyIHTmWxwk532CRzzhUmSIScgM4BnUjjkQRaFO1SEJEO9FW+
	B/g307BtNUxQ8IJPGxOY/DPLZd9Uq8xtIqvEYLzzDCb7tzQ/7tC6kIG6OZ1NKCVm39gwYLPmU4+
	aQZ/RQlQjCy912sTf0160bylaad4w1pU2HjR0uukghyMu0ujjmqWbdZr+lLMkFQzjKPvwpB04O2
	xvC1+KUvCJX4HPF2HwbRNS9YXwGHchHG0vKK8ZCDfAeD2jrGzHJwOvIDei6e7mda/5GFVYZXWRN
	HWVjFc5IyEvTeCydTJhZoUXiDVnS1jM9T9E/en+Ed
X-Google-Smtp-Source: AGHT+IG1B42mON3MfMxwlY04DQlQGBvjdyA686oPOdhbxS/s16KKM1y7P1V3qZegXU3RD3N/iQqKpA==
X-Received: by 2002:a05:690e:155b:10b0:636:d520:32e3 with SMTP id 956f58d0204a3-63b9a0724bdmr4018987d50.1.1759534936017;
        Fri, 03 Oct 2025 16:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b8468f069sm2124345d50.17.2025.10.03.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:42:15 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: add tracing for find_free_extent skip conditions
Date: Fri,  3 Oct 2025 16:41:58 -0700
Message-ID: <e5bb7036ec9f54f4ff862327d3ff3ccc9128077d.1759532729.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759532729.git.loemra.dev@gmail.com>
References: <cover.1759532729.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add detailed tracing to the find_free_extent() function to improve
observability of extent allocation behavior. This patch introduces:

- A new trace event btrfs_find_free_extent_skip_block_group() that 
  captures
  allocation context and skip reasons
- Comprehensive set of FFE_SKIP_BG_* constants defining specific
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
 fs/btrfs/extent-tree.c       | 38 +++++++++++++++++++--
 fs/btrfs/extent-tree.h       | 17 ++++++++++
 include/trace/events/btrfs.h | 66 ++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 28b442660014..3b6d57d39bd5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4455,6 +4455,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 				 * target because our list pointers are not
 				 * valid
 				 */
+				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+								  FFE_SKIP_BG_REMOVING, 0);
 				btrfs_put_block_group(block_group);
 				up_read(&space_info->groups_sem);
 			} else {
@@ -4466,6 +4468,15 @@ static noinline int find_free_extent(struct btrfs_root *root,
 				goto have_block_group;
 			}
 		} else if (block_group) {
+			if (!block_group_bits(block_group, ffe_ctl->flags))
+				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+								  FFE_SKIP_BG_WRONG_FLAGS, block_group->flags & ~ffe_ctl->flags);
+			else if (block_group->space_info != space_info)
+				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+								  FFE_SKIP_BG_WRONG_SPACE_INFO, 0);
+			else if (block_group->cached == BTRFS_CACHE_NO)
+				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+								  FFE_SKIP_BG_NOT_CACHED, 0);
 			btrfs_put_block_group(block_group);
 		}
 	}
@@ -4481,6 +4492,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ffe_ctl->hinted = false;
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro)) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_READ_ONLY, 0);
 			if (ffe_ctl->for_treelog)
 				btrfs_clear_treelog_bg(block_group);
 			if (ffe_ctl->for_data_reloc)
@@ -4492,6 +4505,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		ffe_ctl->search_start = block_group->start;
 
 		if (!block_group_bits(block_group, ffe_ctl->flags)) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_WRONG_FLAGS, block_group->flags & ~ffe_ctl->flags);
 			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 			continue;
 		}
@@ -4511,6 +4526,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 			 * error that caused problems, not ENOSPC.
 			 */
 			if (ret < 0) {
+				trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+								  FFE_SKIP_BG_CACHE_ERROR, ret);
 				if (!cache_block_group_error)
 					cache_block_group_error = ret;
 				ret = 0;
@@ -4520,18 +4537,26 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		}
 
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR)) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_CACHE_ERROR, -EIO);
 			if (!cache_block_group_error)
 				cache_block_group_error = -EIO;
 			goto loop;
 		}
 
-		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
+		if (!find_free_extent_check_size_class(ffe_ctl, block_group)) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_SIZE_CLASS_MISMATCH, block_group->size_class);
 			goto loop;
+		}
 
 		bg_ret = NULL;
 		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
-		if (ret > 0)
+		if (ret > 0) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_DO_ALLOCATION_FAILED, ret);
 			goto loop;
+		}
 
 		if (bg_ret && bg_ret != block_group) {
 			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
@@ -4545,22 +4570,29 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		/* move on to the next group */
 		if (ffe_ctl->search_start + ffe_ctl->num_bytes >
 		    block_group->start + block_group->length) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_SEARCH_BOUNDS, block_group->start + block_group->length);
 			btrfs_add_free_space_unused(block_group,
 					    ffe_ctl->found_offset,
 					    ffe_ctl->num_bytes);
 			goto loop;
 		}
 
-		if (ffe_ctl->found_offset < ffe_ctl->search_start)
+		if (ffe_ctl->found_offset < ffe_ctl->search_start) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							FFE_SKIP_BG_SEARCH_BOUNDS, ffe_ctl->found_offset);
 			btrfs_add_free_space_unused(block_group,
 					ffe_ctl->found_offset,
 					ffe_ctl->search_start - ffe_ctl->found_offset);
+		}
 
 		ret = btrfs_add_reserved_bytes(block_group, ffe_ctl->ram_bytes,
 					       ffe_ctl->num_bytes,
 					       ffe_ctl->delalloc,
 					       ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS);
 		if (ret == -EAGAIN) {
+			trace_btrfs_find_free_extent_skip_block_group(root, ffe_ctl, block_group,
+							  FFE_SKIP_BG_ADD_RESERVED_FAILED, -EAGAIN);
 			btrfs_add_free_space_unused(block_group,
 					ffe_ctl->found_offset,
 					ffe_ctl->num_bytes);
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index e970ac42a871..4f1dc077b7c9 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -23,6 +23,23 @@ enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_ZONED,
 };
 
+/*
+ * Enum for find_free_extent skip reasons used in trace events.
+ * Each enum corresponds to a specific unhappy path in the allocator.
+ */
+enum {
+	FFE_SKIP_BG_REMOVING,
+	FFE_SKIP_BG_READ_ONLY,
+	FFE_SKIP_BG_WRONG_SPACE_INFO,
+	FFE_SKIP_BG_WRONG_FLAGS,
+	FFE_SKIP_BG_NOT_CACHED,
+	FFE_SKIP_BG_CACHE_ERROR,
+	FFE_SKIP_BG_SIZE_CLASS_MISMATCH,
+	FFE_SKIP_BG_DO_ALLOCATION_FAILED,
+	FFE_SKIP_BG_SEARCH_BOUNDS,
+	FFE_SKIP_BG_ADD_RESERVED_FAILED,
+};
+
 struct find_free_extent_ctl {
 	/* Basic allocation info */
 	u64 ram_bytes;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 7e418f065b94..72aa250983d4 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -103,6 +103,19 @@ struct find_free_extent_ctl;
 	EM( COMMIT_TRANS,		"COMMIT_TRANS")			\
 	EMe(RESET_ZONES,		"RESET_ZONES")
 
+#define FIND_FREE_EXTENT_SKIP_REASONS						\
+	EM( FFE_SKIP_BG_REMOVING,		"BG_REMOVING")			\
+	EM( FFE_SKIP_BG_READ_ONLY,		"BG_READ_ONLY")			\
+	EM( FFE_SKIP_BG_WRONG_SPACE_INFO,	"BG_WRONG_SPACE_INFO")		\
+	EM( FFE_SKIP_BG_WRONG_FLAGS,		"BG_WRONG_FLAGS")		\
+	EM( FFE_SKIP_BG_NOT_CACHED,		"BG_NOT_CACHED")		\
+	EM( FFE_SKIP_BG_CACHE_ERROR,		"BG_CACHE_ERROR")		\
+	EM( FFE_SKIP_BG_SIZE_CLASS_MISMATCH,	"BG_SIZE_CLASS_MISMATCH")	\
+	EM( FFE_SKIP_BG_DO_ALLOCATION_FAILED,	"BG_DO_ALLOCATION_FAILED")	\
+	EM( FFE_SKIP_BG_SEARCH_BOUNDS,		"BG_SEARCH_BOUNDS")		\
+	EMe(FFE_SKIP_BG_ADD_RESERVED_FAILED,	"BG_ADD_RESERVED_FAILED")
+
+
 /*
  * First define the enums in the above macros to be exported to userspace via
  * TRACE_DEFINE_ENUM().
@@ -118,6 +131,7 @@ FI_TYPES
 QGROUP_RSV_TYPES
 IO_TREE_OWNER
 FLUSH_STATES
+FIND_FREE_EXTENT_SKIP_REASONS
 
 /*
  * Now redefine the EM and EMe macros to map the enums to the strings that will
@@ -1388,6 +1402,58 @@ DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
 	TP_ARGS(block_group, ffe_ctl)
 );
 
+TRACE_EVENT(btrfs_find_free_extent_skip_block_group,
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


