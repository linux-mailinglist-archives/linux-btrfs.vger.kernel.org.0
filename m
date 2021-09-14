Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778BC40AACB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhINJ1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:27:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:59925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhINJ1G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631611546;
        bh=Usk8J37CGAQ2nk8QMd0wdWstrRNXxRKuToSR6J5X56o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=X4zkBeQSks4dZLGOXvohq5X2/hBF4hzyiV5s7tM+srJMJLlqQJ1SpmI60rTGeJMGY
         HjNI3Sp1k7gn6ZVSq2hxIez9syr6+ilLSn4LhVtp2yYMvTuyOSrgghgmLf80dKFc62
         4Mrn4C1rZxXVbj3cxb96ai9xIKF3AjGSywb74To4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4z6k-1mrbyf2ubU-010xgk; Tue, 14
 Sep 2021 11:25:46 +0200
Subject: Re: [PATCH v2 7/8] btrfs-progs: check: Implement removing received
 data for RW subvols
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <20210914090558.79411-8-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <15295190-51cb-7fff-c9dd-1f604a177064@gmx.com>
Date:   Tue, 14 Sep 2021 17:25:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914090558.79411-8-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SYsodzPe3it8oBz+taZwCHl1dTgo0aoKcc7YjRBo+khveRr/43Q
 f7Jfz4T7CGe9Y25CVpgAjDKSzRbQ4gQCpHHAva+lijE8ptpdkst0OO0dkGS2Uqn08vEAeuG
 /u2G0mwT2Nq2XeuXtMmd4k5gPU5K75+WvXpTNtiir7uSqH7LTe9jD99FDwg3SREk0E3wKlw
 asPSsPKy+qrPjchqx+qRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LPisTfUS/Ew=:IbRFc9WTV20w7G+dHwwamK
 annJr+pwy4HvRc+BkgyaDo2FM04gCgENygC9aDhdO3XiJUbo89fQqHSKFmwHoAKQs74bX4wmL
 5V3OvbW9SdYGu1cd2ZbUONFQQ0V4aU+rMIxQrpGbphmfAliA1elMB/mPcAVRkib0AicXUAyQo
 JicB9PBLG/znYM16bafBV6mKfCKwnnXHUYNP2tT5ySU34CQ2qsNINrfai5H0PLRgQ0Xr090md
 NGGE9qEVMZh1U7LfGVR0oyPC77UJZ7ltgm9xt7Hd4CYoQmHkQrfVFImDD41IZSSMohlOx9jMV
 3Zu9lC1ZQy25B8iQqB2uYSk0cRb1fTNesAeG28GFDwokItrSC4SRmitrZEKKOAL4sQXG9PWrY
 6Sxj1Zpt6kOVh/y5Mt7GQDzAA/rv617uXRs3k9JTdxstJxI+enylUotd+VjEgZ7sMaN2vREA4
 JemMvrh0ogqXJQJum9wZugSUCCsLsKK+ufvsIwTFwMXPbCGorrObd1QBgCRbksvGr4a8fgBA8
 fsetKjQfUk45zzBYtusam17iWyXXOC1W+LKz/fLPvnvTnAGFnkWU2WeQbmfLW6cwx76qcESHz
 FOngAEuWuKB2slGfF21ix304112McXh4YqmNpq2iK4ptTz6y5DQ0dIAR/Sy3CX5n2gfWbw4ZB
 iEAbX9n/RbeX3JuoBEUSq7aRpxABrNtTJTL8tWd+VEgL7ni8Xj+zY9BQo0kFOrA9QbEyg7dmh
 9CWUuQXF1gnRPyzhNcbqm/ubbbL5mzFwegq37lB8APGSxKrkdgDc5MQwcH8Ka/tk/lHrBrvbk
 2r8v1VRrOG0OL2WhfyJFZ1LtUvSDDPCYGMXgNVDIWhS2E3kT6aziUFtu/jCoHL8JdBLaCgjf1
 Xz7xdcz3RE2wpQ45GtXxcLC9OM7sVTXfAE2XU/pWrPe6mx9XoA3UgT4jQAyEIEOfU6rXOc1wt
 zJNeW8ghh0AVP/I+Pxd33xWSwaqVPoC77JYCBEWGR/h2pp62Q/1ikQgVWsn7GIB8KPbieUZ6P
 /Mu2lqJy9yaGNpO+pq3pE4Y2FzAe5z1EVKHHnpZjgQ5nt76M3K5j8Sj7KjI1x94+FTnQeHdnx
 eXI5Fx3cyK4+DY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8B=E5=8D=885:05, Nikolay Borisov wrote:
> Making a received subvolume RO should preclude doing an incremental send
> of said subvolume since it can't be guaranteed that nothing changed in
> the structure and this in turn has correctness implications for send.
>
> There is a pending kernel change that implements this behavior and
> ensures that in the future RO volumes which are switched to RW can't be
> used for incremental send. However, old kernels won't have that patch
> backported. To ensure there is a supported way for users to put their
> subvolumes in sane state let's implement the same functionality in
> progs.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   check/main.c        | 16 +++++++++++++++-
>   check/mode-lowmem.c | 11 ++++++++++-
>   2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index 6369bdd90656..9d3822a2ebae 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -3544,6 +3544,7 @@ static int check_fs_root(struct btrfs_root *root,
>   	int ret =3D 0;
>   	int err =3D 0;
>   	bool generation_err =3D false;
> +	bool rw_received_err =3D false;
>   	int wret;
>   	int level;
>   	u64 super_generation;
> @@ -3658,6 +3659,19 @@ static int check_fs_root(struct btrfs_root *root,
>   					sizeof(found_key)));
>   	}
>
> +	if (!((btrfs_root_flags(root_item) & BTRFS_ROOT_SUBVOL_RDONLY) ||
> +			btrfs_is_empty_uuid(root_item->received_uuid))) {
> +		error("Subvolume id: %llu is RW and has a received uuid",
> +				root->root_key.objectid);
> +		rw_received_err =3D true;
> +		if (repair) {
> +			ret =3D repair_received_subvol(root);
> +			if (ret)
> +				return ret;
> +			rw_received_err =3D false;
> +		}
> +	}
> +
>   	while (1) {
>   		ctx.item_count++;
>   		wret =3D walk_down_tree(root, &path, wc, &level, &nrefs);
> @@ -3722,7 +3736,7 @@ static int check_fs_root(struct btrfs_root *root,
>
>   	free_corrupt_blocks_tree(&corrupt_blocks);
>   	gfs_info->corrupt_blocks =3D NULL;
> -	if (!ret && generation_err)
> +	if (!ret && (generation_err ||  rw_received_err))
>   		ret =3D -1;
>   	return ret;
>   }
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 323e66bc4cb1..d8f783bea424 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -5197,8 +5197,17 @@ static int check_btrfs_root(struct btrfs_root *ro=
ot, int check_all)
>   		ret =3D check_fs_first_inode(root);
>   		if (ret < 0)
>   			return FATAL_ERROR;
> -	}
>
> +		if (!((btrfs_root_flags(root_item) & BTRFS_ROOT_SUBVOL_RDONLY) ||
> +					btrfs_is_empty_uuid(root_item->received_uuid))) {
> +			error("Subvolume id: %llu is RW and has a received uuid",
> +				  root->root_key.objectid);
> +			if (repair)
> +				ret =3D repair_received_subvol(root);
> +			if (ret < 0)
> +				return FATAL_ERROR;
> +		}

Not sure if we need to error out completely.

I guess continue the check would be better?

Despite that, everything looks good to me.

Thanks,
Qu
> +	}
>
>   	level =3D btrfs_header_level(root->node);
>   	btrfs_init_path(&path);
>
