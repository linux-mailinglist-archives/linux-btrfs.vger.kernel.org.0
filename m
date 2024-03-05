Return-Path: <linux-btrfs+bounces-3024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF7872727
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EAE281BD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67B824B29;
	Tue,  5 Mar 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bYYY3Xom";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HKQ6QFAE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C95288DB;
	Tue,  5 Mar 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665164; cv=none; b=lsyKLLN/4qiO2kw9bPngj+98wJhLMqQSKlopoVtS8HmgvkbVFAqluA0dvzmx/rg+pbG4W8GuvV/9/9cvvZ+5TQpkpqw0icwxw7e4coTB+qRMQe4DJcQhi89KGgCHA4UIaC7v2R6+6UAnZustqDvg/g/XTB+hgOf4nkmr++luRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665164; c=relaxed/simple;
	bh=aKC90b+tRFJe40ZXBUd7pbHxaxHmvbobfQtECX49514=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ufpl8PFoV8O82T7oTvUuOBdXrstiGPxJKDAwkzdi/O6Gu68/uRL/NVjyy/h6Xd59RsFWuGjDWzSi2rO+v8bYCKHaC+9b3v37ro+X2+0L3cT3tlWrEu+mXx95z+Vxorgi7m8FGuPPI6PlftKGNuVG3KGrKtmKdpmZeCsx0EqWD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bYYY3Xom; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HKQ6QFAE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E79BF20DE2;
	Tue,  5 Mar 2024 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wkOYl4lSaUAz6/c69SQ5WVIIwo8oth+q0Ufe8kbPr4=;
	b=bYYY3Xomie+C8W6OkA/XbOLU2FKLynV6cSlxjkbB5Rxe9w30vIECuNNnzWgfOvcR/NfGzR
	OiWJ33GU3o21aEnLSvA8ImXVn+Xh4SdYumg63AHmLxA4ia03d3guHKxFppKnvyowgWrjYm
	WJMAzheQzylqZ1Thw4sflRC5rsVUw/o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wkOYl4lSaUAz6/c69SQ5WVIIwo8oth+q0Ufe8kbPr4=;
	b=HKQ6QFAEHyLBXu5yJJls6njqSzZH9xccy88pGdH+qoeBzPHkdDdl58ePFCcXUUR8YYMjGL
	dhy6FXs+1Am7qYBw717qCKvIcNoae3SytaL6cDt1hnZtLfIbuDwzoDSLnwZDi4oXcryBkG
	vp3E3YBYgfFqSOZffOy73lyMVbYZ23o=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E22B113466;
	Tue,  5 Mar 2024 18:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jbg1N4dr52VGBQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:19 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs/213: make the test more reliable
Date: Tue,  5 Mar 2024 19:52:14 +0100
Message-ID: <2349210f22271d849bd835e49cec946aca7c86ed.1709664047.git.dsterba@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HKQ6QFAE
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
X-Rspamd-Queue-Id: E79BF20DE2
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

This test will write for 8 seconds and then try to balance, but for some
setups 8 seconds may be enough to fill the disk.  Instead figure out
what half the size of the disk is and write at most that many bytes, or
for 8 seconds, whichever comes first.  Then use the amount of time it
took to do the write to determine how long we should allow the balance
to continue before we attempt to cancel it.

Additionally the macro is '_notrun' not '_not_run'.  With this change
this test now does the correct thing on my ARM CI VM.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check           |  6 ------
 common/rc       |  5 +++++
 tests/btrfs/213 | 20 ++++++++++----------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/check b/check
index 71b9fbd075223f..c6dba89b5b506e 100755
--- a/check
+++ b/check
@@ -204,12 +204,6 @@ trim_test_list()
 	rm -f $tmp.grep
 }
 
-
-_wallclock()
-{
-    date "+%s"
-}
-
 _timestamp()
 {
     local now=`date "+%T"`
diff --git a/common/rc b/common/rc
index 6cbceb7ae7c6bb..9b6dfcaaeddadb 100644
--- a/common/rc
+++ b/common/rc
@@ -6,6 +6,11 @@
 
 BC="$(type -P bc)" || BC=
 
+_wallclock()
+{
+    date "+%s"
+}
+
 _require_math()
 {
 	if [ -z "$BC" ]; then
diff --git a/tests/btrfs/213 b/tests/btrfs/213
index 6def4f6ef79acf..816041a0cc2ea0 100755
--- a/tests/btrfs/213
+++ b/tests/btrfs/213
@@ -31,23 +31,23 @@ _fixed_by_kernel_commit 1dae7e0e58b4 \
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 
-runtime=8
+max_space=$(_get_total_space $SCRATCH_MNT)
+max_space=$(( max_space / 2 ))
 
-# Create enough IO so that we need around $runtime seconds to relocate it.
-#
-# Here we don't want any wrapper, as we want full control of the process.
-$XFS_IO_PROG -f -c "pwrite -D -b 1M 0 1024T" "$SCRATCH_MNT/file" &> /dev/null &
-write_pid=$!
-sleep $runtime
-kill $write_pid
-wait $write_pid
+# Create enough IO so that we need around 8 seconds to relocate it.
+start_ts=$(_wallclock)
+$TIMEOUT_PROG 8s $XFS_IO_PROG -f -c "pwrite -D -b 1M 0 $max_space" \
+	"$SCRATCH_MNT/file" > /dev/null 2>&1
+stop_ts=$(_wallclock)
+
+runtime=$(( stop_ts - start_ts ))
 
 # Unmount and mount again the fs to clear any cached data and metadata, so that
 # it's less likely balance has already finished when we try to cancel it below.
 _scratch_cycle_mount
 
 # Now balance should take at least $runtime seconds, we can cancel it at
-# $runtime/2 to ensure a success cancel.
+# $runtime/4 to ensure a success cancel.
 _run_btrfs_balance_start -d --bg "$SCRATCH_MNT"
 sleep $(($runtime / 4))
 # It's possible that balance has already completed. It's unlikely but often
-- 
2.42.1


