Return-Path: <linux-btrfs+bounces-14366-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9920ACAC84
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50716196063E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FE1FFC5D;
	Mon,  2 Jun 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogactl5b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D6202984
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860398; cv=none; b=EU8sb48bRyFF8cfvrbBFu4Y8EFU+U1ul8+5SZRPLNbBpxr7amFSr8eu8Skqo00UmDsHn5SccMCm1ZiXbm2ACL+FINgcD9InOz6Npen1bIv39qrP+vLDZdcCClGBdePUqrp3f2PkC9m+Vj6VNtAmfjVWkFqNH10XUvV92kt1r6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860398; c=relaxed/simple;
	bh=7BAYAHfltR9XrHTsLE8gghe8hlW7m241RX0+BQiHmPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8Xhco5Eek/iceeXny8MduMSZboA8tb5qGpUHciDUz5d1i2fXQ5VjMOz27UdxltxMGMj3Yog4wfamSUW8+3EQywb3ojA67DeyjlvInmKiAqkVNgfdZ2QJIPFtOZI28hQIk2w6KQ5HoXh5u3N8tGlaqj016RXttrYNMX2cSORuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogactl5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204E0C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860398;
	bh=7BAYAHfltR9XrHTsLE8gghe8hlW7m241RX0+BQiHmPs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ogactl5bIzsv/FFvbuXgzmqB0fe90q5t+yOTBi+tsWbENEnFmkw+r4x/+oPvvORPL
	 UuVUIdS5SmEk1BqLZIN6O6F+DtXfR3NWitTbDNDgH/6o33U0a+OxfbgY2/NhIJWqsF
	 ADI5ID86mO3uTjNuIuevAL5Vka7vi0x6TQaW8/FJbtSxlN+LWsnZHijQIfLlUUIwwS
	 uYV3aU/rKmEYc/scVdK+WY40et7ULuDcs9D4c2Jglm+P9L3a3v2okCtYS9btg40X7D
	 q3qkFu9KJzBjn5GMO8I5cY2KIZwLxHjd+Iw77lBZi8WHj8C4DWRHFYj3V3S0mbDZmK
	 QRdcKtVfWp3rA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/14] btrfs: use btrfs_del_item() at del_logged_dentry()
Date: Mon,  2 Jun 2025 11:32:57 +0100
Message-ID: <0a85b12031aa2a181bae8204123a9ec92de6d74e.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to use btrfs_delete_one_dir_name() at del_logged_dentry()
because we are processing a dir index key which can contain only a single
name, unlike dir item keys which can encode multiple names in case of name
hash collisions. We have explicitly looked up for a dir index key by
calling btrfs_lookup_dir_index_item() and we don't log dir item keys
anymore (since commit 339d03542484 ("btrfs: only copy dir index keys when
logging a directory")). So simplify and use btrfs_del_item() directly
instead of btrfs_delete_one_dir_name().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5af0e2d0634e..4f0a86805dc2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3432,7 +3432,7 @@ static int del_logged_dentry(struct btrfs_trans_handle *trans,
 	 * inode item because on log replay we update the field to reflect
 	 * all existing entries in the directory (see overwrite_item()).
 	 */
-	return btrfs_delete_one_dir_name(trans, log, path, di);
+	return btrfs_del_item(trans, log, path);
 }
 
 /*
-- 
2.47.2


