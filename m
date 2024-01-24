Return-Path: <linux-btrfs+bounces-1669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DBF83A04E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 04:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45641C2720A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 03:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672268F72;
	Wed, 24 Jan 2024 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ErLuoIfR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ErLuoIfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4266FA5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068757; cv=none; b=nRNsgQLvsEsgdpNA8c3dU5MUROrDblBnBatshR7QTxsrLQubTJZh+YLhJJWGnW1CCSJ+uqGHkXM/o1ytRttG+9kO5f+FMkr68o3p12JGIaRhvoFdk7r9z/8H4d9fhpaO0Lavd3GlOqZsNco6E+Y70sHdfQ5lWVWPKNZnWOhvj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068757; c=relaxed/simple;
	bh=F864I449D7epTAYTfMbAPvBrongAHjPFoMZT3nkjEoE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DQCSekewpzJ1QPwP1C6xAt6t5IsQxWTCTupEjpUpprbiYGZHKXbOuoF29dyComgxC0W5u34gfsxLtViAYyKFDK8RMLnFgrfHs2rLuKhdIPDQ5trW6hSGAovITXRf8OqCLkG67z6l73B7T0id/9ivQrau6pAmbq/jnZixUcldh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ErLuoIfR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ErLuoIfR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B42301FCFD
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706068752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Hb0VYBs6H3W0q7fw2kVOQ/0OwBQkZzQO1EjBbNHfwJw=;
	b=ErLuoIfRboZE2s0T77te8Mntqo2ciSp+7c8fPXRQgWLwb7ihvZ1QUa9XdT9vbQ6x0MHLZS
	HwNbbR6wcxubXmU0lRIwdU3YUAP1XyNRkr53OiiYc2kBYR8fW+ygaTO7C+jE622AUcFLlA
	Ht+8CFNSqSmYY3PBFBKQ7lOIU/xUI3g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706068752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Hb0VYBs6H3W0q7fw2kVOQ/0OwBQkZzQO1EjBbNHfwJw=;
	b=ErLuoIfRboZE2s0T77te8Mntqo2ciSp+7c8fPXRQgWLwb7ihvZ1QUa9XdT9vbQ6x0MHLZS
	HwNbbR6wcxubXmU0lRIwdU3YUAP1XyNRkr53OiiYc2kBYR8fW+ygaTO7C+jE622AUcFLlA
	Ht+8CFNSqSmYY3PBFBKQ7lOIU/xUI3g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9226136F5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ywWwJQ+LsGXVLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 0/2] btrfs: defrag: further preparation for multi-page sector size
Date: Wed, 24 Jan 2024 14:29:06 +1030
Message-ID: <cover.1706068026.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
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
	dkim=pass header.d=suse.com header.s=susede1 header.b=ErLuoIfR
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.88%]
X-Spam-Score: 3.40
X-Rspamd-Queue-Id: B42301FCFD
X-Spam-Flag: NO

With the folio interface, it's much easier to support multi-page sector
size (aka, sector/block size > PAGE_SIZE, which is rare between major
upstream filesystems).

The basic idea is, if we firstly convert to full folio interface, and
allow an address space to only allocate folio which is exactly
block/sector size, the support for multi-page would be mostly done.

But before that support, there are still quite some conversion left for
btrfs.

Furthermore, with both subpage and multipage sector size, we need to
handle folio different:

- For subpage
  The folio would always be page sized.

- For multipage (and regular sectorsize == PAGE_SIZE)
  The folio would be sector sized.

Furthermore, the filemap interface would make various shifts more
complex.
As filemap_*() interfaces use index which is PAGE_SHIFT based,
meanwhile with potential larger folio, the folio shift can be larger
than PAGE_SHIFT.

Thus in the future, we may want to change filemap interface to accept
bytenr to avoid confusion between page and folio shifts.

The first patch would introduce a cached folio size and shift.

The second patch would make defrag to utilize the new cached folio size
and shift.
(And still use PAGE_SHIFT only for filemap*() interfaces)

Qu Wenruo (2):
  btrfs: introduce cached folio size
  btrfs: defrag: prepare defrag for larger data folio size

 fs/btrfs/defrag.c  | 69 +++++++++++++++++++++++++---------------------
 fs/btrfs/disk-io.c | 11 ++++++++
 fs/btrfs/fs.h      | 10 +++++++
 3 files changed, 58 insertions(+), 32 deletions(-)

-- 
2.43.0


