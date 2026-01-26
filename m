Return-Path: <linux-btrfs+bounces-21085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIIoJhXVd2mFlwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21085-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 21:56:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA98D613
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 21:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498BB308E85C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39B2D876B;
	Mon, 26 Jan 2026 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AYXNAgxk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68552D839D
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460724; cv=none; b=geAE4ws6gL8azPCTHC0aB2cgnntg0pVZGCuMz4eo/aQeTs70lpEratflFcQQKW/vj54Dy1frgn+Isq/KWnMVlP/G732bwEibrcNuqwU1LsreO4dZUpzKmeDSRD3tPpsfNhwff9Zfzsh4/6MHOBfdqNI2fsX8uof7q2rBVU3Tzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460724; c=relaxed/simple;
	bh=ZECMswkKdDfHVIOxtsdCu2Lbe4oZcEBOrb6kqqy28hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Doycw121dn6MVXp2N5zEMUbXQb03QdQjV/8q/xzCjehulGHA2CnzyKKvRPXH/zY9zVL7w1sGKCTKgljMhnTh52S3NfrfkFBcc59ra0DndHfxCvJHKUFsxTm93SSp3dZ5Q8axDbjk4jAXbLvcU3/M/BhtTgOHsB/2lisIi2O6gLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AYXNAgxk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769460716; x=1770065516; i=quwenruo.btrfs@gmx.com;
	bh=rwnRGLhVgLJLKvVGnfGNyil8HpWDG0TnZvavN5c06qs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AYXNAgxkev+jy+C27WjbR7WLyiDPkTNU7IPHQB5uQ1xKmt7DZF6G5/jAAQqe7Zci
	 kgziNsQkwCS9HtA+GLbbu/rCQBYAM5Mb9QpE4gBDRHBKIWFkRAPLSwJTVlAgmn4GN
	 y5tnisPUeGOsDcBppFLY7vSy+chufgd9Gv1ruoAvCiXNSIQro/XtPy4+O+AGkODew
	 MCIL2+0CTvxj4tZ8mphSOUMQc5bpOE8nSSYt6gMe/kw2F+rsHrkVHMCZf1GlUH6Ga
	 sf0IHHPauB8cbuGJGturNhVCOL95HGzd3kakzeAGJo5vF2Jc79W/4CcMVWnUd/DZ1
	 G6MYIhD0ZfF9R2pgMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1vDhal12Qh-00SMYa; Mon, 26
 Jan 2026 21:51:56 +0100
Message-ID: <7abb458c-c630-419d-8ae5-8bb2af229e95@gmx.com>
Date: Tue, 27 Jan 2026 07:21:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] btrfs: introduce btrfs_compress_bio() helper
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1769397502.git.wqu@suse.com>
 <1e5609990460c9f56671336343b7a48a9da12f16.1769397502.git.wqu@suse.com>
 <20260126193613.GC1066493@zen.localdomain>
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
In-Reply-To: <20260126193613.GC1066493@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U9gICwob7YXz4lhVjRQtYLl9tMr2pzookNltIimRxhXL5DgvwSb
 /8+Bc42yA53xotbQUgKdN4J5NbsV2XGw9Hh6xeQSiMkKRQ2QSXhucM4YvKP0GvaP0sD7rxo
 TrLi1GfILRc+S933p+75/yyZpXkjhZtYZf+eq9AhiCzhgFbA6C9hkcRthzztq9FHNmo4juD
 Wc7j+DQP94PA2zN3mArPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qo6VqAvxytQ=;C3d3Ys32mOM2NV5bQnRcDXZDSuV
 z7u7whjZpYFKlF/AKjQx5M0XzCrdAWNbQIrsShPZz8xKYv5EXTRJffFpY+Z42yoKuDMNXe078
 SkZwUhkuBvy6KfcxNYNJhr2t/EDufjMzdjvru6Em7EgJ096QBQOfMtWhuk0/6jD/GLBcXwzmw
 4sUJ5ZIxt73HoxFlOtpaAvCbKKSywK1H9QLxBtfy6ni0AhPZPIdwGm60Zunu1vHrVGpVAUEvY
 p2L8zue45jTCPvL+OUrsUen3z3Ucab/7RoQp2RmF2zdrSjgTMSmKleIZPA/xL/m0OfEiFJnAr
 1BobKpRCplzxxqTcor3bxqjpqU0iykOLl4Fw1dyIJcEK5mMKedN69J4icMc9O+U+3yqxck5XA
 vNQ/UWhiqimfFHqFp/4ibEChruXHxUqDslJqv5N1ws/I5CFcoX9iyYmCpbsJ5sQgxN6PrxPRF
 XYxAvWqqmAGSL0JZ+5cdFjNCpTTUo5zs6Fl64bj6loikqeP8T4yGvOW9pcp72oPhH3lLxIeRH
 cCL36vN28pfFT2PTLVetoAiNq8Y0THeF0LvrY9dRnWVDTJz3QPy8MhgmblmFmACJIacSDi9cn
 7f2Pxn0lU8+RymgQAsmVSWWK8rFsCXn5ZI3HloT9w5EcqFGp9sQYDACQQrkZPpGyYiXwUtN2H
 RHrZ/szRurYtQ0K16wEazLblBwDsrgeLSrOprppX4URx7+D2dc2IEn+vHfvv/9XOEAFOQXQC6
 QM9xNMj+v9+r4en/GMkd6pQzdSb6pYEKLy1srLP1OWTzvOiqBesIhH6idqJOLfHGzVcSXWQ7o
 m+lV1vzNU+cYsgmggm/nVwR5FKG8XgShAgBP1BKFDt8Uv3Vra5VeUrPL5gB/rqndzwTHsF0oM
 rqQAsbD32ru5K0Q/xrr1OSyi/Tazxl2K1qGV9cnAnj/XoFDKMOh8Wgt60keOPrCbBmyZi8mw9
 h9cTW/5xjBK9yIqYBgvVxRY2Djmmtvh2PfUnbnVUPIPooWl2zeD2n3xdS9OYX20XIX4ARQ172
 SFcfzvURaksrvKaxDgXXFNXlCj+dphag/x6FP7DyigeQBldqHVEtRAuo92cZzgoeLEC7Ne3HX
 erzjxv1mP7OHaTk9lnKgZwy4hY9SeIrce/5kA+/2LfbVoENKbmRoW6euMegB19WnOQg0yK5tV
 ujKk/TOLIE4wGiiiofuIDQsyutqR8RpsiJuyXFQbwYVlCMFNd9jRwrE9LUabKurLe/cJguIeS
 IWgtyM4VeUVWoCAzvQNZole+HatTxpyB6Q7nSAGnI15AUbMc0Yp3W0x5uGJ+xAj/i9nu7oWNO
 ycwgQOm2PbVykMpXxPNuKCk75BMkPDW2ter971k9DrfANaGultI++6Hbbie+Nu6gV3vOX93Ug
 54Mpwim/oD7z8Qvi5f7tjJkgABc0H3hIsyt2/9sJEVE7JBOLae55o2UelPRwTTRgpl89Znp4I
 ZVQPoADjB2IkXTk7xR+ZxS4F9olQJkk+9yCuXcQ+L5C9kw+ci5nOHq1I1cavRWkjpzFQKyZHS
 rqrZHHD+ABXiIhhqCDULhlEc8TfEsiDxooLvgHgIGsWgI3fDPQV2yEpeJ/KJgjN9/u5rY9Vmr
 beJbcHTfj6L/DQSWHsLa6CKGArkgTT8VeVMQJoRJq883YKqg1S63g6ZvR/oEelBC21kCgNtf1
 mOzK0IxbxNDqW3sc8Q5ecBuqDWyp0sZCQQ5O/mWwrw/uSKBd7zG+EFAbJ8P7dXbUv4FVJWoSI
 r4XLYLuU349gGm/FafGNcMU0Zq9KWeqrqe9F2GOBPh8bs7LRunCgaRyWGl5fNEhtF6CtpFA6+
 HlEvZcHY71hw2nLXtahvWmttOb8UdNKtr1ndLD8Lfgl74pnLT0GSrFAXbaE7OBcrWuo6bOKTP
 i3hKowvKHFUS3FYa2BAWi0eK0alHaPD22DfBWgbc/XPbmHb2B9z4XaxbTbE8kKv+kkKvS0PxO
 gZpXA0maTTPCeBNwZkF+/sieJi/g+M1FfaNbEVbHoPcpzKQ8Ttzg/qeLGKrKNykKfQvLTZxe+
 heiwDvEWKNw/lb8pJngchYrhHcalnhcjUQiTAMwaUGWsn82021/hIlqW23LLPI8yLV3yM0ryu
 qJ5YDHS0E0CeBcvQDuvJ6e4I3Bw6Gi9r8OUNhqB9L3UI1I0n10VnLeRHotGBWbMuV2gC4Ad44
 Y9iRBM94jQkCiEq1YRvGCR/s9Bio4ZuKsMPcdrbtpn/h9etC+fJGB6WvNqxe4owL0z1e/Q6B1
 urqnXKucw/zX6ShAcInr6IOBeUbL6EWOepAMoD7XljCcUcq9tAWGAPf0l1Y3c2neZfK8brriH
 a0ynlYEy2k7+OpA1t20d1tt4jSf1+MR275Y4kxysLdDFgVXO8RCij5v8KKgoGsFd+kxDjcAed
 JNYFEl0cVGVGTE2m/xe7X7cuJj50/crZ/fY2OG3kMyVeM2uOEcprL/sgA76D278gAb+BaWKDM
 yO2Wq7hqaB/YF0LZgtf4hD6uhlfEeU2gg+Kqi1JWuY2N/BB7zGVGY2J2jswjYW4lEznmjgwvM
 lSuDDoGA8uHbsEy8ulXamhPNLBq/sgj3aTdGb3yGLb/q+7039ziRI5SWkdqBbY7fmwRnqW7NX
 9v17M1uw7X+rC88y1o6RTr81p7MnVgHoXyNDVGugPaczvyuO5qEC5b0tj1L0hgnja7/fxp4GG
 STeDoFK9mfjcrTfZ7smwvWu4V7RlI50CSUIbcNEq6E7N1M8bNRnPnhiJVXlJBGwwmxkDqNM0K
 ESMrPfoWVrJsx/TW9t7GK+x/fxvbsypCRa0CEleHuHx7SmWI/hxyeB0PQRQ93suJnxAsjnBsC
 Jglbxsn85YvmuK1+OGsBun68G/IXqRddi/gjOAPj+brkvUQ8FSXfAIKLXywE8CvMBRvpyPlLc
 1UW3cuvYHasfojyP3WgeQBR5TInwjl5d9+7M1+bOfZq2/rLjnBicPRpKZG0HeKsBk8AZGGzFq
 S6/TKZBsmpmRRIyQNHpstxWvmuHeuhw4HVDbmL3ZRowrfjhL6FX01HsysgqA64BEjhZodKUPv
 v6XGgGUIDx/IrP2pUwFMiEUKvT+PmZ/JVtBDinh051+djecUahvRIjOCkBdO5nU9KMhVwwlhb
 BWjOS8MYtRAUQi14gib2ljgpOMWVvn9tv7gEuNeG/C2GW5Cww+SNQ6gxd0KzqtcA7my62tSSS
 xAzVaAUbEPbBYuKaLM6qoafDNs1CUf9+UBLmUDgRQv6n+RTFVP1IudPx6he7bigHlDSfGVl/b
 8/MnKtxAYAfD/kEmwHvKniiJMdgtcl68fQz2M6bt7TduYFo/BqMpyTqVvN/VB74J55P2TeU5P
 BawVlP31+12EJgmXAYW9K3w/oeBJV/cEi+DnB0auaCpCYrPxOCPBmlGVpuEvcbwBBzA6b0Me/
 BHKIX1MoThd4Oykh+Ghd7uzW75u3+Gg8gt5Q8om+m5S1pjtLurzsBsj/FWNe7omLdX+HAN0ec
 3VJFQpxHI5gcSCBMnBn65gbXpszYQ+/JnEG659XybbGi3NxthSZXGPjX5V71Mu2JjfYat/eUg
 PfnwNuzy3pCQJGmvb/HTtHPgWtIc1FKM6jswSV7K9wVH7kUNNN28YplLvSePVgKnTccUwNlrZ
 6gKy1tSSwVuB5UgaGB6cGyXoRgbqzhZAVQ1xMaayuW8IPLFsUYdpLFiuZ6L4jbdrKwkzVqzk+
 OFjum4VcbfcvV0n9rLcrk98scEN8TWQgCZe8JyV7dG52AlN0Ll275krlxTEBOeYvvPQQujxZJ
 4INChWfrT6VUyEjy3j9a8rO8DJT6ZlVBF4ahcoYVluLyHiqHprJq8Q3TEjGGQMK9o1C6Rh/k7
 yy6xU8oEOQpfV7mhxVgM2ngRpMdUU7RBwaqVR+zTUWO+x7hwnyTamggc9wiBdGeUY6aBI7VK8
 H4nCTTeg8naQfWyQXbAdVfwhwruUS5G3d3VqcdEClW3IpRMwRsTnj/cxRsrHaF2Nols1x3++S
 /V/fjfI8Nphyy7I88J5TvMiGkfXHgIQD4z+nhnW6V9eZpmP2k1pP09HT/DA3LZ8+Ly+p4+VrT
 Ztb+QBkQehzEkQ89SSjGiWAuycp0ptTinDOQeVgKUfvCnw1TNJfe2mfujl0kLr3rP5cZ2Z2vZ
 jHcfZDbCtfpK3xNVQGls8Kb4Kigv21aJBcRf6veVCIgCz+Mh0m1M8XvBZvPfRlG4ULfBJmbm2
 tetgnUdHVj4HLm8RFam0/YOIo8ZwcJS3f/KqZ8+u1xPW1DrnVgAPdWI7YbCXcm6C7U64GnQrf
 G+vABI7KX78bd+qUdw6rDc1bDK7EiNo92b5bgPuxS+5CRdQhSD3z2dICOY3sf8fT9M3zdkZCe
 JLy36CgFpL9V48O+yRGADu8UWxqh6j12OA/QUNrAtWZ+KwLacT6S4ljX4I5j2IF08cI+9MxLA
 cjba//TEnO7zI4sywoadMNwuy/sUSW5iJXfcrIu96lpuRX3jCh6wu9JY6mb6wZj/chGVpuL3a
 SkOyAxnSf2HEpei8yloHel9zR3F5Pg3QL14W9VHi/JD7+w3abCSEFoDLXnG5lQRMayyEdxhmI
 pI9PG2wJgwA0LvfYdhsoQaJkNEjySEfiP1hyZIIzIV3oRnstghkcxmoa5sQuPCtySwVd8Iebz
 3iifHRVpTCrhcnWIMnztHMsOgsS4aUM/3DAbD8KAmZF1v1vjP8AbY25GnksOEfNML9yDgvzNv
 3ZWGRI+b0/BPCxgwwRuBrL04IyVLR5AsVFvfhi+PiZScv6hE8V7D9MMyt2BbMKcjHIV1f0H8j
 7WSL0niKCCEJOJ0aHFgNcTtK1TQZ4hPri3+EtzbX3by+YsboFx4CrYF4nirD0p/XJ5OvFCNIR
 1R9rmQ4HedIlznpQ0HVcprKlWmGX0cgsb5pZc9AFJqNBw3I1hurrkSBe8Ap7ym8IQaWpJiaNl
 ffSXXbkw1tcgeLq3YG5JPwJZprfDg/R907CSHH73lVfwNcIlvfsABSGwBvDKazj+r1zGCzzDs
 BI3tIwUljmwSwJFEYw3SnG0y2odscIEJXUK1J/oPwznIMr99PkP6ddK5u/oKVGqPULppdANGj
 BPAUHybsTDEVdrNP1GBqBWAe7otohuAZjNKj9AdYScig7ToRlv8X811FcN6dckXNEFppu6VT3
 A6RDc01KFCjIJEny+JMYGoyl4EN8sbnY6kn7/Hw5CWhwmtdU8mhUdWNXRp8g==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21085-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CCA98D613
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/27 06:06, Boris Burkov =E5=86=99=E9=81=93:
> On Mon, Jan 26, 2026 at 01:54:11PM +1030, Qu Wenruo wrote:
[...]
>> +/*
>> + * Given an address space and start and length, compress the page cach=
e
>> + * contents into @cb.
>> + *
>> + * @type_level is encoded algorithm and level, where level 0 means wha=
tever
>> + * default the algorithm chooses and is opaque here;
>> + * - compression algo are 0-3
>> + * - the level are bits 4-7
>> + *
>> + * @cb->bbio.bio.bi_iter.bi_size will indicate the compressed data siz=
e.
>> + * The bi_size may not be sectorsize aligned, thus the caller still ne=
ed
>> + * to do the round up before submission.
>> + */
>=20
> I think it would be helpful to extend this documentation to include teh
> fact that it allocates the compressed folios as a side effect and that
> the caller is responsible for freeing them with the bio folio loop.

I don't think it's a side effect, it's the expected behavior.
The same as the old btrfs_compress_folios().

And I agree with you that we should mention that folios are allocated=20
during the function, and the allocation is through=20
btrfs_alloc_compr_folio(), thus all those folios should also be freed by=
=20
btrfs_free_compr_folio(), which is normally done by=20
cleanup_compressed_bio().

[...]
>> +struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
>> +					  u64 start, u32 len, unsigned int type,
>> +					  int level, blk_opf_t write_flags);
>> +
>> +static inline void cleanup_compressed_bio(struct compressed_bio *cb)
>> +{
>> +	struct bio *bio =3D &cb->bbio.bio;
>> +	struct folio_iter fi;
>> +
>=20
> Isn't it possible to have an error half way through preparing the
> compressed folios and to have a number of folios on the bio which were
> allocated with btrfs_alloc_compr_folio so should be freed with
> btrfs_free_compr_folio to keep the compressed pool management
> accurate?

My bad, I missed this location, thanks a lot for point this out.

Will get it fix in the next up.

Thanks,
Qu

> Otherwise, I think we end up leaking the pool and not getting
> to use it ever again?
>=20
> Or is the caller responsible for that even if we return an error? If so,
> why do we want to do an unconditional folio_put() here? Is there another
> get that I am missing?
>=20
>> +	bio_for_each_folio_all(fi, bio)
>> +		folio_put(fi.folio);
>> +	bio_put(bio);
>> +}
>>  =20
>>   int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *in=
ode,
>>   			 u64 start, struct folio **folios, unsigned long *out_folios,
>> --=20
>> 2.52.0
>>
>=20


