Return-Path: <linux-btrfs+bounces-5867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C92911A38
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 07:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CC41F2249B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52613C68C;
	Fri, 21 Jun 2024 05:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qNm4jRyS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qNm4jRyS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD441369BB
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947047; cv=none; b=mIAHrDdne6taSPyIHKHZegd3PRcCjiWW2lDb5UU3kFs1JAwSpWqeg1+7Ghkd2rR59BVAugcWiH+jMGVt/S8AZ9mGFmH2EQRRaFzFdU8X8MJcgltDoiZoqJifTuX2pploY7b5idFNxMaamCZR/1vA5kdaUEGD1bjOMc+5VoCXeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947047; c=relaxed/simple;
	bh=B45wM2FHxNLZE4fj6/kBPOgy7k1pLQ3vtxvY4CpVidk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msCkw6E4ktfv/0G6FjZsPBGFPmEGPNi1+Aa8CVLD6G8ed6LjJu7LxYvmCrFMbEl63yTQ7Wp7AYfLGLK2s5SYU5BBHcQ4tlBm0Yptsr3H2jsTLBgvAYFjRwb20QDWkLR8GDoz/rZV3SunsrSH/gWr7sGdSIrhtgWnjIVAG3u7mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qNm4jRyS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qNm4jRyS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDA5921AB6
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jw5xUZeGYpfF999dczFDMP5KGW6iKevnYsK3DhBF2g=;
	b=qNm4jRyS9YuAArxyDBOXr+RsWpeldn1NLQnFBFgWzPtWAD9xUL4hV7RGIA0FXKPxPEcl5y
	XbrOHco2u71yDJv8N0OR6mnukofokITEV+16gCINA5SUOS25sHLrVZNsLN3uhKth1MI3KI
	l86NOEnjy3wx25YPu8McJJIVUKzFBgM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718947043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jw5xUZeGYpfF999dczFDMP5KGW6iKevnYsK3DhBF2g=;
	b=qNm4jRyS9YuAArxyDBOXr+RsWpeldn1NLQnFBFgWzPtWAD9xUL4hV7RGIA0FXKPxPEcl5y
	XbrOHco2u71yDJv8N0OR6mnukofokITEV+16gCINA5SUOS25sHLrVZNsLN3uhKth1MI3KI
	l86NOEnjy3wx25YPu8McJJIVUKzFBgM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C988713AAA
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4JaCH+IMdWavbAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 05:17:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: misc-tests: add a basic resume test using error injection
Date: Fri, 21 Jun 2024 14:46:56 +0930
Message-ID: <470dda58291481fe01e53d904be3db6141ff93fb.1718946934.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718946934.git.wqu@suse.com>
References: <cover.1718946934.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.972];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
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
  Furthermore check the stdout/stderr to make sure the failure is really
  caued by the error injection.

- Inject error at the last commit transaction of new data csum
  generation

- Resume the csum conversion and make sure it works

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../065-csum-conversion-inject/test.sh        | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100755 tests/misc-tests/065-csum-conversion-inject/test.sh

diff --git a/tests/misc-tests/065-csum-conversion-inject/test.sh b/tests/misc-tests/065-csum-conversion-inject/test.sh
new file mode 100755
index 000000000000..c213232ec545
--- /dev/null
+++ b/tests/misc-tests/065-csum-conversion-inject/test.sh
@@ -0,0 +1,61 @@
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
+	local tmp_output=$(mktemp --tmpdir btrfs-progs-check-injection.XXXXXX)
+	local ret
+
+	run_check_mkfs_test_dev --csum crc32c
+
+	# This is for the very first transaction commit.
+	export INJECT="0x3964edd9"
+	"$TOP/btrfstune" --csum xxhash "$TEST_DEV" &> "$tmp_output"
+	ret=$?
+	cat "$tmp_output" >> "$RESULTS"
+	if [ "$ret" -eq 0 ]; then
+		_not_run "this test requires debug build with error injection"
+	fi
+	if ! grep -q "$INJECT" "$tmp_output"; then
+		rm "$tmp_output"
+		unset INJECT
+		_fail "csum conversion failed for unexpected reasons."
+	fi
+	rm "$tmp_output"
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


