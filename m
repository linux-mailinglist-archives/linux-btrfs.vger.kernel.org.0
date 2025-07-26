Return-Path: <linux-btrfs+bounces-15691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BEB12CFA
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD653B0E73
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 22:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C442045B7;
	Sat, 26 Jul 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t88LF4BF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t88LF4BF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD6262BE
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569229; cv=none; b=fHjiOcXlO1XfVW1popIFK3wpx2lWzZVR/IoTgCgmHg761+tl2l4m3FxopwedycWwonCEjvbXttLSuGSHAorqfkNvg+583jxsJFkYC42Is8Fs9hTekdbe5347ZpGVvfj7pjf7UeYbDfKzGceMnXR3UNlcBBNNC02s2SHoEeh0zGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569229; c=relaxed/simple;
	bh=gD1Dp2TttLWNNxcSr3droKN56Y3U6IeMbhGZLeIi3rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkHT+Tik6kOXNnMscX5tP5ERNPMu5p7JD90LEnQksCPkIK2UHXf3MGSFeIcLwI9EjgFn3PSSeADaph8HNwH55hnaUNY2atyzBvbdVKmdvZSJczK0z9Ulore/ugNYiIKu9R5P0wviiYQUbg6Uo5W9yaHFygC8rchbLsHND7Xanro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t88LF4BF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t88LF4BF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32D121F45F;
	Sat, 26 Jul 2025 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDytRchxgsfMPXyKDXnonZ1HGg8lgiHgk57jQ3bIbbw=;
	b=t88LF4BF4VhfLr686mVjUTNi0nQtXmxZU/WqHuZqsRyPICFJ+iiOn7Y8G+PfraSg9hhJAG
	B38JRvEMnuwceS6cz3M9spmeX6UkO5yTd+bdrC3pRSknJ+7GQNZOO2Vyn3uYu73HwrBNU/
	6bA8ghuTVvnMDoB+nqNTRiRDQLpeYys=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDytRchxgsfMPXyKDXnonZ1HGg8lgiHgk57jQ3bIbbw=;
	b=t88LF4BF4VhfLr686mVjUTNi0nQtXmxZU/WqHuZqsRyPICFJ+iiOn7Y8G+PfraSg9hhJAG
	B38JRvEMnuwceS6cz3M9spmeX6UkO5yTd+bdrC3pRSknJ+7GQNZOO2Vyn3uYu73HwrBNU/
	6bA8ghuTVvnMDoB+nqNTRiRDQLpeYys=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 212A81388B;
	Sat, 26 Jul 2025 22:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KOKxNLdXhWjWLAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 26 Jul 2025 22:33:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v2 3/3] btrfs-progs: fsck-tests: a new test case for missing root orphan item
Date: Sun, 27 Jul 2025 08:03:02 +0930
Message-ID: <f5787d7a494dbb6d8a661eac92c460150cb3209c.1753569083.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753569082.git.wqu@suse.com>
References: <cover.1753569082.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The new image is created by:

- Make btrfs_delete_subvolume() to commit transaction
  So that we're sure the orphan item is committed to disk after removing
  the subvolume.

- Remove the orphan item from tree root

Then use this image to make sure btrfs check can detect such problem.
Repair is not yet supported.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../066-missing-root-orphan-item/default.img.xz | Bin 0 -> 13468 bytes
 .../066-missing-root-orphan-item/test.sh        |  14 ++++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/default.img.xz
 create mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh

diff --git a/tests/fsck-tests/066-missing-root-orphan-item/default.img.xz b/tests/fsck-tests/066-missing-root-orphan-item/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..c34f989daf0aef34e2692f2d11d4d4b1417ccdb5
GIT binary patch
literal 13468
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
UGOX`gy=UW*^xsS%NtVbc0Jn2zga7~l

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/066-missing-root-orphan-item/test.sh b/tests/fsck-tests/066-missing-root-orphan-item/test.sh
new file mode 100755
index 000000000000..9db625714c1f
--- /dev/null
+++ b/tests/fsck-tests/066-missing-root-orphan-item/test.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+#
+# Verify that check can report missing orphan root itemm as an error
+
+source "$TEST_TOP/common" || exit
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "missing root orphan item not reported as an error" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.50.1


