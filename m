Return-Path: <linux-btrfs+bounces-15772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE3B16923
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BB458107C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687322F39B;
	Wed, 30 Jul 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YYT4eVrg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YYT4eVrg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A414C62
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753915824; cv=none; b=M9GUu6O3Lc4z11bxKZY6KM2j7SSaCoQuoO6MPcAqtE5k+zRW+VHMdfL/ndT1UnjgOF8iG6dvKQ/Aq0cPjmChWB8MzXr3p4ravxoHKW2ID8iDoRhutKvYLndZLyk0wI/eIqqMkOVJK1KADYVr0gcTBfhugsnizB/2YKl/kiKGzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753915824; c=relaxed/simple;
	bh=gJGetr/qw3zgyi8tnFWOFmFBC+cRPyf76N1hrB3vJoo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nC4JpyDKc6nBQo50q/YZ2qYEY2C/6jUBBDsGDX6jctEAsCsomEUwdXjRn8bBH7+4mnqquRc5CK4wm8vrz/hJOuiPbnU237PZNRLOk1POnsmW6D7DkeeDvKs4lUNWU/ioiy5oy9o9/ViOqeAQik/Q1JmKilyZDvcqxt5m798QcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YYT4eVrg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YYT4eVrg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3518F21A68
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753915820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WT0qTw4JrlhuXZxcJb4GmygRUqN511xqJ5k487p+f+I=;
	b=YYT4eVrgHB0Zrc/CTkQacd85g7GuklvaDYT3OzCJHT3f9mnF4iXXSpkNZ5mYUWN4z7qTR4
	Fbb5RwljxxwgvbNXDTltcLkjTQs26uHb1pbzd0WvzVz/GL+gKTCV8dqnoqJ9Ty0MLph7Gm
	Jwu9/AuG32C9vYxfZLN4lpb34wg9K18=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YYT4eVrg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753915820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WT0qTw4JrlhuXZxcJb4GmygRUqN511xqJ5k487p+f+I=;
	b=YYT4eVrgHB0Zrc/CTkQacd85g7GuklvaDYT3OzCJHT3f9mnF4iXXSpkNZ5mYUWN4z7qTR4
	Fbb5RwljxxwgvbNXDTltcLkjTQs26uHb1pbzd0WvzVz/GL+gKTCV8dqnoqJ9Ty0MLph7Gm
	Jwu9/AuG32C9vYxfZLN4lpb34wg9K18=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C5C01388B
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qj6HC6uhimgKXwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:50:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: clear TAG_TOWRITE from buffer tree when submitting a tree block
Date: Thu, 31 Jul 2025 08:20:01 +0930
Message-ID: <4390972b1e06fa09068ed6f1d60dd60c46e69b87.1753915741.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3518F21A68
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[POSSIBLE BUG]
After commit 5e121ae687b8 ("btrfs: use buffer xarray for extent buffer
writeback operations"), we have a dedicated xarray for extent buffers,
and a lot of tags are migrated to that buffer tree, like
PAGECACHE_TAG_TOWRITE/DIRTY/WRITEBACK.

This frees us from the limits of page flags, but there is a new
asymmetric behavior, we call buffer_tree_tag_for_writeback() to set
PAGECACHE_TAG_TOWRITE for the involved ranges, but there is no one to
clear that tag.

Before that rework, we rely on the page cache tag which is cleared when
folio_start_writeback() is called.
Although this has its own problems (e.g. the first one calling
folio_start_writeback() will clear the tag for the whole page), it at
least cleared the tag.

But now our real tags are stored in the buffer tree, no one is really
clearing the PAGECACHE_TAG_TOWRITE tag now.

[FIX]
Thankfully this is not going to cause any real bug, but just some
inefficiency iterating the extent buffers.

As if we hit an extent buffer which is not dirty but still has the
PAGECACHE_TAG_TOWRITE tag, lock_extent_buffer_for_io() will skip it so
we won't writeback the extent buffer again.

To properly fix the inefficiency, just clear the PAGECACHE_TAG_TOWRITE
inside lock_extent_buffer_for_io().

There is no error path between lock_extent_buffer_for_io() and
write_one_eb(), so we're safe to clear the tag there.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1d029eaf6f1b..7e18296fce07 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1887,6 +1887,7 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 		xas_load(&xas);
 		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
 		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
+		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		xas_unlock_irqrestore(&xas, flags);
 
 		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
-- 
2.50.1


