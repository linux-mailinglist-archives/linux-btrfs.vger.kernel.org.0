Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C585229B8D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgGVPga (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 11:36:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:45144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbgGVPg3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 11:36:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56F80AC83;
        Wed, 22 Jul 2020 15:36:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E99C8DA70B; Wed, 22 Jul 2020 17:36:01 +0200 (CEST)
Date:   Wed, 22 Jul 2020 17:36:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Chris Murphy <chris@colorremedies.com>
Subject: Re: [PATCH][RFC] btrfs: don't show full path of bind mounts in
 subvol=
Message-ID: <20200722153601.GZ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Chris Murphy <chris@colorremedies.com>
References: <20200721181656.16171-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721181656.16171-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 02:16:56PM -0400, Josef Bacik wrote:
> Chris Murphy reported a problem where rpm ostree will bind mount a bunch
> of things for whatever voodoo it's doing.  But when it does this
> /proc/mounts shows something like
> 
> /dev/vda4 on /usr type btrfs (ro,relatime,seclabel,space_cache,subvolid=256,subvol=/root/ostree/deploy/fedora/deploy/610b0f9be3141c79f19a65800f89746c70183cc7f14f3cfba29d695d49128075.0/usr)
> 
> Despite subvolid=256 being subvol=/root.  This is because we're just
> spitting out the dentry of the mount point, which in the case of bind
> mounts is the source path for the mountpoint.  Instead we should spit
> out the path to the actual subvol.  Fix this by looking up the name for
> the subvolid we have mounted.
> 
> Fixes: c8d3fe028f64 ("Btrfs: show subvol= and subvolid= in /proc/mounts")
> Reported-by: Chris Murphy <chris@colorremedies.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> 
> I talked with Omar about this and his other suggestion is we simply don't spit
> out subvol=<path> if we're not the actual subvolume dentry.  I'm ok with that
> option too, and it avoids a memory alloc for show_options, however it does mean
> that we'll stop spitting out subvol= in some cases, which may cause problems?
> If we prefer that option I can code that up instead.

That sounds like a valid alternative, in case it's not a subvolume
dentry I'd drop the subvolid= too. One of the points of the subvol=
option was to allow copy&paste from /proc/mounts and get the same
result.

The bind mount is the underlying mechanism for subvolume mount but it
can be also done by user and we have no way to distinguish that. So
manual bind mount to a subvolume is effectively the same thing as mount
-o subvol=/path. The result in /proc/mounts would be the same. I don't
think this is a problem.

Current output of non-subvolume bind mount is confusing and known, I
once tried to fix it by traversing back the dentry chain until it
reaches the parent subvolume but there are some other cases like nested
subvolumes where it's not clear where to stop:

/dir1/subvol1/dir2/subvol2/dir3/subvol3/dir4

when eg. dir3 is bind mounted, if subvol= should be subvol2 or subvol1.

Resolving the subvolume from the subvolid we get from the dentry/inode
should work, it's the actual mount point so something the user has
specified at some point.

So the question is:

1) resolve subvol from subvolid in all cases, it could be something else
   in case of bind mounts, but it's still close

2) non-subvolume bind mounts won't print subvolid/subvol at all, that
   way it could be determined it's bind mount in some random directory

I'g go for option 1, ie. what you implemented. The extra allocation
should not be a big concern.

>  fs/btrfs/super.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 58f890f73650..0e1647c08610 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1367,6 +1367,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  {
>  	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
>  	const char *compress_type;
> +	const char *subvol_name;
>  
>  	if (btrfs_test_opt(info, DEGRADED))
>  		seq_puts(seq, ",degraded");
> @@ -1453,8 +1454,12 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  		seq_puts(seq, ",ref_verify");
>  	seq_printf(seq, ",subvolid=%llu",
>  		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
> -	seq_puts(seq, ",subvol=");
> -	seq_dentry(seq, dentry, " \t\n\\");
> +	subvol_name = btrfs_get_subvol_name_from_objectid(info,
> +			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
> +	if (subvol_name) {
> +		seq_printf(seq, ",subvol=%s", subvol_name);

The path still needs to be escaped, seq_escape

> +		kfree(subvol_name);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.24.1
