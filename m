Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB03C3D5875
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhGZKrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 06:47:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:49907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhGZKq7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 06:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627298827;
        bh=LRqAU3IHSSdsK9u768het1/5cBHbyAvmhahk+38vhqI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XvsQNGc3QJmrq66BBtOF9K0pbEpViOvmeTgq9tLeZt5Ps6/kXk7veyB2odh7hMH3I
         CpoDEapQaxoA10LF9/rzmqFsc2fwkpcXMhQ6ayCMrH2kGQe8ebCkhxhNSCc13vc7gz
         R4GA+qI9sd8KPeUhHT8EXsxVbjezVnCwDAa4ckeY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1lGZC40kOw-00rVfp; Mon, 26
 Jul 2021 13:27:06 +0200
Subject: Re: [PATCH v3 14/21] btrfs/ioctl: allow idmapped
 BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210726102816.612434-1-brauner@kernel.org>
 <20210726102816.612434-15-brauner@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2838ba86-456f-31ee-5caa-b5a1a17161d6@gmx.com>
Date:   Mon, 26 Jul 2021 19:26:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726102816.612434-15-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BNhtlnYrE6irhZWYdxsKWMp7D30/aIgo9TlCJreyLwYq2zUUmQD
 R4lTvQJ7I+Fz9oR2TKjwv+xHLtICwJ+isKh17wiAVepaaSHwmuRRBmzSiKuKu3ayKCqNes3
 q/V+YFXNWC9l2/PTs10hMFUN/hKrw6cD9QSeCVoXD1xSCEzHxNmfjRLy10iVubXw3L8N4/u
 T6H25NVdksd7kNkglOyHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rZntVezT6Dg=:uuTi7q9rODXYIoEdCEB6jx
 vJXkM0hWTKJ9WMB7xIaY39IvffCH832t9euiFf17O9ga7hMwai2hwEOSX1ke1RHb3Ae5VlGWR
 6zycYUe33l6DieKSoJSXhxa7DtsWl/faY/akW+MMa/LJRn2eYbQfdgW5FqofDiUjsMZ1SYiF/
 isi1B0fxOKrs+GhyWkAbjSdVURUdGpUQhuuzFhepBQWqtTWA0gaCEn1xcQenmaRCEihw3Fueu
 rg7k5bgOojI1ZdIMc1E/Wo25SPB8JmLVMEkN1FPW5V64ZPiMLeZICqONK1c9HnD6+q8w6Wns5
 FlnGksUZbR/JylAKCxnHMp/zCGC5DjAQ6i+MjZsGW3Z+6fDdjCom7XKbCU9umLYpUAHCOF/Qt
 yuPRjvQ/ar4a3QOyBsq1Wxm/zMzvBlSeYbATiNhzzfJq9n9YSLbOKse7NNmci93yYO7Qzrep2
 croC8ZcB6HCCp6D0heJN0gjXVrYVPQ2oaeZFZ+nXKM7VqgVcNNIriRmGnDpvQNRQQrdzIs647
 0zLQmRz+TYJzsItVN40lhTMFe/Y+HmQGtStZ4x8gdnoB7OlpjDxTHyq7opOKpHomSWxmlUdXD
 GLnAbT88eqoTguC60gy4aRtFpvFTMhkouTGJhsHM5Yk+HE0decdspiuKGKJJdIXK4Uu2LH9Za
 LZG5KfEujEuvRqrFFtY9S8OsadIADlVMvvXc7wX+tVpIjDSVmx0qfndy65LZYb1h9Z6I5KXe6
 Y/J4IilndKHnDqT6qCTXFA9+R4Mgf7l/R10HDHluCa+WyEsVP7CDa2HFE46W+YAVVfQWHfxQD
 OwOSLutHg+MsPFGGdIwCTLmh4v3BYiDoew0u9HYoD6F1zcIjJ9VbXbIGjUItfFtgKDi9HDKng
 UZA8dH8/kxpgZVDSYGM1ktdJDYPNSWzmxopSH6BSxvgE5IZuPty5Q7GgjsrVzkUCdNq/WGTEZ
 UuLrxcPZsDvBtow1cfpqUnL4OEw8q6NI7oM6v+58Z2//W4NmndjstMl1jSXV9hL5sOXBzNHhx
 swi00h9zTNuvl/I+yvbUmDW3PgcIQbwcKuyaxXj0tS4n/gUvVNYER7uFKOVrlAo8Q3H/ssawy
 QqhVMey9Ona8PbQt0XWKLOrmEH3JXtkZ8vaE9M/nL33NvwvAEfgpTao8Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=886:28, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Destroying subvolumes and snapshots are important features of btrfs. Bot=
h
> operations are available to unprivileged users if the filesystem has bee=
n
> mounted with the "user_subvol_rm_allowed" mount option. Allow subvolume =
and
> snapshot deletion on idmapped mounts. This is a fairly straightforward
> operation since all the permission checking helpers are already capable =
of
> handling idmapped mounts. So we just need to pass down the mount's usern=
s.
>
> Subvolumes and snapshots can either be deleted by specifying their name =
or - if
> BTRFS_IOC_SNAP_DESTROY_V2 is used - by their subvolume or snapshot id if=
 the
> BTRFS_SUBVOL_SPEC_BY_ID is set.
>
> This feature is blocked on idmapped mounts as this allows filesystem wid=
e
> subvolume deletions and thus can escape the scope of what's exposed unde=
r the
> mount identified by the fd passed with the ioctl.
>
> As David correctly pointed out this means that even the root or CAP_SYS_=
ADMIN
> capable user can't delete a subvolume via BTRFS_SUBVOL_SPEC_BY_ID. This =
is
> intentional. The root user is currently already subject to permission ch=
ecks in
> btrfs_may_delete() including whether the inode's i_uid/i_gid of the dire=
ctory
> the subvolume is located in have a mapping in the caller's idmapping. Fo=
r this
> to fail isn't currently possible since a btrfs filesystem can't be mount=
ed with
> a non-initial idmapping but it shows that even the root user would fail =
to
> delete a subvolume if the relevant inode isn't mapped in their idmapping=
. The
> idmapped mount case is the same in principle.
>
> This isn't a huge problem a root user wanting to delete arbitrary subvol=
umes
> can just always create another (even detached) mount without an idmappin=
g
> attached.
>
> In addition, we will allow BTRFS_SUBVOL_SPEC_BY_ID for cases where the
> subvolume to delete is directly located under inode referenced by the fd=
 passed
> for the ioctl() in a follow-up commit.
>
> Here is an example where a btrfs subvolume is deleted through a subvolum=
e mount
> that does not expose the subvolume to be delete but it can still be dele=
ted by
> using the subvolume id:
>
>   /* Compile the following program as "delete_by_spec". */
>
>   #define _GNU_SOURCE
>   #include <fcntl.h>
>   #include <inttypes.h>
>   #include <linux/btrfs.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <sys/ioctl.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
>   #include <unistd.h>
>
>   static int rm_subvolume_by_id(int fd, uint64_t subvolid)
>   {
>   	struct btrfs_ioctl_vol_args_v2 args =3D {};
>   	int ret;
>
>   	args.flags =3D BTRFS_SUBVOL_SPEC_BY_ID;
>   	args.subvolid =3D subvolid;
>
>   	ret =3D ioctl(fd, BTRFS_IOC_SNAP_DESTROY_V2, &args);
>   	if (ret < 0)
>   		return -1;
>
>   	return 0;
>   }
>
>   int main(int argc, char *argv[])
>   {
>   	int subvolid =3D 0;
>
>   	if (argc < 3)
>   		exit(1);
>
>   	fprintf(stderr, "Opening %s\n", argv[1]);
>   	int fd =3D open(argv[1], O_CLOEXEC | O_DIRECTORY);
>   	if (fd < 0)
>   		exit(2);
>
>   	subvolid =3D atoi(argv[2]);
>
>   	fprintf(stderr, "Deleting subvolume with subvolid %d\n", subvolid);
>   	int ret =3D rm_subvolume_by_id(fd, subvolid);
>   	if (ret < 0)
>   		exit(3);
>
>   	exit(0);
>   }
>   #include <stdio.h>"
>   #include <stdlib.h>"
>   #include <linux/btrfs.h"
>
>   truncate -s 10G btrfs.img
>   mkfs.btrfs btrfs.img
>   export LOOPDEV=3D$(sudo losetup -f --show btrfs.img)
>   mount ${LOOPDEV} /mnt
>   sudo chown $(id -u):$(id -g) /mnt
>   btrfs subvolume create /mnt/A
>   btrfs subvolume create /mnt/B/C
>   # Get subvolume id via:
>   sudo btrfs subvolume show /mnt/A
>   # Save subvolid
>   SUBVOLID=3D<nr>
>   sudo umount /mnt
>   sudo mount ${LOOPDEV} -o subvol=3DB/C,user_subvol_rm_allowed /mnt
>   ./delete_by_spec /mnt ${SUBVOLID}
>
> With idmapped mounts this can potentially be used by users to delete
> subvolumes/snapshots they would otherwise not have access to as the idma=
pping
> would be applied to an inode that is not exposed in the mount of the sub=
volume.
>
> The fact that this is a filesystem wide operation suggests it might be a=
 good
> idea to expose this under a separate ioctl that clearly indicates this. =
In
> essence, the file descriptor passed with the ioctl is merely used to ide=
ntify
> the filesystem on which to operate when BTRFS_SUBVOL_SPEC_BY_ID is used.
>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> /* v2 */
> unchanged
>
> /* v3 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>    - Explain the restriction for the BTRFS_SUBVOL_SPEC_BY_ID flag in det=
ail.k
>
> - David Sterba <dsterba@suse.com>:
>    - Replace the -EINVAL return value for BTRFS_SUBVOL_SPEC_BY_ID deleti=
on
>      requests with a more sensible one such as -EXDEV or -EOPNOTSUPP.
> ---
>   fs/btrfs/ioctl.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index be52891ba571..488e2395034f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -830,7 +830,8 @@ static int create_snapshot(struct btrfs_root *root, =
struct inode *dir,
>    *     nfs_async_unlink().
>    */
>
> -static int btrfs_may_delete(struct inode *dir, struct dentry *victim, i=
nt isdir)
> +static int btrfs_may_delete(struct user_namespace *mnt_userns,
> +			    struct inode *dir, struct dentry *victim, int isdir)
>   {
>   	int error;
>
> @@ -840,12 +841,12 @@ static int btrfs_may_delete(struct inode *dir, str=
uct dentry *victim, int isdir)
>   	BUG_ON(d_inode(victim->d_parent) !=3D dir);
>   	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
>
> -	error =3D inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
> +	error =3D inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
>   	if (error)
>   		return error;
>   	if (IS_APPEND(dir))
>   		return -EPERM;
> -	if (check_sticky(&init_user_ns, dir, d_inode(victim)) ||
> +	if (check_sticky(mnt_userns, dir, d_inode(victim)) ||
>   	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
>   	    IS_SWAPFILE(d_inode(victim)))
>   		return -EPERM;
> @@ -2915,6 +2916,7 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>   	struct btrfs_root *dest =3D NULL;
>   	struct btrfs_ioctl_vol_args *vol_args =3D NULL;
>   	struct btrfs_ioctl_vol_args_v2 *vol_args2 =3D NULL;
> +	struct user_namespace *mnt_userns =3D file_mnt_user_ns(file);
>   	char *subvol_name, *subvol_name_ptr =3D NULL;
>   	int subvol_namelen;
>   	int err =3D 0;
> @@ -2942,6 +2944,18 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>   			if (err)
>   				goto out;
>   		} else {
> +			/*
> +			 * Deleting by subvolume id can be used to delete
> +			 * subvolumes/snapshots anywhere in the filesystem.
> +			 * Ensure that users can't abuse idmapped mounts of
> +			 * btrfs subvolumes/snapshots to perform operations in
> +			 * the whole filesystem.
> +			 */
> +			if (mnt_userns !=3D &init_user_ns) {
> +				err =3D -EOPNOTSUPP;
> +				goto out;
> +			}
> +
>   			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
>   				err =3D -EINVAL;
>   				goto out;
> @@ -3026,7 +3040,8 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>   	err =3D down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
>   	if (err =3D=3D -EINTR)
>   		goto free_subvol_name;
> -	dentry =3D lookup_one_len(subvol_name, parent, subvol_namelen);
> +	dentry =3D lookup_mapped_one_len(mnt_userns, subvol_name,
> +				       parent, subvol_namelen);
>   	if (IS_ERR(dentry)) {
>   		err =3D PTR_ERR(dentry);
>   		goto out_unlock_dir;
> @@ -3068,14 +3083,14 @@ static noinline int btrfs_ioctl_snap_destroy(str=
uct file *file,
>   		if (root =3D=3D dest)
>   			goto out_dput;
>
> -		err =3D inode_permission(&init_user_ns, inode,
> +		err =3D inode_permission(mnt_userns, inode,
>   				       MAY_WRITE | MAY_EXEC);
>   		if (err)
>   			goto out_dput;
>   	}
>
>   	/* check if subvolume may be deleted by a user */
> -	err =3D btrfs_may_delete(dir, dentry, 1);
> +	err =3D btrfs_may_delete(mnt_userns, dir, dentry, 1);
>   	if (err)
>   		goto out_dput;
>
>
