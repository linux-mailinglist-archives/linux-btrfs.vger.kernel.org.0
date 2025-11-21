Return-Path: <linux-btrfs+bounces-19260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10267C7BAB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 21:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89B2135C0B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78924275B0F;
	Fri, 21 Nov 2025 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wt4iYwLB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791420299B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763757975; cv=none; b=qncrx/R+6fAK+luRl4HZsjw3d3tlf63D967mO1SfZKI2EGRaslp+5JVyVlnphT5pI3eYtpgN1XkGv5pLa2a4bYpDrWyHNJyD5ovhb+WJSGqQehlASYWFyp9bPTLYsKMHOguhGMp9+Eb1thS04YxIqKR79KaHpjjq0oEr/2ZCzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763757975; c=relaxed/simple;
	bh=tmDZq5+cLwC/nviziEQPEZadx5c4W546kjg+unaiSXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIPjHs06PMxok5BGf9APhP/kZT3oFGS68JbCNWZrnRSNWOIVy0TxAgQCRo+UlockL/3HZsEhqUWHkNv2DfBb3pTZmwiYcr128HhoZongTUxm8U5BJosZgILWVIHn7FB5xvOHE7Gu2q58NdK24D4AGxG1K62Osn5xxqAlj1EY7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wt4iYwLB; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763757971; x=1764362771; i=quwenruo.btrfs@gmx.com;
	bh=Pfw79UA9Ket5DPYvwJcyGk4ioOVZmDx6vx2H/4VIkTs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wt4iYwLB/kfjdva6Pyz9F2Au6THQ+2KyzvuDUQ4e2+c/AAMXwNUPR4k2zTC/XKw2
	 d5nGcumNFRgV+OSGLBltiUdYn9q81/1L5OYgRk41uVadG9QUsOVOYQKAy3YWoCCEL
	 WYJOoaaJ3LGuXW5DDEJRI/VWoFcRa8VNqwCh2uv6PvlCp022wh6vc+ioeEuitbxDY
	 BdU6hvbZUizzvI8s0F1w11t5hSPQmfSkhrlR5JMx752YFXb3Ij6FtAZ9W+SvlIY9c
	 1yXgKz495x094oQWmPyfrKaRj9z7SWHyqS48Zo0Ybc+4rfH5Nf+O2lcilzo0sN4+X
	 eEltSGaFRRWLelGBow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79u8-1wC4oY36nU-015c0e; Fri, 21
 Nov 2025 21:46:11 +0100
Message-ID: <58e0b0e5-c72c-43de-a1ec-b9d85a71bbdf@gmx.com>
Date: Sat, 22 Nov 2025 07:16:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: Daniel Vacek <neelx@suse.com>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1763629982.git.wqu@suse.com>
 <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
 <20251121153850.GP13846@twin.jikos.cz>
 <94236c69-10ed-494f-8895-39a8b4a443b6@gmx.com>
 <CAPjX3FdrTZwzuObrERxP=pLmSMjYt6Drqfxn4S5ENmL_JQhkzw@mail.gmail.com>
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
In-Reply-To: <CAPjX3FdrTZwzuObrERxP=pLmSMjYt6Drqfxn4S5ENmL_JQhkzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:br/A3x1QUm06GqDyy1w7nwzlsvvo+DA3Z9nk0KxEbwG7+kNLE3M
 0RcLUraeIxsb9xsSf13lkjir5dNgZQ1lbhqIqGVttQdapKwvnHq+eXsUAo9lYaPcakXHsEN
 01dRXzjuMeydGHPMBpbq8UFQz0Y035irHu36iTdD5hYslBn3kn4YNougUCbESC3Wrkb6o7y
 YDJ0rebAJS1vyxeSbz5vQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kwFCwP4N8XU=;RUGGwp21K3ElwP5c0AbykPDteqz
 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
 Y2WVV2wWF2mgS2Vm+t/jR3hL/S0sPzdMje36Qr



=E5=9C=A8 2025/11/22 06:55, Daniel Vacek =E5=86=99=E9=81=93:
> On Fri, 21 Nov 2025 at 20:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> =E5=9C=A8 2025/11/22 02:08, David Sterba =E5=86=99=E9=81=93:
>>> On Fri, Nov 21, 2025 at 11:55:58AM +0000, Filipe Manana wrote:
>>>>> +               /*
>>>>> +                * We have just run delalloc before getting here, so=
 there must
>>>>> +                * be an ordered extent.
>>>>> +                */
>>>>> +               ASSERT(ordered !=3D NULL);
>>>>> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
>>>>> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->f=
lags);
>>>>> +                       ordered->truncated_len =3D min(ordered->trun=
cated_len,
>>>>> +                                                    cur - ordered->=
file_offset);
>>>>> +               }
>>>>
>>>> I thought we had not made a decision yet to not use this new fancy lo=
cking yet.
>>>> In this case where it's a very short critical section, it doesn't
>>>> bring any advantage over using explicit spin_lock/unlock, and adds on=
e
>>>> extra level of indentation.
>>>
>>> Agreed, this looks like an anti-pattern of the scoped locking.
>>>
>>
>> I think one is free to use whatever style as long as there is no mixed
>> style in the same function.
>=20
> I've got a hard objection here. If there is(?) any granularity using
> guards vs. explicit locking then, IMO, it should be per given lock.
>=20
> Ie, given `ordered_tree_lock` - either it should always use the RAII
> style *OR* it should always use the explicit style. But it should
> never mix one style in one function and the other style in another
> function. That would only make it really messy looking for
> interactions and race bugs / missing/misplaced locking - simply
> general debugging.

Then check fs/*.c.

There are guard(rcu) and rcu_read_lock() usage mixed in different files.

E.g. in fs/namespace.c it's using guard(rcu) and scoped_guard(rcu),=20
meanwhile still having regular rcu_read_lock().

There are more counter-examples than you know.
We're not the first subsystem to face the new RAII styles, and I hope we=
=20
will not be the last either.


[...]
>>
>> I'm not saying we should change to the new RAII style immediately with =
a
>> huge patch nor everyone should accept it immediately, but to gradually
>> use the new style in new codes, with the usual proper review/testing
>> procedures to keep the correctness.
>=20
> I would understand if you introduced a _new_ lock and started using it
> with the RAII style - setting the example. But if you're grabbing a
> lock which is always acquired using the explicit style, just stick to
> it and keep the style consistent throughout all the callsites, the
> whole code base. This makes it _easier_ to crosscheck, IMO.

Then check kernfs_root::kernfs_rwsem, it also has mixed RAII and old style=
s.

We should all remember there are always subsystems before us facing this=
=20
challenge, and if they are fine embrace the new style gradually, I see=20
no reason why we can not.

We're just a regular subsystem in the kernel, not some god-chosen=20
special one, we do not live in a bubble.

Thanks,
Qu

>=20
> -just my 2c
>=20
>> If one doesn't like the RAII, sure one doesn't need to use, and I'm not
>> going to force anyone to use that style either.
>>
>> But if this step-by-step new-code-only approach is also rejected, it
>> will going to be a closed-loop:
>>
>>     Not settled -> No new style code to get any feedback -> No motivati=
on
>>     to change
>>
>> Thanks,
>> Qu
>>
>=20


