Return-Path: <linux-btrfs+bounces-14645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6289EAD9495
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 20:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3621E4925
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A42343B6;
	Fri, 13 Jun 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZmqv2BC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD722F76C;
	Fri, 13 Jun 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839953; cv=none; b=tLvRtpDu2j2XNdYmz3LghZLlFLNWNKXoVGeyshzb15TccRbDumbmP8F6SI3tIoWbfrmn9uHFiQmdNVmR3b5cmWQ4Yi/Kn7ucj5J3HAUU1POanbFdjoe0HiZ8NeqyZy/gHsaBHNaPSAkzQl9K7sxtAvObbS6ZUE3OXKn/FDEVqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839953; c=relaxed/simple;
	bh=xl1b59oPWmJ1rntLzD003FXPGqJCUJXZnbl4FDjH9ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=og9FtKF4C12grSsEhP21+XFz+dGU36jNyZKUdCkLCxAY63JpJTBAohUihY9s8cC1iXEEmAXb3gE5zCNVdB7Pvc9ZfteuwDX5VmMaqHDKcbQIq3a75P5IY4Mm4hi7OccGoG1j3fcmoJjDfAkd0KFcTOi2KmZcLALs9dfWSRzfuwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZmqv2BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F16CC4CEEB;
	Fri, 13 Jun 2025 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749839952;
	bh=xl1b59oPWmJ1rntLzD003FXPGqJCUJXZnbl4FDjH9ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZmqv2BCb3NXXmBTAuOFQzmOdMdh9O6VYvqLiKmtNRElGbgJoeDMPrd/RP0iXyuWU
	 iVaUzVaspNA57y7DeiAodSP/l+Qz/BBe6l5nlKhUtfTtBAxxA8WwAhjndmVunZfgQt
	 xnM08m3NdlNb4vhBBv6Aa2Myw9v2ZNIA6GWnggHmH4RItwktzNsXtqcXdJaxyGg1t8
	 xCOkUwj8AThrJ+hLRpOxpoFEY2LjYRiEOKVVsv2LSDs7D+PjydigC5vdD152aVIjJl
	 TQo8OaKElXe18E8f0sN8Du+qZzYnhfCbiGvYPd4IGltpN1TtAwitleEfCoo9QZiA6G
	 aio13oCn7zb2Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: stop parsing crc32c driver name
Date: Fri, 13 Jun 2025 11:37:52 -0700
Message-ID: <20250613183753.31864-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613183753.31864-1-ebiggers@kernel.org>
References: <20250613183753.31864-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

To determine whether the crc32c implementation is "fast", use
crc32_optimizations() instead of parsing the crypto_shash driver name.
This keeps the code working as intended after the driver name is changed
by the next patch.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/btrfs/disk-io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1beb9458f622a..7bb453b69639c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2024,18 +2024,14 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		return PTR_ERR(csum_shash);
 	}
 
 	fs_info->csum_shash = csum_shash;
 
-	/*
-	 * Check if the checksum implementation is a fast accelerated one.
-	 * As-is this is a bit of a hack and should be replaced once the csum
-	 * implementations provide that information themselves.
-	 */
+	/* Check if the checksum implementation is a fast accelerated one. */
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
-		if (!strstr(crypto_shash_driver_name(csum_shash), "generic"))
+		if (crc32_optimizations() & CRC32C_OPTIMIZATION)
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		break;
 	case BTRFS_CSUM_TYPE_XXHASH:
 		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		break;
-- 
2.49.0


