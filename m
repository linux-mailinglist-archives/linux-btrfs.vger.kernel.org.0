Return-Path: <linux-btrfs+bounces-2390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B412085522C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89B21C29907
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A313B785;
	Wed, 14 Feb 2024 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YizPtY5L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q+nHBQx0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5413B794
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935556; cv=none; b=rQCd/UpBALehNcTocS0xmHCcTcYz2iIrWZBrGfD41ghdZWfnaBE2et4KaxqB/rC0AyhFNPTXxFtqSkRJBIy4gIlr8BUx2mrlpMiZmcMB03HtGmjUrFqwCdu9b6dGMqQcaeI3MAyEjMb2GP1W5Jc/1qMi/RSC0+facFTR2cLCEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935556; c=relaxed/simple;
	bh=JdEn6opk2zXSoyThB2Qn0wpBA9eLqsKnIS6N/qYqn1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns6VkZ1YFjfcr16qIHhLZxqhFTTwCqG7jhVUq4UvKg8LYIr3cTXMPZPB5RTmpXWTXnitFOlUta99rlVCDQjot7tYqluRkJpv+P05E8QK972ueaZzvYDY4sECetole8frgpJfxqdqaEgRoErvkkIosEjTQeBJdmWzd5Fuw/fkSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YizPtY5L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q+nHBQx0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBA581F815;
	Wed, 14 Feb 2024 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqz0jMirbO5Wod0toRgSsM0lxoRM9O9IDYgq+XnjNXI=;
	b=YizPtY5LNHvA7QM3/0joTXGaaAIklJa//p4FYMIbPo2/elVOkX7zcdxx8du7oPbFpjFHEd
	miElu3QcKWLbhIX6z8YeJTbdjOnjwBta5J1mJpuexQ3qN6viVJuKxgdfYlqX4liso3mS8W
	ylzqY2kgEGqOT6Dt/cAzlNSZjjdV/qw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqz0jMirbO5Wod0toRgSsM0lxoRM9O9IDYgq+XnjNXI=;
	b=q+nHBQx0wj2Q3Z8i+k4XRdbTnSJNA01eOInS9f67IdzBqaaoD4TOcN69uAj2uS0WbcnCws
	XMZZasKR+owo+9AXvJGV4lI1fqACHZbGjiuCVAcEO0meblJYqDsXpS0NPJdMGQueama/fP
	R3gCa3qzUQkuAV+UojTghID9ZTkMD50=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DA7B313A0B;
	Wed, 14 Feb 2024 18:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6RBVNT8HzWULRQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 14 Feb 2024 18:32:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: factor out validation of btrfs_ioctl_vol_args::name
Date: Wed, 14 Feb 2024 19:31:59 +0100
Message-ID: <00446761eaf4f11f6dcde4ead3ff2464a2f96b6d.1707935035.git.dsterba@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

The validation of vol args name in several ioctls is not done properly.
a terminating NUL is written to the end of the buffer unconditionally,
assuming that this would be the last place in case the buffer is used
completely. This does not communicate back the actual error (either an
invalid or too long path).

Factor out all such cases and use a helper to do the verification,
simply look for NUL in the buffer. There's no expected practical change,
the size of buffer is 4088, this is enough for most paths or names.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/fs.h    |  2 ++
 fs/btrfs/ioctl.c | 34 +++++++++++++++++++++++++++++-----
 fs/btrfs/super.c |  5 ++++-
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f8bb73d6ab68..3c8fbc5ab082 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -922,6 +922,8 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 			  enum btrfs_exclusive_operation op);
 
+int btrfs_check_ioctl_vol_args_path(const struct btrfs_ioctl_vol_args *vol_args);
+
 /* Compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ac3316e0d11c..69d2ad24a4ca 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -231,6 +231,13 @@ static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+int btrfs_check_ioctl_vol_args_path(const struct btrfs_ioctl_vol_args *vol_args)
+{
+	if (memchr(vol_args->name, 0, sizeof(vol_args->name)) == NULL)
+		return -ENAMETOOLONG;
+	return 0;
+}
+
 /*
  * Set flags/xflags from the internal inode flags. The remaining items of
  * fsxattr are zeroed.
@@ -1128,7 +1135,10 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		ret = PTR_ERR(vol_args);
 		goto out_drop;
 	}
-	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
+	ret = btrfs_check_ioctl_vol_args_path(vol_args);
+	if (ret < 0)
+		goto out_free;
+
 	sizestr = vol_args->name;
 	cancel = (strcmp("cancel", sizestr) == 0);
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_RESIZE, cancel);
@@ -1328,12 +1338,15 @@ static noinline int btrfs_ioctl_snap_create(struct file *file,
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
-	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
+	ret = btrfs_check_ioctl_vol_args_path(vol_args);
+	if (ret < 0)
+		goto out;
 
 	ret = __btrfs_ioctl_snap_create(file, file_mnt_idmap(file),
 					vol_args->name, vol_args->fd, subvol,
 					false, NULL);
 
+out:
 	kfree(vol_args);
 	return ret;
 }
@@ -2466,7 +2479,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		if (IS_ERR(vol_args))
 			return PTR_ERR(vol_args);
 
-		vol_args->name[BTRFS_PATH_NAME_MAX] = 0;
+		err = btrfs_check_ioctl_vol_args_path(vol_args);
+		if (err < 0)
+			goto out;
+
 		subvol_name = vol_args->name;
 
 		err = mnt_want_write_file(file);
@@ -2677,12 +2693,16 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 		goto out;
 	}
 
-	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
+	ret = btrfs_check_ioctl_vol_args_path(vol_args);
+	if (ret < 0)
+		goto out_free;
+
 	ret = btrfs_init_new_device(fs_info, vol_args->name);
 
 	if (!ret)
 		btrfs_info(fs_info, "disk added %s", vol_args->name);
 
+out_free:
 	kfree(vol_args);
 out:
 	if (restore_op)
@@ -2774,7 +2794,10 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
 
-	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
+	ret = btrfs_check_ioctl_vol_args_path(vol_args);
+	if (ret < 0)
+		goto out_free;
+
 	if (!strcmp("cancel", vol_args->name)) {
 		cancel = true;
 	} else {
@@ -2801,6 +2824,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 		bdev_release(bdev_handle);
 out:
 	btrfs_put_dev_args_from_path(&args);
+out_free:
 	kfree(vol_args);
 	return ret;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 101f786963d4..bbc9efa7157b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2203,7 +2203,9 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	vol = memdup_user((void __user *)arg, sizeof(*vol));
 	if (IS_ERR(vol))
 		return PTR_ERR(vol);
-	vol->name[BTRFS_PATH_NAME_MAX] = '\0';
+	ret = btrfs_check_ioctl_vol_args_path(vol);
+	if (ret < 0)
+		goto out;
 
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
@@ -2245,6 +2247,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		break;
 	}
 
+out:
 	kfree(vol);
 	return ret;
 }
-- 
2.42.1


