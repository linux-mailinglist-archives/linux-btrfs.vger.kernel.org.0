Return-Path: <linux-btrfs+bounces-16925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6881AB84419
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D287466803
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1A2F362B;
	Thu, 18 Sep 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BFdSYIMV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BFdSYIMV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F523ABA0
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193379; cv=none; b=R1kgAJY/H/JxZeIl4DRrbwu0e4ir5YpAofQrwMKDWwUvcK0zSlSztgwhmvGcZHw1HV3hmmly17DYxAcbvfEeI4MX1qI98NTFPoU0yLwX26AeBe2MnPjWillx2CsC4m+UfjyoXwQhxubH6h+2BWhHXkQrqXZppwsNIAmBohPHdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193379; c=relaxed/simple;
	bh=gdCDixKFFvXHQUz63U5MNRJGnQGc7xIDbWXRlKEphV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dxc6snKWO5PoVflXV8SmDl57W/lT5U4i57RmbLXq+9SC9D3uZif6QSocMrIRzW0p7QkHSVs79NGKpSofOGjY9mybNK0ZMiLp7SWB4PLUIWkLOIhSJ9+RZt4V3q73LmOEiL51TmoujtOyiq1EQ7zZ/ffe+hAlmBONYB19Ni44v1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BFdSYIMV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BFdSYIMV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 486471F393;
	Thu, 18 Sep 2025 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758193375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Gat0UwzKSh6SXlM6Ji6UvoMiXghbrm89mmn+8clEps=;
	b=BFdSYIMV912DxZBtcwe6JMgxdL3bKbfDKGWfB+EkOaAOyXFgcSqVFIhUTMEO1nQLD7yy3Q
	m706odvvzMyVFVZryCm0vMFAWvKLIxvOXBYOnnNW1+TbwbFJUSchlYIvexs8pjy2D4GWpy
	I2WdhtvvYb2JO8w6b+hAZBSUp0VWiis=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BFdSYIMV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758193375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3Gat0UwzKSh6SXlM6Ji6UvoMiXghbrm89mmn+8clEps=;
	b=BFdSYIMV912DxZBtcwe6JMgxdL3bKbfDKGWfB+EkOaAOyXFgcSqVFIhUTMEO1nQLD7yy3Q
	m706odvvzMyVFVZryCm0vMFAWvKLIxvOXBYOnnNW1+TbwbFJUSchlYIvexs8pjy2D4GWpy
	I2WdhtvvYb2JO8w6b+hAZBSUp0VWiis=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 352B213A39;
	Thu, 18 Sep 2025 11:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XVSJOd3my2iFeQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 11:02:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/306: skip the run if block size is not 4K
Date: Thu, 18 Sep 2025 20:32:36 +0930
Message-ID: <20250918110236.102931-1-wqu@suse.com>
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
X-Rspamd-Queue-Id: 486471F393
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
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

btrfs/306 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/306.out.bad)
    --- tests/btrfs/306.out	2024-07-15 16:17:42.639999997 +0930
    +++ /home/adam/xfstests/results//btrfs/306.out.bad	2025-09-18 18:44:16.075000000 +0930
    @@ -14,7 +14,7 @@
     chunk uuid <UUID>
     	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
     			stripe 0 devid 1 physical XXXXXXXXX
    -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
    +	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
     			stripe 0 devid 2 physical XXXXXXXXX
     total bytes XXXXXXXX
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/306.out /home/adam/xfstests/results//btrfs/306.out.bad'  to see the entire diff)

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
to run btrfs/306 successfully, improving the subpage bs support coverage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/306 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/306 b/tests/btrfs/306
index b47c446b..879f67b4 100755
--- a/tests/btrfs/306
+++ b/tests/btrfs/306
@@ -21,8 +21,13 @@ _require_btrfs_fs_feature "raid_stripe_tree"
 _require_btrfs_fs_feature "free_space_tree"
 _require_btrfs_free_space_tree
 _require_btrfs_no_compress
+_require_btrfs_support_sectorsize 4096
 
-test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+_scratch_mkfs >> /dev/null
+blksz=$(_scratch_btrfs_sectorsize)
+if [ $blksz -ne 4096 ]; then
+	_notrun "this tests require blocksize 4096, has $blksz"
+fi
 
 test_4k_write_64koff()
 {
-- 
2.51.0


