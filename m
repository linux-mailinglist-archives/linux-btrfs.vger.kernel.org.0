Return-Path: <linux-btrfs+bounces-14168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1FDABF09A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F084E4817
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8325A2B7;
	Wed, 21 May 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G7+Zl4Lg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G7+Zl4Lg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6D25A2DD
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821534; cv=none; b=dmK2UdkM3COSEDlCRF9XjyxVaLNNCHdrP2bqrqPDCKn506XNCfzO9pBkB8SPNB3o6qWDVhTLMO/+YahlU9lxLHbfcxnO1C03WBNumyUvEqHAyDncB+Sv6TFKYOhRMKRr2gkMwKOSEEK8aw0kich7tIxSw0o32iz31LWk+bhN+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821534; c=relaxed/simple;
	bh=j87XQj55R90lW/Akjq9KKSuiIimp2f/8ZjqEdBYYXuI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcLxv2svy360U21OuGAA0l92slYglojRJXoifj2FFXQAIbwEtDwENJOfLoTr3KH8KSbdBZ6ZgWwz27ule3WZ16x0dJamk4BX2p4a1fNSHlzXzyUIYbMUTE0cgT3TvEnnkZX6QnML3NKdGqEBP5ad+ER1ruo1vdLu4Uma3Tv//Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G7+Zl4Lg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G7+Zl4Lg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5685E21215
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxHN4cvBUF3IK6ta9dWr4CsBrrENgkPXlm0VoxDe3mM=;
	b=G7+Zl4LgJ+IKFPX1SVNcOIBigD+bKvmK/ts3CLF+hA3i8UmqGR+kJhqPP+XxkLuUpja0+W
	Irljg8nC5rFf6dWO60tz0mUceTAauI93NhUmmpjTAX2OhAp971DoEkqG221/bEElYmAR+V
	cEziEDdqVupxE765iTIKxypktnGuVwo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=G7+Zl4Lg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxHN4cvBUF3IK6ta9dWr4CsBrrENgkPXlm0VoxDe3mM=;
	b=G7+Zl4LgJ+IKFPX1SVNcOIBigD+bKvmK/ts3CLF+hA3i8UmqGR+kJhqPP+XxkLuUpja0+W
	Irljg8nC5rFf6dWO60tz0mUceTAauI93NhUmmpjTAX2OhAp971DoEkqG221/bEElYmAR+V
	cEziEDdqVupxE765iTIKxypktnGuVwo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8778513888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4KWVEdSjLWj6RwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs-progs: mkfs-tests: a new test case for --inode-flags
Date: Wed, 21 May 2025 19:28:21 +0930
Message-ID: <d47581ab6c7c3f4b8acb61db40deee551c28ae3d.1747821454.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747821454.git.wqu@suse.com>
References: <cover.1747821454.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5685E21215
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim]

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


