Return-Path: <linux-btrfs+bounces-21832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APo0IdUKnGn8/AMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21832-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 09:07:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3D4172F10
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 09:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D6F302BB99
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1534D38B;
	Mon, 23 Feb 2026 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GeRQrHgR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GeRQrHgR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80D349AF6
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833855; cv=none; b=CnWUsD9GFTxBvZi1eRtriNe2OSm7MYQ1FjeZFZ62zdDixK4dNo+wFazIP57s7taWVyJzi5A6stluYQBEsP7M+Q1yKEPn0Rq2pm0L8aocZpjtDfwPp/uakX2inRfkGUyUFrHQTQl1em3mvhPnea+E+iB13Clua8SrX/fI0Rkjx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833855; c=relaxed/simple;
	bh=hPQfL1kdndK9WXSaZxqBZZ86tv2CoPIpXm5oERs90Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YctDiD95+MbqEf7veGkZGUNYnrJoFJOxoXW6/GNzXa0Oxo4OQYBfdPXly9HYmWyLYvswcM1A2OKveBXfxOZLROBOiYEIrc1WR/e8AspWCx1E4nQokewxMVMJVxXDwFMHNiUp7jY8NNB65PnMvE5AeLfaBXohnXhSf1sMDB+Lp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GeRQrHgR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GeRQrHgR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D1E75BD01;
	Mon, 23 Feb 2026 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771833852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7MY2IlPcX8pvp/9jCy+fcxkpTLGfcrloKd1JZB/FNCI=;
	b=GeRQrHgRmAjPmPsFxmDFL/6oOXS0XjUOiQTrcTQA53ra4lb5zX7UcaiVnFdSEXPM1gfuLZ
	zjqBJf5ZND6KAWOppH2OWbOeq0e5j6Kp3dB4VGALiaucP8bIo+B8BenW/YBl96bHeyJbrY
	1ATs3oxC285FOkgBZ+b/27nHNJOOWb4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771833852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7MY2IlPcX8pvp/9jCy+fcxkpTLGfcrloKd1JZB/FNCI=;
	b=GeRQrHgRmAjPmPsFxmDFL/6oOXS0XjUOiQTrcTQA53ra4lb5zX7UcaiVnFdSEXPM1gfuLZ
	zjqBJf5ZND6KAWOppH2OWbOeq0e5j6Kp3dB4VGALiaucP8bIo+B8BenW/YBl96bHeyJbrY
	1ATs3oxC285FOkgBZ+b/27nHNJOOWb4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C5253EA68;
	Mon, 23 Feb 2026 08:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IQ0xB/oJnGkKRgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 23 Feb 2026 08:04:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v6.6] btrfs: always fallback to buffered write if the inode requires checksum
Date: Mon, 23 Feb 2026 18:33:48 +1030
Message-ID: <5c3a9c8f484ed1ba8fe897e67057eec24968f7bd.1771833812.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21832-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: DF3D4172F10
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

Cc: stable@vger.kernel.org # 6.6
[ Conflicts caused by code extracted into direct-io.c ]
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9ef543db8aab..8e7108c14de2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1514,6 +1514,22 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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


