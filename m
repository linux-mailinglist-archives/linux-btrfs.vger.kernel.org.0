Return-Path: <linux-btrfs+bounces-11233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B985A255CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 10:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6123A8947
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF331FF1D8;
	Mon,  3 Feb 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j5r50jBc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j5r50jBc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455D2BB04
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574881; cv=none; b=EbT+HR2h0npoyine8KBv+XVpa5Io8WC7H7kRMHBpvWVfRiQ240ZM5BGf76c7/qYSMtLsJ0mlUteNFHFw1at6FKjU7BY6mydhDXTD6OO35hIBWj7veCctyznSANmGOJ7leCUO+OF2CwDVOverapJvbM62eFZjDTK8pbmY4ktHLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574881; c=relaxed/simple;
	bh=SuHJpW4Tl7HsQ7auoQCCMPJpQUnCdmfCkmpOMLiPmt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k18wCD5BqA15ERbEs6tvEKS29/NS8AdJAvjWtg8fMkCOSI/IT0BnXiX/aTAoXfMyTtCzjOlkDBL34c8V3XZAWjxfMJGjDx6uVYn6jx57dvOLAAUP314Lb6hdnKzxQ40TXJw/FFJGQznGQ3r5zmpd3IdZV1sJF0rjb5ZDqB222kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j5r50jBc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j5r50jBc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 973A81F37C;
	Mon,  3 Feb 2025 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738574877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=urzQNCOcqhA7arW5ia0OOFa8tUWOZfmvqEwwYH+dsp0=;
	b=j5r50jBcWkDbPOlADbW9MxHuGYZMaBLNEkZNtmZM3XYOHo8OMgjC6FCaQZMUw0d6azWMzm
	sK/ZOfUjSkBqz6ShbXE5NHqktBpObPMrlDviU7TU1+MRzB0UKWqDcrSpDhcUkrFexe72SW
	P8UTMzsp7KO66giwWEz697BNzkM8Q/0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738574877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=urzQNCOcqhA7arW5ia0OOFa8tUWOZfmvqEwwYH+dsp0=;
	b=j5r50jBcWkDbPOlADbW9MxHuGYZMaBLNEkZNtmZM3XYOHo8OMgjC6FCaQZMUw0d6azWMzm
	sK/ZOfUjSkBqz6ShbXE5NHqktBpObPMrlDviU7TU1+MRzB0UKWqDcrSpDhcUkrFexe72SW
	P8UTMzsp7KO66giwWEz697BNzkM8Q/0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 951E413A78;
	Mon,  3 Feb 2025 09:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pViuFRyMoGd6YAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Feb 2025 09:27:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "hch@infradead.org" <hch@infradead.org>
Subject: [PATCH] btrfs: always fallback to buffered IO if the inode requires checksum
Date: Mon,  3 Feb 2025 19:57:38 +1030
Message-ID: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
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

- Always fallback to buffered IO if the inode requires checksum
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
 fs/btrfs/direct-io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index c99ceabcd792..d64cda76cc92 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 			goto err;
 	}
 
+	/*
+	 * For direct IO, we have no control on the folio passed in, thus the content
+	 * can change halfway after we calculated the data checksum.
+	 *
+	 * To be extra safe and avoid false data checksum mismatch, if the inode still
+	 * requires data checksum, we just fall back to buffered IO by returning
+	 * -ENOTBLK, and iomap will do the fallback.
+	 */
+	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
+		ret = -ENOTBLK;
+		goto err;
+	}
+
 	/*
 	 * If this errors out it's because we couldn't invalidate pagecache for
 	 * this range and we need to fallback to buffered IO, or we are doing a
-- 
2.48.1


