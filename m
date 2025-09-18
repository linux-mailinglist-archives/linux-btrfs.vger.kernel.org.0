Return-Path: <linux-btrfs+bounces-16924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028AAB843FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863A21BC2F23
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9E2FFDE9;
	Thu, 18 Sep 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s7cUfCtQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s7cUfCtQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731B2FFFA3
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193173; cv=none; b=lW270Oz1r9P307s4WD3XpmQkoit2eZPzGbJETGfDqrNIUy7qZmJupRiuWCsGXZOmqjHEYt+8LvPtL/l9yUIMQY/HO6ZAGX9tiBUH6ZRzdLeb1MsrkAYsgiPKrkoIJ+nqUsazyQr7siXbSjoscBHSKdUad8g4pg85zDL0KYWngVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193173; c=relaxed/simple;
	bh=fwe44n39iiOFOcBiJiyBldHSbp1YT+UHKY4nYWteqHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A6GE7tOAHBFuHq8GR9CysuyFmWRENEoiohVQVygg2M4h2ZLIxwTyPqppryWcAU6+mk5EApLiZ/+GHkQfFPbpbsU3bmkUP/XuvAX5nJxvKh+8BpnAFbD081tilOM/MTCLjp7ftslmgyj9a2t48DoYSL4a2Qb0p4VXqmVLohhxKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s7cUfCtQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s7cUfCtQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5148A1F393;
	Thu, 18 Sep 2025 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758193168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0gb+TnnIlAOj/mR564zg4oUEOiB5UMGi3/MwcOyAghs=;
	b=s7cUfCtQw9ufB0MK4M3D2ut/k3hTn9gAUAP9zAgftETp92LD0DhjbJzJIvUKEFpCl0FGta
	wBdSiQISzkGzx8w3PMKEPU6+HnLn97aW/77D3aP/FHRFqksS5zz9JaqKLp06WWVwHVO+F6
	ZcCgGj6oDecv3YSV4+ISjeJgz8BrX8s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=s7cUfCtQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758193168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0gb+TnnIlAOj/mR564zg4oUEOiB5UMGi3/MwcOyAghs=;
	b=s7cUfCtQw9ufB0MK4M3D2ut/k3hTn9gAUAP9zAgftETp92LD0DhjbJzJIvUKEFpCl0FGta
	wBdSiQISzkGzx8w3PMKEPU6+HnLn97aW/77D3aP/FHRFqksS5zz9JaqKLp06WWVwHVO+F6
	ZcCgGj6oDecv3YSV4+ISjeJgz8BrX8s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5290D13A39;
	Thu, 18 Sep 2025 10:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ILiYBQ/my2hTeAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 10:59:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] btrfs/305: skip the run if block size is not 4K
Date: Thu, 18 Sep 2025 20:29:09 +0930
Message-ID: <20250918105909.102551-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5148A1F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[FALSE ALERT]
When running btrfs with block size larger than 4K (e.g. 8K in this
case), the test case will fail like this:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/305 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/305.out.bad)
    --- tests/btrfs/305.out	2024-07-15 16:17:42.639999997 +0930
    +++ /home/adam/xfstests/results//btrfs/305.out.bad	2025-09-18 18:44:14.914196231 +0930
    @@ -12,11 +12,9 @@
     leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
     fs uuid <UUID>
     chunk uuid <UUID>
    -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
    +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
     			stripe 0 devid 1 physical XXXXXXXXX
    -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/305.out /home/adam/xfstests/results//btrfs/305.out.bad'  to see the entire diff)

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
Add a quick scratch mkfs, and grab the block size of the resulted fs.
If the block size is not 4K, skip the run.

Since we're here, also remove the page size check, since we have subpage
block size support for a while, and replace it with a more accurate
supported sectorsize check.

This more accurate sectorsize support now allows aarch64 (64K page size)
to run btrfs/305 successfully, improving the subpage bs support coverage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the _notrun message to use $blksz instead of the wrong $blocksize
---
 tests/btrfs/305 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/305 b/tests/btrfs/305
index ad060853..bd484bbe 100755
--- a/tests/btrfs/305
+++ b/tests/btrfs/305
@@ -22,7 +22,13 @@ _require_btrfs_fs_feature "free_space_tree"
 _require_btrfs_free_space_tree
 _require_btrfs_no_compress
 
-test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+_require_btrfs_support_sectorsize 4096
+
+_scratch_mkfs >> /dev/null
+blksz=$(_scratch_btrfs_sectorsize)
+if [ $blksz -ne 4096 ]; then
+	_notrun "this tests require blocksize 4096, has $blksz"
+fi
 
 test_8k_new_stripe()
 {
-- 
2.51.0


