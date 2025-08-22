Return-Path: <linux-btrfs+bounces-16313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE7B3256F
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Aug 2025 01:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019D55C2F02
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809452D7DD9;
	Fri, 22 Aug 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bGv5IN/A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2E19E7E2;
	Fri, 22 Aug 2025 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755905962; cv=none; b=ZvYwTc+t+zqPIy9vFXfavVNY7FDSL+/fmm92/NVSLKfMvtJDdNktY2p5cnI84bWltWdQN/aCcZxNzFVrU75t2/PDJpqjmYLB25BQqmzyVD98IujSma0f5FIrS6wcAHZLMb78MjJ9Ay9rrXn2f9xXHq2dPjv72HXqtRc3M9ZRAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755905962; c=relaxed/simple;
	bh=R2/ct0PKs2GPBIiPOE+cpYWQQo6AmiLxuIp2chwI34c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfgML3O8WijhTjtpBKd6/QXKl/2Ljy5PpOMo/jsOiGkxM9lOvS3L6Xu5pCyzhPFQz2L+Od4TlvZhAeXmpP4C4FUpfOhmT12dNsl4vN+U28ytUQb3GDj15R+HukZqCIWt9ebdtzQxfZWAdoH+TQCpKM753Vtra4QB26i/3reKAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bGv5IN/A; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755905951; x=1756510751; i=quwenruo.btrfs@gmx.com;
	bh=3TpI1WJGDbhCoG9ooDv0D78R4NOBKu2kp+Bk6NNmHoA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bGv5IN/AkCF8TOIdNy4ElJ8jp7Txo7J1jhYHLUhgCiKAdElApJo2qGLeq8D6yl3A
	 VSuwYKoqx2Wm45Qj8kLeLV1RYAorlfJeCD3sBzMGGjhwiBvKWEF/6lByH3/zaN9XY
	 rEHgANevEpNpqSrrx3ATpyAOwmV+oEEvvVbx48tLJuLSF5KD1FdoiJxvzw+Rb7aD0
	 I3K5KCDpzFIR3UHYxQJzS7K3K+2T2zcvDHenlND1SeafnrJhHs8SfbPM9yfEQ57gj
	 AxL9WzzsVPj9fqDutSrlmemN2ppFPcdmhRl1oladAhydOZfxqxJACo2Ncl54AwzAo
	 LaYPw6u3TpPrj3DZzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2wL0-1uoULq3P36-000Ctb; Sat, 23
 Aug 2025 01:39:11 +0200
Message-ID: <9cacdafc-98ec-4ad2-99a8-dfb077e4a5fb@gmx.com>
Date: Sat, 23 Aug 2025 09:09:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Calvin Owens <calvin@wbinvd.org>
Cc: Sun YangKai <sunk67188@gmail.com>, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, neelx@suse.com
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me>
 <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
 <aKj8K8IWkXr_SOk_@mozart.vkv.me>
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
In-Reply-To: <aKj8K8IWkXr_SOk_@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6UQf6AMpa/Kdg769ftIkpTv67MVMrF8U52jg0eXN7HaDPMhL5lF
 BssB4zlX7tYEE6wwwRuGFnDDO3myGnxaggV2THThuG/Zckptnq0hzoRyGm3/RR8IhQUZT0+
 KuCJjbFcI4/q/4qR3EQQEz+YNHpNzH10TEkuH/G9s8D0uJT+NShXY863F0XpDnpf7U196hu
 Kalucf+IHQXBaF8vkAN5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F4a+SGPlL6M=;mow3pfuw8PvXuYe7EXhmaj5KPhy
 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



=E5=9C=A8 2025/8/23 08:54, Calvin Owens =E5=86=99=E9=81=93:
> On Saturday 08/23 at 07:14 +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2025/8/23 01:24, Calvin Owens =E5=86=99=E9=81=93:
>>> On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
>>>> =E5=9C=A8 2025/8/22 19:50, Sun YangKai =E5=86=99=E9=81=93:
>>>>>> The compression level is meaningless for lzo, but before commit
>>>>>> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"=
),
>>>>>> it was silently ignored if passed.
>>>>>>
>>>>>> After that commit, passing a level with lzo fails to mount:
>>>>>>        BTRFS error: unrecognized compression value lzo:1
>>>>>>
>>>>>> Restore the old behavior, in case any users were relying on it.
>>>>>>
>>>>>> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount o=
ptions")
>>>>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>>>>> ---
>>>>>>
>>>>>>     fs/btrfs/super.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>>>>> index a262b494a89f..7ee35038c7fb 100644
>>>>>> --- a/fs/btrfs/super.c
>>>>>> +++ b/fs/btrfs/super.c
>>>>>> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs=
_context
>>>>>> *ctx,>
>>>>>>     		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>>>>     		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>>>>>     		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>>>>>
>>>>>> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
>>>>>> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>>>>>>
>>>>>>     		ctx->compress_type =3D BTRFS_COMPRESS_LZO;
>>>>>>     		ctx->compress_level =3D 0;
>>>>>>     		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>>>>
>>>>>> --
>>>>>> 2.47.2
>>>>>
>>>>> A possible improvement would be to emit a warning in
>>>>> btrfs_match_compress_type() when @may_have_level is false but a
>>>>> level is still provided. And the warning message can be something li=
ke
>>>>> "Providing a compression level for {compression_type} is not support=
ed, the
>>>>> level is ignored."
>>>>>
>>>>> This way:
>>>>> 1. users receive a clearer hint about what happened,
>>>>
>>>> I'm fine with the extra warning, but I do not believe those kind of u=
sers
>>>> who provides incorrect mount option will really read the dmesg.
>>>>
>>>>> 2. existing setups relying on this behavior continue to work,
>>>>
>>>> Or let them fix the damn incorrect mount option.
>>>
>>> You're acting like I'm asking for "compress=3Dlzo:iamafancyboy" to kee=
p
>>> working here. I think what I proposed is a lot more reasonable than
>>> that, I'm *really* surprised you feel so strongly about this.
>>
>> Because there are too many things in btrfs that are being abused when i=
t was
>> never supposed to work.
>>
>> You are not aware about how damaging those damn legacies are.
>>
>> Thus I strongly opposite anything that is only to keep things working w=
hen
>> it is not supposed to be in the first place.
>>
>> I'm already so tired of fixing things we should have not implemented a
>> decade ago, and those things are still popping here and there.
>>
>> If you feel offended, then I'm sorry but I just don't want bad examples
>> anymore, even it means regression.
>=20
> I'm not offended Qu. I empathize with your point of view, I apologize if
> I came across as dismissive earlier.
>=20
> I think trivial regression fixes like this can actually save you pain in
> the long term, when they're caught as quickly as this one was. I think
> this will prevent a steady trickle of user complaints over the next five
> years from happening.
>=20
> I can't speak for anybody else, but I'm *always* willing to do extra
> work to deal with breaking changes if the end result is that things are
> better or simpler. This just seems to me like a case where nothing
> tangible is gained by breaking compatibility, and nothing is lost by
> keeping it.
>=20
> I'm absolutely not arguing that the mount options should be backwards
> compatible with any possible abuse, this is a specific exception. Would
> clarifying that in the commit message help? I understand if you're
> concerned about the "precedent".

Then I'm fine with a such patch, but still prefer a warning (not WARN(),=
=20
just much simpler btrfs_warn()) line to be shown when a level is=20
provided for lzo.

Furthermore, since we already have something like btrfs_lzo_compress=20
indicating the supported level, setting to the proper default value=20
would be better. (Already done by btrfs_compress_set_level() call in=20
your v2 patch).


BTW, since you mentioned something like "compress=3Dlzo:asdf",=20
btrfs_compress_set_level() just ignores any kstrtoint() error, allowing=20
things like "compress=3Dzstd:invalid" to pass the option parsing.

I can definitely send out something to enhance that check, but just want=
=20
to be sure, would you opposite such extra sanity checks?

Thanks,
Qu

>=20
>>> In my case it was actually little ARM boards with an /etc/fstab
>>> generated by templating code that didn't understand lzo is special.
>>>
>>> I'm not debating that it's incorrect (I've already fixed it). But give=
n
>>> that passing the level has worked forever, I'm sure this thing sitting
>>> on my desk right now is not the only thing in the world that assumed i=
t
>>> would keep working...
>>>
>>>> I'm fine with warning, but the mount should still fail.
>>>> Or those people will never learn to read the doc.
>>>
>>> The warning is pointless IMHO, it's already obvious why it failed. My
>>> only goal was to avoid breaking existing systems in the real world whe=
n
>>> they upgrade the kernel.
>>>
>>> If you'd take a patch that makes it work with a WARN(), I'll happily
>>> send you that. But I'm not going to add the WARN() and keep it failing=
:
>>> if that's all you'll accept, let's just drop it.
>>>
>>> Thanks,
>>> Calvin
>>>
>>>>> 3. the @may_have_level semantics remain consistent.
>>>>>
>>>>>
>>>
>>
>=20


