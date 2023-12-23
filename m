Return-Path: <linux-btrfs+bounces-1132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A081D377
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Dec 2023 10:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599B61C20CAC
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Dec 2023 09:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ECDDF6B;
	Sat, 23 Dec 2023 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a3b4Lo+A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a3b4Lo+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6BDDC2;
	Sat, 23 Dec 2023 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26FA81FD3C;
	Sat, 23 Dec 2023 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703325527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu2YVbnchgZ4Y9RHvJToIjCQwioq6Ym5s/G+NLbihEc=;
	b=a3b4Lo+AzQzJk2ptQoP4ZuFzGlrViiy1CGi27Hni8jQa+AOC2r/Cc+uogcKK+HDlSvAlQO
	dGdrGwl1dMq8bmNwfmRqAsWF9eTp+3MpA5KBiighYWuIaURyZ31QBQacTpL9L/VMBirLuC
	dm0cyUIasWHcQGPvuhi5ElDD1/zjD+s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703325527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu2YVbnchgZ4Y9RHvJToIjCQwioq6Ym5s/G+NLbihEc=;
	b=a3b4Lo+AzQzJk2ptQoP4ZuFzGlrViiy1CGi27Hni8jQa+AOC2r/Cc+uogcKK+HDlSvAlQO
	dGdrGwl1dMq8bmNwfmRqAsWF9eTp+3MpA5KBiighYWuIaURyZ31QBQacTpL9L/VMBirLuC
	dm0cyUIasWHcQGPvuhi5ElDD1/zjD+s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8805C1392C;
	Sat, 23 Dec 2023 09:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eACRClOvhmXmcgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 23 Dec 2023 09:58:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de
Subject: [PATCH 3/3] btrfs: migrate to the newer memparse_safe() helper
Date: Sat, 23 Dec 2023 20:28:07 +1030
Message-ID: <6dfa53ded887caa2269c1beeaedcff086342339a.1703324146.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703324146.git.wqu@suse.com>
References: <cover.1703324146.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

The new helper has better error report and correct overflow detection,
furthermore the old @retptr behavior is also kept, thus there should be
no behavior change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c |  8 ++++++--
 fs/btrfs/super.c |  8 ++++++++
 fs/btrfs/sysfs.c | 14 +++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4e50b62db2a8..8bfd4b4ccf02 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1175,8 +1175,12 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 			mod = 1;
 			sizestr++;
 		}
-		new_size = memparse(sizestr, &retptr);
-		if (*retptr != '\0' || new_size == 0) {
+
+		ret = memparse_safe(sizestr, MEMPARSE_SUFFIXES_DEFAULT,
+				    &new_size, &retptr);
+		if (ret < 0)
+			goto out_finish;
+		if (*retptr != '\0') {
 			ret = -EINVAL;
 			goto out_finish;
 		}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3a677b808f0f..2bb6ea525e89 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -400,6 +400,14 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->thread_pool_size = result.uint_32;
 		break;
 	case Opt_max_inline:
+		int ret;
+
+		ret = memparse_safe(param->string, MEMPARSE_SUFFIXES_DEFAULT,
+				    &ctx->max_inline, NULL);
+		if (ret < 0) {
+			btrfs_err(NULL, "invalid string \"%s\"", param->string);
+			return ret;
+		}
 		ctx->max_inline = memparse(param->string, NULL);
 		break;
 	case Opt_acl:
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..6846572496a6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -762,6 +762,7 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
 	char *retptr;
 	u64 val;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -776,7 +777,10 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -EPERM;
 
-	val = memparse(buf, &retptr);
+	ret = memparse_safe(buf, MEMPARSE_SUFFIXES_DEFAULT, &val, &retptr);
+	if (ret < 0)
+		return ret;
+
 	/* There could be trailing '\n', also catch any typos after the value */
 	retptr = skip_spaces(retptr);
 	if (*retptr != 0 || val == 0)
@@ -1779,10 +1783,14 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
 {
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
-	char *endptr;
 	unsigned long long limit;
+	char *endptr;
+	int ret;
+
+	ret = memparse_safe(buf, MEMPARSE_SUFFIXES_DEFAULT, &limit, &endptr);
+	if (ret < 0)
+		return ret;
 
-	limit = memparse(buf, &endptr);
 	/* There could be trailing '\n', also catch any typos after the value. */
 	endptr = skip_spaces(endptr);
 	if (*endptr != 0)
-- 
2.43.0


