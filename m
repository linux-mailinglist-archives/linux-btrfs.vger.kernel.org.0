Return-Path: <linux-btrfs+bounces-11307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEBAA29C3F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 22:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639213A46C2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 21:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0737221519B;
	Wed,  5 Feb 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n2iIfE+n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n2iIfE+n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26876214214;
	Wed,  5 Feb 2025 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792749; cv=none; b=IKkYpmgdT318M+Qy1Ea4AxoziQ59lcAaROhh8lr/J8/rDsscZvLNfeTP0ijW4Cn0/nG+VH9wYoTTCOhJGNwH33agL3dqxak2FW44bpersRhDvbAVvuFA8vqrgwhLm9LgY4wTVF0h8yHUIEPQMTgzvhd6fjVOv+5vMcnmNCTeSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792749; c=relaxed/simple;
	bh=mRFMCZXkHL+Wb9EBU8hlumB9QsrCFTiOuR/fPIDyqk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCPVfgj+HzUJ31IBWyjeAmlZ/MjcFIB/MOuYAdHXIEpBlc3hz+DHYiu/Wy16iqcPBFA1zF9UcGPRj26hfGbwMDcyt/KiRaDy8g0Hm+akoZkQuk94yesyYlCG0Vkdd67TwbIijkkSCAWDokmOkh/LppwRWaIe/IpK774EAszholo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n2iIfE+n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n2iIfE+n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B0291F397;
	Wed,  5 Feb 2025 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738792745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gKEr9x1dsukK+q/aU4lOpfVsg8ziYkZorQve7zWjy7Q=;
	b=n2iIfE+neTefNwUU9ObNe970Wv80vxDZ2Ll7Jwx59s4IoSBjKYhSKDBUfg2SEcQh8FDKsi
	xZxqTvQyuL4n49CQ8t/oqQbery+HAsevmZ1QkCGSGy51qVkJycRDabE8xrwZ9F8VKYcqww
	4ug1yCP/JoqqyB7rNAACzJCdDEnO96M=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=n2iIfE+n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738792745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gKEr9x1dsukK+q/aU4lOpfVsg8ziYkZorQve7zWjy7Q=;
	b=n2iIfE+neTefNwUU9ObNe970Wv80vxDZ2Ll7Jwx59s4IoSBjKYhSKDBUfg2SEcQh8FDKsi
	xZxqTvQyuL4n49CQ8t/oqQbery+HAsevmZ1QkCGSGy51qVkJycRDabE8xrwZ9F8VKYcqww
	4ug1yCP/JoqqyB7rNAACzJCdDEnO96M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D17FB139D8;
	Wed,  5 Feb 2025 21:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vAyFJCffo2cjEgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 05 Feb 2025 21:59:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>
Subject: [PATCH] fstests: btrfs/226: use nodatasum mount option to prevent false alerts
Date: Thu,  6 Feb 2025 08:28:46 +1030
Message-ID: <6b66d881e152296eab70acc19991d9a611aefde6.1738792721.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B0291F397
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
With recent kernel patch "btrfs: always fallback to buffered write if the
inode requires checksum", the test case btrfs/226 will fail with the
following error:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.13.0-rc6-custom+ #209 SMP PREEMPT_DYNAMIC Fri Jan 24 17:23:03 ACDT 2025
MKFS_OPTIONS  -- /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/226 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/226.out.bad)
    --- tests/btrfs/226.out	2024-04-12 14:04:03.080000035 +0930
    +++ /home/adam/xfstests/results//btrfs/226.out.bad	2025-02-06 08:23:42.564298585 +1030
    @@ -39,14 +39,11 @@
     Testing write against prealloc extent at eof
     wrote 65536/65536 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 65536
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +pwrite: Resource temporarily unavailable
     File after write:
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/226.out /home/adam/xfstests/results//btrfs/226.out.bad'  to see the entire diff)
Ran: btrfs/226
Failures: btrfs/226
Failed 1 of 1 tests

[CAUSE]
That kernel patch makes btrfs to always fallback to buffered IO if the
target inode requires data checksum.

This is to avoid more deadly problems of mismatched data checksum.

But this also means, for inodes with data checksum, RWF_NOWAIT will
always fail, because we will wait writing back the page cache, thus
breaking the RWF_NOWAIT requirement.

[FIX]
Update the test case to utilize nodatasum mount option, so that the
direct-IO will not fallback to buffered ones unconditionally.

Reported-by: Filipe Manana <fdmanana@kernel.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/226 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 70275d0aa2d8..359813c4f394 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -21,7 +21,12 @@ _require_xfs_io_command falloc -k
 _require_xfs_io_command fpunch
 
 _scratch_mkfs >>$seqres.full 2>&1
-_scratch_mount
+
+# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
+# btrfs will fall back to buffered IO unconditionally to prevent data checksum
+# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
+# So here we have to go with nodatasum mount option.
+_scratch_mount -o nodatasum
 
 # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
 # NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
-- 
2.48.1


