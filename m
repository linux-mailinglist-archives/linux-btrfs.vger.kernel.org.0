Return-Path: <linux-btrfs+bounces-16626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D852FB448C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 23:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEEA5674A9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40012C21F6;
	Thu,  4 Sep 2025 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CtA4+kI/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CtA4+kI/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CE2C21DE
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Sep 2025 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022287; cv=none; b=Kk2hqrMLKY/oRI+yWjmz66InJ99jIG+Wy+9sBWGRgulYS+EjbFt83MF4BI9KRQWhXvSifcmRvSKVqvZzkTELt4OX6U4OtbQrIRaTWJxPk+jxbTSwDvtStyEjHGWzzN9dYBwGSg8Pb3is/cfL9ZxCXmAETBlzNgxAKPuqhY9izsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022287; c=relaxed/simple;
	bh=lF6301TVrpRYPca3ZizEhF7w7vc1IexPZe9SVUhfirc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qm4Sq0k3UiSCNC6kwY0Lw/cFcHe3dOIJojRmuw/c+ku7LbeisN04Cw8p9WivqL66k2Nx2qPwp/9yuL7XSi+d4ATzH+RrcZLgC1z/8FU0W4Qs9Sp0pC46tDC0DfSErVt7iPGEkzU9LXK6Y3sxp9dm1t9CT/qdGFEuIeuJWzKxWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CtA4+kI/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CtA4+kI/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A24F438E3F;
	Thu,  4 Sep 2025 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757022282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w46oTHBqKv9I21RmwHGRKfyqRpLWypqd8iUOf4qZTeQ=;
	b=CtA4+kI/Nd7jo38owh9BYNAbA3IPyRzz7nQzsxun6PqKEnpIIaAAEYD4CiqsG0b4gOoQ8c
	ORM6UM7MufPtCjZsZXU8tnLWJgydfDcQO5dFEzh/i+eJXtoYHUWrnrRzOWQIAPGFhiyMgs
	PIzwSwCdGxkkz+sHbgTg6l6TKHmAJfk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="CtA4+kI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757022282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w46oTHBqKv9I21RmwHGRKfyqRpLWypqd8iUOf4qZTeQ=;
	b=CtA4+kI/Nd7jo38owh9BYNAbA3IPyRzz7nQzsxun6PqKEnpIIaAAEYD4CiqsG0b4gOoQ8c
	ORM6UM7MufPtCjZsZXU8tnLWJgydfDcQO5dFEzh/i+eJXtoYHUWrnrRzOWQIAPGFhiyMgs
	PIzwSwCdGxkkz+sHbgTg6l6TKHmAJfk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D99F13AA0;
	Thu,  4 Sep 2025 21:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NHMuF0kIumjHcAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 04 Sep 2025 21:44:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: generic/733: avoid output difference due to bash's version
Date: Fri,  5 Sep 2025 07:14:15 +0930
Message-ID: <20250904214415.10628-1-wqu@suse.com>
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
X-Rspamd-Queue-Id: A24F438E3F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

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
Run the command in a command group, which will be executed in a
subshell.

By this we can redirect the output of the subshell, including the job
control message, thus hide the different output pattern caused by
different bash versions.

Thankfully this particular test case does extra checks on the outcome
file to determine if the program is properly terminated, thus we are
safe to move the "Terminated" line from the golden output to
seqres.full.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
v2:
- Use command grouping instead of background execution
  Background execution requires extra cleanup to wait for the background
  program.
  Meanwhile command grouping will run in a subshell thus we can redirect
  everything including the job control message.

  Thanks Darrick for pointing this solution out.
---
 tests/generic/733     | 17 +++++++++++++++--
 tests/generic/733.out |  1 -
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tests/generic/733 b/tests/generic/733
index aa7ad994..21347d51 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -70,8 +70,21 @@ done
 echo "fnr=$fnr" >> $seqres.full
 
 echo "Reflink the big file"
-$here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
-	"$testdir/outcome" &>> $seqres.full
+# Workaround the default job control by command grouping so that we can redirect
+# the job control message of the subshell.
+#
+# Job control of bash v5.3.x will output the command which triggered the job
+# control (terminated, core dump etc).
+# And since it's handled by bash itself, redirection of the program won't work
+# for the job control message.
+#
+# Running the command in a command group will make the program run in a subshell
+# so that we can direct the job control message of the subshell.
+#
+# We will check the outcome file to determine if the program is properly
+# terminated, thus no need to bother the job control message.
+{ $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
+	"$testdir/outcome" ; } &>> $seqres.full
 
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


