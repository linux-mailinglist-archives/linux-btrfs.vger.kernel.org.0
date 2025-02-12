Return-Path: <linux-btrfs+bounces-11387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685CA31C5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 03:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2C73A5162
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 02:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0E1D63F5;
	Wed, 12 Feb 2025 02:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jt9v07gg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jt9v07gg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DC1CAA7F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328793; cv=none; b=UlzgOOQOrIVAB7dgf7gXuvTLQAKtO+j3pmUSfqJwAzpAl/aJslY7EKgeFg5AlWz84QnShKqlpu7y4RZ1T+CnVSPUjkohaQjTnZxrE2uxoZAZC1ot6uVaiAT7mLgWZkLxCGeDOABWq+wAReoj/DR1DigBAaQiaTx4HriEJhVNcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328793; c=relaxed/simple;
	bh=xzECHAptK1b1AIM3AecjzGVmFEQ8Trunozbsbyv2Q/c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h9ReKea0aSf2246ep066rfY6+zc/mMzXaQCW8v/qTdVXUP5dTIR0HzaEK8y2sCZ6CnbW/J63aBIZkYDEEvOvnVHzBSUn2Gtne80zG/lWceQyCM04tE0km5qrxI4IJEJAP+SkSzp9kJ7KWc3cRkSLeAGWoR3rNVr3UdejAdrCZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jt9v07gg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jt9v07gg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCDED33834
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739328789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=atbd7HGLxHorU+Xu60l4vrMJpYFls7qzWzaS9ipG12s=;
	b=jt9v07ggjMS/qpFNNgb0Xqu33Q0bUXyLeaDOCjFDJxDVdsig0kgTklj2hefa7tD2xG/UJZ
	sqlfk34FLFhBSaGvCNTbV5n4DU2aZ2B00nqpQys6kmZL00kGiPmzk39tDLLnRXd5yqyFA0
	nEncuasPpBXU3I4QTpg4AnjPGL7onIA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739328789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=atbd7HGLxHorU+Xu60l4vrMJpYFls7qzWzaS9ipG12s=;
	b=jt9v07ggjMS/qpFNNgb0Xqu33Q0bUXyLeaDOCjFDJxDVdsig0kgTklj2hefa7tD2xG/UJZ
	sqlfk34FLFhBSaGvCNTbV5n4DU2aZ2B00nqpQys6kmZL00kGiPmzk39tDLLnRXd5yqyFA0
	nEncuasPpBXU3I4QTpg4AnjPGL7onIA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1040313874
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1xdMBQNrGc/UAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:53:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: enhancement to pass generic/563
Date: Wed, 12 Feb 2025 13:22:44 +1030
Message-ID: <cover.1739328504.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Rebased to the latest for-next branch
  There is a data corruption read fix, which changed the timing of
  btrfs_lock_and_flush_ordered_range().

- Introduce a dedicated and smarted, read path speific extent range lock
  helper, lock_extents_for_read()
  Which has all the extra subpage specific deadlock avoiding mechanism,
  along with a much better comments on which type of ordered extents
  needs to be waited, and which can be completely skipped.

The test case generic/563 on aarch64 with 64K page size and 4K fs block
size will fail with btrfs, but not EXT4 nor XFS.

The detailed reason is explained in the last patch, the TL;DR is that
btrfs is not handling block aligned buffered write in an optimized way
for subpage cases (block size < page size).

The first patch is to address the deadlock-prone
btrfs_lock_and_flush_ordered_range() in read paths, by introduce a
deadlock-avoiding helper for read paths.

The second patch is a refactor in preparation for the new enhancement.

Eventually the last patch will enable the enhancement and pass the
generic/563.

Qu Wenruo (3):
  btrfs: introduce a read path dedicated extent lock helper
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: allow buffered write to avoid full page read if it's block
    aligned

 fs/btrfs/defrag.c       |   2 +-
 fs/btrfs/direct-io.c    |   2 +-
 fs/btrfs/extent_io.c    | 224 +++++++++++++++++++++++++++++++++++-----
 fs/btrfs/file.c         |   9 +-
 fs/btrfs/inode.c        |   4 +-
 fs/btrfs/ordered-data.c |  29 ++++--
 fs/btrfs/ordered-data.h |   3 +-
 7 files changed, 229 insertions(+), 44 deletions(-)

-- 
2.48.1


