Return-Path: <linux-btrfs+bounces-19367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DE0C8CDE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 06:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F3BF4E2284
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 05:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2CF312800;
	Thu, 27 Nov 2025 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pcA5tL7J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pcA5tL7J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2A1EA7CC
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764221128; cv=none; b=QZpjXi3hPAfSwiM0tu0vUkN0hefX+BpJ7/HgX1XeuEpbtABjyw9N3skTuMf+mdepHBsGiVGs79We4mNTaSlqgl4aRv5GPHS4hA1DjUDstFryLzTjW6wEFkSlrr4ZA+hjv0GnmQH+bU9JO84eN+fxLqjGCTUrpVcOpChQAEdBS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764221128; c=relaxed/simple;
	bh=Oo3QQYQXbilpi5G3pZ1xx7vGMIFzgxaY18dMQfHcV+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZYB9ttBP2gMK95Jbjv3vciAq8+h2+913+BbllBe2m+cXYor7yanAJytsFxszAg1bh0nnNQ2309jbB6HGndP0OQEYnnMjvoVuh0pPD105KykkV1Yf57ilNoYWlqkxEZo92qf32gBRjgHADjnlHAdTL6WEtoT2zRxMzVF724FzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pcA5tL7J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pcA5tL7J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85ECA33682
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgExFJ3oLI4Jp3NSh2oQFQMRfH7ckmTm/KkqQXrmlKc=;
	b=pcA5tL7J6y47CiKzYJ2lulMhM18v/V3EDEJ5AJbnl1j4+6ezE7zqmFPDQtham4RfMaEiBi
	u/ztkpTFKRBPQZTbOWV1Gybb/k2UqOkn4ss42qhULJe2bFivcJpZ6ywHDnUX8ETJA4XWYb
	2fsb+GgjmhhxPBJntjZwTTEQvxGct0U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pcA5tL7J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgExFJ3oLI4Jp3NSh2oQFQMRfH7ckmTm/KkqQXrmlKc=;
	b=pcA5tL7J6y47CiKzYJ2lulMhM18v/V3EDEJ5AJbnl1j4+6ezE7zqmFPDQtham4RfMaEiBi
	u/ztkpTFKRBPQZTbOWV1Gybb/k2UqOkn4ss42qhULJe2bFivcJpZ6ywHDnUX8ETJA4XWYb
	2fsb+GgjmhhxPBJntjZwTTEQvxGct0U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C37103EA65
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CMhKIcPgJ2l3fgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: tests: disable bgt feature for ^no-holes and ^fst runs
Date: Thu, 27 Nov 2025 15:55:02 +1030
Message-ID: <4368977cf6aac97160d89345af5df195d412470b.1764220734.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764220734.git.wqu@suse.com>
References: <cover.1764220734.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 85ECA33682

The no-so-new block-group-tree feature requires both no-holes and
free-space-tree features.

For the incoming default block-group-tree feature at mkfs and convert
time, this will cause errors and mkfs/convert will reject the run due to
missing dependency features.

Change test cases that uses ^no-holes or ^fst to also disable
block-group-tree feature to avoid such false alerts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/cli-tests/009-btrfstune/test.sh                  | 2 +-
 tests/misc-tests/001-btrfstune-features/test.sh        | 9 +++++----
 tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/cli-tests/009-btrfstune/test.sh b/tests/cli-tests/009-btrfstune/test.sh
index c3d0f0254679..e01190a53070 100755
--- a/tests/cli-tests/009-btrfstune/test.sh
+++ b/tests/cli-tests/009-btrfstune/test.sh
@@ -20,7 +20,7 @@ run_check "$TOP/btrfstune" -r "$TEST_DEV"
 run_check_mkfs_test_dev -O ^skinny-metadata
 run_check "$TOP/btrfstune" -x "$TEST_DEV"
 
-run_check_mkfs_test_dev -O ^no-holes
+run_check_mkfs_test_dev -O ^no-holes,^block-group-tree
 run_check "$TOP/btrfstune" -n "$TEST_DEV"
 
 run_check_mkfs_test_dev
diff --git a/tests/misc-tests/001-btrfstune-features/test.sh b/tests/misc-tests/001-btrfstune-features/test.sh
index 081411107aab..ee4235ffb0ef 100755
--- a/tests/misc-tests/001-btrfstune-features/test.sh
+++ b/tests/misc-tests/001-btrfstune-features/test.sh
@@ -25,7 +25,7 @@ test_feature()
 	tuneopt="$2"
 	sbflag="$3"
 
-	run_check_mkfs_test_dev ${mkfsfeatures:+-O ^"$mkfsfeatures"}
+	run_check_mkfs_test_dev ${mkfsfeatures:+-O "$mkfsfeatures"}
 	if run_check_stdout "$TOP/btrfs" inspect-internal dump-super "$TEST_DEV" | \
 			grep -q "$sbflag"; then
 		_fail "FAIL: feature $sbflag must not be set on the base image"
@@ -38,7 +38,8 @@ test_feature()
 	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
 }
 
-test_feature extref -r EXTENDED_IREF
-test_feature skinny-metadata -x SKINNY_METADATA
-test_feature no-holes -n NO_HOLES
+test_feature '^extref' -r EXTENDED_IREF
+test_feature '^skinny-metadata' -x SKINNY_METADATA
+# block group tree feature relies on no-holes, thus have to disable block-group-tree too.
+test_feature '^no-holes,^block-group-tree' -n NO_HOLES
 test_feature '' '-S 1' SEEDING
diff --git a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
index 8d9a858ddc2f..fe5b87a1fd38 100755
--- a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
+++ b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
@@ -12,7 +12,7 @@ setup_root_helper
 prepare_test_dev
 check_kernel_support_acl
 
-run_check_mkfs_test_dev -O ^free-space-tree
+run_check_mkfs_test_dev -O ^free-space-tree,^block-group-tree
 run_check_mount_test_dev
 populate_fs
 run_check_umount_test_dev
-- 
2.52.0


