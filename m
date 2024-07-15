Return-Path: <linux-btrfs+bounces-6452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB480930D7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBF32814E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349EB18309B;
	Mon, 15 Jul 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J3PC6qxW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J3PC6qxW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87701EEBA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020678; cv=none; b=NjQPQ7hJEApITMbiwtqDSXjg04+Y3JB4IXFZ11pbb9aV0OffZzoS7awgAvcMXim8VXRuK5Bh8YPwXqHp1kzZTYezZpHdy4l7O/LxAnNr8FOn5gYBycDVMbTOmR1vHyvrsCkx2QCAcxgOkpDoP5cnB0rbQXFhgtOjU2bfgnJPjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020678; c=relaxed/simple;
	bh=yng4Njx1pN+ug5/f0mCcWWTSsiw6Q2pqHpCY14QJ3Ew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG0ByvPWHbBI5k5DciO9vW23vRj4FM6Fykhc+gWGshJ7gNtKsq/UDTGBpt7L7PgeHiNEyOjuMAu2l40EIBfZH1A+rE0Si1WKj32n9N1qfBYMUGaWlKHOoUO52L0FtbjGy1nIsH6P/5+ku5MLPKqmvgyVBs3d9N5G1LKrT7K/nzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J3PC6qxW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J3PC6qxW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC8DE21A06
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUumDu/Z7dV3LPjdqUQr9sLCHtGmUtWjrzd+rDHns9E=;
	b=J3PC6qxWWA5jT0WESJafFl3oy5nFPC6X4JfbtLppuArfvF8gkoGjud7ZGi/zmlDxjqgh27
	598TRQF+wVOsBNvZtItIUQdCKPDAn1Jl4zT8eX8tgPf3RvPQgPs5Ap26VtpmAkUhA96MgD
	tFZMkB/brH3E1azMhSnVnjpupCzUTec=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUumDu/Z7dV3LPjdqUQr9sLCHtGmUtWjrzd+rDHns9E=;
	b=J3PC6qxWWA5jT0WESJafFl3oy5nFPC6X4JfbtLppuArfvF8gkoGjud7ZGi/zmlDxjqgh27
	598TRQF+wVOsBNvZtItIUQdCKPDAn1Jl4zT8eX8tgPf3RvPQgPs5Ap26VtpmAkUhA96MgD
	tFZMkB/brH3E1azMhSnVnjpupCzUTec=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFFB3134AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qFosJgGxlGZRRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: convert-tests: new test case to verify the rollback output
Date: Mon, 15 Jul 2024 14:47:33 +0930
Message-ID: <4ed8c93ac44c1e1a628eec173e666240a7c0673b.1721020542.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721020542.git.wqu@suse.com>
References: <cover.1721020542.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *

The new new test case is to make sure the rollback output for a fixed
content converted fs contains the string "ext2_saved/image".

As we have a bug in the past where after the string "ext2_saved", we can
have some unterminated garbage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../convert-tests/026-rollback-output/test.sh | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 tests/convert-tests/026-rollback-output/test.sh

diff --git a/tests/convert-tests/026-rollback-output/test.sh b/tests/convert-tests/026-rollback-output/test.sh
new file mode 100755
index 000000000000..ed3d14c1aa5e
--- /dev/null
+++ b/tests/convert-tests/026-rollback-output/test.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# Make sure "btrfs-convert -r" is outputting the correct filename
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev
+
+check_global_prereq mkfs.ext4
+check_prereq btrfs-convert
+check_prereq btrfs
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+run_check_umount_test_dev
+convert_test_do_convert
+
+tmp=$(mktemp --tmpdir btrfs-progs-convert-rollback.XXXXXX)
+# Rollback and save the output.
+run_check_stdout "$TOP/btrfs-convert" --rollback "$TEST_DEV" >> "$tmp"
+
+if ! grep -q "ext2_saved/image" "$tmp"; then
+	rm -f -- "$tmp"
+	_fail "rollback filename output is corruptedd"
+fi
+rm -f -- "$tmp"
-- 
2.45.2


