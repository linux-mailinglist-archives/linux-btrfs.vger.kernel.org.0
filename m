Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBA7DEF2D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbjKBJso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 05:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbjKBJsn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 05:48:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62568111
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 02:48:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFABC433C8;
        Thu,  2 Nov 2023 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698918520;
        bh=89TbdRFGRsSQbmSE8vqh8YsvVTrLMcZh5MiD6xIF4HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIUu8G6o6eEg4qosxpSMpA+fMG23bSU+C6m1frHIyQhy2Z4LM6vcBGihZI7LbG/XE
         bpjwEfJNkR2vmmOjEPEo1U/hvrwyVUq/JGF4jjBN7W2u097OTOuyQf3MGAVX73zfXk
         OFyQniTliQZ8kgZZB/ZuAT0IlUPBTWCWJ+wl7RL/vBM+jf/eikNGe2znhqAIcUPcm0
         Ihn/+igfDZFlBH05x2Jt8vFeAvtEQQvEya+BzDEWEOKgTsQ1+sPitfrQfdVIkug2DC
         9YnYYITj95byYjDGLgBfpQpfWeOvFRQ45CNK4nXtGkInA7DLFtv2v1WPbeullQy51A
         Geprxtt/PyrKQ==
Date:   Thu, 2 Nov 2023 10:48:35 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
References: <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102051349.GA3292886@perftesting>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> We'll be converted to the new mount API tho, so I suppose that's something.
> Thanks,

Just in case you forgot about it. I did send a patch to convert btrfs to
the new mount api in June:

https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org

Can I ask you to please please copy just two things from that series:

(1) Please get rid of the second filesystems type.
(2) Please fix the silent remount behavior when mounting a subvolume.

You might need my first patch for that from that series for (2).

+static int btrfs_get_tree_common(struct fs_context *fc)
+{
+	struct vfsmount *root_mnt = NULL;
+	struct fs_context *root_fc;
+	struct dentry *root_dentry;
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	int ret;
+
+	if (WARN_ON(ctx->phase != BTRFS_FS_CONTEXT_PREPARE))
+		return -EINVAL;
+
+	root_fc = vfs_dup_fs_context(fc);
+	if (IS_ERR(root_fc))
+		return PTR_ERR(root_fc);
+
+	/*
+	 * We've duplicated the security mount options above and we only
+	 * need them to be set when we really create a new superblock.
+	 * They're irrelevant when we mount the subvolume as the
+	 * superblock does already exist at that point. So free the
+	 * security blob here.
+	 */
+	security_free_mnt_opts(&fc->security);
+	fc->security = NULL;
+
+	/* Create the superblock so we can mount a subtree later. */
+	ctx->phase = BTRFS_FS_CONTEXT_SUPER;
+
+	root_mnt = fc_mount(root_fc);
+	if (PTR_ERR_OR_ZERO(root_mnt) == -EBUSY) {
+		bool ro2rw = !(root_fc->sb_flags & SB_RDONLY);
+
+		if (ro2rw)
+			root_fc->sb_flags |= SB_RDONLY;
+		else
+			root_fc->sb_flags &= ~SB_RDONLY;
+
+		root_mnt = fc_mount(root_fc);
+		if (IS_ERR(root_mnt)) {
+			put_fs_context(root_fc);
+			return PTR_ERR(root_mnt);
+		}
+		ctx->root_mnt = root_mnt;
+
+		/*
+		 * Ever since commit 0723a0473fb4 ("btrfs: allow
+		 * mounting btrfs subvolumes with different ro/rw
+		 * options") the following works:
+		 *
+		 *        (i) mount /dev/sda3 -o subvol=foo,ro /mnt/foo
+		 *       (ii) mount /dev/sda3 -o subvol=bar,rw /mnt/bar
+		 *
+		 * which looks nice and innocent but is actually pretty
+		 * intricate and deserves a long comment.
+		 *
+		 * On another filesystem a subvolume mount is close to
+		 * something like:
+		 *
+		 *	(iii) # create rw superblock + initial mount
+		 *	      mount -t xfs /dev/sdb /opt/
+		 *
+		 *	      # create ro bind mount
+		 *	      mount --bind -o ro /opt/foo /mnt/foo
+		 *
+		 *	      # unmount initial mount
+		 *	      umount /opt
+		 *
+		 * Of course, there's some special subvolume sauce and
+		 * there's the fact that the sb->s_root dentry is really
+		 * swapped after mount_subtree(). But conceptually it's
+		 * very close and will help us understand the issue.
+		 *
+		 * The old mount api didn't cleanly distinguish between
+		 * a mount being made ro and a superblock being made ro.
+		 * The only way to change the ro state of either object
+		 * was by passing MS_RDONLY. If a new mount was created
+		 * via mount(2) such as:
+		 *
+		 *      mount("/dev/sdb", "/mnt", "xfs", MS_RDONLY, NULL);
+		 *
+		 * the MS_RDONLY flag being specified had two effects:
+		 *
+		 * (1) MNT_READONLY was raised -> the resulting mount
+		 *     got @mnt->mnt_flags |= MNT_READONLY raised.
+		 *
+		 * (2) MS_RDONLY was passed to the filesystem's mount
+		 *     method and the filesystems made the superblock
+		 *     ro. Note, how SB_RDONLY has the same value as
+		 *     MS_RDONLY and is raised whenever MS_RDONLY is
+		 *     passed through mount(2).
+		 *
+		 * Creating a subtree mount via (iii) ends up leaving a
+		 * rw superblock with a subtree mounted ro.
+		 *
+		 * But consider the effect on the old mount api on btrfs
+		 * subvolume mounting which combines the distinct step
+		 * in (iii) into a a single step.
+		 *
+		 * By issuing (i) both the mount and the superblock are
+		 * turned ro. Now when (ii) is issued the superblock is
+		 * ro and thus even if the mount created for (ii) is rw
+		 * it wouldn't help. Hence, btrfs needed to transition
+		 * the superblock from ro to rw for (ii) which it did
+		 * using an internal remount call (a bold choice...).
+		 *
+		 * IOW, subvolume mounting was inherently messy due to
+		 * the ambiguity of MS_RDONLY in mount(2). Note, this
+		 * ambiguity has mount(8) always translate "ro" to
+		 * MS_RDONLY. IOW, in both (i) and (ii) "ro" becomes
+		 * MS_RDONLY when passed by mount(8) to mount(2).
+		 *
+		 * Enter the new mount api. The new mount api
+		 * disambiguates making a mount ro and making a
+		 * superblock ro.
+		 *
+		 * (3) To turn a mount ro the MOUNT_ATTR_RDONLY flag can
+		 *     be used with either fsmount() or mount_setattr().
+		 *     This is a pure VFS level change for a specific
+		 *     mount or mount tree that is never seen by the
+		 *     filesystem itself.
+		 *
+		 * (4) To turn a superblock ro the "ro" flag must be
+		 *     used with fsconfig(FSCONFIG_SET_FLAG, "ro"). This
+		 *     option is seen by the filesytem in fc->sb_flags.
+		 *
+		 * This disambiguation has rather positive consequences.
+		 * Mounting a subvolume ro will not also turn the
+		 * superblock ro. Only the mount for the subvolume will
+		 * become ro.
+		 *
+		 * So, if the superblock creation request comes from the
+		 * new mount api the caller must've explicitly done:
+		 *
+		 *      fsconfig(FSCONFIG_SET_FLAG, "ro")
+		 *      fsmount/mount_setattr(MOUNT_ATTR_RDONLY)
+		 *
+		 * IOW, at some point the caller must have explicitly
+		 * turned the whole superblock ro and we shouldn't just
+		 * undo it like we did for the old mount api. In any
+		 * case, it lets us avoid this nasty hack in the new
+		 * mount api.
+		 *
+		 * Consequently, the remounting hack must only be used
+		 * for requests originating from the old mount api and
+		 * should be marked for full deprecation so it can be
+		 * turned off in a couple of years.
+		 *
+		 * The new mount api has no reason to support this hack.
+		 */
+		if (root_fc->oldapi && ro2rw) {
+			/*
+			 * This magic internal remount is a pretty bold
+			 * move as the VFS reserves the right to protect
+			 * ro->rw transitions on the VFS layer similar
+			 * to how it protects rw->ro transitions.
+			 */
+			ret = btrfs_legacy_reconfigure(root_fc);
+			if (ret)
+				root_mnt = ERR_PTR(ret);
+		}
+	}
+	put_fs_context(root_fc);
+	if (IS_ERR(root_mnt))
+		return PTR_ERR(root_mnt);
+	ctx->root_mnt = root_mnt;
+
+	root_dentry = mount_subvol(fc);
+	if (IS_ERR(root_dentry))
+		return PTR_ERR(root_dentry);
+
+	fc->root = root_dentry;
+	return 0;
+}
