Return-Path: <linux-btrfs+bounces-13818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A086AAF061
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 03:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6761893EBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 01:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACA3594F;
	Thu,  8 May 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eD7GBv51";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eD7GBv51"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581A8F54
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666094; cv=none; b=OG+psSlMZ+214v2WR3xPAjdUI8AUwFXhWBzMiO3mTkMiBSSCXhtuFfVGqjWWsp4gKBoF34xbPwknJRFRjv8JGudPQDIGY5KJARzct4bxQ+MyMIpwkuspYkjPzj0LityV+Y+M9YewuTLctDkav0kX/rGSWiJTJOZjon7UY/ZSZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666094; c=relaxed/simple;
	bh=TUEAEKJ52qvIJQuqydhMl8oJRMded7ynfMKPxOkG/U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbQYcnbgpyMp2r7rwUxJdHovPtmRmrWFb9VXuwJS07r6mt2dCKB8MTQmIz4ZqEUUJcrByk/vfCZdPzyprn76BrkS6oMNO0+DAX32ROV/jGKCfZ4b53sKSN3R8tn5fU80umf65PgppIP6m99/YjyTkDLb/YHItWapC736ab8RKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eD7GBv51; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eD7GBv51; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 890971F393;
	Thu,  8 May 2025 01:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746666090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zo3iwXAv2z+CjZT8woUGoxz0vEeBUcMXNPBAy7iZwbk=;
	b=eD7GBv518uvaKgoQ+/OoghdfWL4cOGHCnEp1i9vGF8A54FhOZbo32SD2gC80cpVP5Mzr26
	ZmwRU07sqqWolu1PdD3gkjgAoM6YwNkdLsVQ1GAoYxFLUka8LaNsmgP2wPsznJkeG4/QLJ
	VVmOB0vGOA30pSKjgbZSRaVNvSRpXsA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746666090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zo3iwXAv2z+CjZT8woUGoxz0vEeBUcMXNPBAy7iZwbk=;
	b=eD7GBv518uvaKgoQ+/OoghdfWL4cOGHCnEp1i9vGF8A54FhOZbo32SD2gC80cpVP5Mzr26
	ZmwRU07sqqWolu1PdD3gkjgAoM6YwNkdLsVQ1GAoYxFLUka8LaNsmgP2wPsznJkeG4/QLJ
	VVmOB0vGOA30pSKjgbZSRaVNvSRpXsA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3FB513687;
	Thu,  8 May 2025 01:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id skmSJWgCHGgIdAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 08 May 2025 01:01:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.12.y] btrfs: always fallback to buffered write if the inode requires checksum
Date: Thu,  8 May 2025 10:31:25 +0930
Message-ID: <968f19c5b1b7d5595423b0ac0020cc18dfed8cb5.1746665263.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Patch-mainline: v6.15-rc1
Git-commit: 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
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

Bu the final write into the image file is handled by btrfs, which needs
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

CC: stable@vger.kernel.org # 6.12+
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/direct-io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 8567af46e16f..eacbb74bf6bc 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -855,6 +855,22 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
2.49.0


