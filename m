Return-Path: <linux-btrfs+bounces-16736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C916B4A01F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 05:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3A33A8100
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 03:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE327147D;
	Tue,  9 Sep 2025 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ReMc5FfK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ReMc5FfK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2554654
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389145; cv=none; b=MT1XLLH47k/JHc6dnGxE8jzQSnzSewNqoMT6QdFF7vEoNn2xw3ai/joQHSMFv295+4t/1NHJa3X7ZbmuKphH5eqVOMkx8oEAdQDdY2jmmTLUHRUUsZykKLle4EGHivj1GJLLoQ33i07Ov2xEe+8aFgGsqWkaxZSXSTwR21Bqvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389145; c=relaxed/simple;
	bh=KZspbvPEPFJ28Ljx2EjJ6qDdXOnbHw3Dk8KvRx/Sotc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kYZBqszXrxAQSp+h32wdc0/e/qxhOD6AnDgnJTbpwH/Rxn7K3bPEvpkzl/tkfZGSkoJUq0Bwk1HBwI4gOw2hYUfHj6y7yLlhc+C3qcmTheOkgQhzse+YLHNh034kEBkFeTCho509BkbUnxrGvIYiqyXStrpQu6SUNTktK7Y6Hug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ReMc5FfK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ReMc5FfK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4EC928F86
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757389139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PniKb+Gu9kLLnkTCWCueDqqlzVGwP7zam4lqc2y+XHA=;
	b=ReMc5FfKjt4OhpbLSFU/TZAIUfDu7Tgt0wZ8k50mFq7CCtvVX72MhL8W3o08yyzUopMSPH
	qnRR24v4h77v2rFNAB4tXIMkp5uniW5iLaOfLeONGmF8+n2zBFQqIBLedo1+aByeKaVswT
	fD0Bz+hAV0RSWQOeScDlbzriJ5FF+hA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757389139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PniKb+Gu9kLLnkTCWCueDqqlzVGwP7zam4lqc2y+XHA=;
	b=ReMc5FfKjt4OhpbLSFU/TZAIUfDu7Tgt0wZ8k50mFq7CCtvVX72MhL8W3o08yyzUopMSPH
	qnRR24v4h77v2rFNAB4tXIMkp5uniW5iLaOfLeONGmF8+n2zBFQqIBLedo1+aByeKaVswT
	fD0Bz+hAV0RSWQOeScDlbzriJ5FF+hA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D88013996
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 03:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ybowOFKhv2i7JgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 03:38:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: prepare compression for bs > ps support
Date: Tue,  9 Sep 2025 13:08:36 +0930
Message-ID: <cover.1757388121.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Score: -2.80

This is the compression part support for bs > ps cases.

The main trick involved is the handling of compr folios, the main
changes are:

- Compressed folios now need to follow the minimal order
  This is the requirement for the recently added btrfs_for_each_block*()
  helpers, and this keeps our code from handling sub-block sized ranges.

- No cached compression folios for bs > ps cases
  Those folios are large and are not sharable between other fses, and
  most of btrfs will use 4K (until storage with 16K block size got
  popular).

- Extra rejection of HIGHMEM systems with bs > ps support
  Unfortunately HIGHMEM large folios need us to map them page by page,
  this breaks our principle of no sub-block handling.

  Considering HIGHMEM is always a pain in the backend and is already
  planned for deprecation, it's best for everyone to just reject bs > ps
  btrfses on HIGHMEM systems.

Please still keep in mind that, raid56, scrub, encoded write are not yet
supporting bs > ps cases.

For now I have only done basic read/write/balance/offline data check
tests on bs > ps cases with all 4 compression algorithms (none, lzo, zlib,
zstd), so far so good.

If some one wants to play with the incomplete bs > ps cases, the
following simple diff will enable the work:

 --- a/fs/btrfs/fs.c
 +++ b/fs/btrfs/fs.c
 @@ -96,8 +96,7 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
          */
         if (IS_ENABLED(CONFIG_HIGHMEM) && blocksize > PAGE_SIZE)
                 return false;
 -       if (blocksize <= PAGE_SIZE)
 -               return true;
 +       return true;
  #endif
         return false;
  }

The remaining features and their road maps are:

- Encoded writes
  This should be the most simple part.

- RAID56
  Needs to convert the page usage into folio one first.

- Scrub
  This relies on some RAID56 interfaces for parity handling.
  Otherwise pretty like RAID56, we need to convert the page usage to
  folios first.

Qu Wenruo (4):
  btrfs: prepare compression folio alloc/free for bs > ps cases
  btrfs: prepare zstd to support bs > ps cases
  btrfs: prepare lzo to support bs > ps cases
  btrfs: prepare zlib to support bs > ps cases

 fs/btrfs/compression.c | 38 +++++++++++++++++++-------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/extent_io.c   |  7 +++--
 fs/btrfs/extent_io.h   |  3 ++-
 fs/btrfs/fs.c          | 17 ++++++++++++
 fs/btrfs/fs.h          |  6 +++++
 fs/btrfs/inode.c       |  5 ++--
 fs/btrfs/lzo.c         | 59 ++++++++++++++++++++++-------------------
 fs/btrfs/zlib.c        | 60 +++++++++++++++++++++++++++---------------
 fs/btrfs/zstd.c        | 44 +++++++++++++++++--------------
 10 files changed, 157 insertions(+), 84 deletions(-)

-- 
2.50.1


