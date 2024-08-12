Return-Path: <linux-btrfs+bounces-7148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF994F988
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 00:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCCC1F22D1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CEA197552;
	Mon, 12 Aug 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="okNlwg/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49F14A4DF
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501369; cv=none; b=uug8m7hmfdjD4U7ic47PJoa8I+fyq2+yocO9VEnfOsNT5afgtv27kcjTuv0DF03W7U3HeQTWuI9VnPdBJ7K+RyQGqp9FAZVOb+JJf2LLSG6x8IRcNXOUIsNeEbwbEOUrEXKs9yWZlGPw/9hKaHdD+SM38v7bv24A5GXqdXDlkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501369; c=relaxed/simple;
	bh=tAWKkI5qF43+aEXtkW5m+H4AjnSzlwliImAlHDAP4yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kuAXyZySF+iU5+SDdTXnjwNdhch/NjXYXTLFJGZIWn+o/WAj3JpylpIYacbxXETsXiLbM459j7xCmR2qAPzB0b5DyrmrrlEZ7s92yKutLJQFKLtUj2m7vCd20bOST+DE6TW/MzfoDbJdpdTMlW7XHnGonqHcbiq2L+6AmwwmbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=okNlwg/0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723501360; x=1724106160; i=quwenruo.btrfs@gmx.com;
	bh=iaMsX5LqIwuXOPH8bDg2qbhGvwybWMrEqD74BLCurpQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=okNlwg/06AGZlVi4UdnlpW288PjReOoVdF4qr4U/ACptCctNp7nUtaT+NZSA1y3r
	 MwhtRsf4WfuCBwiytLd99/96T3gpJSj0IvAzLs8kRiY32oGxbC8BGh9+UesVixIXO
	 IUJu65ihrJ2ljlzfAkAHPwcj72AQe0hP7BDpF/TIFdh2v2X+IBRkb/l89s4CKCzp+
	 MXwKVjCE175g8ezDfKIBxXavpHmdluoM1FAY9+Y/nxjp5lRGBk1GsI7I6NQIf8LDR
	 DUtF4d83jOzssIfjbnPA9PoF6bLWWmUuPkms/nFEafYdPxgCbPfPGCwS5QyIxmna+
	 /1uid2vedrWRTIBulw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5fIQ-1sWUZ3368g-004o7U; Tue, 13
 Aug 2024 00:22:40 +0200
Message-ID: <ccbb9b8b-f6be-48fd-bcbb-795c76d3f82a@gmx.com>
Date: Tue, 13 Aug 2024 07:52:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: allow cloning non-aligned extent if it ends
 at i_size
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <e764923c5a0bca3cdf90199da34747b38094a390.1723469840.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <e764923c5a0bca3cdf90199da34747b38094a390.1723469840.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xam6/tX1bjTVnpa/90MyflahE3NfMN5DYMsAUEXslQzheraJ07L
 5z3EPnZgmMH44rLUQdVdbsrrfiOhtzYHZgWG8nvR8B3QJwX+Lcex8zREElQpluQ1fMZcU63
 AjpCCArM+cFv0R1sjy+cpmeE2i+pZX6jVECP1FSlgNGOOcXgC5qBu4CUdUM98WnEAZPsWBD
 wxB4+p3O6A57r9J+3UOgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fy96aedCqk4=;knMAb/bC0oBJS5zWGz1pX76IK4H
 0O4Z77sP+JGnGGLz9hldNTq6cIC4kOBij307+LS91+NoSACkgLCMn2hleAnM2Nc0px6SjLM7V
 lGGt3gQJG4wVLTI9KaOpD+tnuxMd61uyY7gp16EPTqgc4LAdpafC9zMG1C/73k3eHplfPs9tX
 25f2qW3e9r1MWZZFSu/lAH5BN/80ADIDB6iGOWL4ivLMo+lFLF4OVMDl+ZofL1VytBxnxlfAi
 1wp9dRP+dkx730HL/iMhUGezGiuPE4fpHSb8QwRE5v57p6kJXZwrpivL0TzsZz4IUZBDUEfyg
 3sJ4NAjslQc4+WPkSA8ME07w8j3LxJgeDO/urfK06fQ6quIk6XWLzaIZIWZD8Q+ZiIjIEbzHL
 +3Pn65dNNEegdzA7qwx0dwEF8dcilY2bNXMnp2ETWpBD0AGbEtrl17OLsrAyAV1g4Qh5YV5Wc
 nKlEa71QHShf6KSRWjWCeUo2rRWw+Kyy5udqQS/BPsC+9Wd7oisnCf5wIHpa2/jdr4szu4Xti
 XuzdCPCulZ5hOqVWwUcomNtMigcr8cAW5RNajx0vLa1hnxQ8MXTaQNHoP3NbOUL8tvcFKirwG
 HDF2+jMRgYY0VRJZBEQQHR4wsDGirVFuZNBvuuOj8a5OOwXBDY/TdMcqC2nEHvgc2n/4phUpm
 r3ffPaRcRYMcsIcGy4csNu1nsXm8qvkYjS/h2PbH9GyxL7syjlJXPQCjS43KljdWT9m5fYf/H
 CHrX8hS7ptzXxYvhyMc16+AcrYQ6bxuC2tCVeINgLVvD8OF/gl3lPvQOqwrA3/C1QCfE5uf1D
 bXtjBlDIKdzyNCBEMdGUInIRNBEPSkuptbymsGi7GDpRA=



=E5=9C=A8 2024/8/12 23:20, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> If we a find that an extent is shared but its end offset is not sector
> size aligned, then we don't clone it and issue write operations instead.
> This is because the reflink (remap_file_range) operation does not allow
> to clone unaligned ranges, except if the end offset of the range matches
> the i_size of the source and destination files (and the start offset is
> sector size aligned).
>
> While this is not incorrect because send can only guarantee that a file
> has the same data in the source and destination snapshots, it's not
> optimal and generates confusion and surprising behaviour for users.
>
> For example, running this test:
>
>    $ cat test.sh
>    #!/bin/bash
>
>    DEV=3D/dev/sdi
>    MNT=3D/mnt/sdi
>
>    mkfs.btrfs -f $DEV
>    mount $DEV $MNT
>
>    # Use a file size not aligned to any possible sector size.
>    file_size=3D$((1 * 1024 * 1024 + 5)) # 1MB + 5 bytes
>    dd if=3D/dev/random of=3D$MNT/foo bs=3D$file_size count=3D1
>    cp --reflink=3Dalways $MNT/foo $MNT/bar
>
>    btrfs subvolume snapshot -r $MNT/ $MNT/snap
>    rm -f /tmp/send-test
>    btrfs send -f /tmp/send-test $MNT/snap
>
>    umount $MNT
>    mkfs.btrfs -f $DEV
>    mount $DEV $MNT
>
>    btrfs receive -vv -f /tmp/send-test $MNT
>
>    xfs_io -r -c "fiemap -v" $MNT/snap/bar
>
>    umount $MNT
>
> Gives the following result:
>
>    (...)
>    mkfile o258-7-0
>    rename o258-7-0 -> bar
>    write bar - offset=3D0 length=3D49152
>    write bar - offset=3D49152 length=3D49152
>    write bar - offset=3D98304 length=3D49152
>    write bar - offset=3D147456 length=3D49152
>    write bar - offset=3D196608 length=3D49152
>    write bar - offset=3D245760 length=3D49152
>    write bar - offset=3D294912 length=3D49152
>    write bar - offset=3D344064 length=3D49152
>    write bar - offset=3D393216 length=3D49152
>    write bar - offset=3D442368 length=3D49152
>    write bar - offset=3D491520 length=3D49152
>    write bar - offset=3D540672 length=3D49152
>    write bar - offset=3D589824 length=3D49152
>    write bar - offset=3D638976 length=3D49152
>    write bar - offset=3D688128 length=3D49152
>    write bar - offset=3D737280 length=3D49152
>    write bar - offset=3D786432 length=3D49152
>    write bar - offset=3D835584 length=3D49152
>    write bar - offset=3D884736 length=3D49152
>    write bar - offset=3D933888 length=3D49152
>    write bar - offset=3D983040 length=3D49152
>    write bar - offset=3D1032192 length=3D16389
>    chown bar - uid=3D0, gid=3D0
>    chmod bar - mode=3D0644
>    utimes bar
>    utimes
>    BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=3D06d640da-9ca1-604c-b87c-3375175a=
8eb3, stransid=3D7
>    /mnt/sdi/snap/bar:
>     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>       0: [0..2055]:       26624..28679      2056   0x1
>
> There's no clone operation to clone extents from the file foo into file
> bar and fiemap confirms there's no shared flag (0x2000).
>
> So update send_write_or_clone() so that it proceeds with cloning if the
> source and destination ranges end at the i_size of the respective files.
>
> After this changes the result of the test is:
>
>    (...)
>    mkfile o258-7-0
>    rename o258-7-0 -> bar
>    clone bar - source=3Dfoo source offset=3D0 offset=3D0 length=3D104858=
1
>    chown bar - uid=3D0, gid=3D0
>    chmod bar - mode=3D0644
>    utimes bar
>    utimes
>    BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=3D582420f3-ea7d-564e-bbe5-ce440d62=
2190, stransid=3D7
>    /mnt/sdi/snap/bar:
>     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>       0: [0..2055]:       26624..28679      2056 0x2001
>
> A test case for fstests will also follow up soon.
>
> Link: https://github.com/kdave/btrfs-progs/issues/572#issuecomment-22828=
41416
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for the rapid response and fix for the case!
Qu

> ---
>   fs/btrfs/send.c | 52 ++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 4ca711a773ef..7fc692fc76e1 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6157,25 +6157,51 @@ static int send_write_or_clone(struct send_ctx *=
sctx,
>   	u64 offset =3D key->offset;
>   	u64 end;
>   	u64 bs =3D sctx->send_root->fs_info->sectorsize;
> +	struct btrfs_file_extent_item *ei;
> +	u64 disk_byte;
> +	u64 data_offset;
> +	u64 num_bytes;
> +	struct btrfs_inode_info info =3D { 0 };
>
>   	end =3D min_t(u64, btrfs_file_extent_end(path), sctx->cur_inode_size)=
;
>   	if (offset >=3D end)
>   		return 0;
>
> -	if (clone_root && IS_ALIGNED(end, bs)) {
> -		struct btrfs_file_extent_item *ei;
> -		u64 disk_byte;
> -		u64 data_offset;
> +	num_bytes =3D end - offset;
>
> -		ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
> -				    struct btrfs_file_extent_item);
> -		disk_byte =3D btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
> -		data_offset =3D btrfs_file_extent_offset(path->nodes[0], ei);
> -		ret =3D clone_range(sctx, path, clone_root, disk_byte,
> -				  data_offset, offset, end - offset);
> -	} else {
> -		ret =3D send_extent_data(sctx, path, offset, end - offset);
> -	}
> +	if (!clone_root)
> +		goto write_data;
> +
> +	if (IS_ALIGNED(end, bs))
> +		goto clone_data;
> +
> +	/*
> +	 * If the extent end is not aligned, we can clone if the extent ends a=
t
> +	 * the i_size of the inode and the clone range ends at the i_size of t=
he
> +	 * source inode, otherwise the clone operation fails with -EINVAL.
> +	 */
> +	if (end !=3D sctx->cur_inode_size)
> +		goto write_data;
> +
> +	ret =3D get_inode_info(clone_root->root, clone_root->ino, &info);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (clone_root->offset + num_bytes =3D=3D info.size)
> +		goto clone_data;
> +
> +write_data:
> +	ret =3D send_extent_data(sctx, path, offset, num_bytes);
> +	sctx->cur_inode_next_write_offset =3D end;
> +	return ret;
> +
> +clone_data:
> +	ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
> +			    struct btrfs_file_extent_item);
> +	disk_byte =3D btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
> +	data_offset =3D btrfs_file_extent_offset(path->nodes[0], ei);
> +	ret =3D clone_range(sctx, path, clone_root, disk_byte, data_offset, of=
fset,
> +			  num_bytes);
>   	sctx->cur_inode_next_write_offset =3D end;
>   	return ret;
>   }

