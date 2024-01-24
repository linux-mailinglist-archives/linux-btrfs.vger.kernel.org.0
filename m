Return-Path: <linux-btrfs+bounces-1758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3983B3C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559DBB22EC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC26C1353E9;
	Wed, 24 Jan 2024 21:19:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05772132C36
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131148; cv=none; b=tV1oS4aSAeo+3EjJ3Kury2zJGQvhsCVuhXSXQ4kZh9uqxLWYFyGUgDFO77N/T59svW6b0ZT5j+BVQiuFVo+EOQh3kpK9ZvZvBT/CBKurtJMMy3kgNhU5JY2PuZRWcSoh6qnYJMtpXNWW7iiebQiob6uGnhi4XTbzzkfAaK3G0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131148; c=relaxed/simple;
	bh=tEY2PPz5epcXFnqjIcxiOvJ8D9FMl+CUM4mJ7Bw1WSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+v6c/5juyxHf2HEOTgZPcpa2A8d9kCIehL2YVWCR+LZN5sX+zptrc4/p4YNW2jZmUqA4xUF4TyXbkVSBIIRcEqWTfqGtUQZCeKitRnNYmSy2pIFL6J/VftPhDhnCOMWShvep+Vma87GybrrTP7569Y7TO5YU6kdd1khmC2t3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7355821F9B;
	Wed, 24 Jan 2024 21:19:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BEEB13786;
	Wed, 24 Jan 2024 21:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2sRrGsl+sWXsdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:19:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 16/20] btrfs: change BUG_ON to assertion in reset_balance_state()
Date: Wed, 24 Jan 2024 22:18:40 +0100
Message-ID: <d76d7c5cff57d1a7f1efaca0ca4d8ef01e057b67.1706130791.git.dsterba@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7355821F9B
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The balance state machine is complex so it's good to verify the
assumptions in helpers, however reset_balance_state() is used
at the end of balance and fs_info::balance_ctl is properly set up before
and protected by the exclusive op ownership in btrfs_balance().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6aae92e4b424..59fc6ab18fef 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3634,7 +3634,7 @@ static void reset_balance_state(struct btrfs_fs_info *fs_info)
 	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
 	int ret;
 
-	BUG_ON(!fs_info->balance_ctl);
+	ASSERT(fs_info->balance_ctl);
 
 	spin_lock(&fs_info->balance_lock);
 	fs_info->balance_ctl = NULL;
-- 
2.42.1


