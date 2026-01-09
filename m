Return-Path: <linux-btrfs+bounces-20316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80ED0734D
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 06:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172E73018950
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 05:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5021E5201;
	Fri,  9 Jan 2026 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QURHIJI1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QURHIJI1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DAF78F3E
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767936698; cv=none; b=l3CqFoevWEJLpLhSObNkoleUoZCXZSQ7/cajrSEJ+u37b8pfI1RtlxDO8ei7eTrPXK8s6cES4pfbPJtkh6xazrIzwf4/P7Xe7gb3zIfGB4qwm+ERVYlD6ZzLV/UEWDIojhTxMluVN0JuM+euFLs5Z40i7BfE4z4Zm0qQdA73PU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767936698; c=relaxed/simple;
	bh=jdhXlGmBp8XMCNu6pQZ3UWIqpb1FjRh1h9QAb5w8Hx4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lni9yIENBTj0TiKscexdBdyDvNU/cWySEG81fWSzDaTk5KCPwTGlvL1gaBcrXA09v18UgUEL+s044QmODm5GYi70/MwUhxgEH/iI5XSImLw/WZvBrNHuFIvSmX6oXvyYhbhjcOOGzH/ol9J5hlHo5SJj6tMxEV31ASz+c2ChUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QURHIJI1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QURHIJI1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 947FE3451F
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767936694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=stZ3fGRHOPi0lcyyKhi3MCQ4mY/kELR418ZYf5AeMwk=;
	b=QURHIJI1V3GThtuXxMaBPV9o99bQRsi8RX2VuVmmSMe5hzSvNME37hwY04QJmwRwWBim0M
	PxFBO0jod+3lke05rEirhUpiyMxrhLlM78oU8UTP9BbdXnMu+NTZsZ5a+x5Dtt2vuym9RS
	KiAh7Y4xiL9Q709s3w0fxH0Fx6qHHMI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QURHIJI1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767936694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=stZ3fGRHOPi0lcyyKhi3MCQ4mY/kELR418ZYf5AeMwk=;
	b=QURHIJI1V3GThtuXxMaBPV9o99bQRsi8RX2VuVmmSMe5hzSvNME37hwY04QJmwRwWBim0M
	PxFBO0jod+3lke05rEirhUpiyMxrhLlM78oU8UTP9BbdXnMu+NTZsZ5a+x5Dtt2vuym9RS
	KiAh7Y4xiL9Q709s3w0fxH0Fx6qHHMI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C876D3EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 05:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8tprIbWSYGk9IQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 05:31:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: mkfs: optimize the discard behavior so it won't drive me crazy
Date: Fri,  9 Jan 2026 16:01:13 +1030
Message-ID: <cover.1767936141.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 947FE3451F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

After commit 4b861c186592 ("btrfs-progs: mkfs: discard free space"),
mkfs.btrfs inside my VM is much slower.

Previously it takes only around 0.015s, now it takes over 0.750s, which
is around 50x regression, and that's already when that virtio-blk device
is already ignoring discard commands.

It turns out that the main problem is inside how we submit discard
requests.

Currently we submit the discard immediately after finding a free space,
but for DUP profiles (the default one for metadata/system chunks), we
send a discard request for each mirror.

Since it's DUP, the two device extents are on the same device, then the
for next free space we send two discard requests again, meaning we're
switching between two different dev extents, making the discard requests
more like some random writes, greatly reduce the peroformance.

The root fix is in the second patch, where we record and re-order the
discard requests for each device, so that the eventual requests are all
in ascending order and are merged when possible.

The first patch is just a minor cleanup to reduce the call of
btrfs_map_blocks() by using WRITE for discard.

With this series, the runtime of mkfs.btrfs is still increased (by the
free space discarding), but still fast enough that even I can not sense
it (0.015s - > 0.017s), finally bring back my inner peace.

Qu Wenruo (2):
  btrfs-progs: mkfs: discard the logical range in one search
  btrfs-progs: mkfs: optimise the block group discarding behavior

 kernel-shared/volumes.c |   4 ++
 kernel-shared/volumes.h |   3 ++
 mkfs/main.c             | 100 ++++++++++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 24 deletions(-)

--
2.52.0


