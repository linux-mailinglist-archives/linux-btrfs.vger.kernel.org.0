Return-Path: <linux-btrfs+bounces-10510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BE9F5815
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D2C167B97
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 20:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911651F9ABF;
	Tue, 17 Dec 2024 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RR8XWiiI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496061EE7CB
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468571; cv=none; b=DUrOXvfAwt/8sZ7Giavb5Jrfa6XohhF7MLFhqXa/CUsZWfMfp6s77gCAa0eGyEkCetD2Q1FVsEf7WfwqEwdKFCd1CiRIdq9TiKf+47cRlHH/5uF5UvWMJGgCPW4X+M3CGC74+M3RpP2/qfPg2fnlTcF8U7uIhLO9zbjhg0igDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468571; c=relaxed/simple;
	bh=WDjI3B8HGEcoDvfuzWmm9RtKr7vPsUkhZKRB1foXBYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3DV1TVTMMQZtAc3UOUagfrN5DEIjZTRUKW1MXTQ4TP3awQu8G3a1fd/HszWDSd3OgL/60FMpzHqWLiSutqDkIyHjUj21gWEoN9/QBDFUPYmsTChRb03Clz0XnEiGmMbcq6buafIF3Mty3SX44AvsVq3rGLJXYqcNUWQ/bMTybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RR8XWiiI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734468562; x=1735073362; i=quwenruo.btrfs@gmx.com;
	bh=MUurAzUeu9hkLu/AaFhXMrsozGNOeZHJxnT5mItkZ1M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RR8XWiiIgV7IpXhzmrvfUOGluKJGsMYq8zW9xQBsx85ZP1ctCMRF/LwbgGKjaHAL
	 2DGqlGNiu+Mr0YQtSmAmKh+RAdB8Dnad6iz4ySZ1vtVwyoZby+kTFsyhw69/uDFaU
	 gOE5kOOPpF/BZvlRZJLvnQ1GlLBeJl9ei3nuTtYBSKKS3VPAAdq1rcIQuG6/YFzWH
	 fa3M5VdeGpBUGm/fpcNFZRqfGIJkIUduYkLWK1cMNZznTRNKp50mq35/4MEbebmeW
	 fNUp7iYySKoWv6UGsTycmMcdnE2RzpbBvQ+yR0FdbA1ydFpl+v10Z/InE9PCsPvzl
	 TV5ZztN18BbMjjXLFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwwdf-1tlwPy1GAt-015910; Tue, 17
 Dec 2024 21:49:22 +0100
Message-ID: <d2af3a37-8486-4c95-b38e-7671466127f6@gmx.com>
Date: Wed, 18 Dec 2024 07:19:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] reduce boilerplate code within btrfs
To: Lee Beckermeyer <beckerlee3@gmail.com>,
 Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1734108739.git.beckerlee3@gmail.com>
 <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
 <62871028-9f70-48d2-9d46-3ae1f6a57505@gmx.com>
 <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
 <CAMNkDpChHpDFPi4JT08zhbygXSPHV-sbLz=fgW9Fe5ajp9s_tA@mail.gmail.com>
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
In-Reply-To: <CAMNkDpChHpDFPi4JT08zhbygXSPHV-sbLz=fgW9Fe5ajp9s_tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L7xYJydlYUucV0WMfX1rWsqC2Iy9i0sGeKjlivHNKaGc7//Ro0o
 A2mtMvLEUa1xnFOutj7468OQy06spkScfDhWzWAPZvHQl+57k1cU+lsl1qdDdct0d+I608K
 kqx6HNGcDthInNlSJwnAjKdQVgIMYbsjbtWdrRjTSZjmhuMp5Yej+FmRXSVfGop030ZxOVm
 BNiq2lIoPCqvoSmQ2prqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NMDRa43kg1Q=;hbmVcS0H/cIrvi0cPNqxukhfQwB
 rAVHyUUeYxPr5K/RtQMrjiEVAB50viJzFEfdtyIdzkufNCGt1Y1vr6disP6I6+gaVbt1DlwBP
 BhvUOA3aG2qpLvyAzTGUnusbyv8GWRu4KjM2CZLSl7I0ojhdJIRND4IoNA8DWHP6hvPL/fVT+
 fOyCL/ewWKfnGLSXkYXeRCRvgqWdYP9vOqSn3hH9wNnCAufIpT/UEjYVPk6FE8V97tiy2xplF
 7zVQyNUcWNT9+vl/ZrPibPwcJxbEkE1JF+x0WAVA+7OdAyD6aD1StR4EulVOAP2Yd7lwwPYOV
 Gzc3mk+32DeFu6j0gUdFempW8Awf7UWBJuAv1h7cLR8qzqAQ3ykKZtA0p0wfdTrqTQIH3MJrU
 jwpDnc4u6mI/IQLj8kNo3nXzZSOOQKL/c3OlkCMD78dJ5sADQlr9su4j7XuIP2UmHCUmr6jMu
 yqjISk0g1rMWB4DzY8hwxXFYvEk4N2D/dSAMmf77eA8tqBGmUht4RBS0imtIM8KsOFNZHi1d3
 RwfSoJ8lr4NGmdaiQ5yAEIRzYKw335aVDpC4wOthKyGdZbrSTB4BM+KQAcEsmTQ1z5ZCNrG0M
 WJxWkejgH8d/SKVdNKVZR2WiwQtNc3/ohhf3gvs8J5TJNOYcR/4+PuHVFo96r3orodN9+Qb88
 j8etfa+7ixNfIF9qSKlQSxRuEQ5B/2dBiZARcp7VPtI3EQiXqsFtW4hvNDH0Q/XpF+Zr26nWe
 7p1fjXUOdqOcnJoko/6LubAXprsC9sUI2VQckj87rnG8y3q/vW+Xa2D5VTAypexZmqMvTOBXP
 KtJCOPlGBSOwLEa3NUTL12+QBPBgcFaLkxZUlYEbLzriMVrBHKRoBZ4EvBhbHhu8xD5/RnNDC
 UdlxPmjH4OXP0igPwuDQgefXF0zx5ovtFOa6dlDY4eXwB0VFhhmODUbkqmN1L9ARSFWvwbUmG
 pnkQiG5hfAK9lXXwE2/+TjzlIvxUPaGSqBGLxDFgNyjWZhwoFunfs128XgMsCPfG6A7dRPgNO
 9UTDHmZMcPWbuTcYu34WbykxOt8RHTXP883ymkbH3c+LXazNGY4YgyJTo79A1BGV/gCA464dj
 m0DDClznahxpdnv/5Njr/o487L3WYV



=E5=9C=A8 2024/12/18 07:06, Lee Beckermeyer =E5=86=99=E9=81=93:
> On Tue, Dec 17, 2024 at 9:09=E2=80=AFAM Filipe Manana <fdmanana@kernel.o=
rg> wrote:
>>
>> On Mon, Dec 16, 2024 at 10:07=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
>>>
>>>
>>>
>>> =E5=9C=A8 2024/12/17 07:50, Qu Wenruo =E5=86=99=E9=81=93:
>>>>
>>>>
>>>> =E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=
=93:
>>>>> The goal of this patch series is to reduce boilerplate code
>>>>> within btrfs. To accomplish this rb_find_add_cached() was added
>>>>> to linux/include/rbtree.h. Any replaceable functions were then
>>>>> replaced within btrfs.
>>>>
>>>> Since Peter has acknowledged the change in rbtree, the remaining part
>>>> looks fine to me.
>>>>
>>>> The mentioned error handling bug will be fixed when I merge the serie=
s.
>>>>
>>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Well, during merge I found some extra things that you can improve in t=
he
>>> future.
>>
>> One more thing to improve in the future:
>>
>> - Run fstests and check that that are no tests failing after the change=
s.
>>
>> There's at least 1 test case failing after this patchset.
>> The patch "btrfs: update prelim_ref_insert() to use rb helpers" breaks
>> btrfs/287:
>>
>> $ ./check btrfs/287
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc2-btrfs-next-182+ #2
>> SMP PREEMPT_DYNAMIC Tue Dec 17 11:02:25 WET 2024
>> MKFS_OPTIONS  -- /dev/sdc
>> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>>
>> btrfs/287 1s ... - output mismatch (see
>> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
>>      --- tests/btrfs/287.out 2024-10-30 07:42:47.901514035 +0000
>>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad
>> 2024-12-17 15:00:35.341110069 +0000
>>      @@ -8,82 +8,82 @@
>>       linked 8388608/8388608 bytes at offset 16777216
>>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>       resolve first extent:
>>      -inode 257 offset 16777216 root 5
>>      -inode 257 offset 8388608 root 5
>>       inode 257 offset 0 root 5
>>      +inode 257 offset 8388608 root 5
>>      ...
>>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out
>> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see
>> the entire diff)
>>
>> HINT: You _MAY_ be missing kernel fix:
>>        0cad8f14d70c btrfs: fix backref walking not returning all inode =
refs
>>
>> Ran: btrfs/287
>> Failures: btrfs/287
>> Failed 1 of 1 tests
>>
>> So please fix the patch (or patches) and resend the updated version onc=
e fixed.
>> Meanwhile it should be dropped from for-next.
>>
>> Thanks.
>>
> Found the problem, it's in prelim_ref_cmp in fs/btrfs/backref.c, if
> you invert the comparison between the parent and node it passes the
> test. e.g. prelim_ref_compare(ref2, ref1); instead of
> prelim_ref_compare(ref1, ref2);
>
> I can dig into it but I've got a couple of other things in the queue
> right now so it might be a little bit. prelim_ref_cmp() could do with
> a logic rework as well as prelim_ref_compare() is only used in 2
> places within backref.c. It's just outside the scope of this patch
> series so I didn't dig too deep into it.

It's not the parameter order, it's the problem related to the parent/ref
usage.

Previously during the insert we update the parent/ref pointer during the
search, but it's no longer the case, thus the whole if (exist) {} branch
is wrong.

>>
>>>
>>> - The length of each code line
>>>     Although we no longer have the older strict 80 chars length limit,
>>>     check_patch.pl will still warn about lines over 100 chars.
>>>     Several patches triggered this.
>>>
>>>     So please use check_patch.pl or just use btrfs workflow instead.
>>>
> yee, I haven't built a really good workflow for kernel submissions yet.
>>> - The incorrect drop of const prefix in the last patch
>>>     Since the comparison function accepts one regular node and one con=
st
>>>     node, the last patch drops the second const prefix, mostly due to
>>>     the factg that comp_refs() doesn't have const prefix at all for bo=
th
>>>     parameters.
>>>
>>>     The proper fix is to add const prefixes for involved functions, no=
t
>>>     dropping the existing const prefixes.
>>>
> Okay, however, what do const keywords do that would require this
> habit? There's also a place in backref.c where I didn't implement
> const keywords.
>>>     I have also make all internal structure inside those helpers to be
>>>     const.
>>>     (Personally speaking I also want to check if the less() and cmp() =
can
>>>      be converted to accept both parameters as const in the future)
>>>
>>> - Upper case for the first letter of a sentence
>>>     I'm not good at English either, but at least for the commit messag=
e,
>>>     the first letter of a sentence should be in upper case.
> Gotcha, I can work on rewording those descriptions, just didn't seem
> very important compared to validating everything works properly.
>>>
>>> - Minor code style problems
>>>     IIRC others have already address the problem like:
>>>
>>>          int result;
>>>
>>>          result =3D some_function();
>>>          return result;
>>>
>>>     Which can be done by a simple "return some_function();".
> Where was this? I probably missed one when I went through these, sorry.
>
> Just to summarize, would you like me to resend the patch series with
> the below changes?
> - updated prelim_ref_compare to eliminate comparison error
> - rescanned with scripts/checkpatch.pl
> - whatever needs to be done with consts.

I'll handle the error fix.

Since I have already changed the series a lot, your update will get all
the existing modification lost.

Thanks,
Qu

>
> Thanks for your time!
> Lee
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> changelog:
>>>>> updated if() statements to utilize newer error checking
>>>>> resolved lock error on 0002
>>>>> edited title of patches to utilize update instead of edit
>>>>> added Acked-by from Peter Zijlstra to 0001
>>>>> eliminated extra variables throughout the patch series
>>>>>
>>>>> Roger L. Beckermeyer III (6):
>>>>>     rbtree: add rb_find_add_cached() to rbtree.h
>>>>>     btrfs: update btrfs_add_block_group_cache() to use rb helper
>>>>>     btrfs: update prelim_ref_insert() to use rb helpers
>>>>>     btrfs: update __btrfs_add_delayed_item() to use rb helper
>>>>>     btrfs: update btrfs_add_chunk_map() to use rb helpers
>>>>>     btrfs: update tree_insert() to use rb helpers
>>>>>
>>>>>    fs/btrfs/backref.c       | 71 ++++++++++++++++++++---------------=
-----
>>>>>    fs/btrfs/block-group.c   | 41 ++++++++++-------------
>>>>>    fs/btrfs/delayed-inode.c | 40 +++++++++-------------
>>>>>    fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
>>>>>    fs/btrfs/volumes.c       | 39 ++++++++++------------
>>>>>    include/linux/rbtree.h   | 37 +++++++++++++++++++++
>>>>>    6 files changed, 141 insertions(+), 126 deletions(-)
>>>>>
>>>>
>>>>
>>>
>>>


