Return-Path: <linux-btrfs+bounces-9503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410769C5097
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6587281F97
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4C20FAA0;
	Tue, 12 Nov 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TAdlGzZC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ocRz3DVN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727A1AB535
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400034; cv=none; b=Jnhq7qHuC8czOG23Dj7xxVTCc7aXWQaEsWG6BY8qP6IZ/DxvoYyAiqHaAZDS4RcNen0dhD+hEoMlEEKdluu/Rndh6lY+CtLUx6gYc92zUpzJfF8hP1c3q/ki2RGG0CmqAfSPFaEYrCHR2vLSZTA49we0BzjD/7lqmmOSb+3axNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400034; c=relaxed/simple;
	bh=jfWIJu6nc9EGFJl0zMubiPHeIleQwWMsJDN8Ef6kpEM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WK410mwqkNpa5I7sdTqYU1NxrDZy4ZZ0TeW6NSzGkC3u6E5hGUWuia8/Pi6jL6/QDfb1+2A9e7SLravt4ANloNPEZ0iC4oXZZpWDIMuLQNDEeyIqFlsn32L1kTHp9luR3y6bZvr6dyzpyFgvT1MvTbfvs0BdSV2CzvC6UvMqecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TAdlGzZC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ocRz3DVN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E60451F451
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731400030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XJXpC0MuN0NrMp59M/zd/x2Sj710qZ7NKLlKBxuMq7E=;
	b=TAdlGzZCJkashlQS1GzHOlFTuJwH2qd1drgbHV9W3/PZPpiwHrzq8tQvyqf218dD9kTcNN
	OOA8rtwLcLvXc28xd4vDLCiP+C5caaztuw9bAuGC5kuQjtgQzKRmjGZW4zcUrL2+FP1HWf
	XbQrNZw1OSDtCCu0a9KMM37Ick5OtG0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ocRz3DVN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731400029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XJXpC0MuN0NrMp59M/zd/x2Sj710qZ7NKLlKBxuMq7E=;
	b=ocRz3DVNYT11Joe9gYT9/jIJyEST+HltT/gQapBCM9XKGCMvam5nfvgRIRr8XXYCSqYgKo
	k5jXPink+a3MXLGkjX85xArEHrHFZP+7aZ6jnJmMTti0AWQSdTniHlEjR16oo6+Ij1iiJb
	6EUpQniwCydMuChEweoS/KxeD41b5x4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F0EF13301
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 08:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bsCfOFwRM2e5CAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 08:27:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reject out-of-band dirty folios during writeback
Date: Tue, 12 Nov 2024 18:56:51 +1030
Message-ID: <2bbe9b35968132d387379dd486da9b21d45e1889.1731399977.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E60451F451
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

An out-of-band folio means the folio is marked dirty but without
notifying the filesystem.

This used to be a problem related to get_user_page(), but with the
introduction of pin_user_pages_locked(), we should no longer hit such
case anymore.

In btrfs, we have a long history of handling such out-of-band dirty
folios by:

- Mark extent io tree EXTENT_DELALLOC during btrfs_dirty_folio()
  So that any buffered write into the page cache will have
  EXTENT_DEALLOC flag set for the corresponding range in btrfs' extent
  io tree.

- Marking the folio ordered during delalloc
  This is based on EXTENT_DELALLOC flag in the extent io tree.

- During folio submission for writeback check the ordered flag
  If the folio has no ordered folio, it means it doesn't go through
  the initial btrfs_dirty_folio(), thus it's definitely an out-of-band
  one.

  If we got one, we go through COW fixup, which will re-dirty the folio
  with proper handling in another workqueue.

Such workaround is a blockage for us to migrate to iomap (it requires
extra flags to trace if a folio is dirtied by the fs or not) and I'd
argue it's not data checksum safe, since the folio can be modified
halfway.

But with the introduction of pin_user_pages_locked() during v5.8 merge
window, such out-of-band dirty folio such be treated as a bug.
Ext4 has treated such case by warning and erroring out even before
pin_user_pages_locked().

Here we take one step between ext4 and the COW fixup workaround, that we
go the ext4 way (warning and error out) for experimental builds, so that
we can test if the no more out-of-band dirty folios expectation is true.

For non-experimental builds we still keep the existing COW fixup, but I
hope in several releases we can get rid of the COW fixup completely,
making it much easier to migrate to iomap.

The new checks happen in two locations:

- extent_writepage()
  If an out-of-band dirty folio is marked dirty, it may not even have
  page->private properly set.
  Reject it early here.

- btrfs_writepage_cow_fix()
  Error out with -EUCLEAN instead if we're sure it's an out-of-band one,
  and make the caller to check errors other than -EAGAIN.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 27 ++++++++++++++++++++++++++-
 fs/btrfs/inode.c     | 15 +++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e629d2ee152a..b8d2857f114b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1400,12 +1400,14 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
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
+		goto out;
 
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
@@ -1492,6 +1494,29 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * The proper bitmap can only be initialized until writepage_delalloc().
 	 */
 	bio_ctrl->submit_bitmap = (unsigned long)-1;
+	/*
+	 * If the page is dirty but without private set, it's marked dirty
+	 * without informing the fs.
+	 * Nowadays that is a bug, since the introduction of
+	 * pin_user_pages_locked().
+	 *
+	 * So here we check if the page has private set to rule out such
+	 * case.
+	 * But we also have a long history of relying on the COW fixup,
+	 * so here we only enable this check for experimental builds until
+	 * we're sure it's safe.
+	 */
+	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) && !folio_test_private(folio)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err_rl(fs_info,
+	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
+			     BTRFS_I(inode)->root->root_key.objectid,
+			     btrfs_ino(BTRFS_I(inode)),
+			     folio_pos(folio));
+		ret = -EUCLEAN;
+		goto done;
+	}
+
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto done;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 22b8e2764619..62bada0d6d62 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2832,6 +2832,21 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
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
2.47.0


