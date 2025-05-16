Return-Path: <linux-btrfs+bounces-14088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E238ABA2A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCACD7BA6A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4F2459D4;
	Fri, 16 May 2025 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeupxVVf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7220221D9E
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419417; cv=none; b=R9GXNg+sApxdH7WbH4dA2UaRrInNCEiM+M4zUvcrUruskzQ/jpAVhqRcZRG6FLjerADgStpOrmOWmWmKfypLvWKXhpc8wTRysBkzLfLGU3QPfkWqe7QTdxQ8d/oas1FZfm7BhoRujiXRVLEsIaQcoC8q4wMpFY0qArQZpSRgDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419417; c=relaxed/simple;
	bh=tP1auKZGIgAyaKiTmJNK3YYlOP/q6HUoZ+TmvTaCilc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Hwspa1yJr4sij/Q3GV8YJEKSfsqnYoplqRnCPi0lKRbLjR/9Zx8zhvJIB4lnuww+0+gv6lC7m0mVwc2wnimSwQ1uA4zMBQkaZS+pULGTciiC0zVezgOY/5Hgq6kaCjsCAQ90FH5CLWRBjoRG36iwo5bG6Q2egjqCwmS/Ap7hEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeupxVVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C652BC4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747419417;
	bh=tP1auKZGIgAyaKiTmJNK3YYlOP/q6HUoZ+TmvTaCilc=;
	h=From:To:Subject:Date:From;
	b=NeupxVVf+JU1Qm4v6hsBfW1geb8/m8OqvagDUvncewXKIgymePANwBTZoaMalQzXe
	 hsDAp9PW0zxGt9LSdhzlplEiVrz3Wnc/ZUfDI2NFS2LheSCdN0/x/X23oVZTCr2kRA
	 PZm5kGfrmoshRP3MyPTx41lTdf2W7ZAjHIiUvdKpbmCIGhYmw5motG8j6agWMq6EU0
	 e3i8SUaPz8vkvmPKpLr/h9iUYiD3xrqpFp/2I4X+gP5VRz0Ih3Iium5HL8es1phO4O
	 NXqq0BZZLtntxN9Ty8rOE3y+5maVVDNBK78PKRbB3Oshjtsf2ntTDUu+r5N1vfns/W
	 Xr52vCONitn/A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless 'out' label from clone_finish_inode_update()
Date: Fri, 16 May 2025 19:16:54 +0100
Message-Id: <a32c6856d38b6f2f9452ddba50627a7acb04cfde.1747419369.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The label is only used once and we can instead return directly where it's
used, besides the fact that all we do under the label is to return the
value of 'ret'. So get rid of the label and return directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 62161beca559..5eacd3584a8d 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -46,11 +46,9 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
-		goto out;
+		return ret;
 	}
-	ret = btrfs_end_transaction(trans);
-out:
-	return ret;
+	return btrfs_end_transaction(trans);
 }
 
 static int copy_inline_to_page(struct btrfs_inode *inode,
-- 
2.47.2


