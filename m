Return-Path: <linux-btrfs+bounces-4362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E925A8A8608
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4B1B21E32
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552A1422BE;
	Wed, 17 Apr 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OkjzH1Z8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68451422AB
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364575; cv=none; b=mR5GQ4LkgIkZcUbFtvbr3NFRp4S3MIek7El/dLnpSSnTlkNz9XOPFuBNvMQ/t78YrbscYQW9DlzdNFm+8IrvXWcbDDZ57IjC4POKrqPhg7lx7xLczSwEbpqHwED2nK4eIdhNvHkIAd2Je9Ui+vzQXY2rAhmyVmWSNkFR6dH5F8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364575; c=relaxed/simple;
	bh=QXlnfj7KDQpyGNoJS+FwefXlm27btOTcqxy70TUZ+Fo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J59gqCJoxN7qs1vSNZ4LzjJ9d6KXZeaqiNUB1wZ69rtkCOkippizeklSzsucfSKt+J7//HiRa9gHK605fK7Rdxva10SKM6fL9we/x6n1C7O/TU2v5gjrcTZKxjNzY9HcYlyfmjExYy7YY6v6gM6XNb676wDIdw7wKRNy7LgCjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OkjzH1Z8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b24162dd6so25277436d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364572; x=1713969372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EHxmW3m3DWN7fzZ1oF9jWMjtNhrvXB9gqGHTf88rEA=;
        b=OkjzH1Z8zvfjOLfVL3DkVFWVNfn8XqpEKRcPpPRvhTDGBuEfo5svoaW3b/K5fz/QN5
         Mh/WhqpgJ0P4+zGvASUAn4JkFN7Czbb3gZqiidaYkk4CtIdOB8C2B2oX5INj8/YtyJMj
         zOm55OVjh+Kb0pfWLsoLrJa2KA25tgdGsVVi2SoU5ZxMwAYzqgZV4UuhoCG3Mk2GR5RV
         Ppe18vbRYIc4CbxHQ4ysYNvRo9LqsmJZPqACr6kA72eVP/ffYf3jqDEZHTi4ECleKbGe
         FqLGCN8D0Fs6Sxp94MCfhdDVtSmeapn5hz4FYgex+7hb8RgjGWLeMXMq6MuZOOe9xpnj
         tk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364572; x=1713969372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EHxmW3m3DWN7fzZ1oF9jWMjtNhrvXB9gqGHTf88rEA=;
        b=QLd6KtUbafqnNM2lntPomyeHAnBaNQdKkecm8+JQRSW4KBi26uobTmcwiUXSSu8+uH
         YTf8G8PKs5TT0uGGdLg2gyfpI39kiUYQnP9bnNEXodanDVp1MFN45S0XVTCAtA8The8a
         Q6iQygcTx8FizXGCD9Ol7vp4iWMaXYvGpz2AM+W9H/9PtyQ32elJVhRzOnNZFoEfbvLK
         +ntHJ4iwCkb9b0R2vOjHdURarTp9yQGDBVqKLyBzHGtlvigCMInek+1S3+vzu6dXn8OJ
         ud7NYsK31QHE+1rz7YcaZzyKu8/lLd+aa0Mdh5rxYVK2Z7iTje1+Hyq19Om/CBecuAAG
         1i9g==
X-Gm-Message-State: AOJu0YyB6d2443JZ7nMTvXr5Y6rerRNPI3gnbLMmWL/w7IO8ZLm4Sabs
	IZiQnvGEk5m26IYOBJmN8ZBIoFEVe07TIxszUlmQC+0brG4phOeJO0DLDGISH9g4cvJffrsZdIS
	a
X-Google-Smtp-Source: AGHT+IGdhO2z1n6SHg7aQObIJe8Wj5A+4p5Rm5LFvhYYe7zPfXmQgMBWPl3K6yOlEbKVVfGWMdHjzA==
X-Received: by 2002:ad4:4f8f:0:b0:699:2293:92ba with SMTP id em15-20020ad44f8f000000b00699229392bamr14184925qvb.61.1713364572603;
        Wed, 17 Apr 2024 07:36:12 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j15-20020a0ceb0f000000b00698fd83ac04sm8345943qvp.135.2024.04.17.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 05/17] btrfs: lock extent when doing inline extent in compression
Date: Wed, 17 Apr 2024 10:35:49 -0400
Message-ID: <99be1657b5273f3a9d24e53f6be9303b381a51eb.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently don't lock the extent when we're doing a
cow_file_range_inline() for a compressed extent.  This isn't a problem
necessarily, but it's inconsistent with the rest of our usage of
cow_file_range_inline().  This also leads to some extra weird logic
around whether the extent is locked or not.  Fix this to lock the extent
before calling cow_file_range_inline() in compression to make it
consistent with the rest of the inline users.  In future patches this
will be pushed down into the cow_file_range_inline() helper, so we're
fine with the quick and dirty locking here.  This patch exists to make
the behavior change obvious.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6fd866a793bb..ba74476ac423 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -742,10 +742,10 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 					  size_t compressed_size,
 					  int compress_type,
 					  struct folio *compressed_folio,
-					  bool update_i_size, bool locked)
+					  bool update_i_size)
 {
 	unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-		EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING;
+		EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING | EXTENT_LOCKED;
 	u64 size = min_t(u64, i_size_read(&inode->vfs_inode), end + 1);
 	int ret;
 
@@ -755,9 +755,6 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 	if (ret > 0)
 		return ret;
 
-	if (locked)
-		clear_flags |= EXTENT_LOCKED;
-
 	extent_clear_unlock_delalloc(inode, offset, end, NULL, clear_flags,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
@@ -1031,18 +1028,19 @@ static void compress_file_range(struct btrfs_work *work)
 	 * Check cow_file_range() for why we don't even try to create inline
 	 * extent for the subpage case.
 	 */
+	lock_extent(&inode->io_tree, start, end, NULL);
 	if (total_in < actual_end)
 		ret = cow_file_range_inline(inode, start, end, 0,
-					    BTRFS_COMPRESS_NONE, NULL, false,
-					    false);
+					    BTRFS_COMPRESS_NONE, NULL, false);
 	else
 		ret = cow_file_range_inline(inode, start, end, total_compressed,
-					    compress_type, folios[0], false, false);
+					    compress_type, folios[0], false);
 	if (ret <= 0) {
 		if (ret < 0)
 			mapping_set_error(mapping, -EIO);
 		goto free_pages;
 	}
+	unlock_extent(&inode->io_tree, start, end, NULL);
 
 	/*
 	 * We aren't doing an inline extent. Round the compressed size up to a
@@ -1352,8 +1350,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	if (!no_inline) {
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, start, end, 0,
-					    BTRFS_COMPRESS_NONE, NULL, false,
-					    true);
+					    BTRFS_COMPRESS_NONE, NULL, false);
 		if (ret <= 0) {
 			/*
 			 * We succeeded, return 1 so the caller knows we're done
-- 
2.43.0


