Return-Path: <linux-btrfs+bounces-4282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A78A5E3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 01:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1097284D6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 23:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3081591F9;
	Mon, 15 Apr 2024 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hH86xH4Z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X4O7/kc2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132F158859
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223470; cv=none; b=oFesUDP7xXbifOQ+P6dQ1RlzJFmbYToliRXh6VRBgNhAQZvpDZduYJqtOiWmo9fDuMv7qNOoWFhScI88TgN2dPVSlH4aWGkhljRWjnk77d0FcSOQJF1109oFMJFd7r4BryyVyQxCBzkEY9vMHw6KbOaufbUnAOYK1aFzd7A9CQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223470; c=relaxed/simple;
	bh=lud8K9i7pBHHiz58tqZTDKL/rY710dF3gu9hR50L1SQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XINzt7ffdwuq2Dfi1S9utDGyrgKhgEUXQbMjh/aDcdFEhmgAjFafpbfClbuxDmCIlx+azEjxkVUFxiFiVdHbjX7kOwXoD4BVUySzRNISeZoLPFDo4TGmk0aBBDeoECx/47kCU+iEAKxLZcXtl9aqBVgUoM804zp9+M96qBTAcmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hH86xH4Z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X4O7/kc2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 259C75D4E1
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713223466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eqwsFzzkuim8+WEuuUHRefipsTXRpsNMxXRJV18gICY=;
	b=hH86xH4ZlzHGorOWoRDMmCMIwbjCu7QAWQgulW0y3acdeRtP1og85EGNO0s7X0AXPGowQ4
	huaiF4046yelnacopyT001q/742+Q1yynyfZ05fTTQcEXinl/LF962vcTP5FjV+AckvLVC
	uMBD5Ew+z0gfGFTpAxlzayjQ2ZiPcmQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="X4O7/kc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713223465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eqwsFzzkuim8+WEuuUHRefipsTXRpsNMxXRJV18gICY=;
	b=X4O7/kc26MUtdd6jUidof2V0KysHIwRHyZ1mTOXl7nGNmPaBZXxWrdg5RWmDbocaSnXXRc
	oyNvg2tI1X6RfC8WLq9jnIzXaIsu+CP2obIAoynoAiE+Pvch38KUBayWDoPoCTQ31s5kc2
	raD8Lbm1ESCIVJt/z2qqSr3LbANQJhw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 518311368B
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S9LdASi3HWZzSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 23:24:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of btrfs_split_ordered_extent()
Date: Tue, 16 Apr 2024 08:54:04 +0930
Message-ID: <cover.1713223082.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.99
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 259C75D4E1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.99 / 50.00];
	BAYES_HAM(-2.98)[99.90%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

During my extent_map members rework, I added a sanity check to make sure
regular non-compressed extent_map would have its disk_num_bytes to match
ram_bytes.

But that extent_map sanity check always fail as we have on-disk file
extent items which has its ram_bytes much larger than the corresponding
disk_num_bytes, even if it's not compressed.

It turns out that, the ram_bytes > disk_num_bytes is caused by
btrfs_split_ordered_extent(), where it doesn't properly update
ram_bytes, resulting it larger than disk_num_bytes.

Thankfully everything is fine, as our code doesn't really bother
ram_bytes for non-compressed regular file extents, so no real damage.

Still I'd like to catch such problem in the future, so add another
tree-checker patch for this case.

And since the invalid ram_bytes is already in the wild for a while, we
do not want to bother the end users to fix their fs for nothing.
So the check is only behind DEBUG builds.

Furthermore, the tree-checker is only to make sure @ram_bytes <
@disk_num_bytes for non-compressed file extents.
As we still have other locations to make @ram_bytes < @disk_num_bytes.

And for btrfs-progs, I'm going to add extra check and repair support
soon.

Qu Wenruo (2):
  btrfs: set correct ram_bytes when splitting ordered extent
  btrfs: tree-checker: add one extra file extent item ram_bytes check

 fs/btrfs/ordered-data.c |  1 +
 fs/btrfs/tree-checker.c | 35 +++++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.44.0


