Return-Path: <linux-btrfs+bounces-21459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD/dFC7Bhml1QgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21459-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 05:35:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 087EF104EBA
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 05:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB7D30182BA
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 04:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D12DB7B4;
	Sat,  7 Feb 2026 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jVbODMK0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jVbODMK0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3142D8DB5
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438945; cv=none; b=lVXGO8VGQO1s9YlslnOAdBxxj8w/9ElkWQPc6FUAq50BHI7XhVBQH3eCn58nvRUgXDs6rYkRHdQaTbM8aegYAHm9Sxg6O3mSFS0TndTsttQSTMM+BwjiTMPFM8ulLY9iRcDS+4SeySczYgWcxG9//xIsTCmk6WDryTjb5ebxUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438945; c=relaxed/simple;
	bh=Vk49zraOuUFjhmucyb/6tk3mylj5AHUrVAN3nvXAUg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldYYIyGPrO75qMIGYeV1HKuPGXvptHxilZjRNqxZRzVj9jvHq2+W3c05UwFBuN8S4Wz7/YldXLdqZDnP7fNdQuDsplyZPl2o50dVZeKgU80JywKJh3k8pkXAZ8sFr6QG7Fk/0PBRb4RBJJO5hsNnbABSL/B4LrXIyUU5quHk2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jVbODMK0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jVbODMK0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 548635BCCE
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 04:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770438943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLJTFnYJzhZuH9yEyRLH31UzxS3SgnovtUU6qPR5uFk=;
	b=jVbODMK00LRk8/EV7xijS5SminZvEV6tv77oyZIogw1eo+AkMRGOzri8EiDS8QmBv1fgdD
	hLp3f3n2tydJASynnIsh8osB6Eg8bEGSifpgW5oYAsdUs3SjCQGBBSZboeiqR3bn+culOk
	9F7wTsTMl6fTa6tfMqFrS3YWzcaUQfI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770438943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLJTFnYJzhZuH9yEyRLH31UzxS3SgnovtUU6qPR5uFk=;
	b=jVbODMK00LRk8/EV7xijS5SminZvEV6tv77oyZIogw1eo+AkMRGOzri8EiDS8QmBv1fgdD
	hLp3f3n2tydJASynnIsh8osB6Eg8bEGSifpgW5oYAsdUs3SjCQGBBSZboeiqR3bn+culOk
	9F7wTsTMl6fTa6tfMqFrS3YWzcaUQfI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84A443EA63
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 04:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJKzER7Bhmm0LQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 04:35:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests: output the directory path for missing custom script
Date: Sat,  7 Feb 2026 15:05:23 +1030
Message-ID: <a0cfce59143cf99e9c89baa0f4b0f189dfe40687.1770337623.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <bac89ac52147344ab6244beef8c0085552a3aacb.1770438921.git.wqu@suse.com>
References: <bac89ac52147344ab6244beef8c0085552a3aacb.1770438921.git.wqu@suse.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21459-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mkfs-tests.sh:url,suse.com:email,suse.com:dkim,suse.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 087EF104EBA
X-Rspamd-Action: no action

I hit a mkfs failure locally where I reverted the commit which
introduced the mkfs/040 test case.

However that directory didn't got removed as there are local image files
left due to previous test failure.

This results a very confusing error message:

    [TEST/mkfs]   039-zoned-profiles
 custom test script not found or lacks execution permission
 make: *** [Makefile:557: test-mkfs] Error 1

The reality is, the failure is caused by 040 not 039, but the error
message lacks the proper info on it.

Add the directory name for every test script, so that now the failure
will be more readable:

  TEST     mkfs-tests.sh
    [TEST/mkfs]   001-basic-profiles
 custom test script not found or lacks execution permission ("/home/adam/btrfs-progs/tests/mkfs-tests/002-empty-dir-to-fail")
 make: *** [Makefile:557: test-mkfs] Error 1

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/cli-tests.sh     | 2 +-
 tests/convert-tests.sh | 2 +-
 tests/fuzz-tests.sh    | 2 +-
 tests/misc-tests.sh    | 2 +-
 tests/mkfs-tests.sh    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/cli-tests.sh b/tests/cli-tests.sh
index 3a13cf70ffb0..55dd559c2694 100755
--- a/tests/cli-tests.sh
+++ b/tests/cli-tests.sh
@@ -75,7 +75,7 @@ do
 			_fail "test failed for case $name"
 		fi
 	else
-		_fail "custom test script not found or lacks execution permission"
+		_fail "custom test script not found or lacks execution permission (\"$i\")"
 	fi
 	cd "$TEST_TOP"
 done
diff --git a/tests/convert-tests.sh b/tests/convert-tests.sh
index f11adebd4edf..157a8118e79d 100755
--- a/tests/convert-tests.sh
+++ b/tests/convert-tests.sh
@@ -85,7 +85,7 @@ run_one_test() {
 		fi
 		check_test_results "$RESULTS" "$testname"
 	else
-		_fail "custom test script not found or lacks execution permission"
+		_fail "custom test script not found or lacks execution permission (\"$testdir\")"
 	fi
 }
 
diff --git a/tests/fuzz-tests.sh b/tests/fuzz-tests.sh
index 666f245836fd..52a2802f0e35 100755
--- a/tests/fuzz-tests.sh
+++ b/tests/fuzz-tests.sh
@@ -74,7 +74,7 @@ do
 			_fail "test failed for case $(basename $i)"
 		fi
 	else
-		_not_run "custom test script not found or lacks execution permission"
+		_not_run "custom test script not found or lacks execution permission (\"$i\")"
 	fi
 	cd "$TEST_TOP"
 done
diff --git a/tests/misc-tests.sh b/tests/misc-tests.sh
index 2cb8d6081c17..28756c2acde7 100755
--- a/tests/misc-tests.sh
+++ b/tests/misc-tests.sh
@@ -82,7 +82,7 @@ do
 		fi
 		check_test_results "$RESULTS" "$name"
 	else
-		_fail "custom test script not found or lacks execution permission"
+		_fail "custom test script not found or lacks execution permission (\"$i\")"
 	fi
 	cd "$TEST_TOP"
 done
diff --git a/tests/mkfs-tests.sh b/tests/mkfs-tests.sh
index 55d1dc7ac3e9..6ab1fb77d62b 100755
--- a/tests/mkfs-tests.sh
+++ b/tests/mkfs-tests.sh
@@ -77,7 +77,7 @@ do
 		fi
 		check_test_results "$RESULTS" "$name"
 	else
-		_fail "custom test script not found or lacks execution permission"
+		_fail "custom test script not found or lacks execution permission (\"$i\")"
 	fi
 	cd "$TEST_TOP"
 done
-- 
2.52.0


