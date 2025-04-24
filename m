Return-Path: <linux-btrfs+bounces-13403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 668EEA9B975
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 22:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A7446696D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D462820C4;
	Thu, 24 Apr 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cSG1yOkU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697A26A0FF;
	Thu, 24 Apr 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528270; cv=none; b=XqD48yY6eFlmTKLULlUSO0gjTVLps6XVCquQuJ8wa5e9Tg7P0QHUXZGN+MoB7vTRu1+SddCUMy5Uf/bwoC8seaIYhpgf3ddv5GSG0D31NuODxQQp7lbvYtkB8TI7xeisz2CWfGJmogItrjxvLDUusTj1cTv+3e9+hG6fp+dW2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528270; c=relaxed/simple;
	bh=8bMOXeeXEuQOo5moD5D0HbnjQnWxauRQeyE+0vl0CcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2FmM5zOvUNel6FQX8NHJPkmejVp7ZvsxU7tYj0ZX5hiipPFxxVoE9Zm+kfvih2231h2Ac4/KOD14YNTLCZeCAzlFh7myeltQVpYTo41bYYLTNFPJU79TiAuk2wohnH9OJxRrioLspoNnXmKt+aU3RBL8MzWGbSMCp6CD38po30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cSG1yOkU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745528259; x=1746133059; i=quwenruo.btrfs@gmx.com;
	bh=2vQYHierLiPy2KJcrXFPzN+0bisf1OYS+kvXNzLp1pA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cSG1yOkUYFfPQWlUY7eQuZOjN8s9hGLcC00RiFfOALDz0Rn4fq67sljIZP4uTXWh
	 qn7U/TKgEKxpEL/lWXpKigcaLdCx8ESLwZ/Dvqt8CeHhgvR8YpRpQ2fBcBOb7Mjr9
	 29/JYPBESp2nrI4DXdBRkRQSN5Nmr92T8GQbDOIhO1tMnaOxC/GuL9fcK2G2ywPOD
	 s0UCM7Zu2+4UsNUPd7wybOPRyag1Yd9Zm30AAh8+KxMs02mWYjGwSLA3Da3Mu+J4u
	 4m/PCZ0HoRPf7glIDJT5KTzw11tPBAY2DaSvqDJ4hBGbXt0khqBPZxzkRNAZkHAz6
	 3BTc6wgBmXczdp5xkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMyf-1uUPqd2utl-00QMoC; Thu, 24
 Apr 2025 22:57:39 +0200
Message-ID: <d874c64c-34fc-4d3a-abf9-19625bddd213@gmx.com>
Date: Fri, 25 Apr 2025 06:27:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Daniel Vacek <neelx@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org,
 Boris Burkov <boris@bur.io>
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1745242535.git.josef@toxicpanda.com>
 <CAPjX3FeSOJVo=4hyPaHp3svLorWXp2SGhMEB17+Qm3OLmireSw@mail.gmail.com>
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
In-Reply-To: <CAPjX3FeSOJVo=4hyPaHp3svLorWXp2SGhMEB17+Qm3OLmireSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4dQg274C6LZR5EMbadpDbV62UzPlfgsUy07fof+G3Hf3sU/Y/y
 3g1lRPPyX6YGU6CzlLp9lalYSptFd/haHVqTrzX8FCRuff6kbFAlBKLN6s2LtLfNCiqiQGz
 sZR/iofXBPnqWu6PekGriV1T+8p4RAVPea1O7k+dflLmHnBlepZ5AB4OW/Y2/j6tqnLp2Tc
 TUB147VAFNtbaNP3S4TOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WLuKyEiQz58=;8kkG92mt1X+Jo/EBWV6iJabRkvm
 Nbjp0zed7mGHfZk79k7HXXUGRnpjr6zy7+JPBpftij42Kz8m1usLKckzEd//tfaWIA7rTwyyO
 TGFqlJY4E8hbPxknCbhiKAUC9DvIrsTt0egintvuKQ4f0ftMe0sUugTxs1+sLtAaC5wqF1GcR
 O20rj5WsX8fA8WenNP7lHf4H/8ix/J2ecz71E5bUAzk0uv+5H6hGf27TTYKZ74Dtrh4Dd8zd6
 dBNWvqGUEfHH+XO7qxU0s8JWky0lGsfpquYvtdh/hwLgz5zB8fKVN3HR0GRX3iVR3F4jaSXtL
 EESXG7r+bc+UG0GtX4gxxlDSeF+H5DwtuUtJID7vugViVzlKROEqW7PPQnW8huKdj3iQPlmT/
 FoKLwSKxufUi1HohjI4s1kLhG47LeU5NqqparGZlKQI8KZbj57vat+wRKdM81c8YM/YNKBvlf
 rHqRWseoTdu8OCpURPNXMBFswYR+1QD7mUc4R9RAjjdk2M50Cx9maKPnm4twTUrUs66r2MxSN
 /uxaS/NQTWiLdJt+sFLOb32qwSyD1RR/ydKrHfItuImuSNewn6JQyK9M9f6XVZRT+l7hTGw3e
 5QYtiCKEwxPYWfj0SpTnot4H7rtm93YOSZT9gCwktnP1aYOxvnMxr2VL/e+W+zTtYHIl5cGPd
 JbwvIjdXXthhOt5llPjBmeJTlFj2l3nxD1x4RDXPwdMEncVUGf2gYCX356dZcnLlyCo48DdHB
 fvy4lxMRx24l+XILbRFpiskw2x14bKB3XXoAJRp0ZmkFmIrDNgnyucigxP5L91AyaP4yZ+oQr
 rmrTiyo78oyRegPSLZYjG+TxGgr1xmsuuirg/rNdh4HfCJeWtgQg1Dz8RiEEmu6dI5WoPqKXX
 ofz7F5y+YlXdvr+GZ80HI1CpaeHVX2U/vp7ys917cBRyf+/nt3cW3t8Np0xGoeLi9NGPIpsvF
 pSvTBRerK+ZV6jyDH+fAN+cCHJp6fBOHCzb4L/9p42NcEPKv8lX9Y1/H82huFEWahnL2nKr17
 BYZvrumHO5MBYbQMyjerlZMGYxn08Oe2mybmdtG4VgvxCJd4LWWioCEFsK2Pyqcuex+CIATiL
 NKFEywf4F2dZ7b6JezcZfXJDdHpf+ckziK7B9ACMAy7gwuZkIkHFL/mJUOTgpW2dtOpT32Abr
 QUlKMyds2NZ3mPoVJtMZSyZ4ts46RAipu1G9gESrNDgiQZpeIsFwP1ITdyeBdTWz5eH9L0cPt
 vtMkMXaZo5I40Z3d5EH2DmiplrF/lOp6zErRkEWZB53mzAZAddxRUokapgNn289T7CxNwI9UJ
 +/RE+g/5/F8emn1LKtiFbcluXNTbjAn+73biMtf4I+XmD9V/xnCk4jzyctwDk/hMseJB+XuLA
 4VezAVhqXJ13d5l1Uxw4Ld5mun8PIi/OYNCGS99l/hA883dHHMc7Zp7XVI6G7rJnDrAYCJLT5
 AmW100SHLMxDNxtJWd8rOLMZ7hJTF4H1WlrodGdlRfS5kFscGVosQPfus7kJqPrXpWTfbweym
 K6aQXfJxIzOqBhA3HTXnGhwVuGt1ZnWej1nTGpsMuC4EvEulKrR02NBM6Bd8d+kbiyTCNeOc8
 NSZClyPhIjMYZD3n3T5x0/RVEhhydVU1GQoJYqjlvU3PJSFqeX9xqjzLLo3612gKKYT6XxDVX
 HErxIVgu3fGgXJ0rMW1UGGWt/1MS2xbZL/dJODDIV2O+4rFO8Cct1tTwJmTw0dSYSYgqhesYe
 F4v6pTGrZyvz0OiALYaFxyxONg31iHiLibS267pUs9FlZfh8BNgPqkkVZjPqgEBFe6ujdjqpM
 51nN//TOFYCdCHFRJeIOAR5TuWRQzEMbIIYeiqZZ6wpwEN9uJR+wd84/JHPxfhF60JQBW5mhj
 IGhmk9fcA7vFIE4dhOlXNUw7NfxvJH4uhszObDr0iSDApzIBb4cBGBSOo524oGqXfvJArk7r2
 /HpDoqery9umoPllRm7aYITGNf2bKAH2/ypt3k9+rKseh9cCDHD+2RPNKND2WvGGIFkKjsSOc
 Onvyt6VLbbcJ07JwPmbA/Fax9xOBf4mennoB3hIMzVb7Hraci0SNoti7otY7W8eMl+kA8htIC
 4W7UxLPGHKfhBsjhb9BFOUYfiHq6lcvO+IskxmDGhiyaMHnIWApcuUogSnGU+5dVpwrM0HHej
 TU0QduQk/dQ//EqS/C77MAGlaeXtnPVLCaJPBBO10ZNYoqIIj/fzV0z1jGdGUN3k+W2u68R8C
 4M59o9b0cpaNg3JoJSz1hAi2YhxmaJ2w/8HGxUsmsAmckv3kqd/yp3hwvVwJz+D2cI8RonJGF
 9jmE1zOPoiQ23Bt8WoPOEz2JGPrxcEQ/GMnn5gOG+mpUEnFyYJPhmPMe9jwb/FzQVzilC/+wB
 NQ5vz4BMgjy9HeT7aK9u+kQ24s7rjKtp1MgPwfZr9K1/LQdepygUIK8gozF5JtyAr4Ng22iMb
 qIDCsl8B3i9KNxyic7Ujm8ePICPJHjPIQI8MPEXrLIaJTHbJvByB36IYTd5Of4xMf3YCEXTrF
 HftrKVZj5dWFSTQEgU1szP7cN5WRxqYSUrTmau4qX/fY0ruTA/sGuj6j4I4gPpiPO2vxGkXNy
 tcAEINADrcQIusTJokh557xMAueyf/vb+MgSr62xViNVzgzoUoZkIetIeIImn9sSKsDBMNXdc
 PZzPNORTZcjcG3ln+sUVujh6DD94Gxr+qZ13nj+ACMeRqk/sh7Rw70Wh4gkbPvjjPIRIHNJe9
 +lTicyiO//feJdQbXYwcRaGyo6k+XaAkl0MKCWieghc4uW1jrbPTimneCG7pWs4Dm7fCiV/EK
 s8STTgQQvMTa2YQVbGBPJgqZpq9dHgfcg+XSkVdP7lXQ2zY4JpWDCW4Te302JclOjvLd5f7Wu
 m9YDa42uijTCyjID6x5K/4qrr2tWd6HP0iTakTBAacMnHrzxbHkRZj3Iax2i6Qu++/1CgGDP2
 qewGXJf7KjliSJtpQldTSruqfYGjNqBCxDXd2eHqD0W41FbZvGbseY8G6oV0lS3QP/cGpa13Y
 w==



=E5=9C=A8 2025/4/24 20:10, Daniel Vacek =E5=86=99=E9=81=93:
> On Mon, 21 Apr 2025 at 15:38, Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> When running machines with 64k page size and a 16k nodesize we started
>> seeing tree log corruption in production.  This turned out to be becaus=
e
>> we were not writing out dirty blocks sometimes, so this in fact affects
>> all metadata writes.
>>
>> When writing out a subpage EB we scan the subpage bitmap for a dirty
>> range.  If the range isn't dirty we do
>>
>> bit_start++;
>>
>> to move onto the next bit.  The problem is the bitmap is based on the
>> number of sectors that an EB has.  So in this case, we have a 64k
>> pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is =
4
>> bits for every node.  With a 64k page size we end up with 4 nodes per
>> page.
>>
>> To make this easier this is how everything looks
>>
>> [0         16k       32k       48k     ] logical address
>> [0         4         8         12      ] radix tree offset
>> [               64k page               ] folio
>> [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
>> [ | | | |  | | | |   | | | |   | | | | ] bitmap
>>
>> Now we use all of our addressing based on fs_info->sectorsize_bits, so
>> as you can see the above our 16k eb->start turns into radix entry 4.
>=20
> Btw, unrelated to this patch - but this way we're using at best only
> 25% of the tree slots. Or in other words we're wasting 75% of the
> memory here. We should rather use eb->start / fs_info->nodesize for
> the tree index.

That requires all tree blocks to be nodesize aligned.

We're already working towards that direction, but we need to be cautious=
=20
to reject those non-nodesize aligned tree blocks, as end users won't be=20
happy that their fsese no longer mount after a kernel update.

So as usual, kernel warning message first, btrfs check reports as error,=
=20
then experimental rejection, and finally push to end users.

>=20
> And by the other way - why do we need a copy of nodesize in eb->len?
> We can always eb->fs_info->nodesize if needed.

Because there are pseudo "extent buffers" in the past, like accessing=20
super blocks using extent buffer helpers.

In that case we need a length other than node size but super block size.

But that is no longer the case, feel free to clean it up.

Thanks,
Qu

>=20
>> When we find a dirty range for our eb, we correctly do bit_start +=3D
>> sectors_per_node, because if we start at bit 0, the next bit for the
>> next eb is 4, to correspond to eb->start 16k.
>>
>> However if our range is clean, we will do bit_start++, which will now
>> put us offset from our radix tree entries.
>>
>> In our case, assume that the first time we check the bitmap the block i=
s
>> not dirty, we increment bit_start so now it =3D=3D 1, and then we loop
>> around and check again.  This time it is dirty, and we go to find that
>> start using the following equation
>>
>> start =3D folio_start + bit_start * fs_info->sectorsize;
>>
>> so in the case above, eb->start 0 is now dirty, and we calculate start
>> as
>>
>> 0 + 1 * fs_info->sectorsize =3D 4096
>> 4096 >> 12 =3D 1
>>
>> Now we're looking up the radix tree for 1, and we won't find an eb.
>> What's worse is now we're using bit_start =3D=3D 1, so we do bit_start =
+=3D
>> sectors_per_node, which is now 5.  If that eb is dirty we will run into
>> the same thing, we will look at an offset that is not populated in the
>> radix tree, and now we're skipping the writeout of dirty extent buffers=
.
>>
>> The best fix for this is to not use sectorsize_bits to address nodes,
>> but that's a larger change.  Since this is a fs corruption problem fix
>> it simply by always using sectors_per_node to increment the start bit.
>>
>> cc: stable@vger.kernel.org
>> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a =
subpage metadata page")
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> - Further testing indicated that the page tagging theoretical race isn'=
t getting
>>    hit in practice, so we're going to limit the "hotfix" to this specif=
ic patch,
>>    and then send subsequent patches to address the other issues we're h=
itting. My
>>    simplify metadata writebback patches are the more wholistic fix.
>>
>>   fs/btrfs/extent_io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 5f08615b334f..6cfd286b8bbc 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio,=
 struct writeback_control *wbc)
>>                                subpage->bitmaps)) {
>>                          spin_unlock_irqrestore(&subpage->lock, flags);
>>                          spin_unlock(&folio->mapping->i_private_lock);
>> -                       bit_start++;
>> +                       bit_start +=3D sectors_per_node;
>>                          continue;
>>                  }
>>
>> --
>> 2.48.1
>>
>>
>=20


