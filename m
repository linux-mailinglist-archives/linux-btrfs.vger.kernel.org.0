Return-Path: <linux-btrfs+bounces-18637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B97C2F53B
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 05:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F2594EE799
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF1829B8EF;
	Tue,  4 Nov 2025 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WttHRPDw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WttHRPDw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24523D290
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232260; cv=none; b=GCHJYRt5jtfF5Z65DVebkIf/rEVjcqtmnhOJ6QrJajbY8pXCerhflW3sOLt+poHO5Z1Ou7ttoQtwJLWSQXzSOoqqZIVZCtl3JL8Bh0tX9M35MNVPzZaQy3Ogzehl2Z/RtvR3GMMfsGTm0duMMFTOzwAb10n1MV9KTLcy5PiE4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232260; c=relaxed/simple;
	bh=69LaS1QlxuMXdaOOQ1JpKetzMbIOE2x5XfWZBqeeXtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnnBWfO2EVeKvoSTMGrYmYT0JHvU0W/kGf0OvqmnpTlAORE7fVZ/113DSW+k2M7vjW27pNQa7mXc7y3nqn/kMHwhXJfgu0t9IV9Y2EbFnAMyq5PR3Tg6dLRlWJUA8dTJAGCxPZft9hTeKhQLB9DSdZGWztFXUQLAzlBwqIFXIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WttHRPDw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WttHRPDw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B8151F385;
	Tue,  4 Nov 2025 04:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762232255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXrUQAijZQMZm8mRDIGstRfRq2ikHcx/hnTqL0Q8fMw=;
	b=WttHRPDw+F91PB5YkUcu/qDzt5MTPZLnMtGDPUWyuB8FRtIuPNTLdkzZitcpC0+kRb/BNg
	dLPkZ7Ftb5fwOkwnG5AFNwUI+8NVMFHjRre2P9xhxWmKrapEkmI38twUFERfXXN3+vj38G
	UJF8CVZbvkQd9sQnHQwIPHtlWgjjJtI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WttHRPDw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762232255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XXrUQAijZQMZm8mRDIGstRfRq2ikHcx/hnTqL0Q8fMw=;
	b=WttHRPDw+F91PB5YkUcu/qDzt5MTPZLnMtGDPUWyuB8FRtIuPNTLdkzZitcpC0+kRb/BNg
	dLPkZ7Ftb5fwOkwnG5AFNwUI+8NVMFHjRre2P9xhxWmKrapEkmI38twUFERfXXN3+vj38G
	UJF8CVZbvkQd9sQnHQwIPHtlWgjjJtI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74AD3139A9;
	Tue,  4 Nov 2025 04:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XQp2HL+HCWmkFQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 04 Nov 2025 04:57:35 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.18-rc5
Date: Tue,  4 Nov 2025 05:57:28 +0100
Message-ID: <cover.1762230638.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7B8151F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Hi,

please pull a few more short fixes. Thanks.

- fix memory leak in qgroup relation ioctl when qgroup levels are
  invalid

- don't write back dirty metadata on filesystem with errors

- properly log renamed links

- properly mark prealloc extent range beyond inode size as dirty
  (when no-noles is not enabled)

----------------------------------------------------------------
The following changes since commit ada7d45b568abe4f1fd9c53d66e05fbea300674b:

  btrfs: ref-verify: fix IS_ERR() vs NULL check in btrfs_build_ref_tree() (2025-10-22 09:40:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-rc4-tag

for you to fetch changes up to 3b1a4a59a2086badab391687a6a0b86e03048393:

  btrfs: mark dirty extent range for out of bound prealloc extents (2025-10-30 19:18:18 +0100)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name

Qu Wenruo (1):
      btrfs: ensure no dirty metadata is written back for an fs with errors

Shardul Bankar (1):
      btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation

austinchang (1):
      btrfs: mark dirty extent range for out of bound prealloc extents

 fs/btrfs/extent_io.c |  8 ++++++++
 fs/btrfs/file.c      | 10 ++++++++++
 fs/btrfs/inode.c     |  1 -
 fs/btrfs/qgroup.c    |  4 +++-
 fs/btrfs/tree-log.c  |  3 +++
 5 files changed, 24 insertions(+), 2 deletions(-)

