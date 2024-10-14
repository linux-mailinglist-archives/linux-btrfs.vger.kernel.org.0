Return-Path: <linux-btrfs+bounces-8898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B888E99D3CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB5F287802
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E031ABEB8;
	Mon, 14 Oct 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNTOWE06"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CA1AB6DD
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920794; cv=none; b=J+3psJmGs+liJFfh0hwsICPRiNM23FP58hjIC6qvc8dwlVCcxghPQfwlR4YxiLNdwipfP9PP5DrfMkQ0woBJj6QmXrp+fw9uc0ylk54Jgw+9bD4eqG2vllEWYx8NJe99vc+5kRH12YFtHeKjXSnbLig9t6co0XCDJBzKEcGopYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920794; c=relaxed/simple;
	bh=EXm/zb+jhX9Gdu602L400Dsckop5IEVLZpxY+fAXq/I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZCwsD0+JFFzntdHqrtImPSTKVAbJopm22tIFgXj58+ru4R4tKVcUrZkiu0qC8o9BxNDDRlYGI+zu00FDCUEli10W/dS2o7Pd0M4Xe33PfwACZ91I/BVm6jVL+IGtMS562YCY3OiyF6wCweLhgAINVUhQJtNekORQLxEk1zdc5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNTOWE06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CF0C4CEC3
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728920793;
	bh=EXm/zb+jhX9Gdu602L400Dsckop5IEVLZpxY+fAXq/I=;
	h=From:To:Subject:Date:From;
	b=XNTOWE06WsbEb7qnyUN6iRwk/Tof39dWiGV+OSZwxQ2tDPQ4neHjhgSsAoDwg+hNx
	 W1Wfm2lPxIqHrwYuTSkzQ4Cemt5lNbpE/QNG9m+YvooZkbQORLYIlN5BYVwC+4F+0I
	 Fdj4QKAJwUUoP0EOvK8PiAmcKwyM9ZfBys2Mugxh5/gDlGhzkW5pOjRXFxB3F6A8Aj
	 BP5VNTFwecMySU0Xf+HSymVF2K3FSLUwSarZctO3NVofoIDEoSWxV7kE/GI2kTO2w3
	 fWRF3ZOCSrDRytINyrGtgeVJ4T5A8M3vP5LXJmb2BWT1x3vUhRF5ouCAn+S8tqSTYJ
	 rhrjT7BrunrUQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: clear force-compress on remount when compress mount option is given
Date: Mon, 14 Oct 2024 16:46:30 +0100
Message-Id: <4d68f9e1e230dba0dfa70fb664540a962e0ae055.1728920737.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After the migration to use fs context for processing mount options we had
a slight change in the semantics for remounting a filesystem that was
mounted with compress-force. Before we could clear compress-force by
passing only "-o compress[=algo]" during a remount, but after that change
that does not work anymore, force-compress is still present and one needs
to pass "-o compress-force=no,compress[=algo]" to the mount command.

Example, when running on a kernel 6.8+:

  $ mount -o compress-force=zlib:9 /dev/sdi /mnt/sdi
  $ mount | grep sdi
  /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress-force=zlib:9,discard=async,space_cache=v2,subvolid=5,subvol=/)

  $ mount -o remount,compress=zlib:5 /mnt/sdi
  $ mount | grep $sdi
  /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress-force=zlib:5,discard=async,space_cache=v2,subvolid=5,subvol=/)

On a 6.7 kernel (or older):

  $ mount -o compress-force=zlib:9 /dev/sdi /mnt/sdi
  $ mount | grep sdi
  /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress-force=zlib:9,discard=async,space_cache=v2,subvolid=5,subvol=/)

  $ mount -o remount,compress=zlib:5 /mnt/sdi
  $ mount | grep sdi
  /dev/sdi on /mnt/sdi type btrfs (rw,relatime,compress=zlib:5,discard=async,space_cache=v2,subvolid=5,subvol=/)

So update btrfs_parse_param() to clear "compress-force" when "compress" is
given, providing the same semantics as kernel 6.7 and older.

Reported-by: Roman Mamedov <rm@romanrm.net>
Link: https://lore.kernel.org/linux-btrfs/20241014182416.13d0f8b0@nvm/
CC: stable@vger.kernel.org # 6.8+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index e8a5bf4af918..a4711640c0b4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -340,6 +340,15 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		fallthrough;
 	case Opt_compress:
 	case Opt_compress_type:
+		/*
+		 * Provide the same semantics as older kernels that don't use fs
+		 * context, specifying the "compress" option clears
+		 * "force-compress" without the need to pass
+		 * "compress-force=[no|none]" before specifying "compress".
+		 */
+		if (opt != Opt_compress_force && opt != Opt_compress_force_type)
+			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+
 		if (opt == Opt_compress || opt == Opt_compress_force) {
 			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
 			ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
-- 
2.43.0


