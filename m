Return-Path: <linux-btrfs+bounces-11661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35053A3D7C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B468189CF76
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C11F4E4B;
	Thu, 20 Feb 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goh34P2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2351DE2D8
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049514; cv=none; b=MoZjEmbYzPtTHjXEqoea52Vm6ZGODBzgF7rjkLkD8kVCyHkmAbL1VtAHBgqi4qhlFijdTcS2ZyKVCiFEZhXfdu2k2tXiYrJblsgSdxXkGj7U0EdFNIUCYbkgfhmXS2qq0R1spkiq/Zz7tNat6nvWXJ4nNVlhh6vH6Avipc6GeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049514; c=relaxed/simple;
	bh=TEyvVs9sSH67OdNK9N+PYvkA6S8b9X+bW4EZLLSSLHw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjFtpxYy1Iu2qsxiR3e8VfE/5TnpE5o9Ubij0Di9hsnnMIajuJ6V7s2R3wVwUiy23qe4AywD4B/ZM5zSc1NuDj4Tlfre81YhDInrsO694AzTXoqkvnpF83Gtx4MtQoTDiuH4gwd79HoHAgpLthI43TT1VAtei6bsQ2Ap3euIQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goh34P2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD43EC4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049514;
	bh=TEyvVs9sSH67OdNK9N+PYvkA6S8b9X+bW4EZLLSSLHw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=goh34P2m27MHdTtdnIVu1gEpszSp9VYL2z4VlBjPvWyvPuu7VPhsgUO+scgvQxe1f
	 kkF5zFxRzPMQGl799tR+p5HBRWSoxyBaYLQS7ul3rc4VLh6isNvjYcByG0tUYw5Eri
	 gdjNniMcJoM3fpjnzCAPrxxIW4sgD2LTBIp2C/a6ZH6gD6G2lEdXLXZYD0D3yNRKjj
	 qFe8YiR6FtqOrS6j4XTCRjXhoP8AaDOn3rp14UVlv6fpevd6yPAhutVcxTO9Vo4Sq5
	 wd6rWuSjLYPwf8mxQgmsXsaqxopBZZ/fJ+1Y2PE5r0lehrDZLwx8/8QDzY2yF+suf8
	 Io/tekPn+jsyQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 26/30] btrfs: send: simplify return logic from send_unlink()
Date: Thu, 20 Feb 2025 11:04:39 +0000
Message-Id: <08ce139f9df32e2449cccea0335687f6376875be.1740049233.git.fdmanana@suse.com>
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

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bda229c7084b..cbc9ca9db062 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -856,14 +856,13 @@ static int send_unlink(struct send_ctx *sctx, struct fs_path *path)
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_UNLINK);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2


