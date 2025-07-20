Return-Path: <linux-btrfs+bounces-15572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2109B0B3C7
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 08:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0583B9DDF
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jul 2025 06:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C491C5D6A;
	Sun, 20 Jul 2025 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SitvvbM4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SitvvbM4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD820B22
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992977; cv=none; b=lYE9PVRGoS9vW30FSprYOeBeb1TWZeBuhVx2bk306E+jgbLdkmQ4RoZzLPwtMYknlJ3Uyi16vppJhG1mgNoQDU4CSFJZ9rY+q0oPaLN4FQBqK9JpnDl1iz8YrWWfWIbi/IXLBtNmK3ZeFLl/nqKbfbs76VJ4rx1gKtXBJcbnF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992977; c=relaxed/simple;
	bh=1Iw7s2MWugcpan5xavpLF9DC6/4VLgRaiAwaGqEJvEo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZXYxVxwr8SOYxbnW3j0RYo65OFSjcu1kqgPUp8RBYgkAaDAf11RJznS5fGvbivSQ57Ez6pW/5hqMXvV9ysXMYqv9vrKbqnX3/hHmdmiOx2uM3Kde4u5oR2nCA4VhPmb2v+xpW21ANrb+TQfwZpKh6PnxpjcCufjw7iB2eL+jyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SitvvbM4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SitvvbM4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04A882121E
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=U7CKYXUscFWGwPr4O6N8wRaLOkfWXx2Htg1BOMdqVe8=;
	b=SitvvbM4jYEOCe9ORrlOE7NdKGnBcM1GhIRtiKvfawCl4yBthxkqkyHu/JCXcWJ2CrjRk6
	5UGmcNcnv9/+jVAGCO/qA7LBZZ5quCB1l4QsSJ1ITFr+BFUMa1n3V/aNFDkZtm/P5XiJ1R
	jugACFVYCFudmjah3vwJDzdp+69KBkA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SitvvbM4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752992970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=U7CKYXUscFWGwPr4O6N8wRaLOkfWXx2Htg1BOMdqVe8=;
	b=SitvvbM4jYEOCe9ORrlOE7NdKGnBcM1GhIRtiKvfawCl4yBthxkqkyHu/JCXcWJ2CrjRk6
	5UGmcNcnv9/+jVAGCO/qA7LBZZ5quCB1l4QsSJ1ITFr+BFUMa1n3V/aNFDkZtm/P5XiJ1R
	jugACFVYCFudmjah3vwJDzdp+69KBkA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BDB213A1E
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3zU8O8iMfGjJfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Jul 2025 06:29:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: simple enhancement and fix for delalloc range
Date: Sun, 20 Jul 2025 15:59:08 +0930
Message-ID: <cover.1752992367.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 04A882121E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

When debugging the rare DEBUG_WARN() inside btrfs_writepage_cow_fixup(),
I just found several small things to fix/enhance:

- The double boolean parameters of cow_file_range()
  A simple enhancement with a single @flags to replace the two booleans.

- Inefficient folio iteration of btrfs_cleanup_ordered_extents()
  Enhance that function to support large folios better.

- Wrong parameters for btrfs_cleanup_ordered_extents() of
  nocow_one_range()
  Due to the wrong parameter (end other than length), we may clear
  Ordered flags for range out of our control, which can be some page
  under writeback and cause the DEBUG_WARN() inside
  btrfs_writepage_cow_fixup().

  However the call trace doesn't match the one I hit, which is normally
  cow_file_range() failure inside fallback_to_cow().
  Not the failure from nocow_one_range().

Although I already have an idea why the DEBUG_WARN() in
btrfs_writepage_cow_fixup() is triggered, the fix will be a little more
complex.

The root cause is that btrfs_cleanup_ordered_extents() is called on
unlocked folios inside run_delalloc_nocow().

As run_delalloc_nocow() can fallback to COW path, and succeeded
cow_file_range() will unlock the folios, we have no other way but to do
the cleanup on unlocked folios.

This has a small race window, where the unlocked folio is already under
writeback, and we cleared the ordered flag halfway, thus triggerring the
error.

The proper fix is to make run_delalloc_nocow() to keep folios
(and io tree range) locked until the full range is finished, just like
how cow_file_range() works, but that will be a much more complex series.

So for now just handle the small-and-simple enhancement and fix.

Qu Wenruo (3):
  btrfs: replace double boolean parameters of cow_file_range()
  btrfs: make btrfs_cleanup_ordered_extents() to support large folios
  btrfs: fix the wrong parameter for btrfs_cleanup_ordered_extents()

 fs/btrfs/inode.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

-- 
2.50.0


