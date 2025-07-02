Return-Path: <linux-btrfs+bounces-15189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671BAF0A0E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 06:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2233E4477E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 04:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095382AE8E;
	Wed,  2 Jul 2025 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I9S/ejur";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I9S/ejur"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD113774D
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751432015; cv=none; b=ItNo9o+J5xFO288H7nkhWjUkQpftGyO2+6c97IPVUtcJfKdAGivL7O5d92qEGEhhTG+iUvYSOCBH0kUFrfktWuP5JP36SymaKYy+x+WLvCS8p3gC8qPsg8LxmBBfFsbIw9hcC8F+iBiSBfX8BPvlWYMyvXiAIuEb50MEKlIvWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751432015; c=relaxed/simple;
	bh=3+y77uxgn579YKP0QcYN/+4g7DQEsu7n3w4tTgL7/vU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HvbzZApX2JPIuTyAwVPqhj31HXGj4ULD5Jrk//f94RggBE9SVvVU0CpyCYjwmiTPpzPQY0VKJKgs7CRG95wJFu2kwwWN5OhkqkUWI/YqpbZEkIAt29hmUZP2c/MVGVmh9c+jSzb8vj0FH4VhCwyXC54VLh4qyTIZkmKk0AowflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I9S/ejur; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I9S/ejur; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0391F445;
	Wed,  2 Jul 2025 04:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751432011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mtIgI2+wuErY5IDvsD8emyXLe9cVO5rjS08y/hMAxls=;
	b=I9S/ejur49dePOYOtvCzZVAOvqr6j5mGEAomxGzbvYoKVaZO719wL3AdUrrlE5A6ccCLfS
	qUhFpN/5OCyZrK5UrmOuE60XsHWJKfe4WM/2y3WAyehQLLWggfX4Z7Uk3IwsJSVWvM5sCP
	6YFbw5tHxgHy+vFpWedKTYDKPSKRXhs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751432011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mtIgI2+wuErY5IDvsD8emyXLe9cVO5rjS08y/hMAxls=;
	b=I9S/ejur49dePOYOtvCzZVAOvqr6j5mGEAomxGzbvYoKVaZO719wL3AdUrrlE5A6ccCLfS
	qUhFpN/5OCyZrK5UrmOuE60XsHWJKfe4WM/2y3WAyehQLLWggfX4Z7Uk3IwsJSVWvM5sCP
	6YFbw5tHxgHy+vFpWedKTYDKPSKRXhs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CDC11369C;
	Wed,  2 Jul 2025 04:53:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OdE+MEm7ZGh/EgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 02 Jul 2025 04:53:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] generic/050: add a workaround for btrfs
Date: Wed,  2 Jul 2025 14:23:12 +0930
Message-ID: <20250702045312.59995-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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

[BUG]
With the incoming btrfs shutdown ioctl/remove_bdev callback support,
btrfs can be tested with the shutdown group.

But test case generic/050 still fails on btrfs with shutdown support:

generic/050 1s ... - output mismatch (see /home/adam/xfstests/results//generic/050.out.bad)
    --- tests/generic/050.out	2022-05-11 11:25:30.763333331 +0930
    +++ /home/adam/xfstests/results//generic/050.out.bad	2025-06-30 10:22:21.752068622 +0930
    @@ -13,9 +13,7 @@
     setting device read-only
     mounting filesystem that needs recovery on a read-only device:
     mount: device write-protected, mounting read-only
    -mount: cannot mount device read-only
     unmounting read-only filesystem
    -umount: SCRATCH_DEV: not mounted
     mounting filesystem with -o norecovery on a read-only device:
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/050.out /home/adam/xfstests/results//generic/050.out.bad'  to see the entire diff)
Ran: generic/050

[CAUSE]
The test case generic/050 has several different golden output depending
on the fs features.

For fses which requires data write (e.g. replay the journal) during
mount, mounting a read-only block device should fail.
And that is the default golden output.

However for btrfs, although it has something similar to a journal, aka
log tree, it's not the traditional journal which is used to protect
metadata update.

The log tree of btrfs is mostly for speeding up fsync() without syncing
the full fs.

This means several things are different with btrfs:

- Regular metadata update won't cause dirty log tree
  The workload here is just touching several files, which will not cause
  the creation of btrfs log tree.

  And the metadata consistency is protected by metadata COW, not
  journal.

- FLUSHLOG shutdown flag will cause btrfs to commit the current
  transaction
  And above new files are recorded in the current transaction, meaning
  those new files will be fully written by a FLUSHLOG shutdown.

This means, unlike fses using traditional journals, touching files then
shutdown with FLUSHLOG will not cause any dirty log tree.

This makes btrfs acts like it doesn't support metadata journaling, at
least for this particular test case.

[FIX]
Since the workload here will not cause btrfs to generate a log tree,
meaning after the shutdown, the fs can still be mounted RO even the
block device is read-only.

So here we have to make an exception for btrfs, that it has to go
through the "nojournal" feature.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/050 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/generic/050 b/tests/generic/050
index affb072d..3bc37175 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -34,6 +34,18 @@ elif [ "$FSTYP" = "xfs" ] && echo "$MOUNT_OPTIONS" | grep -q quota ; then
 	# Mounting with quota on XFS requires a writable fs, which means
 	# we expect to fail the ro blockdev test with with EPERM.
 	features="xfsquota"
+elif [ "$FSTYP" = "btrfs" ]; then
+	# Btrfs' log tree is not the traditional journal to protect metadata
+	# (that is done by metadata COW), the log tree is to speed up fsync()
+	# without syncing the full fs.
+	#
+	# In this particular test case, the workload (touching files without
+	# fsync, and use FLUSHLOG option to shutdown) will not utilize log tree
+	# at all.
+	#
+	# So for this test case, btrfs will not get any dirty log tree thus
+	# it can be treated as "nojournal".
+	features="nojournal"
 fi
 _link_out_file "$features"
 
-- 
2.50.0


