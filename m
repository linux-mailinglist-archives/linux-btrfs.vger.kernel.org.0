Return-Path: <linux-btrfs+bounces-4000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF589A99D
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A28328398C
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4B22EF8;
	Sat,  6 Apr 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DXeHZUz3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D31EB40
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712389781; cv=none; b=sCm9oGkRvgzMT9poJj4OOJ1PjUDfdXVIaLY17T3cw6lgvKTntf4qMJjnA6Tn7CWjIgzy55Vnm5CmnWFEc99rn0/rkhNKGudJ11rZJffUrMt2s6sfK6PK+PGKoMy4970LxCX5SOJgqQlZpz6Ql7vxMPfVFd1fNRx3RHZO4Jr0ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712389781; c=relaxed/simple;
	bh=MNRzJepW4Im3ekuPn2A3DwJAzbfhzK4ggbzGg2AR2Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjvzqaRUD2cdW9bockgUwnlczRqkVlaDTrBzoIBDxNSLFTKbp4GT+sWMimRhg9imQXvTHPkuCdm4dr8dv8s8KWtWs1oQubKcb72V1KlNMREuyBH5z+A2vRkvFGtq6Rewn39BFQzCUii0Eu3dLGYUczV4wQISLm5Y0d063k0PuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DXeHZUz3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712389776; x=1712994576; i=quwenruo.btrfs@gmx.com;
	bh=MNRzJepW4Im3ekuPn2A3DwJAzbfhzK4ggbzGg2AR2Gs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DXeHZUz3SR5Sv4YYFmOR8W6P0ixzD2Jn1INuHr6RwXMqoUaaQjwRSCxhTK2MS9SW
	 cpqlrfJZ4sjXymry0Dfz3tQzJlwY2qPAERvmEUEoUkBbbhTFCEph+DuRNhHFUV+Y1
	 Ub7GOWvyGAEIpeIliwkFCsh7lOGWZ7/xXoh6avq/us5HJD0dBasHVOShgmkexhNDt
	 rrAzfK5JAVerF4nSFbQizaKdPNNYxKXbQAhgDVn7K0Wp6ekOltieNiFSgVk8mB3p0
	 DcuYWCb7iZNS4Zyy8Wk41aFSpydaImJQTHgwXKyZpaJx/j6fQymjB5FfZu/mwQL8k
	 Mcx/Yfj9RtCpKHz/Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUnp-1sheWE2urp-00xv1b; Sat, 06
 Apr 2024 09:49:36 +0200
Message-ID: <68a8b3f7-a769-4f50-9f51-bf1b4513467f@gmx.com>
Date: Sat, 6 Apr 2024 18:19:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Preconfigured BTRFS Virtual Drives for testing?
To: "David F." <df7729@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAGRSmLtrH7GNzAE2o69qvfEMk9mTR1a=zUq36dzwkCeQTz7F8A@mail.gmail.com>
 <f1e7424c-64a8-4752-8a36-fa08f902ce7b@gmx.com>
 <CAGRSmLuKoYmxVJ+w=Bb2RxXUi6Z79mU+yLmxhc_OfWtmkhFg8Q@mail.gmail.com>
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
In-Reply-To: <CAGRSmLuKoYmxVJ+w=Bb2RxXUi6Z79mU+yLmxhc_OfWtmkhFg8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jUa0HIN1wDZXQ+wLpSCamVpss1Nb4JNukJP0MSKQQdrXq3AQFz8
 VXMXwMTAAiAQtYpnI7m1F4QCd1VCw/Md0ZcZE0cIDNiYEXrVQM0hmc+nQ/snG0eLhViKcrA
 ifQsC2ma3Y9X1fMt/rgf1zzK5yRthQYWG/KkpinHZt9koPUwHfzIxG3Xpld07ZLOfMSaf+1
 iHFvAiOc9t/z14QxUP6rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gEw0trhuDmY=;ZLAPQTjVH8t82q3j7M5kSWOA/7n
 icY8WoFK+jG3pgpgzm2IPD7jRxUnP5QOy0g+RPsgrKQwgy3ib5Fl/f+ZGp9KXuNtCmgOD5/66
 XbiAr+v7UEdVX5rm3g9qQ3DUlxz7UC6QxAThjIXwDB5unRiZgP8oVooxRFeCUHLNzUUKEpEwB
 Y/UVJTIcEo2/tk7yZl9o3LPYVtmIbQX7B6jfQHSnHn6rMcIk1cA8Z3mHd/q9iMik4oRnrWVv2
 tFUqAupewKWsIGzvAcc9dmVg4X8v7ZY2ZWq32LSvyEbDlZOn/MweQKaFETq1GbTWWCPwKovJI
 /zVKyGYyf3PfaA92bPhEDae5aGtV6bD1dUz+A8sKl9njHOvRX7Fh4GsAxEAIvlz9NL1tD+ERU
 zdak9yzisP40zL9jcJPJ+J9cAdxs/JQ2i09XRfOJ3lfgqo4t4hyxz6fu0jH/DASFXE8vfV8nr
 k+FIwhSiOF1d0S1mOQ7S17cO8XaXEMagvvTVrGwRu1WKHdDPea56vGtD6MCeBrGTfYp1nA6qE
 4t26QWxyX+umLHI6kQTvheOvO0pjVCT8Fojw0NodkJVIlTFDkNlWNL3sdPEnTseLxlf9Rn19i
 M49arNnAji4JFmOm9tPTj4v58GttWfvMTlPJOFM98S2HiENvrMAyv5tCrw1sZgkGIUi+lj/3I
 PYX53xoaeSiky974aveg2Q/C1/yY29odNHr0MCfOdjeFSu7VoxPstOWjcML33bz3NB6j6dfEa
 IDs+Oe96oN2M3FZoVl+Cg1Ei8jsy9Y+Hl3TntThvdH5/0cYP+gzfiBYRUQRUf3mxS5KyrCLZp
 dQLhNuSJXLb4NoOrkLYmtVRFnd0XnyfYu/MOjGZgy9unQ=



=E5=9C=A8 2024/4/6 18:01, David F. =E5=86=99=E9=81=93:
> How can I set up btrfs so that the chunk_tree, extent_tree, and root
> of roots all exist with all 8 levels (0-7) in use (or say I only want
> 4 levels)?

Reduce nodesize and create tons of inline extents to boost subvuolume
tree to increase tree level.

Other tress are pretty hard to reach that height except extent tree.

>
> I just need it on a single drive, a .vhdx, .vmdk, .vdi type file would
> make it easy to grab and test.

What kind of tests?

Aren't fstests enough?

Thanks,
Qu

>
> Thanks.
>
> On Fri, Apr 5, 2024 at 8:47=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/4/6 12:04, David F. =E5=86=99=E9=81=93:
>>> Hello,
>>>
>>> I wonder if there are preconfigured BTRFS virtual hard drives setup
>>> with all the various conditions BTRFS metadata can be in (leaf only,
>>> max nodes, new format, full drive, etc..) for testing purposes?
>>
>> It's not possible, due to zoned support.
>>
>> A virtual disk image can not easily tell a VM to emulate a zoned device
>> for it.
>>
>> For features other than zoned, you can mostly specify the feature at
>> mkfs time.
>>
>> That's how we handle it for fstests.
>>
>> Thanks,
>> Qu
>>>
>>> If so, where can they be downloaded?
>>>
>>> Thanks.
>>>

