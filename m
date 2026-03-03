Return-Path: <linux-btrfs+bounces-22172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIyKHPqYpmltRgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22172-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:16:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A21EAABC
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50DE73013FC9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9EC382296;
	Tue,  3 Mar 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BvoIa7f9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BvoIa7f9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF763845C6
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525759; cv=none; b=B7gUYGCKH8MlC2UotcL1abhaEv5KAJamjdnH8OQ1UZJ3dKF5E4Ci8VX/mMFPKpxiI8OMtmQHoy1SJxNj+XW+d2c+WrNQAAnrILX3fVGY5U47SJTD1TUOVVbAuwCDtiiC66B7p11aG16N9amZOUy/GaUhQIskyq7rdDNk3yfn9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525759; c=relaxed/simple;
	bh=iIRl6fYRewQkQiDlEn5qArt3qFjxzWW6NerZTKBwHFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6aVp5zuJwTK1u4TaubtbC60T96/BLquQQNk+M9/scIqAxmXktpc0NBz9Y3j1JnJO/3+nKAfkWKzSJIvY0RmcyX5HZPVwHLW8++OKUkJJOqgJoAdriutbIFXr9fzROWHZ9ba5T6LbLlo+VCzW5q0jgiUxTJsEexmaW5frkCzoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BvoIa7f9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BvoIa7f9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74F485BDE9
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772525736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=It5biGGT6pPR0R8TFOmHj59yrkA4pKfneps3PAnn76w=;
	b=BvoIa7f9BDcn3GshJPPKbmCuUydluCjPLtivo1llevj/kS9P3hiul5j6/TAlOKi3HAhOox
	sI+RmFrVTpnClMCXHUxrtxDGBzEhIxfuWO5iNGqgpviuomBbYQC+3sIL0seKeO0FE5ICi0
	AeDw4RQVffoxVl5miKzgTtnJqTkZp8s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772525736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=It5biGGT6pPR0R8TFOmHj59yrkA4pKfneps3PAnn76w=;
	b=BvoIa7f9BDcn3GshJPPKbmCuUydluCjPLtivo1llevj/kS9P3hiul5j6/TAlOKi3HAhOox
	sI+RmFrVTpnClMCXHUxrtxDGBzEhIxfuWO5iNGqgpviuomBbYQC+3sIL0seKeO0FE5ICi0
	AeDw4RQVffoxVl5miKzgTtnJqTkZp8s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFB993EA69
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHRYHKeYpmmHeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 08:15:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: move the mapping_set_error() out of the loop in end_bbio_data_write()
Date: Tue,  3 Mar 2026 18:45:10 +1030
Message-ID: <3908171012ed88b5d1bff3c9d5c77a0a77965bd4.1772525669.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772525669.git.wqu@suse.com>
References: <cover.1772525669.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 768A21EAABC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22172-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Previously we have to call mapping_set_error() inside the
for_each_folio_all() loop, because we do not have a better way to grab
an inode, other than through folio->mapping.

But nowadays every btrfs_bio has its inode member populated, thus we can
easily grab the inode and its i_mapping easily, without the help from a
folio.

Now we can move that mapping_set_error() out of the loop, and use
bbio->inode to grab the i_mapping.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index de6e25475ce1..f972c1580374 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -529,14 +529,14 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		u32 len = fi.length;
 
 		bio_size += len;
-		if (error)
-			mapping_set_error(folio->mapping, error);
-
 		ASSERT(btrfs_folio_test_ordered(fs_info, folio, start, len));
 		btrfs_folio_clear_ordered(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
 
+	if (error)
+		mapping_set_error(bbio->inode->vfs_inode.i_mapping, error);
+
 	btrfs_finish_ordered_extent(bbio->ordered, bbio->file_offset, bio_size, !error);
 	bio_put(bio);
 }
-- 
2.53.0


