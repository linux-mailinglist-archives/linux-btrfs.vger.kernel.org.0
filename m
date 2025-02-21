Return-Path: <linux-btrfs+bounces-11709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F9A4030F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 23:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED913AD629
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 22:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055C4254B00;
	Fri, 21 Feb 2025 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sRm1YLbX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5432512DB;
	Fri, 21 Feb 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178480; cv=none; b=l5+mQxvtBxA3UGl/hpQDX3sZrKhKEYB0OfhnlTI/XnHpGQ0yvSZd4OYiOSQGwqqjWRv85LNXgwxQ39KsaLh0bjynvEqhsMStBtaiqLH+P6Q5l4fRBBYfx87vLalivLEybR4dfq0y/ZFq5PRE+uJfeqJX1V38XrcF7B26cVro4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178480; c=relaxed/simple;
	bh=V67ND5ofm+34Y/67/YRqBVsDctXFvPGg+++fjqs1jQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILn2owDOtl/25BaUm5yXKyKRDq9yO8hH5nO6nTiLWqWQf/Zonz64SIJS2FF/XDh69C6Xj5+w5vcqL4qahuPTxl4SuIQdz2/VU15guA48b8ZmEq9uuDvJwSL/GMnmMSZix09D9AnrwRGxpBPch1Yyo4vJgWcFeOcWMJxIs4UfvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sRm1YLbX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740178472; x=1740783272; i=quwenruo.btrfs@gmx.com;
	bh=p+xKtbzm0BmoCB/4il6vYlQKZI+f4L11NLxsJbS43tI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sRm1YLbXyJI57DlvPGxCWUkNA0T2OtiflX+dPLbXJknd3kH9j++7zstTJfUUNHYV
	 OvhD+iCzziCxUavhOppBT/W8OPzhOj+qphLMdfLKlVOC3v4TdoZTRB817No3b7ba5
	 KfT4QWlwnK95owv5aSYu+GRUfohrBFElLqC7EMkCldDeTjz/7G7RzByLUbr3960jL
	 BVRxOK4tf0jB4Uxs5aLnSr9qhTVA1+++adbtkD09EWSR+dxJ06/4v/uauj7x5znm5
	 hAhsuaIgmzVfi15iTH7TuLDUy//68LHhkqB1skcdwz5Jvhl+rt3gOsiyIMLPAR2Py
	 4WXojXUQW/QAWNCFqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1tKMFX3xbY-00yanl; Fri, 21
 Feb 2025 23:54:32 +0100
Message-ID: <20d7a8c5-8f61-4870-84ae-87a6ca4a052e@gmx.com>
Date: Sat, 22 Feb 2025 09:24:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
To: Daniel Vacek <neelx@suse.com>
Cc: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <d84d2d83-03ac-4741-9677-52c71e1fb36d@suse.com>
 <c0a4b4a0-268c-42f3-b117-b87b2fb12a03@suse.com>
 <CAPjX3Fem-=D8dxyR1MGTQVskkzdijmc7k82+f5_S_YyBJ_Orsg@mail.gmail.com>
 <6bbfddea-f0ea-4825-a987-01be3ff18a23@suse.com>
 <CAPjX3Fc=E28A6zD4tJOT2bRZ-pnErVKzkYuzALt6soGLu=MRJQ@mail.gmail.com>
 <a2ae2321-4934-4a10-8a44-2f7dc3bf48c3@suse.com>
 <CAPjX3Fes+PDEyi4_tFJyRHePVVuv_K+nUfShEeuagOANd6VqfQ@mail.gmail.com>
 <61afcaa2-01ff-4d18-a8fa-804fe36464cb@gmx.com>
 <CAPjX3FcnofHyQzHvP_R0CWWML2EVC-PmPY9k90X+ddWWPFxhBw@mail.gmail.com>
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
In-Reply-To: <CAPjX3FcnofHyQzHvP_R0CWWML2EVC-PmPY9k90X+ddWWPFxhBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WzlCAoNvEUTlNDy7FMhQ5h4/Ddq29DEu7IdhieJoBKQXGzxCuNJ
 aEzjhVcNcRhF2uyDLF84DU11bVknt+PHkeWfazuUffL3IinExNa089jGnyktwN+xblbFmpC
 kNXg1WYW8KeJPU7QLA6f/xi1KANVraBLsiey6Isk8qq3j1Kcft+pUZUHfmMPYkaOy4DBghM
 7cN+dx0nac0QsceLW6xfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YtaVgEcFDCs=;khDpvGmFfCxqBW8TX8RtcOcM7zw
 r8D06HKCwYFXZPZd8+OWnUkCUCrBfEf2Sr1N3WxWsaAg1iouJvh11mCfBvxBb6MahYbeS1AvY
 nSLgPeulk7275FcGg3EJLX+QFr8x6Wk7wTeNVhcGY0grOj7fIClC5sQwH91LAWU19WLyijopO
 U/Hitt/DVl53ZrqHYsHetSO4lyniGUndnprPkaycLVbjlO5B+iZqxrAPbUIwpY8VWEocdblPk
 aYR9Jd/OK05kLFQ9d5Vy5BM8VSm6uug1ayR65L9JH+iemmDqEITYqicr133t1zUTUz0Uq9J8F
 iLzpvtK0pOvyMldYLcPJiVP4T6RVKmgJbeBDQXtZlBLCH1DI2TZdko6QNoVufmAfLkKuRiefJ
 dt4Km7z5IxavgLtIp5q2rU5iYp39HiGNEJlESGR5+QrsZ2/2vB340JA1C/qyElQhrTcNkFYVL
 FeHcrWpsmM3pZY7Olev0OddFQs2xtyWRXzqejgdsKk6qrtdkH4pInFoaGFoYKzQjMgikL0KOp
 QFMlWYQJOT7GQPpBBuktNALBwZu7Qs3HL0frUUpCiRvpiq0bbQFvPpR0X/OkZt0wPGRkcu85Q
 V32M1kO2pCzrStm98auocbE+vdtQfcaQ6//gqSx4xocDv2/ozHTW58dy9NJzISH3TtslWRDDO
 IC9j2zlByM2mhCYyg/LCmUKW9v9L9qCq01uKUFY/z6pbPGflaFLsoiXM2LiHKdpGBaPn8ksiT
 n2joud/2lV+LGGEtbCMJ+eDS+2HQ+1QyFwl75DUUSc8yCuF5XGQQjPJuvhftOsT4E7MbjYzKt
 6kBIxu1IY/+rU9srdFK066SLDNRSjiJBlfIv3D+PXPP5F9/mO0YOIrqKm6DBMKJqK01vBDesi
 Rzi4Gys8e+Uz66vWUqY8uzzo35tO8qBiUH1Gp8bcsWqlDBmc/Yz9/GtFkumehYFo0N+sTr1DG
 oS/xVHSv4RalWMvGOHtina0LOdbOCDuXwcPGSzS5682SD8XLR9CCSgGkpQ29Sro6Pqr+AS6p1
 wOTD9f09B+Yab4HEw4J0Mr9HO0h8z98iUDb0loV7mtpKXDBMe0AwhFjjHcbBBzhT4day5EnnR
 9Qva5d3LKELzbiQaXSZEJhSVf2cggeOa/BWfWHgnNTK8djiFexoEzAnWeUergdpzKzErdlXEQ
 D56j7EHOkFvLVbSrurUZM9VmHSfI3Q6ja1e55rPcV5BR7ZkazL5WJ/9S8UAAVEcj84EhZZM+t
 wK3DkyGqBFQoPXnJg9qK3TC/XHFy8l8UxPg1PtGPTNvbZgZbdRItBwHl5x9G4pgllT6eiImPa
 S9/R52TOKc0o4O+iunCYIiDLhNoke7Ns7SaoPIopZm+TxsVT/i8IQ5i28vnWtjVuRSTLGntqT
 J2427UxeXTbmK3VISGZZd4m9JjkfkxP6lrHE7BAGUhDpI2jdUe6gB7fcbQ



=E5=9C=A8 2025/2/21 22:23, Daniel Vacek =E5=86=99=E9=81=93:
> On Fri, 21 Feb 2025 at 10:48, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/2/21 19:43, Daniel Vacek =E5=86=99=E9=81=93:
>>> On Fri, 21 Feb 2025 at 09:20, Qu Wenruo <wqu@suse.com> wrote:
>> [...]
>>>> Remember, user can provide their own mount options (including the
>>>> SELinux ones) through MOUNT_OPTIONS environmental variables.
>>>>
>>>> So you at least need a full reason why SElinux context must be disabl=
e
>>>> for this case.
>>>> And I see none.
>>>
>>> It does not need to be disabled. But it also does not have to be
>>> enabled for this test.
>>
>> Then good lucky if one day some QA guy finds out the send/receive
>> behavior has a SELINUX specific bug, and you need to explain to them wh=
y
>> it's a good idea to not test SELinux for this particular workload.
>>
>> Your mindset of "XX feature doesn't have to be tested" makes nosense fo=
r
>> a test suite.
>
> Huh, this is a huge misunderstanding.You still got it the other way
> around. I'm sorry if I was confusing you.
> I never said I'm against testing SELinux. Quite the opposite, to be
> honest. I did argue that testing the default system policy without
> overriding the context also works for this test, at least with my
> testing on the latest TW.
> SELinux is always tested. Just either with the default system policy
> or with the given forced context.
>
>>> At least not with the default policy on the latest Tumbleweed I was te=
sting on.
>>>
>>> But your mileage may vary, I guess.
>>>
>>>>>
>>>>> Or do you use such an option with any of your mounts? I doubt so.
>>>>>
>>>>> Check the mentioned commit 3839d299. fstests cripple SELinux by
>>>>> default. Which doesn't look good by itself.
>>>>
>>>> Do you really believe that commit is going crippling SELINUX?
>>>
>>> Well, in a way, yes.
>>>
>>> What it does is that it overrides the system's default policy. Which
>>> may make sense, as for example your system policy may deny some
>>> operations the tests do, eventually resulting in failed tests.
>>> Though as a side-effect it also prevents writing the security label
>>> file attribute by design with the mount option override. In such a
>>> case SELinux just returns with -EOPNOTSUPP.
>>>
>>> 3213         sbsec =3D selinux_superblock(inode->i_sb);
>>> 3214         if (!(sbsec->flags & SBLABEL_MNT))
>>> 3215                 return -EOPNOTSUPP;
>>> ...                  ^^^^^^^^^^^^^^^^^^^
>>
>> This only explains why your mount option fix is correct.
>
> Nope. This triggers precisely when the context is forced with the
> mount option. In that case setting the file attribute is not
> supported.

BS, overriding the SELINUX context just means disabling SELINUX.

Your "fix" from the very beginning is doing two conflicting things:

- Disable SELINUX context by overriding it

- Add back the empty SELinux context for mount

Explain why it makes any sense?

>
>> The send stream has SELinux attrs, that's because the original fs is
>> mounted with SELinux context (the regular _scratch_mount() helper added
>> SELinux context).
>
> Nope. Again, the other way around. The send stream has the
> `security.selinux` attribute precisely because the mount was missing
> the option and hence the file labels were used (and not refused).

There is no SELinux xattrs because you damn disabled SELinux for this
test case!!

  But
> the receive side fails as that mount actually did use the context
> mount option and so it was refusing setting the file label returning
> this -EOPNOTSUPP error.
>
>> But later we manually mounted a btrfs, not using _scratch_mount(), thus
>> the new mounted btrfs doesn't have SELinux context, thus unable to set
>> the SELinux attrs at receive side.
>
> This is just wrong.

Whatever you believe, I think I have wasted too much time on this non-sens=
e.

>
>> It doesn't show why you need both the mount fix and overriding SELINUX
>> context at all.
>
> I'm saying you don't need both from the very beginning. Where did I say =
you do?

Then why damn putting the override and mount fix in the same damn patch?

