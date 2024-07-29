Return-Path: <linux-btrfs+bounces-6859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672899401CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 01:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1301C220F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3518F2C8;
	Mon, 29 Jul 2024 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R2PADGno";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R2PADGno"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A157CB5
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296479; cv=none; b=gGDcHn+hkvLAhScjaGKuH/W09dbdfCknvLlwXa3e68iU85/l2bLUL5VlmWY2EoTA0QD1cC1KZWU27ggIxsK3jvp2sW08WhRJWU/3xB3skyUZse4ouzwoZ8BK5Hf470W2YQ7zAMKJKo+e7I0U54guVdfaf0Q8dEECMRypeLDftPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296479; c=relaxed/simple;
	bh=hJJUlgv4cHtheM3jJl5Npefzmoy8xY51Ghru09TXnqQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=taiA4Fg++lGa3NEpHTXEzVaNMt5jPgPi5jJuhl788JvF6ZaiDTrpIhd9cEfN7zbF3/TH9IKr4yLAfK3+BGyjPhz5Swat3WT9TUPb7drPY1F48Ur6eOfxXvg7j8tjs8lqVaXTR5Ek64YrAPQLlQpfyUpFfAlRcmnR+VmnwJpvSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R2PADGno; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R2PADGno; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3CDD21B18
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 23:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722296475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T5L3fgUbJ6BBdR6k68VmWpB1ckvCibN5Pn2W92uHELc=;
	b=R2PADGnoSXCs45nd6RQFMHo65q3am8QzyLrYYBGisCbmbmD/VD4d5snIQfE4Iyw0mLReFJ
	sOXrDzpOygjcf1q4d/FsbI6CgkOdfBMejd0z0yDu8AQ/OJamt6q+T5t35xRCPPyK7q8EUu
	RdzqQH/DTEGLdPkWFeKKhhq5Y2Ro0eA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=R2PADGno
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722296475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T5L3fgUbJ6BBdR6k68VmWpB1ckvCibN5Pn2W92uHELc=;
	b=R2PADGnoSXCs45nd6RQFMHo65q3am8QzyLrYYBGisCbmbmD/VD4d5snIQfE4Iyw0mLReFJ
	sOXrDzpOygjcf1q4d/FsbI6CgkOdfBMejd0z0yDu8AQ/OJamt6q+T5t35xRCPPyK7q8EUu
	RdzqQH/DTEGLdPkWFeKKhhq5Y2Ro0eA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4AB61368A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 23:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BEA+H5ooqGZ3eAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 23:41:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: cmd/qgroup: fix memory leak for clear-stale subcommand
Date: Tue, 30 Jul 2024 09:10:56 +0930
Message-ID: <9132fa0a5ec23ec32ce5d27136b1d208eeda41c3.1722296448.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.19 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: A3CDD21B18
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.19

[BUG]
ASAN test fails at misc/055 with the following leak:

Qgroupid    Referenced    Exclusive   Path
--------    ----------    ---------   ----
0/5           16.00KiB     16.00KiB   <toplevel>
0/256         16.00KiB     16.00KiB   <stale>
====== RUN CHECK /home/runner/work/btrfs-progs/btrfs-progs/btrfs qgroup clear-stale /home/runner/work/btrfs-progs/btrfs-progs/tests/mnt

=================================================================
==102571==ERROR: LeakSanitizer: detected memory leaks

Indirect leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x7fd1c98fbb37 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55aa2f8953f8 in btrfs_util_subvolume_path_fd libbtrfsutil/subvolume.c:178
    #2 0x55aa2f8fa2a6 in get_or_add_qgroup cmds/qgroup.c:837
    #3 0x55aa2f8fa7e9 in update_qgroup_info cmds/qgroup.c:883
    #4 0x55aa2f8fd912 in __qgroups_search cmds/qgroup.c:1385
    #5 0x55aa2f8fe196 in qgroups_search_all cmds/qgroup.c:1453
    #6 0x55aa2f902a7c in cmd_qgroup_clear_stale cmds/qgroup.c:2281
    #7 0x55aa2f73425b in cmd_execute cmds/commands.h:126
    #8 0x55aa2f734bcc in handle_command_group /home/runner/work/btrfs-progs/btrfs-progs/btrfs.c:177
    #9 0x55aa2f73425b in cmd_execute cmds/commands.h:126
    #10 0x55aa2f735a96 in main /home/runner/work/btrfs-progs/btrfs-progs/btrfs.c:518
    #11 0x7fd1c942a1c9  (/lib/x86_64-linux-gnu/libc.so.6+0x2a1c9) (BuildId: 08134323d00289185684a4cd177d202f39c2a5f3)
    #12 0x7fd1c942a28a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2a28a) (BuildId: 08134323d00289185684a4cd177d202f39c2a5f3)
    #13 0x55aa2f734144 in _start (/home/runner/work/btrfs-progs/btrfs-progs/btrfs+0x84144) (BuildId: 56f3dd838e1ae189c142c5d27fac025cd46deddb)

Indirect leak of 432 byte(s) in 2 object(s) allocated from:
    #0 0x7fd1c98fb4d0 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55aa2f8fa1a1 in get_or_add_qgroup cmds/qgroup.c:822
    #2 0x55aa2f8fa7e9 in update_qgroup_info cmds/qgroup.c:883
    #3 0x55aa2f8fd912 in __qgroups_search cmds/qgroup.c:1385
    #4 0x55aa2f8fe196 in qgroups_search_all cmds/qgroup.c:1453
    #5 0x55aa2f902a7c in cmd_qgroup_clear_stale cmds/qgroup.c:2281
    #6 0x55aa2f73425b in cmd_execute cmds/commands.h:126
    #7 0x55aa2f734bcc in handle_command_group /home/runner/work/btrfs-progs/btrfs-progs/btrfs.c:177
    #8 0x55aa2f73425b in cmd_execute cmds/commands.h:126
    #9 0x55aa2f735a96 in main /home/runner/work/btrfs-progs/btrfs-progs/btrfs.c:518
    #10 0x7fd1c942a1c9  (/lib/x86_64-linux-gnu/libc.so.6+0x2a1c9) (BuildId: 08134323d00289185684a4cd177d202f39c2a5f3)
    #11 0x7fd1c942a28a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2a28a) (BuildId: 08134323d00289185684a4cd177d202f39c2a5f3)
    #12 0x55aa2f734144 in _start (/home/runner/work/btrfs-progs/btrfs-progs/btrfs+0x84144) (BuildId: 56f3dd838e1ae189c142c5d27fac025cd46deddb)

[CAUSE]
Above leaks are caused by two btrfs_qgroup structures and one path for
toplevel qgroup.

It's caused by the fact that we called qgroups_search_all() but didn't
do any cleanup.

[FIX]
Call __free_all_qgroups() inside cmd_qgroup_clear_stale() to properly
free the qgroups.

Fixes: 701ab151c2b6 ("btrfs-progs: qgroup: new command to delete stale qgroups")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/qgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index bffe942b1c52..20b97f7ae594 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -2301,6 +2301,7 @@ static int cmd_qgroup_clear_stale(const struct cmd_struct *cmd, int argc, char *
 
 out:
 	close(fd);
+	__free_all_qgroups(&qgroup_lookup);
 	return !!ret;
 }
 static DEFINE_SIMPLE_COMMAND(qgroup_clear_stale, "clear-stale");
-- 
2.45.2


