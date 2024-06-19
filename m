Return-Path: <linux-btrfs+bounces-5825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999A90F4D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C881F2346E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71124155744;
	Wed, 19 Jun 2024 17:09:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B15155336
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816953; cv=none; b=AVy+heeWVUUWf6w8M4n5UtflZhhdj5dNqo/0Wy4GK7xxfS2kQ5ZZZf4H2Kdbr93nMdVu2bCqNih9QNIE1t1f6U/eERPG0AwvUt+gU2uuSFonyKPrVZfgPvPczciR2I+Tu3OJvlV9KBTaBCOIzP/+Z18jYPKPEhZWqqr1KEtML3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816953; c=relaxed/simple;
	bh=wuJGHtQ4M9g8xPAtZ4WESXo50YuUMm0xp3xg8vgdMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etEqAHhx02bwPLdhqPU9SLqQwO+tudiJR59elIV2NGCaBIoOxXeayUIIhVRIpXfxPTbQn8q7yFGOrtuJL/1zlf/fBYn3Y/j5nCzSR4SLVnZG5/0IYxwl6BeaQX/kgRTTvXxtNMiTMNSnuMYqmIsTXC/p9gNb3XlFF7lnqjkvGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BE871F7C7;
	Wed, 19 Jun 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6584D13668;
	Wed, 19 Jun 2024 17:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AePFGLUQc2aAQwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 19 Jun 2024 17:09:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: only print error message when checking item size in print_extent_item()
Date: Wed, 19 Jun 2024 19:09:01 +0200
Message-ID: <a60b39b899713e59a07d87eaae01b19769ca4d36.1718816796.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1718816796.git.dsterba@suse.com>
References: <cover.1718816796.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 6BE871F7C7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

The extent item used to have a v0 that was removed in 6.6. There's a
check for minimum expected size that could lead to
btrfs_handle_fs_error() that would make the filesystem read-only. As we
don't have v0 anymore (and haven't seen any reports in the deprecation
period), handle this in a less intrusive way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/print-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 7e46aa8a0444..ffe89db24bec 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -109,7 +109,7 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 		btrfs_err(eb->fs_info,
 			  "unexpected extent item size, has %u expect >= %zu",
 			  item_size, sizeof(*ei));
-		btrfs_handle_fs_error(eb->fs_info, -EUCLEAN, NULL);
+		return;
 	}
 
 	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
-- 
2.45.0


