Return-Path: <linux-btrfs+bounces-10359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497C89F1760
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 21:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E665F188C36E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526C8193404;
	Fri, 13 Dec 2024 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SJWkGf5z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4318DF73
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121734; cv=none; b=MmvjRNicJj8iJ8fmyGVZzsyCg7IgyDnaSTT8cMcktulhFKv9kWu/F08xiBQmZhIylxWjaKCEscs45LP7Sl5gfJbY6rJOLbNFhnVl97zYNNYjPgBTKjBXacTCD+8TnMMVS/Tt0grQhBzVp8fSAs/ypH+fNmmwztFmIaTFIEghmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121734; c=relaxed/simple;
	bh=6vucdB3OSNCSU2xYAHEfnkRxB4Dw+cDlEyp/6mSWdBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bocc0pt4SDZKh4nHHqTvYTJHIJZvIB0gVff7dgZ05JaLo9npoEkvNby8dBPLFf4ey6uDLFMWNZ0J9/vu3Hcsg9a4NXK/0kde3Iy9jv5M/CRmE5e6lqk2GtGUi/Zc7FxXCMOsidR1HJC+UXVKjS6z1OGdo5F6xZW7ECxAqSMEeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SJWkGf5z; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734121726; x=1734726526; i=quwenruo.btrfs@gmx.com;
	bh=6vucdB3OSNCSU2xYAHEfnkRxB4Dw+cDlEyp/6mSWdBQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SJWkGf5zqNSYykS3G8h10YEItf29Na1ewCtj5bE5R1P83IMjqtCVLc2wbk1qcpmZ
	 pG4Fka1Ip0i1a1ak11Uuk/b6+7f9HMxsABBGX9SbiTslX+lOwcxOr+/bnyH3pn4Lk
	 RRdpkpINxz99aFvXiQxW3qpKSgkA98cIQngMqK25L7jxPyrnWhkygJyk50Y3TtzsK
	 itbosFKl1YfTv3/iIfXAAoHBO+Xvh1NHt/5v++SXiMFeSqNiTXVKy6roinw5V6e+S
	 SMrSceHGVgYlOHWyiSsY0A3SN8LIt03JcP3b/Hz6LwWa1bvUGKardyEo0f/eDYicg
	 8TjLkgW1/8tb04yFIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK0X-1te0D63hPV-00s2MC; Fri, 13
 Dec 2024 21:28:46 +0100
Message-ID: <884e3ec3-dde7-482e-9d46-9ceb3650389f@gmx.com>
Date: Sat, 14 Dec 2024 06:58:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
To: Lee Beckermeyer <beckerlee3@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1734033142.git.beckerlee3@gmail.com>
 <c80d0f92b73983e7454291154b3fb6ae555f6053.1734033142.git.beckerlee3@gmail.com>
 <6c633f79-9808-4537-be9f-fc201c032a6b@suse.com>
 <fe2b0dfb-1b3b-4e98-8c81-b4dc98af59cf@wdc.com>
 <8ce3be5f-2a88-460c-b1c5-e80fbe349014@suse.com>
 <CAMNkDpBAUO4EDdKkXYZev8-aGoTM+Kz4sBNvOVcmVMV+b91xfg@mail.gmail.com>
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
In-Reply-To: <CAMNkDpBAUO4EDdKkXYZev8-aGoTM+Kz4sBNvOVcmVMV+b91xfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ud+g3E9y1Qynsznqz1ibI7al6cPGQ17zovPP3uTENGu0rqAKRSo
 cLQJBbLjAL8NA9NXtDKKR9wDEaUzd/thMxQnMhTDwN6Q+OVR+aHVPRzcUuaiQBklQSmeRMd
 klQEbwdzcrwgnZVzxHbWeuQRmhlAavZ3ntKYkeGgm9SL59ZiKBZ8J1W3HnwfqUjOHwOzXEr
 keK9ryLgAGTYda75WDBkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V15GwjSnK6Q=;uZyzT4rF5F3yzCS6U4F7YVK0Sh1
 Q1+u3H9o3rbgwRtBlUs7i16tP92ap5j8W3yfLzm6EtnYpM/FHZVOKDmdjkStYw/2WalQGYlOM
 tDHlpK2Wv9oaFpFmF/rYwT3xriKSlmohn7MEO5HAX/+L4ZczazwrvGWUcyX9oZD6PHICXMiUD
 anvMVAsL/7evqPdYe/4S5W1/vHj0Ir60TtDSy5B8t30wwfejWejAaqkkA+sT9Xvv/VY6yFzLC
 xlvhXWdU7M+8DqmijooD2bHhKReNNk1Ud+7y4YKOzrf8wYSHgUNjr4TRx7OtszGBWBaAYBdvb
 Ka+iPqYmDpdoa9ObQEPVslRsAbOWunum5F2ZMFd9bEMAO/sXddIaVLHBUyBlg6ygWSpnfu4ZZ
 dU8QaXttUkPJIsySuSWrv6+R3wXXugbeIXwV+fh7/AIemH/RgUZDbwmlllwqg2ozXlySc84E7
 1tCRERCXOsxiEB9uOVqVnZ+mXOgk9CnIF9KUgzWhPfhxgkJe3Mv439k1Vyov7TARqButT9zmI
 gxw2ElR+IDYnh7WlZ+N6uVVPHleMHklMkPuwyejpwG5mR/VbWvFbgaOVZDaM5i6NiB2hCSTY3
 jrpE0OOC/oFVKnWCUv41jPIbPzb+1OrM2pkqyvPVRmBkT5Ivm/L7uSQYJQIOXdSTG059qX77d
 C+WOMcSZy0FYMXkGYlgU5UsKh5uYaoTxRlx396e3/ORzQhsIDa21fVqJX20eUC4UFd5dwQne4
 8oEUlNUa15xnuoArrtANlTidkHU88V/zdNbIOB6IqvsZzzi3iOEveV/VWZc8tdU44rTceZ+DR
 iJ/EoKQrFwb5qFsc7IJin4KmUxeJXgZ+fFKLrTqU2JU2ybDDVdJ7F6er77i8VjPDGpiH0EJfx
 YXLsrPOZNRivVLQNvBeRA+RiRgGTgWP+TA1yBaolYtXcH4KaUXKBSCxsVOpagiBwpDy1rQvux
 WoJ+iUnmnNouTe06hFhDiBVinS5dSgR9VsuntZaFrSsv4I8Lp0jdyDbs4mG/OT9Y59ID5MMum
 t8pzPPyPpFN7UPfMdq5XepdHxwKWEoqwzKPWkJwgRJHWE2IbFSu5Ti+njCi1HqwWB29+f3Eqy
 OVbhX1LyAoB8clkgH2FMyxkFtTBudV



=E5=9C=A8 2024/12/14 03:44, Lee Beckermeyer =E5=86=99=E9=81=93:
> On Fri, Dec 13, 2024 at 1:32=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/13 18:00, Johannes Thumshirn =E5=86=99=E9=81=93:
>>> On 13.12.24 07:19, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2024/12/13 06:59, Roger L. Beckermeyer III =E5=86=99=E9=81=
=93:
>>>>> update tree_insert() to use rb_find_add_cached().
>>>>> add cmp_refs_node in rb_find_add_cached() to compare.
>>>>>
>>>>> note: I think some of comparison functions could be further refined.
>>>>>
>>>>> V2: incorporated changes from Filipe Manana
>>>>
>>>> Firstly changelog should not be part of the commit message. It should=
 be
>>>> after the "---" line so that git-am will drop it when applying.
> added it to the cover letter this time, also was more thorough in
> documenting the changes.
>>>>
>>>> Secondly if you're updating a series of patches, please resend the wh=
ole
>>>> series and put the change log into the cover letter to explain all th=
e
>>>> changes.
>>>> Updating one patch of a series is only going to make it much harder t=
o
>>>> follow/apply.
> Roger (pun intended) I'll resend the whole patch series once I get a
> reply on this, I've been utilizing the help message on the first
> message I sent so it all stays the same more or less.

What do you mean by the "help message"?

> Should I not be
> doing that when I send a new patch series?
>>>>
>>>> And put a version number for the whole series. It can be done by
>>>> git-formatpatch with `--subject=3D"PATCH v2"` option.
>>>
>>> Nit: git format-patch -v 2 also gives you a nice v2-XXX.patch prefix f=
or
>>> the files as well as "PATCH v2" for the subject.
>>
>> Thanks a lot! It saves quite a lot of key strikes, and even added the
>> "v2-" prefix.
>>
>> Never too old to learn.
>>
>> Thanks,
>> Qu
>


