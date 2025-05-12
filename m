Return-Path: <linux-btrfs+bounces-13867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C93AB2F02
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 07:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37B31784FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 05:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AD2550A9;
	Mon, 12 May 2025 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RjUJwPoD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RjUJwPoD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229619DF41
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747027579; cv=none; b=pqz7En6BjIuuwRh9CxcnMZASpeZEgeIQFMLfIIUxjyXjv4qwk5g4ZESfUCeJDsxllHP/DLdVBcl5YjWX0CUM0fbclz5xXE91R59CCjIQfY9pXMw+Plo9vnbkAB4nenirp+k3jb3GXkBrRuNeCBZxC9yTJabecTFI0v7wHL1jsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747027579; c=relaxed/simple;
	bh=Rbrr0n251goTD3DT/M6Bh89cPYf3x6faRWZfdmYLYTo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JbngyQt20dQ2QCllQoF4hxMaFbU2yp3ZQJuWPxvZrSnMkPdDtREGalCx4GN/k4Xqy4pwYw3ILRCuHEIaxV3N9RfIAET6rlAmnJT/je3lpxw2tegkQ3Skx0dCyc//56TrgthcrugBrHIIDG4R4v5e8Ep23TTbJ9UrBvKEInK3F3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RjUJwPoD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RjUJwPoD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D44421197;
	Mon, 12 May 2025 05:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747027574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1hRMK3laAUEJXwPmiG9PM3q4Qdn/Xmd/GOu9Ia225aQ=;
	b=RjUJwPoDHeaHBNiJuRvRrXh3O7f47HCeCdvv2phmpI/mo7rr78TknZlzwR/N5zaFG2IElh
	rZrO0kkkTFFottSNkB3Y7fuxurBZy+17AMj3iYeGONhuDsYZqABrcn9L8Xo081deR0JXRU
	Mt7UJucr6UVTVplfHWoEoy2z0XzeYMU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747027574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1hRMK3laAUEJXwPmiG9PM3q4Qdn/Xmd/GOu9Ia225aQ=;
	b=RjUJwPoDHeaHBNiJuRvRrXh3O7f47HCeCdvv2phmpI/mo7rr78TknZlzwR/N5zaFG2IElh
	rZrO0kkkTFFottSNkB3Y7fuxurBZy+17AMj3iYeGONhuDsYZqABrcn9L8Xo081deR0JXRU
	Mt7UJucr6UVTVplfHWoEoy2z0XzeYMU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15480137D2;
	Mon, 12 May 2025 05:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y5u1MnSGIWhdZgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 12 May 2025 05:26:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
Date: Mon, 12 May 2025 14:55:51 +0930
Message-ID: <20250512052551.236243-1-wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80

There is a kernel bug report that scrub will trigger a NULL pointer
dereference when rescue=idatacsums mount option is provided.

Add a test case for such situation, to verify kernel can gracefully
reject scrub when  there is no csum tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/336     | 32 ++++++++++++++++++++++++++++++++
 tests/btrfs/336.out |  2 ++
 2 files changed, 34 insertions(+)
 create mode 100755 tests/btrfs/336
 create mode 100644 tests/btrfs/336.out

diff --git a/tests/btrfs/336 b/tests/btrfs/336
new file mode 100755
index 00000000..f76a8e21
--- /dev/null
+++ b/tests/btrfs/336
@@ -0,0 +1,32 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 336
+#
+# Make sure read-only scrub won't cause NULL pointer dereference with
+# rescue=idatacsums mount option
+#
+. ./common/preamble
+_begin_fstest auto scrub quick
+
+_fixed_by_kernel_commit 6aecd91a5c5b \
+	"btrfs: avoid NULL pointer dereference if no valid extent tree"
+
+_require_scratch
+_scratch_mkfs >> $seqres.full
+
+_try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
+	_notrun "rescue=ignoredatacsums mount option not supported"
+
+# For unpatched kernel this will cause NULL pointer dereference and crash the kernel.
+# For patched kernel scrub will be gracefully rejected.
+$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
+
+_scratch_unmount
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
new file mode 100644
index 00000000..9263628e
--- /dev/null
+++ b/tests/btrfs/336.out
@@ -0,0 +1,2 @@
+QA output created by 336
+Silence is golden
-- 
2.47.1


