Return-Path: <linux-btrfs+bounces-6855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183F594007E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 23:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C23B1C20E4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24C18E774;
	Mon, 29 Jul 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CNmUDPjQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17845131E4B
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288886; cv=none; b=IOQmJg1Nq0yQuVnUQQNa8nxTgWTdH5RNYPufVCX5B8fA8O1BG1tqzVuX+Fm6ixR8G+HN+uKEp00OiDgVFz7Xa8dJADZ83dN7xDTfuyzGahe2fFL5KD1XOlyc4RdiJ69L21ldRmaK90w+vZ/jfgRADfSVvhG8bZYxRnPcELvBPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288886; c=relaxed/simple;
	bh=JKUMTnZtXg819MsOeJ40WFT4h5jQz+fJ09RXdzM5ueA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl02KEqK2Q6s2l5Vjx1x0sNvG6msFGzY7oAsckXIh93KoKXkcPZkN7/uJ4GZEMk63hp8j2QKX0hxsUMJsMq/8ctWDWk2h2CbPEcMN1Socgu871RtknVIXlG+AhY6jyBaLFxkSQEkdw7vJKstqZAAi2vnFHHf7eE2wuhnwGQ5Hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CNmUDPjQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722288880; x=1722893680; i=quwenruo.btrfs@gmx.com;
	bh=/3KiFGLKMR6bE1y+DjNs9xMOt05bx8ErOMPljuwK0to=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CNmUDPjQit+5PCuPIIBVsdcVMmpIz3BhuXGqSMJP+f0zA2LuIeQRw9NtcRdfB979
	 pTZIL5sawKi8fIeHWfX1/eVovkdau9ieXlJubrniE8LxHRpT1qZnDAZmFL9upmv2J
	 qkJ86Ibk6h+/zQRd0XCAT6bpEeAosWhTPf6xJE2BDLRcBYO5kiXL4yprNTsRapo+K
	 ISLlv5FfmWqpDh2cC9AGkDlk4zKyrak/Li2oVgXxYliU6O21QP0L/dU6wWVkpH+J6
	 xSvLyq5ibt+7aXMRGQrgriaaIRO/8Gz+u7TJmXhDkB5qc1WYuF+783MFSHE13aM5m
	 dOdhR3ZjKuSuORM3Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ81-1snFNK36Qf-00JkS9; Mon, 29
 Jul 2024 23:34:40 +0200
Message-ID: <92c6004f-9742-4abc-91bc-347cccaa44b9@gmx.com>
Date: Tue, 30 Jul 2024 07:04:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: initialize location to fix -Wmaybe-uninitialized
 in btrfs_lookup_dentry()
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: geert@linux-m68k.org
References: <20240729200608.10722-1-dsterba@suse.com>
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
In-Reply-To: <20240729200608.10722-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BxWC6IVmbPYRJXt3PA7WguFR/fhV4W5lxfJFy8+D5Ej7rC39D8W
 7kahLpvOWN0+LkaF26/au4mJsYBng7HyrsyvNB5TKVitUpS3/w+hS9/hKo743Ki7Ku6Dbsi
 EhtSO6tItkYQYEGcD6uT+Xv+NYOdtNGCkmgAA4M4MhCGNzk9a6GMPAvu42fUV93a3mIZAHh
 z3mwANEdVHqZxu2GPJPdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dt8v9VQPuGg=;I1OHA5mTJ6FenSgXv6yOz0D5xKb
 yqpWHlAeXW/vCUYVGQRh6OTscF6ZlW/oHTp1ZER2Lx5pExuZC4XlNhmANJWuD2aIZeGI5qQtI
 FEAjOYRJ83slNuzCgxHcH7lFon3s9S/00q0beRC8XKVfE2M3lbiUzj6FF9oXORlNCwh1iGCTY
 AlrsruBsVBujyKmamhklfzacyvC/OYXIawI31SfFrZhGUe4TMqib0hpQ4Ldjbgv6b3QQEkoQs
 0q4O3rbdmCUj5FiofvuJZaq1uahTvGSl36s68YmATqi/I5jKtZa95zMXvwaRuJk5+hZ+JpqRu
 1sMulJ2BFSS2/DcauFlTBBzg5ZwEzZu1wUSFtYx6JdS1H3vuwQwiLBV0sBR1X36lp/ha0vKrM
 v3hpThcXgamwruz4rX0p7BxzfMD9/8SiWUYpSKi7rMsEzC2DBX1Hi6Ui73hOrvvgiQB0z9JVM
 M6IPMxPdiLqMHTwlJ4V+PeuBn+VVRq+BcSYLYN+2IxE26ABKEjlE81Ok4Iuq6c66mJqmkxk8i
 6mAzPac4s2EfN0F5xm6sLV4+epiJKHmj7QLcLwIzOqRwxTsmsC1iswQ6rJmac6C/7LIEP94CM
 27Mkz8FB21OFzzO+rUubOGMyNNawp650pdpwDbeoHM8siUUAszS3+TDdkhcjZxPQX6oryB5qM
 BbAk/39Z7oUavgGjXWyCEGfLTmeU3/oqvACkKq8OKn6/pqh+W+GhfXHNeNgiyqiBZb5PRXYnC
 RCP+VzHlhU6XrdVRxld8i8WGvrfnE+uej/FaPt5fkG4ZA7KgV5sEIbPSOgZciNWcl/JDME/QG
 oVzlpx4UziCBJxaSuPU9csQw==



=E5=9C=A8 2024/7/30 05:36, David Sterba =E5=86=99=E9=81=93:
> Some arch + compiler combinations report a potentially unused variable
> location in btrfs_lookup_dentry(). This is a false alert as the variable
> is passed by value and always valid or there's an error. The compilers
> cannot probably reason about that although btrfs_inode_by_name() is in
> the same file.
>
>     >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.objectid' may be=
 used
>     +uninitialized in this function [-Werror=3Dmaybe-uninitialized]:  =
=3D> 5603:9
>     >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.type' may be use=
d
>     +uninitialized in this function [-Werror=3Dmaybe-uninitialized]:  =
=3D> 5674:5
>
>     m68k-gcc8/m68k-allmodconfig
>     mips-gcc8/mips-allmodconfig
>     powerpc-gcc5/powerpc-all{mod,yes}config
>     powerpc-gcc5/ppc64_defconfig
>
> Initialize it to zero, this should fix the warnings and won't change the
> behaviour as btrfs_inode_by_name() accepts only a root or inode item
> types, otherwise returns an error.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/linux-btrfs/bd4e9928-17b3-9257-8ba7-6b7f9b=
bb639a@linux-m68k.org/
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I hate to update our code for bad compilers, I guess it's
unavoidable anyway.

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 32010127710d..333b0e8587a2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5667,7 +5667,7 @@ struct inode *btrfs_lookup_dentry(struct inode *di=
r, struct dentry *dentry)
>   	struct inode *inode;
>   	struct btrfs_root *root =3D BTRFS_I(dir)->root;
>   	struct btrfs_root *sub_root =3D root;
> -	struct btrfs_key location;
> +	struct btrfs_key location =3D { 0 };
>   	u8 di_type =3D 0;
>   	int ret =3D 0;
>

