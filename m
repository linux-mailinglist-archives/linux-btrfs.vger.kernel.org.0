Return-Path: <linux-btrfs+bounces-17823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97BBDD617
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F33188C941
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F672DA77E;
	Wed, 15 Oct 2025 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FTQxrf0L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F82C0F95;
	Wed, 15 Oct 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516811; cv=none; b=iXZmFHMGJAvjKj9HwNh/bgexAk7HxG/rfMDoEbkLp7BSnvmSTDIBZgJ0f41KC0blCqhbdl5Y7oDdFW0G0c9Zte9HYjhm4WvWqZEt5aZkDMI4Fcn6inNYviD6/XvbVW7sumXsmtbM/QWfJVI1r0HGFGo2Mdse76BeTd+ZcmroZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516811; c=relaxed/simple;
	bh=NZETxdwQ58VCj8GFW5/haF6RbNnKqDoflQ6fYT1ubPU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NU1PjJ1gBiEo/guIH1FhebV53AMl7L3/vmGvkZovkcZDBQ/KQ901MxpFjawnLrBpI+BEJoul7sfu43anJvzgeM3XDSR1fwzr3UVc53j/RnFPZF5z+tV+qjOJwxquZZPDkqHybQlt0DZmyEky1Ul16Y3TFCNOPLh5jSPZGrACPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FTQxrf0L; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760516804; x=1761121604; i=quwenruo.btrfs@gmx.com;
	bh=WvHRn/g59RhQSwpTtKR8Du/mXvPQd/2J1E+7TUiNMXI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FTQxrf0L5ASVLUKdaPtCCBBRK/8l+aWXskWCKP90xKdER1OG61WpuSjcTf6kcipg
	 ft14EGJbNQONsC/54kk4rHroUnjNG4lAiRzSqmab0ur4VJ4EVRsaABHna0eJaDA06
	 Ettf8NVxfCtRn60FqDwgU4sJVPxf7pf/z55hve0tDHKOg43CFivN9reNlRRhmMBu+
	 ikJlTBekfuEehFjzo2eS8TwcXMqqn9VTDCrPGoTyt1HZi+neEuqMGkRUJGAIrLHp+
	 oge5UNiy6I+tJAk1luseGFksblw+wkfb+x+Jyv5IXug1fjmJRyUDa83R5L02CnEni
	 t6l5DFFFS91d8+VhbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2WF-1uPCVP19Mt-00ioDF; Wed, 15
 Oct 2025 10:26:44 +0200
Message-ID: <74bc8d0a-70a6-4f4a-b6a1-ecdf1b2e3f3b@gmx.com>
Date: Wed, 15 Oct 2025 18:56:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix NULL pointer access in
 btrfs_check_leaked_roots()
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Dewei Meng <mengdewei@cqsoftware.com.cn>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com
References: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
 <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
Content-Language: en-US
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
In-Reply-To: <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HQ8Tmpv6Rj5FgRVZ4Isa9UMSuHM4wp2eeJj5cET/7/p2KCOFSIQ
 b59Snj99CYk8SE7RfsEdIBc6ugVtR/xjCYzXFrirPbt+tGmfu2QV1h/GHuKZ8Kd5HCDxW4R
 MJ1z8CNp3sLDouf7P0PDpJHpd8VuSLyzGFv2bcJIgsmIbtbPF1kgVvsT6gAEPunX+oN3GUc
 zYDEn6f/P+95+l3gTl2Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+aiGmPMXS1s=;OgT2EjUQ6jU6PUOYkXqOGbIhDut
 W+XeF/b5PJ7Chdt5OLrc9wGLH1F9hCkAtASiuRmEL7uSp/NaVgmqfEKoa3tbZ15rmqUSG7a+8
 48CNjQF4Qd7CyVujwadbn8N12UqfKaRwKctHXjPMarGeyIzQpbKDRKfU3t/vvDQiRW7ducUEa
 aIMgZa5Rz4GQrf8M+42jX4aS7Whi4hQtS+b8DsvoYaqZfv7SRvBxHDI1ymX4hLa1fZZ5JX0py
 FQ2pRQSUFsTLbqaJbUD7sUSNo/wmx/dRDC+wZ4cyFEhrfDenTPj8+ZFjWdrJEAhimnfWZFgLx
 Mix3DQEilfYD2s4wPVkzLKZ+kBh0viLzP7W888xiiOwyL/mXT4TkCalsofErDUSC/5A5Vit/m
 l1iC9mMTW3TuB6F//QdFxmfCeo04I/3rz0ScpB2YBgmyDCVtMupYhTljHXltvDX+9IHf5thdH
 Rqv83VUskj0gFO4VGt/e40FPLjRDVEzt+Y7pDnnKVbxFTfLyVuS5JVNc2yf3Sdov/Dde82vTp
 1QGkdFFX8k83USoRV5sw19ibOPASRJYogcj8mEMY0uSMWg3okiOCM+tnQsSQS1lSZczh2rgyp
 UjwOC1uL/3aCVQyz/4f95bi1eS+SDAnjGmiT2gVXZDNztM/KM4gigXJ63HN8+P368xAuglYu3
 oxsmRhGdBEMB8NY6d3sYucfnQs/DQFf5XN/o2Ozb0zqtVzkfzhZ8cTb3NqeCQiGN6yREDsPEf
 lIQfNKijKcJvBnrEKKcX3Ov8y+gHwba0Gl9LExx5gOd6ngDkGAk6nab2ByhAcc20WVa1JdiDk
 BJIDXdd60D4fO0shtxy7uSd7rkitmk6xTR9WvjULthCEKMc7H3NeLgD17+8NLYfnOzwI0yaSP
 SCYRqMybYXGmk1qFZb+DJYRGC3QuhzUGint8mwcPqMQcVny+dGyaOhHlJBALi1zHqEj60g060
 IR/eS5W9RywHie3JG/4NfGeMeeyK5NHPgQmeonSoNQU/qtubGcDLjZC34tE9nwNBuscoylu5L
 np9zZDyq1p9/n6v9ZA8rmlmYHu4/ywhGlYLwLCAXlk/krQeJvZFvV/7AyQcO9FzZSmW46miuH
 GsGmCgmQLTwWGcrxASacDkz9PMHRHOh6iwqcBhB6fWZABZP+tn2wMwAIMuJHaU3e7rILyiUng
 W9eVzvrwp83Hb9vNhOEkO5hZrLqJQsqc2Psr+6wRIM+xS8PC8tde3vAtE5Xss02nRiPYKSBLR
 8O56rFOS2xdRt1Eob36CmREObubwUBQ2OppA0Mm9KXbc5u8TgXQgfhFtb2XxdfUMHN0h5Hgzd
 BJeKSLUq9Hsg4jrSxtoDccZD+M5IjmR3YwZvEhXr9kEk5ZrDSYbwFYQ98X+incGL5obFwU3Kp
 4FaGWE9ITBCj90AINVqNsd0dri8o3R1hRowk0yjCPlSfKTQscyqzTB/T6Al0npxSiGxwWrOkM
 5MOWt6ZyAidh2awdplVq4JEdl163E6XXodZBhfbHgboT937KlLinbZP6K9OPFD08kDZpD5Ats
 GQudLvPJHo/JLDHNNeNgIfBSD717R8vjdWD+eFRlG7I0ebcXo0GfF2n5/H1nyNeFPwqr/p8r3
 hf+2koNl9eZ7x9b+jg8ixhH/dq84aAFuiEdZxAoyi/rE1eHjFnDZONDUE27fBCaWXt7tmNwnz
 f1DvSIsON7O3+/q3zEW0YjDoYbTcelf+4I4E256az8LrLsNIauiif5l7MTUpcaiVsNFE+sIS+
 EaOfTwiJ9z2Ck/eQKmb+CRCo9hApMuBHZJaX11dziXhx9O0LQSkM/WLUvfoO78GtbA2VM57NF
 +EZ5DdvbU6Fz2wJ0MKhSen7WmwP1U6r2ooYAk5lf+AyUESbAyQY6a7T8ZJBoBO8tkwnE0PDpz
 P5PvaKWYhj+lxxEhr03SM/iSIRM37Dv2V+wjTpGZtqmOJmHrb0TE3PJo9DOnEk7A7KLxb5eD8
 P9TEe91555WU6PeutKtMgHWgRAK0jW2tO1lcWdQLAoRQtMVs+WuXTI9NpJDNWSwtET/YjXUCC
 iNHUmTm7sM/V8Va2S31z5rk9xxjTxgmQbr7omdABEM6nnm3Le4iV1x4N0Wb0weJWEQlD3mGUS
 +gZrZOBAIfr6TP5vx3BXhRHk2YuAgj0NgjiYggdoAzdP96gfjXsJhZRsh3IWiYF1bLCOgWaKT
 ETJubzkPboiU0ltIHCxrgLO9hAc2a11GuB5sC8UtCID3twSMTdBsXEQXK/2kDVYmmUGQJOeVg
 kGxO1HJG083qCwOHcr3f9pqurMJeUGUJOtYSUHMXB9nwag1bNlfUm2lqgajho5rXILJ3CWNV7
 8Wpiz5YoUeDt9UKQj7iXz4AJDvj5JeUcWN9iIWhO52K9cfQL/uShPmu9lD/6H1zDwH5UZaGzt
 XK7nNdJvb3ZVqduFnNOPfdRJfJHrzNyopnVT+tzAhZNpWkMHCjsIQNjrbREVyScPrhGe3pW3T
 0s1bmEcATHZwGtAWeKpk1lYRQ1y3bHy9c5HJAo/n3dtLumYUpsczwsqpq69e4Iq3iURZ/hWY3
 Cfz/Fj2/dj6ypCJKGsLY+Wpb+tla9QmwZnwEl8pvOqhZJKiKRTLsqPFAMpMJ0lzQPVV+D6DIK
 6+tkcWWbCGHrI3xI5TYMcyJm3ztVHcvHvMpgghp7WjQTgB1ETgHNZkIzEZqmbPt0wmf5pH+Te
 k9o4+DOW/RtsGokLN/3TjeMK6OFT7keSmCH1Ki/iq7o26m4cJx8lhuluU2R8lt23unC1vWh8P
 dBDQ3w7fW7WoVpQ/YuToGC59E917bHOi445NWBsVR/KY+s3Y72FTKbQTFvIqdmnWXA+x1Cd4g
 eQ7j9Yr04OO3hajy33JzRxJ24GfWG80C3ezGBMVeUhQQqPNak2sTTXPto+QZWmeWvp62/TAUW
 lmM3uybkhKSE9tdAMGJns3zJG5L743Hgw0ZaiSAY4ekKGFzJT6I7WV6phGnBDL6YjkmE//9aa
 DnNR8yvZaM/2uddITopaghxH2M3ZJYlqekscrxpVjCEKoYWVKDQ1hayLscNFXn7xSjFpiK/S/
 Tj+/EvGyHzlmfsNNrdwcFNMlcVJSqTJzURNJi8rwIzRfQVJvo/6SHUetti7vKbl0ozHrmVoAy
 zn73kWGH0Vu2Lvl9j/PiPNRJ6JmqjI5bjIDdVWuZaCNs/VHyI1uR4K2dt686iqtiQGFOOnVCa
 TJUNOWReT89XGn/geIxWzDcKK+7s1glL9Esx7kuYx7ADqBcoLfhWYc5HrEZLLJpxnvpNanm5D
 6RkJGi6EbQJHEwoG5FjUbuul5J9n8e7yrCLFdDExC2fRJy3DgZ3Fv9jH8+2NwgjkeTNyHYlyv
 UOrzgSm4XGLnzN75C/Pr0pgxbNINPHWDeCyY5pBCmcdf8pljwW64iyp2KQ8T4RFlA563GOIpD
 N8fgLggBnZgabsg6jN2P4vzgFR9WjxUpbndz4pT3oInFXR8yulthkAasX9lJsWN+Ap49Bu5a6
 cP936GnSg/4+ItV3eBN1RgIpdYWqO1m0vUV4SkJmlwlaYo87hh2AXptBTFfdVJVNiqbSm+NHw
 3XDrm8Sb/Pd/HlzulnN1Vzhbqy0ni++mno8vLaHz8cRENQ/N+eJHwmfO0oQf1Dj13iMe/ka9+
 YJZRDgtv9ksKZJXMo0jnGmbUzaj1YhkbgJ2iDBy/zLvobMmrJGvo/ryKKSsNx6EHHtWIvgyTs
 I/f6aLccMxZ7hWkGJsaokMTKAwjJ1LugJQQ1VXhmw3n2/NJA55xPVOuR7m16uahq+gYDDClfe
 LqsJ5dCBdq7PTzxaVl3Pxq9elH1iPK7yiQixhg+R/37Anv6AbLo0gERS0iGY/veRp2SXfevct
 zoynQpnPJkGcrom82V2ey6U6csTR7VsSt3+i4KQPURIHlG0ExnVo5ERP0FuLmLQZC1zAv1MUV
 c9Plb/2CrstPIdc3JonH8rrGsGJseYpXSFMNmY9mglFvrsgYfkk7xwyOxt2w1+aizUP06ElUi
 Jor4ln6ap225VISji4NA0Q2ZxWNnp2Ogmk9roEzeGXbNzgdsr7sKYsFRguMV/rw13czBGlDp7
 8uoevwejOfOtVlQNIFbNTqs82rk7vi8oFqGvtXl00ETh0sG1zn6q3WdAIgXkMVO3Cn0bOcQxF
 W3h5DxOJKUXHycKsYf7z0FBxofsYlFBPb1MaMwf07Dwq2yKN8tkH8F53KCedFLiQewrVWxd3+
 XUWvReevnAP/UUY6I2BE3DZE+DK92HpZV0AE+x/0fwN8TAsd5VvE3tz/Y/Xii7jQ3KLW7wOV9
 ZPZ+4a8QlmZlgBPPsFrDcMF7+FWXma6JqpS7oLVdwJxIiwr/GaIt73X0LrS2YgmG8w1ixz0QI
 JPo/CziCGRCjD9lc1U+ry61tYo5guzBjBoxC74LVcYtcRm6vRNMiElA2rI6nB+f0GFhUC84sL
 HIgGkbmqWHYmiLkLN4Wo+EsCfDO4qVl7Y2nwvQOc5DKA+Blj9QnSRWq6tj8gPAYExKq+5NX/P
 nhE2O0o0Mk4L+Z+XrmMpKxU0djLD7HOatoJwdweAUrMn3NGPPYlmShcrM4XMm8rI2lKlhyUT1
 wlZ5BIMrqUyYGVwl+zQ+ojTC9ZEiNFc5BRQsrLUj7E5YEXEgPCMQwF+eGkPsQhlRhY9WLlMKa
 k1qhf8V362RlKi3ej2EGvFORpiSUPIb38qUoAftOn6PNT7JkVzyXVcnqs//nV8m8MeRgvzB3g
 9fVBMfLwedqh/0zT9MQ6e0ATGgUpng7UYehjAsvg8kmRT0F9jdsKxgxTrJ+rjm5Ox4Sb7I4sG
 1GFl7bBKwCzjyfnjMXeMD6Tiza8Lsk4t/6YDPPl7ieiSnNEcKUHWvqCyrDTVgiRJpjhdubueS
 LJ85Hn1KV3WKdZ2vkm9cjfs/NjMXeqGLWdK3SHO1nuRbpFLoFNpSyBGC6MbB65Uh/5I1XfcfM
 GmV5NZCdbq8IE6zYQpFpAUndocDIVlQ2eYMCIadWysaYkoorGlQ3K2UCwgFM/9HA8wIdLcAjn
 4YInzhkd/3VOPIWSAK62KgX9Cou9n+eJvwUd0JwC26vShllcT+mbAcnxIpNhGb6M9gFurfcAJ
 bWzSg==



=E5=9C=A8 2025/10/15 18:54, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/10/15 17:54, Dewei Meng =E5=86=99=E9=81=93:
>> If fs_info->super_copy or fs_info->super_for_commit is NULL in
>> btrfs_get_tree_subvol(),
>=20
> Please reorganize this sentence. It would be way more easier to read by=
=20
> just saying something like "If memory allocation failed for fs_info-=20
>  >super_copy or fs_info->super_for_commit in btrfs_get_tree_subvol()".
>=20
>> the btrfs_check_leaked_roots() will get the
>> btrfs_root list entry using the fs_info->allocated_roots->next
>> which is NULL.
>>
>> syzkaller reported the following information:
>> =C2=A0=C2=A0 ------------[ cut here ]------------
>> =C2=A0=C2=A0 BUG: unable to handle page fault for address: ffffffffffff=
fbb0
>> =C2=A0=C2=A0 #PF: supervisor read access in kernel mode
>> =C2=A0=C2=A0 #PF: error_code(0x0000) - not-present page
>> =C2=A0=C2=A0 PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>> =C2=A0=C2=A0 Oops: Oops: 0000 [#1] SMP KASAN PTI
>> =C2=A0=C2=A0 CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 =
#4=20
>> PREEMPT(lazy)
>> =C2=A0=C2=A0 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (..=
.)
>> =C2=A0=C2=A0 RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:2=
3 [inline]
>> =C2=A0=C2=A0 RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch=
-=20
>> fallback.h:457 [inline]
>> =C2=A0=C2=A0 RIP: 0010:atomic_read include/linux/atomic/atomic-instrume=
nted.h:33=20
>> [inline]
>> =C2=A0=C2=A0 RIP: 0010:refcount_read include/linux/refcount.h:170 [inli=
ne]
>> =C2=A0=C2=A0 RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/di=
sk-io.c:1230
>> =C2=A0=C2=A0 [...]
>> =C2=A0=C2=A0 Call Trace:
>> =C2=A0=C2=A0=C2=A0 <TASK>
>> =C2=A0=C2=A0=C2=A0 btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:12=
80
>> =C2=A0=C2=A0=C2=A0 btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2=
029
>> =C2=A0=C2=A0=C2=A0 btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>> =C2=A0=C2=A0=C2=A0 vfs_get_tree+0x98/0x320 fs/super.c:1759
>> =C2=A0=C2=A0=C2=A0 do_new_mount+0x357/0x660 fs/namespace.c:3899
>> =C2=A0=C2=A0=C2=A0 path_mount+0x716/0x19c0 fs/namespace.c:4226
>> =C2=A0=C2=A0=C2=A0 do_mount fs/namespace.c:4239 [inline]
>> =C2=A0=C2=A0=C2=A0 __do_sys_mount fs/namespace.c:4450 [inline]
>> =C2=A0=C2=A0=C2=A0 __se_sys_mount fs/namespace.c:4427 [inline]
>> =C2=A0=C2=A0=C2=A0 __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>> =C2=A0=C2=A0=C2=A0 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inlin=
e]
>> =C2=A0=C2=A0=C2=A0 do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c=
:94
>> =C2=A0=C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> =C2=A0=C2=A0 RIP: 0033:0x7f032eaffa8d
>> =C2=A0=C2=A0 [...]
>>
>> This should check if the fs_info->allocated_roots->next is NULL before
>> accessing it.
>>
>> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
>> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
>> ---
>> =C2=A0 fs/btrfs/disk-io.c | 3 +++
>> =C2=A0 1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 0aa7e5d1b05f..76db7f98187a 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct=20
>> btrfs_fs_info *fs_info)
>> =C2=A0 #ifdef CONFIG_BTRFS_DEBUG
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root;
>> +=C2=A0=C2=A0=C2=A0 if (!fs_info->allocated_roots.next)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>=20
> The check looks too adhoc to me.
>=20
> It would be much easier to just call kvfree()

Of course with kfree() on the super_copy/super_for_commit before=20
kvfree() on the fs_info.

> in the error handling of=20
> super_copy/super_for_commit allocation, we do not and should not call=20
> btrfs_free_fs_info() before calling btrfs_init_fs_info().
>=20
> Thanks,
> Qu
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!list_empty(&fs_info->allocated_r=
oots)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[BTRFS_R=
OOT_NAME_BUF_LEN];
>=20
>=20


