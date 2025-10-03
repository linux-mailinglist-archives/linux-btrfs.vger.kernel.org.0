Return-Path: <linux-btrfs+bounces-17422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE5BB86CD
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 01:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725EE4A7E9D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842FF279DB4;
	Fri,  3 Oct 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPLejyu9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520C271451
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534937; cv=none; b=vCtJznApBmUqHXgUFp/0OcsL6tLMtnPeoG7x+cDZbXzAXj2ikNt/YzLZV+z4MbsPC6PVshpkptHUFZsK2eFXf006zrjsj9m55sUlkMEhqGyKRtC9MbDhcvPqH4gPEU0NTKk63naYiN90bkU6IsoCom0m9jekLbbuIJljr1CSgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534937; c=relaxed/simple;
	bh=tcg1k8qmcA7ppW89ThcuHm8QTTXa0pmI5k4i30Ab6zg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOK9iCJpKjQdLVcbtizCBrXws4hOmUggkuJN4jk5GoPIkGdYLCU3vjtcKPUx6bd9w+wgFyJAEXZ/QSufXDZSk1gvHQogO60DIn1N21pEkRmtkRPKi+H+wpcTitSwpg7DHe7nD+ncUx7nE97FS4hXugSdTBvVG6CRZRW7vuosxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPLejyu9; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-6360f986fb0so3221211d50.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534935; x=1760139735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y2imsz2UEzCeAk6bet/zQDziycQ2A4Fqgbbs/uLbIM=;
        b=JPLejyu9xZZQ1sboh9eXzs+5ncqO0v3qZ5Ha89L6GO6MQVBRcUxGW3aPz22Prj39jB
         dDiF3iy3P/umFnUOKsy4v+iEBe8O7hWuadIL0Nw0Ma1Id0TBpNtmwnER9NIwmFehBdVs
         PA3pGA94MV3pAvxOWONthJGFn5UsxsgGSbwzUbXtnCSAOaniFNTDav45PO2Y7lfuyF18
         qRnXt/hlb6BrX3zOWr98IdkF5tMPapBBy4l3QAbZ+PBu6RBIr1Cc4aOZO7Q4e3AoiC/W
         Bm2B8wxto3UZI6zvnIMGfl1Vdn1DDwgqjHYQeL5tfi5VsT6SscbmgAbJrNh05BT5aAej
         w3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534935; x=1760139735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y2imsz2UEzCeAk6bet/zQDziycQ2A4Fqgbbs/uLbIM=;
        b=iaQdvUOxIBMCOBWXjJckqvGhxsql2XwH37ttzwXVw/PK7JIeelYog12lhayJaHb4aD
         Iilo8rFdLtQRO5aM0krzZXlp0tZaXjZ5tzrvpXd9k+/XxBmmaw4JaFNAD5wsw4v5wPIy
         1mN4yBXZ/N69JGFHE1qIvOu9l/7f/HCoSqGuBHg7OaMOxwq4kbqpxYq4h9cedkPwpOEu
         UdN3suTMIROGvxTKWQmRjsG7Cd0BMggrdugJaqR+pYSYtUvgJ86N8ASd78m0CJBWUxAZ
         MUYw45x8dRwu6CT8LyhgZBXhRXSM+A9/5N8Sm1wJ6UQ6UjlPduFGOR8jmyN4zpHEimFW
         fvtQ==
X-Gm-Message-State: AOJu0YwoDOEGF4mViVFqOQg+ZnMz0X4H3UyKQ1KCkzieT5lUzT6rgKLG
	2/8NjFU21zgEHwxBdiA3wOnWHCUdCnD9EC5l/zUeAk/VNntjterGqS/A29X7bs6W
X-Gm-Gg: ASbGnctramDygPmP/6Hplq79qUHbHNa7DYNcjixexkkSG/1LPWt9Kb1ojs6Dm0z+2qW
	pus38TbfaK+tB9OC+saVdmg/ds7lNyGNiqNlnnmtrc4tH/5sn9dqXjW6MpTmmwB5/ewvCXD69ZR
	dihiTJ+3f/sPlSvYk9svmtXlJkaojCVBaJAkCcry6D+Vn2y2i9uOXAwzVm5LxVo4vSz5Oz9p/mj
	HojWJRpbZBNj5yAkWIDBK52s6+1/Z8F3X0pT5Rxf5LzCIAxpJygiMb+5R8I/AKYUJLIYQnjp3FC
	hUkgnkwad/O80htrlB00G9rdojSwAzBIHD3pm4PQeJEOedhI4Q/ijgZY6kNtQ55wM01ZnIxWU/7
	26EqxV2uG8cVvRAMbW82440o6JHXqrSY8+XMm9kyxfmYwOCPCTESH
X-Google-Smtp-Source: AGHT+IE3DmBIkqOFv87x0y1X1auPQLKd7FRAoNWobPV9xfptkh66yMw9S1n6km3PBokqeww8rH+8jw==
X-Received: by 2002:a05:690e:1584:20b0:635:4ece:20ab with SMTP id 956f58d0204a3-63b9a11110amr4605114d50.48.1759534934791;
        Fri, 03 Oct 2025 16:42:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b84690b4csm2164978d50.21.2025.10.03.16.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:42:14 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: remove ffe RAID loop
Date: Fri,  3 Oct 2025 16:41:57 -0700
Message-ID: <a46aa0e4fb936ab73748fc9fd92a9404380769b1.1759532729.git.loemra.dev@gmail.com>
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

This patch removes the RAID loop from find_free_extent since it
is impossible to allocate from a block group with a different
RAID profile.

Historically, we've been able to fulfill allocation requests
from mismatched RAID block groups assuming they provided the
required duplcation. For example, a request for RAID0 could be
fulfilled by a RAID1 block group.

2a28468e525f ("btrfs: extent-tree: Make sure we only allocate extents from block groups with the same type")
changed this behavior to skip block groups with different flags
than the request. This makes the duplication compatiblity check
redundant since we're going to keep searching regardless.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/extent-tree.c | 32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a4416c451b25..28b442660014 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4171,13 +4171,8 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
 		return 1;
 
-	ffe_ctl->index++;
-	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
-		return 1;
-
 	/* See the comments for btrfs_loop_type for an explanation of the phases. */
 	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
-		ffe_ctl->index = 0;
 		/*
 		 * We want to skip the LOOP_CACHING_WAIT step if we don't have
 		 * any uncached bgs and we've already done a full search
@@ -4477,9 +4472,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 search:
 	trace_btrfs_find_free_extent_search_loop(root, ffe_ctl);
 	ffe_ctl->have_caching_bg = false;
-	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
-	    ffe_ctl->index == 0)
-		full_search = true;
+	full_search = true;
 	down_read(&space_info->groups_sem);
 	list_for_each_entry(block_group,
 			    &space_info->block_groups[ffe_ctl->index], list) {
@@ -4498,30 +4491,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		btrfs_grab_block_group(block_group, ffe_ctl->delalloc);
 		ffe_ctl->search_start = block_group->start;
 
-		/*
-		 * this can happen if we end up cycling through all the
-		 * raid types, but we want to make sure we only allocate
-		 * for the proper type.
-		 */
 		if (!block_group_bits(block_group, ffe_ctl->flags)) {
-			u64 extra = BTRFS_BLOCK_GROUP_DUP |
-				BTRFS_BLOCK_GROUP_RAID1_MASK |
-				BTRFS_BLOCK_GROUP_RAID56_MASK |
-				BTRFS_BLOCK_GROUP_RAID10;
-
-			/*
-			 * if they asked for extra copies and this block group
-			 * doesn't provide them, bail.  This does allow us to
-			 * fill raid0 from raid1.
-			 */
-			if ((ffe_ctl->flags & extra) && !(block_group->flags & extra))
-				goto loop;
-
-			/*
-			 * This block group has different flags than we want.
-			 * It's possible that we have MIXED_GROUP flag but no
-			 * block group is mixed.  Just skip such block group.
-			 */
 			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
 			continue;
 		}
-- 
2.47.3


