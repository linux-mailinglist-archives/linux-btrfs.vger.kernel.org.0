Return-Path: <linux-btrfs+bounces-8961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405F39A0C77
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5601F221C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5520C017;
	Wed, 16 Oct 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw2rxODn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48B20C006
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088430; cv=none; b=hbsERt/xIKfZWT1A8OgLGfmDeqQshNthmev0JmAPSmG7MLZOD3OUmx7E4eKrZS3V/H/7Habn5VKmyABVB7wlEIjLWAE/lKVDIKX8J3jXoyDG3JkPYL3PsXXLaieobYQS+mEH698swOQ2MdmOhrcXWrqsEIT7CaQKRztiKXvdvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088430; c=relaxed/simple;
	bh=Ghs9PQbfpXHaC5oZ1IJAokc81/loWXff3lxU7QgHy5Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzjjSEcwVZi3hohCxHGOE0URA1FWwKCMypnEz8JceOwoYpWagMlF75iUJaJfZsHKGSKvCoYJGVtT+ILhdyRvll/YrCcHWw57CQ0x/bP4LC3M9wnycAdTOAreeX5ucTpW1Wrpa6f/qczHJkENW3JrVyU8m1mMBBvLtvVqlfLqANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw2rxODn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D19EC4CEC5
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088430;
	bh=Ghs9PQbfpXHaC5oZ1IJAokc81/loWXff3lxU7QgHy5Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Uw2rxODnl38e8OyrhR9sT1xJkjoHV6ejTFfQ7Msul4eb7XcULhe7PqQ+U3LAEpXWF
	 RUQqnT7iHvNeeUauSgm1ReWcp9jWiYobhmpejEdvCkJsNi3Ck/9esPuxKnfXsMfbW/
	 sI0+o61zBw15nsPNgrgj4NxOg6mKzzm6S6Ez4ufHOUsMMAEbHjXQzwaeCbwqXzcyUG
	 7tVyswTM34QQOy9F+hz5Ymov/awkmvp1IwIE4cke+BH9q/J7j2S0RoI9HE5eriTEgE
	 g6dTvpjmsxqSeAWbkyLwt2pwA2NGZBimls8g/jFhFqBbVZOVuLLnw8pQ2xh25GOxpe
	 Qe/fLT0q4QpfA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: remove redundant initialization from btrfs_readahead_tree_block()
Date: Wed, 16 Oct 2024 15:20:22 +0100
Message-Id: <22e345124a6e35e4dbc07e9564475b5c97b37a41.1729075703.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729075703.git.fdmanana@suse.com>
References: <cover.1729075703.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's pointless to initialize the has_first_key field of the stack local
btrfs_tree_parent_check structure since it all fields not explicitly
initialized are zeroed out, plus it's a bit odd because the field is
of type bool and we are assigning 0 instead of false to it (however it's
not incorrect since 0 is converted to false). Just remove the explicit
initialization due to its redundancy.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 09c0d18a7b5a..0a0c84eb1c42 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4285,7 +4285,6 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level)
 {
 	struct btrfs_tree_parent_check check = {
-		.has_first_key = 0,
 		.level = level,
 		.transid = gen
 	};
-- 
2.43.0


