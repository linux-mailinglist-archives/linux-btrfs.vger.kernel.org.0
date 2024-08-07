Return-Path: <linux-btrfs+bounces-7032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CFE94AF18
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 19:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498671C219B1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6313DB8D;
	Wed,  7 Aug 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1U+HiZa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21113A25F
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052874; cv=none; b=WSNqDRxlXOLeHcgc/LcbZuc7l6Oyftxgkx5mfXBiJ4Kp0qRCtC1RpQqXJxFf/f3eIrmIMUT6WJSrheZ2GK9CmceB6IGD1RWwLj8hvUpSh7gpYYzFZCakZHXD/jKFA/SJU2/2iIdXg1AKdCk9F2WY5dN8WCaLL7KS8oG9YLA8pIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052874; c=relaxed/simple;
	bh=FxO2PjnzsdanNW+HE4asutt9jZTJIvF4oVYSgSFU8qo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MlutA0PCUQrPXZd2DA8i3PB6sIc+VCfqF53+gbkFx3pLOhR3wYEbZA+msEIqJoE9wmxaYmLXOMETXpVyEH2T9gaodtHBhm5MjKrGADK4bRdsN6R+91myTLoBjDs63k0tHBShfgu4voDnywJcOL1J8Yx/AySnO7oJ8hR/4SYxYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1U+HiZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7770DC32781
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723052874;
	bh=FxO2PjnzsdanNW+HE4asutt9jZTJIvF4oVYSgSFU8qo=;
	h=From:To:Subject:Date:From;
	b=r1U+HiZaLtJ4aggtzddQHQylF2lkSZ08s75Sb/iBZnjXFt8rQg1Y+8usf8pdfLdct
	 UaE6gQX5IPgb6fGLlr44c/CmWABT170UTfv3Thja+LgEZhKrHCHo0jXwzirDWZb1qS
	 jRzxQWtcNYdCKtlNgu7wITG/BMngrQkyxuDCkDNlDKYmpULjIwpTiSeQvu7maxvcmp
	 6vkc5B0S/vN2VCGV1U4s2SZyH7pThgQdVvWLJ0B7qM5x6dy7tBXItPZcIzFP1XaEMY
	 Oh7gTjhhHq/myn36GM0WAp+8BvIxfoLGl+QkylyfLncrnU8iC8rZ4Q+AZizQycWNp1
	 u16FbiNE1y5tw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: directly wake up cleaner kthread in the BTRFS_IOC_SYNC ioctl
Date: Wed,  7 Aug 2024 18:47:50 +0100
Message-Id: <b4c0f0bc574a1b105a02132c2ebedb0e31f235eb.1723052137.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The BTRFS_IOC_SYNC ioctl wants to wake up the cleaner kthread so that it
does any pending work (subvolume deletion, delayed iputs, etc), however
it is waking up the transaction kthread, which in turn wakes up the
cleaner. Since we don't have any transaction to commit, as any ongoing
transaction was already committed when it called btrfs_sync_fs() and
the goal is just to wake up the cleaner thread, directly wake up the
cleaner instead of the transaction kthread.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e0a664b8a46a..ee01cc828883 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4765,11 +4765,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 			return ret;
 		ret = btrfs_sync_fs(inode->i_sb, 1);
 		/*
-		 * The transaction thread may want to do more work,
-		 * namely it pokes the cleaner kthread that will start
-		 * processing uncleaned subvols.
+		 * There may be work for the cleaner kthread to do (subvolume
+		 * deletion, delayed iputs, defrag inodes, etc), so wake it up.
 		 */
-		wake_up_process(fs_info->transaction_kthread);
+		wake_up_process(fs_info->cleaner_kthread);
 		return ret;
 	}
 	case BTRFS_IOC_START_SYNC:
-- 
2.43.0


