Return-Path: <linux-btrfs+bounces-14363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968FDACAC81
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D048A3BA130
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883691FE45D;
	Mon,  2 Jun 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9moE5Uo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C61DDC2C
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860396; cv=none; b=CDYcf/6fxBGCWgaAAiKb8baejx3/BCt3n76H0YhK+t+5rv16Rhlly/iHooisT+6+S0pkRhLfYnCSlz+zZqzA4YvgL0L0vls9cKKGGWfPectYflkXbYRL6gdd97/Zu46WG+tH/mqmEDRL5R11xtBs5A+vy3Cv2kF6xRSTwDk/AO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860396; c=relaxed/simple;
	bh=RgFfX135AUeaJggJFNQSn68kX8iC+AB+ysX62OiKEJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li9gPPI5xMldTuyfLEwVP0LONXlE2r2UhL8T0/+8hiEHrM5Vkpe5OKyxzA895aKXQU/3T+8n/1zFDP32hKlhqhzsc20fUICEXd83IN6Knav1gTBP9RHMIUI+6FhjRi+kmY5m3AKwDPvVvMwEEsaP3/pf/M/Knjnd9KCUIMWfZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9moE5Uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30087C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860396;
	bh=RgFfX135AUeaJggJFNQSn68kX8iC+AB+ysX62OiKEJs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k9moE5UoC6bFwVLnFI2oi3kdbPCIqtwTM20Jr+gGiuqDHB5CVRu11XoLLFBUa7b3Z
	 H9lZ0H2lehfHRkI3hS48KyrK9Ax26GWcSSKJx34z8D4N4mOZZGWQCVr2OizjRw8aWN
	 XES8m96sFvZlBaOXxGwcT307oneBs6SHRkiVY9KPu7LVCFPnfLfL/iIgZ6Lmi4a3yG
	 C8KxT4Fyfr/I7YB3ZmQ9d3Da0e8BaZqUeJ8aUd2tWDVHzfoBHhcpAX58CDHYmgwL2Q
	 UI+AiA73cQSqHXzCC2H3mIrOmFBgqe49N2krUkIMde2uCdr4RFP9qsnlNu7I6CKCI6
	 84jn7UuzNgQWg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/14] btrfs: assert we join log transaction at btrfs_del_inode_ref_in_log()
Date: Mon,  2 Jun 2025 11:32:55 +0100
Message-ID: <00aa3872102734e58f370d74c0b6a4d90894d759.1748789125.git.fdmanana@suse.com>
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

We are supposed to be able to join a log transaction at that point, since
we have determined that the inode was logged in the current transaction
with the call to inode_logged(). So ASSERT() we joined a log transaction
and also warn if we didn't in case assertions are disabled (the kernel
config doesn't have CONFIG_BTRFS_ASSERT=y), so that the issue gets noticed
and reported if it ever happens.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 0d5b79402312..5af0e2d0634e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3513,7 +3513,8 @@ void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 	}
 
 	ret = join_running_log_trans(root);
-	if (ret)
+	ASSERT(ret == 0, "join_running_log_trans() ret=%d", ret);
+	if (WARN_ON(ret))
 		return;
 	log = root->log_root;
 	mutex_lock(&inode->log_mutex);
-- 
2.47.2


