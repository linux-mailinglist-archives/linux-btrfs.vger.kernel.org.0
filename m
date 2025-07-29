Return-Path: <linux-btrfs+bounces-15737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAADDB14B4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E6E7A9FFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F52877EB;
	Tue, 29 Jul 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qayS8NZW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qayS8NZW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A12877C6
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781531; cv=none; b=RTNIAxlf1zbGd/bUrWbMagkh2h7K/XF/PK/a/lh/0Xfy+iqukhZNhV/LaFMdIE7sQQ0TycyPeHjg4dM4o1igmfj8w0eS+nQAfYqfk/AgS4wQxJSMu2i2gwOHdtwZaE5Cdpc8uZ2Sz0Vf576BqWgRsWRgBCJ8Mkkt8qzLHXXLyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781531; c=relaxed/simple;
	bh=njC7fl7ShNUufojkLnXxfUvvt2FQwnD6lGVGwrKslBg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LenEhXaXFseMb29KVV9l70B/fazsiO3LmIZ8ASszpkLFfxtY37r49KA2Y9qmYj/123/OaXG93zytWmcYSGrkc5zjTClJox4gQCzecZ+Lnw8r66BSwdTcSO2/ijC3vEfeivfjzbojRxVdEJXRaTViSm/HZVWi7rS+gCFyK5cOzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qayS8NZW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qayS8NZW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9396F1F789
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753781527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhkZMbqxsb1aUrlIQ+kkpulRumJkG+vZBk16hwKHYoo=;
	b=qayS8NZWHVIfO4LqamIuO4WcDjJ5elA7PJfJioF54GGtsxOvc7SZiocplqQrj3TY7GL93t
	wGBf7Mm8GdHIdv2/Mhv8bTl6RCqxgR7FydheRmKKl7KzKtGvu4m9rVGyBcRNjUzXmDK0jn
	p87/TJ+8Tlnss0yjoWy5kpgprPV2GkM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753781527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhkZMbqxsb1aUrlIQ+kkpulRumJkG+vZBk16hwKHYoo=;
	b=qayS8NZWHVIfO4LqamIuO4WcDjJ5elA7PJfJioF54GGtsxOvc7SZiocplqQrj3TY7GL93t
	wGBf7Mm8GdHIdv2/Mhv8bTl6RCqxgR7FydheRmKKl7KzKtGvu4m9rVGyBcRNjUzXmDK0jn
	p87/TJ+8Tlnss0yjoWy5kpgprPV2GkM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF05A13876
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Dj2IxaViGgxUQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:32:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: clear block dirty if btrfs_writepage_cow_fixup() failed
Date: Tue, 29 Jul 2025 19:01:46 +0930
Message-ID: <0d5c6540fef2b1ebd96e332c20adcd694ea23b4d.1753781242.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753781242.git.wqu@suse.com>
References: <cover.1753781242.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
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
X-Spam-Score: -2.80

[BUG]
If btrfs_writepage_cow_fixup() failed (return value not 0 nor -EGAIN),
the block will be kept dirty, but with their corresponding range finished
in the ordered extent.

Currently the only error pattern is only possible for experimental
builds, which places extra check to ensure we shouldn't hit an dirty
block without a corresponding ordered extent.

This means if later a writeback happens again, we can hit the following
problems:

- ASSERT(block_start != EXTENT_MAP_HOLE) in submit_one_sector()
  If the original extent map is a hole, then we can hit this case, as
  the new ordered extent failed, we will drop the new extent map and
  re-read one from the disk.

- DEBUG_WARN() in btrfs_writepage_cow_fixup()
  This is because we no longer have an ordered extent for those dirty
  blocks. The original for them is already finished with error.

[CAUSE]
The function btrfs_writepage_cow_fixup() is not following the regular
error handling of writeback.
The common practice is to clear the folio dirty, start and finish the
writeback for the block.

This is normally done by extent_clear_unlock_delalloc() with
PAGE_START_WRITEBACK | PAGE_END_WRITEBACK flags during
run_delalloc_range().

So if we keep those failed blocks dirty, they will stay in the page
cache and wait for the next writeback.

And since the original ordered extent is already finished and removed,
depending on the original extent map, we either hit the ASSERT() inside
submit_one_sector(), or hit the DEBUG_WARN() in
btrfs_writepage_cow_fixup() again (and very ironic).

[FIX]
Follow the regular error handling to clear the dirty flag for the block
range, start and finish writeback for that block range instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f6765ddab4a7..b2ff2a445b80 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1656,8 +1656,12 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		folio_unlock(folio);
 		return 1;
 	}
-	if (ret < 0)
+	if (ret < 0) {
+		btrfs_folio_clear_dirty(fs_info, folio, start, len);
+		btrfs_folio_set_writeback(fs_info, folio, start, len);
+		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 		return ret;
+	}
 
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
-- 
2.50.1


