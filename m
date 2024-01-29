Return-Path: <linux-btrfs+bounces-1891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D6840201
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A591C215E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36256461;
	Mon, 29 Jan 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k+nMGYjt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k+nMGYjt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AD55E6B
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521599; cv=none; b=OI4KL9YVWJ3l4lbArabuckXNM1UGQt+7uaAWEO2nejRK9LvdvDquJg2vYHpiQpbe9hJ1KWLSL2Ue4+ySiYpvPwBIaar3O1VBd0k/Ja4L+NDnAQUHoJxmxGbSVZJMCMCgVNJbrXCEQ3Eptnn0F4RPQ4WaHxV420MbGfztkyX8tEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521599; c=relaxed/simple;
	bh=gLgocXNfF+p613ht/tWfyxleOyy/6to3p/zSpkt4kug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxiANUB9NLuEDgVCUM7DyDxAPfCetVru2IWEyGdfWOItsqbbZ1Than+mZ2d2h0qTYGL/f0gGkRA7TrW3VFnMt0CZy+vdXlEhcJy/3LQ97r/ThVozuHNaMS4zbeO9biaY0ciN/5y3IMXIR/7+COmzKCeeJLau9HvWSEW1lTbpgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k+nMGYjt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k+nMGYjt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5773E1F7D8
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUWryewhv1pYLIKP1/DtC8QWPeUgqOJxcrzKrSW0rUI=;
	b=k+nMGYjtUdPObB23ReOBDuvW5fEB9KS3gvaXVs8nQL3wpdJNf7DJREMA6hLenZLQnwmo0b
	3CXIqWCtNw5XPAqmD21FVT3iLFDCMFeWmU8BAzmUCL1qNn1VvcXjT0WENI9kp3Ga2dz2bd
	vRIyXS0PFRsfA7VigxXhziRUk/MhcTU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUWryewhv1pYLIKP1/DtC8QWPeUgqOJxcrzKrSW0rUI=;
	b=k+nMGYjtUdPObB23ReOBDuvW5fEB9KS3gvaXVs8nQL3wpdJNf7DJREMA6hLenZLQnwmo0b
	3CXIqWCtNw5XPAqmD21FVT3iLFDCMFeWmU8BAzmUCL1qNn1VvcXjT0WENI9kp3Ga2dz2bd
	vRIyXS0PFRsfA7VigxXhziRUk/MhcTU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9748713911
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CNDeFvtzt2W/RwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: introduce btrfs_alloc_folio_array()
Date: Mon, 29 Jan 2024 20:16:10 +1030
Message-ID: <593b5d58ad0fb8c79a6db3af0c1f0022e5ad4a90.1706521511.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706521511.git.wqu@suse.com>
References: <cover.1706521511.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=k+nMGYjt
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
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
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 5773E1F7D8
X-Spam-Flag: NO

The new helper would do the same thing as btrfs_alloc_page_array(), but
with folios.

One extra difference is, there is no extra helper for bulk allocation,
thus it may not be as efficient as the page version.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 31 +++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8648ea9b5fb5..f0ccf3b546df 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -667,6 +667,37 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 	bio_put(bio);
 }
 
+/*
+ * Populate every free slot in a provided array with folios.
+ *
+ * @nr_folios:   number of foliosto allocate
+ * @folio_array: the array to fill with folios; any existing non-null entries in
+ *		 the array will be skipped
+ * @extra_gfp:	 the extra GFP flags for the allocation.
+ *
+ * Return: 0        if all folios were able to be allocated;
+ *         -ENOMEM  otherwise, the partially allocated folios would be freed and
+ *                  the array slots zeroed
+ */
+int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array,
+			    gfp_t extra_gfp)
+{
+	for (int i = 0; i < nr_folios; i++) {
+		if (folio_array[i])
+			continue;
+		folio_array[i] = folio_alloc(GFP_NOFS | extra_gfp, 0);
+		if (!folio_array[i])
+			goto error;
+	}
+	return 0;
+error:
+	for (int i = 0; i < nr_folios; i++) {
+		if (folio_array[i])
+			folio_put(folio_array[i]);
+	}
+	return -ENOMEM;
+}
+
 /*
  * Populate every free slot in a provided array with pages.
  *
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4437607f2b06..992a9044fa24 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -346,6 +346,8 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   gfp_t extra_gfp);
+int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array,
+			    gfp_t extra_gfp);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
-- 
2.43.0


