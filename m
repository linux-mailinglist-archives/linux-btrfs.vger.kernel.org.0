Return-Path: <linux-btrfs+bounces-8562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A2F990640
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E136280EB8
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33590217900;
	Fri,  4 Oct 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F7bPzap/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F7bPzap/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC4212EEA;
	Fri,  4 Oct 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052643; cv=none; b=C1/olsBje5EtwuN5cD6kUtX4SNPQk2GdngFw5ZSNBXG32WEN1prkXGdEDHk3MuzEalWJ02bHTBz3NK1YLdu5qOuTmpKIaQby1diuN+tW3A6rSPmN1MabBU3J66SR9jmsFRJFtOd+ucwTDUgwLE2BvfJA2K4LbQd4w5iqR+Q8dWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052643; c=relaxed/simple;
	bh=MAK8JWmVjNO8FXi5tEdbRgJHHAYoZFtJbZOaHkJe1xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFmHCnzeUnwNAsbTwREKOV5ZwAoLBVdddZu0W1BaA4Kr2JdJopZCGF6JlVpU3kcyiFgYNxNfQum3KZpzzzh979FifOQFsXh0ZhP6h5R814IbTtDYYIj3bxmn9SiFOrRsTtNuEMmnLvfuGUITwpPCogsSm69WHjBZKCKWawzdWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F7bPzap/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F7bPzap/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78F631F78E;
	Fri,  4 Oct 2024 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728052638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IoNx+MylgNQZdr8mAZLP2m82RL0nRPwe/aXde4USFqI=;
	b=F7bPzap/Id7sGjj8LHb22rgPLxHE7JjE7W6/VetKVujQ5nQUwDLJE6zmje1YIc/7lygLq5
	73QTo5FoKwIDqslRS1qp9H92k+c3oByo5WquBWory2Ywd8c1YNEWorzUrykao4TwYeOh4r
	nU6bCH+UfwTi6Xn4xFIgn8R3QwlepS4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="F7bPzap/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728052638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IoNx+MylgNQZdr8mAZLP2m82RL0nRPwe/aXde4USFqI=;
	b=F7bPzap/Id7sGjj8LHb22rgPLxHE7JjE7W6/VetKVujQ5nQUwDLJE6zmje1YIc/7lygLq5
	73QTo5FoKwIDqslRS1qp9H92k+c3oByo5WquBWory2Ywd8c1YNEWorzUrykao4TwYeOh4r
	nU6bCH+UfwTi6Xn4xFIgn8R3QwlepS4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70C9813A55;
	Fri,  4 Oct 2024 14:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8QCFG579/2YoawAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 04 Oct 2024 14:37:18 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.12-rc2
Date: Fri,  4 Oct 2024 16:37:13 +0200
Message-ID: <cover.1728050979.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78F631F78E
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull the following fixes, thanks.

- in incremental send, fix invalid clone operation for file that got its
  size decreased

- fix __counted_by() annotation of send path cache entries, we don not
  store the terminating NUL

- fix a longstanding bug in relocation (and quite hard to hit by
  chance), drop back reference cache that can get out of sync after
  transaction commit

- wait for fixup worker kthread before finishing umount

- add missing raid-stripe-tree extent for NOCOW files, zoned mode
  cannot have NOCOW files but RST is meant to be a standalone feature

- handle transaction start error during relocation, avoid potential NULL
  pointer dereference of relocation control structure (reported by syzbot)

- disable module-wide rate limiting of debug level messages

- minor fix to tracepoint definition (reported by checkpatch.pl)

----------------------------------------------------------------
The following changes since commit 7f1b63f981b8284c6d8238cb49b5cb156d9a833e:

  btrfs: fix use-after-free on rbtree that tracks inodes for auto defrag (2024-09-17 17:35:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc1-tag

for you to fetch changes up to d6e7ac65d4c106149d08a0ffba39fc516ae3d21b:

  btrfs: disable rate limiting when debug enabled (2024-10-01 19:29:41 +0200)

----------------------------------------------------------------
Filipe Manana (4):
      btrfs: send: fix buffer overflow detection when copying path to cache entry
      btrfs: tracepoints: end assignment with semicolon at btrfs_qgroup_extent event class
      btrfs: send: fix invalid clone operation for file that got its size decreased
      btrfs: wait for fixup workers before stopping cleaner kthread during umount

Johannes Thumshirn (1):
      btrfs: also add stripe entries for NOCOW writes

Josef Bacik (1):
      btrfs: drop the backref cache during relocation if we commit

Leo Martins (1):
      btrfs: disable rate limiting when debug enabled

Qu Wenruo (1):
      btrfs: fix a NULL pointer dereference when failed to start a new trasacntion

 fs/btrfs/backref.c           | 12 ++++---
 fs/btrfs/disk-io.c           | 11 +++++++
 fs/btrfs/inode.c             |  5 +++
 fs/btrfs/messages.c          |  3 +-
 fs/btrfs/relocation.c        | 77 +++-----------------------------------------
 fs/btrfs/send.c              | 31 +++++++++++++++---
 include/trace/events/btrfs.h |  2 +-
 7 files changed, 58 insertions(+), 83 deletions(-)

