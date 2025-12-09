Return-Path: <linux-btrfs+bounces-19599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D96AFCAF578
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30F130204BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3602D7DC2;
	Tue,  9 Dec 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aXFvhGu6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B/1y29+a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5A2D6E52
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270355; cv=none; b=IHmAQy4QL3BqZUYp4jQKfXy857rrqCWdU2/njAJinrLE8QgVr4gDWpPgn6UBnWu3HW6cshcKNUCh6HL4sRsDrbe14h4HgDtQ56XJu7C6RRdLGHq+pzM1twNeHwrNuUeKvwA55clt4boLh6x3ki6YIVXgygKnvGqdAUO6WKYlEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270355; c=relaxed/simple;
	bh=8AM1Ga30jxehdbYUcNtMFcwFPQQzlIOycsV/4dhHuF4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OrwteSOkWDjlMNI8BgLwK3YyyGyLnwCGOKzAa0w4JygJUnQ/cwv024iZYVInK2Y2TlticgRcjpR86Yc9PKNkcI28q8d6tEucfyB6b3ruxmy55iqYbmqrMtUPq1I8KQASpmBw8rn7LDkAo91H734KArYJFk4jPWnR/Q4ETZ0OGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aXFvhGu6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B/1y29+a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA65E337A2;
	Tue,  9 Dec 2025 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765270352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cRs3InfbglS7NQCeU9avWhyxaSOAoH32Fozpj/tDxmc=;
	b=aXFvhGu69ilQ4Pg9EcsNMlbcOL5CKrXdoAMbfl5KtZIuea9MQPmkLba3oTb4qVOlF/mtl7
	MVStbJXYPdBS3d85i2hy3o3opnXvc3VdBjel8SOXPBpSj7Gam+FAH5dN1Tg563seINWG3s
	6kjZvh53SCkF44jYslxoxU31qsDgwR0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765270351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cRs3InfbglS7NQCeU9avWhyxaSOAoH32Fozpj/tDxmc=;
	b=B/1y29+a4RFnL8hrdHeOGRVRBGqFg8kyGxDY49HgE5b5CdGXAQJY3+jm0YZYNcm76EqM8T
	xWk9Nhtu3sBkfDxmn3k2PKKtRuwHmV7Rsxjh8SlNOeLrU7JPecZikGg9QPDlLXUr76dlaH
	esVFy+AIVecKzJl7U7Ql24I6BC75bLc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCF513EA63;
	Tue,  9 Dec 2025 08:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YlSgH07jN2nvFgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 09 Dec 2025 08:52:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/301: use correct blocksize to fill the fs
Date: Tue,  9 Dec 2025 19:22:13 +1030
Message-ID: <20251209085213.110213-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

[FAILURE]
When running the test with 8K fs block size (tried both 4K page size and
64K page size), the test case btrfs/301 always fail like this:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-custom+ #323 SMP PREEMPT_DYNAMIC Mon Dec  8 07:38:30 ACDT 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/301    42s ... - output mismatch (see /home/adam/xfstests/results//btrfs/301.out.bad)
    --- tests/btrfs/301.out	2024-01-02 14:44:11.140000000 +1030
    +++ /home/adam/xfstests/results//btrfs/301.out.bad	2025-12-09 19:14:32.057824678 +1030
    @@ -1,18 +1,71 @@
     QA output created by 301
     basic accounting
    +subvol 256 mismatched usage 41099264 vs 33964032 (expected data 33554432 expected meta 409600 diff 7135232)
    +subvol 256 mismatched usage 175316992 vs 168181760 (expected data 167772160 expected meta 409600 diff 7135232)
    +subvol 256 mismatched usage 41099264 vs 33964032 (expected data 33554432 expected meta 409600 diff 7135232)
    +subvol 256 mismatched usage 41099264 vs 33964032 (expected data 33554432 expected meta 409600 diff 7135232)
     fallocate: Disk quota exceeded
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/301.out /home/adam/xfstests/results//btrfs/301.out.bad'  to see the entire diff)

[CAUSE]
Although the subvolume usage doesn't match the expectation, "btrfs check"
doesn't report any qgroup number mismatch.
This means the qgroup numbers are correct, but our expectation is not.

Upon inspection of the on-disk file extents, there are a lot of file
extents that are partially overwritten.

This means during the fio random writes, there are fs blocks that are
partially written, then written back to the storage, then written again.
This is a symptom of too small IO block size.

The default FIO blocksize is only 4K, and it will result the above
overwrite of the same fs block for 8K fs block size.

[FIX]
Add blocksize option to the fio config, so that we won't have
above over-write behavior which boost the qgroup numbers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/301 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index f1f33cd9..1f72a97b 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -32,6 +32,9 @@ fill_sz=$((64 * 1024))
 total_fill=$(($nr_fill * $fill_sz))
 nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
 					grep nodesize | $AWK_PROG '{print $2}')
+blocksize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
+					grep sectorsize | $AWK_PROG '{print $2}')
+echo "blocksize=$blocksize" >> $seqres.full
 ext_sz=$((128 * 1024 * 1024))
 limit_nr=8
 limit=$(($ext_sz * $limit_nr))
@@ -45,6 +48,7 @@ directory=${subv}
 rw=randwrite
 nrfiles=${nr_fill}
 filesize=${fill_sz}
+blocksize=${blocksize}
 EOF
 _require_fio $fio_config
 
-- 
2.51.2


