Return-Path: <linux-btrfs+bounces-5691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DCC905FAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007C81F227F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF508494;
	Thu, 13 Jun 2024 00:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I79RsIbz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I79RsIbz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F88611B
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238235; cv=none; b=URnyCgPop9Hds6Ho2pmxU93kOFChJd0x8WDXektN9l5hUrwSATJ5NdlDRAjOeji0qVoA4ja1LJUO9rUyE+WVtoe8DvxHtA8FEv938gyp1IIELdTEaO7OIFQlIe31YDEOpREjygBWJy+haFcm0aVZg8I9Xj6pwscXoSwEyuZSuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238235; c=relaxed/simple;
	bh=jwC+OVHni/fuKFIT7QB2E/SZOES/UkPT1L197dW7WLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAK/izUPYDW7bNgp3zRS4VnhuiOxAobz2FVFjeC3gAnyuMZiZ6Xrmw9h59dbdVHfIYnsGNsE1I0ha7uAWgxtJhqOhSV9NjszoeyIcAA+ei7nnnKjuR5yL+FvgsK27Ur5B64jdVAbk6+twBb5WEXAtaHOKvKo9cNRGrDz1QsXMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I79RsIbz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I79RsIbz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1150C5CA0F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLHcX1wvEV9IrSC72QZZtvaIQmnrwY6q7yKlsqG4mjM=;
	b=I79RsIbzMudti1TAFo5vV17TDz5Z2BLbKlz88w4Hd5OeucUfZKO+IR19A9FF8qMpkUbtNR
	oqvUCizkm+XO02JJXByGelf4fChfbyeJSadqJmt/usfrznjLJTXE2Pvlu2yO53VcQ9tz9a
	kgeZSD/PeD4GtLIOsWNV0qGpqlAKTLE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLHcX1wvEV9IrSC72QZZtvaIQmnrwY6q7yKlsqG4mjM=;
	b=I79RsIbzMudti1TAFo5vV17TDz5Z2BLbKlz88w4Hd5OeucUfZKO+IR19A9FF8qMpkUbtNR
	oqvUCizkm+XO02JJXByGelf4fChfbyeJSadqJmt/usfrznjLJTXE2Pvlu2yO53VcQ9tz9a
	kgeZSD/PeD4GtLIOsWNV0qGpqlAKTLE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F23013A7F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mEr7MBY8amY9YQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs-progs: hide rst related mkfs tests behind experimental builds
Date: Thu, 13 Jun 2024 09:53:23 +0930
Message-ID: <5355fb34cfa7fffd9af3be919b182561189ecb69.1718238120.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718238120.git.wqu@suse.com>
References: <cover.1718238120.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Currently we unconditionally run mkfs/029 and mkfs/030 as we export
RST feature through mkfs.btrfs as supported features.

But considering the mkfs.btrfs features are mismatch with kernel support
(only a BTRFS_DEBUG kernel can support that), we're going to hide RST
behind experimental builds.

In that case RST related tests cases also need to be behind
experimental builds as regular builds of mkfs.btrfs will no longer
support RST feature.

This patch would introduce two helpers:

- _test_config()
  To verify if certain config is set to 1

- check_experimental_build()
  A wrapper of "_test_config EXPERIMENTAL", and skip the test if
  btrfs-progs has no experimental features.

So that test cases can be skipped for non-experimental builds.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common                                  | 22 +++++++++++++++++++
 tests/mkfs-tests/029-raid-stripe-tree/test.sh |  1 +
 tests/mkfs-tests/030-zoned-rst/test.sh        |  1 +
 3 files changed, 24 insertions(+)

diff --git a/tests/common b/tests/common
index 7a23f6dde1a5..e9456c1d96b8 100644
--- a/tests/common
+++ b/tests/common
@@ -6,6 +6,21 @@
 # Temporary array for building the final command, injecting arguments as needed
 declare -a cmd_array
 
+# Check if certain config is set to 1
+_test_config()
+{
+	local feature="$1"
+
+	if [ ! -f "${TOP}/include/config.h" ]; then
+		echo "include/config.h not exists"
+		exit 1
+	fi
+	if grep -q "${feature}.*1" "${TOP}/include/config.h"; then
+		return 0
+	fi
+	return 1
+}
+
 # assert that argument is not empty and is an existing path (file or directory)
 _assert_path()
 {
@@ -370,6 +385,13 @@ run_mustfail_stdout()
 	fi
 }
 
+check_experimental_build()
+{
+	if ! _test_config "EXPERIMENTAL"; then
+		_not_run "This test requires experimental build"
+	fi
+}
+
 check_prereq()
 {
 	# Internal tools for testing, not shipped with the package
diff --git a/tests/mkfs-tests/029-raid-stripe-tree/test.sh b/tests/mkfs-tests/029-raid-stripe-tree/test.sh
index c3edd36d8761..f200d068fe79 100755
--- a/tests/mkfs-tests/029-raid-stripe-tree/test.sh
+++ b/tests/mkfs-tests/029-raid-stripe-tree/test.sh
@@ -3,6 +3,7 @@
 
 source "$TEST_TOP/common" || exit
 
+check_experimental_build
 check_prereq mkfs.btrfs
 check_prereq btrfs
 
diff --git a/tests/mkfs-tests/030-zoned-rst/test.sh b/tests/mkfs-tests/030-zoned-rst/test.sh
index b1c696c96eb7..b03c691f1b69 100755
--- a/tests/mkfs-tests/030-zoned-rst/test.sh
+++ b/tests/mkfs-tests/030-zoned-rst/test.sh
@@ -3,6 +3,7 @@
 
 source "$TEST_TOP/common" || exit
 
+check_experimental_build
 setup_root_helper
 setup_nullbdevs 4 128 4
 prepare_nullbdevs
-- 
2.45.2


