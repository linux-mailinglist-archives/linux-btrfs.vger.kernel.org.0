Return-Path: <linux-btrfs+bounces-3025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E00872728
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091A62825E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56001B972;
	Tue,  5 Mar 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZODoZRLG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZODoZRLG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B124215;
	Tue,  5 Mar 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665166; cv=none; b=aoK+xzo63Ng6/0E1Vjiyi/G+PMsI5pJD+9KQFc+hnGr2AgmhRhG/k4hiAdE152VIPUFE016rCGKwDfr65dAcCM49M4PpJWEtBLBU1MaF6XOTFWRmvOMlAfDztvZHeFOqNiQ0sH0VDk+0uw2V/Mbyr5SKUd6gLgj72Licxhvjroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665166; c=relaxed/simple;
	bh=1QNPzpCEThC3pw2m27TmJdYNtpdPz/TKCUxbFvH6nm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQePhi7bDrJlGn1M0rInoIfmqjQybEr0zsET0+2WLlb0n+mjFWKcdNtZnT/HVy85JzQlfesTwU0hQcwEX+c1qZldcQY4AQtDYv8IEhti6pxJNOpQKZl/D/vgHViehBZg7Gk6Y5cdM01KV08+KxbiAoYyL4HvEb1pGvQU7eBIkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZODoZRLG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZODoZRLG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B8853486D;
	Tue,  5 Mar 2024 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iThOjI4NuMlFaoLbKj6b9vac+2kfp+VxdCRC0NY9Hbc=;
	b=ZODoZRLGAnRoFgQmuPiZJ+w0qJG9z/0AREuYoHdlUAv+EehQtZ/T8r/QAooIVHtcw9NP7M
	GAM0yeMaRuEwO+M17uXWZXaLxP/Hkdd7bS0jmKKnkx3kGPq+CO/3F27PBOOZINW+mlPjpF
	LnAlcXQMZn01Ydlbe4cYFHyzvsNnsaM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iThOjI4NuMlFaoLbKj6b9vac+2kfp+VxdCRC0NY9Hbc=;
	b=ZODoZRLGAnRoFgQmuPiZJ+w0qJG9z/0AREuYoHdlUAv+EehQtZ/T8r/QAooIVHtcw9NP7M
	GAM0yeMaRuEwO+M17uXWZXaLxP/Hkdd7bS0jmKKnkx3kGPq+CO/3F27PBOOZINW+mlPjpF
	LnAlcXQMZn01Ydlbe4cYFHyzvsNnsaM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 45C1713466;
	Tue,  5 Mar 2024 18:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lMoFEYpr52VJBQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:22 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs/271: adjust failure condition
Date: Tue,  5 Mar 2024 19:52:17 +0100
Message-ID: <9c31107be9800792b528614e57b075d7e76010b9.1709664047.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZODoZRLG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
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
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 4B8853486D
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

btrfs/271 was failing with the subpage blocksize VM's.  This is because
there's an assumption made that the device error counters are
per-sector, but they're per-io.  With a 16kib pagesize and a 4k
sectorsize/nodesize the threshold was expecting 16 failed IO's, but
instead we were getting 5.

This other gotcha here is that with the tree log we will write the log
tree first, and then update the log root tree with the location of the
log tree root node.  With pagesize == nodesize this is fine, we will
only write the log tree root node.  However with subpage blocksize both
of these nodes could be on the same page, and thus they are both written
out during that initial write.  When we update the pointer for the log
root tree we will COW the log root tree root node and submit another IO,
resulting in 3 metadata IO's instead of 2.

Fix the failure case to be < 4 blocks, which is the minimum number of
IO's we should be seeing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/271 | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/271 b/tests/btrfs/271
index 273799f17924c0..a342af3aed44cf 100755
--- a/tests/btrfs/271
+++ b/tests/btrfs/271
@@ -25,10 +25,6 @@ _scratch_mount
 
 dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
 
-pagesize=$(_get_page_size)
-blocksize=$(_get_block_size $SCRATCH_MNT)
-sectors_per_page=$(($pagesize / $blocksize))
-
 _allow_fail_make_request
 
 echo "Step 1: writing with one failing mirror:"
@@ -36,9 +32,14 @@ _bdev_fail_make_request $SCRATCH_DEV 1
 $XFS_IO_PROG -f -c "pwrite -W -S 0xaa 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
 _bdev_fail_make_request $SCRATCH_DEV 0
 
+# btrfs counts errors per IO, assuming the data is merged that'll be 1 IO, then
+# the log tree block and then the log root tree block and then the super block.
+# We should see at least 4 failed IO's, but with subpage blocksize we could see
+# more if the log blocks end up on the same page, or if the data IO gets split
+# at all.
 errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | \
 	$AWK_PROG '/write_io_errs/ { print $2 }')
-if [ $errs -ne $((4 * $sectors_per_page)) ]; then
+if [ $errs -lt 4 ]; then
         _fail "Errors: $errs expected: 4"
 fi
 
-- 
2.42.1


