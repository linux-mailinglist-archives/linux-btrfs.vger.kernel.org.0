Return-Path: <linux-btrfs+bounces-6945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C694440A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 08:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515E5283D8D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 06:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829C1922C5;
	Thu,  1 Aug 2024 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZV2erX/b";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZV2erX/b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934661917D9
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492793; cv=none; b=sqpj6oa7X2QPDYYgsMS7KMNtZ/SCkIHFPaUOKHcnIU0t/oYRH6vFMPKLrCUwiWe7HMfSKjs3zPAYtGAVkl1UzzRapI6zRYsh4beV9gGIniSpkZ5z+HdqGS90hB4PRZ2PxWNS9YiXTgW9MTiluJuLh1gcCDjpY5IBPkhiKX1LE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492793; c=relaxed/simple;
	bh=4jSHLXbckMyFdpvLLPLsmFSwKAiBgQAVBqNH4vDH0c4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spUSbie+IP4SwIoNqfil/hQxMa4wBY2nbsqR+LtUdYB5b0M21UJOQswl28ThZJuXc5L7OKtw9l1WNN4AWKAubHB3R02VbJBHOIEY627Fb7dEVNY+jcx8x4cuXHHJe/swDBbPJW6HH9D+wzpdy+MVRbbaIoZva9rUnaWBpVn1iJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZV2erX/b; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZV2erX/b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAB961F8D7
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgK3nzBBDnlwTlLnCZiVF3fI0OeeUCvgsghSamUsFIQ=;
	b=ZV2erX/bnY84x0ALZ6jbiI7u7IcecFN/N9flCoXgvEsNJZmmK8Cy5Qeu6eNFt01kXMmh5Z
	s7AkVms52iMFImI+LQRUdJgr7dDDLzVjZ1r5cp/xi/q6jNFUlK8/GoosWzNpHpN0m+AoZi
	gkyv+jAhtJ+Rp+ovNSogcqXBFUvZhKA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgK3nzBBDnlwTlLnCZiVF3fI0OeeUCvgsghSamUsFIQ=;
	b=ZV2erX/bnY84x0ALZ6jbiI7u7IcecFN/N9flCoXgvEsNJZmmK8Cy5Qeu6eNFt01kXMmh5Z
	s7AkVms52iMFImI+LQRUdJgr7dDDLzVjZ1r5cp/xi/q6jNFUlK8/GoosWzNpHpN0m+AoZi
	gkyv+jAhtJ+Rp+ovNSogcqXBFUvZhKA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32A1913946
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oJtpN3Qnq2ZkaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2024 06:13:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs-progs: mkfs-tests: a new test case to verify handling of hard links
Date: Thu,  1 Aug 2024 15:42:39 +0930
Message-ID: <cfa3a9d4f18f11641a87f617feb073e54f03d79e.1722492491.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722492491.git.wqu@suse.com>
References: <cover.1722492491.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.40

The test case will create the following directory layout:

.
|- rootdir/
|  |- inside_link
|- outside_link

Both inside_link and outside_link are hard links of each other.
And use rootdir/ as the rootdir for mkfs.

This is to ensure the nlink of inside_link is correctly set to 1.

Inspired by the recent rework which fixes the handling of hard links.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../034-rootdir-extra-hard-links/test.sh      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100755 tests/mkfs-tests/034-rootdir-extra-hard-links/test.sh

diff --git a/tests/mkfs-tests/034-rootdir-extra-hard-links/test.sh b/tests/mkfs-tests/034-rootdir-extra-hard-links/test.sh
new file mode 100755
index 000000000000..e5c00cb861e9
--- /dev/null
+++ b/tests/mkfs-tests/034-rootdir-extra-hard-links/test.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+#
+# Test if "mkfs.btrfs --rootdir" would handle hard links where one
+# is inside the rootdir, the other out of the rootdir.
+
+source "$TEST_TOP/common" || exit
+
+prepare_test_dev
+
+tmpdir=$(_mktemp_dir mkfs-rootdir-hardlinks)
+
+mkdir "$tmpdir/rootdir"
+touch "$tmpdir/rootdir/inside_link"
+ln "$tmpdir/rootdir/inside_link" "$tmpdir/outside_link"
+
+run_check "$TOP/mkfs.btrfs" --rootdir "$tmpdir/rootdir" -f "$TEST_DEV"
+
+# For older mkfs.btrfs --rootdir we will create inside_link with 2 links,
+# but since the other one is out of the rootdir, there should only be one
+# 1 link, leading to btrfs check fail.
+#
+# The new behavior will split all hard links into different inodes, thus
+# have correct nlink for each new inode.
+run_check "$TOP/btrfs" check "$TEST_DEV"
-- 
2.45.2


