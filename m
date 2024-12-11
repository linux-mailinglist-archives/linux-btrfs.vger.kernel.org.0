Return-Path: <linux-btrfs+bounces-10230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29169ECF11
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BC01881A0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960EF1BD9C8;
	Wed, 11 Dec 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9OCFdIA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83AD1ABEA1
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928814; cv=none; b=O8aFCAUh5kIBLioA6hpwwlv4py+g+iy8Al6vuRf9z4qH+8J2lMiu3aHvjAqkdJff7kG7mi5Ncz3BUcd8ec5+NzEvrbmHMz727eoDcHN8fmSSxINUX4at1TQYzXUXI8QllvUg9aEN4miqENa0Wia9yUzItYzpENEnC+beZ2/p4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928814; c=relaxed/simple;
	bh=/Elnbw3J8+WEUwhw4pS0ScYsHxiN1Bhr3UJd26ScI18=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjR45qr8w8faucxThb+zuBXNroUNkVF6TuwfzVNhXRuGVV4RHINU9UElev89pIs4OtsrU1rbneiW94cgLS8wzZD236aVinBgc64s82d02pZ82/WH3Fb2b4kMsqFrzY0SZRX365pyOu2x3ML9+zYVMysIwgRbKP87HACPEJR8PRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9OCFdIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13821C4CED4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928814;
	bh=/Elnbw3J8+WEUwhw4pS0ScYsHxiN1Bhr3UJd26ScI18=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B9OCFdIA6Bg5w7JTtZOJyfV4YuhaVC4e6vwziXuYlamCJu1pGWibCGHPYA21Hsj7+
	 XWEGpt518XM2pLxGtJV4rFrpNDUO0mrtv+2u6PxBqfJ3c7agRUd9JxJA704BAnp1g/
	 nLREcSO2N8HdJTa3/+prYIF2EAlyQgzAmfh9jR+XMbiVvVfdwBNqom8EQ4qjKK15SG
	 TXMJZyxFFI6D4QEbgYDNUN+QYp24waczxUr+Aq7nke6Gg+T+Rc9cxcZ3QInD7I3amS
	 9iFy81tkC3+tzdeEJG+WtvXo8deagGkeTD3+BD0owqBkytHVBNzzGKVLKiNv3pr0Mv
	 pc6o80NyAKSWQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs: allow swap activation to be interruptible
Date: Wed, 11 Dec 2024 14:53:20 +0000
Message-Id: <05685edc7747bda9a359a04cd66b07e11e889f91.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During swap activation we iterate over the extents of a file, then do
several checks for each extent, some of which may take some significant
time such as checking if an extent is shared. Since a file can have
many thousands of extents, this can be a very slow operation and it's
currently not interruptible. I had a bug during development of a previous
patch that resulted in an infinite loop when iterating the extents, so
a core was busy looping and I couldn't cancel the operation, which is very
annoying and requires a reboot. So make the loop interruptible by checking
for fatal signals at the end of each iteration and stopping immediately if
there is one.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7ddb8a01b60f..5edc151c640d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10073,6 +10073,11 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			bsi.block_start = physical_block_start;
 			bsi.block_len = len;
 		}
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


