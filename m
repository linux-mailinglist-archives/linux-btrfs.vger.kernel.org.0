Return-Path: <linux-btrfs+bounces-6555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2460E937092
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25891F229D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901B146599;
	Thu, 18 Jul 2024 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sx/yAe0c";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sx/yAe0c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CE146016
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340676; cv=none; b=IHJAegJSm6lYjpgVeV6LMa1StHFgQAHgNIFl9tPzGw9cHpnhxC8Ty+UCUvxgrSB5mZw3n/1tIgAhfhoOxnyIzAZZqdxIEYcvtuGaPYWJOvFX8E+G1C170DETLQO8kt4rQSUvS6Chi9AOAAD5YHOFhKRIDn6B6K+vNKdbxFSpJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340676; c=relaxed/simple;
	bh=YMNwuKHxrWOZIrVrNc73wXjzmTBEn2MSb89DH7ekUHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWVzzc5WcoxzSx7eYi1VyXE+u1mcNyBocUa5NddvvZWMQeX4Bv0Rfqia55ouwh61I1xY1iI1rO4mWF5oAIN+2z97+1tFECm1kc+fG9u7FsAbTRhPpoNyW5t0nd5vzUh6mkqUFLlQ+yqD3YqhMOD5LxdbSxk/Si1Z5SXAdNKbyyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sx/yAe0c; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sx/yAe0c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C697721AF5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hOOFTf0JQg/6KOxdrdzzjfFshogkW9/gE4fpxqBFcM=;
	b=Sx/yAe0cZSpoMCk57gj4WRiHe7kkS8JA7guiMtLOsrOFgtAIdTdR1gX04jChHORvZU2IRx
	zYbbOqnlCHOGrkXDtYw3+V/JHS3R8A00Z0fu+jhLf3guceV+ZNGGLHlBxj/MCj7aKwhW9y
	Jz3GxL9NsRzOYOh9ro6p2hklvcEJ1kQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Sx/yAe0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721340672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hOOFTf0JQg/6KOxdrdzzjfFshogkW9/gE4fpxqBFcM=;
	b=Sx/yAe0cZSpoMCk57gj4WRiHe7kkS8JA7guiMtLOsrOFgtAIdTdR1gX04jChHORvZU2IRx
	zYbbOqnlCHOGrkXDtYw3+V/JHS3R8A00Z0fu+jhLf3guceV+ZNGGLHlBxj/MCj7aKwhW9y
	Jz3GxL9NsRzOYOh9ro6p2hklvcEJ1kQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB49B1379D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAr9KP+SmWZZFwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:11:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs-progs: misc-tests: add a basic resume test using error injection
Date: Fri, 19 Jul 2024 07:40:45 +0930
Message-ID: <4556c3b266244552477186a27fb4b4a0c40c0310.1721340621.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721340621.git.wqu@suse.com>
References: <cover.1721340621.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C697721AF5
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

The new test case does:

- Make sure the build has error injection support
  This is done by checking "btrfs --version" output.

- Inject error at the last commit transaction of new data csum
  generation

- Resume the csum conversion and make sure it works

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common                                  |  7 +++
 .../065-csum-conversion-inject/test.sh        | 45 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/misc-tests/065-csum-conversion-inject/test.sh

diff --git a/tests/common b/tests/common
index 4800ef8e77c9..f6b68a418087 100644
--- a/tests/common
+++ b/tests/common
@@ -402,6 +402,13 @@ check_regular_build()
 	fi
 }
 
+check_injection()
+{
+	if ! _test_config "INJECT"; then
+		_not_run "This test requires error injection support (make D=1)"
+	fi
+}
+
 check_prereq()
 {
 	# Internal tools for testing, not shipped with the package
diff --git a/tests/misc-tests/065-csum-conversion-inject/test.sh b/tests/misc-tests/065-csum-conversion-inject/test.sh
new file mode 100755
index 000000000000..715349c4d403
--- /dev/null
+++ b/tests/misc-tests/065-csum-conversion-inject/test.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+# Verify the csum conversion can still resume after an interruption
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+check_experimental_build
+check_injection
+setup_root_helper
+prepare_test_dev
+
+test_resume_data_csum_generation()
+{
+	local new_csum="$1"
+	local tmp=$(_mktemp "csum-convert")
+
+	# Error at the end of the data csum generation.
+	export INJECT="0x4de02239"
+	run_mustfail_stdout "error injection not working" \
+		"$TOP/btrfstune" --csum "$new_csum" "$TEST_DEV" &> $tmp
+	cat "$tmp" >> "$RESULTS"
+	if ! grep -q "$INJECT" "$tmp"; then
+		rm -f -- "$tmp"
+		_fail "csum conversion failed to unexpected reason"
+	fi
+	rm -f -- "$tmp"
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


