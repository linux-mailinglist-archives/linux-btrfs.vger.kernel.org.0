Return-Path: <linux-btrfs+bounces-972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194458143D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 09:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6581C2271D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1D417739;
	Fri, 15 Dec 2023 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sOhL5Grp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sOhL5Grp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEF14F87
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9B401F822
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702629589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCVN/i2zQpsUkpcQ9WDJlCEurR2AKYyRuA37ssavhy0=;
	b=sOhL5GrpgEHTJcGT6CY923o2V8yd6R6O2suRGBilYs8a7WLqueeCdXBmZ9136SkQyEW5QG
	ij96s2sP3707lafAOYAAb0phELFBtq9kDdgEqxmrW6B13CvtefavtM6kaYJm4NoobOtPmb
	6Eg9JE7Ov73gdNbUGojafsZYgT1c32U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702629589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCVN/i2zQpsUkpcQ9WDJlCEurR2AKYyRuA37ssavhy0=;
	b=sOhL5GrpgEHTJcGT6CY923o2V8yd6R6O2suRGBilYs8a7WLqueeCdXBmZ9136SkQyEW5QG
	ij96s2sP3707lafAOYAAb0phELFBtq9kDdgEqxmrW6B13CvtefavtM6kaYJm4NoobOtPmb
	6Eg9JE7Ov73gdNbUGojafsZYgT1c32U=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B4B2513A08
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uBQqGNQQfGVJBgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 08:39:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: sysfs: use kstrtoull_suffix() to replace memparse()
Date: Fri, 15 Dec 2023 19:09:24 +1030
Message-ID: <2693b00ca850b0f604e03c836e71d0ad8a93ffee.1702628925.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702628925.git.wqu@suse.com>
References: <cover.1702628925.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.70
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
Authentication-Results: smtp-out2.suse.de;
	none

Since memparse() itself can not handle overflow at all, use
memparse_ull() to be extra safe.

Now overflow values can be properly detected.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..089c3fc123fe 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -760,7 +760,7 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 {
 	struct btrfs_space_info *space_info = to_space_info(kobj);
 	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
-	char *retptr;
+	int ret;
 	u64 val;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -776,11 +776,9 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -EPERM;
 
-	val = memparse(buf, &retptr);
-	/* There could be trailing '\n', also catch any typos after the value */
-	retptr = skip_spaces(retptr);
-	if (*retptr != 0 || val == 0)
-		return -EINVAL;
+	ret = kstrtoull_suffix(buf, 0, &val, KSTRTOULL_SUFFIX_DEFAULT);
+	if (ret < 0)
+		return ret;
 
 	val = min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
 
@@ -1779,14 +1777,12 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
 {
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
-	char *endptr;
 	unsigned long long limit;
+	int ret;
 
-	limit = memparse(buf, &endptr);
-	/* There could be trailing '\n', also catch any typos after the value. */
-	endptr = skip_spaces(endptr);
-	if (*endptr != 0)
-		return -EINVAL;
+	ret = kstrtoull_suffix(buf, 0, &limit, KSTRTOULL_SUFFIX_DEFAULT);
+	if (ret < 0)
+		return ret;
 	WRITE_ONCE(device->scrub_speed_max, limit);
 	return len;
 }
-- 
2.43.0


