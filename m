Return-Path: <linux-btrfs+bounces-7905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA99972BAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59891289F31
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57AF189B9D;
	Tue, 10 Sep 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C6OgMBcA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C6OgMBcA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DE1891BA
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955670; cv=none; b=N+8Au4jO/IMAbXLxJq48SApDvmjYDZvRMfSRBxHJTBUn6r7oH20Zzlf3HMfCqvKA8htX/qkuuwra/ZmlPGiRkfkvdpUEQSRxOgmqXWtVYtJZtg7zmP2HtwBq7ZsZbiKetv4o9rVVjjbp2+/7q6Okrhn2Ef0qQ07ZSM3swfDIeBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955670; c=relaxed/simple;
	bh=a/jpys+dP4B43RAUHBLhkrH9AWaxGjmsLZZ8FxceeVU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q7DKvkgaLvTC796yH1282gt4IALPne25q8WVE3QvbOVXDERfZVXNDf9M/iC7XSXLnqIp1LhxZXnssvmEDXchAiXWRCDuqcK4ZrQ1+A5A0QBDXBf564/lXYUk/iuR/77A+qYqmVCtzJBGCCZf6hGpMvEecxoPypMjnMIpCfBxHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C6OgMBcA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C6OgMBcA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 352F61F454
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 08:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725955667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f4/Qy0qnmFD577meT60q02pHDmeEKxCu6pmC6+HXlPw=;
	b=C6OgMBcAoRWN7JYgJ3TJ41Tfja/LIYCAco06Zqg3TOu1sShv49+O8PC2r+gtk/Ts1zeXKA
	0wfOIyfO6Ul+Dnp0KrO7EeB0LhNEg50mjAPE2P+TBXbXhpOcefG6xgBHQrrU5/0AR6TwcQ
	+JFQeW5Znrh7ZnYJs3Abnqb7AWXOp54=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=C6OgMBcA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725955667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f4/Qy0qnmFD577meT60q02pHDmeEKxCu6pmC6+HXlPw=;
	b=C6OgMBcAoRWN7JYgJ3TJ41Tfja/LIYCAco06Zqg3TOu1sShv49+O8PC2r+gtk/Ts1zeXKA
	0wfOIyfO6Ul+Dnp0KrO7EeB0LhNEg50mjAPE2P+TBXbXhpOcefG6xgBHQrrU5/0AR6TwcQ
	+JFQeW5Znrh7ZnYJs3Abnqb7AWXOp54=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64ACF132CB
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 08:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0sr3CFL+32Y5MwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 08:07:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make extent_range_clear_diryt_for_io() to handle sector size < page size cases
Date: Tue, 10 Sep 2024 17:37:28 +0930
Message-ID: <6a5d4240e53b55381d3049f6051d10323d356e95.1725955565.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 352F61F454
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
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

For btrfs with sector size < page size (e.g. 4K sector size, 64K page
size), and enable the sector perfect compression support, then the
following dirty range can lead to problems:

   0     32K     64K     96K    128K
   |     |///////||//////|    |/|
                              124K

In above case, if we start writeback for that inode, the last dirty
range [124K, 128K) will not be submitted and cause reserved space
leakage:

- Start writeback for page 0
  We find the range [32K, 96K) is suitable for compression, and queue it
  into a workqueue to do the delayed compression and submission.

- Compression happens for range [32K, 96K)
  Function extent_range_clear_diryt_for_io() is called, however it is
  only doing full page handling, not considering any the extra bitmaps
  for subpage cases.

  That function will clear page dirty for both page 0 and page 64K.

- Writeback for the inode is done
  Because page 64K has its dirty flag cleared, it will not be considered
  as a writeback target.

This means the range [124K, 128K) will not be submitted, and reserved
space for it will be leaked.

Fix this problem by using the subpage helper to clear the dirty flag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The previous version seems to causing a hang, but it looks very possible
that's caused by the double page freeing at the same kernel window.

With that double page freeing fix, I haven't hit any lockup on subpage
cases with this patch applied anymore.
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index edac499fd83d..d53b9e4ca13e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -902,7 +902,8 @@ static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 e
 				ret = PTR_ERR(folio);
 			continue;
 		}
-		folio_clear_dirty_for_io(folio);
+		btrfs_folio_clamp_clear_dirty(inode_to_fs_info(inode), folio, start,
+					      end + 1 - start);
 		folio_put(folio);
 	}
 	return ret;
-- 
2.46.0


