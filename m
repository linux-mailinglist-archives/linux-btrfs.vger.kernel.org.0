Return-Path: <linux-btrfs+bounces-5808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BF90E2B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 07:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3271C224C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 05:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE35C8FC;
	Wed, 19 Jun 2024 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KsU6Cpw8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KsU6Cpw8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322554FAD
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775246; cv=none; b=sWT2MifL3Og11RcV1KNShZNx+CptL9ODy2fiBw7L0IxuOT18J6TSNTpNkCN/CT0pCn5cF6iHm10W9wUUOS032eJh3+uPaPCDAbAcmR9BmS0v2mEACydXjwAeV0yPguV7C+hqurV6EyNhKCC2CKZvkS828Hm66WPHYOPwaWqwtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775246; c=relaxed/simple;
	bh=aVzSGzpRNhQjsZmEpaW9oa+MB4tOHXV+C6h6a6tlhGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKsmQnT48/r+oE4UweJyS8cBrZG1AHDO29nfx/qdCS8MnUJbXadk3gehZ+cGG9XSt5jKrRGVvxNhNKQPRWDtQFHwlrOAC8RJY5KE/7814qJfRO+t8w6iPrIIYqXy3lKCHgKP+KZg3NE87SscUQSxWhm5eK+M6lU6F5LJ7O4OgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KsU6Cpw8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KsU6Cpw8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AD7A21A2C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cvz+nIc1yJ2BPQsX7bSatE4i5BU1sG3xD7WTA66AHTQ=;
	b=KsU6Cpw8zHz2d4ZXO+99cyd9iYjR3Qo6mg/0HWrhHZOWjRcMeyKaG/v1oZQopXWAknlDFI
	/2rtyON2LHWGOauR9nqqzBwo8U4zywZnjJw1JmRWADwEzAvPjpQQGk/PZf/MzPaGQLCJ20
	xcqhD5VKySrt+em8DmOmdcgGvwviG/Y=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718775243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cvz+nIc1yJ2BPQsX7bSatE4i5BU1sG3xD7WTA66AHTQ=;
	b=KsU6Cpw8zHz2d4ZXO+99cyd9iYjR3Qo6mg/0HWrhHZOWjRcMeyKaG/v1oZQopXWAknlDFI
	/2rtyON2LHWGOauR9nqqzBwo8U4zywZnjJw1JmRWADwEzAvPjpQQGk/PZf/MzPaGQLCJ20
	xcqhD5VKySrt+em8DmOmdcgGvwviG/Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 709E013AAF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qL7zCcptcmYUaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 05:34:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: misc-tests: add a basic resume test using error injection
Date: Wed, 19 Jun 2024 15:03:39 +0930
Message-ID: <977dda7e1d53682ac275444c9db87a256c262c77.1718775066.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718775066.git.wqu@suse.com>
References: <cover.1718775066.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The new test case does:

- Inject error at the very first commit transaction to make sure the
  injection is compiled in
- Inject error at the last commit transaction of new data csum
  generation
- Resume the csum conversion and make sure it works

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../065-csum-conversion-inject/test.sh        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 tests/misc-tests/065-csum-conversion-inject/test.sh

diff --git a/tests/misc-tests/065-csum-conversion-inject/test.sh b/tests/misc-tests/065-csum-conversion-inject/test.sh
new file mode 100755
index 000000000000..10d3cf02063b
--- /dev/null
+++ b/tests/misc-tests/065-csum-conversion-inject/test.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+# Verify the csum conversion can still resume after an interruption
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+check_experimental_build
+setup_root_helper
+prepare_test_dev
+
+check_injection()
+{
+	run_check_mkfs_test_dev --csum crc32c
+
+	# This is for the very first transaction commit.
+	export INJECT="0x3964edd9"
+	run_mayfail "$TOP/btrfstune" --csum xxhash "$TEST_DEV" &&\
+		_not_run "this test requires debug build with error injection"
+	unset INJECT
+}
+
+test_resume_data_csum_generation()
+{
+	local new_csum="$1"
+
+	# Error at the end of the data csum generation.
+	export INJECT="0x4de02239"
+	run_mustfail "error injection not working" "$TOP/btrfstune" \
+		--csum "$new_csum" "$TEST_DEV"
+	unset INJECT
+	run_check "$TOP/btrfstune" --csum "$new_csum" "$TEST_DEV"
+	run_check "$TOP/btrfs" check --check-data-csum "$TEST_DEV"
+}
+
+check_injection
+
+run_check_mkfs_test_dev --csum crc32c
+
+# We only mount the filesystem once to populate its contents, later one we
+# would never mount the fs (to reduce the dependency on kernel features).
+run_check_mount_test_dev
+populate_fs
+run_check_umount_test_dev
+
+test_resume_data_csum_generation xxhash
+test_resume_data_csum_generation blake2
+test_resume_data_csum_generation sha256
+test_resume_data_csum_generation crc32c
-- 
2.45.2


