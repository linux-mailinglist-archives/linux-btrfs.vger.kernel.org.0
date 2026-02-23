Return-Path: <linux-btrfs+bounces-21831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HMHDCQEnGlG/AMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21831-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 08:39:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B90172C2D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 08:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C88301ABA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D81034AAEA;
	Mon, 23 Feb 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HQjUeU53";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DuoZqwgZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC520E334
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832340; cv=none; b=ZM1oqbIisMhJa0X/n+G67hZggiGZ7k2Nyx+XkU7X8j4EveaIp8bfU+5A5TZdORv177hgg2yXCcRQGBUiMPLlIcgMcEYPzZhwtPsBx0TbUUtJh1eKkJ9oFa2uAJEsehSsg5U255yd1zF13QgFzGodLW0UCWCYf9dt12sfTT2ko08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832340; c=relaxed/simple;
	bh=Kn7JOTrFsX3rsRxyQrxMBbXouELu4ecR4vO1d0YCK0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTaoh6Caq/AJc+MHzE/XUxt5jjWSyc65IRcrO/bibEQ0VaVDZcHPqlKBOzr/dkldlV4NpUpeKrkmSwMCkHnV0/d4mK8mKPIwpdaJz1vc+F74fb8J8vccLZ1MAYgcSeDA8ZSU4Sas9MvojAdlrky3djAxG2BQfKTjesvvhDj/Ykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HQjUeU53; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DuoZqwgZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61DF35BD01;
	Mon, 23 Feb 2026 07:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771832337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W42XKhZsQhmzyK8SDjBHJLBtL7/5ESUl08FLdmhIJCk=;
	b=HQjUeU53Jf6AQ4Nkf2yXJj1RyvcTtgCVI6tffbigMxZWy5SWMwbHuSXjvcRWhdVYXL84O2
	DsGHTsmlIdRvrHc7dvjC7XWfEYtN925JqfjJMtPPHx33bXYzmmYJ6O2Uv/tEV06SdAErru
	q29yKEjehYStRxyHCt9C7gbWeV6P9nI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771832336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W42XKhZsQhmzyK8SDjBHJLBtL7/5ESUl08FLdmhIJCk=;
	b=DuoZqwgZ1eUUBUe/XRqF44JvOrHCadg30K/e3P3uNAPHR8FW9xFTuUOsaI8Cr7U7P/Hcrp
	YJ5kBsjB1tjia/KyTkinPqqek/RbQyNnLfLUPJ0BXqkY05YQndFaOXnMMwiQYNyGrmID+x
	a/G45IOo7LMGZmKv96hXV5T+kmo5L7E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 885413EA68;
	Mon, 23 Feb 2026 07:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jjqyEQ4EnGn6KwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 23 Feb 2026 07:38:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v6.12] btrfs: always fallback to buffered write if the inode requires checksum
Date: Mon, 23 Feb 2026 18:08:32 +1030
Message-ID: <8419975b6281ce4d112a3a5006c8ca3bc489a41b.1771832083.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21831-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92B90172C2D
X-Rspamd-Action: no action

commit 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5 upstream.

[BUG]
It is a long known bug that VM image on btrfs can lead to data csum
mismatch, if the qemu is using direct-io for the image (this is commonly
known as cache mode 'none').

[CAUSE]
Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
fs is allowed to dirty/modify the folio even if the folio is under
writeback (as long as the address space doesn't have AS_STABLE_WRITES
flag inherited from the block device).

This is a valid optimization to improve the concurrency, and since these
filesystems have no extra checksum on data, the content change is not a
problem at all.

But the final write into the image file is handled by btrfs, which needs
the content not to be modified during writeback, or the checksum will
not match the data (checksum is calculated before submitting the bio).

So EXT4/XFS/NTRFS assume they can modify the folio under writeback, but
btrfs requires no modification, this leads to the false csum mismatch.

This is only a controlled example, there are even cases where
multi-thread programs can submit a direct IO write, then another thread
modifies the direct IO buffer for whatever reason.

For such cases, btrfs has no sane way to detect such cases and leads to
false data csum mismatch.

[FIX]
I have considered the following ideas to solve the problem:

- Make direct IO to always skip data checksum
  This not only requires a new incompatible flag, as it breaks the
  current per-inode NODATASUM flag.
  But also requires extra handling for no csum found cases.

  And this also reduces our checksum protection.

- Let hardware handle all the checksum
  AKA, just nodatasum mount option.
  That requires trust for hardware (which is not that trustful in a lot
  of cases), and it's not generic at all.

- Always fallback to buffered write if the inode requires checksum
  This was suggested by Christoph, and is the solution utilized by this
  patch.

  The cost is obvious, the extra buffer copying into page cache, thus it
  reduces the performance.
  But at least it's still user configurable, if the end user still wants
  the zero-copy performance, just set NODATASUM flag for the inode
  (which is a common practice for VM images on btrfs).

  Since we cannot trust user space programs to keep the buffer
  consistent during direct IO, we have no choice but always falling back
  to buffered IO.  At least by this, we avoid the more deadly false data
  checksum mismatch error.

Cc: stable@vger.kernel.org # 6.12
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/direct-io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 71984d7db839..af68d7ba866b 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -856,6 +856,22 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto buffered;
 	}
+	/*
+	 * We can't control the folios being passed in, applications can write
+	 * to them while a direct IO write is in progress.  This means the
+	 * content might change after we calculated the data checksum.
+	 * Therefore we can end up storing a checksum that doesn't match the
+	 * persisted data.
+	 *
+	 * To be extra safe and avoid false data checksum mismatch, if the
+	 * inode requires data checksum, just fallback to buffered IO.
+	 * For buffered IO we have full control of page cache and can ensure
+	 * no one is modifying the content during writeback.
+	 */
+	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		goto buffered;
+	}
 
 	/*
 	 * The iov_iter can be mapped to the same file range we are writing to.
-- 
2.53.0


