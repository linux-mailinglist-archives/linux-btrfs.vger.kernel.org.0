Return-Path: <linux-btrfs+bounces-16620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDAB43553
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E42318905C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51C2BF3CC;
	Thu,  4 Sep 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rrrDuuf9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IMOMCm2w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D922BEC27
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Sep 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973699; cv=none; b=vEkr/iIw5/sGS0TMSkkUQ08bLUMfjh6j+dynxe/Bor+v+W8qjBnoNjPDPmAVjSgf/gGYe4/JbeZGDeZWLGSu+ZM9o/ASrQAAUqyhiRBnXtyzFIPn+BuXegCBqGZj4NagOhjMD/o3kEMeG/J/yz3bFt8Uzsl9XaOv4ahBqozYjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973699; c=relaxed/simple;
	bh=tephdfM28IiNbU3KFWqaW7voER/RpNZVRY3snJmdzyk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YwJF+TBO1HYgl8GbIFDbqBssohinjZO3XxD/NsCzreAHkaEwEQukHvoAufsJe7SrMlQB8JyV4Q4Fz7s2xUehKDWGF4CUC9YHLuX1EGK5UAUtpvAR9TtkeEIaJlhz9vjgcB4pbfzMqeS1LDeIgzTkOOji+1NIRafN/xwggxr4Jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rrrDuuf9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IMOMCm2w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE0A033C91;
	Thu,  4 Sep 2025 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756973696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NyaY6tqfHh4HoEfnNdUIofOQ+iE3G2OM/91t6XBhNU0=;
	b=rrrDuuf9w8NUmcNOpbMqkv9pnIOJFl7VV151IQsV6MywSMNwiRAe94NLHkRKz6hiClQpA2
	8mlL+O5w7x3ktmQkAwvUkGCd475Nkzy8lyJPentrJWxqlS/9j1qVjWYxgtRrLYf9AyL6ON
	2J/EK3My31uIKV8KHUhDmuPDLNKb56I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756973695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NyaY6tqfHh4HoEfnNdUIofOQ+iE3G2OM/91t6XBhNU0=;
	b=IMOMCm2wnxCuEi06bAkHt0Dol//8SRZgOfkBiDRlSoS0jtD9mfXmoA7fKnxNQlygzs9Zh8
	QUfjd9l1CdLnPbTylppp0fCD6lFU4nxIvLQPFmnAzzzlKhmhniHWiKd+K861LydMI81Zz+
	uYkasAMHEfPHTuvXH2Kg0V0cq3yRFSs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EED4413675;
	Thu,  4 Sep 2025 08:14:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q1q/K35KuWgbeQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 04 Sep 2025 08:14:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/733: avoid output difference due to bash's version
Date: Thu,  4 Sep 2025 17:44:29 +0930
Message-ID: <20250904081429.114716-1-wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[FALSE ALERT]
When running generic/733 with bash 5.3.3 (any thing newer than 5.3.0
will reproduce the bug), the test case will fail like the following:

generic/733 19s ... - output mismatch (see /home/adam/xfstests/results//generic/733.out.bad)
    --- tests/generic/733.out	2025-09-04 17:30:08.568000000 +0930
    +++ /home/adam/xfstests/results//generic/733.out.bad	2025-09-04 17:30:32.898475103 +0930
    @@ -2,5 +2,5 @@
     Format and mount
     Create a many-block file
     Reflink the big file
    -Terminated
    +Terminated                 $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" "$testdir/outcome" &>> $seqres.full
     test completed successfully
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/733.out /home/adam/xfstests/results//generic/733.out.bad'  to see the entire diff)

[CAUSE]
The failure is fs independent, but bash version dependent.

In bash v5.3.x, the job control will output the command which triggered
the job control (from termination to core dump etc).

The "Terminated" message is not from the program, but from bash's job
control, thus redirection won't hide that message.

[FIX]
Instead of relying on the job control behavior from bash, run the
t_reflink_read_race tool in background, and wait for it to finish.

Background bash will be non-interactive, thus no job control and no
"Terminated" message.

Thankfully this particular test case does extra checks on the outcome
file to determine if the program is properly terminated, thus we are
safe to delete the "Terminated" line from the golden output.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/733     | 15 ++++++++++++++-
 tests/generic/733.out |  1 -
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/generic/733 b/tests/generic/733
index aa7ad994..b8321abc 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -70,8 +70,21 @@ done
 echo "fnr=$fnr" >> $seqres.full
 
 echo "Reflink the big file"
+# Workaround the default job control by running it at background.
+#
+# Job control of bash v5.3.x will output the command which triggered the job
+# control (terminated, core dump etc).
+# And since it's handled by bash itself, redirection won't work for the job
+# control message.
+#
+# Running the command in background will disable the job control thus
+# there will be no extra message like "Terminated".
+#
+# We will check the outcome file to determine if the program is properly
+# terminated, thus no need to bother the job control message.
 $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
-	"$testdir/outcome" &>> $seqres.full
+	"$testdir/outcome" &>> $seqres.full &
+wait
 
 if [ ! -e "$testdir/outcome" ]; then
 	echo "Could not set up program"
diff --git a/tests/generic/733.out b/tests/generic/733.out
index d4f5a7c7..2383cc8d 100644
--- a/tests/generic/733.out
+++ b/tests/generic/733.out
@@ -2,5 +2,4 @@ QA output created by 733
 Format and mount
 Create a many-block file
 Reflink the big file
-Terminated
 test completed successfully
-- 
2.51.0


