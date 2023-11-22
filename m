Return-Path: <linux-btrfs+bounces-306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEAB7F4E24
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F55281565
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC35B5CF;
	Wed, 22 Nov 2023 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FEGftSVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D86C11F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:18 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5cd0af4a7d3so917807b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673497; x=1701278297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlsY8IVFRzozoVSPtDgNgEBZtdoSVYJjR60tr7DOIq0=;
        b=FEGftSVdj6Mla0QWdcM7QaMAwoXQXcmzgUGGdyZz8l6g1e5RrX37m0B2Qz1ux4zXyh
         zxqrFop0+/vYDzOgEeGK/YZnAL/DMVXo8Ah48hsUpmTDrM8aF4kueVDnS+TL1LHy/A6D
         AaOPmLWLiRwx7L4pQHOHlKE9g/ABBoO/Xi6Fheh2MgDroO71D4bxPjzKXE/xYu/mBHNm
         TeyPOqpQZqond+yOv3yfZJkKm2I8WfusQD/jiQTUU5xu/cj8FdLRYvPLG4+lfRTsXGtb
         4+7BeZ+maDU7M8+IpdIVMicgCkS7EM62uZOjX0jGgBcccwNL2us/3EG76zopHuOGSHiL
         QMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673497; x=1701278297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlsY8IVFRzozoVSPtDgNgEBZtdoSVYJjR60tr7DOIq0=;
        b=oXCHlqBAg/T8p8kBK24RSDR3mWxQ92tA7o80JJ7enBBbypp3JVR5rmOLU3Ow8UAEpv
         tHBmdJc8k6fDhfpGEru46KyJ5Cebw95PDvXRA0zcueRfyYlhg+/4EswfBG0VRjLggrRm
         8SCDZVSpPD6DZ0IE+uk1NPEkh7i63m2CfYGDi6+/y2/6wv5i7GTlFTZw0GTr0TFB/LAK
         FMUkI8nnhrrz7vVP6UogEmwh0g8Iz6Q7lN7KduvjhERLMMyS20ZusULsuqv3GwB7JQxL
         0f7hdCD2s0uM1vk8z7fQXIjGwhi+ExoDQa/c4H1dRW+cVTsKI1nC5FqVGAjfGM4+Mki9
         ogjA==
X-Gm-Message-State: AOJu0Yz3C9waNqigzIwztetniVdSw6zTYe5OSV2p/5AWGfUVMT7ABpl3
	+rueW2SovioQ067vRcUnmnLaQ2PgiyjnHtt+dCiT8C9i7A4=
X-Google-Smtp-Source: AGHT+IGUxA4U0CaH/a9KmvLVky1jm3N+Xg8hL4E49AhJLml6bM27yYx3GUABZUgBvOLPo9Rr+xI5QQ==
X-Received: by 2002:a0d:dbc3:0:b0:5ca:f2ff:a346 with SMTP id d186-20020a0ddbc3000000b005caf2ffa346mr2786405ywe.13.1700673497062;
        Wed, 22 Nov 2023 09:18:17 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h17-20020a81b411000000b00577269ba9e9sm3788052ywi.86.2023.11.22.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 13/19] btrfs: handle the ro->rw transition for mounting different subovls
Date: Wed, 22 Nov 2023 12:17:49 -0500
Message-ID: <72054b19620fda64c1d2052f99a848754891f34b.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an oddity that we've carried around since 0723a0473fb4 ("btrfs:
allow mounting btrfs subvolumes with different ro/rw options") where
we'll under the covers flip the file system to RW if you're mixing and
matching ro/rw options with different subvol mounts.  The first mount is
what the super gets setup as, so we'd handle this by remount the super
as rw under the covers to facilitate this behavior.

With the new mount API we can't really allow this, because user space
has the ability to specify the super block settings, and the mount
settings.  So if the user explicitly set the super block as read only,
and then tried to mount a rw mount with the super block we'll reject
this.  However the old API was less descriptive and thus we allowed this
kind of behavior.

This patch preserves this behavior for the old api calls.  This is
inspired by Christians work, and includes one of his comments, and thus
is included in the link below.

Link: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org/
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 184d89c0edfd..c2b42f0e6a07 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2489,13 +2489,15 @@ static int btrfs_reconfigure(struct fs_context *fc)
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_fs_context old_ctx;
 	int ret = 0;
+	bool mount_reconfigure = (fc->s_fs_info != NULL);
 
 	btrfs_info_to_ctx(fs_info, &old_ctx);
 
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
 
-	if (!check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
+	if (!mount_reconfigure &&
+	    !check_options(fs_info, &ctx->mount_opt, fc->sb_flags))
 		return -EINVAL;
 
 	ret = btrfs_check_features(fs_info, !(fc->sb_flags & SB_RDONLY));
@@ -2898,6 +2900,133 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	return ret;
 }
 
+/*
+ * Christian wrote this long comment about what we're doing here, preserving it
+ * so the history of this change is preserved.
+ *
+ * Ever since commit 0723a0473fb4 ("btrfs: allow * mounting btrfs subvolumes
+ * with different ro/rw * options") the following works:
+ *
+ *        (i) mount /dev/sda3 -o subvol=foo,ro /mnt/foo
+ *       (ii) mount /dev/sda3 -o subvol=bar,rw /mnt/bar
+ *
+ * which looks nice and innocent but is actually pretty * intricate and
+ * deserves a long comment.
+ *
+ * On another filesystem a subvolume mount is close to * something like:
+ *
+ *	(iii) # create rw superblock + initial mount
+ *	      mount -t xfs /dev/sdb /opt/
+ *
+ *	      # create ro bind mount
+ *	      mount --bind -o ro /opt/foo /mnt/foo
+ *
+ *	      # unmount initial mount
+ *	      umount /opt
+ *
+ * Of course, there's some special subvolume sauce and there's the fact that the
+ * sb->s_root dentry is really swapped after mount_subtree(). But conceptually
+ * it's very close and will help us understand the issue.
+ *
+ * The old mount api didn't cleanly distinguish between a mount being made ro
+ * and a superblock being made ro.  The only way to change the ro state of
+ * either object was by passing ms_rdonly. If a new mount was created via
+ * mount(2) such as:
+ *
+ *      mount("/dev/sdb", "/mnt", "xfs", ms_rdonly, null);
+ *
+ * the MS_RDONLY flag being specified had two effects:
+ *
+ * (1) MNT_READONLY was raised -> the resulting mount got
+ *     @mnt->mnt_flags |= MNT_READONLY raised.
+ *
+ * (2) MS_RDONLY was passed to the filesystem's mount method and the filesystems
+ *     made the superblock ro. Note, how SB_RDONLY has the same value as
+ *     ms_rdonly and is raised whenever MS_RDONLY is passed through mount(2).
+ *
+ * Creating a subtree mount via (iii) ends up leaving a rw superblock with a
+ * subtree mounted ro.
+ *
+ * But consider the effect on the old mount api on btrfs subvolume mounting
+ * which combines the distinct step in (iii) into a a single step.
+ *
+ * By issuing (i) both the mount and the superblock are turned ro. Now when (ii)
+ * is issued the superblock is ro and thus even if the mount created for (ii) is
+ * rw it wouldn't help. Hence, btrfs needed to transition the superblock from ro
+ * to rw for (ii) which it did using an internal remount call (a bold
+ * choice...).
+ *
+ * IOW, subvolume mounting was inherently messy due to the ambiguity of
+ * MS_RDONLY in mount(2). Note, this ambiguity has mount(8) always translate
+ * "ro" to MS_RDONLY. IOW, in both (i) and (ii) "ro" becomes MS_RDONLY when
+ * passed by mount(8) to mount(2).
+ *
+ * Enter the new mount api. the new mount api disambiguates making a mount ro
+ * and making a superblock ro.
+ *
+ * (3) To turn a mount ro the MOUNT_ATTR_ONLY flag can be used with either
+ *     fsmount() or mount_setattr() this is a pure vfs level change for a
+ *     specific mount or mount tree that is never seen by the filesystem itself.
+ *
+ * (4) To turn a superblock ro the "ro" flag must be used with
+ *     fsconfig(FSCONFIG_SET_FLAG, "ro"). This option is seen by the filesytem
+ *     in fc->sb_flags.
+ *
+ * This disambiguation has rather positive consequences.  Mounting a subvolume
+ * ro will not also turn the superblock ro. Only the mount for the subvolume
+ * will become ro.
+ *
+ * So, if the superblock creation request comes from the new mount api the
+ * caller must've explicitly done:
+ *
+ *      fsconfig(FSCONFIG_SET_FLAG, "ro")
+ *      fsmount/mount_setattr(MOUNT_ATTR_RDONLY)
+ *
+ * IOW, at some point the caller must have explicitly turned the whole
+ * superblock ro and we shouldn't just undo it like we did for the old mount
+ * api. In any case, it lets us avoid this nasty hack in the new mount api.
+ *
+ * Consequently, the remounting hack must only be used for requests originating
+ * from the old mount api and should be marked for full deprecation so it can be
+ * turned off in a couple of years.
+ *
+ * The new mount api has no reason to support this hack.
+ */
+static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
+{
+	struct vfsmount *mnt;
+	int ret;
+	bool ro2rw = !(fc->sb_flags & SB_RDONLY);
+
+	/*
+	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
+	 * super block, so invert our setting here and re-try the mount so we
+	 * can get our vfsmount.
+	 */
+	if (ro2rw)
+		fc->sb_flags |= SB_RDONLY;
+	else
+		fc->sb_flags &= ~SB_RDONLY;
+
+	mnt = fc_mount(fc);
+	if (IS_ERR(mnt))
+		return mnt;
+
+	if (!fc->oldapi || !ro2rw)
+		return mnt;
+
+	/* We need to convert to rw, call reconfigure */
+	fc->sb_flags &= ~SB_RDONLY;
+	down_write(&mnt->mnt_sb->s_umount);
+	ret = btrfs_reconfigure(fc);
+	up_write(&mnt->mnt_sb->s_umount);
+	if (ret) {
+		mntput(mnt);
+		return ERR_PTR(ret);
+	}
+	return mnt;
+}
+
 static int btrfs_get_tree_subvol(struct fs_context *fc)
 {
 	struct btrfs_fs_info *fs_info = NULL;
@@ -2947,6 +3076,8 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	fc->security = NULL;
 
 	mnt = fc_mount(dup_fc);
+	if (PTR_ERR_OR_ZERO(mnt) == -EBUSY)
+		mnt = btrfs_reconfigure_for_mount(dup_fc);
 	put_fs_context(dup_fc);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
-- 
2.41.0


