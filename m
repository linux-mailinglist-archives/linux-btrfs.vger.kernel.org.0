Return-Path: <linux-btrfs+bounces-12671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC4FA7556A
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 10:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE16B1706EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C01ADC7D;
	Sat, 29 Mar 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jAqKNNCI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jAqKNNCI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E21A072A
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743240009; cv=none; b=DzKVkZ0y7TVOvcqww7vG1qfCVPgeWvnTsscj08CfQiZMaJ85C10xHPXWGWxza8T8HqYgnUN9MB0Orn+eScrAi68AvqLfijw6H/Y/kor7N9VB1nfVwlIz/pzDeOdicVN4stLrMeNlBoN/gSy3zzFAIQJYfObGH75O5qp7KC+XO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743240009; c=relaxed/simple;
	bh=EgkdEExIyfn4Xfzu/hCMnCZLCw8MBjKNDsK3RVvSzxo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCMQQ3+RiC1g0eEKKfDGJcbhfM27q/zi3kLhmBDsvROa4wAqMMZfjw9MxR1cNhn0t+hNXRqWu/JKR+uFTGOpKD10X38UshovvrYZ1dHHLgBPllwG6Z3MDrUlF+cnEOIeVzLvKhNDVSgatSx5927tuW4pApuqBBeYjLdxfGuxngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jAqKNNCI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jAqKNNCI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E3011F449
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4j/AV+Fi5Rmtw1LPBq/yU3nr9elvQP0D1CHC2ZVgjXU=;
	b=jAqKNNCIaQPhO+fg185y5fdEBcxnFbnDpiKHlnI6C4dE6CRdwsFinwAJZtXHca3oVwdh4N
	nGqwA8fOOv1XOK78SfKn5bkFax/OLfI0Y6RaXYArJbzSEvQR72KeU3/KuJtQDSCCx4l7Tx
	MiNTI4m68v3XuOkZDCNeaDi7agD2uGE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4j/AV+Fi5Rmtw1LPBq/yU3nr9elvQP0D1CHC2ZVgjXU=;
	b=jAqKNNCIaQPhO+fg185y5fdEBcxnFbnDpiKHlnI6C4dE6CRdwsFinwAJZtXHca3oVwdh4N
	nGqwA8fOOv1XOK78SfKn5bkFax/OLfI0Y6RaXYArJbzSEvQR72KeU3/KuJtQDSCCx4l7Tx
	MiNTI4m68v3XuOkZDCNeaDi7agD2uGE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D85B113A41
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FUWJkS752cCEQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()
Date: Sat, 29 Mar 2025 19:49:37 +1030
Message-ID: <21ee2b756ce8ad1dcf1b9ecdfec84f0b87c271f5.1743239672.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743239672.git.wqu@suse.com>
References: <cover.1743239672.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
When running btrfs/004 with 4K fs block size and 64K page size,
sometimes fsstress workload can take 100% CPU for a while, but not long
enough to trigger a 120s hang warning.

[CAUSE]
When such 100% CPU usage happens, btrfs_punch_hole_lock_range() is
always in the call trace.

With extra ftrace debugs, it shows something like this:

   btrfs_punch_hole_lock_range: r/i=5/2745 start=4096(65536)
end=20479(18446744073709551615) enter

Where 4096 is the @lockstart parameter, 65536 is the rounded up
@page_lockstart, 20479 is the @lockend parameter.
So far so good.

But the large number (u64)-1 is the @page_lockend, which is not correct.

This is caused by the fact that round_down(locked + 1, PAGE_SIZE)
results 0.

In the above case, the range is inside the same page, and we do not even
need to call filemap_range_has_page(), not to mention to call it with
(u64)-1 as the end.

This behavior will cause btrfs_punch_hole_lock_range() to busy loop
waiting for irrelevant range to has its pages to be dropped.

[FIX]
Calculate @page_lockend by just rounding down @lockend, without
decreasing the value by one.
So @page_lockend will no longer overflow.

Then exit early if @page_lockend is no larger than @page_lockestart.
As it means either the range is inside the same page, or the two pages
are adjacent already.

Finally only decrease @page_lockend when calling
filemap_range_has_page().

Fixes: 0528476b6ac7 ("btrfs: fix the filemap_range_has_page() call in btrfs_punch_hole_lock_range()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 589d36f8de12..7c147ef9368d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2126,15 +2126,20 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	 * will always return true.
 	 * So here we need to do extra page alignment for
 	 * filemap_range_has_page().
+	 *
+	 * And do not decrease page_lockend right now, as it can be 0.
 	 */
 	const u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
-	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
+	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE);
 
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
 		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
+		/* The same page or adjacent pages. */
+		if (page_lockend <= page_lockstart)
+			break;
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2146,7 +2151,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * we do, unlock the range and retry.
 		 */
 		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend))
+					    page_lockend - 1))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-- 
2.49.0


