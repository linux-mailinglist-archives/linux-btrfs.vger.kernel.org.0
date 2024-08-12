Return-Path: <linux-btrfs+bounces-7146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729694F95E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 00:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6984FB22320
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062F194C8F;
	Mon, 12 Aug 2024 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lZDNXQWQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4889189BB7
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500515; cv=none; b=L+ZM+iXtm8g8uxtG3WK4ICVlDBZ24KrHRkZAc94N4sYygDSuScUFrEqcryTgtUvgcBwutjL06PTB9cMsicKFUI8FOhU/Ut69MJP5Ls1TcLK70vSl1cQ3Yi49H4fiL4r0thNIvBwFL45cboKO2BMJLu1AnzVSwYS+sGTUPlwdQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500515; c=relaxed/simple;
	bh=0HFXB1q0Y4RmCfhqymmaPIn+pHfVxHTZZIyAR04i/pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWdsN6GWoLg4uKhx6xysxVK6cuhiLYFeTC5UNNMuDNUt4oPXMnf8hYZeHDzuGHfccB7YUqiYLbw8skM0hhH2s8lMJiBk6/J14iMlnWUYUhZ1sejH4JD9mOflvNmwFY9l0QrHtkAJMtiD83bUXlDaM2l7WGVGPmrHBA0e86lMmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lZDNXQWQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723500506; x=1724105306; i=quwenruo.btrfs@gmx.com;
	bh=0HFXB1q0Y4RmCfhqymmaPIn+pHfVxHTZZIyAR04i/pk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lZDNXQWQRQ/47iOEl2lC0kffZy60DuiF493isLHWrelzOaMBmpW6n0s6hjdh93JQ
	 e/ld8pFioqThS0rlUgIYrqo4FxkIGw3d0qX/XWm6uHY8tbmeQJ3Bq77EWyao0viBG
	 ncDaGxHBiUmOlSARYzZc91pHU6eGc5/mmaB7nLbGVNe53VWOItCNcfW6+hVdtPMt+
	 Jr5zGRexElTS63rGfiafGaS8a5ZdWByQA/7vsEOQmEe1oVkMDb4uixLp+XWVcEOZ9
	 7ESr0RLKdhmQ+4wR6CAxICTk8e7creX4yUzrY0ycysZ0hrBLa2GDPp6lpbbzJo2nN
	 xCuUNT/1zNpooT0R4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSbx3-1skcHg1uAb-00U7UG; Tue, 13
 Aug 2024 00:08:26 +0200
Message-ID: <77cda2a4-08ae-47b9-8efd-e3ca0e8fe9bc@gmx.com>
Date: Tue, 13 Aug 2024 07:38:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
To: kreijack@inwind.it, dsterba@suse.cz, Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
 <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
 <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
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
In-Reply-To: <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C/VZNgcCtBnRjjutp22g5crtKCFB0dtXrvLYeJlf6ZrfNWHk+nL
 H/PWk+3Ag+HYl0ipf1500D+LWIOs2cINtN2Z4OT9JjwF68bpc1bWciOyHYkbK6VLzeiDpIX
 cGmHo1ieBoHu7+iv3R9boqUMLPl9fqvzQLvwI5bP/mmCV0XNhPdnAU4/avb3+9nAD7iF+Eu
 7XD/3wcOtjrMURLi2KUQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XZ4Y00LzATQ=;dl0gzCTtUYl7Gbo5p8/LaXmqO6+
 lstVjvoEWlOgMnURT9F8UFKO6IKKqk61p2HOlvmy1ObBUwezWg8v7u2W4N9ZdS464DmthCoTq
 R9Sv5vLjbqxIT70UzyBfTsTU4+prgjLlO/ywPHFoguEaQeHfWPNia2ByLgmG/V02H3K3zldcE
 NWf+i+7qk3ufmuJGF5GyvVj27DJwtKzy8zXmsPDafIlS0fqH2jOyerZOzKNXFnCvcVQIsduha
 vLWrJ7V/LWJ6a8QX1fnhARq+bmE7e7VykbJj4K3Zx4yXrl/LPX2rljfAIRDgLa59GMtKjxvLJ
 0/IPyDvT1VRd1IzFIEal9VFBC0Gup9BlksrlcXwLH94n/fcE20OqoFUUcmqKwcSyuSYtwLQWv
 GxfBnZNu1/TOMgaUkxPT6EO04XdRGyGDp1uwV/MVB0jQh9HT9/oNfdOHQP6hBCBRlhOrkJPmp
 CS5Neelk/R+dz6GZl5xgVbqrGeokwGQi+pFDZ8wnRhFIlr92WR8TxrRql1SZ/B4YbcK7UXkzS
 Bz1hkLpTFwpunxV9XpbFX5Q32IQgXdqJwcPkkURDLTj8vWxM8eEM556gLXdrsRENNpazRXq5j
 qb6DVsDkGa6os7PwjEqvd7NRdHEjbn/KcNemcZxz3E3RHyVcvKTyfCKhJp+wDIjC1Tnb/hEU3
 wP05zNljrw/+h1BoZOABjMn70CywWl/pMUgWYNNvUS88jwy4Po685DZT87bV2Uxu90WAL59KV
 tVl2NiUMZvznVbS3JCvw2ktwTl/txgVu7iaNUxChvneTe3vVVdiF1yNJGKu+ut4C6yBaZuNhr
 6RcHZkwOLZ5GPHaJyaXkYn4A==



=E5=9C=A8 2024/8/12 21:12, Goffredo Baroncelli =E5=86=99=E9=81=93:
> On 11/08/2024 00.40, Qu Wenruo wrote:
[...]
>>
>> Personally speaking, I would prefer the current scheme way more than th=
e
>> out of tree subvolumes.
>>
>> It's super easy to have something like this:
>>
>> rootdir
>> |- dir1
>> |- dir2
>>
>> Then you specify "--rootdir rootdir and --subvolume /somewhereelse/dir1=
"
>>
>> This is going to lead filename conflicts and mostly an EEXIST to end th=
e
>> operation.
>
> I am not sure to fully understand to what you means as "filename
> conflicts";
> anyhow, now you have the ENOEXIST problem :-)

I mean, if you support specifying a out of rootdir subvolume, along with
rootdir, then it's going to cause conflicts (the file from rootdir with
the same filename conflicts with the out-of-rootdir subvolume)
>
>>
>>
>> =C2=A0From my understand, the "--rootdir" along with "--subvol" is most=
ly
>> used to populate a fs image for distro building.
>>
>> If you really want just a single subvolume, why won't "--rootdir rootdi=
r
>> --subvol dir1" work for you?
>>
>> If your only goal is to reduce parameters, then your next question is
>> already answering why the idea is a bad one.
>
>
> The use case that I have in my mind is to create a filesystem with a
> default
> non root sub-volume, and nothing more.

You ignored all the things like owner/group/privilege bits and maybe
even xattrs (for SELINUX) that will be needed.


> This would prevent the typical
> problem
> that you face when you populate the root-subvolume, then snapshot it and
> then
> revert to an old snapshot, swapping the subvolumes.
> It is not easy to swap the root subvolume, because it is a special in
> the sense
> that it cannot be deleted and it is the root of all subvolumes.

A seemingly simple solution is not always that simple.

And I can always argue that, for your "simple" subvolume case, why not
just mount it and create one?
Especially that one needs to set the default subvolume of the fs anyway.

>
> Being so I think that it is better to avoid to have the root subvolume a=
s
> default sub-volume.
>
> For my goal (having a filesystem with a non root default sub-volume)
> creating a
> template filesystem is waste of effort.
>
> Now these two use cases (my one, and the one related to this patch) have
> a lot
> in common. So I trying to find a way so the two can be joined.

Unfortunately, as long as you're creating a subvolume, you need all the
details you ignored (which makes the use case looking simple).

In that case, it's just a subset of the feature of Mark's patch.

Meanwhile Mark's solution provides all the information needed, thus I
see no reason to introduce extra interfaces especially when Mark's
solution is already a superset.

Thanks,
Qu
>
>>
>>>
>>> However, this would lead to the queston: which user and permission has
>>> to be set to those subvolumes ?
>>> So I think that we need a further parameter like "--subvol-perm" and
>>> "--subvol-owner"...
>>
>> Nope, the current code is already handling that way better.
>> The user/owner and modes are from the rootdir.
>>
>> Meanwhile your idea is just asking for extra problems.
>>
>> Thanks,
>> Qu
>>
>>>
>>> BR
>>>
>
>

