Return-Path: <linux-btrfs+bounces-10603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D49F76C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DAF7A3277
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB8216611;
	Thu, 19 Dec 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S07lOvpC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503132163BA
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595674; cv=none; b=ktsQHH++5ZQRmgfDPGN0t2rZLT6uAXbUdwZojZwf/VytyhyItrbSM4fkoHmbRrL73LrVr6vCnVyAzenBtHPtwSzZFmS/kopWzn11QDdhRVF5/PTgo/vqmyGkqh4tB21kQw85uDRQbpJy3D2Z70bNfE04A1NkAnQt8YeI0EDTbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595674; c=relaxed/simple;
	bh=UGCHmsgUhVNaJm/IXykdjq53vzQ1p/RJzueOjXeqg2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qikoynwTSsUaqtVxayhbkJW2qz0/+aGDN5VzKNYkhAmbPHBXlsSZ+b8NlUAARj2YH1czaM/zwK8moEcmIVE7XgoR/AI6zhO1JU7+pTxVZt2coO4zTkimVXyKeSHF3mbw6WxWgC8ox4/GAQVaTOjja6rMx2sqhbPfAxWjbkVBUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S07lOvpC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734595668; x=1735200468; i=quwenruo.btrfs@gmx.com;
	bh=UGCHmsgUhVNaJm/IXykdjq53vzQ1p/RJzueOjXeqg2Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S07lOvpCcHtzGzA393qB0vcCtSpCdONS9kKCTxus4w9xUJKb9kf/7rtkdE/o1t8H
	 tM+yBS0/lQX4TqZXxgwnO8du/ISCXFKfpLRCxFlnQB/MCZZVflxWomSwOuFlx+uyO
	 NG6MckU+LwDFvDi3LXr3UufCCOFOYdDmo8H/0czzyNSH0eTodXAN2CBen917+hqIb
	 r6zWdzHZJOdgaBsUEWpWui3gNyOBippn/0pfrOmHLQgCB2f5stoPCFkk+TGFV+UTv
	 6HsyUbEcipwiDYYrmK6dpBcbRjkKUB7rBy6bWrLc1mr9CtbkWUHz0PeMkzL880EHX
	 hJSr6K5H/MlY/xiHkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1twyMH0UCX-00aV60; Thu, 19
 Dec 2024 09:07:48 +0100
Message-ID: <77fd84f1-9012-482e-8f72-5d7de752d5c1@gmx.com>
Date: Thu, 19 Dec 2024 18:37:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check reports backpointer mismatch / owner ref check failed
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYTmpGK3w_07RinTWXzgsnkLr5TA4me40mi-evYqgkBQZg@mail.gmail.com>
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
In-Reply-To: <CAFvQSYTmpGK3w_07RinTWXzgsnkLr5TA4me40mi-evYqgkBQZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8lOX8llUxLChDIffr1fs9/7VKyE9mRWtRuB/wROgdvpIOBajOj/
 /x9GJjJbrhuHV9RSvE9AXdEUV6NP15N1AKnGYl5BQl49VbOhHXvhcpPumJOYGpkLbVkFKrx
 pKqXNVml/SxVohCxKWtIWCbVADT60nvBqKDws9jQ5MLo8eYt/JxPUoj8SVD0xSzXf6Qv2Jt
 WWAB2Ic1YQy6ycGnaS9jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0dyIlmW1H0U=;imjXakh3b+qI/EbclSJM1JxL+Tk
 e3YFKCk5x5tZY/rlSEN7UGL2o8KT3cFTH1KYrJDTw+L0a1zvMEFaAy6+CK8pQY1dfagmP2sCK
 e0a3bP3HqbG7U+iYt+ILddiauh+7c4R+kwMbXfQHW7hBvwl9TnY73ZyQxdU+C0fmhQAHr53SL
 o8W22vbVVznwhtmfPtmCOzQNokd4qByV0DdLREaz1QgY2BoHFBYoB38EMOMrUKvzHf3BLzZa/
 uLLUM86r6SYt2aburAAUnopKot2ur96LBHW+juudeGVA8ZiUEocK63uECaNOSoNklxKZwCu0f
 tGANKI8j+jg5i/daqs5F2Sz1QKU+VWopoQ9zBQm+AbR2lybl65anPJ37FIv8SKHW+BIrXuWn5
 pnoAJqAi01rIM1Hu2qKu8qQF8EQpevXDZPJmdC6oHDxEjV5h+R/FCPqZgXXvNZp+IICOpe1qH
 D1U+vwkIzwwbvBS4HCtxBTZFYTHltH542QHhQmZsUVmYPx0sSvpN8DF+Odr67mzlwnCdh/8Pt
 vbVJSyt2wlQ719wsJXvGwZQQxsNMSzj+Or0iTeEjdrx1jw0KZg05iZJbbDV7D3SZTcxd+VAeD
 odchah+oMMbmZHdyApBFs0iGPz1rjQy/WF0RjFyT77aJJzDsqXz/+RqSU43DeFfZ+tZeEjEme
 85Q5VN906oJ+lyL9qehZaFS26qBAKAqtdcHv8O34ZTrlPpE6iEbLqQjh5gI5bO1pQab3Ahcg/
 6xNcjMrHbp0xtn5YFuUzFwG0douQL/SmK0D4NR+RUM7NZ6jTaVeGNWEF2h+m0aUEDd40NP12v
 fS/bJKrPrGnFHhqiUZFNW3F9jYM/LC622XL+PBl4ns4+/6o5wx8CuPweequfzJUTN35WEs2SZ
 aJdXvtRFV95eLJtdzaV1/fStIZIZD0wFIx7Boc3LotqNkbSub2ujjNjcU/2eEC30YKKJgOTUA
 m6b3f3GSyCWASue8rjp650WDd613wkHXF6LaVljeIxngxWysMlQgFesvCe5YYze+LKBh8Psfz
 evjy8Kpxp8hkXku6ibYdm5jqrmOxq2k89NJ6rDF/z/vVovYZG87Jh0uXXXsgfDaLe/YvI7Zwk
 uS5f26JIwpmUBvSPBijKJFSvDO81Qx



=E5=9C=A8 2024/12/19 17:52, Clemens Eisserer =E5=86=99=E9=81=93:
> Hi,
>
> I am using btrfs send/receive to keep two root-filesytems in sync so I
> can simply sync the rootfs of my laptops internal nvme disk to an
> external usb drive and boot from it when traveling, as well as syncing
> back. Thanks again to Andrei Borzenkov for the suggestions and help
> that made this possible:
> https://www.spinics.net/lists/linux-btrfs/msg142484.html
>
> For a year now everything worked fine, I did scrubs from time to time
> and they always reported 0 errors.
> Recently I tried to give btrfs check a try and got many errors of the sa=
me kind.
>
> The first group of errors looks like:
> ref mismatch on [78987264 16384] extent item 1, found 0
> tree extent[78987264, 16384] parent 30588928 has no tree block found
> incorrect global backref count on 78987264 found 1 wanted 0
> backpointer mismatch on [78987264 16384]
> owner ref check failed [78987264 16384]

This already means the extent tree is corrupted.

But the reason is still unknown.
>
> the other "class" like this:
> ref mismatch on [389818982400 8192] extent item 1, found 0
> data extent[389818982400, 8192] bytenr mimsmatch, extent item bytenr
> 389818982400 file item bytenr 0
> data extent[389818982400, 8192] referencer count mismatch (parent
> 657195008) wanted 1 have 0
> backpointer mismatch on [389818982400 8192]
> owner ref check failed [389818982400 8192]

Full output please, along with "btrfs check --mode=3Dlowmem" output.


Nowadays as a usual precautious step, please run memtest (memtester in
user space, or memtest86+ as UEFI payload) just in case, after taking
the lowmem check output.

Extent tree is the hardest tree to verify, and since it involves a lot
of cross-references, tree-checker is not really able to catch all those
problems, especially when hardware memory is faulty.

>
> Should I be worried?

Yes. Although these problems should be able to be fixed by "btrfs check
=2D-repair", it's still recommended to start backing up your important
data on the fs.

Thanks,
Qu

> Those file systems have never given me any
> trouble, I was quite suprised to see all those errors when checking.
> Could this be some bug triggered by all those snapshotting? What kind
> of additional information would be helpful to pinpoint this?
>
> Thanks & best regards, Clemens
>


