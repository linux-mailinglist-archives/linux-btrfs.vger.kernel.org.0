Return-Path: <linux-btrfs+bounces-19598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F653CAF46D
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7C53028D93
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2C25A640;
	Tue,  9 Dec 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c2+X7ff2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kqpm/dEe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096611F419F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268733; cv=none; b=BxOVYa4zauSGCYU4SiJibl4VonXaanGcCkMubDxCWpC/uKKli8FJ91UiP7lQCsl1e3kUVO1/qgtoV/vwZoT0dwIb7zvgiQyN60PK6jbBct7UssPUiroTsD1VoWR9v8eggzR3xel67Bb8lbBUKj1I+KESbdPmAdPYeBB82drOCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268733; c=relaxed/simple;
	bh=IzvJq8cmdvwB7cTsmrElnfFMLx+ueU7IxybQCkC6t64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kAtNfvXSSBMtwAjrlkD/L6GQzIPPkHduuUGKYHiC5ViC4kVIClQ3Wi1ohPPijZWAtwEk9gAJM8c8v/w4Mvrm55+N8+QwuIT/Zivx9J5Ck9t+FIxgOqxznVu4qQjRcsUaMKdSxvvn/PQgB/MubfQ0Nk5J1JAeqN8cFRo4poN2aHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c2+X7ff2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kqpm/dEe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D71575BD97;
	Tue,  9 Dec 2025 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765268728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wkFisWNnn2Tm2Uc6X5IF7i9sXkQuYZ2tOJzehW3/9zI=;
	b=c2+X7ff2XdlbU6FWA+RSFi/nlAhjJqdpynhm6rjsKLy+jV2BRtCOpqSxbMcSwHL0v9VrkX
	lBvhPPDS8cAXl3hNyoE7BLrZxgYILsSGXYgyltKqWAxOwLPX4ZfIiA9CAQ3L64kMizlRCf
	4kJCGHRVBvaotsEAPCfTdWH9AMmVJXA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Kqpm/dEe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765268726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wkFisWNnn2Tm2Uc6X5IF7i9sXkQuYZ2tOJzehW3/9zI=;
	b=Kqpm/dEe2YwT9GPLcFob6OFjXZM35iUZiFt2c4e1OZAQLBjTs/inrClzn3SvP9Eno3dyHx
	CnHBUrni+A3SV2YIY0SCPCYLRRIfSTsEkfnwj0UYK8xmnTrCSFsV2B4M8mdzw4AVp6vlyX
	BrF0vF3pL2KdFTfI3QeCQQIFo6qwK+g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D89AE3EA63;
	Tue,  9 Dec 2025 08:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MYFjJvXcN2n/fAAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 09 Dec 2025 08:25:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/226: skip the test for bs > ps cases
Date: Tue,  9 Dec 2025 18:55:04 +1030
Message-ID: <20251209082504.107995-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: D71575BD97
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,btrfs-vm:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

[RANDOM FAILURE]
Sometimes btrfs/226 can fail but sometimes it can also pass with 8K
fs block size and 4K page size:

[adam@btrfs-vm xfstests]$ sudo ./check btrfs/226
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-custom+ #323 SMP PREEMPT_DYNAMIC Mon Dec  8 07:38:30 ACDT 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/226    2s ...  3s
Ran: btrfs/226
Passed all 1 tests

[adam@btrfs-vm xfstests]$ sudo ./check btrfs/226
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-custom+ #323 SMP PREEMPT_DYNAMIC Mon Dec  8 07:38:30 ACDT 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/226    3s ... - output mismatch (see /home/adam/xfstests/results//btrfs/226.out.bad)
    --- tests/btrfs/226.out	2024-04-12 14:04:03.080000035 +0930
    +++ /home/adam/xfstests/results//btrfs/226.out.bad	2025-12-09 18:46:44.416878799 +1030
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
For the failure case, the failure is from check_direct_IO(), which find
out that the buffer provided is only aligned to PAGE_SIZE (4K), not to the
fs block size (8K).

The user space can only ensure the allocated memory is contiguous in the
user space, but the user space can not ensure the underlying physical
memory layout, thus depending on the memory allocation situation, the
user space can not always get physically contiguous memory, and fail the
check_direct_IO() call.

After failed check_direct_IO(), we fall back to buffered IO, but since
this particular test case is using RWF_NOWAIT, rejecting buffered IO
fallback, the direct IO failed with -EAGAIN.

[FIX]
Since we can not ensure the physical memory layout for direct IO, just
skip this test case if the fs block size is larger than page size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/226 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/btrfs/226 b/tests/btrfs/226
index afab5868..110a1239 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -26,6 +26,10 @@ _scratch_mkfs >>$seqres.full 2>&1
 # nodatasum (otherwise it falls back to buffered IO).
 _scratch_mount -o nodatasum
 
+if [ "$(_get_block_size $SCRATCH_MNT)" -gt "$(_get_page_size)" ]; then
+	_notrun "fs block size larger than page size, unreliable direct IO buffer alignment"
+fi
+
 # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
 # NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
 echo "Testing write against COW file"
-- 
2.51.2


