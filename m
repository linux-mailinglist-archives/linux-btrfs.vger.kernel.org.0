Return-Path: <linux-btrfs+bounces-13117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E9A91778
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8F75A3F9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13422422F;
	Thu, 17 Apr 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="duU/+cSg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="duU/+cSg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDC33FD
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881438; cv=none; b=L6Wa8ihHSPJ6yylu+E8isBUcbBZA5X5KpHF6uKMaUWeV0AwOjHSa+YVakqhKQjTbtu0SsGmjNoEMe6PjoIDhR3nu8UA+Zx8VE2l16KGgfk2G7NbBPEvmpSnSHz07spYGtw4W2w8axLp1XIPKGkxKP8B0Byk/Pz22KNuNmaGNSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881438; c=relaxed/simple;
	bh=qnSCm8NuSzk3UTepKGUlFKRVBMdsIlYfc73VKVAVfNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2DWF9aEJBHR7hwx5aQchE5Gr6eQfU9440KY8z2LbUZ9w1lA8mvounvgiYYORopzVXIgyBx6s5IqZlq5QCzRGqlI3lqoAvAtqYAuF0IEwTmruG1pWw5UkKrl/0oXXMiOdiOFKEv4tby/BBjGEdjDrAbEP+eGo18zh5BSBlTrEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=duU/+cSg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=duU/+cSg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D0941F391;
	Thu, 17 Apr 2025 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744881434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Fh0wWRFE5qGSvfp3PNb0PeS6gc3jGQ1jRXmrBbAKUPk=;
	b=duU/+cSgVjiZGCVBUe7vKv3cjgMkuAg23WeR2jOPyzXvvSijy7M4iejPh8DJOfF5dZ/u+A
	PSxS6ZTCQopmUbkwoAcJpDR1voVCqzNARBJXV6UG/zoaLmZnXPz/hUK+jSwxg/he0K1bUY
	WY2ylpQXDlAAbBHN0sEF1ePxnUPXD1M=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744881434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Fh0wWRFE5qGSvfp3PNb0PeS6gc3jGQ1jRXmrBbAKUPk=;
	b=duU/+cSgVjiZGCVBUe7vKv3cjgMkuAg23WeR2jOPyzXvvSijy7M4iejPh8DJOfF5dZ/u+A
	PSxS6ZTCQopmUbkwoAcJpDR1voVCqzNARBJXV6UG/zoaLmZnXPz/hUK+jSwxg/he0K1bUY
	WY2ylpQXDlAAbBHN0sEF1ePxnUPXD1M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7290B137CF;
	Thu, 17 Apr 2025 09:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sT6rGxrHAGiscQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 17 Apr 2025 09:17:14 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/5] Assertion and debugging helpers
Date: Thu, 17 Apr 2025 11:16:58 +0200
Message-ID: <cover.1744881159.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

v2:
- add the functionality of VASSERT to ASSERT proper

Hi,

this is a RFC series. We need to improve debugging and logging helpers
so there's no ASSERT(0) or the convoluted
WARN_ON(IS_DEFINED(CONFIG_BTRFS_DEBUG)). This was mentioned in past
discussions so here's my proposal.

The series is only build tested, I'd like to hear some feedback if this
is going the right direction or if there are suggestions for fine
tuning.

1) Update ASSERT macro, so we can print additional information when
it triggers, namely printing the values of the assertion expression.
More details in the first patch, basic pattern is something like

    ASSERT(value > limit, "value=%llu limit=%llu", value, limit);

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
  btrfs: enhance ASSERT() to take optional format string
  btrfs: example use of enhanced ASSERT() in volumes.c
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
 fs/btrfs/free-space-tree.c | 27 +++++++++--------
 fs/btrfs/inode.c           |  6 ++--
 fs/btrfs/messages.h        | 59 +++++++++++++++++++++++++++++++-----
 fs/btrfs/qgroup.c          |  6 ++--
 fs/btrfs/relocation.c      |  4 +--
 fs/btrfs/send.c            |  4 +--
 fs/btrfs/space-info.c      |  2 +-
 fs/btrfs/tree-checker.c    |  8 ++---
 fs/btrfs/volumes.c         | 62 ++++++++++++++++++++++++--------------
 fs/btrfs/zoned.c           |  2 +-
 17 files changed, 129 insertions(+), 69 deletions(-)

-- 
2.49.0


