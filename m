Return-Path: <linux-btrfs+bounces-7846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C746E96CC1F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 03:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F25289006
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADADDBE;
	Thu,  5 Sep 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d9vsPiOI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d9vsPiOI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B64B661
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498835; cv=none; b=TS9Tm9m0lHRjKVwQVStjO9MgLWtDOpWw3meIMf7txRmQHUYyFDNUVyN6Erf6ForGv58YHM26UlUKyKgR6RDE+v4ifKGLe97Tb2rwZxdP2HiLGXoiQHLjlIXTqAk8XvNURUxMxoRzw1SENy99WkJoBnRFUpcZ+0CDYOu8QS7aZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498835; c=relaxed/simple;
	bh=A2y2NfacRgME26rDfUnQO6jPW2+8P+bn93wZB/iu+3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMx/xsDInkLStZmD/xLWJtZWheZd0GldWbGV1M/DnfuSuKaUJ2mJkWHxD15MemtR1cp6ZRWVtgPq09jFusokjipXHsoGGrgNyuBwAfgH8sYjlUbBfmeB1m5C9JsOoT7h8tPjT3L9JdG0jNkQ5X5YC5jnGFDQzR+FuYh1WCIZpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d9vsPiOI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d9vsPiOI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B63A421A2D
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+5cNJcxMFT8UIb9ApKpwfgkE7LT1Kso3brVsZAiFNM=;
	b=d9vsPiOILbklMyKGSqiPKc59IZPBHV5cVHOILyLYgSddpeeGsBlgiOt1+NYrDoJXaH12Wp
	P6QjXiciO3yC99JTUKALQ2/Qw+cJdSV9GG4MvT6ELdZzNILmwJjlrH1mXi2H8EcdArGrpV
	qhqwcWjeySKdeLVZEsOhLykr8PZrnOc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+5cNJcxMFT8UIb9ApKpwfgkE7LT1Kso3brVsZAiFNM=;
	b=d9vsPiOILbklMyKGSqiPKc59IZPBHV5cVHOILyLYgSddpeeGsBlgiOt1+NYrDoJXaH12Wp
	P6QjXiciO3yC99JTUKALQ2/Qw+cJdSV9GG4MvT6ELdZzNILmwJjlrH1mXi2H8EcdArGrpV
	qhqwcWjeySKdeLVZEsOhLykr8PZrnOc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB65113508
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iOVSK84F2WbMKQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2024 01:13:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs-progs: convert-tests: add a test case to verify large symbolic link handling
Date: Thu,  5 Sep 2024 10:43:24 +0930
Message-ID: <1ef57f7fa8c482700016251c2a63fd254c3960ea.1725498618.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725498618.git.wqu@suse.com>
References: <cover.1725498618.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The new test case will:

- Create a symbolic which contains a 4095 bytes sized target on ext4

- Convert the ext4 to btrfs

- Make sure we can still read the symbolic link
  For unpatched btrfs-convert, the resulted symbolic link will be rejected
  by kernel and fail.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../027-large-symbol-link/test.sh             | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 tests/convert-tests/027-large-symbol-link/test.sh

diff --git a/tests/convert-tests/027-large-symbol-link/test.sh b/tests/convert-tests/027-large-symbol-link/test.sh
new file mode 100755
index 000000000000..2a001424df83
--- /dev/null
+++ b/tests/convert-tests/027-large-symbol-link/test.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# Make sure btrfs-convert can handle a symbol link which is 4095 bytes large
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev 1G
+check_global_prereq mkfs.ext4
+
+# This is at the symbolic link size limit (PATH_MAX includes the terminating NUL).
+link_target=$(printf "%0.sb" {1..4095})
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+run_check $SUDO_HELPER ln -s "$link_target" "$TEST_MNT/symbol_link"
+run_check_umount_test_dev
+
+# For unpatched btrfs-convert, it will always append one byte to the
+# link target, causing above 4095 target to be 4096, exactly one sector,
+# resulting a regular file extent.
+convert_test_do_convert
+
+run_check_mount_test_dev
+# If the unpatched btrfs-convert created a regular extent, and the kernel is
+# newer enough, such readlink will be rejected by kernel.
+run_check $SUDO_HELPER readlink "$TEST_MNT/symbol_link"
+run_check_umount_test_dev
-- 
2.46.0


