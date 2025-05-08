Return-Path: <linux-btrfs+bounces-13819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D7AAF07D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 03:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5652F4E78BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 01:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA901865EE;
	Thu,  8 May 2025 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b7yjQGjK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b7yjQGjK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389813DBA0
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666566; cv=none; b=JR0OjfIXQsI8MXnDMPzFMkGt0AP2VIt7ugUs1kwr+xeJwK1gd/OaMuRv3gPsk0ELe4+tn1fMXpObvS17nRblQa/KrNnCmsJ9sgGqd9i+bMiFMjJSKb72/CKwqmdgEK5EY7GeKF2XtZg8ZuMG60WWeC6MTc3u6bOsXS1iZYstfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666566; c=relaxed/simple;
	bh=KPepL8SaZvi9o1TiyKx8UzJ5jiNoOlrIiTjzsypHAoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQ39PxqmjkVDNPKyavdz5ictoA79EmFfsPqBlYKK+IZwV+3525tmnhsqt1840/6Eaf/XNwLtxj6aqMjEsSNSnVZCMKkly+ZpktJ7lh8qJ2wGJQdonoL7SDaMNVpFix6m27ZvPVkFLmzkoilzs0KT5cmW+WKr+G39n9zaJnzPi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b7yjQGjK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b7yjQGjK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E21D1F395;
	Thu,  8 May 2025 01:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746666562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=itrX7noFxKjIxmXg7RzqEQh0kAg78j9E3kWqEumbjtY=;
	b=b7yjQGjKfBKrdJUcwS0ZsxkeK2nPnZE9Ul6L72DnTeIopZVSUoxX7dx4xy9ggJCHERZPGN
	PcLYJT58/51pt581B5iFtj5V3+E8iTlGMu0YBUlj+UuC48wXDXYQxxfjksARpHOtZ61o4O
	be+9JPIx2ZZovBHsib2zFdeyGw0I474=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746666562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=itrX7noFxKjIxmXg7RzqEQh0kAg78j9E3kWqEumbjtY=;
	b=b7yjQGjKfBKrdJUcwS0ZsxkeK2nPnZE9Ul6L72DnTeIopZVSUoxX7dx4xy9ggJCHERZPGN
	PcLYJT58/51pt581B5iFtj5V3+E8iTlGMu0YBUlj+UuC48wXDXYQxxfjksARpHOtZ61o4O
	be+9JPIx2ZZovBHsib2zFdeyGw0I474=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC4B71398F;
	Thu,  8 May 2025 01:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBvUG0AEHGi4dQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 08 May 2025 01:09:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6.y] btrfs: always fallback to buffered write if the inode requires checksum
Date: Thu,  8 May 2025 10:39:16 +0930
Message-ID: <54c7002136a047b7140c36478200a89e39d6bd04.1746666535.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80

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

CC: stable@vger.kernel.org # 6.6
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Fix a conflict due to the movement of the function. ]
---
 fs/btrfs/file.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e794606e7c78..f1456c745c6d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1515,6 +1515,23 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
+
 	/*
 	 * The iov_iter can be mapped to the same file range we are writing to.
 	 * If that's the case, then we will deadlock in the iomap code, because
-- 
2.49.0


