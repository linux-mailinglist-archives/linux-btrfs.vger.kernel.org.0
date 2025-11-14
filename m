Return-Path: <linux-btrfs+bounces-19031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E29C5F6C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 22:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 215973561A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C82302CDF;
	Fri, 14 Nov 2025 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DjnfzskH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DjnfzskH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F35302176
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156799; cv=none; b=j6EwzG0G7NvGa+oCsQ7VkosljFhfHB71b5/YMpNFXTKLPjPiDxDUIwICf8pMCbfStLX4yYyArDQJb0lNYIdVf1VE2yG6tfGsnZZIH4TE2eDT/leTysFli9LKKPPZs1XOWCkPfiTXNpLCCXHYWsHgNqeym9V1BZgQzlU9o1B3Tug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156799; c=relaxed/simple;
	bh=GKUWUl5hHpbxCx1bNH1zQ1SKHGCjd0oS1r6//58iRG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkKL3fLYkZNdiwDfVKcv4D3JeqHVe4YrZnn2hpFHjTha+go+LVsR/CtJUNv5ewBcYmsuE5tsd4pt8non44BSgKfSIIQpk/Le9GOJyDCVMSkTZZqNkaEhqajRRGMTLd38Y7g7lrvoYlgSFvy+hFjDSxpMUExxXDIa7lJ0fR+gmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DjnfzskH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DjnfzskH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A38E11F7F7
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763156789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwqq4kOzusx94Y1POMs0KTOo9MpxqTuUWWB+YaB+EF0=;
	b=DjnfzskHh1dKDSUIOYRcK92+6PXEBS5BAZ0FsJXjSTSAAkleP0cAF7faT57D1gWg57aysx
	aQieyzK9MPx30jYErNUEVPIQQs+Rekl4PkX9csxeyPy5TeLl05JIgFfXgcbkxWmuc7ZXyV
	ovjUizUnlPTxvQy0FGBN3rCJ5z5JGiw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DjnfzskH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763156789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwqq4kOzusx94Y1POMs0KTOo9MpxqTuUWWB+YaB+EF0=;
	b=DjnfzskHh1dKDSUIOYRcK92+6PXEBS5BAZ0FsJXjSTSAAkleP0cAF7faT57D1gWg57aysx
	aQieyzK9MPx30jYErNUEVPIQQs+Rekl4PkX9csxeyPy5TeLl05JIgFfXgcbkxWmuc7ZXyV
	ovjUizUnlPTxvQy0FGBN3rCJ5z5JGiw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEAD63EA62
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KA+6JzSjF2l/FQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: make test case 066 to be repairable
Date: Sat, 15 Nov 2025 08:16:00 +1030
Message-ID: <59b21f15f2199cd27233c367457935cb2708e63f.1763156743.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763156743.git.wqu@suse.com>
References: <cover.1763156743.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A38E11F7F7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

The test case fsck/066 is only to verify we can detect the missing root
orphan item, no repair for it yet.

Now the repair ability is added, change the test case to verify the
repair is also properly done.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../.lowmem_repairable                             |  0
 .../066-missing-root-orphan-item/test.sh           | 14 --------------
 2 files changed, 14 deletions(-)
 create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/.lowmem_repairable
 delete mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh

diff --git a/tests/fsck-tests/066-missing-root-orphan-item/.lowmem_repairable b/tests/fsck-tests/066-missing-root-orphan-item/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/066-missing-root-orphan-item/test.sh b/tests/fsck-tests/066-missing-root-orphan-item/test.sh
deleted file mode 100755
index 9db625714c1f..000000000000
--- a/tests/fsck-tests/066-missing-root-orphan-item/test.sh
+++ /dev/null
@@ -1,14 +0,0 @@
-#!/bin/bash
-#
-# Verify that check can report missing orphan root itemm as an error
-
-source "$TEST_TOP/common" || exit
-
-check_prereq btrfs
-
-check_image() {
-	run_mustfail "missing root orphan item not reported as an error" \
-		"$TOP/btrfs" check "$1"
-}
-
-check_all_images
-- 
2.51.2


