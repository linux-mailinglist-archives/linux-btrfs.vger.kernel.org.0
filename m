Return-Path: <linux-btrfs+bounces-2467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B35858D7F
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 07:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49896282CE5
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0001CAB5;
	Sat, 17 Feb 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D9uJa4Hm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D9uJa4Hm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283541CA9F
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151399; cv=none; b=ibELhJc0FX2pO8cKb3oF0gDKVqh0qYyRutBZ9wngOHGQUvQLzOyWhtLJZOqBiT4FPvNu8BRV8OQqpMJm0kz5n9a0pTCJg6/DydSwfpRBfUfv/5uUJraolPfGQ3T0WDKlWAyV5W+RWFkeXebdV4OsSkQLZl7frLPKdDO+cG7vDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151399; c=relaxed/simple;
	bh=BLpjgfFdGaPVNB0lL9Ct4JZVIeQG3+aGyO8j4umPKFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s/EXcyZvaS+sCXG7wYVq+GKDA4Y0jE4qjjEmmrpqEiQkUYDfegc93BoYek3sgS4A2qHe2THk7RsgCyNCStIrWbp/O8d2LireLKMXIcPX8fpoGlp4UTSJuv8Y6pok2lX1sLVCAlQcJ6fE3oWMz2E+DmfncQjtushVJVpso1HnE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D9uJa4Hm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D9uJa4Hm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DA4F21FB9
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R2nM3nXtrLA0Oi7yKjnJvrlwPO25C+O1/cRTMQN+ZMU=;
	b=D9uJa4HmsNbJR3VvuCSkFcAJ4uRCmZfDBWtonGcgGIgfmqdFrs7wdvr4/IBhtIv5WWzcDJ
	X77UsjIymNUu/9+C4IKl41l6tJuKl6QkMOs/n9FOwsLUzw0i4nYo0MD3BGMQM2DOIgKLHm
	2gMa/T5D2emMCB7AJfayo18QjFdnLs8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R2nM3nXtrLA0Oi7yKjnJvrlwPO25C+O1/cRTMQN+ZMU=;
	b=D9uJa4HmsNbJR3VvuCSkFcAJ4uRCmZfDBWtonGcgGIgfmqdFrs7wdvr4/IBhtIv5WWzcDJ
	X77UsjIymNUu/9+C4IKl41l6tJuKl6QkMOs/n9FOwsLUzw0i4nYo0MD3BGMQM2DOIgKLHm
	2gMa/T5D2emMCB7AJfayo18QjFdnLs8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A9AA134CD
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qQTFA2FS0GUyZQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: make subpage reader/writer counter to be sector aware
Date: Sat, 17 Feb 2024 16:59:47 +1030
Message-ID: <cover.1708151123.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=D9uJa4Hm
X-Spamd-Result: default: False [0.69 / 50.00];
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
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: 0DA4F21FB9
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

[CHANGELOG]
v2:
- Add btrfs_subpage_dump_bitmap() support for locked bitmap

- Add spinlock to protect the bitmap and locked bitmap operation
  In theory, this opeartion should always be single threaded, since the
  page is locked.
  But to keep the behavior consistent, use spin lock to protect bitmap
  and atomic reader/write updates.

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

 fs/btrfs/subpage.c | 77 ++++++++++++++++++++++++++++++++++++----------
 fs/btrfs/subpage.h | 16 +++++++---
 2 files changed, 72 insertions(+), 21 deletions(-)

-- 
2.43.1


