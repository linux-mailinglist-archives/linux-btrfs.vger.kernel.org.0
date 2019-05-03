Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FAA1350A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfECV46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 17:56:58 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40280 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726727AbfECV46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 17:56:58 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A7B012E0ABD; Fri,  3 May 2019 17:56:42 -0400 (EDT)
Date:   Fri, 3 May 2019 17:56:23 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
Message-ID: <20190503215622.GC20359@hungrycats.org>
References: <20190503010852.10342-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20190503010852.10342-1-wqu@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 09:08:52AM +0800, Qu Wenruo wrote:
> [BUG]
> The following command can lead to unexpected data COW:
>=20
>   #!/bin/bash
>=20
>   dev=3D/dev/test/test
>   mnt=3D/mnt/btrfs
>=20
>   mkfs.btrfs -f $dev -b 1G > /dev/null
>   mount $dev $mnt -o nospace_cache
>=20
>   xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
>   xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
>   umount $dev
>=20
> The result extent will be
>=20
> 	item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
> 		generation 6 type 2 (prealloc)
> 		prealloc data disk byte 13631488 nr 28672
> 	item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
> 		generation 6 type 1 (regular)
> 		extent data disk byte 13660160 nr 12288 <<< COW
> 	item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
> 		generation 6 type 2 (prealloc)
> 		prealloc data disk byte 13631488 nr 28672
>=20
> Currently we always reserve space even for NOCOW buffered write, thus
> under most case it shouldn't cause anything wrong even we fall back to
> COW.
>=20
> However when we're out of data space, we fall back to skip data space if
> we can do NOCOW write.
>=20
> If such behavior happens under that case, we could hit the following
> problems:
> - data space bytes_may_use underflow
>   This will cause kernel warning.
>=20
> - ENOSPC at delalloc time
>   This will lead to transaction abort and fs forced to RO.
>=20
> [CAUSE]
> This is due to the fact that btrfs can only do extent level share check.
>=20
> Btrfs can only tell if an extent is shared, no matter if only part of the
> extent is shared or not.
>=20
> So for above script we have:
> - fallocate
> - buffered write
>   If we don't have enough data space, we fall back to NOCOW check.
>   At this timming, the extent is not shared, we can skip data
>   reservation.
> - reflink
>   Now part of the large preallocated extent is shared.
> - delalloc kicks in
>   For the NOCOW range, as the preallocated extent is shared, we need
>   to fall back to COW.
>=20
> [WORKAROUND]
> The workaround is to ensure any buffered write in the related extents
> (not the reflink source range) get flushed before reflink.
>=20
> However it's pretty expensive to do a comprehensive check.
> In the reproducer, the reflink source is just a part of a larger
> preallocated extent, we need to flush all buffered write of that extent
> before reflink.
> Such backward search can be complex and we may not get much benefit from
> it.
>=20
> So this patch will just try to flush the whole inode before reflink.

Does that mean that if a large file is being written and deduped
simultaneously, that the dedupes would now trigger flushes over the
entire file?  That seems like it could be slow.

e.g. if the file is a big VM image file and it is used src and for dedupe
(which is quite common in VM image files), we'd be hammering the disk
with writes similar to hitting it with fsync() in a tight loop?

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> Flushing an inode just because it's a reflink source is definitely
> overkilling, but I don't have any better way to handle it.
>=20
> Any comment on this is welcomed.
> ---
>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7755b503b348..8caa0edb6fbf 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct file =
*file, struct file *file_src,
>  			return ret;
>  	}
> =20
> +	/*
> +	 * Workaround to make sure NOCOW buffered write reach disk as NOCOW.
> +	 *
> +	 * Due to the limit of btrfs extent tree design, we can only have
> +	 * extent level share view. Any part of an extent is shared then the
> +	 * whole extent is shared and any write into that extent needs to fall
> +	 * back to COW.
> +	 *
> +	 * NOCOW buffered write without data space reserved could to lead to
> +	 * either data space bytes_may_use underflow (kernel warning) or ENOSPC
> +	 * at delalloc time (transaction abort).
> +	 *
> +	 * Here we take a shortcut by flush the whole inode. We could do better
> +	 * by finding all extents in that range and flush the space referring
> +	 * all those extents.
> +	 * But that's too complex for such corner case.
> +	 */
> +	filemap_flush(src->i_mapping);
> +	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> +		     &BTRFS_I(src)->runtime_flags))
> +		filemap_flush(src->i_mapping);
> +
>  	/*
>  	 * Lock destination range to serialize with concurrent readpages() and
>  	 * source range to serialize with relocation.
> --=20
> 2.21.0
>=20

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXMy4zwAKCRCB+YsaVrMb
nKuKAJkBu0NVE3XkA2wzyK0R9HCMqYncMQCgyJosrnyZE5ibpW7yzzQ0B53OOeA=
=R2TX
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
