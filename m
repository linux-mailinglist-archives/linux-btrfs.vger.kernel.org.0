Return-Path: <linux-btrfs+bounces-3839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF4895F5B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A6E1C23BDB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60315E81A;
	Tue,  2 Apr 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F4sTxXLL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135715ECDB
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095697; cv=none; b=JXwhmlPnz7YpEviMg8ltwKp3tBuaJgA0EbTLS0f4PAYKpFo453oqtMNnju+ZXq+Atc2fAR/cxP/uR3RE075oL5S9UpDMcN6uOFNhQG5EmcLBy7Jjhd9egKbOyvAbYEukH6O51epoT74+s/zFltWOyRnxICf9StiJ83tpuMb9jRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095697; c=relaxed/simple;
	bh=xmktfWVx7hK3fFpN9ZfZaOWSduk9zR+6XX7ljEdNy7o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsV8dW2mVluLJJ9ce9DDMJKDJCAwQZXtqCY/y1+jvZd/w4iL4L/gETB3RgF5ejHxWytMlVg5ALcwV62qv/mueLvx9JUY6GSWB+TObcw0dTkhnhJvjXJO1wQtLgWgimF6Q1Yd+Mebeef0tpyW7Tn3p96QAJzuIe7+9lKG2X9AoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F4sTxXLL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B86AD34BC8
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712095693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AR0TTEjPd/C61+s6MmilNxXsq0kN/l5UkdS4mSjJKNs=;
	b=F4sTxXLLy6R59KGN8GpH0SQtg1Bh/plZrZuuhfzNJlOUvu2FAbc73bzu2XMy8L8WmuuIVh
	FoheJ4kxArQJ5B15pDodVBL6O1oB+oJVjVNt8w8cre9hMkK8aVOEpBtIur31fPVzDjeSuR
	mNIeevTa0aBqOPYgZZmaA0uNwSBLrS0=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB30813A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aIF0H8yBDGYIdwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 22:08:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs-progs: tests-mkfs: add test case for zoned block group tree feature
Date: Wed,  3 Apr 2024 08:37:39 +1030
Message-ID: <88966130f8833cfe8a3aa3511ced9b029b71ab75.1712095635.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712095635.git.wqu@suse.com>
References: <cover.1712095635.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.80
X-Spam-Level: 
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


