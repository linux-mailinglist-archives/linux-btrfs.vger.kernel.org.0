Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCE3D5885
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhGZKu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 06:50:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:60725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233490AbhGZKu5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 06:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627299072;
        bh=CKbJVaoviPEHXdMIjT2QvkzXJYv32sANT6n7DsAek9w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I+1xLtLNf+yicptEftFTQIzSovH923PryPh7OwOmet65yyfa2P0qiQKiocn59/1XU
         38f15M5Wd3ynxqHUfYA49c9K7e3gv8rrOeSVsktiB2w0x14LkaG42wnmkFQanggGYl
         2E61/wyDkIOLBoAnqjLkv36vt1IPmLXO/BeyrByI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1lWR55462K-00bcdn; Mon, 26
 Jul 2021 13:31:12 +0200
Subject: Re: [PATCH v3 15/21] btrfs/ioctl: relax restrictions for
 BTRFS_IOC_SNAP_DESTROY_V2 with subvolids
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210726102816.612434-1-brauner@kernel.org>
 <20210726102816.612434-16-brauner@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a4931bab-c299-3aa0-a700-5b5e8b61f040@gmx.com>
Date:   Mon, 26 Jul 2021 19:31:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726102816.612434-16-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kJQ0bWrXklk72ni00g51kJ1L+jl//0oVJdh/akFXuB3bTDDv/PC
 Csmou5p+C2oNVXx4kNo5GYu1KVZUFp7ep7N3vXo+jlSDebdiExa6OP+SoY3yfm1irpX98Vb
 KCveJ+uDEQ6qdpHtqO6kgPjAlTmuzVEBlP0Y4ODtOdkDoOA5Qet5C0xaglrKBAQBwxxP44r
 wT2gpsB37iXOZFfBZQNYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h5mHytZOqjI=:CZVHXXyGtBPQ9vLc0TJVsG
 qqYFhmWPUFnRAFhop6GFYEN7Ei/swlMrcZMqH4bGaih2a0E/wJ3oiEGhVjhP0IQPflGCt+Yxj
 ytV3XXk3GRrk1oJZLrifc2ejkgfc1tmaQYAxaW5GPAjNFgyvFbOtwqFBr9IXhvBucJ2ZG2S/F
 9rRWVkD0wEknoICZ7JS1Z6WgY+5q2S1embj6NuvAPMt1yoPdQZ+TYWWipmEJBCxJQk307x+nW
 W11NWxwecjfszhlmXoBDoOyj8BdvEoC8b4Z/9Ga8Wt71DdZKShdTR3Njue1AXbr4XJ7VjOaoJ
 p47hqB0BfUfMoTqFB5wiibIMw+2bOacCehjl7n6+wNR5hOiLkvjocz3yYb3tBglXbcX+FRamm
 8AtKv2OreKgkfURYk+cSNgclzu9aKakLQXTXDop0fXAt7niKdhAUYjuRCHPlJO5FF11G58YEk
 nouRQenAqIDRReSz77anb9xbq9YqjzggYhRNtVrCd/XSfWi+lMA3iigPYFXoAaE6C5j1yEDj1
 CstFKDyS9eD/VCDbOuoxhLDiJydyx4zVqwShlplv0hsli1DW/HC4UfjOCHExhbHQPDKwAV1x7
 WyWBfCNOhpWDORag91eJqxpnACIFksH7kMDVIRO46JqMYoJhx9CScZufrVFFLjSkmk6QHt+bC
 bMDlJv2eCHoM9rHQB8z4fsSw4fqoDSKUJfshDXbpDWPhJdEGyUFdfaKSZmkRYZHMCiwiavhi2
 Sbsm/207Vhiiu79hm0cU+SooXr/zCb7htCoEwYhwIP/N+uyLYCp1hZ5s4hik6NSUKVHrctik2
 ornq4jkZkapimhwjo6klviSp35kT29a1QdPhODkO4laUn3OAy4SaFGzWeq0RnwpW1E/Vh2CTD
 1wMQL7q+Bb3OP3//0SGzmtS/cFxldvuPkLtU407UpDYau7xIeXnABCUtbeoDztyyWfQWpCQGN
 F7sx+KPoW1GfHogitKaIodUjvOWqkT9tUnIYXEyr11WJEbfkUXTIOXRFVOXRZPK2XnsCJ/R3M
 EcTSWq58i/xuEx5gQ2H+iJjyW7Boz94MhOtOz8/+9qMsx66TnLud/1AzMEsVED+YlERliAHjz
 KocsWCBXN/SIQ84KmViQ0OpB8k32wjcJbs1VCyEoj+nntLMMjnt1/bubw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=886:28, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> So far we prevented the deletion of subvolumes and snapshots using subvo=
lume
> ids possible with the BTRFS_SUBVOL_SPEC_BY_ID flag.
> This restriction is necessary on idmapped mounts as this allows filesyst=
em wide
> subvolume and snapshot deletions and thus can escape the scope of what's
> exposed under the mount identified by the fd passed with the ioctl.
>
> Deletion by subvolume id works by looking for an alias of the parent of =
the
> subvolume or snapshot to be deleted. The parent alias can be anywhere in=
 the
> filesystem. However, as long as the alias of the parent that is found is=
 the
> same as the one identified by the file descriptor passed through the ioc=
tl we
> can allow the deletion.
>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Reviewed-by: Josef Bacik <josef@toxicpanda.com> > Signed-off-by: Christi=
an Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I'm wondering if there is any special use case for this relaxed
subvolid deletion?

As for most subvolume deletion it's from btrfs-progs, which has extra
path lookup before calling the ioctl (even for subvolid id deletion).

Thus I guess the relaxed check is only for direct ioctl call for
subvolume deletion?

Thanks,
Qu

> ---
> /* v2 */
> unchanged
>
> /* v3 */
> unchanged
> ---
>   fs/btrfs/ioctl.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 488e2395034f..b9864d63ffbf 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2944,17 +2944,7 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>   			if (err)
>   				goto out;
>   		} else {
> -			/*
> -			 * Deleting by subvolume id can be used to delete
> -			 * subvolumes/snapshots anywhere in the filesystem.
> -			 * Ensure that users can't abuse idmapped mounts of
> -			 * btrfs subvolumes/snapshots to perform operations in
> -			 * the whole filesystem.
> -			 */
> -			if (mnt_userns !=3D &init_user_ns) {
> -				err =3D -EOPNOTSUPP;
> -				goto out;
> -			}
> +			struct inode *old_dir;
>
>   			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
>   				err =3D -EINVAL;
> @@ -2992,6 +2982,7 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>   				err =3D PTR_ERR(parent);
>   				goto out_drop_write;
>   			}
> +			old_dir =3D dir;
>   			dir =3D d_inode(parent);
>
>   			/*
> @@ -3002,6 +2993,20 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>   			 */
>   			destroy_parent =3D true;
>
> +			/*
> +			 * On idmapped mounts, deletion via subvolid is
> +			 * restricted to subvolumes that are immediate
> +			 * ancestors of the inode referenced by the file
> +			 * descriptor in the ioctl. Otherwise the idmapping
> +			 * could potentially be abused to delete subvolumes
> +			 * anywhere in the filesystem the user wouldn't be able
> +			 * to delete without an idmapped mount.
> +			 */
> +			if (old_dir !=3D dir && mnt_userns !=3D &init_user_ns) {
> +				err =3D -EOPNOTSUPP;
> +				goto free_parent;
> +			}
> +
>   			subvol_name_ptr =3D btrfs_get_subvol_name_from_objectid(
>   						fs_info, vol_args2->subvolid);
>   			if (IS_ERR(subvol_name_ptr)) {
>
