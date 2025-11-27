Return-Path: <linux-btrfs+bounces-19368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 569DAC8CDE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 06:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1784E3B49
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 05:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12C530F7F7;
	Thu, 27 Nov 2025 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t7AwKZkI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t7AwKZkI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C01EA7CC
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764221135; cv=none; b=Y/Wok5HF1BCmwpGZ6TPHwKBuWaqKp/z+yBM1eDTAqJFix7jJMvtLsdmrjrRK0/xxA29ZopTJyILv40Hsob6AcG3gCccsr06qCYl0HydCUYJvcWLTy009ciE0xg9v+hdAENTtRO/4g5KfC5Lio73s7FIgPQrgWUUQaYeR6Go+wUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764221135; c=relaxed/simple;
	bh=ISb6BV58OhCFnVLXf7naoZpmqRE8D6Ei1gVQaxNqvag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be6TxBuwUqX1hGX49mhCosc1qWP8NpTtc9TA7ZBhVlmIkh1fkrvG1E3K/79u86NVNkXQTFozpwYnx+1P92f1VC9f63fHefFeRpxbBAGwqeZWQOw9rMzh3RPptagV9J9V/0ahQzThsyJ8pQ+1oZdpQt+Om5q1mvpVa4oTRUHTt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t7AwKZkI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t7AwKZkI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B85E75BCC5
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4GXbJKwWiLkNfPMDZPVXCRVRGGXBlHkJi8a095xORI=;
	b=t7AwKZkIotghQIPteggs4YJlj2lwgadtQXcOOzUZKarSYAIkWtT0Kuyzi/VhvU3BOIglcM
	Xtvt5PvSfCnfJ7p8i9RiQaWcKuZ/vfmQWM7C6DfuaHc+ar+Vkpv60lDyM9RXof03wqClKC
	i5eBoNl3mafpFbcjrXYrt9fnvW7yiSw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764221125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4GXbJKwWiLkNfPMDZPVXCRVRGGXBlHkJi8a095xORI=;
	b=t7AwKZkIotghQIPteggs4YJlj2lwgadtQXcOOzUZKarSYAIkWtT0Kuyzi/VhvU3BOIglcM
	Xtvt5PvSfCnfJ7p8i9RiQaWcKuZ/vfmQWM7C6DfuaHc+ar+Vkpv60lDyM9RXof03wqClKC
	i5eBoNl3mafpFbcjrXYrt9fnvW7yiSw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 025A43EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UL7SLcTgJ2l3fgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:25:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: misc-tests: check if free space tree is enabled after mount
Date: Thu, 27 Nov 2025 15:55:03 +1030
Message-ID: <0cc91f44cac758721ffc9c575fde8d234b3b5bee.1764220734.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764220734.git.wqu@suse.com>
References: <cover.1764220734.git.wqu@suse.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

For bs < ps cases, a mount will always enable free-space-tree due to the
limitation of v1 space cache.

Test case misc/057 will lead to false failure if the page size is larger
than the default 4K sector size.

Add an extra check on free-space-tree after fs population, and skip the
test case if so.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
index fe5b87a1fd38..f4099dd639e7 100755
--- a/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
+++ b/tests/misc-tests/057-btrfstune-free-space-tree/test.sh
@@ -17,6 +17,14 @@ run_check_mount_test_dev
 populate_fs
 run_check_umount_test_dev
 
+# Check if the fs has free space tree already. Currently bs < ps mount
+# will always enable free-space-tree (no support for v1 free space cache)
+if run_check_stdout "$TOP/btrfs" inspect-internal dump-super "$TEST_DEV" |\
+	grep -q "FREE_SPACE_TREE"; then
+	_not_run "free-space-tree is always enabled for page size $(getconf PAGESIZE)"
+fi
+
 run_check $SUDO_HELPER "$TOP/btrfstune" --convert-to-free-space-tree "$TEST_DEV"
 
+
 run_check "$TOP/btrfs" check "$TEST_DEV"
-- 
2.52.0


