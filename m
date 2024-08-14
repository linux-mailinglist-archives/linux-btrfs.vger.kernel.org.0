Return-Path: <linux-btrfs+bounces-7201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F0B95254C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 00:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6354E282E17
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 22:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A9149C46;
	Wed, 14 Aug 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Rh3zahx1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B9F14389F
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673500; cv=none; b=j932O4ksmM1vHxVZE1/tgXg2ItN3S5ukR7VlJ/Meb6/1aZmgZlfr749zfXixqQFGLpoVyMI6KBjVAUZJ5sEgNOG2MxM26MmklazMT1DQxKhlRx9WUo18bmNjdwgftM7t+xdWTpewBqMwtcrDMb59oclMg2TBNKve7px7NLRhspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673500; c=relaxed/simple;
	bh=dl+on2HaP459h2M0EO6LeBsv8zzjc+MufudoLOPQG+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD/rQbOzJdNqrYdhPLafg2qMA7lkfCYocsSt9ht0c3WTFjlxhQQgIU2JKmcfcqabUqLZ6LVcB4SIFZnTpjlNM4ZanF8rLlJBCqMeEKkcD0jW8Y3RtG5+XfuAoiic6jrSZJFVgeaMhUMOHJBrkOGfwLRSSXnufB9AJRaQ5DqoJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Rh3zahx1; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723673467; x=1724278267; i=quwenruo.btrfs@gmx.com;
	bh=JKdH2KTgCbcbqYdB1zMHwAJIxEbwRVgqv/8Fq7+9Hsc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rh3zahx1bG1qvKwFmNhhGAqsfPIGlylAPEqCO8djPhg5CI3gfhkCiH5Yq7jMYnmk
	 jmnXvvPIWX1MLBxT8WxX84EbfiSORi2gIZ11SoExjh+9NzPFn0QApGfN3uQTHQLA8
	 LAeOUtZf8V5Qf/fsd3/eGJ9hVxSuS63qyK7zmKuQpeeUX4q7h4P5WwFn7KJ+njVDy
	 WdPHaCErU/va3oKd6u0+/SaoIpEOf0EOO4QfsKXd/PPe0nFquUnNRi2gwtKMO4o1Z
	 sGpjAtpOmdRvt0XdJJ3AUAGTEDcRrmAHKwBT4QMMjnDPYqXl7kGIPsnet+qgVkvcH
	 uaVwbpD0FXxzRP4KJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzuB-1s2GV32RDD-00cJRd; Thu, 15
 Aug 2024 00:11:07 +0200
Message-ID: <93991cfd-8a39-4178-b8ff-a5edd445410a@gmx.com>
Date: Thu, 15 Aug 2024 07:41:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
To: dsterba@suse.cz
Cc: kreijack@inwind.it, Mark Harmstone <maharmstone@fb.com>,
 linux-btrfs@vger.kernel.org
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
 <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
 <1af5c6be-27ff-4dd5-ba5e-9213bd1e9f68@inwind.it>
 <77cda2a4-08ae-47b9-8efd-e3ca0e8fe9bc@gmx.com>
 <20240814215703.GB25962@suse.cz>
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
In-Reply-To: <20240814215703.GB25962@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:73Jv6Ph9SDkU9B0U5oENO7scrotaipD5foEoOnW51kILqN2BWya
 E0Bf1JdjhdjBVNHCLiVG03HxQw11B3bSW4YIywXLENUcqpCbP2cGIOIYSPgVBwI76Sx7BdU
 5ZiOCUW0aY1skwNOP5pKMxW+REsVh0Cl0CQApLMSli/BaCRMIZYgYIGOqRAzfdUHcLRB0AX
 kXa48FB5Q96t3pDQH0sOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9k6ab0oleUk=;F/vqTYXxkjLYekGaKQ9vMy5ypon
 1cNZdXiJuQwXxR51vD7oxYr3aSRfePOaA2Y4CKBqHe2dBV6nQy5gssA+fwPGR9yLa9xFKw08q
 4PkFngUa6qDnyuB9Qa/vPj+wAUDB7FeQgSxDTVni60wScO+lzTOO5t9O7XedJvQp0oI8W+Pui
 QyNDmMItNHWIq67tyg2Oe+3c5Ua5VEvFkbOSmEZxRkk+hbh+HIW0O66tbrFpjkhqdIwwMTL1L
 bd7qWA2Z7bDxfsDa8GiVFtgv19vJtfQfHC6jwVPDymjMmE8gN7E/TouL4/dvQMmiO7kii23ko
 yjvrQ6ejHVCvvY5o+aA/Rhr2p+tqCL3uIWLRqG/tMxvkEqPimCmUUFVqo9vqDIEUouhcxUoKq
 ToDTpVBnYFnsteqm6+TW7TJu7KaeJjXjoQTnRjgv8+okxFl7cpgT7M2hrT7NX84aK4WzXilYl
 3rz25JDb1dmdUt2GZpT2kJ4oFJ0WbcIDaqvDnAFyUNQ4gjf32toyUbfhCwuaI9i0YrHGJx8KC
 5m4R+q6WpEXtP0Tqu52+56wR6xBDnxU44HDyOkiKPRMstqx6yo2RD4ZIRDE9e4lu90eVxm8WQ
 wrTvUuT9jBP9JM6/MukFzWU6XK+LxQ6YxNECySRgeTFTNrhAvCn4zksXm9zDqAoF1puEC+b70
 G0ssSzk+8pyMll+K6B3J+Upu8s8ArNDVqHJ8kDzVBWeZnBS4nRuifr5hA3O81mYo7+gdX/HIa
 N3/SEHRF7rM8hRZ714IG2hF0ngItHp7sCAQpSJJ/53UrV96jefAD+R/yIrIcbxd17p4CWTMEK
 c8ewtZu9kTdPHHCIEVQFmRgw==



=E5=9C=A8 2024/8/15 07:27, David Sterba =E5=86=99=E9=81=93:
[...]
>>
>> You ignored all the things like owner/group/privilege bits and maybe
>> even xattrs (for SELINUX) that will be needed.
>
> There are probably two main use cases:
>
> - create something simple, with files copied from a directory and now
>    newly also to make some directories subvolumes
>
> - create a filesystem where any detail can be specified, like uid/gid,
>    access rights, ACL, XATTR, ...
>
> So far the focus is on option 1 and it seems we have the most common use
> covered. For option 2 the command line options are probably the wron
> interface.

Nope, the current implementation (inherited from the --rootdir option)
handles both.

We have everything, except the hardlinks, copied from the rootdir,
including uid/gid/access mode, XATTR.

>
> I suggest to use an approach using a list of definitions, e.g. in a
> file, where each line says what should be done on the filesystem. This
> is not a new idea, XFS has a protofile, which is ancient and we don't
> have to copy the exact format, but it's the same idea.

I think it's asking for problems that is already resolved.

The current rootdir is already providing every functionality, except
subvolume related ones (subvolume, snapshot, default subvolume etc).

And Mark's excellent work handles the missing subvolume part, and he is
also working on the default subvolume part too.

So far I really see no reason to introduce a completely new and complex
(and conflicting with --rootdir) interface, while everything can be done
by --rootdir + --subvol already.

The only exception is snapshot, but for mkosi usage, I didn't see much
need for a snapshot.

Thanks,
Qu

>
> The structure is like this:
>    COMMAND OPTIONS...
>
> and we can define anything, like "ROOTDIR dir" that will mimick the
> --rootdir option, but also "CHMOD RWX PATH", to do mkfs-emulated
> "chmod RWX PATH". And custom commands like default subvolume.
>
> This is obviously more work than option 1 so does not need to be
> implemented right now. For the command-line options the most common use
> case should work. If we allow to take the proto file from stdin it can
> be created on the fly too.

