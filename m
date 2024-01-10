Return-Path: <linux-btrfs+bounces-1356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9DA829540
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 09:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C90E1F2794B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635773A8FE;
	Wed, 10 Jan 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gjcet7kw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gjcet7kw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8B1D683
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05C8A21B50
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704875818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyGukXZkgYyprGlw+I9bLlG1qnF0bsvkU/nSDoKWjV0=;
	b=Gjcet7kwy4RnSd1INCzANkQesXT2Daf2OJvMZrT/t7bJJ+PrNp6O6VnMXuu+xlnFDk/2Df
	7/zBAnpMQqESuFp7vupOthYoI4bU2JdUEnHZscY+pnL71kDUUBsmoK/s2fNS44jdBOX8gs
	bEaF8x/w7PitWaSDd4PPmkpj6CTkTnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704875818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyGukXZkgYyprGlw+I9bLlG1qnF0bsvkU/nSDoKWjV0=;
	b=Gjcet7kwy4RnSd1INCzANkQesXT2Daf2OJvMZrT/t7bJJ+PrNp6O6VnMXuu+xlnFDk/2Df
	7/zBAnpMQqESuFp7vupOthYoI4bU2JdUEnHZscY+pnL71kDUUBsmoK/s2fNS44jdBOX8gs
	bEaF8x/w7PitWaSDd4PPmkpj6CTkTnk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD07413786
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2A8XGihXnmV/aQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 08:36:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: cli-tests: add test case for return value of "btrfs subvlume create"
Date: Wed, 10 Jan 2024 19:06:34 +1030
Message-ID: <3eef7ffdb8cc35ec03d28b3e43ada0aebfc89c2d.1704875723.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704875723.git.wqu@suse.com>
References: <cover.1704875723.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *****
X-Spam-Score: 5.20
X-Spamd-Result: default: False [5.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

The test case would check if "btrfs subvolume create":

- Report error on an existing path
- Still report error if mulitple paths are given and one of them already
  exists
- For above case, still created a subvolume for the good parameter

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../025-subvolume-create-failures/test.sh     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 tests/cli-tests/025-subvolume-create-failures/test.sh

diff --git a/tests/cli-tests/025-subvolume-create-failures/test.sh b/tests/cli-tests/025-subvolume-create-failures/test.sh
new file mode 100755
index 000000000000..fd074de113a5
--- /dev/null
+++ b/tests/cli-tests/025-subvolume-create-failures/test.sh
@@ -0,0 +1,32 @@
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
+
+run_check_umount_test_dev
-- 
2.43.0


