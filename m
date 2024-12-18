Return-Path: <linux-btrfs+bounces-10563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043C19F6BEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9931894E4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F91F869D;
	Wed, 18 Dec 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOZ7pxSS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D481FA260
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541619; cv=none; b=DT9mPx2mBDXB8gzpTEa0DeZB1+ICf2wP3kHe+ifpfESZgjT3GJDQx24W4ZvFxxASfoTqwdFqu6vfFUfyuqpdTmLeh938xDGTKaQ65hMKS9VIRzyTZpYyFKujHxMOgwrE+Dw4M8Xnol1bP30Jk4IXrp8NabvG0YrKIqsN1KwaBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541619; c=relaxed/simple;
	bh=H2ZUU/RCYzpgXPp/8p/oMRJEV3l0TrGevFLRylCyDYA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eH7zZQfWJQjjUNF1zpIKyV83cn1JLfpSMB6fDpLMJ0eJI/kX+thTa3yEQpSOemjVynJhkOsOK3xAqDJlAqsDJULsjGt4OC3Rzyg1XTRcZwiPtbes5VI9W4IYkhEwEUsabU+ysF6b32mN9Coc2ejYzCuedURHBhpO3V2IvDtsZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOZ7pxSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB66C4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541618;
	bh=H2ZUU/RCYzpgXPp/8p/oMRJEV3l0TrGevFLRylCyDYA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JOZ7pxSSwZrmyv0YwvwKl+QBh3NFX7YoB5YP20TBHjQZSlkBmV01GPzionNF2BA3a
	 4Y20eKdS99Y1j49jjuSHwMBRNiUe68oeoEmOtX8G1q8tBlwYUtMobfrMractK/q/Go
	 DiiG0OK9lv+YY5sxFvx+Y5TOARyM1jBLJC3YdSSSMQ2C9dfsJNEMjrT5ZsPYZK/wyS
	 PDnhE/gSkyrxyZySQmRNqfOios/VH6te46M+i0ahsP/4jtPlUpWyhkmlP/HlJz+xuJ
	 w7RLaWfmOeRY5NURCqoaR7iMbeHEdQROk1YV/hDE4v0NMwlrxshsNLOE5zMC57cmS1
	 F03WjGfjjpumQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/20] btrfs: dir-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:34 +0000
Message-Id: <3833be2656cb7f08c0881050f9345251f112a23c.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several places explicitly calling btrfs_mark_buffer_dirty() but
that is not necessarily since the target leaf came from a path that was
obtained for a btree search function that modifies the btree, something
like btrfs_insert_empty_item() or anything else that ends up calling
btrfs_search_slot() with a value of 1 for its 'cow' argument.

These just make the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/dir-item.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 1ea5d8fcfbf7..ccf91de29f80 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -92,7 +92,6 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer(leaf, name, name_ptr, name_len);
 	write_extent_buffer(leaf, data, data_ptr, data_len);
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 
 	return ret;
 }
@@ -152,7 +151,6 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
 	name_ptr = (unsigned long)(dir_item + 1);
 
 	write_extent_buffer(leaf, name->name, name_ptr, name->len);
-	btrfs_mark_buffer_dirty(trans, leaf);
 
 second_insert:
 	/* FIXME, use some real flag for selecting the extra index */
-- 
2.45.2


