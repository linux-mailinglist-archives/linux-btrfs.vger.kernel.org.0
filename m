Return-Path: <linux-btrfs+bounces-15869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC5EB1BCD9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 00:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFAE184F69
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FEE29B77C;
	Tue,  5 Aug 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cUHGuyHq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267529AAF0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434424; cv=none; b=JPr2tMh/VeBHznbgkveorngiOvpuoYEx0aLqnivExXV1M2nCkjMSbbojz/6y/o+xaY3ZLE08Xhuo8YSG297wwZyU8XOMM8Oo56C869cE5G6Vq9HbHWv0Hi5njbGCSgXBMfnp8lcp1DHj6LmqRIFQXwqUtvz59gklEWyWXWJSTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434424; c=relaxed/simple;
	bh=vi44sOhTeDOJUlxCQt01+5WzwqoRdAPtq6qTQsd/eTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTNRklMydhlGLLFVUDi/XW52mRp0mn9B4wjYd7qHbIXOzkpI2p2qAHk8M1rPLy/1PPnxgMO8pwMaQ7yDGyL8JPn+ChtE81F4aIUNKszCCJZGhtNoM7MowUWJt5Wjgj12TEY2tV710G5ThZaxD8M0sw3++Xn62EqLkXP3d+84Vbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cUHGuyHq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754434417; x=1755039217; i=quwenruo.btrfs@gmx.com;
	bh=iduncipNFMh4oLd4Yroj4N3cKjXaiA1gCZo/4zL7SkQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cUHGuyHq0YK300cU1+O1+GN0gl5M62ZB8QaFXO8i5H2behAcHM2kT3iZHC/VRkov
	 rP+tRRml0BMCa9ncA46V1LlBXfs63/PhGHX9cU5X8yzxkhEGd3yCyJuqA9FuyEI0C
	 aYugoUS43RJqRFSjA9LE0od9/Tj1BEXWR0ScKdJ9QbngSIS3R2rWFW8TZ3zYmaFhV
	 sF+q2yLARhDGz75IGI+Nf1LQlNB/nwzTNCor5YJl6TUhPq0HaXYpB7rG+ex4BZh7m
	 ZwhO+NbAT/ohXO5jSRQmvdHNEM7N+D8yaOesWFEA2KJ1x36S9XsMk0vHIp/Lg8aKn
	 2Klh/Piamr2QvzRWoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mirng-1u6oWi3BZ6-00blhS; Wed, 06
 Aug 2025 00:53:37 +0200
Message-ID: <4656f4eb-3189-4283-97e8-5d56a0946763@gmx.com>
Date: Wed, 6 Aug 2025 08:23:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs-progs: check for device item between super
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1754090561.git.wqu@suse.com>
 <20250805193458.GD4106638@zen.localdomain>
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
In-Reply-To: <20250805193458.GD4106638@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yKd0fWU4GEosuZNpwwjMXjwT/aTZXfdLuigqF1LMudiJ4zNURXu
 /9vRAsG1H50pUR3/gLFZo/F+PcwIl/7tjC/bFoXPf3o1otDCCqCuOPWjw7e+7V0dV/A93eS
 dG+cYCw2t9nL0xhf64IUzYaciBz4MG2HISRA1B+bBO4Xmj2hTnH79I9WTO/g6GXmGd9dSOF
 oohLADDtuzB5SQGscVjig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lfOTR+4gVrA=;UxzqBdSDPsgrMFawHTV47sEroL4
 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



=E5=9C=A8 2025/8/6 05:04, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Aug 02, 2025 at 09:56:18AM +0930, Qu Wenruo wrote:
>> Mark has submitted a check enhancement for progs to detect the device
>> item mismatch between super blocks and the items inside chunk tree.
>>
>> However there is a long existing problem that it will break CI.
>>
>> The root cause is that the CI kernel lacks the needed backports, that o=
n
>> a lot cases the kernel can lead to such mismatch and being caught by th=
e
>> newer progs.
>=20
> Can you explain why we are contorting around out of date "continuous"
> integration? Shouldn't we just get the CI on a new kernel?

Because the distro used in github CI (ubuntu LTS?) doesn't have a proper=
=20
way to install the latest upstream kernel.

Thus it means a lot of btrfs-progs self tests are out of our control.

I have a crazy idea that we include some read-write fuse implementation=20
into btrfs-progs, and use that fuse implement to replace kernel btrfs,=20
but that will be a super huge project.

Thus we have to workaround the problem for now, and I believe the github=
=20
CI is still a great tool.

>=20
>>
>> So to merge this long existing fsck enhancement, this series refresh an=
d
>> workaround the problem by:
>=20
> Thanks for putting in the effort to get the enhancement in, by the way!
>=20
>>
>> - Only reports warnings when such mismatch is detected
>>    Such mismatch is not a huge deal, as we always trust the device item=
 in
>>    chunk tree more than the super block one.
>>    So it won't cause data loss or whatever.
>=20
> That makes sense to me.
>=20
>>
>>    So even if the CI kernel doesn't have the fix, self test cases won't
>>    report them as a failure.
>>
>> - Workaround fsck/057 to avoid failure
>>    Test case fsck/057 is a special case, where we manually check the
>>    output for warning messages.
>>
>>    This is originally to detect problems related seed device, but now i=
t
>>    will also detect device item mismatch cause by the older CI kernel.
>>
>>    Workaround it by making the keyword more specific to the original
>>    problem, not just checking for warnings.
>=20
> I'm a little skeptical about reducing even the incidental coverage of
> the test except for a good reason.

Yep, that's the biggest problem, and I do not have any better solution.

We either:

- Find a way to use upstream kernel for github CI
   But it will still cause check errors for newer progs on older
   kernels.

   And I failed to find a way for that.


- Further reduce the severity of the dev item mismatch
   That's possible and workaround the fsck/057 by not outputting
   "WARNING:" at all.

   But that also further reduce the need of dev item check in the first
   place.

- Workaround fsck/057
   The way I choose.


- Use fuse from btrfs-progs instead of kernel
   The ultimate but the most time consuming solution.

Thanks,
Qu

>=20
> Thanks,
> Boris
>=20
>>
>> With those done, we can finally make CI to accept the new checks even
>> the kernel is not uptodate.
>>
>> Mark Harmstone (1):
>>    btrfs-progs: check that device byte values in superblock match those
>>      in chunk root
>>
>> Qu Wenruo (1):
>>    btrfs-progs: fsck-tests: make the warning check more specific for 05=
7
>>
>>   check/main.c                                  | 35 ++++++++++++++++++=
+
>>   .../fsck-tests/057-seed-false-alerts/test.sh  |  6 ++--
>>   2 files changed, 38 insertions(+), 3 deletions(-)
>>
>> --
>> 2.50.1
>>
>=20


