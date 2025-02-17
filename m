Return-Path: <linux-btrfs+bounces-11505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5421EA37B19
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 06:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9BD7A2ACB
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 05:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8118C932;
	Mon, 17 Feb 2025 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eWG5ja6W";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eWG5ja6W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB2185B67
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771955; cv=none; b=iuz9m5dv0QlUcu9iOhkvcy7jV1iYP1FH2/j+ct2PsqhLsGaCCylI0q9dLWu1t+7W4anMaV+j5nOukQy7ib84gkJmCRZZhGBMDSPMaEYzRmMzwZ0DOIKr4XlknvOVM0g0NhobXvwK8C91cm0oKtqb+qVtT1w1akZz0b1/f/Px/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771955; c=relaxed/simple;
	bh=rqVr/vNR8Dkxqro/xXJ6vgZbu8l/60UIvFSVPTpMB18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qNMadr2dybgy79C7qu9lWyfwVfvbqSYkl9/Ha5vEtt4YndBh8jRtla2qR6EVp9V8zSGZ9iAd9hC5a1mmrA1fab0To8IXWmeJYJMsbtvF8jcTuqjGQ8pV4zso+flIVipZ0HQ6hgcKZtVPoUSqX2MI0xOzQBr3eqh7yq9vilUe4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eWG5ja6W; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eWG5ja6W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E7CC1F38E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 05:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739771951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TST5g8HDdMGRaaGHimfsLGIPlbcsTFswEbBHRTbKYW8=;
	b=eWG5ja6WRbeo3Q5BNYzKOFUNVbYxJsLVCdbP9HdgYm0UNhlRnWOD71S2qDJNBQVAhSVy0g
	LxKyv8/KQURBj6JS6HmmjwxIHl8QMhqOv3IECuwBMaxDWlz4LRGl6+AQzmrNk53Xem0Sub
	3tUpMHVd/9TbqkyEjK9iioBG8Xd8gMg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eWG5ja6W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739771951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TST5g8HDdMGRaaGHimfsLGIPlbcsTFswEbBHRTbKYW8=;
	b=eWG5ja6WRbeo3Q5BNYzKOFUNVbYxJsLVCdbP9HdgYm0UNhlRnWOD71S2qDJNBQVAhSVy0g
	LxKyv8/KQURBj6JS6HmmjwxIHl8QMhqOv3IECuwBMaxDWlz4LRGl6+AQzmrNk53Xem0Sub
	3tUpMHVd/9TbqkyEjK9iioBG8Xd8gMg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 601BC133F9
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 05:59:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SuMzCC7QsmeYegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 05:59:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: add an extra note to btrfs data checksum and directIO
Date: Mon, 17 Feb 2025 16:28:52 +1030
Message-ID: <90a1ea4049bbf6d80163aa8116af722280c5d70c.1739771926.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E7CC1F38E
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

In v6.14 kernel release, btrfs will force a direct IO to fall back to
a buffered one if the inode requires a data checksum.

This will cause a small performance drop, to solve the false data
checksum mismatch problem caused by direct IOs.

Although such a change is small to most end users, for those requiring
such a zero-copy direct IO this will be a behavior change, and this
requires a proper documentation update.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Grammar fixes sugguested by Johannes
---
 Documentation/ch-checksumming.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ch-checksumming.rst b/Documentation/ch-checksumming.rst
index 5e47a6bfb492..b7fde46fe902 100644
--- a/Documentation/ch-checksumming.rst
+++ b/Documentation/ch-checksumming.rst
@@ -3,6 +3,24 @@ writing and verified after reading the blocks from devices. The whole metadata
 block has an inline checksum stored in the b-tree node header. Each data block
 has a detached checksum stored in the checksum tree.
 
+.. note::
+   Since a data checksum is calculated just before submitting to the block
+   device, btrfs has a strong requirement that the coresponding data block must
+   not be modified until the writeback is finished.
+
+   This requirement is met for a buffered write as btrfs has the full control on
+   its page caches, but a direct write (``O_DIRECT``) bypasses page caches, and
+   btrfs can not control the direct IO buffer (as it can be in user space memory),
+   thus it's possible that a user space program modifies its direct write buffer
+   before the buffer is fully written back, and this can lead to a data checksum mismatch.
+
+   To avoid such a checksum mismatch, since v6.14 btrfs will force a direct
+   write to fall back to a buffered one, if the inode requires a data checksum.
+   This will bring a small performance penalty, and if the end user requires true
+   zero-copy direct writes, they should set the ``NODATASUM`` flag for the inode
+   and make sure the direct IO buffer is fully aligned to btrfs block size.
+
+
 There are several checksum algorithms supported. The default and backward
 compatible algorithm is *crc32c*. Since kernel 5.5 there are three more with different
 characteristics and trade-offs regarding speed and strength. The following list
-- 
2.48.1


