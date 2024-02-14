Return-Path: <linux-btrfs+bounces-2392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D185522F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3952F1C2784E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A518613DB81;
	Wed, 14 Feb 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ismODYak";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ismODYak"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B813B7B1;
	Wed, 14 Feb 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935560; cv=none; b=aknz8TTcUrSA1eSegA0SSaWPIlErXFEMy5siV6Pe1PkOv5O352n3NsopahzQnvNIyIeOXIGSKSIv72vjIycIHh563aJLzmIsBk+m9Pzwy1EljOV7267geB/Ww+6Pv2Zc0h0P5RXN3jrXRHx5dx73HTebTUoZmkV369BVG5B57CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935560; c=relaxed/simple;
	bh=jxQZez0dtw473PeyyoBkIjtqlnjKu1CMofDP4r1LLRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVeF5PLZ1bKyk84K55vlrcolJHRlwAtzoqpyJT6z5SOgvBxpnQLFTWRtWPgC2pz/fCGzQcc8BiVcqlQd1f8o45SmyPPmfgzcHVukCvy2nenekUP5VryF0I88AwTx9nUT4qYAlAL1rR3uplyldASy2l9RUwmVyOKr5ZwnNI2r/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ismODYak; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ismODYak; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A897A21F38;
	Wed, 14 Feb 2024 18:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpoPv0EPH96gsl8RN5JZDirGgdKHkS8imepkcvTyq54=;
	b=ismODYak66RMF80mg6zh+++ii/hPLaVsj4PyZMCuQ5t60Odp/SQMtnLMbL3K2qDosmP3Sz
	PUPTO+9OvT78wvW/7QYHUV6hm0T783fsTJX3+EcNcoglQ2hDDB8SvCBOmUJgfVLSs+GzLG
	oxZ8z+2ZgmIdSu61cPjUQlEdiOrG2YM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpoPv0EPH96gsl8RN5JZDirGgdKHkS8imepkcvTyq54=;
	b=ismODYak66RMF80mg6zh+++ii/hPLaVsj4PyZMCuQ5t60Odp/SQMtnLMbL3K2qDosmP3Sz
	PUPTO+9OvT78wvW/7QYHUV6hm0T783fsTJX3+EcNcoglQ2hDDB8SvCBOmUJgfVLSs+GzLG
	oxZ8z+2ZgmIdSu61cPjUQlEdiOrG2YM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A235613A0B;
	Wed, 14 Feb 2024 18:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CN2ZJ0QHzWUcRQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 14 Feb 2024 18:32:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	stable@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Subject: [PATCH 3/3] btrfs: dev-replace: properly validate device names
Date: Wed, 14 Feb 2024 19:32:04 +0100
Message-ID: <982751e2f8e8cdf6b9e95d4c8eb3fcb22a1b2a25.1707935035.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707935035.git.dsterba@suse.com>
References: <cover.1707935035.git.dsterba@suse.com>
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
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[qq.com];
	 TAGGED_RCPT(0.00)[33f23b49ac24f986c9e8];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,suse.com:email];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,qq.com,syzkaller.appspotmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

There's a syzbot report that device name buffers passed to device
replace are not properly checked for string termination which could lead
to a read out of bounds in getname_kernel().

Add a helper that validates both source and target device name buffers.
For devid as the source initialize the buffer to empty string in case
something tries to read it later.

This was originally analyzed and fixed in a different way by Edward Adam
Davis (see links).

Link: https://lore.kernel.org/linux-btrfs/000000000000d1a1d1060cc9c5e7@google.com/
Link: https://lore.kernel.org/linux-btrfs/tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com/
CC: stable@vger.kernel.org # 4.19+
CC: Edward Adam Davis <eadavis@qq.com>
Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dev-replace.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 1502d664c892..79c4293ddf37 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -725,6 +725,23 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int btrfs_check_replace_dev_names(struct btrfs_ioctl_dev_replace_args *args)
+{
+	if (args->start.srcdevid == 0) {
+		if (memchr(args->start.srcdev_name, 0,
+			   sizeof(args->start.srcdev_name)) == NULL)
+			return -ENAMETOOLONG;
+	} else {
+		args->start.srcdev_name[0] = 0;
+	}
+
+	if (memchr(args->start.tgtdev_name, 0,
+		   sizeof(args->start.tgtdev_name)) == NULL)
+	    return -ENAMETOOLONG;
+
+	return 0;
+}
+
 int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 			    struct btrfs_ioctl_dev_replace_args *args)
 {
@@ -737,10 +754,9 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	default:
 		return -EINVAL;
 	}
-
-	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
-		return -EINVAL;
+	ret = btrfs_check_replace_dev_names(args);
+	if (ret < 0)
+		return ret;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,
-- 
2.42.1


