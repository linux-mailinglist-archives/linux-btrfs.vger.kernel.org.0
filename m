Return-Path: <linux-btrfs+bounces-6262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA3F92966A
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 05:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C943D1C20EF5
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4B4C9F;
	Sun,  7 Jul 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uAHVf1xn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB81C3E
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Jul 2024 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720322201; cv=none; b=nWndtOC/YcaG9vjKuLUzI630FTikhLi5QIHASNYARomHtKs17J7ep5wMr1MdpZIgEyYwIJk9C2KVfzAHdyUMHXdzq8uQ7HR8JIEXiUEyYg99AaJWZldOhs82wkCYHbdgp0v5qffCO2YoPQQWguhaeJvW4WMxa/5F3VY5/o/r4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720322201; c=relaxed/simple;
	bh=cK1kyEcAX9seBPtpm8R2Xxsfgl3ApVGrjM/goDftJ8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDFlT6qIhqwzeLdRHnvxzXBWxc4G5uIa75uL+ddCv+EOLxP9tjCOsu0WqT1fG7HndQ2rBGTP58x3kJhbB2LASvdXrKOLCmxXA0tizl2Kmyae4dIylPxKHpk4H+cFquDUV5ThulS2ZFafplx0wEDa9OtvPqFuh1TxPuoqgBB8mME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uAHVf1xn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720322195; x=1720926995; i=quwenruo.btrfs@gmx.com;
	bh=w4w3vAWYxqxGPp/0CnLlZcbTHWS5fsOaMFs+EcXVOUU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uAHVf1xnYD8G7oo5AEpUyYB3tMmUXaND/ALzaExwDHZRDE2IGY5COAcm213N8J7x
	 2JJCAMhuSwDU49W3Be1tkppuPqd9rAhUWn8CvY8AoHVU5pZ6WsD1RLKzKJ1a6M335
	 MPz23JKNHv+jDsFuAU00DOzdJI4rXBUQvM+C+jQnQB71NY1D65of58CjoHy65cGun
	 XmyGZUeJn4iY09rksPL0hPKgpaj4nmi7yu2bbmjTsPihxuDO3fL2lNRF/3J2ErPFI
	 g3pLw3qsNmljxpqlhgY4KfSrSxF42CphjmHlWhGKanYTyTugaJy2/8rCeb/jsiHMS
	 bu5BeM57iQXg94NlKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7i8Y-1sLbc018zK-016Wm7; Sun, 07
 Jul 2024 05:16:34 +0200
Message-ID: <9cbb163f-0b86-46bb-8d00-0a10e288fb59@gmx.com>
Date: Sun, 7 Jul 2024 12:46:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: skip name hash check for image dump
To: Andrea Gelmini <andrea.gelmini@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <0163b37d7cdb31ed39e0eff2f61cdb4f3cd90272.1720137702.git.wqu@suse.com>
 <CAK-xaQauuhnY0bM0ss6JdFS091bFPaK77HGnbp9qG-KCMtZFyA@mail.gmail.com>
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
In-Reply-To: <CAK-xaQauuhnY0bM0ss6JdFS091bFPaK77HGnbp9qG-KCMtZFyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OAASauq82s/PHGkpH967i5aclQPLZsvS5v3PGpaeY6uMvlES0Ep
 ZGU3vgvoCPhpWOEodiZvN1oeRdlVgx52u1BRbbQOggGgSbn6ySpupzYBPDRrtIDz+XDd9wz
 EEQBHJng1RyAyYBVyFDVZUmQGcf/c9e2Rdp12/woElBuAHrM6lZ46qQhmU4dbcJj6TsEwAO
 J5CrPe6ESXKmKAbIfbSLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Eiui0MFM1dY=;jw50cJcGtciz1KNFJJ+ml0KAx4T
 Oq/kdM+PNemlrHS6DVfirxwzdIVh5K0H40bV/SJPuud1XzFBaramOVpAKVFId9D/f5aMGWy9U
 Pjsun+rds+IHJriYiXqDOMH0VxR9AxGyc4AgfwDO8ppQUB7m94qa1jJeeX23MMfPi+penjV9g
 aZuXGyG6zs1vmAQ28amL4jqgBVbdH+96VKLw9TUrX18HjEnnb4xwqlPzJu252tPEz8F3iGcUw
 dpW8xCOxCuShQl2DOX7sz+Akd4sWxmowc0qyP1sbTYKOxA/JIBqr1CXLHXl3V26NSg09+nLVr
 kmY+SexnZVCKVsakTjdln8BcjYAitZ//eXqZMQFc98ONWyUiUyxXO4tca6gCm97ep9ka7oZRM
 3IrxN0UMtE8CYW9op3uSI2P1RBRw65IfRYTYrYl6+jHBfpxF7WF0gipCjSDiUQ6PMqE2EsnTl
 Ev6rbMEBkX3hym4UlSBVfUp4qCvg3bjbEZWvj3AYek+lkj0YFHSkc/9GhkVtT7/nyVWu1mjuS
 ns8zksBQ3YJHFvjinW+Hn0e5Rss45R9kcqgWp/8Ww8IXwcORAJFZQhO1skw1qv7vNWElLa8kt
 Ypz9mo80VQkIsohy08MynAY9waovgKxm07I/Dtfb/z7iO8GiSWIjH/gA224qTc3Vyxb59ve5S
 WKiFPvOXzZ+OTe/1wTtCLMRgIf7j1dD6Wu3XR1sRQhEvdgqIsxWlE4GxoyiPCKHnIGtng3Vho
 hI1gzt5MdecDSOGJZwMKBscUXmPsodHw5CK4wpIaGDwjbttjYEQn88gj9m2z5u2EctD0978kY
 TXeqdfU/CBMIfwEf0rSuQrR9uz9qPxoZtejoO2VmtzkZs=



=E5=9C=A8 2024/7/6 20:17, Andrea Gelmini =E5=86=99=E9=81=93:
> Il giorno ven 5 lug 2024 alle ore 02:02 Qu Wenruo <wqu@suse.com> ha scri=
tto:
>> [FIX]
>> Since btrfs-image is mostly for debug purposes, we can afford it to be
>> an exception for tree-checker.
>
> Sorry Qu, but I'm so stupid. I didn't make it out.
>
> I mean. Trying different combination, running:
> btrfs-image -s -c4 -t4 /dev/device dump.btrfs
>
> both with patched and not patched kernel, I was unable to mount it:
> a) not patched kernel complains about crc and so on;
> b) patched kernel doesn't recognize the dump as a BTRFS filesystem. No
> error, no complain, it doesn't mount.

Mind to provide the dmesg of the failed mount?

And just in case, "btrfs ins super dump" of that restored fs?

Furthermore, how did you mount the fs?

For "btrfs-image" dump, the result is not a mountable btrfs, you need to
restore it first:

  btrfs-image -r dump.btrfs btrfs.raw

Then mount the restored image:

  mount btrfs.raw <mnt>

>
> Also, doing a simple:
> string dump.btrfs
>
> I read filename in clear.

That's the problem though, as during my local tests, I also find that
"btrfs-image -s" doesn't really fill garbage for the dump.

That's indeed a bug and I'm still trying to fix it.

Thanks,
Qu
>
> If you want I can prepare images of what I used and data and so on.
>
> Thanks again,
> Gelma
>

