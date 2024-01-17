Return-Path: <linux-btrfs+bounces-1496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000D82FE03
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 01:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA68288D1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293AB79DC;
	Wed, 17 Jan 2024 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vtzsj/sj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vtzsj/sj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908116AD6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705451576; cv=none; b=W1BPHSJvWYkw8fNsOhpd0Eb8TZBpn6ZS6yzRLgDTHUn9JjygFuoG0iLBo9tLuQv7HeRPbkq6bFfBONJGVeKLqyfdbScVBNScm0+MiZ/yy2vwDPs1KTbGn4MMKl2SEC0YswYLm592zz0JD+Djy7RjEONjahz+NmxffIVFxT0PPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705451576; c=relaxed/simple;
	bh=iKyl3z7/7bbOheLCAuuTOAl09q/P36DxaXGif3z0YvU=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Spam-Level:X-Spamd-Bar:
	 X-Rspamd-Server:X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:
	 X-Spam-Flag; b=KNZ/UVBsr731GJCbxYEhl6aeya7KXYKnLt7FS1mkdNE/Tfn7Tsl8PDgDDCygpfnK4yjhniAM887JNtBpVjUowCSl+wMDTpYuEKjh8sLZFtLWSsuIGahZ3GURHV0f3fl0ZgKOxAGp6ZxIQuhVg8FK7RqOsQq2Ax1wKS0uwEYmdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vtzsj/sj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vtzsj/sj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B42711FBB6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705451572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw7CAt+Q4w2uvn7ttHIQGWfz0zu1dNCJCf/gO6d4Ews=;
	b=Vtzsj/sj5qrgxrSQ2O6hbXoq1GMKELb9UaYLMJVu4DJP+KCfqKE1FkRpRZwxvKurPvlq56
	9+cS/PmimburLdQYM0ViwEya59BnGqmPp8fIPhfKcRBbkrs2MMOQgepEM98QnXOjkXyMRt
	kbBkzmJTTU8fak/a+InrBBnuuPy5pVg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705451572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw7CAt+Q4w2uvn7ttHIQGWfz0zu1dNCJCf/gO6d4Ews=;
	b=Vtzsj/sj5qrgxrSQ2O6hbXoq1GMKELb9UaYLMJVu4DJP+KCfqKE1FkRpRZwxvKurPvlq56
	9+cS/PmimburLdQYM0ViwEya59BnGqmPp8fIPhfKcRBbkrs2MMOQgepEM98QnXOjkXyMRt
	kbBkzmJTTU8fak/a+InrBBnuuPy5pVg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C110013751
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +BV8IDMgp2W0GgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: scrub: limit RST scrub to chunk boundary
Date: Wed, 17 Jan 2024 11:02:26 +1030
Message-ID: <46320cbeb3274ad3cca6db03c03e063fc3047732.1705449249.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705449249.git.wqu@suse.com>
References: <cover.1705449249.git.wqu@suse.com>
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
	dkim=pass header.d=suse.com header.s=susede1 header.b="Vtzsj/sj"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.05%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: B42711FBB6
X-Spam-Flag: NO

[BUG]
If there is an extent beyond chunk boundary, currently RST scrub would
error out.

[CAUSE]
In scrub_submit_extent_sector_read(), we completely rely on
extent_sector_bitmap, which is populated using extent tree.

The extent tree can be corrupted that there is an extent item beyond a
chunk.

In that case, RST scrub would fail and error out.

[FIX]
Despite the extent_sector_bitmap usage, also limit the read to chunk
boundary.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2d81b1a18a04..0123d2728923 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1646,6 +1646,9 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
+	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
+				      stripe->bg->length - stripe->logical) >>
+				  fs_info->sectorsize_bits;
 	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
@@ -1656,6 +1659,10 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 		struct page *page = scrub_stripe_get_page(stripe, i);
 		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, i);
 
+		/* We're beyond the chunk boundary, no need to read anymore. */
+		if (i >= nr_sectors)
+			break;
+
 		/* The current sector cannot be merged, submit the bio. */
 		if (bbio &&
 		    ((i > 0 &&
-- 
2.43.0


