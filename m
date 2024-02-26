Return-Path: <linux-btrfs+bounces-2762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE55866921
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 05:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9471C21B3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 04:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7311BF20;
	Mon, 26 Feb 2024 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r727o3bB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pmjaNii6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49B91BDD3;
	Mon, 26 Feb 2024 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920178; cv=none; b=uFgWprbw5yP+Dz84yfd5de+LLCew1Qi2SvBhU47lAF+w3xR/CI+5+mlRxM+IqqXWRDYY2hPSlR944yKDRqdE4V9czps54IYyaNP1deK6YxYZJ0dmF7PNeq3z/qwLv4/uZUVdHZffqDsnB06Cbfr426xl3gTYhr7tAoiUkh1RzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920178; c=relaxed/simple;
	bh=FL/D1nmc2Zp60YRvyOv38rPEjdrGYpd9jsvUk/s5xAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E+ofr1N360XQpT2EinJlIn3NVdR9RSYBjNpzdGveqBU5WLMFLGM5sZf4m8UeXhJFcUx0slJu3yQUQoK8db+SsT38Ey52mfoXYJ0Jz67zK9/ADKj/uZyYWaMzQnvPqHG0RHUZfaQHYgZEYSVDW4B+1Cj7u39lhiz7AOQulspBoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r727o3bB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pmjaNii6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF0812248B;
	Mon, 26 Feb 2024 04:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708920174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6nLdoHbkkPVx6Oz7x/WIGQluU6C+GKY9apiVjvU66Vk=;
	b=r727o3bB2uHyzqDY1p7Sa8RrhgIkn6cKaZbSD4KY1rUtGy54z4tDtNz8EoDFVL5tvFe5XH
	QRmk/o7mefp372+pT78qhQv+qWJLSnqhGu8q4c5VKk/H5sg92ZziN9Q2K6VjGocaixnehX
	6+tmc4rUuCws6oopAACUJiQBAzrtIgE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708920173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6nLdoHbkkPVx6Oz7x/WIGQluU6C+GKY9apiVjvU66Vk=;
	b=pmjaNii6gwdYPNSY3cbMMDz/FuAgcG4jhOGDI59VW5sNC9mN+Nx4UavXfvp5KyBzMjxuHA
	eBuECNsQ2TOej272miUc78cFGowAQJ1O6YXIb2Z9/6BWeEbnf1fQSo7ZtZRy6zESZqZqOS
	Buba/oqwqyWsADM8xRUOtoujyHvCdKY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F16A13A71;
	Mon, 26 Feb 2024 04:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AVMGFmwN3GXPVwAAn2gu4w
	(envelope-from <wqu@suse.com>); Mon, 26 Feb 2024 04:02:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/224: do not assign snapshot to a subvolume qgroup
Date: Mon, 26 Feb 2024 14:32:34 +1030
Message-ID: <20240226040234.102767-1-wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pmjaNii6
X-Spamd-Result: default: False [9.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAM_FLAG(5.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.32)[75.57%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 9.37
X-Rspamd-Queue-Id: AF0812248B
X-Spam-Level: *********
X-Spam-Flag: NO
X-Spamd-Bar: +++++++++

For "btrfs subvolume snapshot -i <qgroupid>", we only expect the target
qgroup to be a higher level one.

Assigning a 0 level qgroup to another 0 level qgroup is only going to
cause confusion, and I'm planning to do extra sanity checks both in
kernel and btrfs-progs to reject such behavior.

So change the test case to do regular higher level qgroup assignment
only.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/224 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/224 b/tests/btrfs/224
index de10942f..611df3ab 100755
--- a/tests/btrfs/224
+++ b/tests/btrfs/224
@@ -67,7 +67,7 @@ assign_no_shared_test()
 	_check_scratch_fs
 }
 
-# Test snapshot with assigning qgroup for submodule
+# Test snapshot with assigning qgroup for higher level qgroup
 snapshot_test()
 {
 	_scratch_mkfs > /dev/null 2>&1
@@ -78,9 +78,9 @@ snapshot_test()
 	_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
+	$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
 	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
-	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
-	$BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
 
 	_scratch_unmount
 	_check_scratch_fs
-- 
2.42.0


