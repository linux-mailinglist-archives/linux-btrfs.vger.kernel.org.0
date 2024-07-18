Return-Path: <linux-btrfs+bounces-6560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3C99370B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACE6B21018
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47371465A1;
	Thu, 18 Jul 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z/CG/P5/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z/CG/P5/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42B5B1FB
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342029; cv=none; b=QlqT6+mSsboDvc8VKSFhjhyE7wXrM7NSa7rw/+ygVk8s3dkCC1Lc9Gxemst5ZTicbGQNw8+0tRWXUiIBPPtLmU9JF0jbkUKAsvTJYG/QJeUVVUvP9y2GpzbdIZlK5WTpNOYAh+Q/8TnICo/2KnFKYQRFBEIIAOIt5BmeGlU83Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342029; c=relaxed/simple;
	bh=BfQnu3di6PGWVRtLuEqzihLVxYiCM+NOF28X3fVonLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHaYx5qU21lKWAJsnLRLTlhuXkILraFBd6lQkYcQJreiEdTOMSVobFe6WGM0IU9LAW93j+QVhjIvRlfYp0FIU8e3/cH/Rfodi6iyZOWU8D1B/DRW37qyuosnSzFlDl43oRZRCnNXp/htM+6b/Bn+0HjLqakr8ii/V00UqHxZeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z/CG/P5/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z/CG/P5/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61A4A1F45E
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRDAzyTX8KAYEH4BQ5ek0XP72t2dsKdeXZOUuuSBCF8=;
	b=Z/CG/P5/dqzLTyYRj6yikfk1GRCNtg+QCL/mIRURpqTmj1ji8/7R9jjCN2f0vbFfpl83ns
	jLPNAqNr+ZXwjp/HpD2vmENGB+NM+8tnzFpWWQ38GZj9NM/VCgXLfB78aIULpyuYosp45u
	SGC3y9jiPvxSZvO9Kg45N413bu3uxV0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRDAzyTX8KAYEH4BQ5ek0XP72t2dsKdeXZOUuuSBCF8=;
	b=Z/CG/P5/dqzLTyYRj6yikfk1GRCNtg+QCL/mIRURpqTmj1ji8/7R9jjCN2f0vbFfpl83ns
	jLPNAqNr+ZXwjp/HpD2vmENGB+NM+8tnzFpWWQ38GZj9NM/VCgXLfB78aIULpyuYosp45u
	SGC3y9jiPvxSZvO9Kg45N413bu3uxV0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84F0F1379D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IGPbD0mYmWb9HAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs-progs: misc-tests: add a basic resume test using error injection
Date: Fri, 19 Jul 2024 08:03:21 +0930
Message-ID: <07a66693a71f8dbaf8e8eb580bb922a3fc21745a.1721341885.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721341885.git.wqu@suse.com>
References: <cover.1721341885.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

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
index 30857f153a22..4ff6addf20db 100644
--- a/tests/common
+++ b/tests/common
@@ -406,6 +406,13 @@ check_regular_build()
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


