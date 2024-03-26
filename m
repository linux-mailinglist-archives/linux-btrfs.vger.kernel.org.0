Return-Path: <linux-btrfs+bounces-3583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319488B5FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 01:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5B42C7E6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369474C74;
	Tue, 26 Mar 2024 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tbs8zcz+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tbs8zcz+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F83233
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412600; cv=none; b=aGP6MUbtzUm2dvOapIZIzSwxoj2WImnhQtHyDyTC6buTYzMGrmcL6Az/lY7UyKZcc4qzRf28R4rTgga836NxolPMzFS7uHLPWzG6oSGcQndGtUy8aASPV9L27lFz7PwNzafegUH9tIGJeyWesdGVxFVKBHq1sYTRFiufJVCq184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412600; c=relaxed/simple;
	bh=xmktfWVx7hK3fFpN9ZfZaOWSduk9zR+6XX7ljEdNy7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9UxsHpoZ/FLDAvMW5XibCVfRDXeIUke+zy0k9S4kC6+X8tfDBZm4JBh35RgKU1OMXHOS1RR+LekT2xMWk7rnUXevNUu9l8s6IJPJ2SDgGQ32FTkPKS3M/Ipj80cQK9U0WOKpYtwIbQ94bQTW1bwksNkO8wvJd3OVyAxsf6HQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tbs8zcz+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tbs8zcz+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 248135CE25
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AR0TTEjPd/C61+s6MmilNxXsq0kN/l5UkdS4mSjJKNs=;
	b=tbs8zcz+BpMiXoaJa5IcHQLtc0R3s00X4xHoz5IVHLQVe6H8xjQyRTQzG6ZOgbGl72kLZH
	XHnpIG0HIFC7fI4baUEBmXmXnHRuZq1K/t3UbOZ6HIilP1ayWk9E5MfwIKb2gRdU0Mswhx
	k/STGlGNpdz351yFMLYwvOD86fmck94=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711412597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AR0TTEjPd/C61+s6MmilNxXsq0kN/l5UkdS4mSjJKNs=;
	b=tbs8zcz+BpMiXoaJa5IcHQLtc0R3s00X4xHoz5IVHLQVe6H8xjQyRTQzG6ZOgbGl72kLZH
	XHnpIG0HIFC7fI4baUEBmXmXnHRuZq1K/t3UbOZ6HIilP1ayWk9E5MfwIKb2gRdU0Mswhx
	k/STGlGNpdz351yFMLYwvOD86fmck94=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AEAC13586
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iDeMO3MVAmbOJAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 00:23:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs-progs: tests-mkfs: add test case for zoned block group tree feature
Date: Tue, 26 Mar 2024 10:52:45 +1030
Message-ID: <4bf6bc80f18c716d1cfd21f8f25c3552064c36a5.1711412540.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
References: <cover.1711412540.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tbs8zcz+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 248135CE25
X-Spam-Flag: NO

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/031-zoned-bgt/test.sh | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tests/mkfs-tests/031-zoned-bgt/test.sh

diff --git a/tests/mkfs-tests/031-zoned-bgt/test.sh b/tests/mkfs-tests/031-zoned-bgt/test.sh
new file mode 100755
index 000000000000..91c107cd5a3b
--- /dev/null
+++ b/tests/mkfs-tests/031-zoned-bgt/test.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# Verify mkfs for zoned devices support block-group-tree feature
+
+source "$TEST_TOP/common" || exit
+
+setup_root_helper
+prepare_test_dev
+
+nullb="$TEST_TOP/nullb"
+# Create one 128M device with 4M zones, 32 of them
+size=128
+zone=4
+
+run_mayfail $SUDO_HELPER "$nullb" setup
+if [ $? != 0 ]; then
+	_not_run "cannot setup nullb environment for zoned devices"
+fi
+
+# Record any other pre-existing devices in case creation fails
+run_check $SUDO_HELPER "$nullb" ls
+
+# Last line has the name of the device node path
+out=$(run_check_stdout $SUDO_HELPER "$nullb" create -s "$size" -z "$zone")
+if [ $? != 0 ]; then
+	_fail "cannot create nullb zoned device $i"
+fi
+dev=$(echo "$out" | tail -n 1)
+name=$(basename "${dev}")
+
+run_check $SUDO_HELPER "$nullb" ls
+
+TEST_DEV="${dev}"
+# Use single as it's supported on more kernels
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -m single -d single -O block-group-tree "${dev}"
+run_check_mount_test_dev
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file bs=1M count=1
+run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage -T "$TEST_MNT"
+run_check_umount_test_dev
+
+run_check $SUDO_HELPER "$nullb" rm "${name}"
-- 
2.44.0


