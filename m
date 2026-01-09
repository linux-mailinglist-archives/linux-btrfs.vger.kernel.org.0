Return-Path: <linux-btrfs+bounces-20337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A310D0B562
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BED393024EA6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046B35CBAF;
	Fri,  9 Jan 2026 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W7YCN21G";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W7YCN21G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724E7316904
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976810; cv=none; b=FHrWumrKCQxmAeIBuyp7e+1jlv9yYFqItXmw3vYaIYHbZCs7ywo+UJnMR5VKz44XVCkzaceAUSfl0xH95cQZAj+T8JDgJfEy7BnrlIZ143T8484+3Dh3vC159R5SVscswNIoK0pPpmvO9KhzIQgRX6/wWXdwW/MhShy9b/GCpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976810; c=relaxed/simple;
	bh=/6u9fKxKNUz7IilD3yq60WXTFLQiVuTpnI1zj5PVpo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qmMDr9vhTNTm6ZW6JeJgyd1bTpN8xNGNUVdwDU0SZ+La3ArZIncsWcKDzqmYuS8IjsZl6l2RNhNj9TOjc54kZHNu5LVvE14B5d4sovME9pJHyuQ/yUZRC3tl8ZccXSKZWVBUaisfJ8AUV5es2N0RI/JMlSwb/yM9jBCLfcIexbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W7YCN21G; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W7YCN21G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BF8E5BE1F;
	Fri,  9 Jan 2026 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767976807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wZk1gxas27QC0yJhNZIpG/4nPZbbZAHiVqz62BdXbFM=;
	b=W7YCN21GiMy42IbzKFwL2s1fY9XPrqL3TxDqcm8Q37UexdcHhPPuae83Js025U1OqV6H9y
	mEL8cqdztBH8K0UGwBfRRZtUH4/xy2dDejHINQak+qg1XHSEP7OXuzBi1xJA8fJW9Psvb8
	YBckQEGVrIE2ZuEd/qcGLxjQPHFcma8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=W7YCN21G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767976807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wZk1gxas27QC0yJhNZIpG/4nPZbbZAHiVqz62BdXbFM=;
	b=W7YCN21GiMy42IbzKFwL2s1fY9XPrqL3TxDqcm8Q37UexdcHhPPuae83Js025U1OqV6H9y
	mEL8cqdztBH8K0UGwBfRRZtUH4/xy2dDejHINQak+qg1XHSEP7OXuzBi1xJA8fJW9Psvb8
	YBckQEGVrIE2ZuEd/qcGLxjQPHFcma8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85D393EA63;
	Fri,  9 Jan 2026 16:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRimIGcvYWnFLwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 09 Jan 2026 16:40:07 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.19-rc5, part 2
Date: Fri,  9 Jan 2026 17:40:05 +0100
Message-ID: <cover.1767974557.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.51
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8BF8E5BE1F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi,

second batch of patches after the EOY break. Please pull, thanks.

- fix potential NULL pointer dereference when replaying tree log after
  an error

- release path before initializing extent tree to avoid potential
  deadlock when allocating new inode

- on filesystems with block size > page size
  - fix potential read out of bounds during encoded read of an inline
    extent
  - only enforce free space tree if v1 cache is required

- print correct tree id in error message

----------------------------------------------------------------
The following changes since commit c1c050f92d8f6aac4e17f7f2230160794fceef0c:

  btrfs: fix reservation leak in some error paths when inserting inline extent (2025-12-16 22:53:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc4-tag

for you to fetch changes up to 2bb83bc42be6280d9bc363b8fbcd6fdab690d16d:

  btrfs: show correct warning if can't read data reloc tree (2026-01-06 01:23:00 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: release path before initializing extent tree in btrfs_read_locked_inode()

Mark Harmstone (1):
      btrfs: show correct warning if can't read data reloc tree

Qu Wenruo (3):
      btrfs: avoid access-beyond-folio for bs > ps encoded writes
      btrfs: only enforce free space tree if v1 cache is required for bs < ps cases
      btrfs: force free space tree for bs > ps cases

Suchit Karunakaran (1):
      btrfs: fix NULL pointer dereference in do_abort_log_replay()

 fs/btrfs/disk-io.c  |  1 +
 fs/btrfs/inode.c    | 41 ++++++++++++++++++++++++++++++++---------
 fs/btrfs/super.c    | 12 +++++-------
 fs/btrfs/tree-log.c |  2 +-
 4 files changed, 39 insertions(+), 17 deletions(-)

