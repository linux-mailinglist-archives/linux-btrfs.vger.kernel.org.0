Return-Path: <linux-btrfs+bounces-10243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D334D9ECF52
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C739C1886017
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB91B6CE5;
	Wed, 11 Dec 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t22nozlX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A724634E
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929515; cv=none; b=JSNYQO0MwYn+HUY2RtaNvTeSCHAJqBfopJjFys8yVnBGb/F9/Vkx2+yykq4G4v27ezkJl8xjXa9ZVf2M9Y6nC9t9atatSZ4ACKndQvTgygvVtJl6eCy00QGt1jDhWcKxQS4uNTlXWD4XLc691FZveEZaGUoAJbjLEif0DC0E3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929515; c=relaxed/simple;
	bh=/Elnbw3J8+WEUwhw4pS0ScYsHxiN1Bhr3UJd26ScI18=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GAPnUyZkEY673hGxZQpATO165TNsYOZloAY1m8twMWQaGm2FSZdcp2XjAoylGlSLvsIBR18l/lgojIyHMtPSNiap2qUC6n1Pk+KwdC/bisazWHzSwESluMTDvnB/aYOjeAy8odJgJE8pvpeRCzoUuWdLhDPBkKlhVLZiRrF2l3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t22nozlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66508C4CED2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929515;
	bh=/Elnbw3J8+WEUwhw4pS0ScYsHxiN1Bhr3UJd26ScI18=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t22nozlXVWWET9Ejvsc4LK/1KgFRo7MaQWig3aHFCzo+KYU04gpaMXD2FxMW9Bajf
	 nqsRyEdq8RdPXILb29prjOT5GDgHdZ3lW6xS74kYbxfXc0GPZ8A3Rc9b0d9ottMuuX
	 AiRq8SeXHFw9HFeWHQRNDqr+KZhZhrlm2Izn6lRJkgmgjeOkxdPlMNKc2IoZS1oyfg
	 zZRtbwpZNK2fPOKjjW9rVx4hiASzVYaxmkms4xezl4bhFFaNzliLWZ6HNioeUcxs5a
	 ok9EbV1w4pe0nCdt5QEyTjMq30gxX7FoifQOY1XsxJAU6LsXZcNt1GPo3KbAGcN5K+
	 eC6QOxo0lnLhQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/11] btrfs: allow swap activation to be interruptible
Date: Wed, 11 Dec 2024 15:05:00 +0000
Message-Id: <05685edc7747bda9a359a04cd66b07e11e889f91.1733929328.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
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


