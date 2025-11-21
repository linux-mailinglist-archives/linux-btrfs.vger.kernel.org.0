Return-Path: <linux-btrfs+bounces-19235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB7C77520
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 06:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8CAC4E6BD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E32D3A69;
	Fri, 21 Nov 2025 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aGKM0Gp4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aGKM0Gp4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3C298CB2
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763701784; cv=none; b=QfyRGrEkZ+7uHvVZ+6QIQJ4F/YYpHKoCvqANrkfZdC7WR6gX7UxgWxsXBwCpHGHaqvczAYtO2n4j2yh4XB9ywM/kMyLry9OuHFLsfQS2pwnJl0aA79YbmoBKZ7PBo05Yh34b55azKy3VfJqp8OoWMOrGljpY08GYMynhK+8RWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763701784; c=relaxed/simple;
	bh=iXXCnCWclUmOL1D7NsFsI5lhuIWCFKXxYTHW0tG618o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uhDF36zPtw5NwjQoJ94wUIspJrW1qD/slf/zpHyIBMT2yTfSy7Bxf/eIqj7PmUDRhmnHu6v2hTFLAjeGFvgKIPl01Num9cDoV+l76i6mSoRsAtpo3m0BIJt64EQ2G2KMfo388SbYSogEPtREkqDBkHVJHWXHR2SAjiSaTWM74Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aGKM0Gp4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aGKM0Gp4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BE7521285
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 05:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763701404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TvXOfpysiDe9qNObuzQMpEkpkXW8F50+Nrhl1CAGGPQ=;
	b=aGKM0Gp4sgP2QdYb7KZVwkRXSZs6vfyEIu7OKFO5dA8i4xsm3Qin+bEZL2WrFyT7TLvnc8
	IARdQW6Gaf3U7UGNRNq/eu39xC+uWquESM/tXnSGjfXJ96TdKU/clIOlZPdaR81KCI4CeC
	zMCEnapXWKtd24IR9htzVeSaN9b7lM4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763701404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TvXOfpysiDe9qNObuzQMpEkpkXW8F50+Nrhl1CAGGPQ=;
	b=aGKM0Gp4sgP2QdYb7KZVwkRXSZs6vfyEIu7OKFO5dA8i4xsm3Qin+bEZL2WrFyT7TLvnc8
	IARdQW6Gaf3U7UGNRNq/eu39xC+uWquESM/tXnSGjfXJ96TdKU/clIOlZPdaR81KCI4CeC
	zMCEnapXWKtd24IR9htzVeSaN9b7lM4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9841B3EA61
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 05:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z3p1FpvyH2l6ewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 05:03:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: add warning for btrfs checksum features
Date: Fri, 21 Nov 2025 15:33:05 +1030
Message-ID: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.895];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.78
X-Spam-Level: 

The checksum of btrfs, no matter the algorithm utilized, can not provide
any guarantee that the metadata/data is not modified by a malicious
attacker.

And refer end users to fs-verity if they require a strong verification
of a file.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This also makes me wonder, does it even make any sense to support
SHA256?

I know in the past it is an important step towards write-time dedupe,
but that feature eventually get rejected (and I totally agree the
decision).

And dedupe ioctl is also not utilizing checksum to verify if the content
matches, there is no real user requires cryptographic hash functions.

Which makes SHA256 not only the slowest checksum algorithm, but also the
largest one (takes 8x metadata space compared to CRC32C).

I'd say we should even deprecate SHA256 checksum support.
---
 Documentation/ch-checksumming.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ch-checksumming.rst b/Documentation/ch-checksumming.rst
index 72261c23fb8c..cc3cb43b175f 100644
--- a/Documentation/ch-checksumming.rst
+++ b/Documentation/ch-checksumming.rst
@@ -3,6 +3,17 @@ writing and verified after reading the blocks from devices. The whole metadata
 block has an inline checksum stored in the b-tree node header. Each data block
 has a detached checksum stored in the checksum tree.

+.. warning::
+   The checksum of btrfs is only to detect which mirrors is good, it can not
+   guarantee the data/metadata is not modified by any malicious attacker, no matter
+   the checksum algorithm utilized.
+
+   The attacker can always modify the file content, update the checksum tree to use
+   a newly calculated checksum.
+
+   For strong verification of read-only files, please use *fs-verity* feature,
+   which btrfs supports since v5.15.
+
 .. note::
    Since a data checksum is calculated just before submitting to the block
    device, btrfs has a strong requirement that the corresponding data block must
--
2.52.0


