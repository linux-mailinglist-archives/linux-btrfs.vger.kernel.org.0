Return-Path: <linux-btrfs+bounces-3679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2BA88EF6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 20:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD1AB27525
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262261509A1;
	Wed, 27 Mar 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EYlA/HOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72F13E3E4
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568406; cv=none; b=QtQC6KSBO1BCBdEmnOFgYHKlU4xh8bsQDGcqeW30qTpXqYPy8S7vLEO+7qxz8Do58sBxLEYOcvBhNUKeZGtmhx4B+MKvnhTNOVmh/K0XWJep5iuZQtqCGpN52mHuKIf1JZ/Rgd/DXyhh/tGljael4Gg5TNUBHw6Z2lHuIvuyd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568406; c=relaxed/simple;
	bh=Qwo5s98+D0gdISZafRbTm1NQfEgS7OSjmGxCZlQeE0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjpKByQfs9LLeKUvO2Unh//KF/Tgbo8pxIGRbTlHOmKFGLN6kLF7S0IZzlSF0RYfBt8Y6Z2K3lgsrvNw5OlVG5nyfeSTd5RH5WgBwpvUZK+QgMG4Eq6yzZYHRDflw4t7QkshezBifVNphQh81BmUcA0p5DjrPoN7MCdmN80qwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EYlA/HOB; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711568382; x=1712173182; i=quwenruo.btrfs@gmx.com;
	bh=9IzEAwVCsGgrdmKNUPrh1XH1mP5SWp1D6ZLA1ADzmSI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=EYlA/HOBFkFpz2EhoqoJZW4nW7wLnHfHHYmf8iX6Liyrmecq0QId+eAWhyFF0jHH
	 71Ry2eQlHlF+L13G0MkePcl8Nau/E5quShvs9EykNCmfGRx8AKCdFrnkKng4yH2jv
	 DtBsHFpRyVflo6FArVB6K/KHASTRAb1RhiIxQ0lIJc34mI3X0AaCp1QuMEoAv1Pjt
	 PELawjZBdCOGlGarvdD7d7WGJuC94nCGo48JMTEF0AxCxc/jd2iG/kbI1cNGSmu0W
	 Kj5vOW2NEdMg2gzpiNrayiD6lqtTEnic2HpQbY70wwvy6gZF7zIwF6ZdURWzeA9ip
	 OqAZWWMl3OXQqPVJFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8ofE-1st1dD2rTi-015s9Q; Wed, 27
 Mar 2024 20:39:42 +0100
Message-ID: <8cd1d0e0-adcb-4f15-b0e7-b0e3b9b98ee7@gmx.com>
Date: Thu, 28 Mar 2024 06:09:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs: btrfs_clear_delalloc_extent frees rsv
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <ce7db2df5f2f7617ac37f7c715a69e476acc7f1d.1711488980.git.boris@bur.io>
 <586364af-9082-4b9f-b1fe-3ed75797d87d@suse.com>
 <20240327172640.GD2470028@zen.localdomain>
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
In-Reply-To: <20240327172640.GD2470028@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0rCvpX2iaFVMno+SgKXQWhVhvSdqUZq/F+8IU2q2loWwSdk+1aK
 ie3FaU6wUGFU53Eh3E9hMG6Ff6dT39S48/gaJuTr4t613cWsmFmZTmpjVW04qy4dbfdOb8w
 DaS/pMG5GmY0H5NTRpopisfNbDwPliRH42+EIeaxTV1GAHgLlpKs1BQdfuRV97gTv+1Ctca
 MrTAwIzFQ6N28Zo0ftIMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dbOQifent/o=;9eiHLwGUGO4/penvIMCsbb8vKwE
 HuFXDtjdKHWPjXQhh8wYtVYo736JjR5mrF4N8j2Gn9whDudcjz6JwOBEmg44xh9IlIJDslcys
 JO7UkjFA1msPJlbRtxLsMZt6cVGNBcLNU5hpfW+4+6C558d02HMJuIwBFPgiNy41JoFMHNhz/
 7GVpe4BjuxJGNXcCGfbFoEzbiZdyD1FMv0ILfTUOvgZxdKUgXeqUi6xaQUQeNOl4c/3LkLqIP
 EAhjgkKj4P56u1ob9aRQSVe3D+ybs36FgBKT0duQOQNWGjCdhJKbwEKZCfWd6qASoHQVvZ0yB
 Lwhun2SVNaj/9Rmy3WzUfrSbG7Gg+hwbEVL6/YXtIasNc38u/L4ArvrddkqNPH1oVu4NjRwDh
 G8R28YEpmGLrsMJWRWgdeAdBCi6pYw5FIvbaLvtc1nzRGd2imifyIl4DUlQWVfbX6vwJk7ewn
 ltOKm4Ir/gVEvJUOejNH9oadSn7rHxZiSRT/t9mAEynXEoxptn8cNq/EXAnXJuE+Pjf5U/Ini
 SidMgT98kruJ+SBEgrfM5tp7GxM2SnoKIKGxLdXLJuKhpalqW2cU29pglHziB/nXOyXDhXeBd
 zyZuM87Q+brtrJsKuIaiOLCj+WtHWcXgv/PyCqi5xAi131n5U1By9Sh9MtdJN4WtIlVx2Ebna
 d1X6NluGW9UgILZyAPJKeEkpYwGOjPhEdbszk18JrSoaAcmk6vji8HX0l+0XIYQJgdnSAj2bH
 FTcBSlYUvUuJbVOD6TDDHzECRXH+TrBc6k9Q6iVDbOVdPp7NMJjoD1mWBAwOW09geooMXe0w4
 kb4J6h0gDPaMcm/s9k8byMrQf8yly8nX3rrqDWQ6c8bNg=



=E5=9C=A8 2024/3/28 03:56, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Mar 27, 2024 at 08:56:20AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/3/27 08:09, Boris Burkov =E5=86=99=E9=81=93:
>>> Currently, this callsite only converts the reservation. We are marking
>>> it not delalloc, so I don't think it makes sense to keep the rsv aroun=
d.
>>> This is a path where we are not sure to join a transaction, so it lead=
s
>>> to incorrect free-ing during umount.
>>>
>>> Helps with the pass rate of generic/269 and generic/475
>>
>> I guess the problem of all these ENOSPC/hutdown test cases is their
>> reproducibility.
>
> Yeah, it is definitely annoying to have to run generic/269 and
> generic/475 hundreds of times to hit various different flavors of bugs
> and try to drive it to 0. :/ It's hard to be sure that you are actually
> successful and which fixes are definitely 100% necessary.

I'm wondering if it's possible to add fsstress workload to inject errors
(to specified injection points).

IIRC we have error injection points for ENOSPC and ENOMEM, and fsstress
is so far the most reliable reproducer.

I hope that can greatly improve our reproducibility on the error paths.

>
>>
>> Unlike regular fsstress which can be very reproducible with its seed, i=
t's
>> pretty hard to reproduce a situation where you hit a certain qgroup lea=
k.
>>
>> Maybe the qgroup rsv leak detection is a little too strict for aborted
>> transactions?
>
> I agree for aborted transactions. It feels like a cheat just to beat the
> warning. There are many failure paths that don't end in an aborted
> transaction that we probably do actually care about, though.

Indeed, despite the aborted transactions, we still have a lot of ENOMEM
(less common though) and ENOSPC (much more common).

Thanks,
Qu
>
>>
>> Anyway, the patch itself looks fine.
>
> Thanks for all the review on this series, btw!
>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/inode.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 2587a2e25e44..273adbb6b812 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -2533,7 +2533,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_in=
ode *inode,
>>>    		 */
>>>    		if (bits & EXTENT_CLEAR_META_RESV &&
>>>    		    root !=3D fs_info->tree_root)
>>> -			btrfs_delalloc_release_metadata(inode, len, false);
>>> +			btrfs_delalloc_release_metadata(inode, len, true);
>>>    		/* For sanity tests. */
>>>    		if (btrfs_is_testing(fs_info))
>

