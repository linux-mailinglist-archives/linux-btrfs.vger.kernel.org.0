Return-Path: <linux-btrfs+bounces-1293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E36882673B
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 03:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3281B1C213CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 02:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8410F5;
	Mon,  8 Jan 2024 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eJOEr19S";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eJOEr19S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B3EC3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6391821F78
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 02:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704679268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iodTXAIHadCyFsl1/cOvD3KkkT/ZOI2y+0GOIZ5kinQ=;
	b=eJOEr19S1ea4oFFiUaC6v6y1gJogtxs+KvtSq3UDvoQYXf2j1f67A2VMucI0mS/qjx9z0X
	5c032Bo2VXC45zoIGcsYYu12NH6uL1lzhtU6iaoAlIW68nJbdtR7YJ91BCtdg6q1PZ8/q+
	SvV/7WfC0yyisusPGeBuRhPj790Ab+c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704679268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iodTXAIHadCyFsl1/cOvD3KkkT/ZOI2y+0GOIZ5kinQ=;
	b=eJOEr19S1ea4oFFiUaC6v6y1gJogtxs+KvtSq3UDvoQYXf2j1f67A2VMucI0mS/qjx9z0X
	5c032Bo2VXC45zoIGcsYYu12NH6uL1lzhtU6iaoAlIW68nJbdtR7YJ91BCtdg6q1PZ8/q+
	SvV/7WfC0yyisusPGeBuRhPj790Ab+c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B329713695
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 02:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EDECDWFXm2U2LAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 02:01:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove unused variable bio_offset from end_bbio_data_read()
Date: Mon,  8 Jan 2024 12:30:44 +1030
Message-ID: <69c652507c19ec6bff940dc1da1fe2b847cf9d24.1704679242.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eJOEr19S
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
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
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 1.49
X-Rspamd-Queue-Id: 6391821F78
X-Spam-Flag: NO

The variable @bio_offset is introduced in commit 7ffd27e378d2 ("btrfs:
pass bio_offset to check_data_csum() directly"), when we are still using
the same endio function for both data and metadata.

Later we have several changes to data and metadata endio functions:

- Data verification is handled by btrfs bio layer

- Split data and metadata endio paths

Now for data path we no longer do any verification in
end_bbio_data_read(), as the verification is handled by btrfs bio layer
already.

Thus there is no need for such bio_offset variable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 635d3ae32d08..22946e849d28 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -596,11 +596,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 	struct bio *bio = &bbio->bio;
 	struct processed_extent processed = { 0 };
 	struct folio_iter fi;
-	/*
-	 * The offset to the beginning of a bio, since one bio can never be
-	 * larger than UINT_MAX, u32 here is enough.
-	 */
-	u32 bio_offset = 0;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_folio_all(fi, &bbio->bio) {
@@ -667,10 +662,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		end_page_read(folio_page(folio, 0), uptodate, start, len);
 		endio_readpage_release_extent(&processed, BTRFS_I(inode),
 					      start, end, uptodate);
-
-		ASSERT(bio_offset + len > bio_offset);
-		bio_offset += len;
-
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-- 
2.43.0


