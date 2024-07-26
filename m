Return-Path: <linux-btrfs+bounces-6787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68C93D92E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9D5283082
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735515532A;
	Fri, 26 Jul 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="f0c0LkUH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB015530F
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022648; cv=none; b=iywv9Yar5I6rIs/jEh0BcFXQdJmIljnHlAEDZu4arUheYMXbh5CsBgErAnQJVjbwBoZG3VrhffiFEo7qnTHi/y8o8WP8bcC0X7oJzYkq1U05Qy0K/dzkmmPRSzxkcQT/9Xvkq6Ti0KTfP6mvCHCy9njiMja2/Tm4PjX3WWMkNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022648; c=relaxed/simple;
	bh=sSHhwu5lN1rA+LbUyBsY49n12Ou4f7yaJSrTLBDjMEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpvRlHFmeRa8H5xnbog6KtFwpQZKUvWjcIJXiBmui6naWAdc0KE1I050C/mtBQ3bg7xhUcyqLrY0vAqOY7vBkAf8tAwLwI66Vqg4A0BsURwiEB+pJLDGHIwdk/MMgk12BwNrjwUxRbXfcKVAHRP+ZhX46q2LZhi0LUTh53ykk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=f0c0LkUH; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66493332ebfso311087b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022645; x=1722627445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oS99JkcYohsJ1gPjAyz3LxCZjiAwwWlVR03yxei/AxY=;
        b=f0c0LkUHuVNE+H7nbbTCS0ZMxc1x1uzF0x0zYVTtKhKUCGugTrQQMO/DFjBK43Mwwn
         uagESp42eOyk7SyRk1czIuzi0QNP27Azw+YlWOEgH2M4buCcnNVZNwN2XQx9VKPH31pw
         xzIrfqckWYyj/d9R/i4vZRqc4M0fDzO6fP7wyWDsQFfXjaA2XYvoywQyYHIkB9yotZXz
         hYnRXc7nUcD/x6erhtpnnviCCuNwmjMvqmObD2FtlB9k+aN1yPZP9ITjXzul+w7Du1sD
         2dogWqm9JRXdFFKzmgwpjOl44icR2wYcfJYjbxTkd1e66dkIZ44F9uYZNhVB+gQVJ2HX
         cADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022645; x=1722627445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS99JkcYohsJ1gPjAyz3LxCZjiAwwWlVR03yxei/AxY=;
        b=WghZpXcGJmh4BgkO3KeTDzaGKW5C/rlh4zDB/n9OJizGkhAPixAvLMjXsJMfz2KDgt
         QfJ6bKn1v3ihq9avHuz4q6lX5PPB9mpbrWVsgEJegQhqrPVU5dJ7u4N7z+y8L3ZQl5ek
         MOtH1fFWRNMwlah/flDd7TFYrsF/aFOoawZ7X+vBSb66xrJHTSCs0au1RJWwGiKQWMlG
         uOzjFr/x5x+bA6bf178s0RkKJu8Ndx9T1aXw0xnTD1LnvO+SM4UbI/77KJIx/vQr4V0a
         BAkVGwBGG/Rv4TjlZzXEWj65XKxPBIvZoqf9smOCJBPWHJyWQdS7TPUP2KTmUNOVV1C6
         IsPw==
X-Gm-Message-State: AOJu0YxrNj7qiGtkEao1YEhG0M29k+rMN3QpmEwHt5TzLwaV084IbHtF
	iB4n9slcXJG9ExQSUvdUVN4Z6E5KgFJpU8u4asR9uacsnLz9Z+/J4uf5dzwDXJrdLK3qKxj4zQm
	U
X-Google-Smtp-Source: AGHT+IG/zb6XrQORL42RZX5x9WXskpra+dh0TfVoCWkNf0iCXOJvqQOPsmhgTpKx8Cfj9mpp8MS6JA==
X-Received: by 2002:a0d:f685:0:b0:66a:b6d2:c184 with SMTP id 00721157ae682-67a06ede4f9mr9294377b3.16.1722022644958;
        Fri, 26 Jul 2024 12:37:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024db3sm9864687b3.102.2024.07.26.12.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 45/46] btrfs: convert insert_inline_extent to use a folio
Date: Fri, 26 Jul 2024 15:36:32 -0400
Message-ID: <adb41ee05637cbf7ed46cabe88eaaaf89aa832e6.1722022377.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only use a page to copy in the data for the inline extent.  Use a
folio for this instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2f14b337a7ef..c019beb7d9ef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -495,7 +495,6 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
-	struct page *page = NULL;
 	const u32 sectorsize = trans->fs_info->sectorsize;
 	char *kaddr;
 	unsigned long ptr;
@@ -555,12 +554,16 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_compression(leaf, ei,
 						  compress_type);
 	} else {
-		page = find_get_page(inode->vfs_inode.i_mapping, 0);
+		struct folio *folio;
+
+		folio = __filemap_get_folio(inode->vfs_inode.i_mapping,
+					    0, 0, 0);
+		ASSERT(!IS_ERR(folio));
 		btrfs_set_file_extent_compression(leaf, ei, 0);
-		kaddr = kmap_local_page(page);
+		kaddr = kmap_local_folio(folio, 0);
 		write_extent_buffer(leaf, kaddr, ptr, size);
 		kunmap_local(kaddr);
-		put_page(page);
+		folio_put(folio);
 	}
 	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
-- 
2.43.0


