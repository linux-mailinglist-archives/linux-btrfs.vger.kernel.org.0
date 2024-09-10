Return-Path: <linux-btrfs+bounces-7914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B79744D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 23:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2651F27483
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 21:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372851AB500;
	Tue, 10 Sep 2024 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VMG6Wc/7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC51A76D1
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003848; cv=none; b=TPK1I6EiyEZvSkx7n6NLZIvoBFx9wTnbT5QQTzHsemNfpOcc6ezFVVDJawCB01ZVpgznevKJ4gpJvCzvb1NyZ8aZYKh/VRegRGCyzrgWyXFOTMGSfqiSQQWmZ1r+XJB0V0eQMAJESIH47JIeB2ca+6c/ajjhF9bNVfhJUJHTJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003848; c=relaxed/simple;
	bh=yfydiwTdeVGXXtX8TKPVFEDWCOgS7aoN0omDx4WXvi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sC7OLyW4KX3NEfgj7x76OX6aPvX/7vEiKHODBx4wVFeu98zmnqQ6ErpYKLe7fcdRpLRtfejup5uQHOFzIoV28KDXMsALFWYNUsfYKQxa4oUEu/okQ2L++5WO+lu69nwCTgfC7O9KE+G9VooaqQcqShhJarxyPniLOF01QFNi8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VMG6Wc/7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726003843; x=1726608643; i=quwenruo.btrfs@gmx.com;
	bh=9yxXnEJbuX7TSwJKWhzXFFfjL4DipV/JFLJPgdVWA1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VMG6Wc/7m6be2gG8sm1wE4veLJqx5v2c3uUKvnA6ajtsH4tXp8Q6VlL/VIXulqCl
	 8TiKtw1wn4BI3r7NabBwbQzY5QkGcf+55JVOc9o6pzssakSvyZZEGV/7oE98+16W7
	 VhO7V1ZUc7YZ0hRNmX3Lmjzt7DIis4tN+r10Dm7icGFbqS3SEVow+tWCRkROzQSWt
	 jVHMKA+q3iLHJpau/LEt48vsvf3Fl8KRll5lkdIINAcEjXbiQI6Pa87x0t1svhLs5
	 Ik0rsB4Ie/zh3guziQbTFgOcyhMNPjaVSIvQBrjZ6tZfyhAdOavh5+i+0tL77md4b
	 p2qJi9Lq/pnKTWkiOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1sX9Yf0ZZy-00UmH6; Tue, 10
 Sep 2024 23:30:43 +0200
Message-ID: <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
Date: Wed, 11 Sep 2024 07:00:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
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
In-Reply-To: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fyorL6+wwxXcxLx40L2KlnloRMwgy9ZKw+Kb1cdXaJm6ZgoeagK
 cYvlIC2xLnM6x24suZAZHk307VF6kwR0fABAp2vkFsrhixGkvjQKytbzqbiy4CEUJMQUM6q
 NqdLaWY+sO2AYMhhPp9qfJrFdV1LvBt0hS6WcV4iOYFheQAc4zboAbvTNfyKLerOBYSoMT1
 93gpMBJHM7+TzXgFf6MsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AkP5E1pAx8Y=;PXV7kY2W1mVH9TXqStQ+DGRwex7
 NIOQp63VVZdxah39duX9J6mC8SJVPqV4DByWKUDPZg0T396+T/EFU8iRrZlDY8iG7NggobmaB
 gZy3zGOFeVFQK6vaWEx74Mou1m0uYCg0JcH/15fSrkdKcQgAPvq4xYLHkW4gBmo621nWdy+Us
 8uFbOcKHsP27o8tScL1JLnCd64X3D/pTibgSuSHL8s4ukoPrVCwc61S2swrLpVS9C3TDeLknh
 zrahe29sbM+Rkym4X/bORrs3OJ3Xvyicw86OsbSHTmA2vx+1JEnHDk4ZL5RBT18SDnTWLQMYK
 VAhlxgVTu6npWQN8EZL7GR0TKezEWHELdJ3d4Zt+2NK7xkJvMhMkkrjuFQ6YwIyhqShloo7V0
 6Md8p9DwOLOsydCHcwXGt2DJ3G+LDtaFyBAnGNWxHDEUowbUbxNzGaok5GCauLxqniOPAxyfv
 d/VTUozBK9A0LDW8P0my7w4Th4RJR0+wO6+TAsCeKajQ1tlq8eU+nxJ1XKXIHxFHxaUk8oGUc
 fPKZbcQw5cpJDOyKJOvWM9nv105m/bzVM55dg5JvMy0KfoRi9LSgbiIeYP3Zc4Kk0OlYHFYn5
 Y6K/UJcN562fsMcy6m16vGyoAfpJxLhBjzativmGEcYcHoD6p8IdX4gTR5s72P/SxK2UZCj8t
 N8/ETzktCSeqhrRLBxz9dJcstESy3t9sPnx4I2N4bhjEdHNmAvLayhyhRUuZNR6M5HQqTjgCz
 EQjRR90RgqJTv3yYsb8V5MbOArLD+axaa1yYHqRnfLocmkY21xipLcBaaIJp6wtK+MvmSPgLF
 y56yNFYBm/AXDSJHPlmQe6kQ==



=E5=9C=A8 2024/9/11 02:38, Neil Parton =E5=86=99=E9=81=93:
> Arch LTS system (kernel 6.6.50)
>
> Cannot mount a raid1 (data) raid1c3 (metadata) array made up of 4
> drives as I'm getting corrupt leaf and read time tree block corruption
> errors.
>
> mount -o recovery /dev/sda /mountpoint   didn't help
>
> If I blank the log on what seems to be the affected drive I can get it
> to mount but it will give out the same errors after a few sec and turn
> the file system read only.
>
> If I pull the affected drive and mount degraded I get the same errors
> from another drive.
>
> Trying to work out if I'm shafted or if there are steps I can take to re=
pair.
>
> Critical data is backed up off site but I also have a tonne of
> non-critical data that will take me weeks to re-establish so nuking
> not my preferred option.
>
> I've managed to ssh in and here are some lines from dmesg:
>
> [   14.997524] BTRFS info (device sda): using free space tree
> [   22.987814] BTRFS info (device sda): checking UUID tree
> [  195.130484] BTRFS error (device sda): read time tree block
> corruption detected on logical 333654787489792 mirror 2
> [  195.149862] BTRFS error (device sda): read time tree block
> corruption detected on logical 333654787489792 mirror 1
> [  195.159188] BTRFS error (device sda): read time tree block
> corruption detected on logical 333654787489792 mirror 3
>
> [  195.128789] BTRFS critical (device sda): corrupt leaf:
> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
> invalid data ref objectid value 2543
> [  195.148076] BTRFS critical (device sda): corrupt leaf:
> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
> invalid data ref objectid value 2543
> [  195.157375] BTRFS critical (device sda): corrupt leaf:
> block=3D333654787489792 slot=3D110 extent bytenr=3D333413935558656 len=
=3D65536
> invalid data ref objectid value 2543

`btrfs ins dump-tree -b 333413935558656 /dev/sda` output please.

Thanks,
Qu
>
> advice needed please
>

