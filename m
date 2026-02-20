Return-Path: <linux-btrfs+bounces-21813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MfDK0jhmGmHNwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21813-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 23:33:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676916B409
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 23:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD62B30BDD5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDE3115AE;
	Fri, 20 Feb 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OAZIkqoV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OAZIkqoV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521F30FC22
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626568; cv=none; b=PJt1ZurIWEnRS9YNEb3ytCvEcyUtikvJ3UTaiDpqFTaFsHQ0fT0MHRBOxRG++kpJTVhex+SVSPyOTHkB+BHSK8cGQIg+PJPu2heUHISJqgAZUJKpT71bi9iRGO6x4VDfQ2ic6Pk6rl+CndO9lKvCedd+cikU17kEoTUxsf5/yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626568; c=relaxed/simple;
	bh=nKMsexCF85Y1eZTQrpa5QezA3t2bRV0dSzUeaLliYvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPrXmo2pk0ehW9qjRejlwXzPPx/6FCqjopWlPh1jMIJniEN7swT+E48YdBWVq3J6GHbtkioyVsKOpp92MV9tWiIMIrdqySq0aipsUn/tN87+2dg6nUGzbgQTCHOnUxYTjxjAnSl12JVT3QNK2qt02BcIRjnuzjBbImsZp4kFG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OAZIkqoV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OAZIkqoV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 716F95BCEE;
	Fri, 20 Feb 2026 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771626564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=esINlBSxM7CG/fvquYVkUc3dvUJoACyMHKBUFpSCXiA=;
	b=OAZIkqoViLWyQjzru4APnA3lQ7LJxqmw9F94x68RZNn26buuccPvQ4sifOb7lm1K2VymQP
	03TiMxi0qxNM6UGdH0NNNblLaFDmQEB3nbxnZNdd3w01NEOIWPtvMI2ezz9VZc6gry3/vG
	yVGdVkfaBiWypWRrHfqELPFmust23+w=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OAZIkqoV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771626564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=esINlBSxM7CG/fvquYVkUc3dvUJoACyMHKBUFpSCXiA=;
	b=OAZIkqoViLWyQjzru4APnA3lQ7LJxqmw9F94x68RZNn26buuccPvQ4sifOb7lm1K2VymQP
	03TiMxi0qxNM6UGdH0NNNblLaFDmQEB3nbxnZNdd3w01NEOIWPtvMI2ezz9VZc6gry3/vG
	yVGdVkfaBiWypWRrHfqELPFmust23+w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8BE3EA65;
	Fri, 20 Feb 2026 22:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HXtMF0TgmGntDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 20 Feb 2026 22:29:24 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 7.0-rc1
Date: Fri, 20 Feb 2026 23:29:20 +0100
Message-ID: <cover.1771614421.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21813-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3676916B409
X-Rspamd-Action: no action

Hi,

first batch of fixes that arrived after the code freeze. Please pull,
thanks.

- multiple error handling fixes of unexpected conditions

- reset block group size class once it becomes empty so its class can be
  changed

- error message level adjustments

- fixes of returned error values

- use correct block reserve for delayed refs

----------------------------------------------------------------
The following changes since commit 161ab30da6899f31f8128cec7c833e99fa4d06d2:

  btrfs: get rid of compressed_bio::compressed_folios[] (2026-02-03 07:59:07 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-7.0-rc1-tag

for you to fetch changes up to ecb7c2484cfc83a93658907580035a8adf1e0a92:

  btrfs: fix invalid leaf access in btrfs_quota_enable() if ref key not found (2026-02-18 15:25:54 +0100)

----------------------------------------------------------------
Adarsh Das (2):
      btrfs: handle unexpected exact match in btrfs_set_inode_index_count()
      btrfs: replace BUG() with error handling in __btrfs_balance()

Filipe Manana (5):
      btrfs: use the correct type to initialize block reserve for delayed refs
      btrfs: change unaligned root messages to error level in btrfs_validate_super()
      btrfs: fix lost return value on error in finish_verity()
      btrfs: fix lost error return in btrfs_find_orphan_roots()
      btrfs: fix invalid leaf access in btrfs_quota_enable() if ref key not found

Jiasheng Jiang (1):
      btrfs: reset block group size class when it becomes empty

Qu Wenruo (1):
      btrfs: do not ASSERT() when the fs flips RO inside btrfs_repair_io_failure()

 fs/btrfs/bio.c         |  8 +++++++-
 fs/btrfs/block-group.c | 10 ++++++++++
 fs/btrfs/block-rsv.c   |  7 ++++---
 fs/btrfs/disk-io.c     | 10 +++++-----
 fs/btrfs/inode.c       | 15 ++++++++++++---
 fs/btrfs/qgroup.c      | 11 +++++++----
 fs/btrfs/root-tree.c   |  2 +-
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/verity.c      |  2 +-
 fs/btrfs/volumes.c     | 10 ++++++++--
 10 files changed, 56 insertions(+), 21 deletions(-)

