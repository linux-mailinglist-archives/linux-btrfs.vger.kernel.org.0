Return-Path: <linux-btrfs+bounces-19634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F8CB4899
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 248443000909
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796B20A5C4;
	Thu, 11 Dec 2025 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CS0Mh2SF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p9HjWRfE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AB2BE7D1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419346; cv=none; b=kmIpM8rLhY6c7RUDP3zXOamQYR1qq35DibRHpA1wqn5O3yT/G8unRQz4sl1dI0MLrV6khwcKueujLsvV09iT0XZn6fHrsQdMgqpzlZUcq2WWtaXlII2MEXto3eEQOAg4nPnZHcjgx/9saQsOuvCIfw+9GK5AR7whSw/S/fPHQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419346; c=relaxed/simple;
	bh=YhMRuNayUIssBlf7pLvtthUGa0OIHit4zyXZ9Sfd7Qc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VIS3R/eV+FPidp21Y7WLjJBNpS86jE42nS22/MfuWlqFlAqoGsLWRg41auHn5fMnl2tOluYDnH76Se/gEG9Qb73NTZTaVD1AKj/FB7obvEKS7o5biYfDhDEIAnPX3Gy6mWMLtIW0fbjJ1P7ESwuZ7lh2W9eLHey5n5wPoNpLWzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CS0Mh2SF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p9HjWRfE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1DB065BD3A
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765419338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FRsM5A+lfAUR+V7zVxFw//jT/taL1D6tRKi8H+jps48=;
	b=CS0Mh2SFCfS4N5u8yWQtukr35kWyVrwzlRCxawoBL/Ly3RYe+apapKQ45fZn3r5xNd5mrN
	MQnZi+CZ7Kd6GUYt70YMNiFIh9OZiQUWc9ZP2cAxYVCycwBIPG6ofgYd8WdPpisNQctngJ
	ZAIluysonV86sKUtBiLeXL5xT0jt+ps=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765419337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FRsM5A+lfAUR+V7zVxFw//jT/taL1D6tRKi8H+jps48=;
	b=p9HjWRfEZFSAkagCEK6nFI/jTnGEI2wwmK9b500S47XXB2tsJa1bShzl4dcCgb5n5ffjgu
	inmIric82BXmrTGrkTapCXijXGYD0Oi2gRZGe5w7vG0gUNr78wLwW7gsUnsU0of+xDtchG
	0P85tkwOIkjwC1vYgshfozGNghJaWAk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40C863EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sr1VAUgpOmmBAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 02:15:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix beyond-EOF write handling mostly for subpage and larger folios
Date: Thu, 11 Dec 2025 12:45:16 +1030
Message-ID: <cover.1765418669.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.69
X-Spam-Level: 
X-Spamd-Result: default: False [-2.69 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.09)[-0.454];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Filipe fixed a bug in commit 18de34daa7c6 ("btrfs: truncate ordered
extent when skipping writeback past i_size"), which can lead to btrfs
check reporting missing data checksum.

However that fix is not complete, we can still get file extents inserted
without any data checksum.

The root cause is that the original beyond-EOF handling is not compatible
with subpage/larger folios from day 1, thus as long as we're still using
the old [cur, end) range, there will always be something incorrect.

The old handling is always handling the range [cur, end), which at that
time can only be one fs block.

Later subpage support is still re-using that part, but the enhanced
btrfs_folio_clear_dirty() function allows passing a range that covers
non-dirty blocks, this enhanced behavior masked the problem.

The true fix to the beyond-EOF handling should handle each beyond-EOF
block one-by-one, just like how we handle regular writes.

The first patch is the minimal fix that can be backported, but
unfortunately that still relies on the commit 18de34daa7c6 ("btrfs: truncate
ordered extent when skipping writeback past i_size") itself, and can be
tricky for older branches.

The second patch is to add an extra ASSERT() to catch any OE extent that
doesn't have a proper reason to have no data checksum.
With that new ASSERT() we can catch missing cases more reliably.

Qu Wenruo (2):
  btrfs: fix beyond-EOF write handling
  btrfs: add an ASSERT() to catch ordered extents without datasum

 fs/btrfs/extent_io.c |  8 ++++----
 fs/btrfs/inode.c     | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.52.0


