Return-Path: <linux-btrfs+bounces-13305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2A0A98CBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205C4441881
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CDA27CCE2;
	Wed, 23 Apr 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1S2uEnY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DA27CCDE
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418015; cv=none; b=vDRqHnXMl26USlqLZ2f2UuWvClUAqWYkSyANW2C2nBq0dr4lut2b0s8AAgn7xojN/8JCJbWNOOZiAhqA0kzqh2tfIdmL1QCLkWCv3/MU34ZH1mauSrE6RPYynp2as5HFCz5z4rPLjT849Vdpf3Njo71L+IcKYPWbwRjdWny9CrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418015; c=relaxed/simple;
	bh=2C1vnFo9rXQU3E7YYLeS9IJWt6MrmfUyr8OuwRMpr04=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MzGWxr/ukHpd0X3QiAKBXncIA79+k5Y0JIIpGvbC/wgI4suiaDRjALoCcQ23CJApQlLoDq+lY7S5FCBEhbVuER1ncbx+gBtbwQ1jCFH5HC8NkcoXXC2xN+RFBsgAtYB5Wvv1AeiN55QKXgDmnwPegyWsxm7CKTeTvIDdDkXyd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1S2uEnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8150C4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418015;
	bh=2C1vnFo9rXQU3E7YYLeS9IJWt6MrmfUyr8OuwRMpr04=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E1S2uEnYXWt2JhiCtQwc8Wogu/+71/PuoIaDV1NxxiXl0ASlDMQrgJTUfa9dcilY5
	 H2y8/bO1bbg7G2yrZdIhIwhA0Wsayhr8AmGr0vWzcK4yNLfEJCo7+v9wA+mFUuSUWC
	 KB8jtyML5l44lohDoOHq1F1ul4Pn0mlaAnpUu2U9pxYKKU5Uz8XdN+0tJWmQijaQsE
	 6lx5+NU8ObzL+2Ma05FCSS9TiQ+AJByC1Ev+1MQv9QolO9wOMfhDLJjTrQqNEJPn0O
	 MlL9oDdNF8gGU9i3SwRVcZsyCC4c71kxxjSVSuo9pb/YrJlrBq9LITheQX88iphCJD
	 tq14/8+M3GBiQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/22] btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
Date: Wed, 23 Apr 2025 15:19:49 +0100
Message-Id: <ae54f2b854be9ccade70ce9b34383e202aeee5a7.1745401628.git.fdmanana@suse.com>
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
index 80de8f96b08d..591111879aec 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1439,6 +1439,7 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		if (IS_ERR(inserted_state)) {
 			ret = PTR_ERR(inserted_state);
 			extent_io_tree_panic(tree, prealloc, "insert", ret);
+			goto out;
 		}
 		cache_state(inserted_state, cached_state);
 		if (inserted_state == prealloc)
-- 
2.47.2


