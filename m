Return-Path: <linux-btrfs+bounces-16834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080CB5824A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C4F4C233C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67C27BF7E;
	Mon, 15 Sep 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpDCvVBf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7025CC42
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954247; cv=none; b=DZHSDRjtED7TP7Jtkcy2GS17GC1GvIKOIxpFEGkEUI8B1fGRHRT8V/MiUm+McbcSbwXB6IJpNrGK9gaax1jATMXpFRTJ2ZhbeQkAvfQvqikkNKGXI9VY7pM7TsNaaJ5BaVCUfhooDz6PJXvpxhHJRR+cwkcQlfZXnOn3A6mCaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954247; c=relaxed/simple;
	bh=3yPwYo2jTrQLqsoZOGXIpHVEy+6ieenInut7+vnT06c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy5v4HbxkGtnbeT7HU4YwM+rPp4biwPRRRh0OAsuxP7HofIpM0ZuxE1n5//8hC0Nby51J/CiC+NbKwImT7320GfESTxFpL0TDWq/UPtLvdly3ocGhIWo2qFz5vuM2B8PaJ9TAuHbF1QkCxTn+IqNyRDY9jtndTue1b/3y6tuxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpDCvVBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFB2C4CEFB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954245;
	bh=3yPwYo2jTrQLqsoZOGXIpHVEy+6ieenInut7+vnT06c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JpDCvVBfwDdLUUcOgarjtJZ7h5jdBGjBy5uUbWPxYmqBRP+miBAT132cx5BeQNst+
	 BiDdZLvzJJWRH8kzyclpQxVbFcOhsA7NhqhiI91nuJgRCsYAwjDEzGSDYizeGy9w2Z
	 X3y0IBr2KGcgHSyccPOh7n/Q5t1b26JtTfPySgHxd/Il3NTdflWGIHEUF0whjMuhuM
	 Sb5SVohVMOpLG9aVnyIj8OcSjV5t9Z7/P1VyxbiJK5ih5vEEB6MoXc3RfHWNFsncOL
	 rPh7+5aSP8Ap09zDVRk3+UFiVJvBrf/kCS4AoIvULUvtGVi24LjLo7Frb7M5s3OHs/
	 67xTolySFDsTA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs: print-tree: print compression type for file extent items
Date: Mon, 15 Sep 2025 17:37:11 +0100
Message-ID: <d1c5a6cd8351de3f2dc21feb91f4187888a0c2de.1757952682.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
References: <cover.1757952682.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are not printing anything about the compression type, so add that
useful information in the same format as btrfs-progs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 835b41874a7a..417e3860cd25 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -424,9 +424,10 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 				btrfs_file_extent_type(l, fi));
 			if (btrfs_file_extent_type(l, fi) ==
 			    BTRFS_FILE_EXTENT_INLINE) {
-				pr_info("\t\tinline extent data size %u ram_bytes %llu\n",
+				pr_info("\t\tinline extent data size %u ram_bytes %llu compression %hhu\n",
 					btrfs_file_extent_inline_item_len(l, i),
-					btrfs_file_extent_ram_bytes(l, fi));
+					btrfs_file_extent_ram_bytes(l, fi),
+					btrfs_file_extent_compression(l, fi));
 				break;
 			}
 			pr_info("\t\textent data disk bytenr %llu nr %llu\n",
@@ -436,6 +437,8 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			       btrfs_file_extent_offset(l, fi),
 			       btrfs_file_extent_num_bytes(l, fi),
 			       btrfs_file_extent_ram_bytes(l, fi));
+			pr_info("\t\textent compression %hhu\n",
+				btrfs_file_extent_compression(l, fi));
 			break;
 		case BTRFS_BLOCK_GROUP_ITEM_KEY:
 			bi = btrfs_item_ptr(l, i,
-- 
2.47.2


