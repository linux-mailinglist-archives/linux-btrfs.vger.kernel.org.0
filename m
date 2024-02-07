Return-Path: <linux-btrfs+bounces-2186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C384C226
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 02:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E461B237EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 01:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4DDDC9;
	Wed,  7 Feb 2024 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MMwpgPNQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DDDDA9
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270877; cv=none; b=i4IUdKesStE0A1SfpfB06KtvokWVkTxmXV6XoYzTo96ewaIGyrsVibJLPs0SIW6nFCNEITsazQqgGyQkRMjUF7Wy/JjI5umCEnoGXRhkGHalQEml2LzA4uretdh8P0iTq/OSIOIGjWKODJjZZdm/oyrYkqIpKKUqxd7OBZA1mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270877; c=relaxed/simple;
	bh=DRN1SqhuC13gyRbcVcG3ScJIDaX+uFBF4vESSDJOODU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgI9qP8q1Tg7GMjycMLjkOW/1AAtBbOglFudeL3pZjmhlC0K+YWDMGbKJ92RCjOYNbLFUkt5I9LY2iYq8Jc4eKicLx7+HKPI4z692Tz04RUtZLpKE3f6v2Cg95Z2hTZpoMlc51PkaYYU/a5Y0YKpzlzIZiDy/MEYIchI15MNNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MMwpgPNQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707270870; x=1707875670; i=quwenruo.btrfs@gmx.com;
	bh=DRN1SqhuC13gyRbcVcG3ScJIDaX+uFBF4vESSDJOODU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MMwpgPNQyhwW6Yj/jHpiLPcNr+qw4Sbf/m3YrA8t9EjnFaj4mctsId0rHJ/OepB6
	 SvvzSLr0myb10y+m9zHMOREFQ2UUgI5WCUEmD3wfzXBQHRR9ozXbljv8ZSV1E+kof
	 pCJqUadu/GQPWny2s4XaNXZfnNbfnvUlbIrRZ+HFCWW3C8WuoPNQwlCBsqNGvBIum
	 xbTn4G74v6DcBblZSk8+97dz6dATJwYWjN9+52HQ0ncPONXo6hZIxJ/z2B6YdzGcN
	 HeHsuywZQa599ib8RE5++JE9G51I++Iwru0fHPbNNXXBYHxF72u7RxtYeRIFn7yG8
	 nqqAaEpIRk8gaGpkyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUnA-1qfygZ467O-00raAZ; Wed, 07
 Feb 2024 02:54:30 +0100
Message-ID: <dffbe644-4852-42ac-a752-e9d69c5f6a95@gmx.com>
Date: Wed, 7 Feb 2024 12:24:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: avoid unnecessary defrag caused by
 incorrect extent size
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <abb506b3d54837f79119cdff6c3e08a61e28eba7.1707259963.git.wqu@suse.com>
 <ZcLWq9FZJvVAjN88@devvm12410.ftw0.facebook.com>
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
In-Reply-To: <ZcLWq9FZJvVAjN88@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rWIIKXRwAKxPMsLoKqY4AvTbRNFGv7d1vqLN58Z+6WaFiGKVEu9
 EeeOS4LWqsue+skjMMI52GfKrNvjOl63dshKpSla2+0cp53ry2IH5mRDrx/4txZhtpxQwmr
 koL5X5Zaz+42ay9GNMEko6coOUsQYSOWurRUZyJfI1Q4lCVrrPGF2SrP1h8u+fp+eRls6hu
 Sm2nu9n4bBMWbqtWH+VLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3UYGn4ig4eY=;csCR7mEuUVnyHRMLBxT08HqX3Xb
 2rrwFD/IEHhfAXmAFF4HQMKbc9mXDYTm9/SSfuHpvnENIH42sTdtfQMe0sVwr7l+zuVNZhn3/
 B/8eSL52DAO/ynz1mXuqnDCYat+NuzasgPfFNMy6PT4ZFlitFF8Nop1srykWp9UgtF3p0tACS
 kec2U888ELWrKBYk39ZmDEMxAYrOSEBFO5M/QPheCFXTiRiIK2phFgWlWXSvueyJcTqA0LSHa
 t5Z4gMFaLNzmFCDtaWdCYNn5B1VbZqPADL8rWZuyjajq4BacvJh5au2ub3y6n8OwZ3jrvZURY
 wwQFCkjpudEEQHZHntl+BCSfUGTkVt9Qzj85gk+iE2YTscnOl2Ups4MZASS278bbf/sLCRgKC
 mioqQXjfPhvz7brqMIZEMYdCiWRUZ7vuOlC3IbF5NBSLPMA9pPYrN5KrWecfo1LBW+HJ/nReF
 3jXeDCjzW2nB4vHoavqlvhBLLHTtP6HyETcKhQfIYgBA6dPBInW4y1xngaKdIJgh+7OX3oQbg
 b/hp2sbBQHj1HivHMYCcv7Zo0UnWMDuV/j3PwjI80neZBL1GYE+3/+W52T88Yw3WoFrumT9nZ
 ITJ8jInSE6siDziYuHnFtoQTYpDpgF2vjdEBLJLWWn2FaIKR1oeFqRMsvzznh7xeDtMCmUUwS
 fiTM3vHhbEYmNi1iM5Fc8dqM/fXB62OCX/tAkVqc5p/HTHXVCi1YLS6JSAs9J3du61P+dsxGP
 AoQUqvfn/q9j7y8hU9ZQ+ya1msLghjQgqKUWEmqcmSfRYy+To3W/RyEH9b2m5S5Pn8FKafmU/
 af3NxKuRM+AZj6FDo2Lfb15hB0rYyPOZsXESqjq17QCnw=



On 2024/2/7 11:32, Boris Burkov wrote:
> On Wed, Feb 07, 2024 at 10:00:42AM +1030, Qu Wenruo wrote:
>> [BUG]
>> With the following file extent layout, defrag would do unnecessary IO
>> and result more on-disk space usage.
>>
>>   # mkfs.btrfs -f $dev
>>   # mount $dev $mnt
>>   # xfs_io -f -c "pwrite 0 40m" $mnt/foobar
>>   # sync
>>   # xfs_io -f -c "pwrite 40m 16k" $mnt/foobar.
>>   # sync
>
> Are you planning to make this an xfstest? I think that would be good!

Check this one:

https://lore.kernel.org/linux-btrfs/20240206233024.35399-1-wqu@suse.com/T/=
#u

It goes with qgroup for accounting the real used space of the workload.

And I believe it can even work with squote.

>
>>
>> Above command would lead to the following file extent layout:
>>
>>          item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>>                  generation 7 type 1 (regular)
>>                  extent data disk byte 298844160 nr 41943040
>>                  extent data offset 0 nr 41943040 ram 41943040
>>                  extent compression 0 (none)
>>          item 7 key (257 EXTENT_DATA 41943040) itemoff 15763 itemsize 5=
3
>>                  generation 8 type 1 (regular)
>>                  extent data disk byte 13631488 nr 16384
>>                  extent data offset 0 nr 16384 ram 16384
>>                  extent compression 0 (none)
>>
>> Which is mostly fine. We can allow the final 16K to be merged with the
>> previous 40M, but it's upon the end users' preference.
>>
>> But if we defrag the file using the default parameters, it would result
>> worse file layout:
>>
>>   # btrfs filesystem defrag $mnt/foobar
>>   # sync
>>
>>          item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>>                  generation 7 type 1 (regular)
>>                  extent data disk byte 298844160 nr 41943040
>>                  extent data offset 0 nr 8650752 ram 41943040
>>                  extent compression 0 (none)
>>          item 7 key (257 EXTENT_DATA 8650752) itemoff 15763 itemsize 53
>>                  generation 9 type 1 (regular)
>>                  extent data disk byte 340787200 nr 33292288
>>                  extent data offset 0 nr 33292288 ram 33292288
>>                  extent compression 0 (none)
>>          item 8 key (257 EXTENT_DATA 41943040) itemoff 15710 itemsize 5=
3
>>                  generation 8 type 1 (regular)
>>                  extent data disk byte 13631488 nr 16384
>>                  extent data offset 0 nr 16384 ram 16384
>>                  extent compression 0 (none)
>>
>> Note the original 40M extent is still there, but a new 32M extent is
>> created for no benefit at all.
>>
>> [CAUSE]
>> There is an existing check to make sure we won't defrag a large enough
>> extent (the threshold is by default 32M).
>>
>> But the check is using the length to the end of the extent:
>>
>> 	range_len =3D em->len - (cur - em->start);
>>
>> 	/* Skip too large extent */
>> 	if (range_len >=3D extent_thresh)
>> 		goto next;
>>
>> This means, for the first 8MiB of the extent, the range_len is always
>> smaller than the default threshold, and would not be defragged.
>> But after the first 8MiB, the remaining part would fit the requirement,
>> and be defragged.
>>
>> Such different behavior inside the same extent caused the above problem=
,
>> and we should avoid different defrag decision inside the same extent.
>>
>> [FIX]
>> Instead of using @range_len, just use @em->len, so that we have a
>> consistent decision among the same file extent.
>>
>> Now with this fix, we won't touch the extent, thus not making it any
>> worse.
>>
>> Fixes: 0cb5950f3f3b ("btrfs: fix deadlock when reserving space during d=
efrag")
>> Reported-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Boris Burkov <boris@bur.io>)
>> ---
>>   fs/btrfs/defrag.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
>> index 8fc8118c3225..eb62ff490c48 100644
>> --- a/fs/btrfs/defrag.c
>> +++ b/fs/btrfs/defrag.c
>> @@ -1046,7 +1046,7 @@ static int defrag_collect_targets(struct btrfs_in=
ode *inode,
>>   			goto add;
>>
>>   		/* Skip too large extent */
>> -		if (range_len >=3D extent_thresh)
>> +		if (em->len >=3D extent_thresh)
>>   			goto next;
>
> The next check is using em->len and checking the max extnt lengths,
> so we could theoretically merge the max extent size and thresh checks no=
w,
> by taking the min of all the relevant options or something.

Indeed, but for backport purposes, the minimal fix would be preferred,
especially there are quite some code moving between the original cause
and later defrag works.

Thanks,
Qu

>
>>
>>   		/*
>>
>> --
>> 2.43.0
>>
>

