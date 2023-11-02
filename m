Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6D7DF0E2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 12:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347240AbjKBLH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbjKBLHz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 07:07:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC545DE
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 04:07:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68060C433C8;
        Thu,  2 Nov 2023 11:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698923272;
        bh=vBZ6CoC27DKlXXWJLILSuWZxK3TJ0ywpD+ZBkYaJZtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ys3UFDvrxSk/TgQWj3Z4ue146ufUssLjQ3jWQ9812Cf+TsSdnH7QVrcAN/GXw8R1H
         XYrDoYD179s3rNuQHGdNzfVdhlXb5B54Oe0ityBLEdoolmhZve6qbgsk4IJmfcUf50
         eHbK/lAZCbQqQPqZYMHM2lqMZVozFo7d9UVU8oKQWwyGPf1yRJAdQ07AY6foN/w6Xv
         PWFd3O3NBHx4pdXQpy6ePxwLMQjlEHowZo8X4y2+ilXt6K91GbUsjPcxs6RDkPLwQo
         Y1poKa1RP3sD7x6Te+ASVNZMZiLdRKyp+USEiDUxEQGqr3l7TXZn8M44IEuCQC9C4T
         I8yGWFbXO92VQ==
Date:   Thu, 2 Nov 2023 12:07:47 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231102-schafsfell-denkzettel-08da41113e24@brauner>
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
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Btw I'm working on this, mostly to show Christoph it doesn't do what he thinks
> it does.
> 
> However I ran into some weirdness where I need to support the new mount API, so
> that's what I've been doing since I wandered away from this thread.  I should
> have that done tomorrow, and then I was going to do the S_AUTOMOUNT thing ontop
> of that.
> 
> But I have the same questions as you Christian, I'm not entirely sure how this
> is supposed to be better.  Even if they show up in /proc/mounts, it's not going
> to do anything useful for the applications that don't check /proc/mounts to see
> if they've wandered into a new mount.  I also don't quite understand how NFS
> suddenly knows it's wandered into a new mount with a vfsmount.

So the subvolumes-as-vfsmount solution was implemented already a few
years ago. I looked at that patchset and the crucial point in the
solution was patch [1].

show_mountinfo() is called under namespace_sem (see fs/namespace.c).
That thing is crucial for all mount namespaces, mount propagation and so
on. We can't cause IO under that unless we want to allow to trivially
deadlock the whole system by tricking us into talking to an unresponsive
NFS server or similar. And all vfs_getattr*() flavours can legitimately
cause IO even with AT_STATX_DONT_SYNC.

So exposing this via /proc/<pid>/mountinfo doesn't work. But that means
even if you make it a separate vfsmount you need to epose the device
information through another interface.

But at that point we really need to ask if it makes sense to use
vfsmounts per subvolume in the first place:

(1) We pollute /proc/<pid>/mountinfo with a lot of mounts.
(2) By calling ->getattr() from show_mountinfo() we open the whole
    system up to deadlocks.
(3) We change btrfs semantics drastically to the point where they need a
    new mount, module, or Kconfig option.
(4) We make (initial) lookup on btrfs subvolumes more heavyweight
    because you need to create a mount for the subvolume.

So right now, I don't see how we can make this work even if the concept
doesn't seem necessarily wrong.

Even if we were to go through with this and make each subvolume a
vfsmount but then don't expose the ->getattr() device numbers in
/proc/<pid>/mountinfo but instead add a separate retrieval method via
statx() we'd be creating even more confusion for userspace by showing
different device numbers in /proc/<pid>/mountinfo than in statx().

[1]:

Subject:        [PATCH 01/11] VFS: show correct dev num in mountinfo
Date:	 	Wed, 28 Jul 2021 08:37:45 +1000
Message-ID:	<162742546548.32498.10889023150565429936.stgit@noble.brown>

/proc/$PID/mountinfo contains a field for the device number of the
filesystem at each mount.

This is taken from the superblock ->s_dev field, which is correct for
every filesystem except btrfs.  A btrfs filesystem can contain multiple
subvols which each have a different device number.  If (a directory
within) one of these subvols is mounted, the device number reported in
mountinfo will be different from the device number reported by stat().

This confuses some libraries and tools such as, historically, findmnt.
Current findmnt seems to cope with the strangeness.

So instead of using ->s_dev, call vfs_getattr_nosec() and use the ->dev
provided.  As there is no STATX flag to ask for the device number, we
pass a request mask for zero, and also ask the filesystem to avoid
syncing with any remote service.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/proc_namespace.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 392ef5162655..f342a0231e9e 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -138,10 +138,16 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 	struct mount *r = real_mount(mnt);
 	struct super_block *sb = mnt->mnt_sb;
 	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
+	struct kstat stat;
 	int err;
 
+	/* We only want ->dev, and there is no STATX flag for that,
+	 * so ask for nothing and assume we get ->dev
+	 */
+	vfs_getattr_nosec(&mnt_path, &stat, 0, AT_STATX_DONT_SYNC);
+
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
-		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
+		   MAJOR(stat.dev), MINOR(stat.dev));
 	if (sb->s_op->show_path) {
 		err = sb->s_op->show_path(m, mnt->mnt_root);
 		if (err)

