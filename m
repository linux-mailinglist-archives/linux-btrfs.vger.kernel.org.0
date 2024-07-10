Return-Path: <linux-btrfs+bounces-6347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FA92DD11
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 01:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808951F26231
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 23:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AE16CD16;
	Wed, 10 Jul 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gxdgmzfn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gxdgmzfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FAE16DEDA;
	Wed, 10 Jul 2024 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654984; cv=none; b=ty1L5M75IAekrFa04v6LSPSBFeknBvteVFS/JRYVfFf/5VnS1mNiWU7nRR4PzdhtQQgSg0JWSvJVPTwU3EXLTHvjF1+QSpineU4+cmn/FGzePjOEOuQIvFIxlDjnhyPkS3SpUrD1xrdHpAfPN+n/J1qmve2/vidiUtZiqmN9FCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654984; c=relaxed/simple;
	bh=ie3ucnhyVwls/Qm5ooMM2s6d46s8a/rJKU1dw6qeZp8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PgwaYsyyzI9BPhC7pu/5nY15r3ymmtH7HJG8JdwLMhjOqhMyRFI6ET/8MGglkOCC/LyqYAUWaIXbeewNaEMbth5uBu/OTc5o8h0aC874fJ4oXbSGEoAPvmaI+cNw48NIZ7ACnqAiiUxrlxPwl1erDx5fscm35Z18Kdr4AWAx1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gxdgmzfn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gxdgmzfn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97EF321B52;
	Wed, 10 Jul 2024 23:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720654980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fUUiTTSz9TsfeVxDrRo7Iof7cQnz3KXULloL7ONmgH4=;
	b=GxdgmzfnxwaOoF4jDfneXzpPbFQRBrxV7kX/iBxTQhWwJho5FtF/yQHfbPSCwCLhCIYPci
	oLLe8O9Jgxl4GIhx6pBvxKU470fIM3v3DOJzpMmuYTokpEurotgbmf0jLPiERsR4KBf9HD
	phUMIaKU8sjb5lEGEE3Omsiq0Mul0mA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720654980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fUUiTTSz9TsfeVxDrRo7Iof7cQnz3KXULloL7ONmgH4=;
	b=GxdgmzfnxwaOoF4jDfneXzpPbFQRBrxV7kX/iBxTQhWwJho5FtF/yQHfbPSCwCLhCIYPci
	oLLe8O9Jgxl4GIhx6pBvxKU470fIM3v3DOJzpMmuYTokpEurotgbmf0jLPiERsR4KBf9HD
	phUMIaKU8sjb5lEGEE3Omsiq0Mul0mA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C732137D2;
	Wed, 10 Jul 2024 23:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iz01CYMcj2bCUAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 10 Jul 2024 23:42:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/029: add fixes for the kernel behavior change
Date: Thu, 11 Jul 2024 09:12:55 +0930
Message-ID: <6e7ee8ec1731b5d3d44f511b075fa2edb0b38661.1720654947.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.27 / 50.00];
	BAYES_HAM(-2.47)[97.61%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.27
X-Spam-Level: 

Since fstests commit 866948e00073 ("btrfs/029: change the cross vfsmount
reflink test"), the test case will fail for older kernels (e.g. 5.14
kernels from SLE).

The failure is a false alert, but it would still take some time to
figure it out.
So add the fixes tag to make it more clear that it's a kernel behavior
change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/029 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/029 b/tests/btrfs/029
index 9b56cc73f818..16d9dc2fcc19 100755
--- a/tests/btrfs/029
+++ b/tests/btrfs/029
@@ -23,6 +23,11 @@ _begin_fstest auto quick clone
 
 _supported_fs btrfs
 
+_fixed_by_kernel_commit ae460f058e9f \
+	"btrfs: remove the cross file system checks from remap"
+_fixed_by_kernel_commit 9f5710bbfd30 \
+	"fs: allow cross-vfsmount reflink/dedupe"
+
 _require_test
 _require_scratch
 _require_cp_reflink
-- 
2.45.2


