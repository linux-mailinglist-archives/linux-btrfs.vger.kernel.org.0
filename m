Return-Path: <linux-btrfs+bounces-1745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5FB83B3B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E491F256E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459D1350F7;
	Wed, 24 Jan 2024 21:18:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206E7E760
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131109; cv=none; b=WlBJ7KyTdFcgadGcyzUCw1amwoY6UuOo3GnonQeEn4m+y21CI7aP9RuRFbizVQ61QByJxjD1zVmsdIOj8uNwQWy2MM3O0f6HSvhPiEkB4CQOy7MhCw5d2f1sfF4SCXuYICqlvtXJIfvfmMU1N4VPAXXu/g+4g0LpNM6DRQ+vujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131109; c=relaxed/simple;
	bh=GTo76esAR50E0HMV+KhA3PRwuoPZNTsCDCA+YgEiTzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MauzqzhlpT8rZSPTawT0VQD6IqcSmyM0IoCGaquRvJbHyu8JiFU7G5paSXzC/5GfgH0L71eh2aug21+pUEj/IupLrmdthk3OrGoABdlY9ikww0br8ZtTeP8a1NeQKVs1TiiQoUPgWaQR6pi4i++x3z2+wBs53u3YSiqvjsYqsr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 375F421F87;
	Wed, 24 Jan 2024 21:18:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30CF813786;
	Wed, 24 Jan 2024 21:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LS7oC6J+sWWndwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:18:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/20] btrfs: handle block group lookup error when it's being removed
Date: Wed, 24 Jan 2024 22:17:56 +0100
Message-ID: <cfe1bf94b8a6f24407795d3e1823a187ead04570.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 375F421F87
X-Spam-Flag: NO

The unlikely case of lookup error in btrfs_remove_block_group() can be
handled properly, in its caller this would lead to a transaction abort.
We can't do anything else, a block group must have been loaded first.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1905d76772a9..16a2b8609989 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1063,7 +1063,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	bool remove_rsv = false;
 
 	block_group = btrfs_lookup_block_group(fs_info, map->start);
-	BUG_ON(!block_group);
+	if (!block_group)
+		return -ENOENT;
+
 	BUG_ON(!block_group->ro);
 
 	trace_btrfs_remove_block_group(block_group);
-- 
2.42.1


