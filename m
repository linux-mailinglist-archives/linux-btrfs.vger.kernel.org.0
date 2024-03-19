Return-Path: <linux-btrfs+bounces-3453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079248806AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B15D1C21F71
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B83FBBF;
	Tue, 19 Mar 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Q1oP3/Fp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809F3C488
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883515; cv=none; b=LbO9tTpYds8hQUR1jxHT9jT6jjQ7PGp9xF7sJ4CX5FE4syDgM7pwOkGQeBGNfPaAMnC+zFRcENhrRtJ/uQR8sHTZcOWGYmIreChKOoPfQ5NTzSqubNMFVW2D4yozVS57YwHdp+5QaxRLX/se9D+bNZ4dtFQRZN8j79o8w2vpoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883515; c=relaxed/simple;
	bh=ThPVGjKMZLwokAqPTqQeJLweUjC5MOo8h38fRQkd8rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZRVYHgK+G4k7M4etiqiB0pbKD2YWGqxchlih1wsRhpXYtzgjHOQQQiZXIv5DuZRs37e14LwazSrb3Rp9NzNKYDQZI33KpOoy+ho9oB2NPaN11AZ6j9y1qHRLE8Lh4GbpLZ3RXy4dPOzgJZIjwJ8TglQIH2ygvDqvI4vcQOfCjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Q1oP3/Fp; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710883507; x=1711488307; i=quwenruo.btrfs@gmx.com;
	bh=hwpTTO3l49UOalxpC43KUemIViNe5r9CUphZqmAGkrk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Q1oP3/Fp6q4RtLTjz2+5lQ+5pYJyarU8B6uFlYiE297XNprM9ru0htCxguaXV15h
	 RZ9BEOr+qL5Pa0nYhGDBNOX2jqQ2JFqQ9GeOKE02ySO5lHcM3ShtFIvaRy9dwMJgu
	 pwqnhJZ9+XlIwjpXK3GGkkltB2MZMMAPX1CBPi0y090mxigufPESBwK9oR0OVbqUY
	 Z4WwkYskBo1NwmOuOjHNLWSe6GJL0MDEetczvwkr12+BMBtyO+iJAJgB304O9QDXf
	 +AZLae+zsJqCLsNADSriL00/Q1ZDabFiSbxHwayEHGcZoXm/3zobhKl+5u4AwArYG
	 YLighnaaRUEWY0xRiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSKyI-1rKCny1dO4-00Siht; Tue, 19
 Mar 2024 22:25:06 +0100
Message-ID: <49b3228a-469b-45af-879d-88e637dd1823@gmx.com>
Date: Wed, 20 Mar 2024 07:55:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/29] btrfs: btrfs_write_marked_extents rename werr to
 ret err to ret2
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <14bd267ea479d4c4d104966d4dae2d88ff403a99.1710857863.git.anand.jain@oracle.com>
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
In-Reply-To: <14bd267ea479d4c4d104966d4dae2d88ff403a99.1710857863.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7548Srw4MCTkslvb7nkVUG+C4o4m6DYybZTSyYODp8uz3poCeF7
 w6TWcslgLa38XhMubxmb6kscbTI8afTXlIRv7Wb1oKwFV1glaiMyxHFZaC6816jhyIkfmI3
 /G5lJs+HSrLXFd3Ro6lkKawom2WVzNAOkQrVXFOP64/0awD2o0Y5iPgoNNI8ou+09Saaxe0
 EYSZ7cz/0NmiQZPxYb3Vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DZGvPY8UouE=;N9TGJ8x6JwZRUSPo3i0wUuthUPO
 AELo/+nCMsU99I2tHx+ZMtzLPmz8O/68xxek01IQzxXyj7UvaJ+RGPj14lW2nwURGB0G5VYVQ
 BXAzIJu9fxDRQFSpzhHU2IbRWIWsSeel8Vuz1uy53dlRvhuLSjcpIxvvXMPRVf47r3YoRW/rz
 /1gljvU41gyOp7Fi/bwrQ/0ceqvR1uN2mar3nN2AwITI4hTRwoPk/5fySaUFrUeNuRGeQiVVn
 W6Z8ZXQlodCnmBuzqxFoRi6rWQ7932LH6n4o7nC8+AJRTvLJw+xmXXb3cSvj9bEEL/p3JtNqC
 t4KzcTodn+oLQ27dHiFuxsDnrz3ZB+FBdg6wLuyvf/Qy/lHzQgPLTjLsNhXmjAWle9vf03690
 2yGDze5cJs8uXaNhAk/lY/4jsYRtXaySnuHGT9bLwqD7jmtqnrNmEd+ty/UuttbPx8gUQ2eL4
 AqUVJiUhPzVqVvj8wHQjgZ2KCQ0EX0NQ2hoITshHLtjqLNN/rvMcx9h4UZ08A15XyLHK1hfDR
 b65f0UMov/p3LijzZWM+zkGQHmvbjWPccpSquQXR/NAKXdItjP2hU0TvJCBrObzfn8Hv+cvb8
 UItmyuZctV3AmKvzWXedOfyle6PWUcb3z4QrW5iZY3v635eQUwnfZhxLjdDQA75A1nwunDgsk
 R3R2CFA7eIFz5nLQJuFpM0VJERMH0/PapczzPLwUugI3J2Bd23XlxKY7XVIzP3pQRqSNC2+/l
 pwApxQx5HInUJ3bw104oVVaycybvWFwD5HA5eqP7XLvPO1TDbi3dW2zb6p+g3lT6kLyxtt7y5
 r3FLxfZtmyj2bbU8bhIWSqXNldPFYabGAJnQ3JYmIVtos=



=E5=9C=A8 2024/3/20 01:25, Anand Jain =E5=86=99=E9=81=93:
> Rename the function's local variable werr to ret and err to ret2, then
> move ret2 to the local variable of the while loop. Drop the initializati=
on
> there since it's immediately assigned below.

I love the local return value inside the loop, but I still think we can
do further improvement.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/transaction.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index feffff91c6fe..167893457b58 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1119,8 +1119,7 @@ int btrfs_end_transaction_throttle(struct btrfs_tr=
ans_handle *trans)
>   int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>   			       struct extent_io_tree *dirty_pages, int mark)
>   {
> -	int err =3D 0;
> -	int werr =3D 0;
> +	int ret =3D 0;

Can we rename it to something like global_ret or whatever can indicate
that variable is our final result?


>   	struct address_space *mapping =3D fs_info->btree_inode->i_mapping;
>   	struct extent_state *cached_state =3D NULL;
>   	u64 start =3D 0;
> @@ -1128,9 +1127,10 @@ int btrfs_write_marked_extents(struct btrfs_fs_in=
fo *fs_info,
>
>   	while (find_first_extent_bit(dirty_pages, start, &start, &end,
>   				     mark, &cached_state)) {
> +		int ret2;

And @ret inside the loop.

>   		bool wait_writeback =3D false;
>
> -		err =3D convert_extent_bit(dirty_pages, start, end,
> +		ret2 =3D convert_extent_bit(dirty_pages, start, end,
>   					 EXTENT_NEED_WAIT,
>   					 mark, &cached_state);
>   		/*
> @@ -1146,22 +1146,22 @@ int btrfs_write_marked_extents(struct btrfs_fs_i=
nfo *fs_info,
>   		 * We cleanup any entries left in the io tree when committing
>   		 * the transaction (through extent_io_tree_release()).
>   		 */
> -		if (err =3D=3D -ENOMEM) {
> -			err =3D 0;
> +		if (ret2 =3D=3D -ENOMEM) {
> +			ret2 =3D 0;
>   			wait_writeback =3D true;
>   		}
> -		if (!err)
> -			err =3D filemap_fdatawrite_range(mapping, start, end);
> -		if (err)
> -			werr =3D err;
> +		if (!ret2)
> +			ret2 =3D filemap_fdatawrite_range(mapping, start, end);
> +		if (ret2)
> +			ret =3D ret2;
>   		else if (wait_writeback)
> -			werr =3D filemap_fdatawait_range(mapping, start, end);
> +			ret =3D filemap_fdatawait_range(mapping, start, end);

This does not follow the regular update sequence, we always update the
local one @ret2/@err, but here we directly update the @ret/@werr.

Just for the sake of consistency, can we only use @ret2 for all the
functions calls?

>   		free_extent_state(cached_state);
>   		cached_state =3D NULL;
>   		cond_resched();
>   		start =3D end + 1;

Another thing is, we can move most of the writeback code (aka code
inside the loop) into a helper function, and make things much simpler at
least for the caller.

{
	int global_ret =3D 0;

    	while (find_first_extent_bit(dirty_pages, start, &start, &end,
    				     mark, &cached_state)) {
		int ret;

		ret =3D writeback_range();
		if (ret < 0)
			global_ret =3D ret;
		cond_resched();
		start =3D end + 1
	}
	return global_ret;
}

Thanks,
Qu
>   	}
> -	return werr;
> +	return ret;
>   }
>
>   /*

