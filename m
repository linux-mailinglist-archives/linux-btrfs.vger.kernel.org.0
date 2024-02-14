Return-Path: <linux-btrfs+bounces-2365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A68541E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 05:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B521C23419
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 04:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D1BA34;
	Wed, 14 Feb 2024 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U6C1XxGk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U6C1XxGk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C39B671
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883484; cv=none; b=TiZAfMEIJq2jqCCgZeefq762bw66nzRRMGKJaPi1m6jX5iwaZyo6EryMFfR9GiN6kHdKc5zgShSsiZvlOYHFuxl8ND090upZ6K1BM394EnnV2JO6vkDkSTIzzj2nVYBP5oaq/vIG5p12/5OF+EgY8wZkG/WvTnrbqfIZqGboFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883484; c=relaxed/simple;
	bh=XlTK9IFps4Ldd50CE/nm4eenyiPcz4f1bKarUpFsi9Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qbnPoRBc9eedhESxb4lyIF3bbe9xBS7aAfZjHNrRoSmbllL9NN3OMWwK1FbTyuh8ZZT07r2rds4nVFwX7gsuu3hM1WVgEKELn8SFb/tOqiCa6U1++gUJCdSqEL1Hb03t47v6Kvycp25Eq+Skibe9KjNAqleO0bGVwh3nlsBEtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U6C1XxGk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U6C1XxGk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D529E1F7D1
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8NuSLFiRCeE/gMWdcZiBFuUq26SdVgM4PdW0ME68HsQ=;
	b=U6C1XxGkK+Ydjvd0OAccfphhh336mDzWxONORgMByQplyQSEVTRD9053pq1j0hwXWzuTE3
	4EtGIwtsO3nks+NzuPGZ4VYAagvtKvTUVsr5Fcj5fMSO2sryrXgV5HeSgW0Bd9kBCW12C4
	DsaFPHEMcZ3RabynCvs/Y+eIm1me1JI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8NuSLFiRCeE/gMWdcZiBFuUq26SdVgM4PdW0ME68HsQ=;
	b=U6C1XxGkK+Ydjvd0OAccfphhh336mDzWxONORgMByQplyQSEVTRD9053pq1j0hwXWzuTE3
	4EtGIwtsO3nks+NzuPGZ4VYAagvtKvTUVsr5Fcj5fMSO2sryrXgV5HeSgW0Bd9kBCW12C4
	DsaFPHEMcZ3RabynCvs/Y+eIm1me1JI=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 12C871329E
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3OFCMdY7zGVDDAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: make subpage reader/writer counter to be sector aware
Date: Wed, 14 Feb 2024 14:34:33 +1030
Message-ID: <cover.1707883446.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=U6C1XxGk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: D529E1F7D1
X-Spam-Flag: NO

This can be fetched from github, and the branch would be utilized for
all newer subpage delalloc update to support full sector sized
compression and zoned:
https://github.com/adam900710/linux/tree/subpage_delalloc

Currently we just trace subpage reader/writer counter using an atomic.

It's fine for the current subpage usage, but for the future, we want to
be aware of which subpage sector is locked inside a page, for proper
compression (we only support full page compression for now) and zoned support.

So here we introduce a new bitmap, called locked bitmap, to trace which
sector is locked for read/write.

And since reader/writer are both exclusive (to each other and to the same
type of lock), we can safely use the same bitmap for both reader and
writer.

In theory we can use the bitmap (the weight of the locked bitmap) to
indicate how many bytes are under reader/write lock, but it's not
possible yet:

- No weight support for bitmap range
  The bitmap API only provides bitmap_weight(), which always starts at
  bit 0.

- Need to distinguish read/write lock

Thus we still keep the reader/writer atomic counter.

Qu Wenruo (3):
  btrfs: unexport btrfs_subpage_start_writer() and
    btrfs_subpage_end_and_test_writer()
  btrfs: subpage: make reader lock to utilize bitmap
  btrfs: subpage: make writer lock to utilize bitmap

 fs/btrfs/subpage.c | 70 ++++++++++++++++++++++++++++++++++++----------
 fs/btrfs/subpage.h | 16 +++++++----
 2 files changed, 66 insertions(+), 20 deletions(-)

-- 
2.43.1


