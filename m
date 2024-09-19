Return-Path: <linux-btrfs+bounces-8121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763A597C4F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370B8282A7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463E8194C69;
	Thu, 19 Sep 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ok8k6jn6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C317166F31
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731556; cv=none; b=meckZxZWgLRaFBciHKOJ6Fj8uWpOedVQKfK3VUvZfeQdKtBs0tgEEbiMov3GEp15gDEZ36z3BpXk2Xf9XEOWSLrNudc9JPNqdwTHQ91eEZvUBXfhNS/P01NmKkD+cJ0hToZrrlwpc889rjLJ3axhpYbw0LP4d/aNy9QPvk501JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731556; c=relaxed/simple;
	bh=Q/2krKD8OAotqTloZEDnmGSjjCOriPOznrQEyLsDrfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffXvw9jDuXgwHJPLRklPWVDzNTfgJlkmOHtVA+ScrQfCSBI9Of7/bKxerrSVlj+8TSGVrHnVnI8pI3dEfR17pdtOeeqB+JibVev2IzUquLqvtAcgT0OtinHNPFRjPSjRjUVU1DTylUtmBAcI72MB+8FmpolZy2CmT4e6J8AQEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ok8k6jn6; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726731550; x=1727336350; i=quwenruo.btrfs@gmx.com;
	bh=VZ44wIyKZlXo8eDwkhGCjq0uBBBpGv8va1XTPww9egg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ok8k6jn6OoQZ7iX08Bew2f67pyw7PGbQ2lQqGwLKJEdbDgkT/YmvvXnLa+G6IjdP
	 imwfweUHytETaQAVSepm65TgFhlLpsY7IenzQiOIKNJPUDgD5CtqcNh76iTNIuhUi
	 DzC6K09SOGtHUTnEN4Le7vS9uCbGgUdWJc1ZQ5N2DFY2yIwFrsWv91wuUPFE69Ft1
	 Ysp3MNRIzHpVQGAMBe3ocamrYy3Y5JeOtLZYtCDMzRxl6wIRDSK01p24WCW2z6KkK
	 k2dSt+THZyp8ack4577F3X/cg673jc51Sj84S5CJyJchB56szKj4in5Ls6sFkohVb
	 bSchTLU6FNlvTOfs2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKbkM-1sYQRm0ZW0-00RmBT; Thu, 19
 Sep 2024 09:39:10 +0200
Message-ID: <34e6df34-360b-42d4-aa4a-9346f248056a@gmx.com>
Date: Thu, 19 Sep 2024 17:09:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "inode mode mismatch with dir" error on dmesg
To: =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>
Cc: linux-btrfs@vger.kernel.org
References: <CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com>
 <5c42a8a3-6571-474a-936b-df13057ff0ea@gmx.com>
 <CACsxjPbjbBFV1YBSfMSN07kx6qoNrFihVC6oqZOmrtZgKHYytw@mail.gmail.com>
 <CACsxjPa1T+XUXqQ450fn69O91_g6mte-U_xhctTMmL5RujSzxA@mail.gmail.com>
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
In-Reply-To: <CACsxjPa1T+XUXqQ450fn69O91_g6mte-U_xhctTMmL5RujSzxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sMsD2r50y96KnrbLR47JtuaoslWDNdnSm/m9NCfiusel5bqLnv4
 W4Ssylst1YY1suuk4sRidCInIoBMlFdLVP5vp5srSR5u1lidzr/RAqcbbTP0/f+9ytNgDpc
 3Ze12gvziD5vsmebxc2aV9AwUepewzvyqFzZrKF7tPP0JtCq00whce4gFjMWGudWVAW4dqi
 FR/k8fR9IQjokU5+kj98w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fsRSHZZM/bc=;ds0+Hhv04WWU6aruT0CzajqQs4l
 UHXKJBOcWyGypspgoLfsKwrnOv3Bk+DLa94tC25u/14Sy1qzSQRi71/fzw8pbxpi+8SbZufbS
 MWSBtlDT2vNMzrVStLdberF1X640wgGX+osPhscZ+A+bOmYb0qeH1guSym+bcF/2jKJwnELR3
 p8xYyyoF9A/R74yCKWpvkzo5DwfLfs6TJ66DhYKHRTj4y5Qz497BsV5mmsCUKX3r3yXflKlsK
 /A6dSLgVGPwaGvs4N7oJGbkXOE5EXlE20uPi2JmBpbVHTSPQTgc/ZrZ2SaQsFDn4WoYuH1tim
 XaLLtdGyrnNObvkXSZ+6nmeZRjnSsSukvYLhzaIZXznx/wiVEj5d29+jn2YuP3A5AmfHIEkDc
 P8IQxu+1EVVjG15LxEhiubbZ1GLcNSicLGWt9vYycq1TIXZJn7PTekFlBkxGfVYrInUSlKGi/
 r2ffHQhvCgl+ylPAOAXpceDkbOHltY9m9KUgdnlPRqZelgzAaa0Wv9YVyaF9D5YW3lumDRv9l
 3yi8KF7Ql/fzn8i8p8QW6+vJ9muJNCau/n+JuZOfabdJ70IQNv3D8NmscIXATEE8AU78FlN1w
 k/37TZUDsCb68EethAAaHuFX67UX1rJCkkiMFV8hgFAkOx7Dq/JJjnDj+nl+dPbZ1IdJF6JjP
 nNW8+3IlV2zpzaxjOpGsCJwQ+9xFYWN9Lxz08VNdr3jEII3KnoE8PQkWwtmKZDv8ZwGJ6wuHj
 yX6Fbr5Bsc14Ap110IfZRALxgGpk5kOFg9arkcdhDguK41caskWn6fhVLxY1cfevNI3LemOtS
 xB2oeh+ympu8cpwMAb87/cpg==



=E5=9C=A8 2024/9/19 17:01, =E5=B0=8F=E5=A4=AA =E5=86=99=E9=81=93:
> I just updated my kernel and I'm now encountering some additional
> errors, that overlaps with the directory containing the previous
> corruption:
>
> kota@home:~/.cache$ uname -a
> Linux home.kota.moe 6.10.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> 6.10.9-1 (2024-09-08) x86_64 GNU/Linux
>
> kota@home:~/.cache$ ls -lR . | grep -F '??'
> ls: cannot access './mesa_shader_cache/a0': Input/output error
> ls: cannot access
> './mesa_shader_cache/1a/bc70b1f1d2efc3fc867739909e6c3f586de8e9':
> Input/output error
> d????????? ? ?    ?        ?            ? a0
> ls: cannot access
> './mesa_shader_cache/56/af44c0b3f9711d3d2fdb577beb527d95a9ae20':
> Input/output error
> -????????? ? ? ? ?            ? bc70b1f1d2efc3fc867739909e6c3f586de8e9
> ls: cannot open directory './mesa_shader_cache/77': Input/output error
> -????????? ? ? ? ?            ? af44c0b3f9711d3d2fdb577beb527d95a9ae20
> ls: cannot open directory './mesa_shader_cache/a0': Input/output error
> ls: cannot access
> './mesa_shader_cache/cd/cb796d11e04af4607054e2b7230091f5e7dc4f':
> Input/output error
> ls: cannot access
> './mesa_shader_cache/f0/b401bcf9f5add776020730e84d31f4e3ac8366':
> Input/output error
> -????????? ? ? ? ?            ? cb796d11e04af4607054e2b7230091f5e7dc4f
> -????????? ? ? ? ?            ? b401bcf9f5add776020730e84d31f4e3ac8366
> ls: cannot access './mozilla/firefox-esr': Input/output error
> d????????? ? ?    ?      ?            ? firefox-esr
> ls: cannot open directory './mozilla/firefox-esr': Input/output error
>
> kota@home:~/.cache$ sudo dmesg | grep BTRFS
> ...
> [52524.008236] BTRFS critical (device dm-0): corrupt leaf: root=3D258
> block=3D583989673984 slot=3D0 ino=3D19219306, invalid dir item type, hav=
e 0
> expect (0, 9)
> [52524.008241] BTRFS error (device dm-0): read time tree block
> corruption detected on logical 583989673984 mirror 2
> [52524.009237] BTRFS critical (device dm-0): corrupt leaf: root=3D258
> block=3D583989673984 slot=3D0 ino=3D19219306, invalid dir item type, hav=
e 0
> expect (0, 9)
> [52524.009240] BTRFS error (device dm-0): read time tree block
> corruption detected on logical 583989673984 mirror 1
> [52524.009537] BTRFS critical (device dm-0): corrupt leaf: root=3D258
> block=3D583945076736 slot=3D151 ino=3D19219306, invalid dir item type, h=
ave
> 0 expect (0, 9)
> [52524.009542] BTRFS error (device dm-0): read time tree block
> corruption detected on logical 583945076736 mirror 2
> [52524.009718] BTRFS critical (device dm-0): corrupt leaf: root=3D258
> block=3D583945076736 slot=3D151 ino=3D19219306, invalid dir item type, h=
ave
> 0 expect (0, 9)

No worry, it's the same problem.

Just inspired by your initial report, now btrfs kernel will also make
sure the dir item has correct item type.

Thanks,
Qu


> [52524.009721] BTRFS error (device dm-0): read time tree block
> corruption detected on logical 583945076736 mirror 1
> ...(repeated a few times)...
>
> Is this the same kind of corruption as before? Or is this a completely
> different issue?
> (As usual, none of the corrupted data is important so I don't really
> care to recover the data. But would be nice to get rid of the errors
> so my backup software stops complaining)

