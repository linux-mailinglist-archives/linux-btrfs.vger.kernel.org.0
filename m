Return-Path: <linux-btrfs+bounces-20113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D058CF5BE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 22:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC0B305EE7C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 21:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEC3311C1D;
	Mon,  5 Jan 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lbwlhE6B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ds+aFo3a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC62311596
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650289; cv=none; b=TGuaAc/53HiNb+4C2agDBdbSkdHw+2ivux55uA665lxAqPUYu7No0KlVzGQLajajXfq/4hu5TtXDNNUXRXcINWWFed4U7DrRJvRkMLZP9WC1H01u3ODIHfjDylMOn8VMO5jicNVNQAov0c077cYszwt++jN8BnvqeWvL/iGp46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650289; c=relaxed/simple;
	bh=PDG7W9mBQx8AEMulnp6TGcTYvB40rTYE9dCrcXE/xog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qOVBJ0oOIWUbnlqL+NeHn6pPKfhSBlklyFn04ACBev4MZxhAT1QSuDCMRZPahc7T3Q/74Vw5zxOrgVUZ2LkI/KReWCUIzhkL1Ls1XNFNg1kj/7Cji8EObhJxR0xsDpm12DuI/8zjc5Ld9fw/THQJaQsd/Ci6mozmPLPRNpbAz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lbwlhE6B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ds+aFo3a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B4D95BCC2;
	Mon,  5 Jan 2026 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767650285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sWnlXNsQvo0JJSqhlQByD7gB4j3eubooA5vBPdv7uHA=;
	b=lbwlhE6BQrKF2k5PnrOcoc4eWMrsSMZ7+4UeYpv5x7mruVgT5fRmolTrs+LBeftgRJE8/l
	w9uULEmsJFzzNh3mOtaMB+CMITBnOGgegyCoC2hQDu/7AyyO7g55ho3SzPAGnuyCHXc/eh
	z1aY7DSj8L9+Jkf7v+g+A8xvND5Y5QQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ds+aFo3a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767650284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sWnlXNsQvo0JJSqhlQByD7gB4j3eubooA5vBPdv7uHA=;
	b=Ds+aFo3ay55evdPxJr3MBorWWsxM3qkqYdv5Fov9U+lofc5jWA7y0yvhHrpP7W0SbtuevF
	NIJMc0nbC80ehMFJZcHcyyt89ptOBxnDuMqPoOfZFKYUjUWYVfFG6+a+BTVmSbDTUsT0yx
	VtKSt+XhK3LR0RHExehc+XfO4zmdbCQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 024F613964;
	Mon,  5 Jan 2026 21:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2xBKAOwzXGlAVQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 05 Jan 2026 21:58:03 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.19-rc5
Date: Mon,  5 Jan 2026 22:58:02 +0100
Message-ID: <cover.1767635222.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 0B4D95BCC2
X-Spam-Flag: NO
X-Spam-Score: -3.51

Hi,

please pull the following fixes. Thanks.

- fix potential deadlock due to mismatching transaction states when
  waiting for the current transaction

- fix squota accounting with nested snapshots

- fix quota inheritance of qgroups with multiple parent qgroups

- fix NULL inode pointer in evict tracepoint

- fix writes beyond end of file on systems with 64K page size and 4K
  block size

- fix logging of inodes after exchange rename

- fix use after free when using ref_tracker feature

- space reservation fixes

----------------------------------------------------------------
The following changes since commit 37343524f000d2a64359867d7024a73233d3b438:

  btrfs: fix changeset leak on mmap write after failure to reserve metadata (2025-12-12 16:33:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc4-tag

for you to fetch changes up to c1c050f92d8f6aac4e17f7f2230160794fceef0c:

  btrfs: fix reservation leak in some error paths when inserting inline extent (2025-12-16 22:53:15 +0100)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: fix qgroup_snapshot_quick_inherit() squota bug

Filipe Manana (3):
      btrfs: always detect conflicting inodes when logging inode refs
      btrfs: do not free data reservation in fallback from inline due to -ENOSPC
      btrfs: fix reservation leak in some error paths when inserting inline extent

Leo Martins (1):
      btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node()

Miquel Sabaté Solà (1):
      btrfs: fix NULL dereference on root when tracing inode eviction

Qu Wenruo (2):
      btrfs: qgroup: update all parent qgroups when doing quick inherit
      btrfs: fix beyond-EOF write handling

Robbie Ko (1):
      btrfs: fix deadlock in wait_current_trans() due to ignored transaction type

 fs/btrfs/delayed-inode.c     | 32 +++++++++++++++++---------------
 fs/btrfs/extent_io.c         |  8 ++++----
 fs/btrfs/inode.c             | 22 +++++++++++++++-------
 fs/btrfs/qgroup.c            | 21 +++++++++++++++++++--
 fs/btrfs/transaction.c       | 11 ++++++-----
 fs/btrfs/tree-log.c          |  6 ++----
 include/trace/events/btrfs.h |  3 ++-
 7 files changed, 65 insertions(+), 38 deletions(-)

