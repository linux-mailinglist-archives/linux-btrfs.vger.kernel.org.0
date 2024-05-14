Return-Path: <linux-btrfs+bounces-4955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0E08C4C98
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 09:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EFD1C20B80
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 07:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5B107A8;
	Tue, 14 May 2024 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CM3bwIkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F3F9D4
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670581; cv=none; b=ZVFpeKkv/LlfcKy9VXMTTLHTpg6nVz5tOwCGRIBIZ4YJj3oKP/O7Kisvg5PasQ42lmSGabMRE3DbOTKpReXtoS/5kGBFTw2OAoE37WNRstEx9fXkvtgjKNEgukLubTynIq7X/927EQVeAONwOUfxBOZdCj0TUboaQ8bTVhZyVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670581; c=relaxed/simple;
	bh=PiQV2P31CbTDy2WfG9V2zp1LP+qWdxWyKBJxmjpmUdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8zHEycYe40Ndl7yepwUjYxmNvh5p6Ad8XfQapQNDNiCJfkTODJnToMF3us6hwXzCEvKkWq2PYrfRkGM6UlUh10wy8yUT1Ai18zIy3A0AtsLWPq38uNRhwFZ8FqbY6Xisdvcx3BE/a2VcVprqTQThtvWVu+uc8LUWb+2Faa/FGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CM3bwIkF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715670572; x=1716275372; i=quwenruo.btrfs@gmx.com;
	bh=xVQJeOr6OGhG/GHLPs43Q/k9jOGYqpAPs2y+UMCcndI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CM3bwIkFlSaKc8RCzC4bwRDzrYFez/+wICmR5EvpqlM9R2LUvsKBlERgWA+nhLkg
	 nxpOsBRfEFYh0MfSZt46+S+Y1yVZRaTA4IDRZvyP4XzsCsfFcDHErboqr00kwdCRs
	 33Q4/5rrZIc7qVMnRW/rlYf6lrgziVGhp3Wj1TjyviELN0DdACQxgE/UYIwFmvC9a
	 Y/jN7qrTuAJAinNVaWcBPD9YGigmWBlvjHd/hoKK8wdnevV6IXT+EAmsq+GyR5ieN
	 8zcgnx0JXDz+s1jVFU/Jg17/AN2OyKBv/eO88VWA5R3xilvAHnFUIYNSohOXxP30g
	 Sm79mhNKQopA4sWUiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoN2-1sKZWn2L82-00G3lk; Tue, 14
 May 2024 09:09:32 +0200
Message-ID: <a1dda76d-3e2f-4d00-afb1-617550f0092b@gmx.com>
Date: Tue, 14 May 2024 16:39:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] btrfs: remove extent_map::block_len member
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
 <7d7ca65f30edca3d066310a816aac0a46ecb5d53.1714707707.git.wqu@suse.com>
 <CAL3q7H5y-0mFZey9PwmMtpPX6wHmLpdwi9KPVbZHATpbrUc9mQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5y-0mFZey9PwmMtpPX6wHmLpdwi9KPVbZHATpbrUc9mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fRnxNnoSiKkGLT5NFZdteYPShHcr6s86d5xOtcCdvJOg+r3PnKM
 P5rAWTKEUuadG5KIh8NrJ0DLEg4JBkmx9UNEQup/d9re3xnG01GlbJMWdJa/0Lp0qu5reRF
 q5mc/lhmXqnLtfUFV1nmpirOvej09gxyUwcxbFw8HrdVECZhnp/WJmSEBwzBBfN8amYvFhQ
 0y/IrzTJ5PZjJBqJpf0Yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e5KDGfz+VQE=;LiAHGTTev2tCFmhLeHZ3usk5bby
 kRjm67j0AVkiE2MoxKB9oHxawr+4zar5OBcYGUIvddby46nuANtF2x2w3xvoZ803lMPz2BRCi
 pI/vnznp7+eh+nRhd2/Q9M0+cRl6vbUgnfMiOqN1K5z6p8TwZxmjgasC9NcX79eSbtq4iC+HK
 QCzusXdF2RKrGU0Njiovqmmit4kJvMT5RXjMzLch6prEUK4DuMsqxgB4s3J51yDXmq1dK82rR
 svXubyVLl1ueLbE9/7WPjk/KZiLa1OLvn7qjI8cI45Dvejvn1P5hK35WHAty06WNvHHNBVYj/
 QGy+GtkhrPIdh/1IUT42oTEbsgE9H0ngSOWbcbIN3340rkY7GZvSTL5/8AeJU4rkHD+6HnBf9
 0lSsXLcJS9vOa+PGTJq81wb7oGC9lJZplzxhIMv+OJhyc9OygDHtW4KGEkCMCiNl9kG77bOQ4
 bbSCNF8xtxpiMgMnZAuX/cEoB8g5JDeXi+84SCRoe04wkOf4npmsDiPTIo0gN6MSSC2VftgdQ
 LIMENrih2ad4Dh/3tcEX+eBnWGYcWSoW1fdt0blptljLKezar4ir8Hjhlj9LU/RNSUUnXQaAx
 TV4PADdwq6FbKzNIAPfoHRP45850NEMojz4BOImSGa746B/r7HoowHljwZsuQtQLvNfNtIf4l
 GwVfOATgzut6VGooZwzipbvrnQ0Ehtx8zSgOFCy8V7m2DgjPxf1Nw4mcXLBtzkcGK1rJV4cK4
 3zqxWssZXKg/Ej1Y/PCqR8ga7ftqHh+UUu4LmXJhkQXpN9kqKM0Yww3A+7Oq0XMpDtC2m7kC6
 9HVgKUukZfrdZTxsIXZxlf5kF2OclHfp+VW6yETm7Mh3E=



=E5=9C=A8 2024/5/14 03:14, Filipe Manana =E5=86=99=E9=81=93:
[...]
>> @@ -1098,8 +1088,6 @@ int split_extent_map(struct btrfs_inode *inode, u=
64 start, u64 len, u64 pre,
>>          split_pre->disk_num_bytes =3D split_pre->len;
>>          split_pre->offset =3D 0;
>>          split_pre->block_start =3D new_logical;
>> -       split_pre->block_len =3D split_pre->len;
>> -       split_pre->disk_num_bytes =3D split_pre->block_len;
>
> Ok so this relates to my comment on patch 3, which added the first
> ->disk_num_bytes assignment, a few lines above and visible in this
> diff, which was useless because of this one.
>
> This is hard to follow. Some patches add code just to be removed a few
> patches later.
>

Thankfully after addressing the comments in patch 3, this one is gone.

But indeed this is a big problem, I'll re-check the patches again
manually to ensure the deletion is only there when really needed.

Thanks,
Qu

