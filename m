Return-Path: <linux-btrfs+bounces-11687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7567A3F0EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9497A809D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83E201017;
	Fri, 21 Feb 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dEYI0KGe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246B3C2F;
	Fri, 21 Feb 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131281; cv=none; b=WRWS1jzsGUfo8SpiCfWgXlNiQJTUdgGAm0fCtcxuTnLlGZuLua3D7M1jlb8rm2+qe0ObPH84GX5L5f9cpKAtf6dd3e5lae4+wDQsnSb+7+jv4e2DjyfDI2p3x4ODpR8FxvtcbEkK3g9Ylvxs/QwnGsESu6kA1EtekzNVf3WDCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131281; c=relaxed/simple;
	bh=qFJMnFEfcqKyZL1abiaedRxQe+ORdAcLwUcinKcV7Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8je6jnwRsv1J7zL7h7IA5O4BuJF9UUKDdUQxcgbvkFYljSKk56FTXVPyXIxtqONPbExvovnFis75uhPQBIJdvjvVS3La0YFDHXx4s3x2e35FLFxIOTazKtvSxGETIt4+H41WVbtYN+OgdcQzftybISsqLhU/3rhFv1N+1ScOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dEYI0KGe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740131274; x=1740736074; i=quwenruo.btrfs@gmx.com;
	bh=sS5evQXjjiyOvkS4DryfI3zFqR0vRYSre8PjPIeulhk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dEYI0KGehacm9kfMpGBYlrVA82Fmu6dnPMboZVTYkZpGFo+GuqO5XXntJA2izaB6
	 B+zarco/CodRZz8ot4C9ulyYCXjYl2zQP2wOCZ3a40xHsLu7eBtAsXBOA3uScFi9o
	 YKd49Yo1ZfoiUtIr/jjuOUlg03SLj8we9j728YgBF6jOZZrdLV3ZT/tYiSU6DsaR8
	 zPKAMj6kFx477Q+C0j0cPKjxeBPrZZWXw33Mt0+pEGE3jy+pxhWAMbsM1jFZ4sPkw
	 U5HFX+jsfdhrpdIZ7/8/2Kq5ufnZl8UvAAPhi8hniwwT/LZyCoZox2vcLo8ByOFsj
	 MPel0UmmS7xKGYHWDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3DO3-1tka9c2RmH-006hmU; Fri, 21
 Feb 2025 10:47:54 +0100
Message-ID: <61afcaa2-01ff-4d18-a8fa-804fe36464cb@gmx.com>
Date: Fri, 21 Feb 2025 20:17:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Anand Jain <anand.jain@oracle.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
 <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com>
 <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
 <6bbfddea-f0ea-4825-a987-01be3ff18a23@suse.com>
 <CAPjX3Fc=E28A6zD4tJOT2bRZ-pnErVKzkYuzALt6soGLu=MRJQ@mail.gmail.com>
 <a2ae2321-4934-4a10-8a44-2f7dc3bf48c3@suse.com>
 <CAPjX3Fes+PDEyi4_tFJyRHePVVuv_K+nUfShEeuagOANd6VqfQ@mail.gmail.com>
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
In-Reply-To: <CAPjX3Fes+PDEyi4_tFJyRHePVVuv_K+nUfShEeuagOANd6VqfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ob3O56vlHMP/heZ0u1TdqRzgnGxShygpAZHflcJevPhPFXqFqqW
 nRyjBCYrArYgBFCtIjdY3ZyeubiFgQTc6nE24dj43Xuqnqdkj79nYuzHy4EWJIMKN+FebmZ
 UEi//bV19jZEDzu7DkTvT3s0AdATBzJFoXsX1mDL/LNMnmSQOK8Zmgmm0FTo8xF908om4gR
 h0f1xetC5UhQf3GApE3gA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QIqYiLPvqHk=;7hzS9Adh4M+ewbP9DK1Dtd9f9jw
 EQ2ePa38qq9ykN+fZgnrft5z+EXCS9/vcd/1Wp+I3tW33eXMVb9jGJHvZJxDbM8/mCkW7M76O
 WP2T+8QXLtLigu2pBK5uCtVxO4pJHYiI6PNOFgWDKs26TGT44Q9tDO36ZNstwPV8upy+FyCzD
 WJKxvge7U9LQxC1UQbphaGC5gV7l1kFsqE+AZHqcjNES9x3p8ECneBKRIQlIc+4T1/Z+4AoMl
 z3saHigaz8ivLxPwM1XGB+qOTe4ok6BmyiJHQMFN+7h8TCbcoidU758tuKRPtYkkaFW2hu365
 RzZFJke45lXw7o1PYVL90U6EZe4V1+Llv8X4ErD9kSlxcaHrLhQYERjpUQIt80r/lzGqIxz7z
 5gAQqMkdX9szpx7MYtXar80cLDzYorzUMQyLfPyFHr9wZr5zWFadm7T25HXj3aFb70ZmHVEkx
 A6ogl67juIv4V8l0jJu7IQdYyreQYunZx736IQnDpJct6fRuKtdISNUUmfG7eZ5rFIMMFGzQN
 dWyhxU89ulE83nDDKafNXQYxvdPFqbFoamts3qSk16olCGEQniv7AIRst+SUh24RSdpKulpN2
 2iQLbqE/xu5VLyDfkVPCWXMofq2L7xYzB/qLd0SjzNP2sikwKYXTFErI23hNCQpC67fex4z7J
 G64kmJiAxSpPO4gI0pc6NStXglUO63LRUAGpECXHdI1LWrATcC0Xw1fJCLWcOWZ5YEk4DBiia
 9vPdNTxIyZeoLr93GBbyjBfhC2Spfwr0RsOw3nBvgnXYSGcdnO/fb/lyAz3qEiDpzx9cdYxo1
 ZODfhXrDn/NV1JlYbLd+YjLFszQ4ehSP235ijfs4OB4ClXv3sOh+dOJkDX9og6Iq6RnVz6L7G
 VIMb7w9+GU0niBNdJ0HK13ZbWQK6bFLSHjUXxsk1QXzrqIVC2YbNQY5oeI/8AOGLYv9HQvbvI
 XRd114dBpA4oduQkZ6FSVD1kXgUd7Z1SBdnYiSG84feWDW8/q6SH4hrunaVugIgHH63uYy+kv
 LV7ol+TTVwLGInPNd0Qw2hCLtge8jYavi1twjYP5BCrRgprDXjLZrMQRG2DhXjQFWUh0dnWA9
 Gb1/5L7v9mZ79TfrGuYYfVonkKFoKNSlr1ICHTGC6y4thqsLDDrP/HL/Z46Vo35EZXKJMXg2J
 3fMmBwkO5/9VfvmC5Zo4hZtyA67pl2MPtpzHmlWZZzJMsxdAEzn3Cfzm14Yw4Pkb/3hnRfCHG
 47HI4AhRrJVyqL67vtR1DBc70toDbutdW+k3CnrMitTIfvYidBEnDwIDl9QPmR00w4LTehB81
 NXcADDnX5gffkzKAVNc3+Ynq+HgRpsx+Pbhxkf7t7clK9JzWw38ntZn7fKjGjGfbGSeI88Hfh
 d3DYWrzz6wWJFsW9LY+urbYXm0kIyiEsljPEjxXALynEv2jMhePoFYEmy/



=E5=9C=A8 2025/2/21 19:43, Daniel Vacek =E5=86=99=E9=81=93:
> On Fri, 21 Feb 2025 at 09:20, Qu Wenruo <wqu@suse.com> wrote:
[...]
>> Remember, user can provide their own mount options (including the
>> SELinux ones) through MOUNT_OPTIONS environmental variables.
>>
>> So you at least need a full reason why SElinux context must be disable
>> for this case.
>> And I see none.
>
> It does not need to be disabled. But it also does not have to be
> enabled for this test.

Then good lucky if one day some QA guy finds out the send/receive
behavior has a SELINUX specific bug, and you need to explain to them why
it's a good idea to not test SELinux for this particular workload.

Your mindset of "XX feature doesn't have to be tested" makes nosense for
a test suite.

> At least not with the default policy on the latest Tumbleweed I was test=
ing on.
>
> But your mileage may vary, I guess.
>
>>>
>>> Or do you use such an option with any of your mounts? I doubt so.
>>>
>>> Check the mentioned commit 3839d299. fstests cripple SELinux by
>>> default. Which doesn't look good by itself.
>>
>> Do you really believe that commit is going crippling SELINUX?
>
> Well, in a way, yes.
>
> What it does is that it overrides the system's default policy. Which
> may make sense, as for example your system policy may deny some
> operations the tests do, eventually resulting in failed tests.
> Though as a side-effect it also prevents writing the security label
> file attribute by design with the mount option override. In such a
> case SELinux just returns with -EOPNOTSUPP.
>
> 3213         sbsec =3D selinux_superblock(inode->i_sb);
> 3214         if (!(sbsec->flags & SBLABEL_MNT))
> 3215                 return -EOPNOTSUPP;
> ...                  ^^^^^^^^^^^^^^^^^^^

This only explains why your mount option fix is correct.

The send stream has SELinux attrs, that's because the original fs is
mounted with SELinux context (the regular _scratch_mount() helper added
SELinux context).

But later we manually mounted a btrfs, not using _scratch_mount(), thus
the new mounted btrfs doesn't have SELinux context, thus unable to set
the SELinux attrs at receive side.

It doesn't show why you need both the mount fix and overriding SELINUX
context at all.

>
>> All it does are just:
>>
>> - Allow scratch mount filter to ripple off selinux context
>>     This is only to make certain golden output to skip the SElinux ones=
.
>>
>> - Make sure scratch mount follows the SELINUX context
>>
>> Please explain why you believe that commit "cripples" the whole SELinux
>> thing.
>
> Well, maybe not cripples. It overrides the system policy.
>
> The SELinux is always tested, just with different options/configuration.

Not if you override the SELINUX context, then the test case will never
have SELinux tested.
And you never know if someone in the future will find a bug in
send/receive with SElinux enabled.


And I do not think your "combining two working fixes is fine" mindset
makes any sense either.

Every fix should have a reason, if you have different ways to fix a test
case, you need to evaluate the pros and cons.

Overriding SElinux means we will never test SElinux for this particular
workload, which is not a small trade-off.

Fixing the mount command brings no obvious problem.

So the choice should be obvious.

But combining the two? You have all the cons (no more SElinux for this
test case), but not any new benefit.

>
> Thinking about it again, I guess fstests are not supposed to test the
> SELinux policy and it's better to override it.

It not your call.

> SELinux should have
> it's own tests after all.

Say it again loud to all the SElinux guys, and better CC them.

>
> That said, I'm fine with dropping the first hunk when merged.
>
> Thank you for the review, btw.
>
>>>
>>> At least I'd say it's good for diversity to have one test different.
>>> Diverse tests are prefered with testing, right?
>>
>> What diversity? You just ripped off the whole SELinux for this test
>> case, that's killing the diversity.
>>
>> Reasons please, and "just to make it pass" doesn't count.
>>
>>>
>>>> So please only fix the mount command (with the extra selinux mount
>>>> option), without overriding the existing SElinux config.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Anyways, this test is fine without forcing the default mount context=
,
>>>>> which is more a bandaid for other fstests, IIUC. There's no need for
>>>>> this option in this case, at least with my testing. Hence I disabled
>>>>> it. Does it fail for you?
>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>>          $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo |
>>>>>>>> _filter_xfs_io
>>>>>>>>          _btrfs subvolume snapshot -r ${src} ${src}/snap1
>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>
>


