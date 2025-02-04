Return-Path: <linux-btrfs+bounces-11261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8B5A26A9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 04:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A9167E92
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 03:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2343156F3C;
	Tue,  4 Feb 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R9lx+p5U";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R9lx+p5U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954D3597D
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738639855; cv=none; b=r6U4QtNNhzaXdM0iEHltvCsutuFgAwjs/oTeuojsLF1w6eADN6VZbWVbR7cAgv+LI6Y0663LK5A8apni/ypYDcBV700PaC7ZtNMEOrDFafAspDgOLBdzLS1ZRlsF0cVROV5Qe/ewin5OiguTCBf6OwDqxDxXxPMskY2gW3DfyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738639855; c=relaxed/simple;
	bh=CrkbDQfZzxbpluxB065CQ2GJBfGAFTQtR7RkvAqoGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6AanjGrYm7hFGnhBaQHecAg1ol5CNNkttDp5tM22OQmHaalgfecQfvrnJ8PJqLkPLfesV2FCrEp+5wEvfxpiO3zrBIq49rnHWNeJ2B7uRzJ42LhUigLjW5ZIrpgS45S+aPWUTynIbpXJXCg6kgxlKrWxPjDP6DHew+1yKShBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R9lx+p5U; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R9lx+p5U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0391C21119;
	Tue,  4 Feb 2025 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738639846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rR0K/FS+eralNZElqXyjFijGHwnPvb6RiZfeqdWK/Yc=;
	b=R9lx+p5Uawh1u9mIBa5Pbqzd1xFh4UpRduw4MTt5xSIHYSJPovsW0Q7IKV90gUY289itTi
	aUPfySRsBfBuqAzCjXS35czkGo9nfX7tgN2P8LAwGmN82e97kyvlHtuCHFTw3vDZXy1KW0
	bA4q8Pa4vPAk+wFZYniE3Hv+B7Vvt0Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=R9lx+p5U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738639846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rR0K/FS+eralNZElqXyjFijGHwnPvb6RiZfeqdWK/Yc=;
	b=R9lx+p5Uawh1u9mIBa5Pbqzd1xFh4UpRduw4MTt5xSIHYSJPovsW0Q7IKV90gUY289itTi
	aUPfySRsBfBuqAzCjXS35czkGo9nfX7tgN2P8LAwGmN82e97kyvlHtuCHFTw3vDZXy1KW0
	bA4q8Pa4vPAk+wFZYniE3Hv+B7Vvt0Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F31FF136AD;
	Tue,  4 Feb 2025 03:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Z1TLOSJoWcxGwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 04 Feb 2025 03:30:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "hch@infradead.org" <hch@infradead.org>
Subject: [PATCH v2] btrfs: always fallback to buffered write if the inode requires checksum
Date: Tue,  4 Feb 2025 14:00:23 +1030
Message-ID: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0391C21119
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
It is a long known bug that VM image on btrfs can lead to data csum
mismatch, if the qemu is using direct-io for the image (this is commonly
known as cache mode none).

[CAUSE]
Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
fs is allowed to dirty/modify the folio even the folio is under
writeback (as long as the address space doesn't have AS_STABLE_WRITES
flag inherited from the block device).

This is a valid optimization to improve the concurrency, and since these
filesystems have no extra checksum on data, the content change is not a
problem at all.

But the final write into the image file is handled by btrfs, which need
the content not to be modified during writeback, or the checksum will
not match the data (checksum is calculated before submitting the bio).

So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
but btrfs requires no modification, this leads to the false csum
mismatch.

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

- Let hardware to handle all the checksum
  AKA, just nodatasum mount option.
  That requires trust for hardware (which is not that trustful in a lot
  of cases), and it's not generic at all.

- Always fallback to buffered write if the inode requires checksum
  This is suggested by Christoph, and is the solution utilized by this
  patch.

  The cost is obvious, the extra buffer copying into page cache, thus it
  reduce the performance.
  But at least it's still user configurable, if the end user still wants
  the zero-copy performance, just set NODATASUM flag for the inode
  (which is a common practice for VM images on btrfs).

  Since we can not trust user space programs to keep the buffer
  consistent during direct IO, we have no choice but always falling
  back to buffered IO.
  At least by this, we avoid the more deadly false data checksum
  mismatch error.

Suggested-by: hch@infradead.org <hch@infradead.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Move the checksum check just after check_direct_IO()
  So that we don't need the extra ENOTBLK error code trick to fallback
  to buffered IO.

- Slightly improve the comment
  Adds that only direct write is affected, and why buffered write is
  fine.
---
 fs/btrfs/direct-io.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index c99ceabcd792..0de4397130be 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -855,6 +855,21 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
 		goto buffered;
 	}
+	/*
+	 * For direct IO write, we have no control on the folios passed in,
+	 * thus the content can change halfway after we calculated the data
+	 * checksum, and result data checksum mismatch and unable to read
+	 * the data out anymore.
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
2.48.1


