Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA0107D2B
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2019 06:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfKWF1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Nov 2019 00:27:42 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48160 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWF1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Nov 2019 00:27:42 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C73284EAFB9; Sat, 23 Nov 2019 00:27:41 -0500 (EST)
Date:   Sat, 23 Nov 2019 00:27:41 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
Message-ID: <20191123052741.GJ22121@hungrycats.org>
References: <20191030122301.25270-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+1d8mk/W7pQzMfc7"
Content-Disposition: inline
In-Reply-To: <20191030122301.25270-1-fdmanana@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--+1d8mk/W7pQzMfc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 12:23:01PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Backreference walking, which is used by send to figure if it can issue
> clone operations instead of write operations, can be very slow and use too
> much memory when extents have many references. This change simply skips
> backreference walking when an extent has more than 64 references, in which
> case we fallback to a write operation instead of a clone operation. This
> limit is conservative and in practice I observed no signicant slowdown
> with up to 100 references and still low memory usage up to that limit.
>=20
> This is a temporary workaround until there are speedups in the backref
> walking code, and as such it does not attempt to add extra interfaces or
> knobs to tweak the threshold.
>=20
> Reported-by: Atemu <atemu.main@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgK=
aW3JGp3SGdoinVo=3DC9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492c657=
82be3fa
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 123ac54af071..518ec1265a0c 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -25,6 +25,14 @@
>  #include "compression.h"
> =20
>  /*
> + * Maximum number of references an extent can have in order for us to at=
tempt to
> + * issue clone operations instead of write operations. This currently ex=
ists to
> + * avoid hitting limitations of the backreference walking code (taking a=
 lot of
> + * time and using too much memory for extents with large number of refer=
ences).
> + */
> +#define SEND_MAX_EXTENT_REFS	64
> +
> +/*
>   * A fs_path is a helper to dynamically build path names with unknown si=
ze.
>   * It reallocates the internal buffer on demand.
>   * It allows fast adding of path elements on the right side (normal path=
) and
> @@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *sctx,
>  	struct clone_root *cur_clone_root;
>  	struct btrfs_key found_key;
>  	struct btrfs_path *tmp_path;
> +	struct btrfs_extent_item *ei;
>  	int compressed;
>  	u32 i;
> =20
> @@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *sctx,
>  	ret =3D extent_from_logical(fs_info, disk_byte, tmp_path,
>  				  &found_key, &flags);
>  	up_read(&fs_info->commit_root_sem);
> -	btrfs_release_path(tmp_path);
> =20
>  	if (ret < 0)
>  		goto out;
> @@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *sctx,
>  		goto out;
>  	}
> =20
> +	ei =3D btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
> +			    struct btrfs_extent_item);
> +	/*
> +	 * Backreference walking (iterate_extent_inodes() below) is currently
> +	 * too expensive when an extent has a large number of references, both
> +	 * in time spent and used memory. So for now just fallback to write
> +	 * operations instead of clone operations when an extent has more than
> +	 * a certain amount of references.
> +	 */
> +	if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_REFS) {

So...does this...work?

I ask because I looked at this a few years ago as a way to spend less
time doing LOGICAL_INO calls during dedupe (and especially avoid the
8-orders-of-magnitude performance degradation in the bad cases), but
I found that it was useless: it wasn't proportional to the number of
extents, nor was it an upper or lower bound, nor could extents be sorted
by number of references using extent.refs as a key, nor could it predict
the amount of time it would take for iterate_extent_inodes() to run.
I guess I'm surprised you got a different result.

If the 'refs' field is 1, the extent might have somewhere between 1
and 3500 root/inode/offset references.  But it's not a lower bound,
e.g. here is an extent on a random filesystem where extent_refs is a
big number:

        item 87 key (1344172032 EXTENT_ITEM 4096) itemoff 11671 itemsize 24
                refs 897 gen 2668358 flags DATA

LOGICAL_INO_V2 only finds 170 extent references:

        # btrfs ins log 1344172032 -P . | wc -l
        170

Is there a good primer somewhere on how the reference counting works in
btrfs?

> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +	btrfs_release_path(tmp_path);
> +
>  	/*
>  	 * Setup the clone roots.
>  	 */
> --=20
> 2.11.0
>=20

--+1d8mk/W7pQzMfc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXdjDSgAKCRCB+YsaVrMb
nB4sAKDYYX3LNfeq1Gx1jisgypsOvvfCWgCgk8nDFvbwDbcdz6PY7Jx8shqRYW4=
=mVoi
-----END PGP SIGNATURE-----

--+1d8mk/W7pQzMfc7--
