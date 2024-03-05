Return-Path: <linux-btrfs+bounces-3026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E2872729
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A3B1F2A292
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE24CB28;
	Tue,  5 Mar 2024 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tfOjBT+K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tfOjBT+K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C3438FA7;
	Tue,  5 Mar 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665168; cv=none; b=XbKqdX/yMF8HCgTeio/xrECjrrD2Q6yfFXyYAu6+oqmKa7KrN3XAIJ067B2Sicg7KxYUJgZhsgkJccqluNnAkhbWPDIQBtT5kCfCvEvP8upJ5a1Or7bSz1wHd7RDjdgbuOACekm7GWh/501hq8lJIV05s5EzcKxH+jm6Zj/mDBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665168; c=relaxed/simple;
	bh=uXy49FmSUgS9BMA4Ys2k/M2JSB+LVAwPuyKKWGmddtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndWfa6OrWQDONUd1Hcfiq5aHy2RuAiVsGmMXLel9Fj8AdoJWmNQ91PVa4qw8uvBL1aCJmvYPINixT6gH9/DyMzHiFRqqfnhKI8IzFoxIbh3qlWuslxAzHI3GFDBJuKI/L3BDTfQOrRIKbDKZfKgcMOvICDsnvymozId4uaPfWMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tfOjBT+K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tfOjBT+K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A27CA34B4C;
	Tue,  5 Mar 2024 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX7rQq9PbMxqQobfWnBcl7rA1Sz6+kv4X/IrxAs9zIg=;
	b=tfOjBT+KLlZwwLVYLQDy1ToJsFUpKIEaygNSKC/rcQV/BHwt1zIJb9juQR6BBf55tBv8yr
	rgnkLvFAmcY7NbatzP/RBKUQg8XHGQtNtAf5f8eg3t5lhKlAYTrEKmmFH1kOTeXZtpwCKe
	5hrGYVabylx6aPflYzFzP+fLPFwQ2KE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX7rQq9PbMxqQobfWnBcl7rA1Sz6+kv4X/IrxAs9zIg=;
	b=tfOjBT+KLlZwwLVYLQDy1ToJsFUpKIEaygNSKC/rcQV/BHwt1zIJb9juQR6BBf55tBv8yr
	rgnkLvFAmcY7NbatzP/RBKUQg8XHGQtNtAf5f8eg3t5lhKlAYTrEKmmFH1kOTeXZtpwCKe
	5hrGYVabylx6aPflYzFzP+fLPFwQ2KE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C76713466;
	Tue,  5 Mar 2024 18:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4/MwJoxr52VLBQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:24 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs/287,btrfs/293: filter all btrfs subvolume delete calls
Date: Tue,  5 Mar 2024 19:52:19 +0100
Message-ID: <fc4d5270c569ef7d74066d7249a3f6669fb021fe.1709664047.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1709664047.git.dsterba@suse.com>
References: <cover.1709664047.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

Some of our btrfs subvolume delete calls get put into the golden output,
and many of them simply _filter_scratch.  This works fine, but we
recently changed btrfs subvolume delete output, and it would have been
nice to simply filter this in one place.  We have a
_filter_btrfs_subvol_delete helper, but it's only used in one place.
Fix all of these uses to call _filter_btrfs_subvol_delete, this will
allow for follow up fixes against _filter_btrfs_subvol_delete itself to
deal with changed output.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/287     | 4 ++--
 tests/btrfs/287.out | 2 +-
 tests/btrfs/293     | 6 +++---
 tests/btrfs/293.out | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/287 b/tests/btrfs/287
index 04871d46036aa2..64e6ef35250c8e 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -9,7 +9,7 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot clone punch logical_resolve
 
-. ./common/filter
+. ./common/filter.btrfs
 . ./common/reflink
 
 _supported_fs btrfs
@@ -148,7 +148,7 @@ echo "resolve second extent with ignore offset option:"
 query_logical_ino -o $second_extent_bytenr | filter_snapshot_ids
 
 # Now delete the first snapshot and repeat the last 2 queries.
-$BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_btrfs_subvol_delete
 
 # Query the second extent with an offset of 0, should return file offsets 12M
 # and 20M for the default subvolume (root 5) and file offsets 4M, 12M and 20M
diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
index 0d69473364fa31..30eac8fa444c8f 100644
--- a/tests/btrfs/287.out
+++ b/tests/btrfs/287.out
@@ -79,7 +79,7 @@ inode 257 offset 4194304 snap1
 inode 257 offset 20971520 root 5
 inode 257 offset 12582912 root 5
 inode 257 offset 5242880 root 5
-Delete subvolume (commit): 'SCRATCH_MNT/snap1'
+Delete subvolume 'SCRATCH_MNT/snap1'
 resolve second extent:
 inode 257 offset 20971520 snap2
 inode 257 offset 12582912 snap2
diff --git a/tests/btrfs/293 b/tests/btrfs/293
index cded956468ee9a..06f96dc414b05b 100755
--- a/tests/btrfs/293
+++ b/tests/btrfs/293
@@ -18,7 +18,7 @@ _cleanup()
 	test -n "$swap_file" && swapoff $swap_file &> /dev/null
 }
 
-. ./common/filter
+. ./common/filter.btrfs
 
 _supported_fs btrfs
 _fixed_by_kernel_commit deccae40e4b3 \
@@ -40,7 +40,7 @@ echo "Activating swap file... (should fail due to snapshots)"
 _swapon_file $swap_file 2>&1 | _filter_scratch
 
 echo "Deleting first snapshot..."
-$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap1 | _filter_btrfs_subvol_delete
 
 # We deleted the snapshot and committed the transaction used to delete it (-c),
 # but all its extents are actually only deleted in the background, by the cleaner
@@ -55,7 +55,7 @@ echo "Activating swap file... (should fail due to snapshot)"
 _swapon_file $swap_file 2>&1 | _filter_scratch
 
 echo "Deleting second snapshot..."
-$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap2 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume delete -c $SCRATCH_MNT/snap2 | _filter_btrfs_subvol_delete
 
 echo "Remounting and waiting for cleaner thread to remove the second snapshot..."
 _scratch_remount commit=1
diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
index 2ac1663281947a..fd04ac9139b849 100644
--- a/tests/btrfs/293.out
+++ b/tests/btrfs/293.out
@@ -6,12 +6,12 @@ Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 Activating swap file... (should fail due to snapshots)
 swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
 Deleting first snapshot...
-Delete subvolume (commit): 'SCRATCH_MNT/snap1'
+Delete subvolume 'SCRATCH_MNT/snap1'
 Remounting and waiting for cleaner thread to remove the first snapshot...
 Activating swap file... (should fail due to snapshot)
 swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
 Deleting second snapshot...
-Delete subvolume (commit): 'SCRATCH_MNT/snap2'
+Delete subvolume 'SCRATCH_MNT/snap2'
 Remounting and waiting for cleaner thread to remove the second snapshot...
 Activating swap file...
 Disabling swap file...
-- 
2.42.1


