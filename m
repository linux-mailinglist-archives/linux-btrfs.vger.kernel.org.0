Return-Path: <linux-btrfs+bounces-2335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AD8520D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 22:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD721F21F03
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 21:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505824D131;
	Mon, 12 Feb 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6mTlhHe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598B4CE12
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775170; cv=none; b=NNZRqIM+2MvMQX4fB5iQNMyjMvTJiYfYhSesmwIKDniX+LuyultkLbm+c58edfu+AqpnbpEuTQZ7RQ7wpF0NGbbKiCXN6XjlcowjJlGgpDyZDOhY2uZvlYK2IzKVy0ssIGkzL2s0D4YtixhuONk5D+CQARVF1Xcun1A50VeTlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775170; c=relaxed/simple;
	bh=8T1zO8zVaagdxCmKS0oUJPdaSSs+V9tNmM6PmaGGkfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kYrndcpGKjsEFS9IA16E1gkhBqkai0EpUEWtnWoOWCi/n7r3yI9KcOg2KY+Z2xy2SU+SZfQZT6TMMVmji9Il8jslnWs8NOa5yYx+EMfdFSQzWFlts1L//b2H2auFyYthvJJ/zLV3pT/F/qnDZlo7vXuvQSBRoV+egOnOj3G9vnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6mTlhHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD7EC433C7;
	Mon, 12 Feb 2024 21:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707775169;
	bh=8T1zO8zVaagdxCmKS0oUJPdaSSs+V9tNmM6PmaGGkfI=;
	h=From:To:Cc:Subject:Date:From;
	b=X6mTlhHe6XmOKUy/kornmZ1PNSojClsnqQWRxDZExEF+RMu10aR1RixW7t9d1neW8
	 F8e0E6o2+BYLjACpKG+AXXXDOgI6iU8ozVO6ln31xpKUTNHXDAzZZdQYZ2oDtLdspk
	 53nvnZ9DgOr+/EhkOWR5pyTiAhFklBDHebTc8mTAQVdPF4DJSlJVZdq/eeDSB/DKld
	 DBk2YStgrqZZjqq0S6YgHI5RDHLq706vo2f4MCAA2DAOnZtagqLy1cCKbCQbpHScAz
	 KuByOG84QxuyR3ZnlyU8z5Fi5coFO+pXhb2RzRiyZuJq2gx0OXFBd57nH0MadE9hfS
	 YIhMW+J1uMSbw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: johannes.thumshirn@wdc.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: zoned: fix chunk map leak when loading block group zone info
Date: Mon, 12 Feb 2024 21:59:21 +0000
Message-Id: <0bdc61c9216d238eaa4abb6edfb1c5d9c8e86c52.1707775003.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_load_block_group_zone_info() we never drop a reference on the
chunk map we have looked up, therefore leaking a reference on it. So
add the missing btrfs_free_chunk_map() at the end of the function.

Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk maps")
Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d9716456bce0..46537d606dc3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1668,6 +1668,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 	bitmap_free(active);
 	kfree(zone_info);
+	btrfs_free_chunk_map(map);
 
 	return ret;
 }
-- 
2.40.1


