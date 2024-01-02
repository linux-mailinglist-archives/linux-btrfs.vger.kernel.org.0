Return-Path: <linux-btrfs+bounces-1182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD98216D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 05:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC2C1C2111B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 04:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C988D30E;
	Tue,  2 Jan 2024 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lX7r6j6r";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uBvf6HeW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C33C8F5;
	Tue,  2 Jan 2024 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E25FE21E95;
	Tue,  2 Jan 2024 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704168778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYSOONXMVgPEycKwvBPu1abrQtkqdF3VIp134lU1tnc=;
	b=lX7r6j6rdp5YdZLwov4YOKJNf9q/CYe4iTn4uYlDkXBxn/hep7secxFmqlkltNSB6Hd/Hu
	TK6kLWp2q9qi00C+Otw7v+xdt+yF6b2GsTsopjdZpi1dQitRVrIzJfXBayOLjgnEUaTaE+
	TJ3co8EMgojp3Rbfj8seRcQWLPTwMUM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704168777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYSOONXMVgPEycKwvBPu1abrQtkqdF3VIp134lU1tnc=;
	b=uBvf6HeWx+uUgCG2aVjtgde31tHUWrYubE+oy+aoJQep8rAgNzv+XDY7BuMgtr/WlXYS57
	ttXTkKUiO0+C4Dg2UlVrT+SIvRzeFfzWQhl2+K1XKv9GPAGOTpMFr3h3RbKqihKDDEDdEr
	t9DySxG746ptIOLp8EdwPstRKjIeifE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A8C136D1;
	Tue,  2 Jan 2024 04:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aH+9BUaNk2UHQQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 02 Jan 2024 04:12:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de
Subject: [PATCH v2 4/4] btrfs: migrate to the newer memparse_safe() helper
Date: Tue,  2 Jan 2024 14:42:14 +1030
Message-ID: <04b551a30763f776303c7ca8b0d0ffc0ed665e2a.1704168510.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704168510.git.wqu@suse.com>
References: <cover.1704168510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uBvf6HeW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.19)[-0.962];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.00
X-Rspamd-Queue-Id: E25FE21E95
X-Spam-Flag: NO

The new helper has better error report and correct overflow detection,
furthermore the old @retptr behavior is also kept, thus there should be
no behavior change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c |  6 +++++-
 fs/btrfs/super.c |  9 ++++++++-
 fs/btrfs/sysfs.c | 14 +++++++++++---
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4e50b62db2a8..cb63f50a2078 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1175,7 +1175,11 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 			mod = 1;
 			sizestr++;
 		}
-		new_size = memparse(sizestr, &retptr);
+
+		ret = memparse_safe(sizestr, MEMPARSE_SUFFIXES_DEFAULT,
+				    &new_size, &retptr);
+		if (ret < 0)
+			goto out_finish;
 		if (*retptr != '\0' || new_size == 0) {
 			ret = -EINVAL;
 			goto out_finish;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3a677b808f0f..0f29fd692e0f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -263,6 +263,8 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
+	/* Only for memparse_safe() caller. */
+	int ret;
 	int opt;
 
 	opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
@@ -400,7 +402,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->thread_pool_size = result.uint_32;
 		break;
 	case Opt_max_inline:
-		ctx->max_inline = memparse(param->string, NULL);
+		ret = memparse_safe(param->string, MEMPARSE_SUFFIXES_DEFAULT,
+				    &ctx->max_inline, NULL);
+		if (ret < 0) {
+			btrfs_err(NULL, "invalid string \"%s\"", param->string);
+			return ret;
+		}
 		break;
 	case Opt_acl:
 		if (result.negated) {
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


