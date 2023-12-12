Return-Path: <linux-btrfs+bounces-840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AFB80E3C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 06:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E92B21AF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 05:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A37156C9;
	Tue, 12 Dec 2023 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hp+FMA7F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q+HrEewm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84C5D9
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 21:24:34 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2D2622488
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702358673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7FoUiO15pPIRPvxke2UQ4Fzk9xXiuTlR+fY444KWek=;
	b=Hp+FMA7FRuYbiIt1mqk7f/z0lMd49y2llVWtv6Az9j5qJXYC6F4jZz3LLL7dlVbjqj8gf0
	9ub30BHkcMmwJ2wTLiHQK79s1p3nsKZAsOcnTdDLnNWZDXQWJACqXkoN9pL5s2V3XQ8U3y
	iXKmFl2O9e7oZmtMxZJn5bVoma5gS+E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702358672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7FoUiO15pPIRPvxke2UQ4Fzk9xXiuTlR+fY444KWek=;
	b=Q+HrEewmqWfaihdnKM1JSt8+7C2M82rxcAagCjkBArf2crV72gnJVEvQJNPhWSRhiALyyX
	jf51UbXbi80wUTizCvg15PtpRApWjvBMEixk57KGNmPvEb7DI8233cTxgre4SZv+g0rtCI
	QNgOs1IAUIYQArAw3pSOPwZb51m8A2w=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B5A1C139E9
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SL/4E4/ud2VZQQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 05:24:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: migrate eb_bitmap_offset() to folio interfaces
Date: Tue, 12 Dec 2023 15:54:09 +1030
Message-ID: <ccb0a41912f4a46ac89234e164e16b3df6b7c6c6.1702354716.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702354716.git.wqu@suse.com>
References: <cover.1702354716.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: 0.70
Authentication-Results: smtp-out1.suse.de;
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
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

[BUG]
Test case btrfs/002 would fail if larger folios are enabled for
metadata:

 assertion failed: folio, in fs/btrfs/extent_io.c:4358
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/extent_io.c:4358!
 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 1 PID: 30916 Comm: fsstress Tainted: G           OE      6.7.0-rc3-custom+ #128
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
 RIP: 0010:assert_eb_folio_uptodate+0x98/0xe0 [btrfs]
 Call Trace:
  <TASK>
  extent_buffer_test_bit+0x3c/0x70 [btrfs]
  free_space_test_bit+0xcd/0x140 [btrfs]
  modify_free_space_bitmap+0x27a/0x430 [btrfs]
  add_to_free_space_tree+0x8d/0x160 [btrfs]
  __btrfs_free_extent.isra.0+0xef1/0x13c0 [btrfs]
  __btrfs_run_delayed_refs+0x786/0x13c0 [btrfs]
  btrfs_run_delayed_refs+0x33/0x120 [btrfs]
  btrfs_commit_transaction+0xa2/0x1350 [btrfs]
  iterate_supers+0x77/0xe0
  ksys_sync+0x60/0xa0
  __do_sys_sync+0xa/0x20
  do_syscall_64+0x3f/0xf0
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
  </TASK>

[CAUSE]
The function extent_buffer_test_bit() is not larger folio compatible.

It still assume the old fixed page size, when an extent buffer with
large folio passed in, only eb->folios[0] is populated.

Then if the target bit range falls in the 2nd page of the folio, then we
would check eb->folios[1], and trigger the ASSERT().

[FIX]
Just migrate eb_bitmap_offset() to folio interfaces, using the
folio_size() to replace PAGE_SIZE.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 614d10655991..dfd9f2d6e3fe 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4466,22 +4466,22 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 }
 
 /*
- * Calculate the page and offset of the byte containing the given bit number.
+ * Calculate the folio and offset of the byte containing the given bit number.
  *
  * @eb:           the extent buffer
  * @start:        offset of the bitmap item in the extent buffer
  * @nr:           bit number
- * @page_index:   return index of the page in the extent buffer that contains
+ * @folio_index:  return index of the folio in the extent buffer that contains
  *                the given bit number
- * @page_offset:  return offset into the page given by page_index
+ * @folio_offset: return offset into the folio given by folio_index
  *
  * This helper hides the ugliness of finding the byte in an extent buffer which
  * contains a given bit.
  */
 static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 				    unsigned long start, unsigned long nr,
-				    unsigned long *page_index,
-				    size_t *page_offset)
+				    unsigned long *folio_index,
+				    size_t *folio_offset)
 {
 	size_t byte_offset = BIT_BYTE(nr);
 	size_t offset;
@@ -4491,10 +4491,10 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 	 * the bitmap item in the extent buffer + the offset of the byte in the
 	 * bitmap item.
 	 */
-	offset = start + offset_in_page(eb->start) + byte_offset;
+	offset = start + offset_in_folio(eb->folios[0], eb->start) + byte_offset;
 
-	*page_index = offset >> PAGE_SHIFT;
-	*page_offset = offset_in_page(offset);
+	*folio_index = offset >> folio_shift(eb->folios[0]);
+	*folio_offset = offset_in_folio(eb->folios[0], offset);
 }
 
 /*
@@ -4507,15 +4507,13 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr)
 {
-	u8 *kaddr;
-	struct page *page;
 	unsigned long i;
 	size_t offset;
+	u8 *kaddr;
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
-	page = folio_page(eb->folios[i], 0);
 	assert_eb_folio_uptodate(eb, i);
-	kaddr = page_address(page);
+	kaddr = folio_address(eb->folios[i]);
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
 
-- 
2.43.0


