Return-Path: <linux-btrfs+bounces-6584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93519375AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 11:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256931C21A29
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661D282D66;
	Fri, 19 Jul 2024 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ESlej0Ty";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ESlej0Ty"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F2824BD
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381233; cv=none; b=E+zTR2iB2P2rzYZAgiRuHyNVNbQxvWMSC+ArJlJugWKEBbTtSOf9l16aHKa3cFtb8ddDoPJ9PvZgq9PZ/3bqfK3lx0FDtn3XUu1mRCPzkwH1hnoC6n9BjeaK9/4d3VCHLJ64uFa4ItT/ogTVQ9y3b2Yuk+IZgNmbhI1plhuGs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381233; c=relaxed/simple;
	bh=rjskTv2kmZ5o/UrRdi6ppky/OVk2p9TDbRIzrW0wvDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvkIuNt+lwdGnnjwl2zVCWwMVBktat9n4XKKUAqeQ4tG9rvJIrBM/0RDhwBLmoL21vJDf+80xH8AvspMxazQL93NIs3eD+PZGOx0tiBcOIMPNUl6fUUiDZNjn6G+5YwFqrXhXoVMQYMgVp3Gdz/idh4hcu1HDXOmjRay5OABHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ESlej0Ty; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ESlej0Ty; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CADD1FCFB;
	Fri, 19 Jul 2024 09:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721381230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LkkVG+zcXmUXErtEZi44YqQYGZyxgEG49H3ledo0rtY=;
	b=ESlej0Ty97VHbutSCWKl3A/66Qh8XsI/+s2eex0ncf2x2d0sH0cLphCwHBOFAHGkJsn645
	5J6/l06KL4wNh9rpMOTh2ZHyYyo3QvmcTUXxcbOh3j6edCczbrL2aV09sUJ19/VYj66KbF
	BmvNmWJqPP1PXXF8TtJRsVLPooXi2DM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ESlej0Ty
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721381230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LkkVG+zcXmUXErtEZi44YqQYGZyxgEG49H3ledo0rtY=;
	b=ESlej0Ty97VHbutSCWKl3A/66Qh8XsI/+s2eex0ncf2x2d0sH0cLphCwHBOFAHGkJsn645
	5J6/l06KL4wNh9rpMOTh2ZHyYyo3QvmcTUXxcbOh3j6edCczbrL2aV09sUJ19/VYj66KbF
	BmvNmWJqPP1PXXF8TtJRsVLPooXi2DM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91935136F7;
	Fri, 19 Jul 2024 09:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TrH0EmwxmmYtRwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Jul 2024 09:27:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v2] btrfs: avoid using fixed char array size for tree names
Date: Fri, 19 Jul 2024 18:56:46 +0930
Message-ID: <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0CADD1FCFB

[BUG]
There is a bug report that using the latest trunk GCC, btrfs would cause
unterminated-string-initialization warning:

  linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE"      },
      |
      ^~~~~~~~~~~~~~~~~~

[CAUSE]
To print tree names we have an array of root_name_map structure, which
uses "char name[16];" to store the name string of a tree.

But the following trees have names exactly at 16 chars length:
- "BLOCK_GROUP_TREE"
- "RAID_STRIPE_TREE"

This means we will have no space for the terminating '\0', and can lead
to unexpected access when printing the name.

[FIX]
Instead of "char name[16];" use "const char *" instead.

Since the name strings are all read-only data, and are all NULL
terminated by default, there is not much need to bother the length at
all.

Fixes: edde81f1abf29 ("btrfs: add raid stripe tree pretty printer")
Fixes: 9c54e80ddc6bd ("btrfs: add code to support the block group root")
Reported-by: Sam James <sam@gentoo.org>
Reported-by: Alejandro Colomar <alx@kernel.org>
Suggested-by: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add all the needed tags
  Especially for the two fixes tags.

 fs/btrfs/print-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 32dcea662da3..fc821aa446f0 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -14,7 +14,7 @@
 
 struct root_name_map {
 	u64 id;
-	char name[16];
+	const char *name;
 };
 
 static const struct root_name_map root_map[] = {
-- 
2.45.2


