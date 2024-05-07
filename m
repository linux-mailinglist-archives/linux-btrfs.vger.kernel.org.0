Return-Path: <linux-btrfs+bounces-4794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45C8BD9B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 05:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1AA1F2308A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727B4F894;
	Tue,  7 May 2024 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwYhFaMN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwYhFaMN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7644EB4A
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052203; cv=none; b=VuUpYBEARxVQExYNbLNyGmZCS1QuDbC7BjucCfKfF/Q6XfgTtkGeELJhkFq1dZ9Fi8TgSZJumF7W5XeOMjXqS7IOltgBSF/4xnO8DSogKytErnbjtkupMTzGvjrWbPgb13TJ9100nQO+sHshv27mzly3O4xo6mx8CtJPSAeR6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052203; c=relaxed/simple;
	bh=PCoFlLJ27cjSK6eAFeTEROQ3vIQbz6bnZTz2arGJ8xo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIn0KFfze6EHrZR+h5eBbNECFTaLAJNroVQlZ3UROc4p5/46O0pHRIHQdlgQbPWYMV4EAehDy+sFViJ3PcLM3r5sxZjwBxKFXt9xrb0VtsfHtCiTTvCiwjgXbxENbjOcKifQ/gIMMx5nXcsINHOylSQrZTy4HvQAXBZ2D+a/u6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwYhFaMN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwYhFaMN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8E612029F
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTIG8f0cs7oIW2gVWp1CqxZ+4e2MIS/6XFmetDbygCM=;
	b=AwYhFaMNSNL1DsojYdxE54c3t8TzHCc5wX+I5T143s7dcRtfv4IaE/QoXjyveiKcJ7VUyn
	7C0dYSX8AMzOIJqUuZpLqgnlUrVlPRL6VFzZWIiGaZWSIpJH0rFL/tZ7RG36347evXyLRk
	RK01FyfJ2cyvWk4G4+ksBDDMZSUDJd0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTIG8f0cs7oIW2gVWp1CqxZ+4e2MIS/6XFmetDbygCM=;
	b=AwYhFaMNSNL1DsojYdxE54c3t8TzHCc5wX+I5T143s7dcRtfv4IaE/QoXjyveiKcJ7VUyn
	7C0dYSX8AMzOIJqUuZpLqgnlUrVlPRL6VFzZWIiGaZWSIpJH0rFL/tZ7RG36347evXyLRk
	RK01FyfJ2cyvWk4G4+ksBDDMZSUDJd0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02143139CB
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCHFKaaeOWa9WgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 03:23:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: tests/convert: add test case for ext4 unwritten extents
Date: Tue,  7 May 2024 12:52:55 +0930
Message-ID: <542d0b559a21ae84202d2e7632dfab59019e4982.1715051693.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715051693.git.wqu@suse.com>
References: <cover.1715051693.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The test case would verify the behaivor of ext4 unwritten extents by:

- Create a unwritten (preallocated) extent on ext4

- Fill the on-disk extent with random garbage
  This is to make sure if btrfs tries to read the on-disk data, it would
  definitely get some garbage.
  As I found sometimes mkfs.ext4 can fill the unused bg with zeros.

- Fill the preallocated file range with some data
  This is to make sure btrfs-convert can handle mixed written and
  unwritten ranges.

- Save the checksum of the file.

- Convert the fs

- verify the checksum
  For older btrfs-convert, there would be only one regular file extent,
  and reading the file would read out some garbage and cause checksum to
  mismatch.

  For the fixed btrfs-convert, we punch holes for unwritten extents,
  thus only the written part would be read out and match the checksum.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../025-ext4-uninit-written/test.sh           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 tests/convert-tests/025-ext4-uninit-written/test.sh

diff --git a/tests/convert-tests/025-ext4-uninit-written/test.sh b/tests/convert-tests/025-ext4-uninit-written/test.sh
new file mode 100755
index 000000000000..cca8f69a201e
--- /dev/null
+++ b/tests/convert-tests/025-ext4-uninit-written/test.sh
@@ -0,0 +1,53 @@
+#!/bin/bash
+# Make sure btrfs is handling the ext4 uninit (preallocated) extent correctly
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev 1G
+
+check_global_prereq mkfs.ext4
+check_global_prereq fallocate
+check_global_prereq filefrag
+check_global_prereq awk
+check_global_prereq md5sum
+check_prereq btrfs-convert
+check_prereq btrfs
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+
+# Create a preallocated extent first.
+run_check $SUDO_HELPER fallocate -l 32K "$TEST_MNT/file"
+sync
+# Get the real on-disk location and write some data into it.
+physical=$(run_check_stdout $SUDO_HELPER filefrag -v "$TEST_MNT/file" | grep unwritten | awk '{print $4}' | grep -o "[[:digit:]]*")
+
+if [ -z "$physical" ]; then
+	_fail "unable to get the physical address of the file"
+fi
+
+# Now fill the underlying range with non-zeros.
+# For properly converted fs, we should not read the contents anyway
+run_check $SUDO_HELPER dd if=/dev/urandom of=$TEST_DEV bs=4096 seek="$physical" conv=notrunc count=8
+
+# Write some thing into the file range.
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/file" bs=4096 count=1 conv=notrunc
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/file" bs=4096 count=1 seek=3 conv=notrunc
+sync
+md5_before=$(md5sum "$TEST_MNT/file" | cut -f1 -d' ')
+_log "md5sum before convert: $md5_before"
+run_check_umount_test_dev
+
+# Btrfs-convert should handle the unwritten part correctly, either punching a hole
+# or a proper preallocated extent, so that we won't read the on-disk data.
+convert_test_do_convert
+
+run_check_mount_test_dev
+md5_after=$(md5sum "$TEST_MNT/file" | cut -f1 -d' ')
+_log "md5sum after convert: $md5_after"
+run_check_umount_test_dev
+
+if [ "$md5_before" != "$md5_after" ]; then
+	_fail "contents mismatch"
+fi
-- 
2.45.0


