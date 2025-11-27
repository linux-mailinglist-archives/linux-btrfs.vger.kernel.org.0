Return-Path: <linux-btrfs+bounces-19378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E4C8DA3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 307D6349E72
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED63168FC;
	Thu, 27 Nov 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a3kM6Gws";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oJC3fXdU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6211F7586
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764237191; cv=none; b=OUbYoumwPhD5QpuyO2d69PdD2NM+7kNNLbNoCB0eZiJn0H1mUcsoLw+9Ua8jEI44iAAMsGIVewcWzTLu2S4EcWpq48AX1/MJ//EtuAJbKClJDwym6VALZOeh/spd/QCDaNtucIiZeErWgCxNBkaYk+ufDzMztSXQzorVsXPAhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764237191; c=relaxed/simple;
	bh=A3ydoovOud9aeaADOVq1/WIOZqs+/KUWC6UYD3RZa+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RMPp1NrUGKM6vjy4SVda+SP8Pk8TkoF2Yb3bkFKS8SBwT0Eyh66mDY4O/DcA1WGWsCG41UmWRl3obfXXBHgg9HlUkCTwd3qQXVNGEvjPKOi6Xqp8k7dD2hiGgMV++SOT/g/wetEvcZwvbl4d9OaXNltPangdZXSFIHsYKVbyOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a3kM6Gws; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oJC3fXdU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F9885BCCE
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764237187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wfipx4ZIsfIBpOa/ccZ3FrTVbbPDGh1SlJafFfZ6Y8E=;
	b=a3kM6Gwsd5dM25UVDgdkzt/Kb6fQeAZ0RhVvF7wY6mIAgJiva3BEC19rHqcL4/p+Zb1Bex
	w07WHmuPrwzRzfxgtQALNaRpGooKVcmVXY+oVWVkMfwHgZ9j1gOK7ol0CvQjfC2eQUuV/v
	TM2R/n6ERy7BCBAXOCjHWypgiCr1YDc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oJC3fXdU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764237186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wfipx4ZIsfIBpOa/ccZ3FrTVbbPDGh1SlJafFfZ6Y8E=;
	b=oJC3fXdUN6NiBGvXDiJR2sWNtoSZtD212bV/YX7LelB168DOnI7/mUGBjmUTSlYeF7oJFm
	5Uo5axkAR41hgztTDZ0Qlv4edcqgkM4GmsrKPmZMOd5HQCVL98Ap4WpX7BQrrM/gBxcnl6
	bK7ipOdyfoYDh7K7l7sbirG0EUIf/jE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEA523EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 09:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OysxJIEfKGlWegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 09:53:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: do not output extra lines about mismatching device numbers
Date: Thu, 27 Nov 2025 20:22:48 +1030
Message-ID: <be9450a6d18fc29095db1145033f3805877f6143.1764237166.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.com:dkim];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8F9885BCCE

[BUG]
Fstests btrfs/218 fails with newer btrfs-progs:

btrfs/218 2s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/218.out.bad)
    --- tests/btrfs/218.out	2024-11-24 18:04:01.137258508 +1030
    +++ /home/adam/xfstests-dev/results//btrfs/218.out.bad	2025-11-27 20:19:21.653781264 +1030
    @@ -2,6 +2,7 @@
     Label: none  uuid: <UUID>
     	Total devices <NUM> FS bytes used <SIZE>
     	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
    +found more devices than fs_info
     [SCRATCH_DEV].write_io_errs    0
     [SCRATCH_DEV].read_io_errs     0
     [SCRATCH_DEV].flush_io_errs    0
    ...
    (Run 'diff -u /home/adam/xfstests-dev/tests/btrfs/218.out /home/adam/xfstests-dev/results//btrfs/218.out.bad'  to see the entire diff)

[CAUSE]
Commit f1115bd7fd1c ("btrfs-progs: count devices without SEARCH_TREE
ioctl in get_fs_info()") added a new message which will be triggered
every time we're calling get_fs_info() on a fs with a seed device.

This message is not really necessary as we know this behavior already
and is doing device number counting to handle such situation.

[FIX]
Just remove the unnecessary message which is confusing and lead to the
above golden output mismatch.

Fixes: f1115bd7fd1c ("btrfs-progs: count devices without SEARCH_TREE ioctl in get_fs_info()")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/utils.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index 3f7bcc0d07f1..23dbd9d16781 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -208,10 +208,8 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 			if (ret == 0)
 				count++;
 		}
-		if (count > fi_args->num_devices) {
-			printf("found more devices than fs_info\n");
+		if (count > fi_args->num_devices)
 			fi_args->num_devices = count;
-		}
 
 		/* We did not count devid 0, do another probe. */
 		ret = device_get_info(fd, 0, &tmp);
-- 
2.52.0


