Return-Path: <linux-btrfs+bounces-16153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B442CB2B8D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 07:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A77ABCA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E230FF06;
	Tue, 19 Aug 2025 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HS1rHwni";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HS1rHwni"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5923E34C
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582085; cv=none; b=sROkTvkCtUkrnBOU4lkBRWJtrHW6VtQ5KbBrybSdTxpJ/fystA4I+lowNEzHt7G1yl/2K17UgWI2km4P7Mrq4dQ0IAlgYzBVMLuLbhhVWMAg7kEt8D0TXbkT2WS5mV4c802Rk8DGSFd2wCx0ouHT5PVCAx1aHXkVnF7SYY7yUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582085; c=relaxed/simple;
	bh=NAmwHtEq7+2Z53ZiJ+G9zRAdyWjrkXjMPkwx3MoS3oU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PM1fg+e1wo5hgcwpcIXrrzOA/2T3Z9Ie9TqH5T7zh61prntZ5qLTduXtCVV8xV1/IWAQZ1Jx6w6XUmwYA2+dK/uMgQkGzo+9yyfROHJsxozHgr1X/uvgiK+i5wuWHf8C6UkxKI/nnXCpfIXwC8Vv3BZLMP7SiqUb6yBL3IqGz2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HS1rHwni; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HS1rHwni; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E8B01F749
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 05:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755582081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YWiTNxhcQuoY3FtFCyyhdnXW5mEgzn95ZDoECK3meBA=;
	b=HS1rHwni98eR6jof+OJR8vpuDXK97HUIiWUsNY1CZP92obm4olnC5lJNsft4zTk/OqaOd+
	8P1sQkcMu4QHmxvnUZvdvwbEIr+4kwKmYoCmwB+p9/eZfta0pZEiEo5Xeq2YlTrqx2/C9T
	Bsg6er/dWhoHm/SR5bK0S/K4arGcrWU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755582081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YWiTNxhcQuoY3FtFCyyhdnXW5mEgzn95ZDoECK3meBA=;
	b=HS1rHwni98eR6jof+OJR8vpuDXK97HUIiWUsNY1CZP92obm4olnC5lJNsft4zTk/OqaOd+
	8P1sQkcMu4QHmxvnUZvdvwbEIr+4kwKmYoCmwB+p9/eZfta0pZEiEo5Xeq2YlTrqx2/C9T
	Bsg6er/dWhoHm/SR5bK0S/K4arGcrWU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BCC013686
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 05:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G7yUA4AOpGidBQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 05:41:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: update the compatibility about compression
Date: Tue, 19 Aug 2025 15:11:02 +0930
Message-ID: <bba7c113042d631cf6a787a261d550291e08c6c4.1755582011.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

There is a github issue that expressed confusion about the
"Compatibility" section of "ch-compression.rst".

The words in the man page is indeed confusing, and some points are no
longer correct either.

Considering how complex the direct IO and compression thing is, I didn't
come up with a correct answer until reading the code.

So update that section to provide a more straightforward result.

Issue: #1015
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-compression.rst | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/ch-compression.rst b/Documentation/ch-compression.rst
index 9174f97c74b3..eb609c70b530 100644
--- a/Documentation/ch-compression.rst
+++ b/Documentation/ch-compression.rst
@@ -167,10 +167,18 @@ pattern detection, byte frequency, Shannon entropy.
 Compatibility
 -------------
 
-Compression is done using the COW mechanism so it's incompatible with
-*nodatacow*. Direct IO read works on compressed files but will fall back to
-buffered writes and leads to no compression even if force compression is set.
-Currently *nodatasum* and compression don't work together.
+Compression requires both data checksum and COW, so either *nodatasum* or
+*nodatasum* mount option/inode flag will result no compression.
+
+Direct IO reads on compressed data will always fallback to buffered reads.
+
+Direct IO write behavior depends on the inode flag.
+For inodes with data checksum, direct IO writes always fallback to buffered
+writes, thus can generate compressed data if the mount option/inode flags allows.
+
+For inodes without data checksum, direct IO writes will not populate page cache,
+and since the inode has no data checksum, no compressed data will be generated
+anyway.
 
 The compression algorithms have been added over time so the version
 compatibility should be also considered, together with other tools that may
-- 
2.50.1


