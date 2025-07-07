Return-Path: <linux-btrfs+bounces-15271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02394AFA898
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 02:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA5D189300D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 00:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8013635C;
	Mon,  7 Jul 2025 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UoBv89H/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UoBv89H/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A62E371C
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751847941; cv=none; b=u7NU0VbLRBqwDs+9vyFMN+FsNJ7OrsktAa+A+qOlqtTDD+vnhn24zClZPndLcAGW9LNBpCxINaULm6xomL+cYpVobR1+W+Vh9mV4YQWGkTw517drLfnni1q7varaxAxrhj8fcwq1dPPA3yfW0dN7lHS+b5ODF8vZ4ZU49SZz6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751847941; c=relaxed/simple;
	bh=3xCjn4P6fcIImWqyQowSb6rRmg1J+zJhOfcBqSBCfDU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=leqofklUkMsoAVgPuhUfDuWmsw+3OnYw0j5xG2jVgkdXI+xD/zJDc2Jwrpbox4hdRvhsCL/fhH+4weDpcgLaaRgie00qnF9X4rV6yis06f2VEbn240MGgc51/4DEQVx+OM02W4B99BmwVNBUGBQqhs+UyEHhTU0AkFTeq7nLr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UoBv89H/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UoBv89H/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68C452117D
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 00:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751847931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FWztn6umGfZ7OOKD8SJWdKHIzqDNbFkU0FPQjN1fojk=;
	b=UoBv89H/OjSzSXjK2bDLDq8moFHogu0p1pREYhe8ngZ+jdSA5hmuqxe8y1tWLgRhDU2R1I
	gtl2Jv3MRgW7HE6MRSpuUsyHajW2Uo/F/3Vosbw6c5p/iNnba0afVd5iqgI3tEysq9ugMJ
	Z4+qV+SSj8qpTve0mRC+nijayxUSmzs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751847931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FWztn6umGfZ7OOKD8SJWdKHIzqDNbFkU0FPQjN1fojk=;
	b=UoBv89H/OjSzSXjK2bDLDq8moFHogu0p1pREYhe8ngZ+jdSA5hmuqxe8y1tWLgRhDU2R1I
	gtl2Jv3MRgW7HE6MRSpuUsyHajW2Uo/F/3Vosbw6c5p/iNnba0afVd5iqgI3tEysq9ugMJ
	Z4+qV+SSj8qpTve0mRC+nijayxUSmzs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A498136A8
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 00:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BlwGFvoTa2iFNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Jul 2025 00:25:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: exit scrub and balance early if the fs is being frozen
Date: Mon,  7 Jul 2025 09:55:12 +0930
Message-ID: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[PROBLEM]
There are some reports that btrfs is unable to be frozen if there is a
running scrub.

[CAUSE]
If there is a running scrub, freeze_super() will wait for the running
scrub as read-write scrub is holding sb_start_write():

           Scrub process             |         Freeze process
-------------------------------------+--------------------------------
btrfs_ioctl_scrub()                  |
|- mnt_want_write_file()             |
|  |- sb_start_write()               |
|     This will block freezing       |
|                                    | freeze_super()
|- mnt_drop_write_file()             | |
                                     | |- sb_wait_write()
                                     | |  This will wait for any
                                     | |  sb_start_write() to finish

This means freeze_super() will wait for any running scrub to finish.
The same applies to all ioctls that requires mnt_want_write_file().

The most common long running ones are scrub and balance.

Since scrub and balance can be very long running operations, this will
cause freezing to timeout.
And since freezing the fs is required before suspension/hibernation,
this means those two operations will fail too.

[FIX]
Check if the fs is being frozen, and if so cancel the current running
scrub or balance.

So far I didn't find a better way to solve the problem, the only way to
drop the mnt_want_write_file() is to finish or cancel the scrub/balance.

There is no way to drop the mnt_want_write_file() meanwhile just pausing
scrub/balance, at least not for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
I'm not sure if cancelling is the best solution, but it is the easiest
one to implementation.

Pause the scrub/balance is not really feasible yet, as it will still hold the
mnt_want_write_file(), thus blocking freezing.

Meanwhile for end users, pausing scrub/balance when freezing, and resume
when thawing should be the best outcome.
---
 fs/btrfs/relocation.c | 3 ++-
 fs/btrfs/scrub.c      | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 175fc3acc38b..f173e36a69f8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2797,7 +2797,8 @@ noinline int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
 		atomic_read(&fs_info->reloc_cancel_req) ||
-		fatal_signal_pending(current);
+		fatal_signal_pending(current) ||
+		fs_info->sb->s_writers.frozen > SB_UNFROZEN;
 }
 ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6776e6ab8d10..bf8e4c411b60 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2244,6 +2244,12 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		u64 found_logical = U64_MAX;
 		u64 cur_physical = physical + cur_logical - logical_start;
 
+		/* Fs being frozen, need to exit early or freezing will timeout. */
+		if (fs_info->sb->s_writers.frozen > SB_UNFROZEN) {
+			ret = -ECANCELED;
+			break;
+		}
+
 		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
 		    atomic_read(&sctx->cancel_req)) {
-- 
2.50.0


