Return-Path: <linux-btrfs+bounces-13967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE080AB4EA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714BE46065F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218CF20E70E;
	Tue, 13 May 2025 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="W0Efn1ay"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2851EB19F;
	Tue, 13 May 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126656; cv=none; b=cD0B46AJdeqCDw8NIOZlhf0SrSRyA1tSJIdg5w7UfSCl5gPnC9CBd5EefNC2LRUIBFrs3Z+icee40LSE55xToZFvpM7gGVvQ06/k4cR0nfxynriKctEwWP6dzsQ4ftZVXyJluH7DYl7gVZKeHhcMDjmmlkNVxAl6Pf6QEEhqj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126656; c=relaxed/simple;
	bh=4366M36hPXzK3V9yvf7FxQVbsjHfqA3iAowOcC45UsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYgkgmwiPso0u5I1AxiPG40X/6p4+2uZ04eUgPfWLc/mDDlitvnQw5CtOrl9oC7NOOG3QoxdODefFGSCeZdzCDYroRuY4QtVsZQAMETho90v5lxrHIFVvzjjOSS/qaG4rx1eyarBaLH1EnKI6yv0WHwntgu7pn+mja9rG+Ay5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=W0Efn1ay; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747126641; x=1747731441; i=quwenruo.btrfs@gmx.com;
	bh=4366M36hPXzK3V9yvf7FxQVbsjHfqA3iAowOcC45UsM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W0Efn1aynwJ7PuPm+XyrfEol/Z0SVETk6E/RJ6KLTTHH1BrRVJu2+V/NrklD6iqc
	 Ed3H5ZIPIp/7CcIUPgQ+GI1mu462pQrPth/ri/PXg6y30PzobGIn01xBeCY7Q2YrO
	 snYVC3GiCu7KqFc3Vn3Stwj4u03fa5VWM1H8eBPrLKUdkJU4Vc7FpFvMTViHocpJk
	 sh/EzB1ZsRIyBGUBaFTeUvsEO3UCE/uUPNGA2+dqeK5CkwuCva5Bwpwa42bYRkaFO
	 rl5zG1WFfHCCeJH2A8OSOZ2SQYmgn44qv9KEA6xfF4+0BQl1Geu1azn3VurDoC0eE
	 nUeR0HaVSZX747HlfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1v18vh3Yxt-00xfc1; Tue, 13
 May 2025 10:57:21 +0200
Message-ID: <0d50d010-0010-4cee-a663-c6e86b3b5409@gmx.com>
Date: Tue, 13 May 2025 18:27:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and
 rescue=idatacsums
To: Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@kernel.org>,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250512052551.236243-1-wqu@suse.com>
 <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
 <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
 <CAL3q7H4dxAGTK9XBe2Yeoywy7-HTktwt_Jcp=FE0yNYnrU8H0A@mail.gmail.com>
 <4208096e-459c-4379-99a5-6bf1defc65ac@oracle.com>
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
In-Reply-To: <4208096e-459c-4379-99a5-6bf1defc65ac@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Rk4xJ/SnAC6rlFeA1F6CXQK20XSf6nOVeW0vDlUXFu3Jm+V0RK
 o7zdwigU4+8/nWPuV2XMaMmdYqsZHcKEoJWG2P+tO27M7sAE0n6E5AEB7Ix+dgNxwDwj1fT
 N/m2yXtVBkDCdMiBuPN3TNMIbM7v5ZY+wSa9F0u0uy+6yopfFfNxHrhYSJ8BdarBz4jLhY1
 bRFnL4/wD4guz7hh0bW1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lf46yEjZsIw=;Ifoc0kRZf1r7etqpg2egINDkkXD
 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
 ApLdehawvICYA=



=E5=9C=A8 2025/5/13 18:24, Anand Jain =E5=86=99=E9=81=93:
> On 12/5/25 15:54, Filipe Manana wrote:
>> On Mon, May 12, 2025 at 8:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>>
>>>
>>> =E5=9C=A8 2025/5/12 17:14, Filipe Manana =E5=86=99=E9=81=93:
>>>> On Mon, May 12, 2025 at 6:26=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrot=
e:
>>>>>
>>>>> There is a kernel bug report that scrub will trigger a NULL pointer
>>>>> dereference when rescue=3Didatacsums mount option is provided.
>>>>>
>>>>> Add a test case for such situation, to verify kernel can gracefully
>>>>> reject scrub when=C2=A0 there is no csum tree.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 tests/btrfs/336=C2=A0=C2=A0=C2=A0=C2=A0 | 32 ++++++++++=
++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 tests/btrfs/336.out |=C2=A0 2 ++
>>>>> =C2=A0=C2=A0 2 files changed, 34 insertions(+)
>>>>> =C2=A0=C2=A0 create mode 100755 tests/btrfs/336
>>>>> =C2=A0=C2=A0 create mode 100644 tests/btrfs/336.out
>>>>>
>>>>> diff --git a/tests/btrfs/336 b/tests/btrfs/336
>>>>> new file mode 100755
>>>>> index 00000000..f76a8e21
>>>>> --- /dev/null
>>>>> +++ b/tests/btrfs/336
>>>>> @@ -0,0 +1,32 @@
>>>>> +#! /bin/bash
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
>>>>> +#
>>>>> +# FS QA Test 336
>>>>> +#
>>>>> +# Make sure read-only scrub won't cause NULL pointer dereference wi=
th
>>>>> +# rescue=3Didatacsums mount option
>>>>> +#
>>>>> +. ./common/preamble
>>>>> +_begin_fstest auto scrub quick
>>>>> +
>>>>> +_fixed_by_kernel_commit 6aecd91a5c5b \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "btrfs: avoid NULL pointer der=
eference if no valid extent=20
>>>>> tree"
>>>>> +
>>>>> +_require_scratch
>>>>> +_scratch_mkfs >> $seqres.full
>>>>> +
>>>>> +_try_scratch_mount "-o ro,rescue=3Dignoredatacsums" > /dev/null 2>&=
1 ||
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "rescue=3Dignoredatacs=
ums mount option not supported"
>>>>> +
>>>>> +# For unpatched kernel this will cause NULL pointer dereference=20
>>>>> and crash the kernel.
>>>>> +# For patched kernel scrub will be gracefully rejected.
>>>>> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
>>>>
>>>> If the scrub is supposed to fail, as the comment says, then we should
>>>> check that it fails.
>>>> Right now we're ignoring whether it succeeds or fails.
>>>
>>> Currently it indeed fails for patched kernel, but I'm not sure if it
>>> will keep so in the future.
>>>
>>> E.g. we can still properly scrub metadata chunks, and for data chunks =
we
>>> may even delayed the csum tree lookup so that if we got an empty data
>>> block group, we just do an early exit.
>>>
>>> Or should I do the failure check, and update the test case when the
>>> kernel behavior changes in the future?
>>
>> It should check the current expected behaviour, and if that changes
>> one day, then update it.
>>
>> I always find it terribly confusing when something is called and we
>> ignore its stdout/stderr and exit status - it makes one wonder why the
>> command is being called, if the author forgot about checking what's
>> supposed to happen.
>=20
> Makes sense.
>=20
> As there is no way to check if the kernel has commit fix 6aecd91a5c5b
> testcase will crash the system. That's a bit concerning.

In that case you can add the test case to dangerous group at merge time.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>=20


