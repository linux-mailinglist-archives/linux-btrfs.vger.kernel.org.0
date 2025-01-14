Return-Path: <linux-btrfs+bounces-10963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF9A10354
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D577A41D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 09:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C312500C9;
	Tue, 14 Jan 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S2869GFo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S2869GFo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01C22DC28
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848380; cv=none; b=DGBO1sho5PaVX3Xwgbi14kFN0A1Vt2RJnIema/FenPmPqWrPj0PPnN6nxX5UVl5OKiS8OHr1dIESb94xBDrzSIsd/+OcjuUYtexoTUoFiU+pDJ+FMxADUXSsebtus4RbBvvKkbOPGBcaacCUpHNXn1b0R3SMxmq9th+/MANhsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848380; c=relaxed/simple;
	bh=4QYTxkNOtMhJuKRef/2PkNi5+yT3jlW8JBEywalRoY8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PbDd70lzmuud1gbqPOHnmcF3gWvLj6mMu0qSvMs+9/pxpHHJK+QUF67rfhci4W0kchDiU9v6Zx8L8qe4M21XTLdLb7Leoe6asj6B4aXl3pvSfRHzUlosQQuUMInjPUmEfPXsPaVNq8iOp5rttHG1vwm/G+hBo/ladOwmDERYQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S2869GFo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S2869GFo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31A131F38F
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4L0rZKiGaYsZpMkxSKYnvLze9tZ+Vgcnq4bpTQ57sts=;
	b=S2869GFocShpeiPlzytXqQAJOLbXXI854Tulrvc6Sl0RWxl/pgnUriK+3aoR/IBDZ85Ak9
	I9HxHN3aZKNl1UA6fVbFMKf+wd7bMO6xVpXfgaoyuk9IO8FiqtZ/3CTAakNXIRq/rCrHRu
	5s5bRq7mIWF5nLaHNyPcRDMvLMQoXW0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S2869GFo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4L0rZKiGaYsZpMkxSKYnvLze9tZ+Vgcnq4bpTQ57sts=;
	b=S2869GFocShpeiPlzytXqQAJOLbXXI854Tulrvc6Sl0RWxl/pgnUriK+3aoR/IBDZ85Ak9
	I9HxHN3aZKNl1UA6fVbFMKf+wd7bMO6xVpXfgaoyuk9IO8FiqtZ/3CTAakNXIRq/rCrHRu
	5s5bRq7mIWF5nLaHNyPcRDMvLMQoXW0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D647139CB
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6uMJDPczhmeMAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: enhancement to pass generic/563
Date: Tue, 14 Jan 2025 20:22:26 +1030
Message-ID: <cover.1736848277.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31A131F38F
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The test case generic/563 on aarch64 with 64K page size and 4K fs block
size will fail with btrfs, but not EXT4 nor XFS.

The detailed reason is explained in the last patch, the TL;DR is that
btrfs is not handling block aligned buffered write in an optimized way
for subpage cases (block size < page size).

The first patch is a refactor in preparation for the new enhancement.
The second patch is to solve the possible deadlock which can only be
exposed by the final enhancement.

Eventually the last patch will enable the enhancement and pass the
generic/563.

This series used to be mixed into this series:
https://lore.kernel.org/linux-btrfs/cover.1732492421.git.wqu@suse.com/

But unfortunately the ordered extent double accounting fix is not
solving all problems.
And since all the ordered extents double accounting is properly fixed in
for-next, we can come back to the subpage enhancement and focus on it.

Qu Wenruo (3):
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: avoid deadlock when reading a partial uptodate folio
  btrfs: allow buffered write to avoid full page read if it's block
    aligned

 fs/btrfs/defrag.c       |  2 +-
 fs/btrfs/direct-io.c    |  2 +-
 fs/btrfs/extent_io.c    | 44 +++++++++++----------------
 fs/btrfs/file.c         | 13 ++++----
 fs/btrfs/inode.c        |  6 ++--
 fs/btrfs/ordered-data.c | 67 ++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/ordered-data.h |  8 +++--
 7 files changed, 94 insertions(+), 48 deletions(-)

-- 
2.48.0


