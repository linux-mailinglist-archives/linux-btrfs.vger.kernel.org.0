Return-Path: <linux-btrfs+bounces-16311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A82B324B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 23:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15803B009B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 21:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D02882C9;
	Fri, 22 Aug 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="I4CsR/wL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF4221F09;
	Fri, 22 Aug 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899053; cv=none; b=eVMpBfuvXAMHcjGh/EEhwu9d9anh944bSXwzuGmO4IcZUcNv+SeRsWYAYUlrUc0f/qZTyLVwM03D+SuuCfGCTVbFLNqzUl5ZaAm+O8uLuyJyAEKLHZlg76OoN/Jgvcv4hwjvziiEh9SkWiObN+ZO4QImoV0HSMcYxAI56IFrxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899053; c=relaxed/simple;
	bh=OaJcSTanvS5KNrWbc/ToA79gNpNDW9ZHhG+87wwZITI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8qtHrRXY5Y3TbegsAM64SAepJlHbMnEFQsQfBncRCQNYvwH/EMhI+5V5L0JPvGyILMw0uXawD5WQFA/94Il+xMxqi7IzU1XnCyEPj//fZn4lQ6Bvjg4qPLlK47Lcvn1QdW2HIIBGMRf4OEd3by3rQFpcyYGdlhtFcoDo3l2cWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=I4CsR/wL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755899048; x=1756503848; i=quwenruo.btrfs@gmx.com;
	bh=Ym+D0f4bq+U41x6zxqWLwWyTCn9qnpoYWUke6NwFcZc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I4CsR/wLugoAJacyJmLAxDYKIGsr0FD3fZ/CT4d26NeKI4korl25YMgu/76HXkyw
	 2wefiMysw2DF/H2i7tFCyU5iRJxYRAKg9ggeGFsne5nY9jXYY5ZPUsiGzYzwjhASJ
	 ZhfDPUFC6XNC8JnmUQO3gJ6bC8jOtdH7rTHb9hNkMXbaWN2JaMiFjSULhA3Ustbt5
	 m1avvIOAyjst0mkgvxVeUzPNu4svxP80YAOFFyA+bGWqirjsVJXxya7UYWeFe28H2
	 hYVorpMWLQ+HZy01dye6EYo+GdpN3eIepDpd9r8f4EQ+cj6Wf7dOKoMgY/uVbh/bu
	 Lr53zlgGSqr5qZWmSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1ud0om3rbX-016gSE; Fri, 22
 Aug 2025 23:44:08 +0200
Message-ID: <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
Date: Sat, 23 Aug 2025 07:14:02 +0930
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
In-Reply-To: <aKiSpTytAOXgHan5@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+sQNCJ9gplKo3zIJ4JWpKDb5GcTyc2oPVFIOaR0z0eVZuUC69N+
 2veCZNHlqan7NLB/Sp/UM59bUQpBPGxC+2QiJEVq5/ctI7cns43ibx58ax+9t45/jKU1gvE
 AUqeu3KQVFeK/eqkdYMzM98Vw9MrY8DZ6VKxOmaZHittYLg/sbkvyWWKRqIxQdn+LRJp2+6
 oX7WztqZii9pFgv1N5nhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WOL8tyq/yOA=;QBzNZvXBXFVLMCGvqXZsXYLl4WR
 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



=E5=9C=A8 2025/8/23 01:24, Calvin Owens =E5=86=99=E9=81=93:
> On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
>> =E5=9C=A8 2025/8/22 19:50, Sun YangKai =E5=86=99=E9=81=93:
>>>> The compression level is meaningless for lzo, but before commit
>>>> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
>>>> it was silently ignored if passed.
>>>>
>>>> After that commit, passing a level with lzo fails to mount:
>>>>       BTRFS error: unrecognized compression value lzo:1
>>>>
>>>> Restore the old behavior, in case any users were relying on it.
>>>>
>>>> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount opt=
ions")
>>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>>> ---
>>>>
>>>>    fs/btrfs/super.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>>> index a262b494a89f..7ee35038c7fb 100644
>>>> --- a/fs/btrfs/super.c
>>>> +++ b/fs/btrfs/super.c
>>>> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_c=
ontext
>>>> *ctx,>
>>>>    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>>    		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>>>    		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>>>
>>>> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
>>>> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>>>>
>>>>    		ctx->compress_type =3D BTRFS_COMPRESS_LZO;
>>>>    		ctx->compress_level =3D 0;
>>>>    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>>
>>>> --
>>>> 2.47.2
>>>
>>> A possible improvement would be to emit a warning in
>>> btrfs_match_compress_type() when @may_have_level is false but a
>>> level is still provided. And the warning message can be something like
>>> "Providing a compression level for {compression_type} is not supported=
, the
>>> level is ignored."
>>>
>>> This way:
>>> 1. users receive a clearer hint about what happened,
>>
>> I'm fine with the extra warning, but I do not believe those kind of use=
rs
>> who provides incorrect mount option will really read the dmesg.
>>
>>> 2. existing setups relying on this behavior continue to work,
>>
>> Or let them fix the damn incorrect mount option.
>=20
> You're acting like I'm asking for "compress=3Dlzo:iamafancyboy" to keep
> working here. I think what I proposed is a lot more reasonable than
> that, I'm *really* surprised you feel so strongly about this.

Because there are too many things in btrfs that are being abused when it=
=20
was never supposed to work.

You are not aware about how damaging those damn legacies are.

Thus I strongly opposite anything that is only to keep things working=20
when it is not supposed to be in the first place.

I'm already so tired of fixing things we should have not implemented a=20
decade ago, and those things are still popping here and there.

If you feel offended, then I'm sorry but I just don't want bad examples=20
anymore, even it means regression.

>=20
> In my case it was actually little ARM boards with an /etc/fstab
> generated by templating code that didn't understand lzo is special.
>=20
> I'm not debating that it's incorrect (I've already fixed it). But given
> that passing the level has worked forever, I'm sure this thing sitting
> on my desk right now is not the only thing in the world that assumed it
> would keep working...
>=20
>> I'm fine with warning, but the mount should still fail.
>> Or those people will never learn to read the doc.
>=20
> The warning is pointless IMHO, it's already obvious why it failed. My
> only goal was to avoid breaking existing systems in the real world when
> they upgrade the kernel.
>=20
> If you'd take a patch that makes it work with a WARN(), I'll happily
> send you that. But I'm not going to add the WARN() and keep it failing:
> if that's all you'll accept, let's just drop it.
>=20
> Thanks,
> Calvin
>=20
>>> 3. the @may_have_level semantics remain consistent.
>>>
>>>
>=20


