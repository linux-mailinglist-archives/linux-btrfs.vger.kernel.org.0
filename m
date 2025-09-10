Return-Path: <linux-btrfs+bounces-16771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C753B50D12
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153767A1BFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D96E26F28A;
	Wed, 10 Sep 2025 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xman+vuK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xman+vuK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1A31D39F
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481509; cv=none; b=ilOekbKoAWI+bq0UFtpIhuaqQP2C3MlL/+BFzRcFwA4RV6ZyA/LzEFxb+LgOeXzK+4D37M1dX+kTpK0788A1JgEW5mSJN2TWq91/jzR+R9Mv6XEZeBGeaowIQs7r/jU92lobUTBsxVp4GVAAREAC2aFr2z15ltScc7mUcUVnjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481509; c=relaxed/simple;
	bh=jK3pdbRslsRrovf25k9U6X07XilgVPjhjhHfqqr8MCo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PbpKEkkZjGmlJsZrsOKjDaR5a+sR16iIQJQPh/KGFKw1X8Dg/F9kI6QHYQX/Ip9ZGnvwTD24Ch4WT1IpzSd7avLH0hCphvAXfr+BM0zraeVGnXwI+EtScSKTskDkdVhJfloiMa+WzbTzzQVYPUO+yXzuYbOg6i8Ln06gADCHr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xman+vuK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xman+vuK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BF71336D2
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757481505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rsWOMWUDUehMMRyDR5eqJfT3r858SXaLUudUIyHJ3M8=;
	b=Xman+vuK8YNH6fTQ/dnPXFtBewOtGNWoxLfeFnpGRWTAptnpN7DFaPUkSILOIHKzMbg02f
	6QASkgbOepeo4y2+W8G9Kygz/dTP7shKoXrUqzPqWCLM1h5de4WzvNDEV0K7IF22pM0v52
	9ZGnYEr6Kf7Byq8MEeMD80Q1govsVGg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Xman+vuK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757481505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rsWOMWUDUehMMRyDR5eqJfT3r858SXaLUudUIyHJ3M8=;
	b=Xman+vuK8YNH6fTQ/dnPXFtBewOtGNWoxLfeFnpGRWTAptnpN7DFaPUkSILOIHKzMbg02f
	6QASkgbOepeo4y2+W8G9Kygz/dTP7shKoXrUqzPqWCLM1h5de4WzvNDEV0K7IF22pM0v52
	9ZGnYEr6Kf7Byq8MEeMD80Q1govsVGg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F6DF13301
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /PjzByAKwWjvdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:18:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: prepare compression for bs > ps support
Date: Wed, 10 Sep 2025 14:48:02 +0930
Message-ID: <cover.1757481354.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2BF71336D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Fix a missing callsite inside btrfs_compress_file_range() which only
  zeros the range inside the first page
  The folio_zero_range() of the last compressed folio should cover the
  full folio, not only the first page.

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
 fs/btrfs/inode.c       | 16 ++++++-----
 fs/btrfs/lzo.c         | 59 ++++++++++++++++++++++-------------------
 fs/btrfs/zlib.c        | 60 +++++++++++++++++++++++++++---------------
 fs/btrfs/zstd.c        | 44 +++++++++++++++++--------------
 10 files changed, 163 insertions(+), 89 deletions(-)

-- 
2.50.1


