Return-Path: <linux-btrfs+bounces-1350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F582928A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334981F26C21
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57263DF;
	Wed, 10 Jan 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lf6LoeZV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lf6LoeZV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A25CB8
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F8B221B7E
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704855245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUqdPHnYcxcI/hcA584Wm4bUwS18++oYRlGydCq3Qf8=;
	b=lf6LoeZVgG9h7lYneH74EiSmqHLSV48RDIllhRDEgAciTajcVMGVBHLKHUWhxbxSUVp+2R
	aTZ25ehmfPUNimeaWBLsN/BRACw3d0xSc0QqphJb+QP5PAgFxah47Kolcq/yos8RnbHYc0
	49iJbJANE/FfeXy6xqd6iK8bTK8OtnY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704855245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUqdPHnYcxcI/hcA584Wm4bUwS18++oYRlGydCq3Qf8=;
	b=lf6LoeZVgG9h7lYneH74EiSmqHLSV48RDIllhRDEgAciTajcVMGVBHLKHUWhxbxSUVp+2R
	aTZ25ehmfPUNimeaWBLsN/BRACw3d0xSc0QqphJb+QP5PAgFxah47Kolcq/yos8RnbHYc0
	49iJbJANE/FfeXy6xqd6iK8bTK8OtnY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8021513786
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qDUlAssGnmWqKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:54:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: cli-tests: add test case for return value of "btrfs subvlume create"
Date: Wed, 10 Jan 2024 13:23:32 +1030
Message-ID: <2df04d2266134948bdd6755b9dbeaf70f42908f3.1704855097.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704855097.git.wqu@suse.com>
References: <cover.1704855097.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.76
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Result: default: False [3.76 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 NEURAL_HAM_SHORT(-0.14)[-0.678];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

The test case would check if "btrfs subvolume create":

- Report error on an existing path
- Still report error if mulitple paths are given and one of them already
  exists
- For above case, still created a subvolume for the good parameter

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../025-subvolume-create-failures/test.sh     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100755 tests/cli-tests/025-subvolume-create-failures/test.sh

diff --git a/tests/cli-tests/025-subvolume-create-failures/test.sh b/tests/cli-tests/025-subvolume-create-failures/test.sh
new file mode 100755
index 000000000000..b268a069ba37
--- /dev/null
+++ b/tests/cli-tests/025-subvolume-create-failures/test.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# Create subvolume failure cases to make sure the return value is correct
+
+source "$TEST_TOP/common" || exit
+
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+
+# Create one subvolume and one file as place holder for later subvolume
+# creation to fail.
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
+run_check $SUDO_HELPER touch "$TEST_MNT/subv2"
+
+# Using existing path to create a subvolume must fail
+run_mustfail "should report error when target path already exists" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
+
+run_mustfail "should report error when target path already exists" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv2"
+
+# Using multiple subvolumes in one create go, the good one "subv3" should be
+# created
+run_mustfail "should report error when target path already exists" \
+	$SUDO_HELPER "$TOP/btrfs" subvolume create \
+	"$TEST_MNT/subv1" "$TEST_MNT/subv2" "$TEST_MNT/subv3"
+
+run_check $SUDO_HELPER stat "$TEST_MNT/subv3"
-- 
2.43.0


