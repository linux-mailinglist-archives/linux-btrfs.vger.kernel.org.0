Return-Path: <linux-btrfs+bounces-19784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2FACC1C44
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 10:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6624302A76A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3D83446A2;
	Tue, 16 Dec 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hc9LVTGC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hc9LVTGC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B034405D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877067; cv=none; b=YB8HYuoTd+Ajz5utx95G+nQ36hTcDO4RVgZgQBZbk5G9rbj55f+H+XCsB8Kv1607tlbDrWag8FuPL/je7d0077bu/DNgGULA083NU1y3RBIHwwjfWVwqd/ekouOv1Hq9krxlbJud+TmgWgdO//s1aAx0uFG0Wl89Q+oxGSJrF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877067; c=relaxed/simple;
	bh=viqk5LdZWReFmxr3s8q1AGuBaw9Nsbs8/HYj9fkG0Ik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV/FLpwmWGMku/VV++/UZewlMN4m2GHZr0cKwsDWOOt/74On+q6ILTcPoppWmuFWLIuuc//+kQO0gekvmxkWcZcNQ0PjLCkOTkiFOY7b0iebHtYNWXldcn6y/NZUdx0PGCtIlt6Hk4hX9C1Ds9hi2ndBQN9c56LIMsoVVxHfEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hc9LVTGC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hc9LVTGC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C17D333695
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765877049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWwOy6mwKCBkMnn27n1F3YMrlQ/vB2s7jpzR7uJ+gSI=;
	b=hc9LVTGCktIe9xZJtkwp4nNpv2j2eZ/c1TCIq5R4V13eNbNMy0ih7CwyhS4rEdlVjxp7kK
	bGyvhu3Az3fFbB/VWlvZjUoGspZAcg8h5pdmXTuLlrxqSg/XwyJgIBUXuI/GV3L6Vh+YF3
	ZzsvXWqoYU8ZnFM9vyvgsZHE+6477og=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765877049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWwOy6mwKCBkMnn27n1F3YMrlQ/vB2s7jpzR7uJ+gSI=;
	b=hc9LVTGCktIe9xZJtkwp4nNpv2j2eZ/c1TCIq5R4V13eNbNMy0ih7CwyhS4rEdlVjxp7kK
	bGyvhu3Az3fFbB/VWlvZjUoGspZAcg8h5pdmXTuLlrxqSg/XwyJgIBUXuI/GV3L6Vh+YF3
	ZzsvXWqoYU8ZnFM9vyvgsZHE+6477og=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09F243EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MDJ9LzglQWlKNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 09:24:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: add a test case for unknown keys in subvolume trees
Date: Tue, 16 Dec 2025 19:53:48 +1030
Message-ID: <4acdcb50a4713a55d941c3297beac5691affb4ab.1765876829.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765876829.git.wqu@suse.com>
References: <cover.1765876829.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.64 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.04)[-0.196];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.64

The image has the following corrupted key in fs tree:

	item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
		generation 9 transid 9 size 0 nbytes 0
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 5 key (257 UNKNOWN.8 256) itemoff 15879 itemsize 0 <<<
	item 6 key (257 INODE_REF 256) itemoff 15863 itemsize 16
		index 2 namelen 6 name: foobar

This is inspired by a real world memory bitflip, which lead to a bitflip
from 12 to 8, causing the above unknown key type in a subvolume.

Although we will need to properly enhance btrfs-check to handle such
case better, let's start from detecting and report such unknown keys as
an error.

The image is created by inserting an empty item with above unknown key
type.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/fsck-tests/069-unknown-fs-tree-key/test.sh |  14 ++++++++++++++
 .../unknown_key_empty.img.xz                     | Bin 0 -> 2084 bytes
 2 files changed, 14 insertions(+)
 create mode 100755 tests/fsck-tests/069-unknown-fs-tree-key/test.sh
 create mode 100644 tests/fsck-tests/069-unknown-fs-tree-key/unknown_key_empty.img.xz

diff --git a/tests/fsck-tests/069-unknown-fs-tree-key/test.sh b/tests/fsck-tests/069-unknown-fs-tree-key/test.sh
new file mode 100755
index 000000000000..ea4f04e284be
--- /dev/null
+++ b/tests/fsck-tests/069-unknown-fs-tree-key/test.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+#
+# Verify that check can report unknown key types in subvolume trees
+
+source "$TEST_TOP/common" || exit
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "unknown keys in subvolume trees not reported as error" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
diff --git a/tests/fsck-tests/069-unknown-fs-tree-key/unknown_key_empty.img.xz b/tests/fsck-tests/069-unknown-fs-tree-key/unknown_key_empty.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..300a7cc92b7125d0309be6917195695610a0f549
GIT binary patch
literal 2084
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
N{+kKZ3}A_j0sx0D2c`f3

literal 0
HcmV?d00001

-- 
2.52.0


