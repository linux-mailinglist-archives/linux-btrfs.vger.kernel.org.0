Return-Path: <linux-btrfs+bounces-22093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPt4Odg1omnR0wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22093-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 01:24:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4891BF671
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 01:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E569312ECC0
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 00:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853262367B3;
	Sat, 28 Feb 2026 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JB5ybuth";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JB5ybuth"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4E368978
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238227; cv=none; b=UIW0XNsCiOB8HFr8vunGP0AoyfDzcc1sO15ZvSu42foPkbmyzcDW95gGtD7ByZX+dNB1oxEECxkQGt4OZ7MdDLYn5yo6xLR4xkBYx0SUehMMzrq2TAZni83Fc6g84pQPVdPCaVx05KPZlN0V/IwcLlUc9N4aj1jfuLocC/U+BPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238227; c=relaxed/simple;
	bh=cZCS8BT7XNVeeJWn7YZqIPhb3zNqi+p/iL11W9JeWls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTm9cU/FIOmsH4RaJrlylcv7wV4GvTihqhUfuOkfzFimRtgjFR8PfNLnvep0Vo1F+WgJKlspbnsS8IORIHk2u2N54yIP9NeG8H8EvK9fMhQ7jyx6ZuxHZaxaYQi+AQmvrpUgQDfhyMhn4yKdWbu0WExRt4EtCQWNy5Db6BYVtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JB5ybuth; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JB5ybuth; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEC3B3F9D7
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772238213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXau/kbwV1s0S2blNNbwfkNGwTK8At4ywRuGmMZBjS8=;
	b=JB5ybuthEX6g7WnxW5dMTV6gnqJcjJ04beyMIPptOhPh3+e4TjMNTqM/Kwc2zDpyxsACDz
	JZGI8NqzntTjRHbVOLG3mx9/4FiNe2hdjdyMVqp9ycUaf+6cO218ZpCft2+EKc7pPYmTVe
	s+MJTBf9gqE0RZiDdazrBuRIVu6AnPU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772238213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXau/kbwV1s0S2blNNbwfkNGwTK8At4ywRuGmMZBjS8=;
	b=JB5ybuthEX6g7WnxW5dMTV6gnqJcjJ04beyMIPptOhPh3+e4TjMNTqM/Kwc2zDpyxsACDz
	JZGI8NqzntTjRHbVOLG3mx9/4FiNe2hdjdyMVqp9ycUaf+6cO218ZpCft2+EKc7pPYmTVe
	s+MJTBf9gqE0RZiDdazrBuRIVu6AnPU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0452F3EA65
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ACgJLoQ1omkgbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix the incorrect freeing of a compression folio in btrfs_do_encoded_write()
Date: Sat, 28 Feb 2026 10:53:12 +1030
Message-ID: <c0d3e985e4fc4fe583e9fbe0d68b4f4a0659071b.1772238005.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772238005.git.wqu@suse.com>
References: <cover.1772238005.git.wqu@suse.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22093-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E4891BF671
X-Rspamd-Action: no action

[BUG]
Commit e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage for
encoded writes") changed how we allocate folios for encoded writes.

Previously we allocate an array of folios for the encoded write.
But now we require all folios to be allocated and freed by
btrfs_alloc_compr_folios() and btrfs_free_compr_folios() to use the
cached folio pool.

Unfortunately we only use btrfs_alloc_compr_folio() but not pairing it
with btrfs_free_compr_folio().

This can lead to problems as a compr folio has maintained its own RCU
list, not releasing it from the RCU list can lead to various problems.

[FIX]
Use btrfs_free_compr_folio() to replace the regular folio_put() call.

Fixes: e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage for encoded writes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ea3746c14760..8702247e4db0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9989,7 +9989,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = copy_from_iter(kaddr, bytes, from);
 		kunmap_local(kaddr);
 		if (ret != bytes) {
-			folio_put(folio);
+			btrfs_free_compr_folio(folio);
 			ret = -EFAULT;
 			goto out_cb;
 		}
@@ -9997,7 +9997,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			folio_zero_range(folio, bytes, round_up(bytes, blocksize) - bytes);
 		ret = bio_add_folio(&cb->bbio.bio, folio, round_up(bytes, blocksize), 0);
 		if (unlikely(!ret)) {
-			folio_put(folio);
+			btrfs_free_compr_folio(folio);
 			ret = -EINVAL;
 			goto out_cb;
 		}
-- 
2.53.0


