Return-Path: <linux-btrfs+bounces-1886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188C8401FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341581C216D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261E55C2D;
	Mon, 29 Jan 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uCklnAeu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uCklnAeu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3454FB8
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521595; cv=none; b=NT7Iv6pCmrigEWfaQhwPTQRM/PhSwPkKbKfzEodV3QAn5npdHjCJCMRYTq1BQo8AHRSnYFhlJz6rcWaCFAfokDEPmgePBXBu+2J9erIVc3Erv7Baa9rHmXbdh31vMyw6+O7+mj5Z6zUosCSwM6ESycO7IInDyEnnF+QuyE0hLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521595; c=relaxed/simple;
	bh=PXMzg4Sn1UDC8LXXheNGcZjlQpYNbgwSb7VJcbK6lus=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MmTqSflpZJu7ZWmcI/xJKNX7LRQ4qzmH4DsfFv1+Ae8VKuj1bbc30a8tG+QyLjzVXdnba/zKGfc1b5HDph7/o09astiSSJ7YKq6v9Tl85oLaXiMBi6eNZp+Gdhm1rLj4va1LSlfAVWNVdB5fe/9wKyrKCtPrY/xUDTWr5s0MIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uCklnAeu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uCklnAeu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BA141F7D8
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fSf1ieebqKgX+Rj7US+6JDv64sVeNueYjBKTi20Z2jY=;
	b=uCklnAeuO+Q5UjN8kf7bMukTsRq/ePlUZ/LntIkK89pXh6FkamInUg/VUXR2AlG5OZePaQ
	EHzW1nhhgK7npOu7d5OFopdfrIx+Wc+zR9lhWCqWLs3sQh8TBAx7UbrKpmNgiqiajWN8If
	rRC5P8maW1Jwg46gIGwqougwKoiMKsw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fSf1ieebqKgX+Rj7US+6JDv64sVeNueYjBKTi20Z2jY=;
	b=uCklnAeuO+Q5UjN8kf7bMukTsRq/ePlUZ/LntIkK89pXh6FkamInUg/VUXR2AlG5OZePaQ
	EHzW1nhhgK7npOu7d5OFopdfrIx+Wc+zR9lhWCqWLs3sQh8TBAx7UbrKpmNgiqiajWN8If
	rRC5P8maW1Jwg46gIGwqougwKoiMKsw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C0CF13911
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NlL3F/Vzt2W/RwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: compression: migrate to folio interfaces
Date: Mon, 29 Jan 2024 20:16:05 +1030
Message-ID: <cover.1706521511.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

This is the conversion for btrfs compression paths to use folio
interfaces.

For now, it's a pure intrefaces change, just with some variable names
also changed from "page" to "folio".

There is no utilization of possible larger folio size yet, thus we're
still using a lot of PAGE_SIZE/PAGE_SHIFT in the existing code.

But it's still a good first step towards large folio for btrfs data.

The first patch is in fact independent from the series, to slightly
enhance the page cache missing error handling, but all later patches
relies on it, to make later folio change a little smoother.

The third patch is also a good cleanup, as it allows we to pass a single
page to inline creation path.
Although during tests, it turns out that under heavy race we can try to
insert an empty inline extent, but since the old code can handle it
well, I just added one comment for it.

The remaining but the last one are some preparation before the final
conversion.

And the final patch is the core conversion, as we have several structure
relying on page array, it's impossible to just convert one algorithm to
folio meanwhile keep all the other using pages.


Qu Wenruo (6):
  btrfs: compression: add error handling for missed page cache
  btrfs: compression: convert page allocation to folio interfaces
  btrfs: make insert_inline_extent() to accept one page directly
  btrfs: migrate insert_inline_extent() to folio interfaces
  btrfs: introduce btrfs_alloc_folio_array()
  btrfs: compression: migrate compression/decompression paths to folios

 fs/btrfs/compression.c | 119 +++++++++++++++++++-------------
 fs/btrfs/compression.h |  41 ++++++------
 fs/btrfs/extent_io.c   |  31 +++++++++
 fs/btrfs/extent_io.h   |   2 +
 fs/btrfs/inode.c       | 149 +++++++++++++++++++++--------------------
 fs/btrfs/lzo.c         |  87 ++++++++++++------------
 fs/btrfs/zlib.c        | 110 ++++++++++++++++--------------
 fs/btrfs/zstd.c        |  79 ++++++++++++----------
 8 files changed, 349 insertions(+), 269 deletions(-)

-- 
2.43.0


