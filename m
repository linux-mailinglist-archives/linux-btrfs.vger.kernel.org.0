Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2730614CCF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgA2PE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 10:04:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:44686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgA2PE4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 10:04:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8A9BAAA6;
        Wed, 29 Jan 2020 15:04:54 +0000 (UTC)
Message-ID: <fd8a3cb87b1084e5ab68fdcb60f7af3c6b6265d1.camel@suse.de>
Subject: Re: [PATCHv2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     dsterba@suse.cz
Cc:     linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Wed, 29 Jan 2020 12:07:40 -0300
In-Reply-To: <20200128172638.GA3929@twin.jikos.cz>
References: <20200127024817.15587-1-marcos.souza.org@gmail.com>
         <20200128172638.GA3929@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2020-01-28 at 18:26 +0100, David Sterba wrote:
> wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>

...

> >  	struct dentry *parent = file->f_path.dentry;
> >  	struct btrfs_fs_info *fs_info = btrfs_sb(parent->d_sb);
> > @@ -2845,34 +2847,87 @@ static noinline int
> btrfs_ioctl_snap_destroy(struct file *file,
> >  	struct inode *inode;
> >  	struct btrfs_root *root = BTRFS_I(dir)->root;
> >  	struct btrfs_root *dest = NULL;
> > -	struct btrfs_ioctl_vol_args *vol_args;
> > +	struct btrfs_ioctl_vol_args *vol_args = NULL;
> > +	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
> > +	char *name, *name_ptr = NULL;
> 
> The naming is confusing, name_ptr refers to the resolved subvolume
> name,
> so I suggest to rename it to subvol_name.

Sure, much better.

> >  	int namelen;
> >  	int err = 0;
> >  
> > -	if (!S_ISDIR(dir->i_mode))
> > -		return -ENOTDIR;
> > +	if (destroy_v2) {
> > +		vol_args2 = memdup_user(arg, sizeof(*vol_args2));
> > +		if (IS_ERR(vol_args2))
> > +			return PTR_ERR(vol_args2);
> >  
> > -	vol_args = memdup_user(arg, sizeof(*vol_args));
> > -	if (IS_ERR(vol_args))
> > -		return PTR_ERR(vol_args);
> > +		if (vol_args2->subvolid == 0) {
> 
> This should be compared >= BTRFS_FIRST_FREE_OBJECTID
> as there are no valid subvolumes with lower id. The exception is the
> toplevel subvolume with id 5 that must not be deletable.

Agreed.

> 
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> >  
> > -	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
> > -	namelen = strlen(vol_args->name);
> > -	if (strchr(vol_args->name, '/') ||
> > -	    strncmp(vol_args->name, "..", namelen) == 0) {
> > -		err = -EINVAL;
> > -		goto out;
> > +		if (!(vol_args2->flags & BTRFS_SUBVOL_BY_ID)) {
> > +			err = -EINVAL;
> > +			goto out;
> 
> The flag validation needs to be factored out of the if. First
> validate,
> then do the rest. For backward compatibility, the v1 ioctl must take
> no
> flags, so if theres BTRFS_SUBVOL_BY_ID for v1, it needs to fail. For
> v2
> the flag is optional.

Only vol_args_v2 has the flags field, so for current
BTRFS_IOC_SNAP_DESTORY there won't be any flags. If we drop the check
for BTRFS_SUBVOL_BY_ID in BTRFS_IOC_SNAP_DESTORY_V2, so won't check for
this flag at all, making it meaningless.

What do you think? Should we drop this flag at all and just rely in the
ioctl number + subvolid being informed?

> 
> > +		}
> > +
> > +		dentry = btrfs_get_dentry(fs_info->sb,
> BTRFS_FIRST_FREE_OBJECTID,
> > +					vol_args2->subvolid, 0, 0);
> > +		if (IS_ERR(dentry)) {
> > +			err = PTR_ERR(dentry);
> > +			goto out;
> > +		}
> > +
> > +		/* 
> 
> There's a trailing space on the line, 'git am' does not allow me to
> apply the patch without removing it manually. Same for the comment
> below.

Done.

> 
> > +		 * change the default parent since the subvolume being
> deleted
> 
> Also please uppercase first letter in comments unless it's an
> identifier. I fix such things but for patches that are going to have
> another iteration it's better to point it out.

Sure.

> 
> > +		 * can be outside of the current mount point
> > +		 */
> > +		parent = btrfs_get_parent(dentry);
> > +
> > +		/* 
> > +		 * the only use of dentry was to get the parent, so we
> can
> > +		 * release it now. Later on the dentry will be queried
> again to
> > +		 * make sure the dentry will reside in the dentry cache
> 
> Can you please rephrase that? I'm not sure I understand.

What do you think about:
      /*
       * At this point dentry->d_name can point to '/' if the
       * subvolume we want to destroy is outsite of the current mount
       * point, so we need to released the current dentry and execute
       * the lookup to return a new one with ->d_name pointing to the
       * <mount point>/subvol_name.
       */


> > +		if (strchr(vol_args->name, '/') ||
>  +		    strncmp(vol_args->name, "..", namelen) == 0) {
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> 
> This sanity check can be unconditional, ie. also done for the v2 even
> in
> the spec-by-id case.

Makes sense.

> 
> > +		name = vol_args->name;
> > +	}
> > +
> > +	if (!S_ISDIR(dir->i_mode)) {
> > +		err = -ENOTDIR;
> > +		goto free_subvol_name;
> >  	}
> >  
> >  	err = mnt_want_write_file(file);
> 
> So this is related to separating the validation. Calling
> mnt_want_write_file must be between flag validation and using the
> dentries and resolving path etc.
> 
> The initial part is ordered like: argument checks, subsystem checks,
> the
> implementation.

Done.

Thanks for your review David. Once I have the flag question clarified I
will sent the v3.


Thanks,
  Marcos

