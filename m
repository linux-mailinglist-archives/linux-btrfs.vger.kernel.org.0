Return-Path: <linux-btrfs+bounces-7685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF33965724
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 07:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8AB23CB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 05:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E303A14B081;
	Fri, 30 Aug 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fAhVoVsN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fAhVoVsN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF62F2C
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997299; cv=none; b=g00+SpPkqpda716Vy+aNcr0s21JaKbQlAuvm/WAGGzwEj1eCPY212d4E7wJg043m3ELDrBtHMS9cB7n+CEPAVH3e8gnzEg9n79q0zhe0lpde/t9Cr/J89hu/snYJ0s3GxsEpoWD++ZUXojMhLusvHxHrP3k+GDMJydM2+L/0C78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997299; c=relaxed/simple;
	bh=zr130h0jLEyXZr8V8HeCYwKVQ8kGHWeoudf5E/57ZBs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iCCK8BJSTVso5001ssSPlTN00hNwGZuRkqN58aJ+MYSahlt8tuMkbbWumeHUP5XEVy7bO4CMfF05nUOjfwb2Wyf4lauHEoeNVuBVWbSDYu5RGmGR97yNocdBfmCnDZmfSL6bt1ouFecarIzbUvgoyCRJ2VuaHxfp0t8Rxa0P4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fAhVoVsN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fAhVoVsN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6725E21A0E
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 05:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724997295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FmsAAcbsmOxaNxGXtdaQf4DnjASFyGl1HEWdd7HAnGw=;
	b=fAhVoVsNTppqIietYZqmjSosIr/Rmz8V4x+JjNT3QweI7ZAQINEH536ey4L+q7NU9rpw0A
	Q2eS39cEt1+PiygPNaGZCgWq8h8LMBywK8Hol1Yz4dJo6l6aO213q4HkQMmka0oudZeBsm
	br2kqxURC5j3curbtiTfpgtR2BUeH74=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724997295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FmsAAcbsmOxaNxGXtdaQf4DnjASFyGl1HEWdd7HAnGw=;
	b=fAhVoVsNTppqIietYZqmjSosIr/Rmz8V4x+JjNT3QweI7ZAQINEH536ey4L+q7NU9rpw0A
	Q2eS39cEt1+PiygPNaGZCgWq8h8LMBywK8Hol1Yz4dJo6l6aO213q4HkQMmka0oudZeBsm
	br2kqxURC5j3curbtiTfpgtR2BUeH74=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9132A136A4
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 05:54:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4shMFK5e0Wa3SAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 05:54:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: subpage: fix the bitmap dump which can cause bitmap corruption
Date: Fri, 30 Aug 2024 15:24:32 +0930
Message-ID: <2d1b89e8400e2a536dc5b43bf1e35821b469a14d.1724997259.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

In commit 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for
debug") an internal macro GET_SUBPAGE_BITMAP() is introduced to grab the
bitmap of each attribute.

But that commit is using bitmap_cut() which will do the left shift of
the larger bitmap, causing incorrect values.

Thankfully this bitmap_cut() is only called for debug usage, and so far
it's not yet causing problems.

Fix it to use bitmap_read() to only grab the desired sub-bitmap.

Fixes: 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for debug")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This patch contains the fix for patch "btrfs: refactor
__extent_writepage_io() to do sector-by-sector submission", thankfully
that patch is not yet upstreamed.

I'll put the fix before that commit when merging.
---
 fs/btrfs/subpage.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 663f2f953a65..6a73834368c8 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -869,10 +869,10 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct fol
 	}
 }
 
-#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
-	bitmap_cut(dst, subpage->bitmaps, 0,				\
-		   fs_info->sectors_per_page * btrfs_bitmap_nr_##name,	\
-		   fs_info->sectors_per_page)
+#define GET_SUBPAGE_BITMAP(subpage, fs_info, name)			\
+	bitmap_read(subpage->bitmaps,					\
+		    fs_info->sectors_per_page * btrfs_bitmap_nr_##name,	\
+		    fs_info->sectors_per_page)
 
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
@@ -891,12 +891,11 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, uptodate, &uptodate_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, dirty, &dirty_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, writeback, &writeback_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, ordered, &ordered_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, checked, &checked_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &checked_bitmap);
+	uptodate_bitmap = GET_SUBPAGE_BITMAP(subpage, fs_info, uptodate);
+	dirty_bitmap = GET_SUBPAGE_BITMAP(subpage, fs_info, dirty);
+	writeback_bitmap = GET_SUBPAGE_BITMAP(subpage, fs_info, writeback);
+	ordered_bitmap = GET_SUBPAGE_BITMAP(subpage, fs_info, ordered);
+	checked_bitmap = GET_SUBPAGE_BITMAP(subpage, fs_info, checked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
 	dump_page(folio_page(folio, 0), "btrfs subpage dump");
@@ -922,6 +921,6 @@ void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, dirty, ret_bitmap);
+	*ret_bitmap = GET_SUBPAGE_BITMAP(subpage, fs_info, dirty);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
-- 
2.46.0


