Return-Path: <linux-btrfs+bounces-20165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA0CF957E
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 891FA30255AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA5331206;
	Tue,  6 Jan 2026 16:20:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3E2DA75C
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716457; cv=none; b=V7PvKRGbIQwDqoFlnC+EqN0eJiGfIMNyHWu6gzbpomAt8FD1z15PHqN8hLK9cLK4thMcQCz7BBANXaW0Hvc+jiQ8hAgP5tpoiYxbMjs7Q3Jr+tcFy9hMTMYA24N1CpAhTCCtbaj7KuFYJdALR0JkptrN297mofXgu3PHAC1ci5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716457; c=relaxed/simple;
	bh=1LFrHb7tDrvd2n1QsxqFaX+Lik6VkKSv9qJMi7c8s1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3vQHuceWsPIuSFtvoLCM0OTgktH0CPXfYbTfciCGmZYzERc6sZkX1uHuf0CU/kmCVytzooGPEq2xh2DwOXeq7yfVVlelZcC9HgpharumgnLrPGx6ab8yygIvu7f2QRrIlG7b2tv2OZprlfC/d7tIwXCTUlMku3wsgsWQ9cI7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3D6F33691;
	Tue,  6 Jan 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD16E3EA63;
	Tue,  6 Jan 2026 16:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AOwnLl82XWmgWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:20:47 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/12] btrfs: unify types for binary search variables
Date: Tue,  6 Jan 2026 17:20:25 +0100
Message-ID: <3fb05ea43fb3967a6327c2c0bf81f23fe2e57c82.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C3D6F33691
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

The variables calculating where to jump next are useing mixed in types
which requires some conversions on the instruction level. Using 'u32'
removes one call to 'movslq', making the main loop shorter.

This complements type conversion done in a724f313f84beb ("btrfs: do
unsigned integer division in the extent buffer binary search loop")

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1eef80c2108331..0a7ee47aa8aaab 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -766,7 +766,7 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
 		unsigned long offset;
 		struct btrfs_disk_key *tmp;
 		struct btrfs_disk_key unaligned;
-		int mid;
+		u32 mid;
 
 		mid = (low + high) / 2;
 		offset = p + mid * item_size;
-- 
2.51.1


