Return-Path: <linux-btrfs+bounces-1302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA855826A41
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 10:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AF51F2171C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB17C11C87;
	Mon,  8 Jan 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mOQ80GSM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mOQ80GSM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3511709
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 441731F796
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704704946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gCgPC86+salB1wxVipIQ1qovOKjMAMGL8qLclukv3II=;
	b=mOQ80GSM3tauGofp/R8dqI0MW5vcXdRDeNk1G9jgur90FfWW19W3Tsbu56LdRTLWGuCYmC
	MJjEuQ4YTQPkeMSQlLwjLhIVzW3pGLM4+ZYDoAWTDwbOaSsaIxzw57HoEOs0hccA/xbAcC
	Qb+1iD7TpgLeTtYqGmabWXrwiBPKggA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704704946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gCgPC86+salB1wxVipIQ1qovOKjMAMGL8qLclukv3II=;
	b=mOQ80GSM3tauGofp/R8dqI0MW5vcXdRDeNk1G9jgur90FfWW19W3Tsbu56LdRTLWGuCYmC
	MJjEuQ4YTQPkeMSQlLwjLhIVzW3pGLM4+ZYDoAWTDwbOaSsaIxzw57HoEOs0hccA/xbAcC
	Qb+1iD7TpgLeTtYqGmabWXrwiBPKggA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3127613496
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QalEM7C7m2UxCwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 09:09:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix and simplify the inline extent decompression path for subpage
Date: Mon,  8 Jan 2024 19:38:43 +1030
Message-ID: <cover.1704704328.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 3.69
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Result: default: False [3.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.13%]

There is a long existing bug in subpage inline extent reflinking to
another location.

The bug is caused by an existing bad code, which is from the beginning
of btrfs.
The bad code is never properly explained and got further copied into new
compression code.

The bad condition never got properly triggered by different reasons for
different platforms:

- On 4K page sized system, the @start_byte is always 0
  Thus the existing checks are all dead code, thus never triggered.

- For subpage (4K sectorsize 64K page size) cases, inline extent
  creation is disable for a different reason
  Since no inline extent can be created, there is no way to reflink
  any inlined extent thus no way to trigger it.

The fixes are mostly going to rework the decompression loop, making sure
the input and output buffer are always large enough for inline extent.
Thus no need for any loop, but a single decompression call.

But the difficulty lies in how to properly test the bug.
For now I'm only doing cross-platform tests, using image created on
x86_64, and do the reflink on aarch64.
Not sure if it's possible to upload a binary image for fstests, or I
don't have any good way to test the bug.

Qu Wenruo (3):
  btrfs: zlib: fix and simplify the inline extent decompression
  btrfs: lzo: fix and simplify the inline extent decompression
  btrfs: zstd: fix and simplify the inline extent decompression

 fs/btrfs/compression.c | 23 +++++++++----
 fs/btrfs/compression.h |  6 ++--
 fs/btrfs/lzo.c         | 34 +++++--------------
 fs/btrfs/super.h       |  3 ++
 fs/btrfs/zlib.c        | 73 +++++++++++------------------------------
 fs/btrfs/zstd.c        | 74 +++++++++++++-----------------------------
 6 files changed, 72 insertions(+), 141 deletions(-)

-- 
2.43.0


