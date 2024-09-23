Return-Path: <linux-btrfs+bounces-8159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDCC97E692
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F30281593
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 07:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E656B72;
	Mon, 23 Sep 2024 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VT4iW3Mp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67D3E49E;
	Mon, 23 Sep 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076537; cv=none; b=sxD90Jb3sTFaAyK5Fy4tCbxgbExKZfvVXlfN0oF01d01y/gWKbCJCOaLO9+6qBsTPJWmE5ViizgNReUAKEPqa3t2f4k1kBoZ889D6a9z02vywT1N1Jlh++N0XvQNGWD+hBHwGj4sO6+Sej2UEKiaRl3VIm3h+niC0LI8BB9ojVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076537; c=relaxed/simple;
	bh=A5Pas79epxBIObXqRnsu0YJiGWRvcoaOlVkcmzdjoZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3n9o6hw14AJmjpk9wzJ/q27tNOfs+Hqm3RUDIIeIOY9F/mOu9KzwLDeVl6XUNwa3dsbXlLA8CcL9A+t3N7QYpJzmR0F5EbCFi8qkmQ/NFFcvgc2SUWK2vhNC9PVoOQy0EDkQoMcI4YJOPMTlOFLfGUh9uqboc7K5Ycqw9ooGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VT4iW3Mp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727076520; x=1727681320; i=quwenruo.btrfs@gmx.com;
	bh=/5YYfK/ShVdW5SAHFt6raWNFB183nSJRCv+/GE9BV08=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VT4iW3MpF+850WZHKHd8hRghgO1SR3HzX3SqQv6cthnAmzcc9sCiJT1SLabkpyyN
	 fT4fAgyriN9NIEhby//fPWANsTEErvN3WexZq56nlU+UGrK9X71sKdEKX5UgAAa2V
	 /LsuT8tOwY4eD4HQRhWuD7EO36d0bHNx0F4yyhmFj/vbDWxzHu2xdzSp3PSiqXUkW
	 RKS1HfScxijOyON1nCFBtfLkT1DeTPRZ81ehjsVz3qvp1C0ASHYQCPNv45iUD4lFp
	 V1kBpFpOvAhJFBnpaSs3gUDnprxAMGiTy9M32FrDtan47aVHHNUMSv+ssuKrCEFgS
	 nTdL4U4EyV7vR6kjeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQEx-1s7m9Q1ur9-00gNP2; Mon, 23
 Sep 2024 09:28:39 +0200
Message-ID: <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
Date: Mon, 23 Sep 2024 16:58:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
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
In-Reply-To: <20240923064549.14224-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q2H+D2Jeqps51mRWJRiU1siaJJBWCkiACRvVeoVJlkxAvXehrCE
 t01ZtjVRQfOHTlgLuCuxl3ofShk7X4mq//D8KZ+KFQFxA4QCKwWL7zNJw3e4vtoJgSM7g2H
 BJjgyyAjoY+Deb3iM3CWBnKe1hUnh6KnjbyBLasz5YGHeGHdBSrsjKjGgo+dlgcOTrW6H1D
 JSItqTT02OgiP8YILxMvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tb5RiVuMEKI=;pIBFD9Wa5pBLuHKPAO3KLHllCXy
 y+rcwPNDVddFMfbtaBA701dkD9xmEUGYlC0mLJTonWZsQk/69NVkswq/8Uv3utjIg10mTlh+T
 G1HVztVToGlHtwDRjJ1gXWVT75ApeCnftbh0rxo+hbq31dIx5fjbqzp3WSVGE6NrafrqCxLdT
 3mmckYqtQ276dXAmVW3lK9YvKrN0uhzOr0/NCvYnK0mrH1fseKaq+w8bTeUHu6JSeHhLhWTq5
 9Z9Cjd1r6NCZVHiHCTdLpSmfi4I95kx1Bzbh+2SxdgKytxKhAlvDNQtlK20bV8trz9OygRZ8Y
 e2Bnziv3rgN8gm8d+NA4MKtoaBIfeMyCloD1c8u5qYFVOdPLwCpzGiSSv47ed7r/1htUeuCsd
 QhBDoSl/iNXp3T+HdqbcwUnUIsYpPtil1WHDDVP4HrDO81hTHeLDbQ47dzY1rNhVXr7EAXo4K
 IF1USt+SqFTuyZKL7KFKbwotgmfVB7uj606BsKy6Pf3sB/8xfsCIvVmOm/p1IbDSzghpGy3Ir
 /+pNTsEIWKkj/L8fbf/8A2za7vPQZ0Um4SubEr5pvPwsd28TL/6E/JDqET21O8nCuQm2rE8iy
 uYAgQT8kicpRScvyApMraBX0YglYoW+LptREQG+OxQ4UwuY9DsXsgc0tcUWKR4+XZ1FbGQqLJ
 LDAHumL2Ev2IEqz+qMXAZFLTUE5g35bsTxRiblclOZXA2+0yVR28ruGgZHWgdkdw4+NrpS06E
 LV1ffxMLSZrsAACmc0YaDNz29qR0t/WJlekjCAFg9sRPu+OVgaQboR22+T0k10s4rLeKmeeIa
 ATe8r/61NMQ1tOEPBgY3rW/gxXOy7oROI1Vme/LMCcd0I=



=E5=9C=A8 2024/9/23 16:15, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> NOCOW writes do not generate stripe_extent entries in the RAID stripe
> tree, as the RAID stripe-tree feature initially was designed with a
> zoned filesystem in mind and on a zoned filesystem, we do not allow NOCO=
W
> writes. But the RAID stripe-tree feature is independent from the zoned
> feature, so we must also allow NOCOW writes for zoned filesystems.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Sorry I'm going to repeat myself again, I still believe if we insert an
RST entry at falloc() time, it will be more consistent with the non-RST
code.

Yes, I known preallocated space will not need any read nor search RST
entry, and we just fill the page cache with zero at read time.

But the point of proper (not just dummy) RST entry for the whole
preallocated space is, we do not need to touch the RST entry anymore for
NOCOW/PREALLOCATED write at all.

This makes the RST NOCOW/PREALLOC writes behavior to align with the
non-RST code, which doesn't update any extent item, but only modify the
file extent for PREALLOC writes.

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index edac499fd83d..c6e4b58c334c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3111,6 +3111,11 @@ int btrfs_finish_one_ordered(struct btrfs_ordered=
_extent *ordered_extent)
>   		ret =3D btrfs_update_inode_fallback(trans, inode);
>   		if (ret) /* -ENOMEM or corruption */
>   			btrfs_abort_transaction(trans, ret);
> +
> +		ret =3D btrfs_insert_raid_extent(trans, ordered_extent);
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
> +
>   		goto out;
>   	}
>


