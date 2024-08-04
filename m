Return-Path: <linux-btrfs+bounces-6971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD14946DE7
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 11:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DAC2816F4
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230921350;
	Sun,  4 Aug 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LT+AvjlN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE95320B
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Aug 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722763383; cv=none; b=pQrDL8IUessD0Hr5V4mRDYSY0E7bhnYWacGXMB36DhQW8MqA0BxsY0W2r1ef+DVesxh3b+x8xVFpha8c2eMyXXB6ke6u3G2uDCz8ZFpEKYoRxomY6MY+NsMHyksu11hg5J1gY0ssHh7I+rfJbze07FYvqfLrfCFXG9OTwixDUK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722763383; c=relaxed/simple;
	bh=LORIYA1QNNUsFNc3F5FgT16nYWkHkWmr458bZX25mtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tk122k86gfDvLbBVn8vqTnWuwHraaPM2M644Qkkwr9KhXUVXZci+/fKBnnJgpnIOac4c1guGwH0CFQELhFKr1i1OsnNphN6qnqiTgPUMLfIDzkUeMjleWetbVyXaX5SoZDOyBuh1vmchi/fl1+hi6RdI42yFGGBMkxMt+0KJzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LT+AvjlN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722763376; x=1723368176; i=quwenruo.btrfs@gmx.com;
	bh=k4XGss9R1JKoMPn8Rwsev7bRmB1qt5akFbNpUFh5PLI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LT+AvjlNWQsAsXVmV+xH2bvweCmsLaqlvXrd34pHMRgflOrWpDxIex+M1xvo3bfe
	 VHEd5kS7/70MrGRjpj6srlbHXVtB+8bAfSOSw7DfuBzM+KKH7hOvOj7j0vBCxwDY1
	 AkvO+MRJrSDNFb1JNKzF3hOvMgJUjtAlpx8R19TvyHW1ir/YV5r9eMaDK0j2MptqY
	 XOs2d0GTNarhjVQGpzQ1Hf0Cs+0idNY7k2f2aA982AtvHdpoD1Ee8n6mLxu2ghA6H
	 XIIkoB6gu/zUMOUyLOgcIPYRgBIJFx6hKX09GljOkJV4iDtBT7zNKAsHfZHVVAbeJ
	 FQV+tYH582wCv/yZUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1s99EB2joa-00vPpj; Sun, 04
 Aug 2024 11:22:56 +0200
Message-ID: <ac63b2f0-776d-4a99-a495-ce9ed9a9180f@gmx.com>
Date: Sun, 4 Aug 2024 18:52:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: remove __GFP_NOFAIL usage for debug builds
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1720159494.git.wqu@suse.com>
 <20240705145543.GB879955@perftesting> <20240730135538.GC17473@twin.jikos.cz>
 <aaa0e841-fc2f-458f-9561-c7116c8a646e@suse.com>
 <20240731171321.GT17473@twin.jikos.cz>
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
In-Reply-To: <20240731171321.GT17473@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MYmnJkeND2dqwvT2JB+tSWNEdMcObi00/luGMy56pwTSRaV/ZLD
 pDG7/q/LlMGPk90CeWR4/f01jHgSuXwq1HrJiO/uohIY/iuwGGRN4ZXyL2smfcWJr9P6juF
 VXLx0oe1NM4MmpbTKO3O88v8M8Ig8OJ5YYLwC52DbHLe5s+pDDNhEHaqylLEV9+S1o8oaBi
 tR5Gmsv4YDoJV8PgV4SCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:voMp/H9aSsE=;RTpK7vRi0/i7K5TG8U24xMafNdn
 jTbrlx4CwdXHX3lsqzmjYS5qersNJ4EENUsawkHH4uFRhC2AGS06ibEp92OHpZNV6V0UXxy/D
 VYXh6KLey95GK2mDj2XwQyTDPWAMJ5wk4a/2ktsuX6TuY5nuc5aczp0wamy66Zk/2ZMG06vyt
 d/DQVuI2zzqlpbSdBjEgwnY0VsxJXGRg5svUCard/UEmt6LDcISbTOLppVGZ00OefoEXa1gpR
 ypIk83bSJb8tisGfFb5RqXYheDwiIfUrMRuAtAkMm07PHQDAtOGo1YrGPmVSRDTLzlrPS+C8c
 kfHb/3WYXaFrUW+hKBGoDhfKYPN7uAZ45VJ3pv+k8q54wCVgwhweQjQWy0H2tUSLfOyt7WK+0
 SJMFaH0L6M9R7OaFPx7o5WeQFSYxkyacvksyMA8Lc3J1fcQsUOAp9uFR5WeN0E4KzawTwTSn+
 n6jt+JjwAEqZSa6iR/fDmi0eJT7f1gOViZWFvUoh9OUg9Nu53NrebKcOKEAQQUTQ0j7yrVJDQ
 DOFyDnVia2UB5FvmtHu9VgNJZeZ2V/WuH+CMWM9V2Rv67bIx3uYDNVWofMEc0nWLAQsJHa4Jp
 846dFVFi1p/BYBqR6wvfjpOhhtxuEVFHrmtiMW9h3XLQF2J7U6r0iJKalKufgtDPyxjp3kHYj
 Nzzs1Puv3pDla4E8k1rHAzQyni1xluu8I5kITfMgzXhM4X9Vo4+fDUMA/lr3gyqL8iNLm9W69
 nsYtH3JmiXlQhHNSGWy5yMSUOt+n9BSA0ptpOoyEdcQhqxmey6AVM6pgy02XOZWZt0nDlCS2U
 Bb/6kPqKEI2Y05QN8URPldvT/tpWgkRXuI3D6m2AhdJaE=



=E5=9C=A8 2024/8/1 02:43, David Sterba =E5=86=99=E9=81=93:
> On Wed, Jul 31, 2024 at 07:47:51AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/7/30 23:25, David Sterba =E5=86=99=E9=81=93:
>>> On Fri, Jul 05, 2024 at 10:55:43AM -0400, Josef Bacik wrote:
>>>> On Fri, Jul 05, 2024 at 03:45:37PM +0930, Qu Wenruo wrote:
>>>>> This patchset removes all __GFP_NOFAIL flags usage inside btrfs for
>>>>> DEBUG builds.
>>>>>
>>>>> There are 3 call sites utilizing __GFP_NOFAIL:
>>>>>
>>>>> - __alloc_extent_buffer()
>>>>>     It's for the extent_buffer structure allocation.
>>>>>     All callers are already handling the errors.
>>>>>
>>>>> - attach_eb_folio_to_filemap()
>>>>>     It's for the filemap_add_folio() call, the flag is also passed t=
o mem
>>>>>     cgroup, which I suspect is not handling larger folio and __GFP_N=
OFAIL
>>>>>     correctly, as I'm hitting soft lockups when testing larger folio=
s
>>>>>
>>>>>     New error handling is added.
>>>>>
>>>>> - btrfs_alloc_folio_array()
>>>>>     This is for page allocation for extent buffers.
>>>>>     All callers are already handling the errors.
>>>>>
>>>>> Furthermore, to enable more testing while not affecting end users, t=
he
>>>>> change is only implemented for DEBUG builds.
>>>>>
>>>>> Qu Wenruo (3):
>>>>>     btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
>>>>>     btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filem=
ap()
>>>>>     btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array(=
)
>>>>
>>>> The reason I want to leave NOFAIL is because in a cgroup memory const=
rained
>>>> environment we could get an errant ENOMEM on some sort of metadata op=
eration,
>>>> which then gets turned into an aborted transaction.  I don't want a m=
emory
>>>> constrained cgroup flipping the whole file system read only because i=
t got an
>>>> ENOMEM in a place where we have no choice but to abort the transactio=
n.
>>>>
>>>> If we could eliminate that possibility then hooray, but that's not ac=
tually
>>>> possible, because any COW for a multi-modification case (think finish=
 ordered
>>>> io) could result in an ENOMEM and thus a transaction abort.  We need =
to live
>>>> with NOFAIL for these cases.  Thanks,
>>>
>>> I agree with keeping NOFAIL.  Please add the above as a comment to
>>> btrfs_alloc_folio_array().
>>
>> That will soon no longer be a problem.
>>
>> The cgroup guys are fine if certain inode should not be limited by mem
>> cgroup, so I already have patches to use root mem cgroup so that it wil=
l
>> not be charged at all.
>>
>> https://lore.kernel.org/linux-mm/6a9ba2c8e70c7b5c4316404612f281a031f847=
da.1721384771.git.wqu@suse.com/
>>
>> Furthermore, using NOFAIL just to workaround mem cgroup looks like an
>> abuse to me.
>
> It's not just because of cgroup, the nofail semantics for metadata
> means that MM subsystem should try to get some memory instead of
> failing, where the filesystem operation can wait a bit. What josef
> described regarding transaction aborts applies in general.
>

If you are only talking about the original patch, yes, we should not
remove NOFAIL for folio allocation, at least for now.

But this patchset is already a little outdated, the latest way to remove
NOFAIL is to only remove the usage for filemap_add_folio().

Filemap_add_folio() is only doing two things:

- Cgroup charge
   This will be addressed by manually using root memcgroup, so that
   we will never trigger cgroup charge anymore.

- Xarray split (aka new slot allocation)
   This is only allocating some xarray slots, if that fails I do not
   really believe NOFAIL can do anything much better.

So all your argument on the NOFAIL and metadata allocation no longer stand=
s.

Because I'm not even going to touch folio allocation part (even I still
believe we should not go NOFAIL for metadata folio allocation).

Thanks,
Qu

