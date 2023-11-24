Return-Path: <linux-btrfs+bounces-337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617907F6B5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 05:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921D11C20C79
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 04:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9E944F;
	Fri, 24 Nov 2023 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 20:30:07 PST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A6F11F
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Nov 2023 20:30:07 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A483921AF4
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 04:24:14 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BA62132E2
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 04:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id i1AvEm0lYGV+GgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 04:24:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: free the allocated memory if btrfs_alloc_page_array() failed
Date: Fri, 24 Nov 2023 14:53:50 +1030
Message-ID: <0f34dd9fbefc379a65fe09074f975a199352d99e.1700796515.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++
X-Spam-Score: 16.64
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: A483921AF4
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out1.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com
X-Spamd-Result: default: False [16.64 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 NEURAL_SPAM_SHORT(1.64)[0.546];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

[BUG]
If btrfs_alloc_page_array() failed to allocate all pages but part of the
slots, then the partially allocated pages would be leaked in function
btrfs_submit_compressed_read().

[CAUSE]
As explicitly stated, if btrfs_alloc_page_array() returned -ENOMEM,
caller is responsible to free the partially allocated pages.

For the existing call sites, most of them are fine:

- btrfs_raid_bio::stripe_pages
  Handled by free_raid_bio().

- extent_buffer::pages[]
  Handled btrfs_release_extent_buffer_pages().

- scrub_stripe::pages[]
  Handled by release_scrub_stripe().

But there is one exception in btrfs_submit_compressed_read(), if
btrfs_alloc_page_array() failed, we didn't cleanup the array and freed
the array pointer directly.

Initially there is still the error handling in commit dd137dd1f2d7
("btrfs: factor out allocating an array of pages"), but later in commit
544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio"),
the error handling is removed, leading to the possible memory leak.

[FIX]
This patch would add back the error handling first, then to prevent such
situation from happening again, also make btrfs_alloc_page_array() to
free the allocated pages as a extra safe net.

Fixes: 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  4 ++++
 fs/btrfs/extent_io.c   | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 19b22b4653c8..d6120741774b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -534,6 +534,10 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	return;
 
 out_free_compressed_pages:
+	for (int i = 0; i < cb->nr_pages; i++) {
+		if (cb->compressed_pages[i])
+			__free_page(cb->compressed_pages[i]);
+	}
 	kfree(cb->compressed_pages);
 out_free_bio:
 	bio_put(&cb->bbio.bio);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0ea65f248c15..e2c0c596bd46 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -676,8 +676,7 @@ static void end_bio_extent_readpage(struct btrfs_bio *bbio)
  * 		the array will be skipped
  *
  * Return: 0        if all pages were able to be allocated;
- *         -ENOMEM  otherwise, and the caller is responsible for freeing all
- *                  non-null page pointers in the array.
+ *         -ENOMEM  otherwise, and the partially allocated pages would be freed.
  */
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 {
@@ -696,8 +695,13 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 		 * though alloc_pages_bulk_array() falls back to alloc_page()
 		 * if  it could not bulk-allocate. So we must be out of memory.
 		 */
-		if (allocated == last)
+		if (allocated == last) {
+			for (int i = 0; i < allocated; i++) {
+				__free_page(page_array[i]);
+				page_array[i] = NULL;
+			}
 			return -ENOMEM;
+		}
 
 		memalloc_retry_wait(GFP_NOFS);
 	}
-- 
2.42.1


