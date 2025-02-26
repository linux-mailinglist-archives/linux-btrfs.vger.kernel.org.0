Return-Path: <linux-btrfs+bounces-11830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3639A4544E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531E31898FA7
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32025C717;
	Wed, 26 Feb 2025 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jspieqa0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jspieqa0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD834438B
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740543046; cv=none; b=c2/jnsokv84onCLbxU2sgFG2GaAW3HZQiYVe8rScFSIC+ZxNrGgjRCEpmDH2CRdle9OWN2WrxeVzOGxB7iOmp2Kd+1CZusNoNx++kMO/0RpTGXw1R0PdhNvWl2z3inUimTUaOIcZQ4jiSopwCRGLRRVtybPbN0wJCz3Hey4wbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740543046; c=relaxed/simple;
	bh=qLdk0FXKmRSgGNqBgFvEV9vGE7XQ/SEqDVcdpSDzqL8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F8AuyEdIkv2oP1fAbYU5372PuFaYuhOYJjhQqzWT4VA7nYvtLDQxpqltPLYkv+oLpyxf6FQ1aZG9vE8Ot/zOt2pIHW7z33Jv/kbd75EnV5LXgRxQDNa94h96SW8699CaBX/dA3AAwKq0SKPSX1UxAEKaDedroNKU+QdS2XIYOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jspieqa0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jspieqa0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 880371F387
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740543041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E2o156dXCoh6O/Vr2Ted8rDuaszzDe2ESngmfO1OIaM=;
	b=jspieqa0uQ1zBz/z0V8wf9sp4LCdbW0f4p0bXEPsJfVgMS4xedroGsGP1mg+PMP1mCplnG
	SURSpeKaoBPA5qOZvoVA/LTYjexUJPijBnPX4H23FEp89wOmdKk1Tg6Z+gtIFFVw6jAIih
	D7nWBrGiUTvKkArtlQlrZ5e+5SluFe4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740543041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E2o156dXCoh6O/Vr2Ted8rDuaszzDe2ESngmfO1OIaM=;
	b=jspieqa0uQ1zBz/z0V8wf9sp4LCdbW0f4p0bXEPsJfVgMS4xedroGsGP1mg+PMP1mCplnG
	SURSpeKaoBPA5qOZvoVA/LTYjexUJPijBnPX4H23FEp89wOmdKk1Tg6Z+gtIFFVw6jAIih
	D7nWBrGiUTvKkArtlQlrZ5e+5SluFe4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABF031377F
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ek5rGkCUvmcgfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: support 2k block size for debug builds
Date: Wed, 26 Feb 2025 14:40:19 +1030
Message-ID: <cover.1740542375.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
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

[REPO]
This series depends on the existing subpage related patches to pass most
fstests, so please fetch it from the following repo:

 https://github.com/adam900710/linux/tree/2k_blocksize

Of course, one can still apply those involved patches on for-next
branch, but running such btrfs with 2K block size are going to hit most
if not all bugs fixed in the subpage branch.


From day 1 btrfs only supports block size as small as 4K, this means on
the most common architecture, x86_64, has no way to test subpage block
size support.

That's why most of my tests are done on aarch64 nowadays, but such
limited availability is not a good thing for test coverage.
The situation can be improved if we have larger data folios support, but
that is another huge feature, and we're not sure how far away we really
are.

So here we go with a much simpler solution, just lowering the minimal
block size to 2K for debug builds.

The support has quite some limitations, but should not be a big deal
because we're not pushing this support to end users:

- No 2K node size support
  This is the limit by mkfs, not by the kernel.
  But it's still a problem as this means we can not test the metadata
  subpage routine.

- No mixed block groups support
  As there is no 2K node size support from mkfs.btrfs.

- Very limited inline data extents support
  No inline extent size can go beyond 2K, this affects both regular
  files and symlinks/xattrs.

  Quite some inline related test will fail due to this.

This allows x86_64 to utilize the subpage block size routine, and in
fact it already exposed a bug that is not reproducible on aarch64.
(I believe it's related to the page reclaim behavior)

The first patch is to fix the deadlock that is only reproducible on
x86_64.
The second one is to fix btrfs-check errors that non-compressed block
sized inline extents are reported as an error.
The final one enables the 2K block size support for DEBUG builds.

For now there are around a dozen of failed test cases, mostly related to
inline and mkfs limitations, but this is good enough as the beginning of
subpage testing on x86_64.

Qu Wenruo (3):
  btrfs: subpage: do not hold subpage spin lock when clearing folio
    writeback
  btrfs: properly limit inline data extent according to block size
  btrfs: allow debug builds to accept 2K block size

 fs/btrfs/disk-io.c | 12 +++++++++---
 fs/btrfs/fs.h      | 12 ++++++++++++
 fs/btrfs/inode.c   | 14 +++++++++++++-
 fs/btrfs/subpage.c | 10 ++++++++--
 fs/btrfs/subpage.h |  2 +-
 fs/btrfs/sysfs.c   |  3 ++-
 6 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.48.1


