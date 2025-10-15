Return-Path: <linux-btrfs+bounces-17846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D6BDE737
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B972F504527
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A18326D6F;
	Wed, 15 Oct 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFMYW3NP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41C324B23
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530886; cv=none; b=XQ+TVPBFlkZ5XTZZRTG7VtYFHUgrFUVlDkNDcu7lZNSEg4M3L8blA9/juq8KJCZ9qn9Jl/5HvlV1aNwx6qjdf1Z4hT+vTjzFtUEWb+Lj+ZMGgKUKqy1YCaOHbFR+85TBa7urYFzYUusuldM113jnA7h0XuTy+HNlVxI5Gzv6Mos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530886; c=relaxed/simple;
	bh=lBryR2bg+lyCd2/SNvZ/bRCdbnkWRnb+LvOF15vtmE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLNbTXEe0NG9gzNuXwTsN/NTnUYxuJ5zqYARgia2XO6+MWifUUcejaSwo8pg0RLrtDx4z9efFttYJNe+/gY3G5KQrdk78jFYx/9UfH2dB1YhMmLkcr3Ky0qtryOj8GNJdYa5C8qPd+xF6SwgSLRYcfpqhcQ4nGhp8B0kgMt0l10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFMYW3NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA86C16AAE
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530885;
	bh=lBryR2bg+lyCd2/SNvZ/bRCdbnkWRnb+LvOF15vtmE4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YFMYW3NPzVmjo/tqhpK5hgHB7kHH+fndKO7bqdJZ1DuT6kk2BxwSE6QgZJrffBz4N
	 Ezw5mlW4n+BbcSSbRGNUXbl4euq2YTd6dLXzbAda8G0RGeS3P4rWLlDgIgp3ZtrqhQ
	 lKLoFD6o4sm7aTUWow3SsmXLK19RdnXNJGHPBz0RvA505fVrHGHmGsE7xLTJB7rLdB
	 Uybe1nhPLyjfPUunmUDVh6R95gNMl56AI3P//BMvYm20tEl4sFmGkqIjwD9vxCp4ku
	 H9Of8p0ET5YY5o1foVUAOyVXNVevdi8h+61D5pk8o2bIHWaoltH9v0TC9nI7hgZXVA
	 0iSnvWT948lKQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add macros to facilitate printing of keys
Date: Wed, 15 Oct 2025 13:21:20 +0100
Message-ID: <5c12d2686e8819541f1a5b04670a6beb673ade9a.1760530704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760530704.git.fdmanana@suse.com>
References: <cover.1760530704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's a lot of places where we need to print a key, and it's tiresome
to type the format specifier, typically "(%llu %u %llu)", as well as
passing 3 arguments to a prink family function (key->objectid, key->type,
key->offset).

So add a couple macros for this just like we have for csum values in
btrfs_inode.h (CSUM_FMT and CSUM_FMT_VALUE).

This also ensures that we consistently print a key in the same format,
always as "(%llu %llu %llu)", which is the most common format we use, but
we have a few variations such as "[%llu %llu %llu]" for no good reason.

This patch introduces the macros while the next one makes use of it.
This is to ease backports of future patches, since then we can backport
this patch which is simple and short and then backport those future
patches, as the next patch in the series that makes use of these new
macros is quite large and may have some dependencies.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0bb0c01d7952..ad389fb1c01a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -74,6 +74,9 @@ struct btrfs_space_info;
 #define BTRFS_SUPER_INFO_SIZE			4096
 static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
+#define BTRFS_KEY_FMT			"(%llu %u %llu)"
+#define BTRFS_KEY_FMT_VALUE(key)	(key)->objectid, (key)->type, (key)->offset
+
 /*
  * Number of metadata items necessary for an unlink operation:
  *
-- 
2.47.2


