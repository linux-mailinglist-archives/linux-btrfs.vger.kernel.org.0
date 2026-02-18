Return-Path: <linux-btrfs+bounces-21743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPg/LaCPlWl7SQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21743-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:08:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5951551C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CC5D3036064
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF9F33C51D;
	Wed, 18 Feb 2026 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s6CRKeHj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s6CRKeHj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F3324B0C
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409192; cv=none; b=HeXP9FCB3G6wPPi6FccxmsWwA995OWRm5HD5lfL77wD82a7dXfHfAZ4OGzugzAoGiIhWnBM0moqzmnPpESCidUZ9v7/cJIMLsCWFlYtQpCrQwTtpvhr1hWFtZ8FPfp3010WAuFbMMM/GxCE9MiaRLH5r2LKX0gpdHTb01F4qaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409192; c=relaxed/simple;
	bh=bBiZcgheKI7cKQSRdp9GMFl54X41ex+JiGFIeq1Uc9g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw57YROswRnMyP4OhOS9qCY26SIbV/LtxEOUGNJEPktmuN6L2qZK2YI/9xyCVCREEdKdBJJW/gqHJum1SF+RZIFSDjcqcn9SBj8YW3pBDXWg+VPQSJE3thLp8eEVloVJ3ox0jGYyvOtLRHEefzecSsOXLQT4grg26Q3sDZY1RC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s6CRKeHj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s6CRKeHj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 621313E6D9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771409184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF5ekqjNuM/ezoLCfqRuAS33AdTNqJOPT2shOtfQigo=;
	b=s6CRKeHjbn03jyPlCF3LDsGeaqsmCi+hpEDg2wQzm19YppQjAFgJwU91/GDUlOIwVZbTYg
	xaBmwS9j3M1cVSNdLLS6ijaQOJgXRK+oGft43HIF8IPuPQw26HdGFjoiM10zJJmIE4tFiU
	r/gy+9v4JMG3sBIdOS5+q53kunylRfw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771409184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF5ekqjNuM/ezoLCfqRuAS33AdTNqJOPT2shOtfQigo=;
	b=s6CRKeHjbn03jyPlCF3LDsGeaqsmCi+hpEDg2wQzm19YppQjAFgJwU91/GDUlOIwVZbTYg
	xaBmwS9j3M1cVSNdLLS6ijaQOJgXRK+oGft43HIF8IPuPQw26HdGFjoiM10zJJmIE4tFiU
	r/gy+9v4JMG3sBIdOS5+q53kunylRfw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 961003EA65
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMZTFh+PlWluDQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: fix a bug that makes encoded write bio larger than expected
Date: Wed, 18 Feb 2026 20:36:01 +1030
Message-ID: <fd512372cb3b8f5a476a0a0d780f08e4cb03e087.1771409004.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771409004.git.wqu@suse.com>
References: <cover.1771409004.git.wqu@suse.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21743-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 1A5951551C4
X-Rspamd-Action: no action

[BUG]
When running btrfs/284 with 64K page size and 4K fs block size, the
following ASSERT() can be triggered:

 assertion failed: cb->bbio.bio.bi_iter.bi_size == disk_num_bytes :: 0, in inode.c:9991
 ------------[ cut here ]------------
 kernel BUG at inode.c:9991!
 Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
 CPU: 5 UID: 0 PID: 6787 Comm: btrfs Tainted: G           OE       6.19.0-rc8-custom+ #1 PREEMPT(voluntary)
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 pc : btrfs_do_encoded_write+0x9b0/0x9c0 [btrfs]
 lr : btrfs_do_encoded_write+0x9b0/0x9c0 [btrfs]
 Call trace:
  btrfs_do_encoded_write+0x9b0/0x9c0 [btrfs] (P)
  btrfs_do_write_iter+0x1d8/0x208 [btrfs]
  btrfs_ioctl_encoded_write+0x3c8/0x6d0 [btrfs]
  btrfs_ioctl+0xeb0/0x2b60 [btrfs]
  __arm64_sys_ioctl+0xac/0x110
  invoke_syscall.constprop.0+0x64/0xe8
  el0_svc_common.constprop.0+0x40/0xe8
  do_el0_svc+0x24/0x38
  el0_svc+0x3c/0x1b8
  el0t_64_sync_handler+0xa0/0xe8
  el0t_64_sync+0x1a4/0x1a8
 Code: 91180021 90001080 9111a000 94039d54 (d4210000)
 ---[ end trace 0000000000000000 ]---

[CAUSE]
After commit e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage
for encoded writes"), the encoded write is changed to copy the content
from the iov into a folio, and queue the folio into the compressed bio.

However we always queue the full folio into the compressed bio, which
can make the compressed bio larger than the on-disk extent, if the folio
size is larger than the fs block size.

Although we have an ASSERT() to catch such problem, for kernels without
CONFIG_BTRFS_ASSERT, such larger than expected bio will just be
submitted, possibly overwrite the next data extent, causing data
corruption.

[FIX]
Instead of blindly queuing the full folio into the compressed bio, only
queue the needed byte range, which is the old behavior before that
offending commit.
This also means we no longer need to zero the tailing range, as such
range will not be written to disk anyway.

And since we're here, add a final ASSERT() into
btrfs_submit_compressed_write() as the last safenet for debug kernels.

Fixes: e1bc83f8b157 ("btrfs: get rid of compressed_folios[] usage for encoded writes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 1 +
 fs/btrfs/inode.c       | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1938d33ab57a..348551ab2c04 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -324,6 +324,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 
 	cb->start = ordered->file_offset;
 	cb->len = ordered->num_bytes;
+	ASSERT(cb->bbio.bio.bi_iter.bi_size == ordered->disk_num_bytes);
 	cb->compressed_len = ordered->disk_num_bytes;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
 	cb->bbio.ordered = ordered;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index baf400847ce8..17911d33da0f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9981,9 +9981,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			ret = -EFAULT;
 			goto out_cb;
 		}
-		if (bytes < min_folio_size)
-			folio_zero_range(folio, bytes, min_folio_size - bytes);
-		ret = bio_add_folio(&cb->bbio.bio, folio, folio_size(folio), 0);
+		ret = bio_add_folio(&cb->bbio.bio, folio, bytes, 0);
 		if (unlikely(!ret)) {
 			folio_put(folio);
 			ret = -EINVAL;
-- 
2.52.0


