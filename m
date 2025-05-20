Return-Path: <linux-btrfs+bounces-14141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99CABE6DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C808A213B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 22:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFAC25F7A4;
	Tue, 20 May 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k+ag2Xik"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FB25C818
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747779923; cv=none; b=VLloL+uA4l7DWsiI3loYERS+hM3Dy4vgdlHdEvtsIpt94C7wIbv7Z3e4o4Was4CWunU8Xk+Hvn2CGbYBG1r2xZf9YBAtVS6EywjEbOs98sLbPKFf79eiSAcgHVfOKx/55xHMASrXxlLR+ON/Emy5GASzTjlVb40v71dZysewl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747779923; c=relaxed/simple;
	bh=YcieBLBKzF4JgsnPjkt7BHtswPj8/LEORgry54culo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pH+EGOG6tzYCVRuTayzOtFLnOUkqBRkpX6fLg3SrA3UNxC7A4M901pPmRPF62mP0ZtLmPxQkR/A2S4dZbUtEivbj3wTho+9NSu9KHjSGj11V/wNMNY1c2XA1WEZH81r0JGdCuF9kgda84MREnlRTlvAtZqKRF/fMWstB0KIKHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k+ag2Xik; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747779913; x=1748384713; i=quwenruo.btrfs@gmx.com;
	bh=4kaSa/ZY33yUlGe7jENbc90yUJHTxbG1jvKwP4aSSwc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k+ag2XikbJE8/f6YkUdTjO7nU3/9ZJ46bjJN3j3ckMjFxOcuJTAzx0zVLcuXLFjM
	 tWSCCkf6s4LcPlYh4nSkvdFffoHUzsQv8/SBFfZ3XKbr2GBKqHV14ZAwtiBwKbxk+
	 ufLyggEQWN1Y6MZ8PIpSBe3lbMjcqOHmcZ2MDczIJAC45cn+Kj8nePMLeaHAGZrsf
	 NA4K8CJkMvlOl+6yC22k8hffwzY6KUvDerD2xOcPkv+tyAVvplQVFTViHq1PMwLx5
	 ajIakUxqjdDaSjrBags+7ctpBT2lhqnLMN4IImR9KcwYkUWkSXaagYncB3TZRdIW8
	 pt8Aq6NMaW3llqW8Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGVx-1ua1if2Fg5-00Ioxx; Wed, 21
 May 2025 00:25:13 +0200
Message-ID: <da820980-ecc2-41d2-8406-fcde11b0bfb5@gmx.com>
Date: Wed, 21 May 2025 07:55:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: preserve mount-supplied device path
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <85256ecce9bfcf8fc7aa0939126a2c58a26d374e.1747740113.git.anand.jain@oracle.com>
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
In-Reply-To: <85256ecce9bfcf8fc7aa0939126a2c58a26d374e.1747740113.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0+ni/b6uhU9m19WLIKSkm7Aq1Bb4RahDjixqIks7oPt578zO/EW
 GavkHjdWtKf0qdUiouBq13WlhL/K2IOns5nwWl1CnCfQ8iSBVSWT6ZmBljmPQw7AROjY6dI
 RNAeQyvNOoeaYdijoYFm82DBGIxyjTXrwOc+B31KOpgMrwClKEE0+xScD+6LlkX4Pz8m27w
 pfp9MOM4zd7Mjs9U18DXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mnAfYWlT7NI=;PZc0Z3IjHY8v/OmlMFLlVU97B07
 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
 h0CUke92K+En1is4QTIBiDqbKBTCHG55xi



=E5=9C=A8 2025/5/20 20:53, Anand Jain =E5=86=99=E9=81=93:
> Commit 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for th=
e
> same device") addresses the bug in its commit log shown below:
>=20
>    BTRFS info: devid 1 device path /dev/mapper/cr_root changed to /dev/d=
m-0 scanned by (udev-worker) (14476)
>    BTRFS info: devid 1 device path /dev/dm-0 changed to /dev/mapper/cr_r=
oot scanned by (udev-worker) (14476)
>    BTRFS info: devid 1 device path /dev/mapper/cr_root changed to /proc/=
self/fd/3 scanned by (true) (14475)
>=20
> Here, the device path keeps changing =E2=80=94 from `/dev/mapper/cr_root=
` to
> `/dev/dm-0`, back to `/dev/mapper/cr_root`, and finally to `/proc/self/f=
d/3`.
>=20
> While the patch prevents these unnecessary device path changes, it also
> blocks the mount thread from passing the correct device path. Normally,
> when you pass a DM device to `mount`, it resolves to the mapper path
> before being sent to the kernel.
>=20
>    For example:
>      mount --verbose -o device=3D/dev/dm-1 /dev/dm-0 /mnt/scratch
>      mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.

So what is the problem here?

No matter if it's dm-1/dm-0, or mapper path, btrfs shouldn't need to bothe=
r.

I guess you're again trying to address the libblkid bug in kernel.

>=20
> Although the patch in the mailing list (`btrfs-progs: mkfs: use
> path_canonicalize for input device`) fixes the specific mkfs trigger,
> we still need a kernel-side fix. As BTRFS_IOC_SCAN_DEV is an KAPI
> other unknown tools using it may still update the device path. So the
> mount-supplied path should be allowed to update the internal path,
> when appropriate.
This doesn't look good to me.

The path resolve is util-linux specific, and remember there are other=20
projects implementing "mount", like busybox.
Are you going to check every "mount" implementation and handle their quirk=
s?

 From the past path canonicalization we learnt you will never win a=20
mouse cat game.


Again, if it's a bug in libblk, try to fix it.

Thanks,
Qu

>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/volumes.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 89835071cfea..37f7e0367977 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -778,7 +778,7 @@ static bool is_same_device(struct btrfs_device *devi=
ce, const char *new_path)
>    */
>   static noinline struct btrfs_device *device_list_add(const char *path,
>   			   struct btrfs_super_block *disk_super,
> -			   bool *new_device_added)
> +			   bool *new_device_added, bool mounting)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *fs_devices =3D NULL;
> @@ -889,7 +889,7 @@ static noinline struct btrfs_device *device_list_add=
(const char *path,
>   				MAJOR(path_devt), MINOR(path_devt),
>   				current->comm, task_pid_nr(current));
>  =20
> -	} else if (!device->name || !is_same_device(device, path)) {
> +	} else if (!device->name || mounting || !is_same_device(device, path))=
 {
>   		/*
>   		 * When FS is already mounted.
>   		 * 1. If you are here and if the device->name is NULL that
> @@ -1482,7 +1482,8 @@ struct btrfs_device *btrfs_scan_one_device(const c=
har *path, blk_mode_t flags,
>   		goto free_disk_super;
>   	}
>  =20
> -	device =3D device_list_add(path, disk_super, &new_device_added);
> +	device =3D device_list_add(path, disk_super, &new_device_added,
> +				 mount_arg_dev);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
>  =20


