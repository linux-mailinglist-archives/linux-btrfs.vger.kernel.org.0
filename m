Return-Path: <linux-btrfs+bounces-13062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C3AA8B4D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669FB7AF48F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646923536A;
	Wed, 16 Apr 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n3+ih3Bu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n3+ih3Bu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD67233D9E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794502; cv=none; b=lZ6dr+HxKFyUeqtyB1ei97IUdo6VgM26Tah6N24+xmrRDOnfaY9ZSHPWAxtrM1rEgkxKxHdMOY/w0xG7++DAHF5xMABpULB+Jv+F0ct9SUMZpxk5i/bs9E1DclWgC47u41LP07UDLqrE1DHl4yXyTo5gI+RTCTCH0jgLNjCaEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794502; c=relaxed/simple;
	bh=RlHv3cVQlgy7nJrufENzkxYeQbDc6lJfJNTdXPHPzyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E03/zwaHs7HV4qBTApuKblA6e0m0J4YlY08ZyqOeKTnYDXVAJyBT9qDSUgfNJGBprmnxmuMJWyV1s1IyjO9H1djzE1etgIAJ8qRQ/Q+SUFKBLp7HLUPQ9AfQDpO5qvVcym5y3HGrNK921gBhJoWy3F4XAvk+6IrrMNVsoPC65JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3+ih3Bu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n3+ih3Bu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F8BD1F445;
	Wed, 16 Apr 2025 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QDZfjxhazkUzXaCoTJ1sdLqAG9v0DVezSBQ5TuTBV2k=;
	b=n3+ih3BueeUwtI+VfbdZ7zOffp3dimDOPIybL9un79eyHIQEHkoSn2/mkiprSVNx4h+3cr
	3wT6+rPktRqFlooUEny0uPL78Oj10KRT8wEG/h1N8EQK7jR8aLP3qhqb8KRX3lNyjszsW4
	jVsrWK+CObJBjAXHkFJiXpV4H6ktN8s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=n3+ih3Bu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QDZfjxhazkUzXaCoTJ1sdLqAG9v0DVezSBQ5TuTBV2k=;
	b=n3+ih3BueeUwtI+VfbdZ7zOffp3dimDOPIybL9un79eyHIQEHkoSn2/mkiprSVNx4h+3cr
	3wT6+rPktRqFlooUEny0uPL78Oj10KRT8wEG/h1N8EQK7jR8aLP3qhqb8KRX3lNyjszsW4
	jVsrWK+CObJBjAXHkFJiXpV4H6ktN8s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67C4713976;
	Wed, 16 Apr 2025 09:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FPtPGYJz/2dHbAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 16 Apr 2025 09:08:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Assertion and debugging helpers
Date: Wed, 16 Apr 2025 11:08:07 +0200
Message-ID: <cover.1744794336.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F8BD1F445
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

this is a RFC series. We need to improve debugging and logging helpers
so there's no ASSERT(0) or the convoluted
WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)). This was mentioned in past
discussions so here's my proposal.

The series is only build tested, I'd like to hear some feedback if this
is going the right direction or if there are suggestions for fine
tuning.

1) Add verbose ASSERT macro, so we can print additional information when
it triggers, namely printing the values of the assertion expression.
More details in the first patch, basic pattern is something like

    VASSERT(value > limit, "value=%llu limit=%llu", value, limit);

The second patch shows it's application in volumes.c, converting about
half where it's relevant. There are about 800 assertions in fs/btrfs/
and we don't need to convert them all. This can be done incrementally
and as needed.

The verbose version is another macro, although with some preprocessor
magic it should be possible to make ASSERT take variable number of
arguments. Does not seem worth though.

2) Wrap WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)) to DEBUG_WARN() with
optional message with printk format. This is used to replace the
WARN_ON(...) above and also the ASSERT(0).

The ultimate goal for me is to get rid of all ASSERT(0), it's not used
consistently and looks like it's a note to the code author. There may be
several reasons for it's use and although I've converted almost all to
DEBUG_WARN it may miss the intentions.

In some cases it may be better to add proper error handling, print a
message or warn and exit with error. Possibly the are cases where the
code cannot continue, meaning it should be a BUG_ON but this is also
something we want to convert to proper error handling.

David Sterba (5):
  btrfs: add verbose version of ASSERT
  btrfs: example use of VASSERT() in volumes.c
  btrfs: add debug build only WARN
  btrfs: convert WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG)) to DEBUG_WARN
  btrfs: convert ASSERT(0) to DEBUG_WARN()

 fs/btrfs/backref.c         |  4 +--
 fs/btrfs/delayed-ref.c     |  2 +-
 fs/btrfs/dev-replace.c     |  2 +-
 fs/btrfs/disk-io.c         |  2 +-
 fs/btrfs/extent-tree.c     |  2 +-
 fs/btrfs/extent_io.c       |  4 +--
 fs/btrfs/extent_map.c      |  2 +-
 fs/btrfs/free-space-tree.c | 27 +++++++++-------
 fs/btrfs/inode.c           |  6 ++--
 fs/btrfs/messages.h        | 30 ++++++++++++++++++
 fs/btrfs/qgroup.c          |  6 ++--
 fs/btrfs/relocation.c      |  4 +--
 fs/btrfs/send.c            |  4 +--
 fs/btrfs/space-info.c      |  2 +-
 fs/btrfs/tree-checker.c    |  8 ++---
 fs/btrfs/volumes.c         | 64 ++++++++++++++++++++++++--------------
 fs/btrfs/zoned.c           |  2 +-
 17 files changed, 109 insertions(+), 62 deletions(-)

-- 
2.49.0


