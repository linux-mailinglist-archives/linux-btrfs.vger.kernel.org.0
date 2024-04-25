Return-Path: <linux-btrfs+bounces-4550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7979C8B2CC5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 00:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF04288ACB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB4179641;
	Thu, 25 Apr 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="moc4jDQi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="moc4jDQi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B86178CCB
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082783; cv=none; b=n3zWASYYLnlwkP58/DGh4KA+4QJoCQcaI+SQU12FBLiiNYWSLMMfkUiOEwboKaLhshx5ewAUnfkXj5BCyaatf7UetPoTFuJP76KBd7gU6puDnXT5ePB9Am2J2c1X1t+jWP+zAFF0zxRzCpQrwUDhRdcpT50AQZvg+g4IXxV29sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082783; c=relaxed/simple;
	bh=Vo2FM/qCH/UuD9nSqAmoBmt/16+P8zZd/Uc15xZeUi8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehN+46GJHn9ItUaoalvJMKajxU2PYjAeivlAowacf6Kg3tEJ4BNEwlAi+y7MziYgNXZQtdr1U4LgYtPrHddsXR3KCffeGX+pOrmQlC43p95d8/wrv+IuWZLBfYFDmVWy5rpLMAxSkgBfuNeG4WuaHtkEQ2Hu9MjeRoTGRa5EiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=moc4jDQi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=moc4jDQi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E78C5C824
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714082778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVQNTp88uKsxR4Ejf7UsSVXMCk/0Co/GgbnZeVvqxz4=;
	b=moc4jDQi/jYDHHZDVUCqzQbX9HN/Ne8lccEsuvaM41L/7FizAtUKcXapdVOmogTBt62z2P
	Mm8vBWDOrAxnzkKvJe9hwXIzh6c4FVqG4VxkXgs1aIhTGrCRhxKKhCAPxl/5VB80prCtJc
	+KidJ4/J/6f4xvMhk22kCPCOkMxlB2Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714082778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVQNTp88uKsxR4Ejf7UsSVXMCk/0Co/GgbnZeVvqxz4=;
	b=moc4jDQi/jYDHHZDVUCqzQbX9HN/Ne8lccEsuvaM41L/7FizAtUKcXapdVOmogTBt62z2P
	Mm8vBWDOrAxnzkKvJe9hwXIzh6c4FVqG4VxkXgs1aIhTGrCRhxKKhCAPxl/5VB80prCtJc
	+KidJ4/J/6f4xvMhk22kCPCOkMxlB2Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E68CE1393C
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oMbdH9jTKmaQdgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Apr 2024 22:06:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: misc-tests: remove the subvol-delete-qgroup test case
Date: Fri, 26 Apr 2024 07:35:53 +0930
Message-ID: <afcd81cd552fec9c8357342b7895c87b2c02eb24.1714082499.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714082499.git.wqu@suse.com>
References: <cover.1714082499.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The test case relies on `--delete-qgroup` option, but the feature is not
properly designed from the very beginning, and would not work for most
cases.

The test case does not take the complexity of subvolume dropping into
consideration and only tested the simplest cases.

Since the `--delete-qgroup` option patch is reverted, we also need to
revert this one too.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../061-subvol-delete-qgroup/test.sh          | 47 -------------------
 1 file changed, 47 deletions(-)
 delete mode 100755 tests/misc-tests/061-subvol-delete-qgroup/test.sh

diff --git a/tests/misc-tests/061-subvol-delete-qgroup/test.sh b/tests/misc-tests/061-subvol-delete-qgroup/test.sh
deleted file mode 100755
index c2637ac33cdc..000000000000
--- a/tests/misc-tests/061-subvol-delete-qgroup/test.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/bash
-# Create subvolumes with enabled qutoas and check that subvolume deleteion will
-# also delete the 0-level qgruop.
-
-source "$TEST_TOP/common" || exit
-
-setup_root_helper
-prepare_test_dev
-
-run_check_mkfs_test_dev
-run_check_mount_test_dev
-run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file bs=1M count=1
-
-# Without quotas
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv2"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete --delete-qgroup "$TEST_MNT/subv1"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete --no-delete-qgroup "$TEST_MNT/subv2"
-run_check $SUDO_HELPER "$TOP/btrfs" filesystem sync "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume sync "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" subvol list "$TEST_MNT"
-
-# With quotas enabled
-run_check $SUDO_HELPER "$TOP/btrfs" quota enable "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
-rootid1=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid "$TEST_MNT/subv1")
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv2"
-rootid2=$(run_check_stdout "$TOP/btrfs" inspect-internal rootid "$TEST_MNT/subv2")
-run_check $SUDO_HELPER "$TOP/btrfs" qgroup create 1/1 "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" qgroup assign "0/$rootid1" 1/1 "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" qgroup assign "0/$rootid2" 1/1 "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" quota rescan --wait "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" subvol list "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" qgroup show "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete --delete-qgroup "$TEST_MNT/subv1"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete --no-delete-qgroup "$TEST_MNT/subv2"
-run_check $SUDO_HELPER "$TOP/btrfs" filesystem sync "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" subvolume sync "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" subvol list "$TEST_MNT"
-run_check $SUDO_HELPER "$TOP/btrfs" qgroup show "$TEST_MNT"
-if run_check_stdout $SUDO_HELPER "$TOP/btrfs" qgroup show "$TEST_MNT" | grep -q "0/$rootid1"; then
-	_fail "qgroup 0/$rootid1 not deleted"
-fi
-if ! run_check_stdout $SUDO_HELPER "$TOP/btrfs" qgroup show "$TEST_MNT" | grep -q "0/$rootid2"; then
-	_fail "qgroup 0/$rootid2 deleted"
-fi
-run_check_umount_test_dev
-- 
2.44.0


