Return-Path: <linux-btrfs+bounces-12785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E4A7B59F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C1E3B9B7B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 01:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D6339A8;
	Fri,  4 Apr 2025 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tjS4Rs6N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tjS4Rs6N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54618AFC
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743731285; cv=none; b=iiOTEBUtefMFqmF88VwbIsMKjfP0UInqKmQhwpxjMZenmSJr/hWd+Cd0H0VO0bPeahzVaWnYeNWeK/G8Q29a/kPfBB7ENSmVAohsp/2e6wX+4is8sfb2C6HMQVqtmka914/WTdTD4I98XsU4Cl5nBIUHDTu/biWoaRNQwdIdzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743731285; c=relaxed/simple;
	bh=G6vdk2zNtc6ILjcpjwTrRXPb9HMML1nbKJzPypYq0TQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fDTUZGf+nQiGD8T9NzP0Zm/xAschKMlEZ4JDHvnIwLXly0QbGefmI29ayqUpknwsfTjTfn8v3VyI5I7A33f8cg2IvH2j5HMJvJ5Df+vls2a2XpJrurtRY12sFz1Ziw9lHY9MpNbhvpdYkneaTp4w1EISxglVeciNP+//JY8lvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tjS4Rs6N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tjS4Rs6N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CEC92118A
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3uo98yZWwhIWe2uhzyfVySLKmFJa9Yuq5x4FCYFMFMg=;
	b=tjS4Rs6NQKk4wnKil9mEosLBMuVBqQ18BjiHqgj5M/7dIZJ6u/IfLmQjt/2NsYZlEo/q9X
	rEUk94BCbWUBMJs6iKVEy3o/G6YCW8+8HMqNZlQ+u4JKg46L+XDVtaguq4c7D5+x3q2/jZ
	PqCftboa0C+oGZfIogKJZYowlJfu/pA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tjS4Rs6N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3uo98yZWwhIWe2uhzyfVySLKmFJa9Yuq5x4FCYFMFMg=;
	b=tjS4Rs6NQKk4wnKil9mEosLBMuVBqQ18BjiHqgj5M/7dIZJ6u/IfLmQjt/2NsYZlEo/q9X
	rEUk94BCbWUBMJs6iKVEy3o/G6YCW8+8HMqNZlQ+u4JKg46L+XDVtaguq4c7D5+x3q2/jZ
	PqCftboa0C+oGZfIogKJZYowlJfu/pA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61491134C7
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMGPCFA672dIDwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 01:48:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fsstress hang fix for large data folios
Date: Fri,  4 Apr 2025 12:17:39 +1030
Message-ID: <cover.1743731232.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CEC92118A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

With my local large data folios enabled btrfs, fsstress can hit a hang
where lock_delalloc_folios() fails to lock a folio.

It turns our that filemap_get_folios_contig() can return duplicated
folios, which is fatal for lock_delalloc_folios() and
unlock_delalloc_folio().

The series here is to address the annonying filemap_get_folios_contig()
behavior for large folios.

The first patch is a small cleanup to remove unnecessary early exits,
exposed during the next folio_contains() change.

The second patch uses folio_contains() to handle EOF detection for large
folios.

The final one is the fix of filemap_get_folios_contig(), by getting rid
of it.


Qu Wenruo (3):
  btrfs: remove unnecessary early exits in delalloc folio lock and
    unlock
  btrfs: use folio_contains() for EOF detection
  btrfs: get rid of filemap_get_folios_contig() calls

 fs/btrfs/compression.c           |  2 +-
 fs/btrfs/extent_io.c             | 20 +++++---------------
 fs/btrfs/tests/extent-io-tests.c |  3 +--
 3 files changed, 7 insertions(+), 18 deletions(-)

-- 
2.49.0


