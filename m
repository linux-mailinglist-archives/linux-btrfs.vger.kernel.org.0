Return-Path: <linux-btrfs+bounces-11606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF4A3D4A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36013BD028
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794321F03F2;
	Thu, 20 Feb 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LSGxZYYO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZIgmswOj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6781F03F3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043370; cv=none; b=FlAVss6HV7tvmr9dTN5hf2NWB9ELF8+apy8AkFdt3oYjX0N2K3ndWjImzajsubgjmdcjLEJ37yStX0q9++1C6PJMh3mYB077FTltR0tc3OyM/9hGoCVwCAEJd0Xc4JORKqj6/Hr2NgTLVs9qhT3TUuEv9Yz1po7iU66HGL7Aw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043370; c=relaxed/simple;
	bh=3lt/evaVM6NTkDEIJ/dNfOtubx+tJpzYAxg6r0E3+9o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n97X/I+0aJ0BTbDleVvLgxdh+3wS7/eg/L9g1eNBkyQKF4JBZkvPiVs0gqVr0+1znb34xMpIBg+hKZVWYLXilq7GsoN6Be+cTF3bkJ8aZIOd309kyVv6vhQ0nuXLngQrzF3weXm5sEwM5O71fgvzgKLk2lKjkk10Jn3Vu6+k1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LSGxZYYO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZIgmswOj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F410D210EF
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kaaLka8lcdhLDfvMMYuSOReg9JlpuSYGUmP+FbhHp+w=;
	b=LSGxZYYOBEEmEUZ9wDkE52BAkjw8g5ozq5UfMHvcBh1yyvedOgm2xxeQOOjuBovA4JPrrA
	Pd3u9puYpe+uJ++8aLbOUsHidqATxmU7Fq2xH2YhK5k4+qFddJFI5GWfd5kEo4EIrbh5Ol
	eZmdsU52UmJBiRTPSa0F8YMZzZxyUCc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kaaLka8lcdhLDfvMMYuSOReg9JlpuSYGUmP+FbhHp+w=;
	b=ZIgmswOj1eMLvopaL0XZWrACw7uhmOszIjQ5f4LDfSiyaqNii5kBM7h/jVg/LxJQ/mU/zt
	GPRAcQ+W7kUit5Szfmz+LzshXAf+/eZGxDHKBoBxXRxlYOLqKPNaomrrXpqqXXYptn7S4S
	uLrw8oZK1z65tcwVhfgCcUeWENkZpdk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6E4913A69
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id quzfI2T0tmfBcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: prepare for larger folios support
Date: Thu, 20 Feb 2025 19:52:21 +1030
Message-ID: <cover.1740043233.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
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
X-Spam-Flag: NO
X-Spam-Level: 

This means:

- Our subpage routine should check against the folio size other than
  PAGE_SIZE

- Make functions handling filemap folios to use folio_size() other than
  PAGE_SIZE

  The most common paths are:
  * Buffered reads/writes
  * Uncompressed folio writeback
    Already handled pretty well

  * Compressed read
  * Compressed write
    To take full advantage of larger folios, we should use folio_iter
    other than bvec_iter.
    This will be a dedicated patchset, and the existing bvec_iter can
    still handle larger folios.

  Internal usages can still use page sized folios, or even pages,
  including:
  * Encoded reads/writes
  * Compressed folios
  * RAID56 internal pages
  * Scrub internal pages

This patchset will handle the above mentioned points by:

- Prepare the subpage routine to handle larger folios
  This will introduce a small overhead, as all checks are against folio
  sizes, even on x86_64 we can no longer skip subpage completely.

  This is done in the first patch.

- Convert straightforward PAGE_SIZE users to use folio_size()
  This is done in the remaining patches.

Currently this patchset is not a exhaustive conversion, I'm pretty sure
there are other complex situations which can cause problems.
Those problems can only be exposed and fixed after switching on the
experimental larger folios support later.

Qu Wenruo (5):
  btrfs: prepare subpage.c for larger folios support
  btrfs: remove the PAGE_SIZE usage inside inline extent reads
  btrfs: prepare btrfs_launcher_folio() for larger folios support
  btrfs: prepare extent_io.c for future larger folio support
  btrfs: prepare btrfs_page_mkwrite() for larger folios

 fs/btrfs/extent_io.c | 50 +++++++++++++++++++++++++-------------------
 fs/btrfs/file.c      | 19 +++++++++--------
 fs/btrfs/inode.c     |  8 +++----
 fs/btrfs/subpage.c   | 36 +++++++++++++++----------------
 fs/btrfs/subpage.h   | 24 ++++++++-------------
 5 files changed, 69 insertions(+), 68 deletions(-)

-- 
2.48.1


