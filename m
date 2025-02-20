Return-Path: <linux-btrfs+bounces-11658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73EA3D7BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BE619C1609
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABA1F12E0;
	Thu, 20 Feb 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1y6Gy/G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9E1B0F19
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049511; cv=none; b=hJysHtjHEqJgHdzbQSYI88u9YlYEiHejB3/kz6qY/UPK3/qMJZDri/RBdX5uRBE0ynd0EZPD6cO6jt0xEll9INbjRUBQJqNiK3bJHZb2aY4t7MhVYdedJK6uAuMUFOoGF1PlD4DDu8PBlVhzOs1MjpnvQLAZ02XlIWJ8Hluuda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049511; c=relaxed/simple;
	bh=Z0gnj+j7I6tesK3fs5Y4sZ2G4+laz1ers4iiF43Kdgs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTwFnit8g35GaPCxWOZrmvBnXS85EPfhOv9A3yyqVa3TFNghOwxylSYKVLlrLYA0aa8MSFbHfF7fIl6+FVtqV0rvU+4+IEJODw2dpjfGPuhrc+u557kUOLN+ecLARUJ02AZnuyfTv00HsI7hSQyFotkEZTFZ1xPyvQOOMmcu7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1y6Gy/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CC6C4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049511;
	bh=Z0gnj+j7I6tesK3fs5Y4sZ2G4+laz1ers4iiF43Kdgs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y1y6Gy/GHtYzfMBfx65XuWkI9CGNQZI142L4ZLgv9Q/4+xcIs/u4TX0xmuXvYV4ej
	 PZjpseyEEYKPieypt0rKcK9Yz0bo8goxGRetMwL3K0z8wTXj2n3FbGUAQDCyHRBs9/
	 KFr20sy4VA696UKWtk/QSPZ3wxF+jDwYdvnIezGOKhDlTNSlRkavxBjs5bFzXDEW5G
	 ukA1S7Ae3vl0byug5f6oMu6N/SYNvBiDCZeOIC1nhHdNPF6cVF9CwRLaFdSe8M+TzE
	 n29J0LP3GROo61HSfHPy1zOJQHuMKMbcxPYMkmmI1e9CKnbt7QZcm7TotNxJ5hv03+
	 k3LGWQFy6bvrw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 23/30] btrfs: send: simplify return logic from send_verity()
Date: Thu, 20 Feb 2025 11:04:36 +0000
Message-Id: <f06cc1546f3dacbabaf4c27e4f8e39132e9d6f29.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need for the 'out' label as there are no resources to cleanup
in case of an error and we can directly return if begin_cmd() fails.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0cbc8b5b6fab..f161e6a695bd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5122,7 +5122,7 @@ static int send_verity(struct send_ctx *sctx, struct fs_path *path,
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_ENABLE_VERITY);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 	TLV_PUT_U8(sctx, BTRFS_SEND_A_VERITY_ALGORITHM,
@@ -5137,7 +5137,6 @@ static int send_verity(struct send_ctx *sctx, struct fs_path *path,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2


