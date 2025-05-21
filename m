Return-Path: <linux-btrfs+bounces-14161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE01ABF077
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC131188FC5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0B25A321;
	Wed, 21 May 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pEzykgsg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pEzykgsg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192A20ADF8
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821097; cv=none; b=QcZkmPrqcedH3BbnJxjN1+BpsrtNNcDd++Btk6xGJ4S2L8Ww4X14nFN1mOqSuMwv4qK36jZ/2Sxfl14yL1XWFkEMYkoZyszBAzC+26Bf0sh6ary2McRPvKZ6k91rwhcVdo1pNYVq/UHBFJjhJncw1EzsuHhYiad7NEghRDbOAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821097; c=relaxed/simple;
	bh=j87XQj55R90lW/Akjq9KKSuiIimp2f/8ZjqEdBYYXuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI8+rzqHfVLm8R3XuBQuuTgR8p6NvcaYjY5RGeVOIv/us72eOKE+Peymi3IRV9diBHeM2J90Zg5ePyYQUFga9OI8DAU55endidfib5CZAQdnvcvtsV3gxnOP+Vl8hsaJOUSGMDuhUrFDiM7yFRm45fAUqXnnixSexsjs1EXXSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pEzykgsg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pEzykgsg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 247DC2262C
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxHN4cvBUF3IK6ta9dWr4CsBrrENgkPXlm0VoxDe3mM=;
	b=pEzykgsgfqKOgKQOB+KlBk3JhxeUdzPmzhSO8j3RKkBJeSj0Lkq+p2iEtFUWopTE+JzPM4
	in4d7jRDee7Hu+aWKOj6RdhHgbW+3GAjdspWuePP0VzDoMhvIYn9ayq41ByVdu1izAW8pJ
	0qiyhSj8FtYWdYymOCFeMQuGNJZXIl0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxHN4cvBUF3IK6ta9dWr4CsBrrENgkPXlm0VoxDe3mM=;
	b=pEzykgsgfqKOgKQOB+KlBk3JhxeUdzPmzhSO8j3RKkBJeSj0Lkq+p2iEtFUWopTE+JzPM4
	in4d7jRDee7Hu+aWKOj6RdhHgbW+3GAjdspWuePP0VzDoMhvIYn9ayq41ByVdu1izAW8pJ
	0qiyhSj8FtYWdYymOCFeMQuGNJZXIl0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65ED813888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLvACiWiLWgBRgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: mkfs-tests: a new test case for --inode-flags
Date: Wed, 21 May 2025 19:21:10 +0930
Message-ID: <bb1a79f933e08838e491d93ff58e16d8de68c4dc.1747820747.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747820747.git.wqu@suse.com>
References: <cover.1747820747.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

The simple test will create a layout like the following:

rootdir
|- file1
|- file2
|- subv/		<< Regular subvolume
|  |- file3
|- nocow_subv/		<< NODATACOW subvolume
|  |- file4
|- nocow_dir/		<< NODATACOW directory
|  |- dir2
|  |  |- file5
|  |- file6
|- nocow_file1		<< NODATACOW file

Any files under NODATACOW subvolume/directory should also be NODATACOW.
The explicitly specified single file should also be NODATACOW.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/038-inode-flags/test.sh | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 tests/mkfs-tests/038-inode-flags/test.sh

diff --git a/tests/mkfs-tests/038-inode-flags/test.sh b/tests/mkfs-tests/038-inode-flags/test.sh
new file mode 100755
index 000000000000..bb2f61c55605
--- /dev/null
+++ b/tests/mkfs-tests/038-inode-flags/test.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# Basic test for mkfs.btrfs --inode-flags --rootdir. Create a dataset and use it as
+# rootdir, then various inode-flags and verify the flag is properly set.
+
+source "$TEST_TOP/common" || exit
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+check_global_prereq lsattr
+
+setup_root_helper
+prepare_test_dev
+
+tmp=$(_mktemp_dir mkfs-rootdir)
+
+write_file()
+{
+	local path="$1"
+	local size="$2"
+
+	run_check dd if=/dev/zero of="$path" bs="$size" count=1 status=noxfer > /dev/null 2>&1
+}
+
+check_nodatacow()
+{
+	local path="$1"
+
+	lsattr "$TEST_MNT"/"$path" | grep -q C || _fail "missing NODATACOW flag for $path"
+}
+
+write_file "$tmp/file1" 64K
+write_file "$tmp/file2" 64K
+run_check mkdir -p "$tmp/subv" "$tmp/nocow_subv" "$tmp/nocow_dir/dir2"
+write_file "$tmp/subv/file3" 64K
+write_file "$tmp/nocow_subv/file4" 64K
+write_file "$tmp/nocow_dir/dir2/file5" 64K
+write_file "$tmp/nocow_dir/file6" 64K
+write_file "$tmp/nocow_file1" 64K
+
+run_check_mkfs_test_dev --rootdir "$tmp" --inode-flags nodatacow:nocow_subv \
+	--subvol nocow_subv --inode-flags nodatacow:nocow_dir \
+	--inode-flags nodatacow:nocow_file1
+
+run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+
+run_check_mount_test_dev
+check_nodatacow "nocow_subv"
+check_nodatacow "nocow_subv/file4"
+check_nodatacow "nocow_dir"
+check_nodatacow "nocow_dir/file6"
+check_nodatacow "nocow_dir/dir2/file5"
+check_nodatacow "nocow_file1"
+run_check lsattr -R "$TEST_MNT"
+run_check_umount_test_dev
+run_check rm -rf -- "$tmp"
-- 
2.49.0


