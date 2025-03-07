Return-Path: <linux-btrfs+bounces-12078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C2A55F5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 05:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009557A7C50
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 04:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB219048F;
	Fri,  7 Mar 2025 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UwICTACb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UwICTACb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D7DDBE
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321627; cv=none; b=qLpV+UGbbSdyYMIk72Ek2H/ykRGJMurt3PnvDu2W9yiqDbs+uCezR0o3s/PtfmeaqF+87NeTnvrlXFZ17faHGpwjKyNVjtmbECjfzw0UzuKlERtZ76qrRCt3wtoO81m7qb/n7/8O8Z/4frmZ9C++wXq56pj5yE7QvI82IoNfGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321627; c=relaxed/simple;
	bh=ZSKclTTIgNrqw4PcpZ6/q5sDUpuBDUjAoYIDd4+abbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXzv1SjPi/jxf6MRxLEPQ9TOMgIRcxFSj5FdouUQIyRUkNp/BERZZ/XLUlDTU1rpHjop2WQPjbPS35b5hn72IcEftH0/QMhJ2/Z4BKlxvoGndR+yTFFsCfISOsJuM/q+c2wJU8k52q04FvK6j3syZ1XYdvvzNIZ04uJyBOo3DSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UwICTACb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UwICTACb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DD20211B5;
	Fri,  7 Mar 2025 04:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741321618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ia2DopQoyJVJs4++JqW2AsrJjUJXl3/hJItt0Vic7TI=;
	b=UwICTACboq+hLCuJCsKU8xXYeSfBNrPBZ7bMo7At/I1UmqWhNYg4Y8rXiuS4vinTpLh4pu
	5ZRYRaRD4+u67NYX8mgQOBhIMVJKjYXRvwtISWXkqMseoXa3TlpOT6q/j+QpOZH1MAATw2
	mgk9vYQLwGjGVZn6+P0S55ua46UNkXM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UwICTACb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741321618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ia2DopQoyJVJs4++JqW2AsrJjUJXl3/hJItt0Vic7TI=;
	b=UwICTACboq+hLCuJCsKU8xXYeSfBNrPBZ7bMo7At/I1UmqWhNYg4Y8rXiuS4vinTpLh4pu
	5ZRYRaRD4+u67NYX8mgQOBhIMVJKjYXRvwtISWXkqMseoXa3TlpOT6q/j+QpOZH1MAATw2
	mgk9vYQLwGjGVZn6+P0S55ua46UNkXM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5478A13939;
	Fri,  7 Mar 2025 04:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNFpBZF1ymeZcAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 07 Mar 2025 04:26:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org
Subject: [PATCH 1/2] btrfs: run btrfs_error_commit_super() early
Date: Fri,  7 Mar 2025 14:56:36 +1030
Message-ID: <1065439fbc1fc7aa0db509344c91e37467a717fe.1741321288.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741321288.git.wqu@suse.com>
References: <cover.1741321288.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5DD20211B5
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
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Even after all the error fixes related the
"ASSERT(list_empty(&fs_info->delayed_iputs));" in close_ctree(), I can
still hit it reliably with my experimental 2K block size.

[CAUSE]
In my case, all the error is triggered after the fs is already in error
status.

I find the following call trace to be the cause of race:

           Main thread                 |     endio_write_workers
---------------------------------------+------------------------
close_ctree()                          |
|- btrfs_error_commit_super()          |
|  |- btrfs_cleanup_tranasction()      |
|  |  |- btrfs_wait_ordered_roots()    |
|  |- btrfs_run_delayed_iputs()        |
|                                      | btrfs_finish_ordered_io()
|                                      | |- btrfs_put_ordered_extent()
|                                      |    |- btrfs_add_delayed_iput()
|- ASSERT(list_empty(delayed_iputs))   |
   !!! Triggered !!!

The root cause is that, btrfs_wait_ordered_roots() only wait for
ordered extents to finish their IOs, not to wait for them to finish and
removed.

[FIX]
Since btrfs_error_commit_super() will flush and wait for all ordered
extents, it should be executed early, before we start flushing the
workqueues.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b0f125d8efa0..320136a59db2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4320,6 +4320,14 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* clear out the rbtree of defraggable inodes */
 	btrfs_cleanup_defrag_inodes(fs_info);
 
+	/*
+	 * Handle the error fs first, as it will flush and wait for
+	 * all ordred extents.
+	 * This will generate delayed iputs, thus we want to handle it first.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info)))
+		btrfs_error_commit_super(fs_info);
+
 	/*
 	 * Wait for any fixup workers to complete.
 	 * If we don't wait for them here and they are still running by the time
@@ -4410,9 +4418,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
 
-	if (BTRFS_FS_ERROR(fs_info))
-		btrfs_error_commit_super(fs_info);
-
 	kthread_stop(fs_info->transaction_kthread);
 	kthread_stop(fs_info->cleaner_kthread);
 
-- 
2.48.1


