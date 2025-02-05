Return-Path: <linux-btrfs+bounces-11294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A9A28EA9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F71166B21
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4B79F5;
	Wed,  5 Feb 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B9bemfIg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u91dwL6E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25419522A;
	Wed,  5 Feb 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764944; cv=none; b=aoftRN/Me+DCgrmCi4+gfXZxKW+F089rQWuOAjxH1W16EP4X/bPE72BzfQfZyGu5al4RDmwX3z6EixQ7T1HXtIzPtyYEjLtRrZLfNSdX7a8llDrUnVlQG/1BXQubLdnZqAgwuWvPcBXsh44D+FEWW2nD8//uujhbhGVI7AcAiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764944; c=relaxed/simple;
	bh=cBFpTDklvHxoqphgQUoCnaTOLr6z/c/+f5R10v0mxvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYfnF4rcKG1lHNgmqtbSxRbtwj2n5h4IUS9p36Fe6gXxLxJKbffew5M2+g5U/t5K54ewp5pIuECIiT0/IWdjaoJA3BWq4wrmrteV35sFybM8tc9sGS0ZG39UYUwkBcVKxbWwoe1Svk1jp+AlB09tK9eht1lmGFQVWmkwOX7hcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B9bemfIg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u91dwL6E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF5EB2120A;
	Wed,  5 Feb 2025 14:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738764940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PVzUEmRLVscBr9CVyOYnFZKnVwiZFLCi5TbzwYW0KPU=;
	b=B9bemfIglRUUan+FuIQRWdaOOvJfq/nSk9BtwV2mCL4yDE+yYIBRJ/KKctDiTUSJx/Jtf2
	Q/wm/2uIgIPHCUesN+96H7PXKy1qcMkKsr1rWmzHeOD/ScCj70jUkER/JglWNhXJUVqcOw
	mVvFvRE5NGCPf0NxJ2OsCm/zv6/Doz0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u91dwL6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738764939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PVzUEmRLVscBr9CVyOYnFZKnVwiZFLCi5TbzwYW0KPU=;
	b=u91dwL6EvXhpMUgGZh37oNzmAU0mU9qN4G1QDL43dkdYWK78HZl8lmU+fDIVz1x3K3chWX
	AZ79wuAXE8ojJ6E+SCAh711/yxiDxDhSioiplrzptxg2CMlG+jq1I8MaIVAw/z7ERazFKD
	3d7p48WvaICjNou5/xCjHzU1uivm7So=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E66DB13694;
	Wed,  5 Feb 2025 14:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UC/9N4tyo2cPCwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 05 Feb 2025 14:15:39 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.14-rc2
Date: Wed,  5 Feb 2025 15:15:34 +0100
Message-ID: <cover.1738764049.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF5EB2120A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull a few fixes for problems reported recently. Thanks.

- add lockdep annotation for relocation root to fix a splat warning
  while merging roots

- fix assertion failure when splitting ordered extent after transaction
  abort

- don't print 'qgroup inconsistent' message when rescan process updates
  qgroup data sooner than the subvolume deletion process

- fix use-after-free (accessing the error number) when attempting to join
  an aborted transaction

- avoid starting new transaction if not necessary when cleaning qgroup
  during subvolume drop

----------------------------------------------------------------
The following changes since commit 9d0c23db26cb58c9fc6ee8817e8f9ebeb25776e5:

  btrfs: selftests: add a selftest for deleting two out of three extents (2025-01-14 15:57:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.14-rc1-tag

for you to fetch changes up to fdef89ce6fada462aef9cb90a140c93c8c209f0f:

  btrfs: avoid starting new transaction when cleaning qgroup during subvolume drop (2025-01-23 22:34:17 +0100)

----------------------------------------------------------------
Filipe Manana (4):
      btrfs: fix lockdep splat while merging a relocation root
      btrfs: fix use-after-free when attempting to join an aborted transaction
      btrfs: avoid starting new transaction when cleaning qgroup during subvolume drop

Qu Wenruo (1):
      btrfs: do not output error message if a qgroup has been already cleaned up

 fs/btrfs/ctree.c        |  2 ++
 fs/btrfs/ordered-data.c | 12 ++++++++++++
 fs/btrfs/qgroup.c       | 11 +++++------
 fs/btrfs/transaction.c  |  4 +++-
 4 files changed, 22 insertions(+), 7 deletions(-)

