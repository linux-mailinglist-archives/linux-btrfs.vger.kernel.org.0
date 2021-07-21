Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10D13D1102
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbhGUNhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 09:37:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53174 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhGUNhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 09:37:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D75C22555;
        Wed, 21 Jul 2021 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626877080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDzJ1uis7E+UcX63Pve5xxmFOUpfNZKT51a+IhaPhQs=;
        b=KF9XdRlHoX5DvQ7rCSDH+di0YNQ3rLbv1YiODj6vHagS8gh3ZbR7GJl2qe3QZJPZ4t/FXz
        7PwKRyfOAM1SDC0nGLrNAh2xDTRds54ObZWPZjYFR5z1erJY0Wnb4r8F760jhqd4Jw7Oht
        GDZWimTbJ0RpOZP1Sb3q5vaRUgGiqA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626877080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDzJ1uis7E+UcX63Pve5xxmFOUpfNZKT51a+IhaPhQs=;
        b=NRRslab+IHnQQahZWUpaXvBzBWtFTrIfTWpiJ+2vEypxKMSerLVwwQ/IiMJnE5h+TKCtTi
        F7Z+4cSQ18q3vHBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0E6C1A3B8A;
        Wed, 21 Jul 2021 14:18:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 947FCDA704; Wed, 21 Jul 2021 16:15:18 +0200 (CEST)
Date:   Wed, 21 Jul 2021 16:15:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 14/21] btrfs/ioctl: allow idmapped
 BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
Message-ID: <20210721141518.GF19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
 <20210719111052.1626299-15-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719111052.1626299-15-brauner@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 19, 2021 at 01:10:45PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Destroying subvolumes and snapshots are important features of btrfs. Both
> operations are available to unprivileged users if the filesystem has been
> mounted with the "user_subvol_rm_allowed" mount option. Allow subvolume and
> snapshot deletion on idmapped mounts. This is a fairly straightforward
> operation since all the permission checking helpers are already capable of
> handling idmapped mounts. So we just need to pass down the mount's userns.
> 
> In addition to regular subvolume or snapshot deletion by specifying the name of
> the subvolume or snapshot the BTRFS_IOC_SNAP_DESTROY_V2 ioctl allows the
> deletion of subvolumes and snapshots via subvolume and snapshot ids when the
> BTRFS_SUBVOL_SPEC_BY_ID flag is raised.
> 
> This feature is blocked on idmapped mounts as this allows filesystem wide
> subvolume deletions and thus can escape the scope of what's exposed under the
> mount identified by the fd passed with the ioctl.
> 
> Here is an example where a btrfs subvolume is deleted through a subvolume mount
> that does not expose the subvolume to be delete but it can still be deleted by
> using the subvolume id:
> 
>  /* Compile the following program as "delete_by_spec". */
> 
>  #define _GNU_SOURCE
>  #include <fcntl.h>
>  #include <inttypes.h>
>  #include <linux/btrfs.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> 
>  static int rm_subvolume_by_id(int fd, uint64_t subvolid)
>  {
>  	struct btrfs_ioctl_vol_args_v2 args = {};
>  	int ret;
> 
>  	args.flags = BTRFS_SUBVOL_SPEC_BY_ID;
>  	args.subvolid = subvolid;
> 
>  	ret = ioctl(fd, BTRFS_IOC_SNAP_DESTROY_V2, &args);
>  	if (ret < 0)
>  		return -1;
> 
>  	return 0;
>  }
> 
>  int main(int argc, char *argv[])
>  {
>  	int subvolid = 0;
> 
>  	if (argc < 3)
>  		exit(1);
> 
>  	fprintf(stderr, "Opening %s\n", argv[1]);
>  	int fd = open(argv[1], O_CLOEXEC | O_DIRECTORY);
>  	if (fd < 0)
>  		exit(2);
> 
>  	subvolid = atoi(argv[2]);
> 
>  	fprintf(stderr, "Deleting subvolume with subvolid %d\n", subvolid);
>  	int ret = rm_subvolume_by_id(fd, subvolid);
>  	if (ret < 0)
>  		exit(3);
> 
>  	exit(0);
>  }
>  #include <stdio.h>"
>  #include <stdlib.h>"
>  #include <linux/btrfs.h"
> 
>  truncate -s 10G btrfs.img
>  mkfs.btrfs btrfs.img
>  export LOOPDEV=$(sudo losetup -f --show btrfs.img)
>  mount ${LOOPDEV} /mnt
>  sudo chown $(id -u):$(id -g) /mnt
>  btrfs subvolume create /mnt/A
>  btrfs subvolume create /mnt/B/C
>  # Get subvolume id via:
>  sudo btrfs subvolume show /mnt/A
>  # Save subvolid
>  SUBVOLID=<nr>
>  sudo umount /mnt
>  sudo mount ${LOOPDEV} -o subvol=B/C,user_subvol_rm_allowed /mnt
>  ./delete_by_spec /mnt ${SUBVOLID}
> 
> With idmapped mounts this can potentially be used by users to delete
> subvolumes/snapshots they would otherwise not have access to as the idmapping
> would be applied to an inode that is not exposed in the mount of the subvolume.
> 
> The fact that this is a filesystem wide operation suggests it might be a good
> idea to expose this under a separate ioctl that clearly indicates this. In
> essence, the file descriptor passed with the ioctl is merely used to identify
> the filesystem on which to operate when BTRFS_SUBVOL_SPEC_BY_ID is used.
> 
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged
> ---
>  fs/btrfs/ioctl.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index be52891ba571..5416b0c0ee7a 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -830,7 +830,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>   *     nfs_async_unlink().
>   */
>  
> -static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
> +static int btrfs_may_delete(struct user_namespace *mnt_userns,
> +			    struct inode *dir, struct dentry *victim, int isdir)
>  {
>  	int error;
>  
> @@ -840,12 +841,12 @@ static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
>  	BUG_ON(d_inode(victim->d_parent) != dir);
>  	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
>  
> -	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
> +	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
>  	if (error)
>  		return error;
>  	if (IS_APPEND(dir))
>  		return -EPERM;
> -	if (check_sticky(&init_user_ns, dir, d_inode(victim)) ||
> +	if (check_sticky(mnt_userns, dir, d_inode(victim)) ||
>  	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
>  	    IS_SWAPFILE(d_inode(victim)))
>  		return -EPERM;
> @@ -2915,6 +2916,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  	struct btrfs_root *dest = NULL;
>  	struct btrfs_ioctl_vol_args *vol_args = NULL;
>  	struct btrfs_ioctl_vol_args_v2 *vol_args2 = NULL;
> +	struct user_namespace *mnt_userns = file_mnt_user_ns(file);
>  	char *subvol_name, *subvol_name_ptr = NULL;
>  	int subvol_namelen;
>  	int err = 0;
> @@ -2942,6 +2944,18 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>  			if (err)
>  				goto out;
>  		} else {
> +			/*
> +			 * Deleting by subvolume id can be used to delete
> +			 * subvolumes/snapshots anywhere in the filesystem.
> +			 * Ensure that users can't abuse idmapped mounts of
> +			 * btrfs subvolumes/snapshots to perform operations in
> +			 * the whole filesystem.
> +			 */
> +			if (mnt_userns != &init_user_ns) {
> +				err = -EINVAL;
> +				goto out;
> +			}

How does this work with CAP_SYS_ADMIN and the root user? This namespace
check is in the preparatory phase, in the actual deletion phase there's
capability(CAP_SYS_ADMIN). A different namespace won't reach that, which
means that it's not possible to delete the subvolume at all.

I read the changelog as it is meant for an unprivileged user, this makes
sense but I don't understand how it's supposed to behave with a root
user in the context of namespaces.

Also -EINVAL is IMHO not the right error code, it's for the cases where
the arguments are invalid, like wrong flags or subvolid. For namespaces
it could be something like EXDEV (but we also have that for reall cross
filesystem subvolume deletion attempt, limited options).
