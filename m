Return-Path: <linux-btrfs+bounces-21744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UImRIayPlWl7SQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21744-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:08:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDACF1551D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 11:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1FB303DD6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80A33BBC4;
	Wed, 18 Feb 2026 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XNI4TTC3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XNI4TTC3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A933C538
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409194; cv=none; b=nQG4NQl8zTcdf7UBX5pE6H+DJhfuz+uX7tKkKiGA0/GCQgHGCXnDkBY+DZiHKCUD0vxcUtkYPffKFcdb/GyB3jEcyVFaKMsz+7/IYbCyToiUw7WSs8TKQLGsUqPEDi6RLKLPYeqTPF+YHhrurpDmtvh002hA0wo++uvgtCxZWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409194; c=relaxed/simple;
	bh=P6K33rAGvNJ6Ao/utK7Fk7WueQCEWlVkHqQy62TFRcc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTc3KFZpKqKuPyq9n4ylPYwHDs6LQL5fkjSeQZgPH3KpvPRCmSJoYeS5+Ppx/Y7IACZ5tdYKFnsG5aRlKKcmeWMIzGGGWnIl1zI7KeFN52T9vZ4pQnGN4O21ELrAgAS5WSwZ4lflPefhQdCX43hjRYnc8MlBHqCIGwghs51KP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XNI4TTC3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XNI4TTC3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65DF05BCC9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771409187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eswA0V8SXnVi6LfTuyKVgume14ty5PlgKlypquckAu4=;
	b=XNI4TTC3oH8PyNig1yyGbruyH4Sij2Ks1oIlnVLdgFJMwNnXztzDhcl+kGbpZjRd4/49JH
	1oMq17TVFBAf0Ce0YHZwCmjpI/294LkEZKsOi4ugiITv/EmUx2tJ0ouPMnVmUiYPPS+vmF
	8eQLNIoTRUeUcPdaef8uBG1BH0ffFSM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771409187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eswA0V8SXnVi6LfTuyKVgume14ty5PlgKlypquckAu4=;
	b=XNI4TTC3oH8PyNig1yyGbruyH4Sij2Ks1oIlnVLdgFJMwNnXztzDhcl+kGbpZjRd4/49JH
	1oMq17TVFBAf0Ce0YHZwCmjpI/294LkEZKsOi4ugiITv/EmUx2tJ0ouPMnVmUiYPPS+vmF
	8eQLNIoTRUeUcPdaef8uBG1BH0ffFSM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047E53EA65
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gORxLiGPlWluDQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 10:06:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: fix an incorrect ASSERT() condition inside zstd_decompress_bio()
Date: Wed, 18 Feb 2026 20:36:03 +1030
Message-ID: <384789424f21dc337c4fbceb7339f3694a3bffed.1771409004.git.wqu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21744-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: CDACF1551D4
X-Rspamd-Action: no action

[BUG]
When running btrfs/284 with 64K page size and 4K fs block size, it
crashes with the following ASSERT() triggered:

 assertion failed: folio_size(fi.folio) == blocksize :: 0, in fs/btrfs/zstd.c:603
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/zstd.c:603!
 Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
 CPU: 2 UID: 0 PID: 1183 Comm: kworker/u35:4 Not tainted 6.19.0-rc8-custom+ #185 PREEMPT(voluntary)
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 Workqueue: btrfs-endio simple_end_io_work [btrfs]
 pc : zstd_decompress_bio+0x4f0/0x508 [btrfs]
 lr : zstd_decompress_bio+0x4f0/0x508 [btrfs]
 Call trace:
  zstd_decompress_bio+0x4f0/0x508 [btrfs] (P)
  end_bbio_compressed_read+0x260/0x2c0 [btrfs]
  btrfs_bio_end_io+0xc4/0x258 [btrfs]
  btrfs_check_read_bio+0x424/0x7e0 [btrfs]
  simple_end_io_work+0x40/0xa8 [btrfs]
  process_one_work+0x168/0x3f0
  worker_thread+0x25c/0x398
  kthread+0x154/0x250
  ret_from_fork+0x10/0x20
 ---[ end trace 0000000000000000 ]---

[CAUSE]
Commit 1914b94231e9 ("btrfs: zstd: use folio_iter to handle
zstd_decompress_bio()") added the ASSERT() to make sure the folio size
match the fs block size.

But the check is completely wrong, the original intention is to make
sure for bs > ps cases, we always got a large folio that covers a full fs
block.

However for bs < ps cases, a folio can never be smaller than page size,
and the ASSERT() gets triggered immediately.

[FIX]
Check the folio size against @min_folio_size instead, which will never
be smaller than PAGE_SIZE, and still cover bs > ps cases.

Fixes: 1914b94231e9 ("btrfs: zstd: use folio_iter to handle zstd_decompress_bio()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zstd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 32fd7f5454d3..c002d18666b7 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -600,7 +600,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	bio_first_folio(&fi, &cb->bbio.bio, 0);
 	if (unlikely(!fi.folio))
 		return -EINVAL;
-	ASSERT(folio_size(fi.folio) == blocksize);
+	ASSERT(folio_size(fi.folio) == min_folio_size);
 
 	stream = zstd_init_dstream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
-- 
2.52.0


