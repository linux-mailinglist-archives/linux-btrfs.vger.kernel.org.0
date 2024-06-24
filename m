Return-Path: <linux-btrfs+bounces-5913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAA6914242
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 07:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EC61F23FA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 05:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB971B964;
	Mon, 24 Jun 2024 05:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Pr4ZuiZU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034CB17BCC;
	Mon, 24 Jun 2024 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719207685; cv=none; b=st1NqWWhGd2wAxIy91NFPOzLcIdrAqVLawdNwpc5KWWytF+iue5I2s5N9GSFYMMTVLZyhUvWN3qHXAeVrJOpB07y4Nq9GB+L0rXvxKUcuho+87lEaDo/7a8NewfhfmEznAbmz4Qh+EnAPlIMkfkRWmqEvjt6OlS5ryFbhjMA2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719207685; c=relaxed/simple;
	bh=BMn5gnd0iEBRVxEBmzCq3QYltM7If2QAyw9uRay0504=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rjJLF5/nGi5yerf2nBeugffzlTbowWKOjPRrVXIj7qB9CZ/lJBia4hVzJOpVHAwqwngSVNCYYf4K30Vy6NwgcXd9FdZpjtjIuQilyZOE7QmV/SfyHlugOdZ5bIPqnOmtBBV9T5h9/XqHf1YyiR5Sok4zGEyKcsRkPmM4MSlfsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Pr4ZuiZU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719207648; x=1719812448; i=quwenruo.btrfs@gmx.com;
	bh=BMn5gnd0iEBRVxEBmzCq3QYltM7If2QAyw9uRay0504=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pr4ZuiZU8RIftmgFuB+1KPwqzhxeX5oNC+Ot6U5A0GO8uebw+kgh++xwxUAVg+k9
	 fDBortPYLtBiPKX1PAQwyh/WmHZY+Z3DzJmSsKBa5RXLLa8PWnA08l3/n7ynbJwKo
	 DYAOydfPHcqxC6BpceLf4v5gm+kE+NlFz8iUF4jspcsrH+g9uVxbCX7T1Loi83xnn
	 mkLV45nIH5uTDjZ2oOGbEL80cuAS/TrRhuTZNrCZ+UShp0wA6WB1AzaOOeGw0ma71
	 Kz2P86I0eknTIRs8j5NgzsWBom/gtP9iwA+YXCt3wqejFdkZGlAN5IAv7Akf26fRA
	 NJVIb2N4ziwBi2q96Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mv31W-1sdQJL2yiu-016zvi; Mon, 24
 Jun 2024 07:40:48 +0200
Message-ID: <c5646885-3368-4c49-9cbd-092d4b7b7551@gmx.com>
Date: Mon, 24 Jun 2024 15:10:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: fix slab-out-of-bounds in
 btrfs_qgroup_inherit
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jeongjun Park <aha310510@gmail.com>, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com
Cc: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com, fdmanana@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20240624030720.137753-1-aha310510@gmail.com>
 <a0840520-929a-4973-8ce9-91db07d6a9ec@gmx.com>
Content-Language: en-US
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
In-Reply-To: <a0840520-929a-4973-8ce9-91db07d6a9ec@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GnIllGZb/weDZeiZI8Hf2ZHD9DKbCCJtuxcdHH3LaLuQH7xwY/y
 hwfaS6zCHOeeK9JFv49A98OBucSk3Fex3vIxrlE7YP3MYXkmg4w8VKxhG+mw/uJUWyoyPqV
 f9yGI6E3XHdETBgM6T0RKqo+2owqC4s6V2LN0OHxQkJ8vGheLYo97R/Vdp8jmEC1e4v1tzO
 tu4vFij7MLjA4Vug6CJVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yKQD6dLTlfM=;YouROdscUQ2/YizEfomCjiNzE8q
 A/SrEGee7hlAxQVUL8iqTMziizPYsYltpiAm8WXtd9fTrJbu1aKO5pSLZoGucVzJ+3uB6BgqS
 ST6/ldNHYv+vkZM/GfN0X+MJD4Sr/etYjaKA/JWNTq0i6EGsXm/PJCBmAl82GG6SkwDQNarP+
 2wUDWYRgLODjXhhlFu31qV2T5hfmg+tOixrIcACirFkIrK0V0+LPDW0XyxtmFy5/GHHbaQl6m
 OzywNdBvadPO42RMAL4kHG8dYgB4ID57PzL+FtiWWx5Y5w16kp97Iyahn9Hsw/H8D00RXSwen
 79PClBCX5/Sc2YsQSEbve+apX7SQhxg91rhuVXUh5vDSuBnpWZY31y8skDerdFFbenQEQXx3J
 b+CqKN+Di0dX58XN3CK7G3HYni82meG30DgD2w/IbG54LhuxOt8es7HN4FdCPZn0oaODsZr5t
 QkmAomz7E7hNKhp1eXQRuJuFB7nHEaR/K1rmilKqJL3E2G++IuaoHl40aHwqO4fE9GpMb2qpD
 kHyL0wxDOt3Z1wXo4heU0x5mxF8aoCLlsChGuDDCqDh7i+lrIYzoCM138qiy2AXcA6Z2Gq6XO
 qL3eYpvpVwZf6Ydc84f7o6OYKnph4nozTaHCx3NhJZu+9mm6KolfVUfYzvV+pJnclnTJDz+3o
 NR1AAMluB9liRiS1rHfLr0rtviHyupdLvNP0dKtKXF+gTgtkd4i+MqvDDHax9FmkbmuoiLFb4
 UWUoFFxov1flSBlEzdnL4e4ZVvLAhuTGDpLvyn6tiD2aUw/i2Cvu393pjRkyTMF7Qp9DeZNbq
 531Wu5N1bkS9JSPKbZ2e3bTEiFzrwyg5w+F3SKxHrLSBM=



=E5=9C=A8 2024/6/24 14:40, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/6/24 12:37, Jeongjun Park =E5=86=99=E9=81=93:
>> If a value exists in inherit->num_ref_copies or inherit->num_excl_copie=
s,
>> an out-of-bounds vulnerability occurs.
>>
>
> Thanks for the fix.
>
> Although I'm still not 100% sure what's going wrong.
>
> The original report
> (https://lore.kernel.org/lkml/000000000000bc19ba061a67ca77@google.com/T/=
)
> is showing a backtrace when creating snapshot.
>
> In that case they should all go through __btrfs_ioctl_snap_create(), and
> since it has qgroup_inherit, it can only come from
> btrfs_ioctl_snap_create_v2().
>
> But in that function, we have just called btrfs_qgroup_check_inherit()
> function and it already has the check on num_ref_copies/num_excl_copies.
>
> So in that case it should not even happen.
>
> I think the root cause is why the existing btrfs_qgroup_check_inherit()
> doesn't catch the problem in the first place.

OK, the root cause is the qgroup enable/disable race and delayed
snapshot creation. So that we can have a btrfs_qgroup_inherit structure
passed in with qgroup disabled.

But at transaction commitment, the qgroup is enabled, so some unchecked
inherit structure is passed in.

In that case, the added check is not strong enough (lacks the structure
size and flags checks etc).

A better fix would be only let btrfs_qgroup_check_inherit() to skip the
source qgroup checks.

I'll send a fix using the findings above.

Thanks,
Qu

>
> Thanks,
> Qu
>
>> Therefore, you need to add code to check the presence or absence of
>> that value.
>>
>> Regards.
>> Jeongjun Park.
>>
>> Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
>> Fixes: 3f5e2d3b3877 ("Btrfs: fix missing check in the
>> btrfs_qgroup_inherit()")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>> =C2=A0 fs/btrfs/qgroup.c | 4 ++++
>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/btrfs/qgroup.c b /fs/btrfs/qgroup.c
>> index fc2a7ea26354..23beac746637 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -3270,6 +3270,10 @@ int btrfs_qgroup_inherit(struct
>> btrfs_trans_handle *trans, u64 srcid,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inherit) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inherit->num_ref_copies=
 > 0 || inherit->num_excl_copies >
>> 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i_qgroups =3D (u=
64 *)(inherit + 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nums =3D inherit=
->num_qgroups + 2 * inherit->num_ref_copies +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 * inherit->num_excl_copies;
>> --
>>
>

