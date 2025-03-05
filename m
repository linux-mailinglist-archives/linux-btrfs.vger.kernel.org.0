Return-Path: <linux-btrfs+bounces-12007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF8A4F551
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 04:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA8B1890433
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 03:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A015FA7B;
	Wed,  5 Mar 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MX2CJyIz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MX2CJyIz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4B2E3383
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144930; cv=none; b=KRrP5BlGQUVzduo5xQbEBmB/XKANQSRG01P9VCwX1yW0Myvd86hyQdkHUCX9VasorEPXviTOSLazOGGR6W5IkR4xLfQkyu4OADS1cBMD9gQf0HZRnLscHe1bRp/dj/QrvDhTstEDsUYrUy7MarFJn580i3kLlLxMiAGMVXq3XYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144930; c=relaxed/simple;
	bh=81vmAY2OU130+arjXL0s7oBm0oBjbXx6m+tgjijnzVw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n569ArsIEY2SmA3tDlnyNzu+zB/pG5fVYRJWA0H3fWNgIHBIW82pJMscJtV0c99StHP+M19DLd2BgxnXI3PiNc/eSGujGTPyN1mLO2Ve36S+Lg0n2gyQMbEb8vytkSzb20FVspdMSmN8Aji9bU3kIzMR+JTJAJsrJjF7G0woyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MX2CJyIz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MX2CJyIz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84EE3211A3
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 03:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741144926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wfCbaUiRE9tgpntLKxm14ZjrP4cZKfgQbNBJ3AY/hsM=;
	b=MX2CJyIzErgK972S8XGStjo1eri2bAKpFDGk/xHagu8O0pV7oHd8PScX+d8cVtDyFsovdd
	v+n8bo3ULclcRs0E09ga0H/3u16Hs54QR17tG1Lj7cQs+9P7UYMNE+HwY57ME2BN16ILWb
	6m0KdFHgDV8E3kdKP0fpt69XDNcC3Kc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MX2CJyIz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741144926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wfCbaUiRE9tgpntLKxm14ZjrP4cZKfgQbNBJ3AY/hsM=;
	b=MX2CJyIzErgK972S8XGStjo1eri2bAKpFDGk/xHagu8O0pV7oHd8PScX+d8cVtDyFsovdd
	v+n8bo3ULclcRs0E09ga0H/3u16Hs54QR17tG1Lj7cQs+9P7UYMNE+HwY57ME2BN16ILWb
	6m0KdFHgDV8E3kdKP0fpt69XDNcC3Kc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95ABB13939
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 03:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xlgtEl3Dx2e0CwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 05 Mar 2025 03:22:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: reject out-of-band dirty folios during writeback
Date: Wed,  5 Mar 2025 13:51:39 +1030
Message-ID: <7026d8edc3d1ea5b0ef7307298149d06210807ce.1741144890.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 84EE3211A3
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[OUT-OF-BAND DIRTY FOLIOS]
An out-of-band folio means the folio is marked dirty but without
notifying the filesystem.

This can lead to various problems, not limited to:

- No folio::private to track per block status

- No proper space reserved for such a dirty folio

[HISTORY IN BTRFS]
This used to be a problem related to get_user_page(), but with the
introduction of pin_user_pages*(), we should no longer hit such
case anymore.

In btrfs, we have a long history of catching such out-of-band dirty
folios by:

- Mark the folio ordered during delayed allocation

- Check the folio ordered flag during writeback
  If the folio has no ordered flag, it means it doesn't go through
  delayed allocation, thus it's definitely an out-of-band
  one.

  If we got one, we go through COW fixup, which will re-dirty the folio
  with proper handling in another workqueue.

[PROBLEMS OF COW-FIXUP]
Such workaround is a blockage for us to migrate to iomap (it requires
extra flags to trace if a folio is dirtied by the fs or not) and I'd
argue it's not data checksum safe, since if a folio can be marked dirty
without informing the fs, the content can also change at any time.

But with the introduction of pin_user_pages*() during v5.8 merge
window, such out-of-band dirty folio such be treated as a bug.
Ext4 has treated such case by warning and erroring out even before
pin_user_pages*().

Furthermore, there are already proofs that such folio ordered flag
tracking can be screwed up by incorrect error handling, check the commit
messages of the following commits:

 06f364284794 ("btrfs: do proper folio cleanup when cow_file_range() failed")
 c2b47df81c8e ("btrfs: do proper folio cleanup when run_delalloc_nocow() failed")

[FIXES]
Unlike btrfs, ext4 and xfs (iomap) never bother handling such
out-of-band dirty folios.

- Ext4 just warns and errors out
- Iomap always follows the folio/block dirty flags

And there is nothing really COW specific, xfs also supports COW too.

Here we take one step towards ext4 by doing warning and erroring out.
But since the cow fixup thing is introduced from the beginning, we keep
the old behavior for non-experimental builds, and only do the new warning
for experimental builds before we're 100% sure and remove cow fixup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Rebased to the latest for-next
- Slightly change the commit message
  To mention that bugs in error handling can lead to false COW fixup
  routine.
---
 fs/btrfs/extent_io.c | 28 +++++++++++++++++++++++++++-
 fs/btrfs/inode.c     | 15 +++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 57906c226220..365be9eb4e04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1624,12 +1624,14 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	       start + len <= folio_start + folio_size(folio));
 
 	ret = btrfs_writepage_cow_fixup(folio);
-	if (ret) {
+	if (ret == -EAGAIN) {
 		/* Fixup worker will requeue */
 		folio_redirty_for_writepage(bio_ctrl->wbc, folio);
 		folio_unlock(folio);
 		return 1;
 	}
+	if (ret < 0)
+		return ret;
 
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
@@ -1734,6 +1736,30 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * The proper bitmap can only be initialized until writepage_delalloc().
 	 */
 	bio_ctrl->submit_bitmap = (unsigned long)-1;
+
+	/*
+	 * If the page is dirty but without private set, it's marked dirty
+	 * without informing the fs.
+	 * Nowadays that is a bug, since the introduction of
+	 * pin_user_pages*().
+	 *
+	 * So here we check if the page has private set to rule out such
+	 * case.
+	 * But we also have a long history of relying on the COW fixup,
+	 * so here we only enable this check for experimental builds until
+	 * we're sure it's safe.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) &&
+	    unlikely(!folio_test_private(folio))) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err_rl(fs_info,
+	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
+			     inode->root->root_key.objectid,
+			     btrfs_ino(inode), folio_pos(folio));
+		ret = -EUCLEAN;
+		goto done;
+	}
+
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto done;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f9bd9242acd3..467550c477d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2890,6 +2890,21 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
 	if (folio_test_ordered(folio))
 		return 0;
 
+	/*
+	 * For experimental build, we error out instead of EAGAIN.
+	 *
+	 * We should not hit such out-of-band dirty folios anymore.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err_rl(fs_info,
+	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
+			     BTRFS_I(inode)->root->root_key.objectid,
+			     btrfs_ino(BTRFS_I(inode)),
+			     folio_pos(folio));
+		return -EUCLEAN;
+	}
+
 	/*
 	 * folio_checked is set below when we create a fixup worker for this
 	 * folio, don't try to create another one if we're already
-- 
2.48.1


