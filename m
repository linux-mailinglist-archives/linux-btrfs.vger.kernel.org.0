Return-Path: <linux-btrfs+bounces-1207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B859082392C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 00:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561EC287915
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 23:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0AE20B0D;
	Wed,  3 Jan 2024 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iA7DfiSb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iA7DfiSb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F806208DA;
	Wed,  3 Jan 2024 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE9E81F7D1;
	Wed,  3 Jan 2024 23:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704324513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VzFgHrE0lFC+VNDDj8M8pUUWESRusrMT1ddLdCqdXU=;
	b=iA7DfiSbWuoqRI5TWOUFau6fl2Av6d4rlxS18czGmXygf2JiWqTLpUX0zMfjvHGxXWafnA
	5igBLXuHcaGK6XTrgJYXCAvh3BIAWNSn7UGa1AgCL0eD2Hb4A6VLW8oMdB4/SvkkJa6bx7
	MLnd/qJWxNX8INbpyA1IlAtra82H82A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704324513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VzFgHrE0lFC+VNDDj8M8pUUWESRusrMT1ddLdCqdXU=;
	b=iA7DfiSbWuoqRI5TWOUFau6fl2Av6d4rlxS18czGmXygf2JiWqTLpUX0zMfjvHGxXWafnA
	5igBLXuHcaGK6XTrgJYXCAvh3BIAWNSn7UGa1AgCL0eD2Hb4A6VLW8oMdB4/SvkkJa6bx7
	MLnd/qJWxNX8INbpyA1IlAtra82H82A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88D031398A;
	Wed,  3 Jan 2024 23:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8G8ZCZ3tlWWXTgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 03 Jan 2024 23:28:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de,
	geert@linux-m68k.org
Subject: [PATCH v3 4/4] btrfs: migrate to the newer memparse_safe() helper
Date: Thu,  4 Jan 2024 09:57:51 +1030
Message-ID: <c88ad0a44ec2899ef8f96ff9cbbe274119444578.1704324320.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704324320.git.wqu@suse.com>
References: <cover.1704324320.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *****
X-Spam-Score: 5.34
X-Spamd-Result: default: False [5.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.06)[-0.293];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de,linux-m68k.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

The new helper has better error report and correct overflow detection,
furthermore the old @retptr behavior is also kept, thus there should be
no behavior change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
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


