Return-Path: <linux-btrfs+bounces-8296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD879988294
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7F1B22F9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B4186617;
	Fri, 27 Sep 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Qpax4mqE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A913698F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433249; cv=none; b=WvSx+ML3tqc0LKI966SzzLM1moFrT3Jf5bc3lsWxx+kUDzDGdSDoirg6TsLTz0+Ebt7FRFpdrD2+NzNYPTvd8obnjXxOZP0TZSsfXhyoPYQpU1FnJRm1RDgGe4B3firttbnnaX+2Rh3df7lDCPlglLfUiONJiGP9xlIZmMeEuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433249; c=relaxed/simple;
	bh=TNwhj7NDSE6oJW68n31jyECC33Kvo0025XM2LMCiqtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YAtJD93+tYGGpQxM5bmehDe6iQ3del+/hjfx75P4AxMEpng6dB/ZEHFvRf0BMhXEoSuIAj92DMIBHv9QujuK8ErQElxoOduHOrdLsqb2yGBT2n7ZXH5vVVr1Fdg1q+mIQ4tfvXNyaN/hss3hrzn/VD/WEkJpkYTFcXSyR67gM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Qpax4mqE; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727433240; x=1728038040; i=quwenruo.btrfs@gmx.com;
	bh=7JVKOnKxZtDUF8YaNaZx9+oEEIaznOo47AorP5oOmjU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Qpax4mqEFm70Xo06Cu1/9vqxjOjyk9/l4W4UmtlfxpPZzA7R9pnp30XpRkuoSVtU
	 J9/sKId3w2SDYmc010c4dm6sXa4/aeXOUd9bU+lra4oCXw2dTw5xhK6i4DV8GBxCW
	 GEjhaRqiiGeUG7MHnyD+S8F9+MJcFdyE6TPON/L+G7/W8mNIuA6FjLhuzn1Xsiw+a
	 4tlYNWjyAfll+kLi3K0D54kUufvQ9LOwssDxQVdrpbcfRuA3h1U1+7Qdlly5gmWD4
	 Qgv+ygWEnWVrximOnwdIHYA1UJD1JLeTGPnqNtqlY7P75MFm7NAvAX5s5qUsRdssg
	 /M7EKZ7arGiffgh9SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1rysyO0HVA-00rl07; Fri, 27
 Sep 2024 12:34:00 +0200
Message-ID: <ac929d10-d263-46b1-9584-fd00a38e6189@gmx.com>
Date: Fri, 27 Sep 2024 20:03:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: fix invalid clone operation for file that
 got its size decreased
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
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
In-Reply-To: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kFlPLeAz8zpz5RP72U36lD8qrfqnUs+G/UNeRi+Ivcj2aL9HqTK
 B067yHnq88mX3IPn5O1eHvKxwZ2/L64sB36E7m/veMrdmNXecnXi08YXf3GMwTp5/iOEpJ8
 Vn0dUh6vQmg+x6XwNsN6OJuy4/Af2GUOCYxD8ZUK0WO5B3naLyZBiF4f8eXx1jzmDCvvh7x
 rwXtqjUZuY5a4cWRzS/3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Axi2cIX51+g=;63/ojISsVW6kJ/6y/8yNuFku9Ep
 b0jHmoXw8JG/eVKzzKlxjrjKFtADnWRI7vdN+Vl0N0LwJAdHdWG0+dzDBObC3lYLFkwcXhSPf
 /z4RTkH4ySIng54UeGLdJIWbfdEInL5yMLkFFEtCymq0vsa0i5REDaShVuUE3lCR2h4U/8hhJ
 P7JS5wVTTDrUmMop9FnLbsxr5FywPCJQPOgjc7LxRJRB4bR5IX87K0bF19hPGwim8C/X+y4fI
 dFa24RYgBprTKOCkSIRZpgVMVPQCAglnK3bLda4+JzI2BB+wZ7++vz8kArhH50UHsckftBhsl
 0EuljlwfJtOU4/X6XtayxEEOufXbTn1u+VTn/VOmdvA0JLxMNkaHRv1sgey9y6Im3G1jx2KWc
 HauU3C8qCjUMP43jGotIfx5nxsdO8hMdlTvIa5WWnwqqkw9sVVn17eTFj24K3/ilHaokqiTBv
 8wdAJ77GvkxcWDbfXGfaGU+95dMn2w+dx0cH/Att1IyvM5onDxr01fN55vmtt47Me80zzJWj2
 wakGndL3JEY1Oh3YrTskFQHBwS2u/pvEmLf4ee/Ldc7VEWJG2ddzQRybnIEl6Ew88APf890g4
 ZeMbR2dP37FdxqwWg41BVkY2AqPgl2dioA4ouB2f7ikEK4korAj+87tq6i1OBc4p+LmaGMJZq
 KDw0QqWy+hnW5tQE1OEeNekaWu7IpTT3xwNOrqVI5ENp5Gvq9pwFCiSolHT0k9J1ukLEbY/YZ
 O0QIX3oEEmfTfOVVxm7MoWI7hmCIZDAQMhDAoxby+dVfk13cLCfm2iR7UsC1OJviQHBFI4AM/
 K8uzZb+8t46rAzJyvG5mBS6YkJNkx9UKX3/A2uc1Y4kls=



=E5=9C=A8 2024/9/27 19:55, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> During an incremental send we may end up sending an invalid clone
> operation, for the last extent of a file which ends at an unaligned offs=
et
> that matches the final i_size of the file in the send snapshot, in case
> the file had its initial size (the size in the parent snapshot) decrease=
d
> in the send snapshot. In this case the destination will fail to apply th=
e
> clone operation because its end offset is not sector size aligned and it
> ends before the current size of the file.
>
> Sending the truncate operation always happens when we finish processing =
an
> inode, after we process all its extents (and xattrs, names, etc). So fix
> this by ensuring the file has the correct size before we send a clone
> operation for an unaligned extent that ends at the final i_size of the f=
ile.
>
> The following test reproduces the issue:
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
>    # Create a file with a size of 256K + 5 bytes, having two extents, on=
e
>    # with a size of 128K and another one with a size of 128K + 5 bytes.
>    last_ext_size=3D$((128 * 1024 + 5))
>    xfs_io -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
>           -c "pwrite -S 0xcd -b $last_ext_size 128K $last_ext_size" \
>           $MNT/foo
>
>    # Another file which we will later clone foo into, but initially with
>    # a larger size than foo.
>    xfs_io -f -c "pwrite -S 0xef 0 1M" $MNT/bar
>
>    btrfs subvolume snapshot -r $MNT/ $MNT/snap1
>
>    # Now resize bar and clone foo into it.
>    xfs_io -c "truncate 0" \
>           -c "reflink $MNT/foo" $MNT/bar
>
>    btrfs subvolume snapshot -r $MNT/ $MNT/snap2
>
>    rm -f /tmp/send-full /tmp/send-inc
>    btrfs send -f /tmp/send-full $MNT/snap1
>    btrfs send -p $MNT/snap1 -f /tmp/send-inc $MNT/snap2
>
>    umount $MNT
>    mkfs.btrfs -f $DEV
>    mount $DEV $MNT
>
>    btrfs receive -f /tmp/send-full $MNT
>    btrfs receive -f /tmp/send-inc $MNT
>
>    umount $MNT
>
> Running it before this patch:
>
>    $ ./test.sh
>    (...)
>    At subvol snap1
>    At snapshot snap2
>    ERROR: failed to clone extents to bar: Invalid argument
>
> A test case for fstests will be sent soon.
>
> Reported-by: Ben Millwood <thebenmachine@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=3DojYvBPDLsAT=
wLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
> Fixes: 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if i=
t ends at i_size")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small nitpick inlined below.
> ---
>   fs/btrfs/send.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 5871ca845b0e..3ee27840a95a 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6189,8 +6189,25 @@ static int send_write_or_clone(struct send_ctx *s=
ctx,
>   	if (ret < 0)
>   		return ret;
>
> -	if (clone_root->offset + num_bytes =3D=3D info.size)
> +	if (clone_root->offset + num_bytes =3D=3D info.size) {
> +		/*
> +		 * The final size of our file matches the end offset, but it may
> +		 * be that its current size is larger, so we have to truncate it
> +		 * to that size (or to the start offset of the extent) otherwise
> +		 * the clone operation is invalid because it's unaligned and it
> +		 * ends before the current EOF.
> +		 * We do this truncate when we finish processing the inode, but
> +		 * it's too late by then, so we must do it now.
> +		 */
> +		if (sctx->parent_root !=3D NULL) {
> +			ret =3D send_truncate(sctx, sctx->cur_ino,
> +					    sctx->cur_inode_gen,
> +					    sctx->cur_inode_size);

I know this is a little overkilled, but can we just truncate the inode
size to round_down(cur_inode_size, secotrsize)?

As the truncate will still dirty the last sector, and later clone() will
writeback the range covering the last sector, causing unnecessary IO for
the sector we are going to drop immediately.

Thanks,
Qu

> +			if (ret < 0)
> +				return ret;
> +		}
>   		goto clone_data;
> +	}
>
>   write_data:
>   	ret =3D send_extent_data(sctx, path, offset, num_bytes);


