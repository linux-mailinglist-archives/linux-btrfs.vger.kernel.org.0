Return-Path: <linux-btrfs+bounces-7868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D396E755
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 03:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E581F24A64
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71351CA94;
	Fri,  6 Sep 2024 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="m/g/USrh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E16BA4A
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586766; cv=none; b=u+x6Q0rghBqjezsrHOxf4HgQho27hbKC6gkdHQgZnN0PiggbywO18s/xB1kFJNiocYNlnmY6PbVht6fA4RECnIiitUqqUqpncQA+p9/UFqkDPZEJSjfslnvXj3ePYsqJD8I4rS6+yjz6yqWvTWEMzvi9RvdvdFWoyZ9tpvnRSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586766; c=relaxed/simple;
	bh=Z+xQW+x4QFudrmJcygHb0xyMa0Xe5i72jjo3v/qeiok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NNdAj2KIy26vj+BiS60vGW0UjoDv9JwSZfpClQuExwB1EYRpbQYIm7L/LIPs9NoCn2bQ5Xrm+6fMgdRaYvll54WpX88EN63gF3CT7+OHe1nt1D2s+BHhrGRDJpuwuNdJLj4jkmb+rJe2gWekpK7piDgN41m6vywV5zEOJy//b60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=m/g/USrh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725586761; x=1726191561; i=quwenruo.btrfs@gmx.com;
	bh=A8liDbwtdrX16c6aDlmKqj4LZ2Nq13zwAdV3ENZ7mUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m/g/USrhEvZKXG1AFfzDlpwc9c/mUsp2nHlSKWOEw7an7MZ83No2cSb8bu/cayjd
	 HPhkvdk3HZIlHTjhPLmLMlh1EfvoqWTA2rmVT5ilI1gVhvj2LC7ETw+VFEARi25Lm
	 hjOlYyEvnvgZlhjE0gJGeU25cZYEIMCmsHggUmywD9zwy/PP737frnMDIupncNLCX
	 w5Ldxr+u37dbx5uAq+EP0Crf2fPStLrWQ+j22tGmV0HBE1B4YaWo8BASQnCuFZYRA
	 t3bZapYCqat3Fqi4oAMGfTn/1tC6vg6GIMO1uoFdQx7/6pS1p6kL2+1HzLp1Erkog
	 Y/TKsLxTjtonP/6xbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1rzEg92KiL-017lWj; Fri, 06
 Sep 2024 03:39:21 +0200
Message-ID: <57d77231-4d07-4773-93c4-0f27bd9a851c@gmx.com>
Date: Fri, 6 Sep 2024 11:09:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SSD stuck in read-only mode with call trace and itemoff /
 itemsize errors
To: Brent Bartlett <brent.bartlett1@gmail.com>, linux-btrfs@vger.kernel.org
References: <CACSb8pLWjCPBvfYNGqFQ_6V06SFSqdm-Ea=SC6g+D9_=qygvgw@mail.gmail.com>
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
In-Reply-To: <CACSb8pLWjCPBvfYNGqFQ_6V06SFSqdm-Ea=SC6g+D9_=qygvgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F4cFoFCE9gCCNc5DY5Jq6nn1ARI+F65HeZ+oYSJWMX7vpzHXZEr
 0aC9OUUeKkhU8YzfIfZLadMsO/IJLf3s/COmHbJjrQZM1bg8fvqIv0v+fOoUd8az2lh/orn
 RCCDqUzYLo0JGqU71yoFXyBea94TnJhXwIIPL+dY8bY38G5ujAn1QFnNJRk+lF1Gm2zTvRb
 gQVKIGYF2Z9R+auxp2H6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0PRovW9ZpmI=;dOln5rOK/71nOC39Zgb+7Sw0Cmn
 B+XwRYw3+qnFNN4bbZK+4loe6OySJCDHY8+G8pCOmVXvV5B6XYYG/gghAJT/pDq3mmTb+7z6s
 vIrWKIfrh0w7ivBFfyOLMdCogqi70SwJ0Mg5976wSQSIDLncGqh6aIAJp9IF9iR1bT8BNsJvm
 +gtQ3B4uKbqpN1G8P1df1abIHvCAYVijJ+u9XZl3aNYPbsElTRY/tK0PlgGnt0bHnQe2yRKB0
 +VJ+mOISn9ib/M7CbBKaT+nT6+60/lYiVvPmcEXDAklACx7x+kDbu3m7Kt3vPmOZ0RzjznL1a
 RUas7TXZWLhEGHaAXYAx9x1J8jsUBuK6SfilQOf8+iKyh7rX7zCzmMihQxOlG12wufXRSNxTB
 CPZv99YBnvQFW8KNWKQw3wcJ31WS32EdAwu9DyPiS52lKEiKLFQxOhsw+tLH3p6fCk9RVKt0F
 midF+zPZWc4+AlpdhjKiEyRKPxt09sTS99fYtFsvoSzVphivHgDNOq8AgqTmrsltOOEJsb/NG
 gJb7QnqKUm9cb7hfbUZ2R3LM647qW57GLhqOVN5mNmJJaEkD6H9+Ka9iPmPHLQyree/qkTnOX
 wyoUtvkocPZ2qnuPM3PU85P89qEZ5Ag3gVX4t7VMXj9qERnOX3Mqcvf3g/mwUw9XlKlWvMW7f
 bxroPny2HOaXjoWze/he8Z70jCrmmyBRTSc6Bxn7eHR+IiaTZsgc8THsS+Z/5swrB2PqMMtK/
 zvhQUrE5Za56K3odkLLN4tz9A3A5csXuKZJbJY4y4lN5YHJoMg84baa0oo2hmSp+9mI9MQUDw
 6iXIRFkuke+EMNL25l3wWHsw==



=E5=9C=A8 2024/9/6 10:29, Brent Bartlett =E5=86=99=E9=81=93:
> I have an SSD drive that was mounted by the system as read-only due to
> errors. I have posted my full dmesg here:
> https://pastebin.com/BDQ9eUVc

Great you have posted the full output:

[   36.195752]  item 123 key (228558536704 169 0) itemoff 12191 itemsize 3=
3
[   36.195754]          extent refs 1 gen 101460 flags 2
[   36.195754]          ref#0: tree block backref root 1281

This is the offending backref item for the tree block.

But what your fs is expecting is:

[   36.195988] BTRFS critical (device nvme0n1p2 state EA): unable to
find ref byte nr 228558536704 parent 0 root 257 owner 0 offset 0 slot 124

hex(1281) =3D 0x501
hex(257)  =3D 0x101

Another bitflip.

I'm pretty sure "btrfs check" will just give the same error.

And this really looks like something wrong with your hardware memory.

>
> Please let me know if you need any other information. How should I proce=
ed?
>

It's strongly recommend to run a full memtest before doing anything.

I'd say your previous RO flips may also be caused by your faulty
hardware memory too.

Other than that, please provide the following output on another system:
(The lowmem mode output is a little more human readable)

# btrfs check --mode=3Dlowmem <device>
# btrfs check <device>

To make sure if that's the only corruption, and we can determine what to
do next.

Thanks,
Qu

