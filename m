Return-Path: <linux-btrfs+bounces-19254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F401DC7B80E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CB23A5889
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E42E8DE3;
	Fri, 21 Nov 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Xa/xwSKd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A37B2E2665
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753205; cv=none; b=TFPnLRDm0LzZ7vPWDQlSu1wb1NmEZVw9erG42jNZFDW5yktjz7E2f7Bz/vzEva84FARMTUiL7pZoDcGDar2u97frkVExJ3DHGdemd43mp9XrFzK2DTxootBJ1Zg+rjVeUQ1/kCppceuQ7WfNTSVtcg1v4XwPe9ddTm7lRUG9I8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753205; c=relaxed/simple;
	bh=M5tesEHMNxWGcuAk/DgXMPit57Pl5SZ1sMoaC0wKC98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBJoJAziCvidNbGt0XXnkbA3IGjWezQ+02F6qu4lvV+YzMi4yoi+rAHUIHj5Po3ow1XMSL4xreq+GDUGi3AJ0YGlt74PmZqRA3vtjv2TAcbzaaanIw3L7+EmL+I41Aysdk06zOiTnqfLL1C/im/NREOS+UCI43HuSfl9x7Hxqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Xa/xwSKd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763753192; x=1764357992; i=quwenruo.btrfs@gmx.com;
	bh=cRasro6kblzeAA8CTbXV5L9is1fV9APNpwF94e4m4uo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xa/xwSKdm0IWYMAYVtNExCfKslwglMKGFQ+ss/yGuXWNA1TsO5dQn4XJI9tZO+37
	 wS9SLBPqeXq494Jbj6b73199Bt+8q/F1lmgxR/JeK+pklK50n/w9+fNi7QefFrlqC
	 Kk7WKi8h+vHSB9X4OLyvV4nWc5zCIQxzlGtSaxhjKXX+wznBTEYCGg0WtaT298bGz
	 cH+g4JCIckSfgtPJARmywk3nVpDMNYiU6sOnW21HzvtLX21kwR/OEoA/J0xjcMdIP
	 JvjQiTX22xrNO1JSRZB/UzYvMM2glgnrPvXVqDE3k6jvCzqMgcO/j6nwJgvbTi4pq
	 GlvXPUI4gxnQril3dA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1vaZVt2VjX-00QdF3; Fri, 21
 Nov 2025 20:26:31 +0100
Message-ID: <94236c69-10ed-494f-8895-39a8b4a443b6@gmx.com>
Date: Sat, 22 Nov 2025 05:56:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1763629982.git.wqu@suse.com>
 <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
 <20251121153850.GP13846@twin.jikos.cz>
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
In-Reply-To: <20251121153850.GP13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UiVMezjbTn8LYbq//jeejAwf4XbOtobV3uTyMVNY8Dd3CsfWbKa
 pC8Q+qwUP0kzngb2vCinFAAhLAt7t7R0cULxL4T8OpMvcvCdyWisd38C5rG/twQ1xwCXLAR
 04GABVWeUzZUnBYqnFyOYGv+TTWLGqyN8dikQiquCeefgQAgYZX4JKoxWC45eb1IrDShn0E
 /KAOynQgj/VaVi/8vbn/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wEi5PgFdh+0=;T7Twh6aT4PDRuxLPNyS05oMdzA+
 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
 FS47tGxuvpXxeKgE4=



=E5=9C=A8 2025/11/22 02:08, David Sterba =E5=86=99=E9=81=93:
> On Fri, Nov 21, 2025 at 11:55:58AM +0000, Filipe Manana wrote:
>>> +               /*
>>> +                * We have just run delalloc before getting here, so t=
here must
>>> +                * be an ordered extent.
>>> +                */
>>> +               ASSERT(ordered !=3D NULL);
>>> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
>>> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->fla=
gs);
>>> +                       ordered->truncated_len =3D min(ordered->trunca=
ted_len,
>>> +                                                    cur - ordered->fi=
le_offset);
>>> +               }
>>
>> I thought we had not made a decision yet to not use this new fancy lock=
ing yet.
>> In this case where it's a very short critical section, it doesn't
>> bring any advantage over using explicit spin_lock/unlock, and adds one
>> extra level of indentation.
>=20
> Agreed, this looks like an anti-pattern of the scoped locking.
>=20

I think one is free to use whatever style as long as there is no mixed=20
style in the same function.

Sure, we're not yet settled on the style, but I can not see anything=20
damaging readability either.
That extra indent is clearly showing the critical section, and we have=20
enough space in this particular case.
It's more clear than spinlock() pair, and unlike guard() this won't=20
cause problems for future modifications.


And I didn't get the point of anti-pattern.

You only want to use the guard for the longest critical section with=20
multiple exit? And leave the simplest ones using the old style?
That doesn't looks sane to me.


I'm not saying we should change to the new RAII style immediately with a=
=20
huge patch nor everyone should accept it immediately, but to gradually=20
use the new style in new codes, with the usual proper review/testing=20
procedures to keep the correctness.

If one doesn't like the RAII, sure one doesn't need to use, and I'm not=20
going to force anyone to use that style either.

But if this step-by-step new-code-only approach is also rejected, it=20
will going to be a closed-loop:

   Not settled -> No new style code to get any feedback -> No motivation
   to change

Thanks,
Qu

