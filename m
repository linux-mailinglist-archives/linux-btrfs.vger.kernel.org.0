Return-Path: <linux-btrfs+bounces-10360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06899F17A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 21:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B4F16BBB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A9191F83;
	Fri, 13 Dec 2024 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SZELDXGZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361918F2D8
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123179; cv=none; b=fWSNUV81+TlIlT0YT0FfGMEPaI3bvbm2Xc8LSV7bBVUOHFZJpGbpkFQldvOm2dGU08uKbHiUx+HxCEciYf+0/VWJpbNhkfKWjgNe3YYs57QLeWob0jD2eSkX43usmPL9Pe6rNqoT+WlfVlDQMSFMaX+I2IAIjeM3Ptl+7NYaa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123179; c=relaxed/simple;
	bh=ydhA2R7ogDdTZwE+K+22fVcKvqxrFg56hBPOs8t36jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tke8vQfdYABoNJ7/xfvmcyOVOVeV6OsuTFYcags0p8vhf0tOYoSeNdaQNHcSRAgsr6bLdANSViiM7GIHRRS97n0gNyuckKZCjOtJnypBTkDLGb7HHE4jYFAz/4Bl+LjX3d+3eLr9pIhYUuxJnjLAeajii88KMhfMm7zEwwBbaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SZELDXGZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734123169; x=1734727969; i=quwenruo.btrfs@gmx.com;
	bh=MYAtu8R0Mk7s831eEgN9BbzqGEcdqAPKzRiJfJLLe8s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SZELDXGZq67wpv4I314zUM9iXXZCK/DF7YiNiuSGtH8Hk0b6T49oKTQAtpJrNz2I
	 UlkpzLWzfxG5vWfhPui5GmsfVVwjdxcXnSBQEKovUViMi4SJ2xqZOWU1q728uKcIo
	 2oPm5LpJ/Z1zt5ViwgYRQDjuMbmMMBjqooZEH3riOg/I0xSKYsJPl7QBGimnzxWSL
	 OLryGnpwKjksx4ACdI3b3GyyTlsC1eaI9/9sZAp5Y3mVQHI4DgFR+8g+FSm+oVgnl
	 NiGwvYiByYzZGMBb+AI+cNHBQDAQ7oVXImdAy6EXe+s2Aago4Fr3kMRSEUrX70iSl
	 6fn3iR9crqzKykhZMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDywu-1tTvsa1mYm-0096Ne; Fri, 13
 Dec 2024 21:52:49 +0100
Message-ID: <c0fe6584-7339-4bc3-8e58-6a33626657b3@gmx.com>
Date: Sat, 14 Dec 2024 07:22:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] btrfs: fix swap file activation failure due to
 extents that used to be shared
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1733929327.git.fdmanana@suse.com>
 <bda8a1de78c3d938a71a816401f96f0e0d6c3f72.1733929328.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <bda8a1de78c3d938a71a816401f96f0e0d6c3f72.1733929328.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rOQOFBU9cliW+O/TqKZfQYZceg6nqZUNPOSqRb8oVUOL4x+S8vD
 Q9LrFItnWa/UqCev/ERqiW0kEDDuViw4TLbs49sxcUGtD3cNMJNbe9eKkvEyvf8upjCZTHs
 jwgEqWsrZDee6/tZmw2BI0lQOioQVA8k++yR5CzxVCjQecdvEdm2+cnNxWnFRd337xVfEal
 zl1CuVkC8lzqWVnd3ovJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fqkVKmjrX8w=;CgJr+i8ylPYH+te9Exns9/Zm+cn
 x3mfcldLukOY+jsFF/sBtigXMGAjvfW/XSkbJhUG8Kfp3SOwIQamWLzSqoFdsUZuOkPALLMsN
 l7logulxhOA0J6a1EqcmVYT0d2nUfMT81QtWfEhHlUBISGGOpJ8GQxAdzXtZ2iGIofyQrnpdE
 QRPzQ+XA0SXOVwLS8PteKaJyPORyZvgLm0RGEu+cZMCGF8m5cVF+ZnWDSQjo6gEfu88IEPJn2
 yqpE1sOsLHVrGOVv+NB7dBYW0VNsi5EIv3eML44bKPU/oPlazFhmn0Bx4c3No8qCq+3PVfrOT
 L/bL4mibjqpkJV3G+XC69JBpA6Q737nOE4ihnLIiVR1sfZqmTVm8W6GxgzGT3wC9l/fIKmFbd
 bHZC+K3EgkREbIqrwgSjAXRa/EgGoz3BH07UD8wEgVxBECGP1wFykHr40Uf8MtUdw0/xZlDVN
 EEN1gYrl5a9FmYIPnvZh78B4R5fM8LGsCdgnFP/Hf3yR6f+zSHuSxZxghRJER5jr07CELd0hi
 AMya1cUhvxXqjJGJ06z9rycsGR2d1lWppBXTybEqQLJP4zLySocgiwwq3JNc2WxOv2/0gYSsE
 ju7wzbXt164ZqFS6bQO/DSzqgxaNiLJVPwUhJa+lmbDz6edAlHTMmWr528KJrUc8GPL9u9p/o
 eJOtN4Sc1EEfBs27DoxRS2LV44FgcZ40YJLrIF0tJ5kcnArSCvCAOppwlF1VjcDYJZbQ560wO
 YD2mmH8J7YcdcVmWVKG4EsZjgogZMXRwcz6oL0zkuNCOE2tEHHCzLyJvDne7HKtbv5jN+Bwpr
 7fRFaO7e9DnOjLdWf14o+6UTIvxS72AtWXCVwZaFpkK/8xE+P1SaHKKEZzZ+p1RTPhJOCoTDu
 8AAq5f2wjzEI6wImbs8fsRHAbmOI0QFxiJYo8r3FXbVZGSN3oPJP/YmgGRVRhKb7Yq/4u6koZ
 iLjaW5pAcv+wwa60YgU0VOcxAPubywfaB6Qf5JL+TuNFVuf+VTXa2+pvbIbor7/Ez7V7TBkLn
 zsd5QvNkVVDyzK6/e0od1exLTig/yhKkG+0qjv/PUoLiqvUWpBR6wQM6IqLDYtb2pHSnVKjGz
 5bpUvodbdQBPkvj8p5db71FJrPZnMF



=E5=9C=A8 2024/12/12 01:34, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When activating a swap file, to determine if an extent is shared we use
> can_nocow_extent(), which ends up at btrfs_cross_ref_exist(). That helpe=
r
> is meant to be quick because it's used in the NOCOW write path, when
> flushing delalloc and when doing a direct IO write, however it does retu=
rn
> some false positives, meaning it may indicate that an extent is shared
> even if it's no longer the case. For the write path this is fine, we jus=
t
> do a unnecessary COW operation instead of doing a more rigorous check
> which would be too heavy (calling btrfs_is_data_extent_shared()).
>
> However when activating a swap file, the false positives simply result
> in a failure, which is confusing for users/applications. One particular
> case where this happens is when a data extent only has 1 reference but
> that reference is not inlined in the extent item located in the extent
> tree - this happens when we create more than 33 references for an extent
> and then delete those 33 references plus every other non-inline referenc=
e
> except one. The function check_committed_ref() assumes that if the size
> of an extent item doesn't match the size of struct btrfs_extent_item
> plus the size of an inline reference (plus an owner reference in case
> simple quotas are enabled), then the extent is shared - that is not the
> case however, we can have a single reference but it's not inlined - the
> reason we do this is to be fast and avoid inspecting non-inline referenc=
es
> which may be located in another leaf of the extent tree, slowing down
> write paths.
>
> The following test script reproduces the bug:
>
>     $ cat test.sh
>     #!/bin/bash
>
>     DEV=3D/dev/sdi
>     MNT=3D/mnt/sdi
>     NUM_CLONES=3D50
>
>     umount $DEV &> /dev/null
>
>     run_test()
>     {
>          local sync_after_add_reflinks=3D$1
>          local sync_after_remove_reflinks=3D$2
>
>          mkfs.btrfs -f $DEV > /dev/null
>          #mkfs.xfs -f $DEV > /dev/null
>          mount $DEV $MNT
>
>          touch $MNT/foo
>          chmod 0600 $MNT/foo
>     	# On btrfs the file must be NOCOW.
>          chattr +C $MNT/foo &> /dev/null
>          xfs_io -s -c "pwrite -b 1M 0 1M" $MNT/foo
>          mkswap $MNT/foo
>
>          for ((i =3D 1; i <=3D $NUM_CLONES; i++)); do
>              touch $MNT/foo_clone_$i
>              chmod 0600 $MNT/foo_clone_$i
>              # On btrfs the file must be NOCOW.
>              chattr +C $MNT/foo_clone_$i &> /dev/null
>              cp --reflink=3Dalways $MNT/foo $MNT/foo_clone_$i
>          done
>
>          if [ $sync_after_add_reflinks -ne 0 ]; then
>              # Flush delayed refs and commit current transaction.
>              sync -f $MNT
>          fi
>
>          # Remove the original file and all clones except the last.
>          rm -f $MNT/foo
>          for ((i =3D 1; i < $NUM_CLONES; i++)); do
>              rm -f $MNT/foo_clone_$i
>          done
>
>          if [ $sync_after_remove_reflinks -ne 0 ]; then
>              # Flush delayed refs and commit current transaction.
>              sync -f $MNT
>          fi
>
>          # Now use the last clone as a swap file. It should work since
>          # its extent are not shared anymore.
>          swapon $MNT/foo_clone_${NUM_CLONES}
>          swapoff $MNT/foo_clone_${NUM_CLONES}
>
>          umount $MNT
>     }
>
>     echo -e "\nTest without sync after creating and removing clones"
>     run_test 0 0
>
>     echo -e "\nTest with sync after creating clones"
>     run_test 1 0
>
>     echo -e "\nTest with sync after removing clones"
>     run_test 0 1
>
>     echo -e "\nTest with sync after creating and removing clones"
>     run_test 1 1
>
> Running the test:
>
>     $ ./test.sh
>     Test without sync after creating and removing clones
>     wrote 1048576/1048576 bytes at offset 0
>     1 MiB, 1 ops; 0.0017 sec (556.793 MiB/sec and 556.7929 ops/sec)
>     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
>     no label, UUID=3Da6b9c29e-5ef4-4689-a8ac-bc199c750f02
>     swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
>     swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
>
>     Test with sync after creating clones
>     wrote 1048576/1048576 bytes at offset 0
>     1 MiB, 1 ops; 0.0036 sec (271.739 MiB/sec and 271.7391 ops/sec)
>     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
>     no label, UUID=3D5e9008d6-1f7a-4948-a1b4-3f30aba20a33
>     swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
>     swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
>
>     Test with sync after removing clones
>     wrote 1048576/1048576 bytes at offset 0
>     1 MiB, 1 ops; 0.0103 sec (96.665 MiB/sec and 96.6651 ops/sec)
>     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
>     no label, UUID=3D916c2740-fa9f-4385-9f06-29c3f89e4764
>
>     Test with sync after creating and removing clones
>     wrote 1048576/1048576 bytes at offset 0
>     1 MiB, 1 ops; 0.0031 sec (314.268 MiB/sec and 314.2678 ops/sec)
>     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
>     no label, UUID=3D06aab1dd-4d90-49c0-bd9f-3a8db4e2f912
>     swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
>     swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
>
> Fix this by reworking btrfs_swap_activate() to instead of using extent
> maps and checking for shared extents with can_nocow_extent(), iterate
> over the inode's file extent items and use the accurate
> btrfs_is_data_extent_shared().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

The patch looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>


Although there is no mention about why we get rid of btrfs_get_extent().

I guess it's to avoid caching those extent maps to save space? Just like
what we did in fiemap.

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 96 ++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 69 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 926d82fbdbae..7ddb8a01b60f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9799,15 +9799,16 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>   	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
>   	struct extent_state *cached_state =3D NULL;
> -	struct extent_map *em =3D NULL;
>   	struct btrfs_chunk_map *map =3D NULL;
>   	struct btrfs_device *device =3D NULL;
>   	struct btrfs_swap_info bsi =3D {
>   		.lowest_ppage =3D (sector_t)-1ULL,
>   	};
> +	struct btrfs_backref_share_check_ctx *backref_ctx =3D NULL;
> +	struct btrfs_path *path =3D NULL;
>   	int ret =3D 0;
>   	u64 isize;
> -	u64 start;
> +	u64 prev_extent_end =3D 0;
>
>   	/*
>   	 * Acquire the inode's mmap lock to prevent races with memory mapped
> @@ -9846,6 +9847,13 @@ static int btrfs_swap_activate(struct swap_info_s=
truct *sis, struct file *file,
>   		goto out_unlock_mmap;
>   	}
>
> +	path =3D btrfs_alloc_path();
> +	backref_ctx =3D btrfs_alloc_backref_share_check_ctx();
> +	if (!path || !backref_ctx) {
> +		ret =3D -ENOMEM;
> +		goto out_unlock_mmap;
> +	}
> +
>   	/*
>   	 * Balance or device remove/replace/resize can move stuff around from
>   	 * under us. The exclop protection makes sure they aren't running/won=
't
> @@ -9904,24 +9912,39 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
>   	isize =3D ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
>
>   	lock_extent(io_tree, 0, isize - 1, &cached_state);
> -	start =3D 0;
> -	while (start < isize) {
> -		u64 logical_block_start, physical_block_start;
> +	while (prev_extent_end < isize) {
> +		struct btrfs_key key;
> +		struct extent_buffer *leaf;
> +		struct btrfs_file_extent_item *ei;
>   		struct btrfs_block_group *bg;
> -		u64 len =3D isize - start;
> +		u64 logical_block_start;
> +		u64 physical_block_start;
> +		u64 extent_gen;
> +		u64 disk_bytenr;
> +		u64 len;
>
> -		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
> -		if (IS_ERR(em)) {
> -			ret =3D PTR_ERR(em);
> +		key.objectid =3D btrfs_ino(BTRFS_I(inode));
> +		key.type =3D BTRFS_EXTENT_DATA_KEY;
> +		key.offset =3D prev_extent_end;
> +
> +		ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +		if (ret < 0)
>   			goto out;
> -		}
>
> -		if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE) {
> +		/*
> +		 * If key not found it means we have an implicit hole (NO_HOLES
> +		 * is enabled).
> +		 */
> +		if (ret > 0) {
>   			btrfs_warn(fs_info, "swapfile must not have holes");
>   			ret =3D -EINVAL;
>   			goto out;
>   		}
> -		if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE) {
> +
> +		leaf =3D path->nodes[0];
> +		ei =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_=
item);
> +
> +		if (btrfs_file_extent_type(leaf, ei) =3D=3D BTRFS_FILE_EXTENT_INLINE)=
 {
>   			/*
>   			 * It's unlikely we'll ever actually find ourselves
>   			 * here, as a file small enough to fit inline won't be
> @@ -9933,23 +9956,45 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
>   			ret =3D -EINVAL;
>   			goto out;
>   		}
> -		if (extent_map_is_compressed(em)) {
> +
> +		if (btrfs_file_extent_compression(leaf, ei) !=3D BTRFS_COMPRESS_NONE)=
 {
>   			btrfs_warn(fs_info, "swapfile must not be compressed");
>   			ret =3D -EINVAL;
>   			goto out;
>   		}
>
> -		logical_block_start =3D extent_map_block_start(em) + (start - em->sta=
rt);
> -		len =3D min(len, em->len - (start - em->start));
> -		free_extent_map(em);
> -		em =3D NULL;
> +		disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, ei);
> +		if (disk_bytenr =3D=3D 0) {
> +			btrfs_warn(fs_info, "swapfile must not have holes");
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		logical_block_start =3D disk_bytenr + btrfs_file_extent_offset(leaf, =
ei);
> +		extent_gen =3D btrfs_file_extent_generation(leaf, ei);
> +		prev_extent_end =3D btrfs_file_extent_end(path);
> +
> +		if (prev_extent_end > isize)
> +			len =3D isize - key.offset;
> +		else
> +			len =3D btrfs_file_extent_num_bytes(leaf, ei);
>
> -		ret =3D can_nocow_extent(inode, start, &len, NULL, false, true);
> +		backref_ctx->curr_leaf_bytenr =3D leaf->start;
> +
> +		/*
> +		 * Don't need the path anymore, release to avoid deadlocks when
> +		 * calling btrfs_is_data_extent_shared() because when joining a
> +		 * transaction it can block waiting for the current one's commit
> +		 * which in turn may be trying to lock the same leaf to flush
> +		 * delayed items for example.
> +		 */
> +		btrfs_release_path(path);
> +
> +		ret =3D btrfs_is_data_extent_shared(BTRFS_I(inode), disk_bytenr,
> +						  extent_gen, backref_ctx);
>   		if (ret < 0) {
>   			goto out;
> -		} else if (ret) {
> -			ret =3D 0;
> -		} else {
> +		} else if (ret > 0) {
>   			btrfs_warn(fs_info,
>   				   "swapfile must not be copy-on-write");
>   			ret =3D -EINVAL;
> @@ -9984,7 +10029,6 @@ static int btrfs_swap_activate(struct swap_info_s=
truct *sis, struct file *file,
>
>   		physical_block_start =3D (map->stripes[0].physical +
>   					(logical_block_start - map->start));
> -		len =3D min(len, map->chunk_len - (logical_block_start - map->start))=
;
>   		btrfs_free_chunk_map(map);
>   		map =3D NULL;
>
> @@ -10025,20 +10069,16 @@ static int btrfs_swap_activate(struct swap_inf=
o_struct *sis, struct file *file,
>   				if (ret)
>   					goto out;
>   			}
> -			bsi.start =3D start;
> +			bsi.start =3D key.offset;
>   			bsi.block_start =3D physical_block_start;
>   			bsi.block_len =3D len;
>   		}
> -
> -		start +=3D len;
>   	}
>
>   	if (bsi.block_len)
>   		ret =3D btrfs_add_swap_extent(sis, &bsi);
>
>   out:
> -	if (!IS_ERR_OR_NULL(em))
> -		free_extent_map(em);
>   	if (!IS_ERR_OR_NULL(map))
>   		btrfs_free_chunk_map(map);
>
> @@ -10053,6 +10093,8 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
>
>   out_unlock_mmap:
>   	up_write(&BTRFS_I(inode)->i_mmap_lock);
> +	btrfs_free_backref_share_ctx(backref_ctx);
> +	btrfs_free_path(path);
>   	if (ret)
>   		return ret;
>


