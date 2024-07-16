Return-Path: <linux-btrfs+bounces-6500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7C9325A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 13:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F49282508
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9D1991A3;
	Tue, 16 Jul 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DWTc6yDC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A61799D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129449; cv=none; b=LXOZF0xy76axiuQ4cKSnc6a2bGGFWxN64AkTYpWERaZaLyoZ3i9uS1GXAu7tquGjWQyzT8uqD1MjmOl9YHK8z2O5rHHCvueuvX8jF5x3m1IXWeoXrPyEq0adreyW1PAthGDvuqFETUOoWLsEOL1U8utR6TpoOVuH3EAq/4zFqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129449; c=relaxed/simple;
	bh=5qQdwNmlIFxm2e2ikRh7nZcDqGozPZuBatsCYkOMTMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjwWENlqAYoTf5CicVnVGb6qgdqsPz9JYGaefvWVM/qLiGVSoSGFkOEY2Cry2HgYpycOiVsJ8X1fSqt49C91Wdgxeeh4QkIv4/0i1L+3R0FKkMI8E4WbVLEK32Gra57tEHKwRmZB2nhm//qt2PPiSIJpz5FtUKX6Lq8hOhO1rpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DWTc6yDC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721129439; x=1721734239; i=quwenruo.btrfs@gmx.com;
	bh=329NqzmTfKM4CwawxE3jp5uvydT3wScjnEjWXQZcQB8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DWTc6yDC/qk7EU9vbDUuLK5TmgTkzHTg/FDc5rGcVct1zhhlzDwZi9AU+DNxHqzs
	 pwseZDSl0t06/on3xIx4LPpi94avLhRbgl5LZsxecEA0/3T+wzpdZHKWWoIVpdDgV
	 dsamfbA8ZEA5gMkbKGPrGjh6v9XouuPWraai/CokPJiax5oCaBXr6NaXNPfjNauyO
	 sWtwb+UDhvDnoNwTy4MblNvcCO679pcBWelmkPeTcdw2mFfEWvQ0Ypwj9TX5xl1c8
	 9m+L5J7pL+yls6tVBsi0r9PodVA+e3q/qlM1PRF99jd5QodwAGURdotOwxeUyIDSs
	 UJTIoULX5tkMtciKnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4Qwg-1sJLHV0DiA-00sHiB; Tue, 16
 Jul 2024 13:30:39 +0200
Message-ID: <35ff514b-25c1-448a-a9cd-7b7b0b3709a1@gmx.com>
Date: Tue, 16 Jul 2024 21:00:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix corrupt read due to bad offset of a compressed
 extent map
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <7e186f2d4892bf5bfa1a66dd859a38c981acf8ab.1721124786.git.fdmanana@suse.com>
 <e3161618-5e9f-477c-9708-3428136d1fce@gmx.com>
 <CAL3q7H7DWJm+X2G68dd0rgn94=jMKSKYw-3rzh_fjiMJZcgTgA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7DWJm+X2G68dd0rgn94=jMKSKYw-3rzh_fjiMJZcgTgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rVabBR8bOoJ2bDzmZc3TVq2ZaDg1vkw3lYWhyS7C6DhYrzquI6P
 urcjieoY3B2FRuqp/vMCIhQfB/Gh8ommVK+LiSsKG7jgpGPiAWUKr9MSKQAGUWf3G7/KX3Z
 zCdIy337y8prvB7d3RlFFM29OI3TqGWjBfIK6Up6sVIOqjrfJQERQxy2cDGZCZJO8zEYs1L
 Iwj29cnDZflu1ahG8fPuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:owcYXwEfcpQ=;D0vT9HYMHX86t4A6X2HqClj4B8Z
 G6DxmhUW8MD2wtui9RCHYj0ApsYm39D3spxx10IMLkt+zupg4Y0B2Vqhk+lwFn/C7c5WQHFeJ
 oMuxOM/GRfV+rVR8vpJDA3/ysZIP3nZdBC+ezxBAtu16519f1Tp4UnYyQckOQgmXtur2rRnsQ
 JibATcMrEZEdc5WvoVouAWxTwbGuQT928DK/X8k6tnJs17Um/tufqhZQ/X0wp3rqfhwpz30Qx
 RZdDFUhcYqyLpEWwlNxdLscBX2RfngElGrmvG5/BZy6OwKwBE/ztfJ0QdJaSU08eveF6qbPE4
 ZVLnNC9xh2yEzmvc8FR3veuOJqkdE//DBmUt55BXgs448+6gAR6ouaHsCCnny+6+vKDpOquGM
 2qmLsvL93Xr7qLE/A3Ce5IJdRX8ZwZhmJ27RpdyW76fVwA3QuDdd1YCIPaM+4457QIvN7BvAi
 GAfL81bLbEfMGwLCuxCkfNfeeIGpeqrXMhfrdrykMEJR1CQoSislkJvZXPS/EkwGJ0g2mVIp3
 UnghdG2xuiJE3rFSmpzP/gci/2TU3UWvQmJHb2ucdcn87HXWW7VLsuOD6GpaXNTcBQMrsesLp
 7A1fbl+OTqZ17QtCGF5hCZSlb+93CdIUDjh0XFdq0GRX8jKHumf62/lRrkeXtmZsI22xNFMzE
 I6ifZnikyaRdCwwbRy0fdNVs2sXiP3uFR+TCUpPZu/NIqqq1SylGRRVGzvtmWlDJWSCgf60mx
 P2TCTOJs3CybkAC//Gzwgi1aoLxz0qqvGRGQ3s4wVabA9N09b7X9df6OuuEpDndCZnL0hf7GN
 W1HYvtdttsEtA0o3IHtaF/GA==



=E5=9C=A8 2024/7/16 20:37, Filipe Manana =E5=86=99=E9=81=93:
[...]
>> However I'm not sure if the fixes tag is correct.
>>
>> The fix is changing the condition so that even for compressed extents w=
e
>> can properly update the offset
>>
>> However the condition line is not from that commit.
>
> No?
>
> That's the only commit that adds:
>
> em->offset +=3D start_diff;
>
> to add_extent_mapping(). How can it not be?
> em->offset only exists after that patch.

Before the introduction of em->offset, the old code is:

	if (em->block_start < LAST_BYTE && !is_compressed) {
		em->block_start +=3D start_diff;
		em->block_len =3D em->len;
	}

@block_start is the disk_bytenr + offset for uncompressed extents, or
just disk_bytenr for compressed extents.

@block_len is the num_bytes for uncompressed extents, or just
disk_num_bytes for compressed extents.

So for the old kernel without em member update, compressed extents won't
get any update at all, thus should still lead to the same problem.

Or did I miss something?

Thanks,
Qu

>
>> The condition is there way before the change, just the em member cleanu=
p
>> touched that line by removing the tailing '{' since eventually there is
>> only one line.
>>
>> So it looks like the problem exists way before that fixes tag.
>
> Nop.
>
> Try the test case for fstests on a branch without the extent map
> patchset, and you'll see - it will pass, while with the patchset it
> fails.
>
> The patchset had that problem I mentioned during review, that by
> adding all members and then doing the switch in different patches
> would make a bisection point to the switch patches.
>
>
>
>>
>> Thanks,
>> Qu
>>
>>>        return add_extent_mapping(inode, em, 0);
>>>    }
>>> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent=
-map-tests.c
>>> index ebec4ab361b8..e4d019c8e8b9 100644
>>> --- a/fs/btrfs/tests/extent-map-tests.c
>>> +++ b/fs/btrfs/tests/extent-map-tests.c
>>> @@ -900,6 +900,102 @@ static int test_case_7(struct btrfs_fs_info *fs_=
info, struct btrfs_inode *inode)
>>>        return ret;
>>>    }
>>>
>>> +/*
>>> + * Test a regression for compressed extent map adjustment when we att=
empt to
>>> + * add an extent map that is partially ovarlapped by another existing=
 extent
>>> + * map. The resulting extent map offset was left unchanged despite ha=
ving
>>> + * incremented its start offset.
>>> + */
>>> +static int test_case_8(struct btrfs_fs_info *fs_info, struct btrfs_in=
ode *inode)
>>> +{
>>> +     struct extent_map_tree *em_tree =3D &inode->extent_tree;
>>> +     struct extent_map *em;
>>> +     int ret;
>>> +     int ret2;
>>> +
>>> +     em =3D alloc_extent_map();
>>> +     if (!em) {
>>> +             test_std_err(TEST_ALLOC_EXTENT_MAP);
>>> +             return -ENOMEM;
>>> +     }
>>> +
>>> +     /* Compressed extent for the file range [120K, 128K). */
>>> +     em->start =3D SZ_1K * 120;
>>> +     em->len =3D SZ_8K;
>>> +     em->disk_num_bytes =3D SZ_4K;
>>> +     em->ram_bytes =3D SZ_8K;
>>> +     em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
>>> +     write_lock(&em_tree->lock);
>>> +     ret =3D btrfs_add_extent_mapping(inode, &em, em->start, em->len)=
;
>>> +     write_unlock(&em_tree->lock);
>>> +     free_extent_map(em);
>>> +     if (ret < 0) {
>>> +             test_err("couldn't add extent map for range [120K, 128K)=
");
>>> +             goto out;
>>> +     }
>>> +
>>> +     em =3D alloc_extent_map();
>>> +     if (!em) {
>>> +             test_std_err(TEST_ALLOC_EXTENT_MAP);
>>> +             ret =3D -ENOMEM;
>>> +             goto out;
>>> +     }
>>> +
>>> +     /*
>>> +      * Compressed extent for the file range [108K, 144K), which over=
laps
>>> +      * with the [120K, 128K) we previously inserted.
>>> +      */
>>> +     em->start =3D SZ_1K * 108;
>>> +     em->len =3D SZ_1K * 36;
>>> +     em->disk_num_bytes =3D SZ_4K;
>>> +     em->ram_bytes =3D SZ_1K * 36;
>>> +     em->flags |=3D EXTENT_FLAG_COMPRESS_ZLIB;
>>> +
>>> +     /*
>>> +      * Try to add the extent map but with a search range of [140K, 1=
44K),
>>> +      * this should succeed and adjust the extent map to the range
>>> +      * [128K, 144K), with a length of 16K and an offset of 20K.
>>> +      *
>>> +      * This simulates a scenario where in the subvolume tree of an i=
node we
>>> +      * have a compressed file extent item for the range [108K, 144K)=
 and we
>>> +      * have an overlapping compressed extent map for the range [120K=
, 128K),
>>> +      * which was created by an encoded write, but its ordered extent=
 was not
>>> +      * yet completed, so the subvolume tree doesn't have yet the fil=
e extent
>>> +      * item for that range - we only have the extent map in the inod=
e's
>>> +      * extent map tree.
>>> +      */
>>> +     write_lock(&em_tree->lock);
>>> +     ret =3D btrfs_add_extent_mapping(inode, &em, SZ_1K * 140, SZ_4K)=
;
>>> +     write_unlock(&em_tree->lock);
>>> +     free_extent_map(em);
>>> +     if (ret < 0) {
>>> +             test_err("couldn't add extent map for range [108K, 144K)=
");
>>> +             goto out;
>>> +     }
>>> +
>>> +     if (em->start !=3D SZ_128K) {
>>> +             test_err("unexpected extent map start %llu (should be 12=
8K)", em->start);
>>> +             ret =3D -EINVAL;
>>> +             goto out;
>>> +     }
>>> +     if (em->len !=3D SZ_16K) {
>>> +             test_err("unexpected extent map length %llu (should be 1=
6K)", em->len);
>>> +             ret =3D -EINVAL;
>>> +             goto out;
>>> +     }
>>> +     if (em->offset !=3D SZ_1K * 20) {
>>> +             test_err("unexpected extent map offset %llu (should be 2=
0K)", em->offset);
>>> +             ret =3D -EINVAL;
>>> +             goto out;
>>> +     }
>>> +out:
>>> +     ret2 =3D free_extent_map_tree(inode);
>>> +     if (ret =3D=3D 0)
>>> +             ret =3D ret2;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>>    struct rmap_test_vector {
>>>        u64 raid_type;
>>>        u64 physical_start;
>>> @@ -1076,6 +1172,9 @@ int btrfs_test_extent_map(void)
>>>        if (ret)
>>>                goto out;
>>>        ret =3D test_case_7(fs_info, BTRFS_I(inode));
>>> +     if (ret)
>>> +             goto out;
>>> +     ret =3D test_case_8(fs_info, BTRFS_I(inode));
>>>        if (ret)
>>>                goto out;
>>>

