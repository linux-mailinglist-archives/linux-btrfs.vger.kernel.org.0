Return-Path: <linux-btrfs+bounces-3840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F30895F5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EC5B254F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917C515ECF2;
	Tue,  2 Apr 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r0090IhT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D715ECE3
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095698; cv=none; b=VxCAGO4mh6CnbMy7QSu1UDUqa6UhZ+URasEiUv/c5tNHHCGP/ewRP9X/19beIj3BRdljh9n2tTsakNncV4yQt3fUuvN9q1eMqAZTeWd9UJdtJunLToVOipbPR/4bo7HhEe2gP3x7DR/e3rbXruR5mMg9nXO7rAhwgHVA6hrPEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095698; c=relaxed/simple;
	bh=6qFWotBaRh3xKSe+GspsQt4Z1oIVqAShKghCdIY3YGw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0dRibJ8TblvuSnU6DUzxCGURSg5TCWlElcnXWo0oMgCVaVo/yj6u7GDxM076dkQeu47aIMV3isDQ44hMN6sgADgodamaFeaiXyJtiWqlmP0o/gZV8n+deU293W9MgnpgJf/wDYW4C9hE4rRIlJtjy40/Trf2itF+SJYSZKY0qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r0090IhT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C6B334BD1
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712095695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxUTII/S0U5aofQ2nYiUooFyplSuZEkMIVtDfxuvjG8=;
	b=r0090IhTbHROdZfp3W5D+OMKe7SCGIn/uxNCXrl2KIJ1sGSMDABUTFH/avTKdKwdM7ILpq
	PEohiNzmWfcFAmaDMkmRI1CdShFHHr7kEeRF6zm2pXemyLuTk0prllJtuzk3wQDxeQCqJK
	iCZj859P6lRzcM16FKWEg4H1Emb+bOI=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 59A6513A90
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GL2zA86BDGYIdwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 22:08:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs-progs: tests-misc: add a test case to check zoned bgt conversion
Date: Wed,  3 Apr 2024 08:37:40 +1030
Message-ID: <7b9e0f7997c95c4870c6a0d006a84239653e12d9.1712095635.git.wqu@suse.com>
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

Add a new test case to make sure:

- btrfstune can convert a zoned btrfs with extent tree to bgt
- btrfstune can convert a zoned btrfs with bgt back to extent tree

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../063-btrfstune-zoned-bgt/test.sh           | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 tests/misc-tests/063-btrfstune-zoned-bgt/test.sh

diff --git a/tests/misc-tests/063-btrfstune-zoned-bgt/test.sh b/tests/misc-tests/063-btrfstune-zoned-bgt/test.sh
new file mode 100755
index 000000000000..dc2003cc78ab
--- /dev/null
+++ b/tests/misc-tests/063-btrfstune-zoned-bgt/test.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# Verify btrfstune for zoned devices with block-group-tree conversion
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
+
+# Create the fs without bgt
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m single -d single -O ^block-group-tree "${dev}"
+run_check_mount_test_dev
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file1 bs=1M count=1
+run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage -T "$TEST_MNT"
+run_check_umount_test_dev
+
+# Convert to bgt
+run_check $SUDO_HELPER "$TOP/btrfstune" --convert-to-block-group-tree "${dev}"
+run_check_mount_test_dev
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file2 bs=1M count=1
+run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage -T "$TEST_MNT"
+run_check_umount_test_dev
+
+# And convert back to old extent tree
+run_check $SUDO_HELPER "$TOP/btrfstune" --convert-from-block-group-tree "${dev}"
+run_check_mount_test_dev
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file3 bs=1M count=1
+run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage -T "$TEST_MNT"
+run_check_umount_test_dev
+
+run_check $SUDO_HELPER "$nullb" rm "${name}"
-- 
2.44.0


