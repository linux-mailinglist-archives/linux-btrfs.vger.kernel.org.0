Return-Path: <linux-btrfs+bounces-14108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7972ABB478
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 07:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD881896553
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E81F3B91;
	Mon, 19 May 2025 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m2ecg5y3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JmqqVn6l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574D1F1507
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747632557; cv=none; b=Dfw3s/qQ3d/bYcZTdFDRobOkTxx3Er/AqLIfvTUgqFYxAqT4AEtlORPD51Y0JLXRyGF30ysU0vo+EOjsOaVSKE8GgDX22BYRsBJ+cgL3Lfhe6MenLN1AjdBXHQMRMGMYpi2/a6OGLaIvlz91aCo1X1BM7BpSR1PP807i+G375fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747632557; c=relaxed/simple;
	bh=IhLnIK8HYyn8QD7/qcVYRtcuWG5rpr7ecSoZZu3kWo8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TrZOR+uHyxuVsKWQHb8+wLLVPNx5gELlYk32Iumcs+tcJmGFFOiNUSMp0kOgwKpe+rprX03Tga9xOPfcvwkBdESE4iCIu+LOQiGvx2cQQ7btyM53H7mMu7hX9yPElqJ17gaaiYo48tKZAipEqEon4Ul1xDOY6G6IPUBKwZWARQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m2ecg5y3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JmqqVn6l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3826C201CF;
	Mon, 19 May 2025 05:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747632547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l+w6BCigPIrGW1IOQSUxzQH0EOjRlgKmejNBmOE11L0=;
	b=m2ecg5y3+TtRXemt9Kr9GxQ7+6KZPUxviT/OAd/HpSBPzPS0Ei7TK084TKyoSkItQ+LRRd
	u8O0/bxX3pj+TUL/pC2DGQb+pzq0ZGGcDj7yH2aK1YnnZd8uzu1G/9kaFbVPOMhYHNcLzq
	pYHO80HlwjJfQyqaAGRwZ6f0o9Tq4Qg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747632546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l+w6BCigPIrGW1IOQSUxzQH0EOjRlgKmejNBmOE11L0=;
	b=JmqqVn6l8cZFUplWY2PxB3730DW9pdlCg8uitYXBqza6Ya2zzmz2CXBohWufqzNvLGg7By
	75jcrMBIxNmxH3L4y5FQ9NdsJJfbC1R37gZKvvbApl+9zaSLpSjcWVbExv96KSe/c8M1na
	msjm2vDJL3xOiM87e5YRc8t2/hDgZog=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C1B31372E;
	Mon, 19 May 2025 05:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lD0yAKHBKmgpPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 19 May 2025 05:29:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/537: remove the btrfs specific mount option
Date: Mon, 19 May 2025 14:58:39 +0930
Message-ID: <20250519052839.148623-1-wqu@suse.com>
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
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Although btrfs deprecated "norecovery" mount option in upstream kernel
commit a1912f712188 ("btrfs: remove code for inode_cache and recovery
mount options"), later "norecovery" mount option is re-introduced for
compatibility by commit 440861b1a03c ("btrfs: re-introduce 'norecovery'
mount option").

Instead the btrfs specific mount option "nologreplay" is already
deprecated for a long time and is going to be removed soon.

So use the generic "norecovery" for all filesystems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/537 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/537 b/tests/generic/537
index 3be743c4..77d38bbf 100755
--- a/tests/generic/537
+++ b/tests/generic/537
@@ -55,7 +55,6 @@ fi
 
 echo "fstrim on ro mount with no log replay"
 norecovery="norecovery"
-test $FSTYP = "btrfs" && norecovery=nologreplay
 _scratch_mount -o ro,$norecovery >> $seqres.full 2>&1
 $FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full 2>&1 && \
 	echo "fstrim with unrecovered metadata just ate your filesystem"
-- 
2.49.0


