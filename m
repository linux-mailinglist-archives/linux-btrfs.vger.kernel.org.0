Return-Path: <linux-btrfs+bounces-13310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7433A98CC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAA73A777F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE227D76A;
	Wed, 23 Apr 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a26RF0Y3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60C280A2B
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418020; cv=none; b=Egg4ncqzyTSMi1iQSksZhz8OWhav9jBqS2VQ5lB9lKBKvFD8BcvtqkG4TY/dmMyrY0/lycD0yL2icLrgh0d4ZzYijBnHqoEMFJp0+BJ1pcWM3RN19Oziwj0xdEYQKc5ncajSEx8V3GXJMUg2NiGAlIDdTnErFN2BUUZAZgfdkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418020; c=relaxed/simple;
	bh=3syWcxMJPA6ZXPhrhTs77rG2Mdx10bEKZvDfUypZlgU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFj6JWDaaPJ7okddOkwBKHCtgTVLgAJNNZRdKVzqwKC67VqK3Gk5iDUOzfROdCIEGC7Ku3pdV2JFPRWw7Em8wAKa7lfaoztvMtXxDJFsZ5EPkAlWxQtmm6WnU/b56a7AJM6AWZqZepieunfvlQFZvAAbgAlPplL1+RLMVL5YXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a26RF0Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00ADC4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418020;
	bh=3syWcxMJPA6ZXPhrhTs77rG2Mdx10bEKZvDfUypZlgU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a26RF0Y3TqqTkPFAqK2O8uFJT96dn+dAAO3z/t8lANSbExESfO5GbPfgFDfJlhxTB
	 joBGVGPpRmyhubv2KaK2VYV403i/0NJEJ2jnmnNaMBl18hXzAd72CC4CgqadqA+DE0
	 nZjjObyWTjnQBrMTImdrq67xvhUYwqvw4l5eIJlvinTfXr6o9O4E9DMR0nZYNyqOE4
	 cqrpKUXktotqOPEjuxao5pN2AyD5DVGoxuJLtJ/3VBZSvLRtVxEZRmirM0aN87iwhq
	 3gYsK/pnNcG0Rco18+O/IzPEGC6vGl0eQc1xYGj02IuPrNRlBzBPME8ba5me+fmmv5
	 gWK71+1M4jGPg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/22] btrfs: exit after state insertion failure at set_extent_bit()
Date: Wed, 23 Apr 2025 15:19:54 +0100
Message-Id: <46fc1540a80d3f7a5820f3d32d3e2e3213779d4a.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If insert_state() state failed it returns an error pointer and we call
extent_io_tree_panic() which will trigger a BUG() call. However if
CONFIG_BUG is disabled, which is an uncommon and exotic scenario, then
we fallthrough and call cache_state() which will dereference the error
pointer, resulting in an invalid memory access.

So jump to the 'out' label after calling extent_io_tree_panic(), it also
makes the code more clear besides dealing with the exotic scenario where
CONFIG_BUG is disabled.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 453312c0ea70..2f92b7f697ad 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1220,6 +1220,7 @@ static int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (IS_ERR(inserted_state)) {
 			ret = PTR_ERR(inserted_state);
 			extent_io_tree_panic(tree, prealloc, "insert", ret);
+			goto out;
 		}
 
 		cache_state(inserted_state, cached_state);
-- 
2.47.2


