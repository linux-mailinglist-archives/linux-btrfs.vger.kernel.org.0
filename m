Return-Path: <linux-btrfs+bounces-7433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9AE95CEE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAC43B2839B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A5188A2A;
	Fri, 23 Aug 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAcSw9+l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83319342E;
	Fri, 23 Aug 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421752; cv=none; b=jiYP1Fl9XCJhbkfB3W48Lq0lERv0tNWfWggtPZuURFC0P0AHwVpfvAGPZbcdvNHAA4KNOGBBCAod+7xvAsVCJLctfULQ5fZhb+s4tXRUm4Ie9150bEeuGjX9B18wJ5iBRRVFTmgTZGrf5yQvoMzNeXtAwqxTXo7ahBugrA5LHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421752; c=relaxed/simple;
	bh=VgJGEsN2QWKsMFQ2igE1tynWYaFIcjTvRMNcOzG4CLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neUz+Kp5fuUF2JUdhXRSnOS50g69s57UecUKtvSKBzUpFSRAu/KGq5rmM9JfU6uNSLVI5gHu+rGPokIHtXG4OObW3g5ztE8Cbt+CBO0p2Y9arEZ3vyqAiW6tRWeuKEs/Z3NtfhP1xmhvWPWH9lVVcX/UGQ2PiV39Y+W/xAPK35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAcSw9+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F587C4AF09;
	Fri, 23 Aug 2024 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421752;
	bh=VgJGEsN2QWKsMFQ2igE1tynWYaFIcjTvRMNcOzG4CLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAcSw9+lLxyfIcuWth8eL5W+D99INJKUXKjhZSWBq4/DfZKvgRAP791gc8b2WN6YM
	 XZxPmqn0kKKz/oKdNAgOpkUladKX+ZDSV0eCAnfRuZpD+h5/DmifjnbCRPX2m89qyh
	 daYZhOKjLzTHtEx0YXK3l+Upro6MSaOHElKGtjlwEDgWrAVMKGiMdJm+ZwLy9PQUGT
	 27fvoMfekp/Mebe5eqaizcSBdBfttZw2qLnyYLd+6mcWGyyZrTTA1tipdKSkXT66wh
	 NVojcYyzgucYIC0SMaoGBGo8xBG4Zz5T2BXKq7nDNIediEcXhtO0x2+2JIpVxNa5/b
	 QO0CeFyWZ9yWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 24/24] btrfs: update target inode's ctime on unlink
Date: Fri, 23 Aug 2024 10:00:46 -0400
Message-ID: <20240823140121.1974012-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 3bc2ac2f8f0b78a13140fc72022771efe0c9b778 ]

Unlink changes the link count on the target inode. POSIX mandates that
the ctime must also change when this occurs.

According to https://pubs.opengroup.org/onlinepubs/9699919799/functions/unlink.html:

"Upon successful completion, unlink() shall mark for update the last data
 modification and last file status change timestamps of the parent
 directory. Also, if the file's link count is not 0, the last file status
 change timestamp of the file shall be marked for update."

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add link to the opengroup docs ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39d22693e47b6..c128705ad98c1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4210,6 +4210,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
  	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode(trans, dir);
-- 
2.43.0


