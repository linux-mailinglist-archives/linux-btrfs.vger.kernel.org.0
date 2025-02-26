Return-Path: <linux-btrfs+bounces-11826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5ECA4543B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32307188EC92
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92A2676F5;
	Wed, 26 Feb 2025 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vM9TuH0J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n1RUoIow"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8790253F05
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542387; cv=none; b=udigmaeb60ZMJ21RovZzUgcubpmdO08oVs8aLgp2zJUJmj6GUUzWnktIvL3Q+goLaClsPVhQRfIdmgnQ93xggyfIWoPwkjK2tXWN3oXL42HUSLn267QPJBWSkShGEkSRGSI1G0yebWUR+gyZ7Szm6rcl5q/SUzgtReDVh0ajQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542387; c=relaxed/simple;
	bh=rn8jBTTYsc1FQYmTxsywM4B48711DaE6Y2+r5qFEI/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evPsZd2/nZ7bBut/0BKrlhHUB7XiawzZF3uzM/yfOdBjlGsa70LD6MB1ICEElx6kRawUh5xM5KeEcCatkzzPl9txCy1q9p3H/Q8/bmBrWMaWC22/Lp4TIGiiBs//5omzirO4WgLzj/Z1BawE+pA/V0LAAQubNK2eDMDa/jbsmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vM9TuH0J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n1RUoIow; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D50351F387;
	Wed, 26 Feb 2025 03:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCIZshGrfhifrQzH3knExD2XMtBzrpwWTGikL/qxEyc=;
	b=vM9TuH0Ji4sjtilbvlGDYGz8D4rBp6ipzJRwn2Umy1L+zousNsiLYIFiZqQesP3rNvCaDE
	Ua4aA9Hjw+HIxYMjNDVgxX9RP5Y6hRM+2JwcxB/X9011F5gonwHdenrjC4SYBF4QqBrjSP
	TUEO0Omndy9yJr5i/M9DFRtEsSg5D+c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=n1RUoIow
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCIZshGrfhifrQzH3knExD2XMtBzrpwWTGikL/qxEyc=;
	b=n1RUoIowSWIFGCnO3i0HcySjS0Lvn+9bOWQufT9yVabgPbWQuFtbewb+Mi98vG80G16llV
	ehPsXS/JSzWstqK0TIOMeetNe//zLS5RUAIjOnBkwC04zTJ89HzhMTEHVausI/OwBWEkG1
	Y5OkG1ayCozmlTdGnCt4DfbVjNNwkYk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA90113404;
	Wed, 26 Feb 2025 03:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MFZIIqyRvmdOegAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 26 Feb 2025 03:59:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs-progs: docs: add an extra note to btrfs data checksum and directIO
Date: Wed, 26 Feb 2025 14:29:14 +1030
Message-ID: <3ec3396e9b4c02031a5a050763557c82a8852c75.1739780705.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740542229.git.wqu@suse.com>
References: <cover.1740542229.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D50351F387
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
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


