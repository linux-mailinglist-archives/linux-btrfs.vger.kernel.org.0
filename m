Return-Path: <linux-btrfs+bounces-15803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC92B18AF6
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2463A1AA3F2C
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145D71DF26A;
	Sat,  2 Aug 2025 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mqsDaokX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mqsDaokX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C21DD543
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754117803; cv=none; b=aP+xnU9T3G/xbhuNkfAnFNj8gPlYYMgcQlBnjquA6Hplzknlbg3107dD+3GvPQOcPqXIAJdu8YXNZft1A87B2/njk6/9XBEIXSQQKrUUcjTn/7OYx19y6nyZg1CtEkMwMW3RyGXPOJhi9cZp95bk/bNFXHH8w4oeCEG0fSuGJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754117803; c=relaxed/simple;
	bh=Z5hE93ZxxNwklyBXXYmw9o+iLai1HkHkcCe6E1UmdQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oop5gq/53ilZRBP9fxHfgOy6Xfz7GekmbqiYhhjeKLTBg0cIe3jtJnX9bnS3+jE8zaIW3uC0AwJJxbUnnmXR1MfH0nJeRV39jONFNqOYie2sCSfOBd5QIKY/pYXtHfvEefNN6fboB+wmgcsYwWMRCI/x4Z0030dLlvy+lFuNNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mqsDaokX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mqsDaokX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9B571F45E
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6gvt1F6+IMYvoMYQ+3HA3iRSsAJqSOLit1zPvw6QeY=;
	b=mqsDaokXvYYdhwc02dEE3gD92kaoS6Hz48BGv0rMpPAHC+Qzuo4bSY4nR/7NYmllCeAKWJ
	rhiEoG+X0UEjs17FBW686KYnXIgH3UcDeAzAEOFO5Fow1+u+HV/DHalmG3mo2QbDxJAvzS
	2gYKQV59LYFzMH8eQAa+VpSOjaYwdlg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mqsDaokX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754117776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6gvt1F6+IMYvoMYQ+3HA3iRSsAJqSOLit1zPvw6QeY=;
	b=mqsDaokXvYYdhwc02dEE3gD92kaoS6Hz48BGv0rMpPAHC+Qzuo4bSY4nR/7NYmllCeAKWJ
	rhiEoG+X0UEjs17FBW686KYnXIgH3UcDeAzAEOFO5Fow1+u+HV/DHalmG3mo2QbDxJAvzS
	2gYKQV59LYFzMH8eQAa+VpSOjaYwdlg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D000133D1
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 06:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODS0L4+2jWhhHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 02 Aug 2025 06:56:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: remove device_get_partition_size_sysfs()
Date: Sat,  2 Aug 2025 16:25:51 +0930
Message-ID: <7d924138ebae9196c7a6889b29e44e7549bda83d.1754116463.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754116463.git.wqu@suse.com>
References: <cover.1754116463.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C9B571F45E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

The helper is introduced for cases where the unprivileged user failed to
open the target file.

The problem is, when such failure happens, it means the distro's file
mode or ACL is actively preventing unrelated users to access the raw
device.

E.g. on my distro the default block device mode looks like this:

  brw-rw---- 1 root disk 254, 32 Aug  2 13:35 /dev/vdc

This means if an unprivileged end user is not in the disk group, it
should access the raw disk.

Using sysfs as a fallback is more like a workaround, and the workaround
is soon getting out of control.

For example the size is not in byte but in block unit. This is already
causing problem for issue #979.

Furthermore to grab the correct size in bytes, we have to do all kinds
of sysfs probing to handle partitions (to get the block size from parent
node) and dm devices (directly from the current node).

With the recent error handling enhancement, I do not think we should
even bother using the sysfs fallback, the error message should be enough
to inform the end user.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-utils.c | 39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index b52fbf33a539..7a0a299ccf83 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -333,49 +333,12 @@ int device_get_partition_size_fd_stat(int fd, const struct stat *st, u64 *result
 	return 0;
 }
 
-static int device_get_partition_size_sysfs(const char *dev, u64 *result_ret)
-{
-	int ret;
-	char path[PATH_MAX] = {};
-	char sysfs[PATH_MAX] = {};
-	char sizebuf[128] = {};
-	const char *name = NULL;
-	int sysfd;
-	unsigned long long size = 0;
-
-	name = realpath(dev, path);
-	if (!name)
-		return -errno;
-	name = path_basename(path);
-
-	ret = path_cat3_out(sysfs, "/sys/class/block", name, "size");
-	if (ret < 0)
-		return ret;
-	sysfd = open(sysfs, O_RDONLY);
-	if (sysfd < 0)
-		return -errno;
-	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
-	if (ret < 0) {
-		close(sysfd);
-		return ret;
-	}
-	errno = 0;
-	size = strtoull(sizebuf, NULL, 10);
-	if (size == ULLONG_MAX && errno == ERANGE) {
-		close(sysfd);
-		return -errno;
-	}
-	close(sysfd);
-	*result_ret = size;
-	return 0;
-}
-
 int device_get_partition_size(const char *dev, u64 *result_ret)
 {
 	int fd = open(dev, O_RDONLY);
 
 	if (fd < 0)
-		return device_get_partition_size_sysfs(dev, result_ret);
+		return -errno;
 
 	if (ioctl(fd, BLKGETSIZE64, result_ret) < 0) {
 		int ret = -errno;
-- 
2.50.1


