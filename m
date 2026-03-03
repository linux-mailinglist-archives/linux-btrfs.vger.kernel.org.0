Return-Path: <linux-btrfs+bounces-22171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rZ5zIo+ZpmnfRgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22171-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:19:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF2B1EAB00
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 336B63009F8C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EB031F98F;
	Tue,  3 Mar 2026 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dn4r9Ip1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dn4r9Ip1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5E1E1E16
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525745; cv=none; b=mOI98mHkzQOkOpHwfD0pTMzmymQFB6ryia9OAtwq9gXFgDJpZ5sOm6pbcHcSBIpUXLalQ+c1ejvZuTIpP2WDTC/D+YjihsuQ1A/rF3YE9ApIktg73JR0KNeSFnRDqNs+XJ8k+/1cFFa4HI1nUO7JI1TXvinFUL9M1lqqcMU6FTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525745; c=relaxed/simple;
	bh=ZFQZ0yzPAsa0h7Y+cudfxmFEdz5cLphW1ngK7u7hKU8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5y1KaKcIj6jp0ZM2fcZvRteiSLqOMAwf6HC3Ct5ffbjeBeDD6NegjQlig55LotsvrznEecAQ9EWlenMbbB+bW0bddYhn8Fpyd7k16N+J94DChpcnn9YDfMNhRxXWOnkapHQ4rjFClLI50EPhdOXbFVsB6jJTKkYY+i2zX1IqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dn4r9Ip1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dn4r9Ip1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C2A13E84B
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772525735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HE9JWOKPf58kq7XIYD8aLGWnS/OIndOg/6bOMniK4E=;
	b=Dn4r9Ip1FPfvH9Y+COaid8eCl1pa4Stone8Q8idJ+bty4+ZW7CQawXEDdfOC9DZRjUcHk7
	IggHw1QB1ld75uByg8alvUr9OrQMjnyVp1p1rEfo/m9f8/ZYZz8SLtUscOgjFCqlrgd1nO
	6lQTMp3FlQwLDNzuL86e5zzeUXqVMkc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772525735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HE9JWOKPf58kq7XIYD8aLGWnS/OIndOg/6bOMniK4E=;
	b=Dn4r9Ip1FPfvH9Y+COaid8eCl1pa4Stone8Q8idJ+bty4+ZW7CQawXEDdfOC9DZRjUcHk7
	IggHw1QB1ld75uByg8alvUr9OrQMjnyVp1p1rEfo/m9f8/ZYZz8SLtUscOgjFCqlrgd1nO
	6lQTMp3FlQwLDNzuL86e5zzeUXqVMkc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78D983EA69
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 08:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WBLmDqaYpmmHeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 08:15:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: remove the alignment check in end_bbio_data_write()
Date: Tue,  3 Mar 2026 18:45:09 +1030
Message-ID: <51818a7c1233086fe42a3e7a18cf6a144ef14513.1772525669.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: EDF2B1EAB00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22171-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The check is not necessary because:

- There is already assert_bbio_alignment() at btrfs_submit_bbio()

- There is also btrfs_subpage_assert() for all btrfs_folio_*() helpers

- No similar check in all other endio functions
  No matter if it's data read, compressed read or write.

- There is no such report for very long
  I do not even remember if there is any such report.

Thus the need to do such check in end_bbio_data_write() is very weak,
and we can just get rid of it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 33b1afbee0a6..de6e25475ce1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -520,7 +520,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 	struct bio *bio = &bbio->bio;
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
-	const u32 sectorsize = fs_info->sectorsize;
 	u32 bio_size = 0;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -530,16 +529,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		u32 len = fi.length;
 
 		bio_size += len;
-		/* Our read/write should always be sector aligned. */
-		if (!IS_ALIGNED(fi.offset, sectorsize))
-			btrfs_err(fs_info,
-		"partial page write in btrfs with offset %zu and length %zu",
-				  fi.offset, fi.length);
-		else if (!IS_ALIGNED(fi.length, sectorsize))
-			btrfs_info(fs_info,
-		"incomplete page write with offset %zu and length %zu",
-				   fi.offset, fi.length);
-
 		if (error)
 			mapping_set_error(folio->mapping, error);
 
-- 
2.53.0


