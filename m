Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CA2BBEF9
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Nov 2020 13:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgKUMik (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Nov 2020 07:38:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:49420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbgKUMik (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Nov 2020 07:38:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A9CBAC23;
        Sat, 21 Nov 2020 12:38:38 +0000 (UTC)
Message-ID: <924da8af43650dd09a6647376c532a786afa2632.camel@suse.de>
Subject: Re: [PATCH v2 2/3] btrfs-progs: inspect: Fix logical-resolve file
 path lookup
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com
Date:   Sat, 21 Nov 2020 09:38:32 -0300
In-Reply-To: <4b38494a-2245-f717-e794-5b3d9c441db7@suse.com>
References: <20201116173249.11847-1-marcos@mpdesouza.com>
         <20201116173249.11847-3-marcos@mpdesouza.com>
         <977d37a3-5240-c5d6-b117-d91f0e5a5f9c@gmx.com>
         <4b38494a-2245-f717-e794-5b3d9c441db7@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-11-20 at 16:43 +0800, Qu Wenruo wrote:
> 
> On 2020/11/20 下午4:32, Qu Wenruo wrote:
> > 
> > On 2020/11/17 上午1:32, Marcos Paulo de Souza wrote:
> > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > 
> > > [BUG]
> > > logical-resolve is currently broken on systems that have a child
> > > subvolume being mounted without access to the parent subvolume.
> > > This is the default for SLE/openSUSE installations. openSUSE has
> > > the
> > > subvolume '@' as the parent of all other subvolumes like /boot,
> > > /home.
> > > The subvolume '@' is never mounted, and accessed, but only it's
> > > child:
> > > 
> > > mount | grep btrfs
> > > /dev/sda2 on / type btrfs
> > > (rw,relatime,ssd,space_cache,subvolid=267,subvol=/@/.snapshots/1/
> > > snapshot)
> > > /dev/sda2 on /opt type btrfs
> > > (rw,relatime,ssd,space_cache,subvolid=262,subvol=/@/opt)
> > > /dev/sda2 on /boot/grub2/i386-pc type btrfs
> > > (rw,relatime,ssd,space_cache,subvolid=265,subvol=/@/boot/grub2/i3
> > > 86-pc)
> > > 
> > > logical-resolve command calls btrfs_list_path_for_root, that
> > > returns the
> > > subvolume full-path that corresponds to the tree id of the
> > > logical
> > > address. As the name implies, the 'full-path' returns all
> > > subvolumes,
> > > starting from '@'. Later on, btrfs_open_dir is calles using the
> > > path
> > > returned, but it fails to resolve it since it contains the '@'
> > > and this
> > > subvolume cannot be accessed.
> > > 
> > > The same problem can be triggered to any user that calls for
> > > logical-resolve on a child subvolume that has the parent
> > > subvolume
> > > not accessible.
> > > 
> > > Another problem in the current approach is that it believes that
> > > a
> > > subvolume will be mounted in a directory with the same name e.g
> > > /@/boot
> > > being mounted in /boot. When this is not true, the code also
> > > fails,
> > > since it uses the subvolume name as the path accessible by the
> > > user.
> > > 
> > > [FIX]
> > > Extent the find_mount_root function by allowing it to check for
> > > mnt_opts
> > > member of mntent struct. Using this new approach we can change
> > > logical-resolve command to search for subvolid=XXX,subvol=YYY.
> > > This is
> > > the two problems stated above by not trusting the subvolume name
> > > being
> > > the mountpoint name, and not following the subvolume tree
> > > blindly.
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > >  cmds/inspect.c | 30 ++++++++++++++++++++++--------
> > >  common/utils.c | 13 +++++++++----
> > >  common/utils.h |  5 ++++-
> > >  3 files changed, 35 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/cmds/inspect.c b/cmds/inspect.c
> > > index 2530b904..0dc62d18 100644
> > > --- a/cmds/inspect.c
> > > +++ b/cmds/inspect.c
> > > @@ -245,15 +245,29 @@ static int
> > > cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
> > >  				path_ptr[-1] = '\0';
> > >  				path_fd = fd;
> > >  			} else {
> > > -				path_ptr[-1] = '/';
> > > -				ret = snprintf(path_ptr, bytes_left,
> > > "%s",
> > > -						name);
> > > -				free(name);
> > > -				if (ret >= bytes_left) {
> > > -					error("path buffer too small:
> > > %d bytes",
> > > -							bytes_left -
> > > ret);
> > > +				char *mounted = NULL;
> > > +				char volid_str[PATH_MAX];
> > > +
> > > +				/*
> > > +				 * btrfs_list_path_for_root returns the
> > > full
> > > +				 * path to the subvolume pointed by
> > > root, but the
> > > +				 * subvolume can be mounted in a
> > > directory name
> > > +				 * different from the subvolume name.
> > > In this
> > > +				 * case we need to find the correct
> > > mountpoint
> > > +				 * using same subvol path and subvol id
> > > found
> > > +				 * before.
> > > +				 */
> > > +				snprintf(volid_str, PATH_MAX,
> > > "subvolid=%llu,subvol=/%s",
> > > +						root, name);
> > > +
> > > +				ret = find_mount_root(full_path,
> > > volid_str,
> > > +						BTRFS_FIND_ROOT_OPTS,
> > > &mounted);
> > > +				if (ret < 0)
> > >  					goto out;
> > > -				}
> > 
> > OK, I see how you utilize the new parameter now.
> > 
> > But considering there is only one user for BTRFS_FIND_ROOT_OPTS, i
> > really hope to not touching the existing callers.
> > Anyway this is just a nitpick, and mostly personal taste.
> > 
> > Another thing is, what if we bind mount a dir of btrfs to another
> > location.
> > Wouldn't this trick the find_mount_root() again?
> > 
> > Personally speaking, we should only permit subvolume entry to be
> > passes
> > to the btrfs-logical-resolve command to avoid such problems.
> 
> Another thing is, if we can't access some subvolume, we just exist
> right
> now, without checking next possible entry.

That's a problem indeed.

> 
> Furthermore, exiting without mentioning that the resolved path is not
> the only path can give user some false illusion, e.g. deleting that
> file
> is ensured to release that logical.
> 
> So at least we should do some prompt to inform the user there is some
> other files referring to the logical bytenr, but we can't access
> right
> now. (Maybe also output the subvolume path and inode)

Yes, this too. I'm reworking the code to check for ENOENT on
find_mount_root and print a message showing inode and subvol path in
the case the subvol is not mounted.

Both issues will be solved in the next version.

Thanks for your review!

> 
> Thanks,
> Qu
> > Thanks,
> > Qu
> > > +
> > > +				strncpy(full_path, mounted, PATH_MAX);
> > > +				free(mounted);
> > > +
> > >  				path_fd = btrfs_open_dir(full_path,
> > > &dirs, 1);
> > >  				if (path_fd < 0) {
> > >  					ret = -ENOENT;
> > > diff --git a/common/utils.c b/common/utils.c
> > > index 1c264455..7e6f406b 100644
> > > --- a/common/utils.c
> > > +++ b/common/utils.c
> > > @@ -1261,8 +1261,6 @@ int find_mount_root(const char *path, const
> > > char *data, u8 flag, char **mount_ro
> > >  	char *cmp_field = NULL;
> > >  	bool found;
> > >  
> > > -	BUG_ON(flag != BTRFS_FIND_ROOT_PATH);
> > > -
> > >  	fd = open(path, O_RDONLY | O_NOATIME);
> > >  	if (fd < 0)
> > >  		return -errno;
> > > @@ -1273,11 +1271,18 @@ int find_mount_root(const char *path,
> > > const char *data, u8 flag, char **mount_ro
> > >  		return -errno;
> > >  
> > >  	while ((ent = getmntent(mnttab))) {
> > > -		cmp_field = ent->mnt_dir;
> > > +		/* BTRFS_FIND_ROOT_PATH is the default behavior */
> > > +		if (flag == BTRFS_FIND_ROOT_OPTS)
> > > +			cmp_field = ent->mnt_opts;
> > > +		else
> > > +			cmp_field = ent->mnt_dir;
> > >  
> > >  		len = strlen(cmp_field);
> > >  
> > > -		found = strncmp(cmp_field, data, len) == 0;
> > > +		if (flag == BTRFS_FIND_ROOT_OPTS)
> > > +			found = strstr(cmp_field, data) != NULL;
> > > +		else
> > > +			found = strncmp(cmp_field, data, len) == 0;
> > >  
> > >  		if (found) {
> > >  			/* match found and use the latest match */
> > > diff --git a/common/utils.h b/common/utils.h
> > > index 449e1d3e..b5d256c6 100644
> > > --- a/common/utils.h
> > > +++ b/common/utils.h
> > > @@ -54,7 +54,10 @@
> > >  
> > >  enum btrfs_find_root_flags {
> > >  	/* check mnt_dir of mntent */
> > > -	BTRFS_FIND_ROOT_PATH = 0
> > > +	BTRFS_FIND_ROOT_PATH = 0,
> > > +
> > > +	/* check mnt_opts of mntent */
> > > +	BTRFS_FIND_ROOT_OPTS
> > >  };
> > >  
> > >  void units_set_mode(unsigned *units, unsigned mode);
> > > 

