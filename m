Return-Path: <linux-btrfs+bounces-21463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDaVBp8Rh2lrTQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21463-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 11:19:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA48105756
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 11:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467E73016512
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4DE31195B;
	Sat,  7 Feb 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="twhpqpCk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387A29B8DB
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770459542; cv=none; b=gBLVpXxhOhljZM3tasOpYaamwd3mkX6ArDxPc0PbiX3C67NQdwPy9ovKIZZF/RJbW3ER8H6ndAC8uSX0frqY4fcSq6KNpLDTWPbuAsHnCB3P175vN0V0T+xrFaA2fv+hY3MaNsomgXz3n0ExuH8FYLf2R9F2leYrOK+D7fEr88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770459542; c=relaxed/simple;
	bh=sBn4YMpEuOxdcnj0fDnhmoPSOUUVjfXEQ6DC/ssRkwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZJZ7RIbVp770zHMHEOhTpWmxBetpEIWM59D/RHu/cc3vJm2OetG50udSSwu0P3gK/qx9BcW5Fk9thmgHCl2VBllVWJOfjrBwRkYTTwxOMwGoMRDIRZau+d5rr9RB6CK+hLy/U+d4XpMl/mzn7KwikpW5zyKJjdxvkLQRjgMQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=twhpqpCk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770459540; x=1771064340; i=quwenruo.btrfs@gmx.com;
	bh=VQ7lsRj6EFradrsFSf6+RnOrE+SCqdufFNYjCz1Z5/g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=twhpqpCkfYu2ddhSR1i/uArCF4LS25MHcW82UM7H5TBkKcXsp7zpwDOyFVB92wka
	 x1IRO8a4F5KOl6zOHzvzKENgBPeQ6b5b3tem47PFtyUkTN4qrMSf8+b+hSn4qqm0c
	 XcoYRJYnCHQgyrt/Het87sDj1x2tQTYDB89ShkRdtdFGWGWY9YnesIIYHEcK/kjbZ
	 MM9yxmR1t70eUoA8k9g1Y0VPAPy10c4YjorK359acaXzgfqw1ogxsvklSYUYNuh33
	 msHC7IIr0h87+wL9JX4jtZpuzhKmVMZ6gpQuuqatL2ReaClIvhwOp/uCUHTvcE6N5
	 4FIqWJHM2xYHntILrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1wEtOs2IwT-00LQLm; Sat, 07
 Feb 2026 11:19:00 +0100
Message-ID: <75b0f891-0338-48d7-ba99-ebadd7e2bc07@gmx.com>
Date: Sat, 7 Feb 2026 20:48:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: Sun YangKai <sunk67188@gmail.com>, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20251209033747.31010-1-sunk67188@gmail.com>
 <20251209033747.31010-5-sunk67188@gmail.com>
 <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
 <e058b458-0c8a-47ae-9e45-88f2eaa8b821@gmail.com>
 <d092aa23-655f-408b-94c6-edede3c8dbf2@gmail.com>
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
In-Reply-To: <d092aa23-655f-408b-94c6-edede3c8dbf2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAUed9/EJ9dV7dnGMu9t13T5NosO8Oh/CHhN5gXfbwQivZuPkUX
 ZV5AyCSkOVz2sLO/MWE0RjAlnJthPwTMkSg9Gy6CmkhLtdnq5sH3pXTwtUwytgDIIziyK8Z
 ZIuoBTipZ/TCZH7UQh2POxvjok7764TRJ+rntPiG7RkSfvQbBZMzlUcmBr8cSZ/yVt+jLri
 B3Vnb+sagN6bcjGNOyr3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2GmVjRDrY2Q=;MsYe6GVYbeuxwSmj2cFbb3urXJ4
 z3XCzQrWUIYMObLi2cMkQatNLC2fSowmgxvf+4td5cnOq6zhyKsqbmESHaDdzGDRW5gKfhoyS
 x9gydrmWeFpCTZAHZnnT8TdRG6QhUFA09FHuNuSLte8kFE6L4OZai0qu2HNqSKfo43Vus22Nm
 /oJK6KH/n9vFFEs2xb9hrQw5BgelGF84EyJJs3nhE/7c8FG66hqvDps2MjUqqybvR8Y5Q6yvc
 4c6emAwodKUi3FGrPnfXbelVL+xl0WiTMk6DPJH+sD4waMVE9El2KWWe+ZGn++0n5/Hs/ikU0
 rlblX/JXdl1boG4i/qn3zYE4bkH4BFw+XwTLRc8bCIcRUnm1g431912U40rsAYu8Xfg32Ko4A
 gcdV+PpZzUaqFdculF/tLW3vSfcJiFHInhpXpS9xsGlP3oTcp92W89lismt0swaJyo3LR5RFy
 pClGtoGeL+jWi2oihUHRgabOIp6tdDv80VSQhiMo+WHTET0zi/4MtRe7solFAW5+j1RbZB7l0
 i3I8p0ovxKAvXFRAtBf/wbtGnRIbsYRdZLO/dPmPcUztQjrQ7JhutwltzxExswV/dUMZkpkH/
 FqQiYghkfYqr6C7N+u3oFBNoASnX9yyFUsv6jMV8XqTDMja6+rSXwgHEGCR2NUh0p7GV4knEl
 REbFUEBwL697b9GCgfh6gQRLEKHrej/kEzAL8nwlvmAOwJsftV2wv85L0caumA8GQCSss7Vne
 SHUDuqGiYtG8oQgcIvQDWyS4KHCfVuxcLNuFU7bdB1eZx/2wXk0PIG62Hw4SPgftPYUTdlYH9
 ULT++s/Zuvch8ebL1lxwZU32lwabko2bPKYOlEwMWJMJZvBm5UrBMra8shmj/kfSm1VXsuQgl
 +Wn/Xa0s2gtT484/jZLXkR7cc4YQs3lL9GnEnOwuhPftxXAjDaebQJYHha6tidO0A1aKaFC1T
 zCVSxXURzv27irwpOtfh6C4ZZPACmOMAZJ4l/D6MKAbfvs7Mor9e8Fmmukln7824HqSqy+amU
 wUmzwMPwW06Mv9NFWeGnA1HaDVm6+mo/2YFrUKjZBjJgP4bND4zsAfGBq/TVjXIDfknpa9udm
 I9bE9/ue0U4UN24XwMuTm2OQSBOKzaDaGACwEUZTWYuYcplLDmJcWECEKGoAk/9ru7x++zOLs
 lDT/c7T3J0M5QFO4kOKGo5XKCF3pE+v9ICsvsyqkmib033p2HsCmSBNfo5UX7rhBiugsvE52R
 LY6ml1miGddOw29PZ4eEJnBXGiFFbOuA2MWoUHu2TS1oZ4e+Fzm4CwHPlRjG82zGZ0U32zlpo
 nsDehHXn+S0vjqLb2Urd8GNWqblJL3Il7GnjnRKPt6OK55WW45Ch6sQ30GvkWDoqTXxdqmwHg
 uHZdJtFI8r0Q5W0R+N0Lvnom072x7TV9ROcY9cwdWKakmE3OCNeswdylk+ffJMPUW2VUBjBT4
 1BamRP3INmAxU66EuB0fCKrnPdH0/aOlEl/v8qNrVkGjil50DDg5mF6zSG9G74AG7IqfMpfsc
 H5HvDhuN+9LamkITQYU53bU8chXyeWxspjQ8IUGkKQST+VZQqk82p9oHOUjhzks8ji81JE0c9
 CuRHBKrEL3zK4dg7z6xY4PUdjuWmLoT/OMWpKV4zyMYlbNusvdvxLIeEvZkjqMt/7TS3W0G+P
 iMtYt3Wg2DGcF+pzfdxnHt5P1otDydtx0YBdJ7gHGQo0v8dbzDA+wvqKcE1TGuI3hqsitJMKs
 Hi/u+m5tkVIcmRk/Efrvyd1nLiH81rsfTrr0/YLQrR6B9uNwJMfmaTpkC2E/frIfPeL64BoJg
 tkDWv+xyJY7Yu0Mp1zsTFdzazdx1YN9stZ616S4V2pUe7lndpo7cMSyojvq9pCFxnyPAwyRjE
 Ka1VS8npkgD3Fgxf+6HeL+dw7oe7Bc3oygrkMseFf0CEZGTXghKMaky7mw/Xm5kcKhIL30se1
 8CEpHn8mNVSAsvEvVhHj/pHS04xKU93LQj922u4t2Wl1aGJM4z6OJzvBNUc5H4INn/PuZjLMB
 rDbOBIQyEcun+XlHEnbT108maLvXq4/Pfsqvkw8zHv8a+SVCKW1XVrQ0uucd0UjbAOOd3xpQG
 XV/BtUDLy5g01oMzNEk24aZrdZox1NDwrlJznlpMIVP9mUDE/uv63fjqoKtehM1ME6ZhaLrLz
 6KTgIIgaZC4oZKTG0ZU2i9tk467ljx37D7aKfRoOyuX1muThG0ZdsqEPiKeF/5qjMUaBAK7Zc
 rT66X+qaMwv2M+XrgIlaULvRPgw4LNWSuPtMbPR79hp8apuYvkyv44TfywytOmLbj26mTqSro
 eVk2Ph0/B5timqvaqZnbfTpRNutx3uG2B6M+RpeJcGe6eHQgmEO2NNPnQE7cEtUconyQBtAMD
 be39eBe37ooeH/08N88HH3KIfJHOrOlUwtQnTU+FexXiyIHJur4C7cc2VrYA9uEyN9zRAxE2C
 Pp/6101X9IVzRUfLNN3pNoJwlR2qe9edzv6GJcfj7fPBQUKfUySKwwOb6St4F9YQyld18koV0
 jzayjxSVqXIcgs9XzaE/M1VtNoF3Euj4INLi+Y0jFyRagFtCdxB8X/KkYyYvXoMQw2hBBUuqT
 OMSIOorerZDiD0GHMqi0jZnodDM9tW7WtA08tBJ48FsAmWaFgwmqCK5WGbi5/i+9wOAZr3JXP
 I0MHlx7fYAicopb+ZFcvQAQ0F85d6avb5GIeRI9XAC2b+uoXP5sUpgcBajoKItUYHcO+eyylh
 u8HDgHwhLcCMuw6hbJCda3b86xvJmCPTDpWoey4pEZ8LmgUa08VL93zBBWHkHmvliuBNEi9zt
 XsmJawh6mwvB4UtR+ULG8PkoJkTPNNSbBPOOgkkE5Cc1J/F8AWSHs7oP48/DP4JofQ2ObLQ/t
 /JHvBGphdsgLZaLiCWGEezzhruv+7sKs7DI3bg3EHmMOw0t0+/s++heRxosg8H1jIyBgRUEoN
 H6xQQ/pnXYvjgg9dan4VmVxCkm0Mdv38wFFilzOaDbzAVEkWFcED+DZojeKME551mKT9Rocri
 i5Errsjd00XhpyX271pPYcCWYgfcp8uu9XPgT7KXT5lcj5VF65pA1Nx/5priaXkFZF2tXKZHC
 /QKVnquzQZfZoxPA3tYJSoVyrRUAdYqF9P5ftyrVruLFUY8c43ds8KcpWvh6+m4nqBW9NNlDj
 sW2KSQOTWuHHNzcrREkSp7XmRhYnesGF0suZ7zLK788obVJhGe1vHGN3c4cMRTmfoO6G0A5xw
 DQRNWsFrA0Me3DPuwqTqT0/oq6cBEpF6Eq/S0HXHSqWvk7OirEBnnSUNBMWznr7O64pHXwV4K
 /3WvowCdESkFr6qP85sEnL9Sx+gDwt60oVsaHlsTWI0wpJDpD5Ged+RgUMrhpnxa2hpgfbtvP
 knQCE+Wf/IUPgt5xrAswfqtPwNHVw/zaKy5ATUPFvm06wnZGWw7FnPFp1tCSd6DCbt3frqoZP
 CmkvudeEdIV8LuWI20jXZgdACC0AZGmcHouS5BZ4TYL6l7Oy0x6T0PUlJK+MlnIEnhKgP29BU
 aMY43/qs4hgiIj1u01nfheqhO+TFgL//EdEQUrrdH5t+nB8dJkkXoTLwY1+6zxD+ZTD77b3e9
 c5hHg2zql9/lY+H6NXmsTxdzSYCxLYVvSmgFXlla7044MxVZ+IOsGk75RcV0RV3AIA49ynyva
 5osyejupyIhaHDhv4MxEn/KE7WNnq5dbLjANdk9B3otZMWLQf4mnoN3ywxn/ApwY3ZXwxvlt7
 GE5+UFMB+3FXdIYoXY0EqMUbuopSa6VxNL7T5o5LrgERlyI4j1CCVxHU4AUREr+zyX7eWUGer
 B+PYcooJKCQgxlVeLI7QLXd91cyG/33PxXc8EIw86lfXCf/JG/bz+jpceWYAAxNLGA2RXYPjW
 lale/f1vKwRnPqRJygjg5o7mB3SbOHqbYyRrtd1gEJawYfxOdxrGnzP3nmgSpH8U6d1xpTiG+
 pdmutu6/7ydEU44A+39elzL0d/rdx5ZC9DXKRh2YsPUnzfVGFW57QOY++mPl/fV0mfHyrIYdT
 fjFhsWqupSfYNcVpH2XPHxCH24ViVNtgVbmQSfK/+LWaKaqozZFB9ZtgPJOQJlXJfY9Sy9FWt
 L9iG0rReLIkKFr3oPUqaq23O+bZNZLCkG9VXxzKyQkyBiH1FwvPNnxomMfwBTcr4sxnrwxfuo
 BmcXuO4FZDlpHl8H7mZHfgMFeD4063xcLuciqxEFqU+DYzWgtPWC5EMX3+uKOMICamhUnrjYE
 J/iZKnOwBp/mykKweGpJK6B+0kudZKYO0W3hPCTQFRHwwc7gnf6lGeTefb/GqRwQeVnKzJVoK
 oHMa5M4qS6es/YjG7do6F4uAKudHgLFxdWkpD7yGCr6NTQiiMPr5TYcekWvOHXgrqfUWhtEcj
 zyPv9INbBYcnYbA/LCBN3kZEtYJXoHeXNrCg0ZcBpbALlVAKQvRLamUCswYgqvj34bSw/n3LH
 BhyQjg5uOEYvSnF1YhZva8HqnmjiL6jP89YtSRs4wMRj1ZMdzqclN9isUanQf58D5a2PNVboL
 NHdSRDzIz3YYCIHMd0Add1s+P09oDiu/CzowUCjdGPAw2KR72mppFAO2VRijBp9Ay3/Mn8FV5
 Uozz8umF9dBX6426RBx5Q9Jo65RSB/ZiR++hlh6Xj8Tixsx2II+7LIJYQwj5Nua0j/7zWeXZH
 iC9eSvxJtYeC8mip6twwk+b4LF6wcPfbIrZjuCI88y+A4uErdR/LwpSf0A4VvYm/Midhnbk9M
 TCDpwHc3haq4TGdMnQHiDXgYjo9p0gWbO1N3iNwKwOVo3J+nMjZUN4r7MCz0EAFoOtJKEcvJp
 amkh2w4+DI54CjvXavd7r2tY5BTp3++u+gRitQliI6ZIPn7RqlsYB196I6vFpJmYP+w37aOXC
 j04/9zF/w/DxvmHrxdpXKE/3w5ohOec2Jo91OGRe/W7YlzW3UCr5mMTyGwUuc/aeertI6tdEN
 y+U+menXNj/X++VZUsh1dndEC9E9Y1BbgKy9+dK2ncjTtjXcklc6gmTQUTazGONMGNJ3D2rGY
 WboTyOZxSr3k/VWlxgF4I0rqN1al6BBfjc9/X3HV/8b3WFRKHyMsoG0RXwY8V3IlTl0VhXmxR
 +tEKFJgciWXWzzTzmDReP4LGUlneJsYQNortQvC7AiRikB9QE6MPQMgfC0RNPPiIFTZECsyab
 g5qegpGw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21463-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmx.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 5EA48105756
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/7 19:20, Sun YangKai =E5=86=99=E9=81=93:
>=20
>=20
> On 2025/12/9 20:27, Sun Yangkai wrote:
>>
>>
>> =E5=9C=A8 2025/12/9 20:05, Filipe Manana =E5=86=99=E9=81=93:
>>> On Tue, Dec 9, 2025 at 3:38=E2=80=AFAM Sun YangKai <sunk67188@gmail.co=
m> wrote:
>>>>
>>>> There's a common parttern in callers of btrfs_prev_leaf:
>>>> p->slots[0]-- if p->slots[0] points to a slot with invalid=20
>>>> item(nritem).
>>>>
>>>> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
>>>> valid slot and cleanup its over complex logic.
>>>>
>>>> Reading and comparing keys in btrfs_prev_leaf() is unnecessary becaus=
e
>>>> when got a ret>0 from btrfs_search_slot(), slots[0] points to where w=
e
>>>> should insert the key.
>>>
>>> Hell no! path->slots[0] can end up pointing to the original key,=20
>>> which is what
>>> should be the location for the computed previous key, and the
>>> comments there explain how that can happen.
>>>
>>>> So just slots[0]-- is enough to get the previous
>>>> item.
>>>
>>> All that logic in btrfs_prev_leaf() is necessary.
>>>
>>> We release the path and then do a btrfs_search_slot() for the computed
>>> previous key, but after the release and before the search, the
>>> structure of the tree may have changed, keys moved between leaves, new
>>> keys added, previous keys removed, and so on.
>>
>> Thanks for your reply. Here's my thoughts about this:
>>
>> My assumption is that there's not a key between the computed previous=
=20
>> key and
>> the original key. So...
>>
>> 1) When searching for the computed previous key, we may get ret=3D=3D1 =
and
>> p->slots[0] points to the original key. In this case,
>>
>> if (p->slots[0] =3D=3D 0) // we're the lowest key in the tree.
>> =C2=A0=C2=A0=C2=A0=C2=A0return 1;
>>
>> p->slots[0]--; // move to the previous item.
>> return 0;
>>
>> is exactly what we want if I understand it correctly. I don't=20
>> understand why
>> it's a special case.
>>
>> 2) And if there's an item matches the computed previous key, we will=20
>> get ret=3D=3D0
>> from btrfs_search_slot() and we will early return after calling
>> btrfs_search_slot(). If there's no such an item, then we'll never get=
=20
>> an item
>> whose key is lower than the key we give to btrfs_search_slot().
>> So the second comment block is also not a special case.
>>
>> These two cases are not related with how the items moved, added or=20
>> deleted
>> before we call btrfs_search_slot().
>>
>> Please correct me if I got anything wrong.
>>
>> Thanks.
>=20
> After reviewing this patch several times, I cannot find anything wrong=
=20
> with it. I'd glad to learn a special case which will break the new code.

Check the following corner case.

Originally the leaf has the following first key

	Slot 0 key X (X is a u136 value, combined objectid/type/offset)

Now we're search using key X - 1, and released the path.
COW happened, deleted everything in the tree.

Now btrfs_search_slot() returned 1, pointing the empty leaf with:

	Slot 0 key 0

The old code will return 0 (went through the btrfs_item_key() and=20
btrfs_comp_keys() check), but the new code will return 1 (slots[0] =3D=3D =
0=20
check only).

Although I'm not sure if this makes much sense to the caller though.


And I have to admit, despite the above empty tree corner case, the new=20
code seems correct.

Firstly if we hit an exact match for (X - 1), then we immediately return=
=20
0, no need to bother exact match anymore.

The remaining cases are for non-exact match.

If there is a key smaller than X - 1, we will be at the next slot of=20
that key, thus slots[0] should not be 0.

The only case we hit slots[0] =3D=3D 0 for non-exact match, is when that k=
ey=20
at slot 0 is already the smallest in the whole tree.

Thanks,
Qu

>=20
> My assumption is that let's say we have leaf A with key range [100, 180]=
=20
> and leaf B with key range [200, ...] at search time (and we don't care=
=20
> how those keys distribute before we release path), when searching for=20
> key 199, we'll always get to leaf A and pointing to the position next to=
=20
> the last item of leaf A. Please correct me if my assumption is wrong :)
>=20
> Let's see the origin code:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0if (path->slots[0] < btrfs_header_nritems(path-=
>nodes[0])) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key(path->nodes[0=
], &found_key, path->slots[0]);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_comp_keys(&fou=
nd_key, &orig_key);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
path->slots[0] > 0) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 path->slots[0]--;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0; // case 1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 1; // case 2
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0}
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0btrfs_item_key(path->nodes[0], &found_key, 0);
>  =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_comp_keys(&found_key, &key);
>  =C2=A0=C2=A0=C2=A0=C2=A0if (ret <=3D 0)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0; // case 3
>  =C2=A0=C2=A0=C2=A0=C2=A0return 1; // case 4
>=20
> And the new code:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0if (path->slots[0] =3D=3D 0)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1; // case A
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0path->slots[0]--;
>  =C2=A0=C2=A0=C2=A0=C2=A0return 0; // case B
>=20
> For all the origin return branches:
>=20
> - Case 1: it will go to case B now, the same behavior;
> - Case 2: it will go to case A now, the same behavior;
> - Case 3: if ret =3D=3D 0, then the found key matches the key,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_search_slot will return 0 and we'l=
l not get to case 3.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So ret must less than 0, and the key of =
the item at slot 0 is
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 less than the search key so path->slots[=
0] is greater than
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 and we'll go to case B now. The behavi=
or is different,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but we make sure pointing to the previou=
s item in new code.
> - Case 4: the key of item at slot 0 is larger than the key we give to
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_search_slot(). In this case path->=
slot[0] must be 0 and
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 we'll go to case A now.
>=20
> The original code's complexity (comparing keys) was an attempt to verify=
=20
> if we landed exactly where we started, but this is unnecessary and I=20
> don't think the previous search result and the release path things=20
> matter because we're starting a brand new tree search and=20
> btrfs_search_slot is the source of truth for the current tree structure.
> As long as we treat all the things as a brand new search, looking for=20
> the item with key=3D(origin_key - 1) or the previous item if it doesn't=
=20
> exist, it will be very simple and clear :)
>=20
> Thanks.
>=20
>>>
>>> I left all such cases commented in detail in btrfs_prev_leaf() for a=
=20
>>> reason...
>>>
>>> Removing that logic is just wrong and there's no explanation here for=
=20
>>> it.
>>>
>>> Thanks.
>>>
>>>
>>>
>=20


