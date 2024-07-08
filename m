Return-Path: <linux-btrfs+bounces-6276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F4929B77
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 07:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263651F215A7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 05:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D23012E78;
	Mon,  8 Jul 2024 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LL0ZGuSy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LL0ZGuSy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CD1173F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720415690; cv=none; b=EAwgEQcCL0gKksIAe2JdfgizMWbLyPpCt043YxjOf4g2MaZ0xr+7B/H1Gj2TB4rkWXadm158JfJZnA9URkD2/h8yOtBbHT7z/QPUxRmo1QN4R99AYyRWvn+bOBw1DWXdwTqgqXRu1gKdQ84/aHjX1fT6+PGcC3Nv3ZAeh6ShI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720415690; c=relaxed/simple;
	bh=da+KXIXZbQllWE3f0ELpNROhWiC1KFx810/X3no8TRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWW93NS+caGOcSbMCCBjKlRWEJdqR5zBajp7i5ncOYrnEUhmKx7qHG5lhyiEPSN8sL/P4+JGKQVJMa69FoLfPHZzlLDb6JmdceyKhZMLGL+tuOl/7rFrn2446QTzbA2dQ9h6gokpgrt8kiJZhr3sZ+REi4lioUu/ILKtlUd/JA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LL0ZGuSy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LL0ZGuSy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AA6F1FBED
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXZ0ZlCaPmvdWH6ayv8ca/MtUcffQe7jjhXtJIygt/o=;
	b=LL0ZGuSyea+9S1knFSjzAbUfZaCsGgmfmGplBIjE9olNxjAyK2MjkocsIzQWDe+nG0baHR
	m47JIp17KDkmm/DAztkQiOYYABQFHCx4l9Aoe6K/beS2UhLdyyTKpNF3ds6aho06SZpng2
	u8u7N7fGFG1sX7+Ir7Hf1v7SybIWaxo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720415687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXZ0ZlCaPmvdWH6ayv8ca/MtUcffQe7jjhXtJIygt/o=;
	b=LL0ZGuSyea+9S1knFSjzAbUfZaCsGgmfmGplBIjE9olNxjAyK2MjkocsIzQWDe+nG0baHR
	m47JIp17KDkmm/DAztkQiOYYABQFHCx4l9Aoe6K/beS2UhLdyyTKpNF3ds6aho06SZpng2
	u8u7N7fGFG1sX7+Ir7Hf1v7SybIWaxo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49D961396E
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 05:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OIMvAcZ1i2YbZwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jul 2024 05:14:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: misc-tests: add a test case for filename sanitization
Date: Mon,  8 Jul 2024 14:44:18 +0930
Message-ID: <47cb2c90e2786db2830fe6ef5042f6c9b2e97278.1720415116.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720415116.git.wqu@suse.com>
References: <cover.1720415116.git.wqu@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

This test case checks:

- If a regular btrfs-image dump has the unsanitized filenames
- If a sanitized btrfs-image dump has filenames properly censored

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/065-image-filename/test.sh | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100755 tests/misc-tests/065-image-filename/test.sh

diff --git a/tests/misc-tests/065-image-filename/test.sh b/tests/misc-tests/065-image-filename/test.sh
new file mode 100755
index 000000000000..a9567ad672ef
--- /dev/null
+++ b/tests/misc-tests/065-image-filename/test.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+# Verify "btrfs-image -s" sanitize the filenames correctly
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev
+
+tmp=$(mktemp --tmpdir btrfs-progs-image-filename.XXXXXX)
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+run_check $SUDO_HELPER touch "$TEST_MNT/top_secret_filename"
+run_check $SUDO_HELPER touch "$TEST_MNT/secret_filename"
+run_check $SUDO_HELPER touch "$TEST_MNT/confidential_filename"
+run_check_umount_test_dev
+
+run_check "$TOP/btrfs-image" "$TEST_DEV" "$tmp"
+echo "strings found inside the regular dump:" >> "$RESULTS"
+strings "$tmp" >> "$RESULTS"
+if ! strings "$tmp" | grep -q _filename "$tmp"; then
+	rm -f -- "$tmp"
+	_fail "regular dump sanitized the filenames"
+fi
+run_check "$TOP/btrfs-image" -s "$TEST_DEV" "$tmp"
+echo "strings found inside the sanitized dump:" >> "$RESULTS"
+strings "$tmp" >> "$RESULTS"
+if strings "$tmp" | grep -q _filename "$tmp"; then
+	rm -f -- "$tmp"
+	_fail "filenames not properly sanitized"
+fi
+rm -f -- "$tmp"
-- 
2.45.2


