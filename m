Return-Path: <linux-btrfs+bounces-11457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E4A350D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 23:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C89A3A7F8E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2DA20D50E;
	Thu, 13 Feb 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d8LwqHb0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d8LwqHb0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A90200130
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484114; cv=none; b=oW7CRpQ5rmhRK7AHstTwq9eKwexvSZ1Tun8Np/J713XT/7K9njGlTSVWkzyxaA7Dzh9vNkVI/bLteiBQfABmcAvyM4gUB6tbOT5i3W1DzF/9tiAQuBpeaoyJ9J+U2blJaOW2JgBv7n5zoK1h/gzOn+gZDXZAxUNguu+lhvEGOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484114; c=relaxed/simple;
	bh=sJHoyHeN5LavahVhkLqb+Ci+isV2HUwo1mUgZPs5P+U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VvAJWpC/0Tjkt6HpTesibz9i40kEf1Vo1Q/ei9uUl7neX5pv1KIplKMUunUfIECT/20FNopis5vAI8peWRdc5sQagobT7+Jgg5jtdJnffqLaFl1EViyRmmK6JKYTGKZ3vSs+8P9zQJYjhkb9rBJWWfifvRt08ITn2BXXFglDUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d8LwqHb0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d8LwqHb0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 440251F7BF
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739484110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DttX9THPRbU7VSna8r6PWguEpX+aiio5hKUBhxNlgEY=;
	b=d8LwqHb0yln4E44+VGK/m2HdMMI2zUXx7RNmW3A+hE7hYhJQGZmhe+LTFhUOAuG9vTAOyM
	0VT+x/gl0b3nTZXvfL9XzcE1zPkykEjEi0FmyjKeQwktrdx1ULCl94ObMuMS828Cgtuqc7
	dyeHYFdAiVSRg7N/UBFtI+2qh529h8g=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739484110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DttX9THPRbU7VSna8r6PWguEpX+aiio5hKUBhxNlgEY=;
	b=d8LwqHb0yln4E44+VGK/m2HdMMI2zUXx7RNmW3A+hE7hYhJQGZmhe+LTFhUOAuG9vTAOyM
	0VT+x/gl0b3nTZXvfL9XzcE1zPkykEjEi0FmyjKeQwktrdx1ULCl94ObMuMS828Cgtuqc7
	dyeHYFdAiVSRg7N/UBFtI+2qh529h8g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6775B13874
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 22:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v6mkCM1rrmcHegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 22:01:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: add an extra note to btrfs data checksum and directIO
Date: Fri, 14 Feb 2025 08:31:27 +1030
Message-ID: <b7dd4b16ffffa1114177f37bc349d437fc51cc63.1739484084.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

In v6.14 kernel release, btrfs will force direct IO to fall back to
buffered one if the inode requires data checksum.

This will cause a small performance drop, to solve the false data
checksum problem caused by direct IOs.

Although such change is small to most end users, for those requiring
zero-copy direct IO this will be a behavior change, and require a proper
documentation update.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-checksumming.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ch-checksumming.rst b/Documentation/ch-checksumming.rst
index 5e47a6bfb492..782191692746 100644
--- a/Documentation/ch-checksumming.rst
+++ b/Documentation/ch-checksumming.rst
@@ -3,6 +3,24 @@ writing and verified after reading the blocks from devices. The whole metadata
 block has an inline checksum stored in the b-tree node header. Each data block
 has a detached checksum stored in the checksum tree.
 
+.. note::
+   Since data checksum is calculated just before submitting to the block device,
+   btrfs has a strong requirement that those data can not be modified until the
+   writeback is finished.
+
+   This requirement is met for buffered IO as btrfs has full control on the
+   page cache, but direct IOs (``O_DIRECT``) bypass the page cache, and btrfs
+   can not control the direct IO buffer (can be user space memory), thus it's
+   possible that user space programs modify the buffer before it's fully written
+   back, and lead to data checksum mismatch.
+
+   To avoid such checksum mismatch, since v6.14 btrfs will force direct IOs to
+   fall back to buffered IOs, if the inode requires data checksum.
+   This will bring a small performance penalty, if the end user requires true
+   zero-copy direct IOs, they should set the ``NODATASUM`` flag for the inode
+   and make sure the direct IO buffer is fully aligned to btrfs block size.
+
+
 There are several checksum algorithms supported. The default and backward
 compatible algorithm is *crc32c*. Since kernel 5.5 there are three more with different
 characteristics and trade-offs regarding speed and strength. The following list
-- 
2.48.1


