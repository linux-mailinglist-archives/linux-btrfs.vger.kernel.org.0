Return-Path: <linux-btrfs+bounces-1768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2798C83B887
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51342845A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 03:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9597489;
	Thu, 25 Jan 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KTlb68jQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CDB7460
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155090; cv=none; b=X68EVnBHNAB2Shi1PnG6WSogOcYs4vs19qR9tXCqoIEOEh+UojYQewY8SHxn+BlfIhjfLmYxdoVu0x6CyO2P+PZOUJgprSGjBmPEdLMLs2ouoSyiCVOXUwDX/amFUIpM1VzAREC2d2TgRwk5ll8i8eDvzUA3z6g60Zra0f8E4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155090; c=relaxed/simple;
	bh=ihywy4HMimoEMiEfA7YWAS0aC9BmzCdWGF0zMaHIt9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cpMt5Mvf11vYSTJWdBiXdBxrwMngp0jQ65aZ9Cm005H0advqjqZVbKPAEzm9iBqrdDobpcNT7uxNbuXUmpIpCd1ANG6Pyn0LJNm7igxOOKmyq+WxFerPMUcaVQXDJiXrySe897eJ7FGC01Ot0Ew4jfbXNfeW2tYnok8K4MB0HK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KTlb68jQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706155085; x=1706759885; i=quwenruo.btrfs@gmx.com;
	bh=ihywy4HMimoEMiEfA7YWAS0aC9BmzCdWGF0zMaHIt9Q=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=KTlb68jQPtUjKp5mIETP7JwHFK3qmzIou5Il8+tsbchmbFW9Y+0cZMvM/S1AiaCn
	 PDM8Vo+SfjVWUyNi/H0hpf37EWycBWpteMBNMU5zvXiPJNEXfweXbvyi5irg7t4Y1
	 aHCKrwgRh2OzSRYtwFAw5fp987ShVlFa8yMF/UqFQ6mFG2cr/fjZ9oJ2z7RHAiIH2
	 mpBSNYMngRSOkM3Lo4D8MhrvkM3x0PAlZa4Wi24wMSrX0RJKhxfpQGtDOg1xq0iaX
	 KYD/pqRHyRySJ8Y2J4InfsWBivDN6G2Bh8VZzlI65pDnmmTCfgcC05p0hihBk2S3i
	 +2vlPZkT3JGA0UntVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDEg-1qkkhQ2v3I-00iEdX; Thu, 25
 Jan 2024 04:58:05 +0100
Message-ID: <f2eb8f2f-999f-47a6-b920-fb5ba211fe72@gmx.com>
Date: Thu, 25 Jan 2024 14:28:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] btrfs: handle block group lookup error when it's
 being removed
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
 <cfe1bf94b8a6f24407795d3e1823a187ead04570.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <cfe1bf94b8a6f24407795d3e1823a187ead04570.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VgCkRkckTWyNyssvdOFtO3Ny2tdYnsDRpKuDgepnv3rSP++6T6v
 yemh4RaON7TC6P026lUYtTvrjh89u3viXzPfK9p8PFPuXyOPrrNzHFPizD/HspkNSTKo6Bm
 nq5MGSmRPvzIFKIHynzUzoksUp5TXWPhENN0BvpK80ksKkg9Tkjc5cHWOmc4Wi7bYpB/U5J
 BTd6XOqfShEUvTZubE09Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2O3Bz0p9rzk=;G/7Nf0M4h6iT9YzmQmiiak+IbO/
 I2Voh7uv+hmOIjG6VM2Pt8pBdLdZ2+LtgtEghacNoG6sXAhDIM7reUlWRimp/ZwilG5Xsqhjo
 XdVFtehaCJg6aUYqxig4gr2Wnot/FOXblFJVch54bZCFoH41maQSFYwJeZk27eqU8WlbQUEzA
 qyulaGko51qI2c9uvVqNwpwt+mnHoxrS6myAwc27e/F6VSjlR5r8Rn4/dKPkYBUyj3cYhvPeC
 3L3yPVXCgWPnC/xlppiomI7UgpuhDpB76D11IWkPTxIU0dw4CL0juAMgPNCPcvK3/g0YgIaVM
 KCq7ddfVEDtvgP7cWDdouZzzNsjq4XASAy0RHuPvWZ/wn6iO31fBNxMC8XYiPiuV3d58kfzm1
 XzIqiJ0NWxZabrqwiaIpnUyUd2yc3Msf5jNwnhxCse3VV/q+Amglxegi4ICbuxGhwmuVRqnJM
 iN/3HzoPobBNoBemZsLkAYVznsPEaraAO49bhEFbiqwEtA8xEBYP82EjBANz+4M0DZYuRJR4A
 LcSTTqN36dTpJfxMi4xLLVI74Yqp+LGdaqi9a4KutW0zX+nGN/WoXMZzW9Jjj3+hkFPrkybdw
 6ov47mG5OzwyXEDzHxVWLrQLi3S7YHdQ5t4ESlkqYh03ik9OQZM5cY1XSmFL8ggtG5D5BDhAp
 nqxvVC2u2lKkpHOhY8VCXtcOThYUgmqEhv7zqTdeclIzi9eRDtTdqyW2mjkhIkPfRsZ4VhAha
 qzMOdQTwc9Owr+oirHxgzdIQ1hZT0wPvY4mdiRJNVBgQkuL+jpkphmOMZl9OmfNArvy3uPHwE
 k2iu41uB3J2OhM+WeFUEdzO+kpH56T98bpiXlYYrg1I4s/Tifsm182ADdoAERO+3/0nSUEwK7
 6n/1LkdC+vQeHYT6C8OycnUe7RjCkyf/bUvfLdGhe5xoG/QFgZD9E+nsc8nA4HTCPR3JwEcOW
 tG0xJGrtYIXqnp7glVurBaFEdAc=



On 2024/1/25 07:47, David Sterba wrote:
> The unlikely case of lookup error in btrfs_remove_block_group() can be
> handled properly, in its caller this would lead to a transaction abort.
> We can't do anything else, a block group must have been loaded first.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/block-group.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1905d76772a9..16a2b8609989 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1063,7 +1063,9 @@ int btrfs_remove_block_group(struct btrfs_trans_ha=
ndle *trans,
>   	bool remove_rsv =3D false;
>
>   	block_group =3D btrfs_lookup_block_group(fs_info, map->start);
> -	BUG_ON(!block_group);
> +	if (!block_group)
> +		return -ENOENT;

This -ENOENT return value is fine, as the only caller would call
btrfs_abort_transaction() to be noisy enough.

And talking about btrfs_abort_transaction(), I think we can call it
early to make debug a little easierly.

> +
>   	BUG_ON(!block_group->ro);

But shouldn't we also handle the RO case?

Thanks,
Qu

>
>   	trace_btrfs_remove_block_group(block_group);

