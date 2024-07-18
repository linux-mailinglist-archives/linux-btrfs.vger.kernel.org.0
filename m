Return-Path: <linux-btrfs+bounces-6561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAEA9370B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FBA281E3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C27E563;
	Thu, 18 Jul 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LNy3kdXk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LNy3kdXk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86305146591
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342031; cv=none; b=YwFwj6+5PO+6d/jizGddLyNZaUdtqnMz2cfz/PFBy9W7BvTD8/foqPnNUG0S+RovlylKld1sjHEoSiqctEMrmBIPingQlvURH+prl7tu8zfZJysp0veUuLZzRi7z6sGT/cVlXkhIyh//MQ/ZFCwLD4ibccu03P9m4bkKaZSKC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342031; c=relaxed/simple;
	bh=lgEbp4gbjWjJM6WBwvoCuO4cXple9Xv3seGTsW7Thm0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXht/L2SPT2ExIri7lW8rzagHP7ySdCLqWlwC3MA4JG8LeP2MI9pxDUe6uGk0YvYzYyTng9SaNb9phnq9qkAsTo+f3zS4vTpHaI/UeIgjfcQyWdq62TRLhF7DqKQ0uge8ftR5YgKVr9qaH0LsHK02PRWFJtMAFyF0tw13xk39Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LNy3kdXk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LNy3kdXk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF9601F745
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rMNvCaRy5GnGxJ/8PGKQOi3A3Kp26Sz314HExkW744=;
	b=LNy3kdXkPQwFM/36SnSP2D7qW2sDge4wn82v7TC3LeSxeVs/ihEY+xL0X2eehs949jfEIk
	um7dmE0nJUOrE3MHdDtP1W/I28An8vFg6UPHZeONE0fyvSqADMTFmeDYtNDt23MZo3SNR9
	uGLP/okv+udeJK3J+1npBYHstFBzles=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721342027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rMNvCaRy5GnGxJ/8PGKQOi3A3Kp26Sz314HExkW744=;
	b=LNy3kdXkPQwFM/36SnSP2D7qW2sDge4wn82v7TC3LeSxeVs/ihEY+xL0X2eehs949jfEIk
	um7dmE0nJUOrE3MHdDtP1W/I28An8vFg6UPHZeONE0fyvSqADMTFmeDYtNDt23MZo3SNR9
	uGLP/okv+udeJK3J+1npBYHstFBzles=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3D741379D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +KwkJ0qYmWb9HAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:33:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs-progs: misc-tests: add a test case for filename sanitization
Date: Fri, 19 Jul 2024 08:03:22 +0930
Message-ID: <4b2c2392baefe7c41b0841c7ca41a7fb708e88ce.1721341885.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

This test case checks:

- If a regular btrfs-image dump has the unsanitized filenames
- If a sanitized btrfs-image dump has filenames properly censored

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/065-image-filename/test.sh | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 tests/misc-tests/065-image-filename/test.sh

diff --git a/tests/misc-tests/065-image-filename/test.sh b/tests/misc-tests/065-image-filename/test.sh
new file mode 100755
index 000000000000..0c53cc2f6f72
--- /dev/null
+++ b/tests/misc-tests/065-image-filename/test.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+# Verify "btrfs-image -s" sanitizes the filenames correctly
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev
+
+declare -a filenames=("%%top_secret%%" "@@secret@@" "||confidential||")
+tmp=$(_mktemp "image-filename")
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+for i in ${filenames[@]}; do
+	run_check $SUDO_HELPER touch "$TEST_MNT/$i"
+done
+run_check_umount_test_dev
+
+run_check "$TOP/btrfs-image" "$TEST_DEV" "$tmp"
+_log "strings found inside the regular dump:"
+strings "$tmp" >> "$RESULTS"
+for i in ${filenames[@]}; do
+	if ! grep -q "$i" "$tmp"; then
+		rm -f -- "$tmp"
+		_fail "regular dump sanitized the filenames"
+	fi
+done
+run_check "$TOP/btrfs-image" -s "$TEST_DEV" "$tmp"
+_log "strings found inside the sanitize dump:"
+strings "$tmp" >> "$RESULTS"
+for i in ${filenames[@]}; do
+	if grep -q "$i" "$tmp"; then
+		rm -f -- "$tmp"
+		_fail "filenames not properly sanitized"
+	fi
+done
+rm -f -- "$tmp"
-- 
2.45.2


