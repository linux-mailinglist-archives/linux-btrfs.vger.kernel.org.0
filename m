Return-Path: <linux-btrfs+bounces-16577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EAB3F98F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44391B22F11
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBA2EB867;
	Tue,  2 Sep 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CZXCVmj9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TFFkhi7R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C62EB5AF
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803759; cv=none; b=F+jZ8IXy4hKVN72qs0254btVkc6yuMfzPIMkQsmhpAILOrI2tJM6I5D8eG5jPqTNVA6EA1c5R0/slWFn9lDhXoJMCKp0qyFcvY/O212ZFCnboQ6wN+n9HILYjGUrdSAqW9jPX2NJJUxOz88KpCd4OpS/8LiSC2N9s9Mp6oG0HZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803759; c=relaxed/simple;
	bh=dZ8lejRFEkUuU2lxgcyqqzsY3TURazY5mYqGYUVSmS8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIXpuwlpLowx3VIDl3UjBMb507P243Tb5Ows/KSeYJmIWRyy+pEYnsFx+Zf8yigqQua2+4ongQIr2t0dcONNqOmu9jDcHzOoPkk9JewcAJxDI/gy7zqWniHpN8B9Ddngopn2+cV56ucRWo/diNZH6jwCKONRmdE4TCZcb1riTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CZXCVmj9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TFFkhi7R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC8CA2119A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU6m0NaGtwnpTmLCDUhHf/bJJmH4J0l4dKDrFK5j/To=;
	b=CZXCVmj9S6EcoQosiN46ybRz3O/uuWC5PSpDl24U1mQeMO4w1IdtKYRSLKXB5/0pKvINru
	Y+Ge4ImArVaQReG+oMdy7trsTG3ycboBbfFaj9fDMSxuZ/5d0ts2LTfEV48NWG5XwqQsVT
	+rlwGIbVx6254h4Oux8Fj6bYfWDbEQ8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU6m0NaGtwnpTmLCDUhHf/bJJmH4J0l4dKDrFK5j/To=;
	b=TFFkhi7Rgh6GJrUHI0XMz76jmGXHe3TipmwHS6GH/slsTjD7WmQUT7zkX/DvbuphPQB2Vi
	5D5x6Ahbdqpinf6Sw00aP1pTcFdHUCS+emQ7EydtHox9fnUdz5DV/IuHhdTxHAtHPg3Gup
	Bz3tzRA5bLnH1YdrHe1HH0pKiLNareg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F82313888
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oPxWNKqytmgMBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 09:02:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: support all block sizes which is no larger than page size
Date: Tue,  2 Sep 2025 18:32:12 +0930
Message-ID: <7087a8832c7d186e53f64302eb6328a04cf3a91a.1756803640.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756803640.git.wqu@suse.com>
References: <cover.1756803640.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Currently if block size < page size, btrfs only supports one single
config, 4K.

This is mostly to reduce the test configurations, as 4K is going to be
the default block size for all architectures.

However all other major filesystems have no artificial limits on the
support block size, and some are already supporting block size > page
sizes.

Since the btrfs subpage block support has been there for a long time,
it's time for us to enable all block size <= page size support.

So here enable all block sizes support as long as it's no larger than
page size for experimental builds.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 335209fe3734..014fb8b12f96 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -78,6 +78,10 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
 
 	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
 		return true;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (blocksize <= PAGE_SIZE)
+		return true;
+#endif
 	return false;
 }
 
-- 
2.50.1


