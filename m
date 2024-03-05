Return-Path: <linux-btrfs+bounces-3033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527B872A3E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 23:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D411F22C59
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC447E56F;
	Tue,  5 Mar 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d9ZDkC94";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d9ZDkC94"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6D1BDDF
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678159; cv=none; b=CQunP6xHnXtm4dqJklpYStBM8vF5v9in+tGXS3PdfjLDeuv4UYTqXm/bWKeIBjN7+56l+I7FZGZl9dVT+o+aqE72Pohs4hXrcpcywUT9N855HhAaBZeriqbykCtvXYCu8wWXTmWmT2cqWPQ6XPARt3ng8ryyjKi4ivyRr/goS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678159; c=relaxed/simple;
	bh=fx5XWUuZiU8+/LPSY0jM+MF4/yuJY93WQnxX0ut9LAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gojnm3m9wMfzCFrbqHn8YjUOwZ8Vgb0hOZ4Q9eiUq4rZ3AZiTdEjmf+gMhbpZPcEPLRk1vJj7KET6W8mz/PKlH0l4YXQIFITaOOofwm5nX6q/T3dMUctmgwQIt1EgMCvI4NhKEOciZrL920spjLczTYkXRvY1uvnyc6lwd8eybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d9ZDkC94; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d9ZDkC94; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 196BA5BE96
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709678155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkeVccvpY2bZRGVxK6N14flEdryihQMWYkfxLuOWdGY=;
	b=d9ZDkC94TwwYOW2xBt2ixMnLZi/AmeSrTKGqVEhwDOt/pFEdBeimKGmHRd1CRWXryieKom
	N2RjC3cBja0qpHCpUZOzBTEWw6dPK932oWVRtvM5Zc+AylaZ8xCT/g+8p3GEyOGdyUr9xp
	A7FkCMWN15MHS4Dr5OUTXgDjwyNsUCo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709678155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FkeVccvpY2bZRGVxK6N14flEdryihQMWYkfxLuOWdGY=;
	b=d9ZDkC94TwwYOW2xBt2ixMnLZi/AmeSrTKGqVEhwDOt/pFEdBeimKGmHRd1CRWXryieKom
	N2RjC3cBja0qpHCpUZOzBTEWw6dPK932oWVRtvM5Zc+AylaZ8xCT/g+8p3GEyOGdyUr9xp
	A7FkCMWN15MHS4Dr5OUTXgDjwyNsUCo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A68E13A5D
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ULtqNEme52VwKgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 22:35:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: do not clear page dirty inside extent_write_locked_range()
Date: Wed,  6 Mar 2024 09:05:33 +1030
Message-ID: <ebf001731e2ebafd5c2a435a7e0848634a421ed7.1709677986.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709677986.git.wqu@suse.com>
References: <cover.1709677986.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=d9ZDkC94
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: 196BA5BE96
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

[BUG]
For subpage + zoned case, btrfs can easily hang with the following
workload, even with previous subpage delalloc rework:

 # mkfs.btrfs -s 4k -f $dev
 # mount $dev $mnt
 # xfs_io -f -c "pwrite 32k 128k" $mnt/foobar
 # umount $mnt

The system would hang at unmount due to unfinished ordered extents.

Above $dev is a tcmu-runner emulated zoned HDD, which has a max zone
append size of 64K, and the system has 64K page size.

[CAUSE]
There is a bug involved in extent_write_locked_range() (well, I'm
already surprised by how many subpage incompatible code are inside that
function):

- If @pages_dirty is true, we will clear the page dirty flag for the
  whole page

  This means, for above case, since the max zone append size is 64K,
  we got an ordered extent sized 64K, resulting the following writeback
  range:

  0               64K                 128K            192K
  |       |///////|///////////////////|/////////|
          32K               96K
           \       OE      /

  |///| = subpage dirty range

  And when we go into the __extent_writepage_io() call to submit [32K,
  64K), extent_write_locked_range() would find it's the locked page, and
  not clear its page dirty flag, so the submission go without any
  problem.

  But when we go into the [64K, 96K) range for the second half of the
  ordered extent, extent_write_locked_range() would clear the page dirty
  flag for the whole page range [64K, 128K), resulting the following
  layout:

  0               64K                 128K            192K
  |       |///////|         |         |/////////|
          32K               96K
           \       OE      /

  Then inside __extent_writepage_io(), since the page is no longer
  dirty, we skip the submission, causing only half of the ordered extent
  can be finished, thus hanging the whole system.

  Furthermore, this would cause more problems when we move to the next
  delalloc range [96K, 160K), as the original dirty range [96K, 128K)
  has its dirty flag cleared without releasing its data/metadata rsv, we
  would got rsv leak.

This bug only affects subpage and zoned case.
For non-subpage and zoned case, find_next_dirty_byte() just return the
whole page no matter if it has dirty flags or not.

For subpage and non-zoned case, we never go into
extent_write_locked_range().

[FIX]
Just do not clear the page dirty at all.
As __extent_writepage_io() would do a more accurate, subpage compatible
clear for page dirty anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fb63055f42f3..bdd0e29ba848 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2290,10 +2290,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		ASSERT(PageLocked(page));
-		if (pages_dirty && page != locked_page) {
+		if (pages_dirty && page != locked_page)
 			ASSERT(PageDirty(page));
-			clear_page_dirty_for_io(page);
-		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
 					    &bio_ctrl, i_size, &nr);
-- 
2.44.0


