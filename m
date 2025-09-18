Return-Path: <linux-btrfs+bounces-16920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F3B843A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C34189CB4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EFC2F3621;
	Thu, 18 Sep 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kUt9b9cq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kUt9b9cq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D927AC2F
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192681; cv=none; b=qWArIjIsqvUKi03VUqiMUo5hTa/SVPjGOAxl6SKw76/Gm3O5Sk8w/ASel8bowPha8kC/IxVpYZAP7V441EvZ+Pun88SVl+NKcB/FAIpQljjIPHu+8Wb282pf2NsbEqOl5MrLarcfPEhGb7qsuEYhdHCQZn7hjFbme4LJMh/SN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192681; c=relaxed/simple;
	bh=rNrGD5P74HbeeTJNPr+lynNWGgcW6xCjGU0/W1VIl/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UjpuXle4pLSmUDh1yDSiK62gKuIy8Wj6WbxjDUKGy/gaKYOueFMZYQTCpNbOuFCKYL55rCRfTYgyOQR8Xv/BxAeVGyjlmN3OOeMdHtl5BbxxxN1zdKK6AZUnoIX7M18G8QaZhXdBXLZ4G9A52o0/AMEHlgdk6piJo8MpTFS+bBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kUt9b9cq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kUt9b9cq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD98336E7;
	Thu, 18 Sep 2025 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758192677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a0Y+h8aVoHvdK9Ue55c8FHy6RJN1yPd7GkADGAQDwng=;
	b=kUt9b9cqprFZcEf/ij527qYpE/GInVNOKT4j8IH7DSPnTTnxY/d4Wd8Qsd7238Zq/+cW+V
	/ObpxKKttM4qgY9CsXaEL4/8nmrKutXSU5EjMG52hZYxFbwpccCo195zBHnY7EONOXzc/c
	yHSProCq/R3Mv+vZHHdl+toCuemsiOw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758192677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=a0Y+h8aVoHvdK9Ue55c8FHy6RJN1yPd7GkADGAQDwng=;
	b=kUt9b9cqprFZcEf/ij527qYpE/GInVNOKT4j8IH7DSPnTTnxY/d4Wd8Qsd7238Zq/+cW+V
	/ObpxKKttM4qgY9CsXaEL4/8nmrKutXSU5EjMG52hZYxFbwpccCo195zBHnY7EONOXzc/c
	yHSProCq/R3Mv+vZHHdl+toCuemsiOw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A321113A39;
	Thu, 18 Sep 2025 10:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QRjLGSTky2i3dQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 10:51:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/304: skip the run if block size is not 4K
Date: Thu, 18 Sep 2025 20:20:55 +0930
Message-ID: <20250918105055.101540-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[FALSE ALERT]
When running btrfs with block size larger than 4K (e.g. 8K in this
case), the test case will fail like this:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/304 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/304.out.bad)
    --- tests/btrfs/304.out	2024-07-15 16:17:42.639999997 +0930
    +++ /home/adam/xfstests/results//btrfs/304.out.bad	2025-09-18 18:44:13.761000000 +0930
    @@ -10,7 +10,7 @@
     leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
     fs uuid <UUID>
     chunk uuid <UUID>
    -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
    +	item 0 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
     			stripe 0 devid 1 physical XXXXXXXXX
     total bytes XXXXXXXX
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/304.out /home/adam/xfstests/results//btrfs/304.out.bad'  to see the entire diff)

In the above case it's the experimental support of block size larger
than page size.
The feature is still under development.

[CAUSE]
That test case requires 4K block size, but it has no way to control
that, as QA runners can specify MKFS_OPTIONS="-s 8k", to override the
default block size.

Normally this is impossible as on x86_64 the only supported block size is
4K, already the minimal block size of btrfs. So there is no way to use
other block size in that test case.

However with the experiemental bs > ps support, even on x86_64 it's
possible to use 8K block size, and that breaks the 4K block size
assumption of the test case.

[FIX]
Add quick scratch mkfs, and grab the block size of the resulted fs.
If the block size is not 4K, skip the run.

Since we're here, also remove the page size check, since we have subpage
block size support for a while, and replace it with a more accurate
supported sectorsize check.

This more accurate sectorsize support now allows aarch64 (64K page size)
to run btrfs/304 successfully, improving the subpage bs support coverage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/304 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/304 b/tests/btrfs/304
index b7ed66af..95c493db 100755
--- a/tests/btrfs/304
+++ b/tests/btrfs/304
@@ -20,8 +20,13 @@ _require_btrfs_fs_feature "raid_stripe_tree"
 _require_btrfs_fs_feature "free_space_tree"
 _require_btrfs_free_space_tree
 _require_btrfs_no_compress
+_require_btrfs_support_sectorsize 4096
 
-test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+_scratch_mkfs >> /dev/null
+blksz=$(_scratch_btrfs_sectorsize)
+if [ $blksz -ne 4096 ]; then
+	_notrun "this tests require blocksize 4096, has $blocksize"
+fi
 
 test_4k_write()
 {
-- 
2.51.0


