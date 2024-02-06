Return-Path: <linux-btrfs+bounces-2177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F1484BF92
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 22:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3622F1C236B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45801BDD9;
	Tue,  6 Feb 2024 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wa7VycS0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DF1BC35
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256392; cv=none; b=NcGez2LVylsu4aMgFIMV1pMKIp3vhZnzYmGIEKXC9t43SQFYxjIhbyWWRkBlo/CRv1y8Z5EM3EVXfJEmeZ+Skski/hyjVik9rZIrAPWCFf4DsVO7XGoFgGceps0nzK44N3l/tQomnZUV5ehMWc0X385MW1TKQqMS+Glc4YiFdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256392; c=relaxed/simple;
	bh=C4dkAGLtl87r+uk5d95qI/i8Iuh6LZ/fJai/KYa5MYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bpjvv4yXvOlfmtXbtfSoxWZnmVDXuhVL6HDZF8Ll5Cn38+1AH7mPWHkxmJZQdEVmRX1tsRheG4vC4nUvnRX9dxMgINzmTnNM0vCIWYDdyBgogJ9Fotv7+dk6+8Q50DI+16k+p6QbyT+zasOohFfjlpCKZeHlwKN+envUTGuquqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wa7VycS0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707256386; x=1707861186; i=quwenruo.btrfs@gmx.com;
	bh=C4dkAGLtl87r+uk5d95qI/i8Iuh6LZ/fJai/KYa5MYg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Wa7VycS0vnv4MEqv2LDfXATod4CBGx/azF+/qrcuDYs0NaUa2albScQxEFutivtY
	 zoJ2OypvzAuMcLHaFUO5HVn1ZEwn+jdEYr3oKlP8DBapEKw4oeS0kiYdGlipvpTzP
	 G6ZrZ4McuknbmJGmWYR9BsMqBnDkAMuHQxxdXK7qAtJ4DFJonCb6ijhh6bo11+XI4
	 ZRrP9rCymdiyu4uq7T3kI0uwMkbhSk/K0uY7YQ+oMYZj+dwMK6rO9LQ1/eJvGfCkW
	 ZpQaXqAVHC2yayVlxa0N+9xsjFmWi3qOyt0Yodvi5Rdc7JX8yZRuAwFverKvybap8
	 eGm9nSO1penWkgWpZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4Jqb-1rXkUS3Cj3-000OZP; Tue, 06
 Feb 2024 22:53:06 +0100
Message-ID: <2cddff2a-ac98-44b3-a689-3f640d0e4427@gmx.com>
Date: Wed, 7 Feb 2024 08:23:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
References: <8932de78-729c-431a-b371-a858e986066d@gmx.com>
 <20240206201247.4120-1-tavianator@tavianator.com>
 <60724d87-293d-495f-92ed-80032dab5c47@gmx.com>
 <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
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
In-Reply-To: <CABg4E-=A+Ga2RtTW4tdJUhTQSNtg3HAvSYmGQaoPKJ-qh-UVJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pPn/asTeYStmFwW9pRYkjOk9scAYB0jCm32I57khaEIK7EIoc1X
 eTNhmXUZAdCR9mlftyiRMKxfWFc14wXjZgi1iiCjJpSUJXgy2mK+VVrDN75maT/sa93JfFX
 UofrDTkdq+kHrpqcqUxooTU3qaalSt8tJanDE+oZ7FDlv3gRA3BS7c3xq2niaPgeuwVdHUH
 PEiWLY2k23QXaDXSIui9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4SngBrhyL1c=;uLYvcoZ8MtHOEBKds+ljBBGZrjL
 7vgatnohKDZmtJO0XjaagH9EQ3Z4akng9Joot1pkjUTaD2LfXRSGLanMUDtIaMlocWRLhzfVZ
 2PLYjfRXNmVIGEoR8QIRTbu4KFgACYZm/5E2ysd3NB42RT1X+5kHDaUg6HjtsbE3fHLfjpc/r
 mu9gd1YAEkx+5KzYv2J6JYiTECfhy4eEvx8aN1ecWd4LojQdFu6RnWxfw0Yh6/IsLMhtAcsoj
 0rqHg9fiWDRJbg18d4m5hMOfmY/XQja78e285QysEcODfKQV/EzIcsGTAj6RMAH+DM7UfX5+z
 MRvOTv8VaLRN5Lao2W+beVoEFa6EYEu976/MZVk4NdQRHYpKYOfPjTk2pZePlbIBAXKvuVdoU
 JtCtQnuA6ky6XQQ9RV1d8Vogx6fq9PgzRn85CELlgSgc07VuwDmQ6og39xxu6qV3sJMptsa6w
 ysIJdtBmOeF0QCcJN4rBo2L0sT12s32Cr9l57tYsyoXvz4ZkukuBHjDLkxLjcg9uSTR/1b3Bc
 B6+KGSDZ3b1XSJPcn/CtIdWkIBvwLHuO1hu4sUGycs75tUmoSIcbPYLk2VOy4LlUsBgjgWF9x
 g76HnJ9Q5v3A9hzcSZUCx8VjejwBWOqq72WAaHaFLpCDQdrLOxA8R9Wdf44zGOttlyp5Vhsoj
 7IWgTX5SGbJ1zjdB99D0ZidC3tipHqOwNhgxjvuLD13oDVCYk5pSnQWG0eNdTjYEqwQbV40ce
 W8z1a7ErHpFlLbzDvr87YK3z+t1aw88Y+z62BZsqj09bzoxYnekQ8qTcb3Cy7uZr5KrNa8nnM
 b5R7yV8bEJAnbwwjHcgx26sBKyMPTtRr2Wc7QKURd9xro=



On 2024/2/7 08:18, Tavian Barnes wrote:
> On Tue, Feb 6, 2024 at 3:40=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>> On 2024/2/7 06:42, Tavian Barnes wrote:
>>> On Tue, 6 Feb 2024 16:24:32 +1030, Qu Wenruo wrote:
>>>> Maybe it's missing some fixes not yet in upstream?
>>>> My current guess is related to my commit 09e6cef19c9f ("btrfs: refact=
or
>>>> alloc_extent_buffer() to allocate-then-attach method"), but since I c=
an
>>>> not reproduce it, it's only a guess...
>>>
>>> That's possible!  I tried to follow the existing code in
>>> alloc_extent_buffer() but didn't see any obvious races.  I will try ag=
ain
>>> with the for-next tree and report back.
>>
>> The most obvious way to proof is, if you can reproduce it really
>> reliably, then just go back to that commit and verify (it can still
>> cause the problem).
>> Then go one commit before for, and verify it doesn't cause the problem
>> anymore.
>
> I just tried the tip of btrfs/for-next (6a1dc34172e0, "btrfs: move
> transaction abort to the error site btrfs_rebuild_free_space_tree()"),
> plus the dump_page() patch, and it still reproduces:
>
>      BTRFS critical (device dm-2): inode mode mismatch with dir: inode
> mode=3D0142721 btrfs type=3D6 dir type=3D1
>      page:000000004209c922 refcount:4 mapcount:0
> mapping:000000007cadbbf5 index:0x8379d17c pfn:0x13ca315
>      memcg:ffff8f2cba7d0000
>      aops:btree_aops [btrfs] ino:1
>      flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|no=
de=3D2|zone=3D2|lastcpupid=3D0xffff)
>      page_type: 0xffffffff()
>      raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff8f1d446=
218a0
>      raw: 000000008379d17c ffff8f2faa26ea50 00000004ffffffff ffff8f2cba7=
d0000
>      page dumped because: eb page dump
>      BTRFS critical (device dm-2): corrupted leaf, root=3D518
> block=3D9034951802880 owner mismatch, have 15999665770497355816 expect
> [256, 18446744073709551360]
>
> Is it still worth trying that specific commit?  I'm guessing not.

Yes, still worthy.

The btrfs/for-next contains that commit (which is already upstreamed).
That patch itself has some bugs fixed early (before hitting upstream),
but since it's touching the whole memory management of tree blocks, it
is still the best possible culprit.

>
>> Although without a way to reproduce locally, it's really hard to say or
>> debug from my end.
>
> I can try to make a VM image reproducer if that would help.

That would help a lot.
Although the main part I guess is just the content/size of the target
fs, and transferring tens of gigabytes over internet would never be a
good experience AFAIK.

Thanks,
Qu

>
>> Thanks,
>> Qu
>

