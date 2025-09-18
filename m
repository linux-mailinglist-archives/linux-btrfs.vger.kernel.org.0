Return-Path: <linux-btrfs+bounces-16918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00215B84126
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF881C206E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8FA28750B;
	Thu, 18 Sep 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kC6NBIuU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kC6NBIuU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD228137A
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191174; cv=none; b=DOJjNDR/Dgr5QSIwPiF7PTPtIAaW+INhs1nkfrzkdNYxTQNE6Vm8yXcbVcpaIUr1TPHblx1FNT1+Dcw4oW8Pf71+SL8tj3tJIgjatz0qLzHJ0FMfQ45B7Hmiro5I+WXmIF/aY9cB4OFRcz7cNhn1C26Zu3eqkuZOCG4AwZs/OeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191174; c=relaxed/simple;
	bh=rXzqghaTXiYADJRlBLzXjUS/5zhcbMBacEPijPaH8iI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VP8GfGmCeRRFmAu1ncW+ev1id6C2luLaqc8UqA4cG88asSQUQb32acNRhCEwDhTOE68m/cYJBgvKiZ3jP9SLpgDh4SoDWOzaF5KsbAAVej+SkPyVfFI+sDKJuuQvaG2J7CaCp6uX8Rk0vmX+lkSvapyX123nqH4Tj0bCIZwS2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kC6NBIuU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kC6NBIuU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C85C1F7E7;
	Thu, 18 Sep 2025 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758191170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V9JilDSROWCa0Ad+zriWk+vF5KBYMhtAM9yT+1A/PD0=;
	b=kC6NBIuUX7YEwbz3gw+KsINHolZ1+MCt0e+2hUGi1I5/B09muqe2V/z9qFfqJMH/yOmUuV
	ad2k8kql2UQWauV/AHnNrRUqKAKxe0CqwZEgJqRBPYp8cklUd05BiWFq1TraYVWGVaJj5V
	6x4ihCy2T182H4x5J9SsrIuOSNgUh4k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758191170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V9JilDSROWCa0Ad+zriWk+vF5KBYMhtAM9yT+1A/PD0=;
	b=kC6NBIuUX7YEwbz3gw+KsINHolZ1+MCt0e+2hUGi1I5/B09muqe2V/z9qFfqJMH/yOmUuV
	ad2k8kql2UQWauV/AHnNrRUqKAKxe0CqwZEgJqRBPYp8cklUd05BiWFq1TraYVWGVaJj5V
	6x4ihCy2T182H4x5J9SsrIuOSNgUh4k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 935D013A51;
	Thu, 18 Sep 2025 10:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1OjKFUHey2h2bQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 10:26:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: reject fs block size larger than 4K
Date: Thu, 18 Sep 2025 19:55:47 +0930
Message-ID: <20250918102547.98295-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[BUG]
When running the experimental block size > page support, the test case
btrfs/192 fails with the following error:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/192 436s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/192.out.bad)
    --- tests/btrfs/192.out	2022-05-11 11:25:30.746666664 +0930
    +++ /home/adam/xfstests/results//btrfs/192.out.bad	2025-09-18 18:34:10.511152624 +0930
    @@ -1,2 +1,2 @@
     QA output created by 192
    -Silence is golden
    +ERROR: illegal nodesize 4096 (smaller than 8192)
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/192.out /home/adam/xfstests/results//btrfs/192.out.bad'  to see the entire diff)

Please note that, btrfs bs > ps is still under development.
This is only an early run to expose false alerts.

[CAUSE]
The test case explicitly requires 4K nodesize to bump up tree size.

However if we use fs block size larger than 4K, the node size 4K will be
smaller than a block, causing mkfs failure, as block size is the minimal
unit for both data and metadata, thus node size smaller than block size
is illege.

[FIX]
Before calling mkfs on the log-writes dm device, do a simple mkfs and
mount of the scratch device, to verify the block size.

If the block size is larger than 4k, skip the test case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/192 | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/192 b/tests/btrfs/192
index 0a8ab2c1..2d3e3f2d 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -34,9 +34,15 @@ _require_log_writes
 _require_scratch
 _require_attrs
 
-# We require a 4K nodesize to ensure the test isn't too slow
-if [ $(_get_page_size) -ne 4096 ]; then
-	_notrun "This test doesn't support non-4K page size yet"
+_scratch_mkfs > /dev/null
+_scratch_mount
+blksz=$(_get_block_size $SCRATCH_MNT)
+_scratch_unmount
+
+# We need 4K nodesize, and if block size is larger than that mkfs will
+# fail. So reject any block size larger than 4K.
+if [ $blksz -gt 4096 ]; then
+	_notrun "This test requires block size 4096, has $blksz"
 fi
 
 runtime=30
-- 
2.51.0


