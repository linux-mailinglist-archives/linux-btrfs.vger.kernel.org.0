Return-Path: <linux-btrfs+bounces-21774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEljJivIlmkGmwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21774-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 09:22:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8015D076
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 09:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4512330269DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 08:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A9334C20;
	Thu, 19 Feb 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QaC+lO/R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QaC+lO/R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF12C21FE
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489309; cv=none; b=e3m6eZf1e0FqBwirA/xDe6TiO30K8OgmHqzhlBryPa7VGOeMKGDkkfu+DdK9FVdqINf65AVje082ahWdQ3poWd+T3iXtqNfRapyBRRTLWcbTM+xrjZS74ZFcEbXDv2Seb7Vrrhkc/IgezVAGo4A2IcEIv2LllmyUci9qSxZhwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489309; c=relaxed/simple;
	bh=P6K33rAGvNJ6Ao/utK7Fk7WueQCEWlVkHqQy62TFRcc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhmQvIaIvkERkPbM6OFm7C+V1iLaq5BhBq7h0eg/aEjb7SdyH5jR0PXGz29x9oDsdQwXMwBVpwjvbJz1CPxs6Uau57IW/qrhhxB6oFEF7CEKWFLIB0hw5hZZJlFrSYHb7PCk1M8Y4CYrn2hNzkegHsWCu5cFiibsJ9veQoQj1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QaC+lO/R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QaC+lO/R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18DA63E6F3
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771489297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eswA0V8SXnVi6LfTuyKVgume14ty5PlgKlypquckAu4=;
	b=QaC+lO/RYZh1cEcWgjjVbpeab8LjHH+kyHnnN+Hc/Z2TQESGdNJjOCcNmWHN/vr8TeNc4d
	8cN7e3XZfLwrlvUd9Mi0pq+bFJLiZay2D145PdtBlEThmQ9Bx1QTkl908olhlSgqknK4Xg
	1hMUoHlAo+vwTFtp+fyde8E/NsZxgt8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="QaC+lO/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771489297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eswA0V8SXnVi6LfTuyKVgume14ty5PlgKlypquckAu4=;
	b=QaC+lO/RYZh1cEcWgjjVbpeab8LjHH+kyHnnN+Hc/Z2TQESGdNJjOCcNmWHN/vr8TeNc4d
	8cN7e3XZfLwrlvUd9Mi0pq+bFJLiZay2D145PdtBlEThmQ9Bx1QTkl908olhlSgqknK4Xg
	1hMUoHlAo+vwTFtp+fyde8E/NsZxgt8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49A183EA65
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MCJkAxDIlmkYZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 08:21:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: fix an incorrect ASSERT() condition inside zstd_decompress_bio()
Date: Thu, 19 Feb 2026 18:51:13 +1030
Message-ID: <3b5176eb0c8d7d1780b758ca50599d90c2c62bc9.1771488629.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771488629.git.wqu@suse.com>
References: <cover.1771488629.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21774-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20D8015D076
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


