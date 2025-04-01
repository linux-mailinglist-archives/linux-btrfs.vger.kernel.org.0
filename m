Return-Path: <linux-btrfs+bounces-12722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19BA77EF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CA53B08F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142420AF8E;
	Tue,  1 Apr 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKJjcXrc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE32054E1
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521398; cv=none; b=UbAX/0w8HDF1VIUnpY4Jo3LB1kT9WmwsKLi8Z2dqaie96ysBtyfrldJ9HsVtYTeb4DLlR/+uyBPp8+rtv1psLuRV+PoMYpuiiTL/xpDvJ5s/iDHOfqkGqkPAtqKfg5WJSRlWbJpdCG/6+ZQqUH/aYQRzkpUIM7TfO60y5Yfoudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521398; c=relaxed/simple;
	bh=7LI6uFwYWYntxxhlwUtzuaRXHgbgZK8MiQMY7OaK/XM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTD8u4tedxG/RTDWwqMTnpc5B1XqQy6EMoPVg2IaBJMvugfekifCnDfeCQwjQNlNbDvBKakM5N6dG0BuIZObXGdrfvqQyMxmt5cKWgMhIcwpDsGz9wMRwoJmVwK4vnDnKK/19e7BGZGHP79l8zjsxp6i43QPR0CuiOqMemsQlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKJjcXrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FC5C4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521398;
	bh=7LI6uFwYWYntxxhlwUtzuaRXHgbgZK8MiQMY7OaK/XM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FKJjcXrcMqsNr57xRnBXpwrJ8LCtgSigrqIifxMuIuQ3jU7Kptk19XasFuam+auaR
	 7eUOs88Xk8hMxG5mXqTUCPJGvR6N2TxvmtFtTaXiYVN7Zsph6/tEKEzeC3O/q2MJ3q
	 8v/KiWlYwII8oezzqLQBJRDUSAAkdw54azOpTaz30HYCLv1lQxcaky515Nly9Z10dI
	 Y7znuRPgmZIUgGUNpgW2wR87h+1xlTslQK9kRTKyQxV//KoHXON79cYYHJIDXbh62d
	 ghiDki5F4wosj3e1x50a/sKgrKL+auAXsfQ5O+6Wwvb+r5Ra70s5RynmR+b8mxf7P/
	 y0AZsHtjtG3DA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: use clear_extent_bit() at try_release_extent_state()
Date: Tue,  1 Apr 2025 16:29:51 +0100
Message-Id: <c98bc026af2049be1c7db471651d3f36a5513ec4.1743521098.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743521098.git.fdmanana@suse.com>
References: <cover.1743521098.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using __clear_extent_bit() we can use clear_extent_bit() since
we pass a NULL value for the changeset argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19f21540475d..50b74531b745 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2651,7 +2651,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 	 * nodatasum, delalloc new and finishing ordered bits. The delalloc new
 	 * bit will be cleared by ordered extent completion.
 	 */
-	ret2 = __clear_extent_bit(tree, start, end, clear_bits, &cached_state, NULL);
+	ret2 = clear_extent_bit(tree, start, end, clear_bits, &cached_state);
 	/*
 	 * If clear_extent_bit failed for enomem reasons, we can't allow the
 	 * release to continue.
-- 
2.45.2


