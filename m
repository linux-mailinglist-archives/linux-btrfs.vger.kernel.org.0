Return-Path: <linux-btrfs+bounces-7137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779DB94F1A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E12B247A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0902A184540;
	Mon, 12 Aug 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+Z9KHJZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30645183087;
	Mon, 12 Aug 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476458; cv=none; b=hwzte54WaDwah3JHAQXntd2SiTMMzApDJfiz3Yoe+AKKmrIN9g7uxp5aPlIlecrZ/pT4WXkhkAyaCcgBGXccjwx7LMledrY+xWrnVA5S73D6TC+Y48w04C7rbt+Y/Np40NtZ29ZsXLXhTECkx66zt0xwJUw55fOtILkAAv+dqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476458; c=relaxed/simple;
	bh=M/wMJjpZx6aJiSHtNxv7izRpHQehSQ8ZI6vFRVatl4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9lMWs8HtR8BPnyrHLfpiiGd6OlVH2mNUoFRfCoGBmJRs5xAIlD+mNNywpFkVen00Pq875Xz7JBPmLMer4XJqVoOlzX43dMVnmKCKZC3TtrjTVeoVn/I9M2ERmo2fDa9OR6CyxVxDhtS+KILQ698dAtTkMXTPMydhkejS2rs4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+Z9KHJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DA0C32782;
	Mon, 12 Aug 2024 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476458;
	bh=M/wMJjpZx6aJiSHtNxv7izRpHQehSQ8ZI6vFRVatl4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+Z9KHJZssX2jlCXg0ZtSgoZdggsSqFhkOBIi0hGoITJPF5TWmVHffmJTJc5hTQ+u
	 n3ngPEO8es5ZmCdAHwJcsvWjCuX9ESNBoaVXVbBhEU6HKT+Hp0yBfPkcSSYSmS7NaV
	 k7Ws2cnENHAxiGB2nrkjZes/Hbmlkx31lkfLpaxNnnXwyUQ6lwrRlwO/dlgvgXvkk/
	 /xaFkezhSQlNtr4iF4kdQcTfCJVB93YSxVdX8F3F0Quxrrg5s35tdqk4o7+8Szj8Rf
	 nf0+PCtN8HItALEgqKP3b4+0ddMpd3I3L00WRLlCjTl7AXwuizM77ERLMwyl7Yd+eX
	 3V2cRy5msrZiw==
From: fdmanana@kernel.org
To: stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Filipe Manana <fdmanana@suse.com>,
	syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH for 5.15 stable] btrfs: fix double inode unlock for direct IO sync writes
Date: Mon, 12 Aug 2024 16:27:33 +0100
Message-ID: <363aee7827c9d6ff034b7e3ea2a5bf4959ff4905.1723046461.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723046461.git.fdmanana@suse.com>
References: <cover.1723046461.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115 upstream.

If we do a direct IO sync write, at btrfs_sync_file(), and we need to skip
inode logging or we get an error starting a transaction or an error when
flushing delalloc, we end up unlocking the inode when we shouldn't under
the 'out_release_extents' label, and then unlock it again at
btrfs_direct_write().

Fix that by checking if we have to skip inode unlocking under that label.

Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@google.com/
Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ca49c02e8f8..c44dfb4370d7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2433,7 +2433,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
-- 
2.43.0


