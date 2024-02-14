Return-Path: <linux-btrfs+bounces-2391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5985522D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D8A2853F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1413B7B4;
	Wed, 14 Feb 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AyinW9Na";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AyinW9Na"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5A13B78C
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935558; cv=none; b=ZRrOQBoMog1VWrpTxIg7Wimkxj8hGroOkSRa3J8Udv1a73f75oLj6H2DrwnvC4h6I94w5eZXBcuYYZZ+XgX/Ij0IrSGs6qb3/etyAWaS455IcHg52uE3S25ROhY9xBz9ZPS9HFExQXLSBb/+k2d8j1w1L5XBPX/1XfVot+SDq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935558; c=relaxed/simple;
	bh=HY6vSqKu8jtFgQ/hP+S1/Hfait+BkU2/8tWy2eB12zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0siDoyD3fL2vyH+zhF3wtqMPXUvgY59xFcd/7nFj0vhanpxP+qwcYr5NX4cwYu56Zz3Fn1HOFx2hA/sAn72nyqGJlZVT+BX0DMO88dfRq39uPXDUqGGmanoCvKG/hId6V/a1ZMO+2Tb1Ss6O523WM/ERgbW3dI/iu7Dt5NjdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AyinW9Na; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AyinW9Na; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D1C91F81C;
	Wed, 14 Feb 2024 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajjn+9CdkwMmVNhVEe/HLphOKMt8OYmxGx6+Ly/QGtA=;
	b=AyinW9NaxLKYT+oi42S//vomA6GGgaR0WnVYoiC4lS6YUnDHjWCJ43oO3HRQN4KrigNzIe
	PEeEBiCIsiyyJXVpNCJsJzMkZfwJwZ0bzftfHSNw/bExE4m+PHbMJnp3/qRLHMtPjEdy+b
	MSYcSwHdX22H8fd826b6SOYn0Slds8g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajjn+9CdkwMmVNhVEe/HLphOKMt8OYmxGx6+Ly/QGtA=;
	b=AyinW9NaxLKYT+oi42S//vomA6GGgaR0WnVYoiC4lS6YUnDHjWCJ43oO3HRQN4KrigNzIe
	PEeEBiCIsiyyJXVpNCJsJzMkZfwJwZ0bzftfHSNw/bExE4m+PHbMJnp3/qRLHMtPjEdy+b
	MSYcSwHdX22H8fd826b6SOYn0Slds8g=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 463DF13A0B;
	Wed, 14 Feb 2024 18:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6dcwEUIHzWUNRQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 14 Feb 2024 18:32:34 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: factor out validation of btrfs_ioctl_vol_args_v2::name
Date: Wed, 14 Feb 2024 19:32:01 +0100
Message-ID: <cc7eabb5443c7166c8c8a914f52fbbd9c8e23db2.1707935035.git.dsterba@suse.com>
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
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
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
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

The validation of vol args v2 name in snapshot and device remove ioctls
is not done properly. A terminating NUL is written to the end of the
buffer unconditionally, assuming that this would be the last place in
case the buffer is used completely. This does not communicate back the
actual error (either an invalid or too long path).

Factor out all such cases and use a helper to do the verification,
simply look for NUL in the buffer.  There's no expected practical
change, the size of buffer is 4088, this is enough for most paths or
names.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69d2ad24a4ca..b8895c0e8259 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -238,6 +238,13 @@ int btrfs_check_ioctl_vol_args_path(const struct btrfs_ioctl_vol_args *vol_args)
 	return 0;
 }
 
+static int btrfs_check_ioctl_vol_args2_subvol_name(const struct btrfs_ioctl_vol_args_v2 *vol_args2)
+{
+	if (memchr(vol_args2->name, 0, sizeof(vol_args2->name)) == NULL)
+		return -ENAMETOOLONG;
+	return 0;
+}
+
 /*
  * Set flags/xflags from the internal inode flags. The remaining items of
  * fsxattr are zeroed.
@@ -1365,7 +1372,9 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args))
 		return PTR_ERR(vol_args);
-	vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
+	ret = btrfs_check_ioctl_vol_args2_subvol_name(vol_args);
+	if (ret < 0)
+		goto free_args;
 
 	if (vol_args->flags & ~BTRFS_SUBVOL_CREATE_ARGS_MASK) {
 		ret = -EOPNOTSUPP;
@@ -2395,7 +2404,9 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 * name, same as v1 currently does.
 		 */
 		if (!(vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID)) {
-			vol_args2->name[BTRFS_SUBVOL_NAME_MAX] = 0;
+			err = btrfs_check_ioctl_vol_args2_subvol_name(vol_args2);
+			if (err < 0)
+				goto out;
 			subvol_name = vol_args2->name;
 
 			err = mnt_want_write_file(file);
@@ -2734,7 +2745,10 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto out;
 	}
 
-	vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
+	ret = btrfs_check_ioctl_vol_args2_subvol_name(vol_args);
+	if (ret < 0)
+		goto out;
+
 	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) {
 		args.devid = vol_args->devid;
 	} else if (!strcmp("cancel", vol_args->name)) {
-- 
2.42.1


