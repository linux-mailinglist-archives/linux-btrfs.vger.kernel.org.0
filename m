Return-Path: <linux-btrfs+bounces-19322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75CC82729
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 21:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800E93A38B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE12D7DE2;
	Mon, 24 Nov 2025 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NIjdRyLn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475F258ECC
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017680; cv=none; b=enB15C4R7SmnHlsygiTGl3+uJNeIFrwmxnUNmLUHPVQy5bn3mnKL/PnmefjRZu/O5VEnmLCJ1srnIOHRmrny8v8RV/nedRAWt8rgLQPb4Vw/p+IxPg/LC+nFp4HCus+maTD56eyWFSwhLKygqhuDtUUzLdvV5xzih//uJKcmlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017680; c=relaxed/simple;
	bh=Wzl97gSkTSbnhXB5T9cUtML+3h69fxF6ep4kqbpsHsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jj+6xOlqaBP3wiUz8DwctGWDP0+jbG9S7zXQgH+bTPhSfWpk9fVk+LSfsEyzJ7+jq4bjrHHE272PWI4nuON1hIUz7/399weuI7xS5ksrzJqremoc+FEAYhejfdT3/dHkrxzPinVnlXCAx5/PgnWbcRsTVLCg7tYWQzOoZQ30X0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NIjdRyLn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764017671; x=1764622471; i=quwenruo.btrfs@gmx.com;
	bh=DYuRrQhZkCHGa+fTDXnIRYdaP5UUlqPUI3pAWka3B8M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NIjdRyLnrXsXU5cPdKmNO4kWlHak4FM+2ZUOwfoWcS1SigThzasGhP4NIYTTDYNK
	 DC1T5HQxIY4I/PDY45eXqBXtHf+yOk1h7C5pEnkxq+gKTk8xAjBXue747229N7e9x
	 nyHZwq8fbBrKpvf6sKues6XvbcfwMjTEmlMhKQI7BYdx+F0qJovtODODpnyqDAhzL
	 3h/Gwxk9mLKSsfYJfJYYLxJ7/KrSXxvnLHhDpX90U/83FTJlDHfAMh6SNTYUSJLjS
	 qZKJ5Xv7vOLIB4pqOsfHUGnalelL51TKy5VgQFxJw6/IUi6jfO1lK+VWFlsOJjf6l
	 8VxW1fPS7dakXfxBFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1wJTAD3wSx-00yAOE; Mon, 24
 Nov 2025 21:54:31 +0100
Message-ID: <ece89818-27d0-4cee-af21-bac7867ee31d@gmx.com>
Date: Tue, 25 Nov 2025 07:24:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: return the largest hole between two file
 extent items
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763939785.git.wqu@suse.com>
 <8f8e8639c8b7cdde04d0930017a2f354f33c82d4.1763939785.git.wqu@suse.com>
 <CAL3q7H5x+t_P=CoxcvmNLr8YKM-pUF3mAUiZBUkdRN3oN+273A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5x+t_P=CoxcvmNLr8YKM-pUF3mAUiZBUkdRN3oN+273A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o79zc4przyz6yLCIj4keWhGbhyYRbWWsTV9Ipnyy5HVGSaxG23A
 1oUBymBDuKWYNsXgLIZqz4O0DTSQbT5EQw/RQrn+mJ8sBUuUZ8UOjtPt1OGKBVVF0eYFVXw
 /mW0g1Y4F9yG2ih5ge09X1GAC19S178E6CUaUS8UMWmU5IPwv0e7Ly16/yMl7z0pkEyRWUD
 Ry6OwnhklPJGbXllrvLGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TLBMUaHJRWA=;w5OH5p8R2sXVf/yf6LAFErnxa0X
 +KbPAyQMbuQqcswcbGa6pJgFlQsm1EbGAIm66Hpm0PsSJLnsE/xndxN2F0VdZUUYmbOvKRrcY
 4GIHcX3XcZEoc7tzSwYQDaHsOE1vUsFhA61bJrNs4igSosDkrhVJAfMvFSZOzHuWXcpUHZlrX
 ws/yPUe9keKXxWTtC49ImARyv59B1fG80oa7Pa998K6bCsXuzCx0KLV4lEQsZ5aELmnABbwi2
 h8Lm0ilZ+5Vg8q0Pzp5oAUGrue/DROpyhAwQ3PWoI7spVKVbTd+Kz7yc+Cv3m515KcPtCkx+Z
 jBBWtXGVzRr961TWCwxT7uoRGr08FOlvH44q1rHSwp3wu7B2E4fEne6MdtyTnmKEuymOzPM0E
 1CA489sSgFFFShAGoA/lQrq1N+TeCOSJnZXSvdU7htqAFjUplZyDBnyCJA+4NGkDG3Dw5xHic
 N5L9gyrjDsKvZdL5ItFRyfpQayQ0Y9CTQh8FmiKRX/bbJoVH/6OfwLLeeaGP9ktdul8ppZLBH
 cqyBAZIq6OAy9LqNdxCZTdSNB6qWqwXUx3tS4L6rqSkJZ+P9S5PLSnHh9ueNHfDT2B5l8+77R
 o4I233LzULNVRsdUzQ3czfj7vHD19xwC2EWAAlIoEA2AAzDx4vLEI3w64boljIgpb7njspT2R
 USvHootRx2uIIKoWkgDkMOYY/ZFjVOgCyJfndsNZZsMBEmp4nHgylOfTL2zwz+wnl0nf0iwks
 4D3DT6V4mMdbEHiECV8kPdiAvtf1ATf0XJMMD1TC2pckg0ki/0thhDTL9xNnQIhcZ/X7KR2dx
 5yU4BEFW3INbeb2N0rIsMdHyTC47GezCyXg5H1vNoXpMCQTLolw1lxDe4pkk3WKRImjXbPUEA
 f7kmc+RVNmggs2C+zjuwuCvrsNtDrvqB0cEiPzEKY2nNv7J90u3KnMmdbEMTLiH2Cl6tf/ZHi
 3HUHD+PyCa+zyQEzDOkO4yBPY9AbuOx1sgKyFiXqMxtmwSRkn6TRV1Qemr0w6ci3S9mA7fhZ9
 6Wi6ko2OxXSDhtm/e/hNtzCqzB9Pj/jlZl87bcum0j5E9usJSIrLy2Hbi6pWWG42xfwG7r3WT
 vg1oCCxzUa1LLibi30j7vIq0n+EZIYkDb82CCNMJG9RS2Rq1onyPTmQmaGJrgn6tZWBfVF+WL
 SyMaRZl9NCSlh5ljPJuwuzWYPyUmmi4dlCLUI0ftFcRNkGpmFQz5/tknkm73jbLjXorp8L2Mn
 qMEvUC3nalgGeOWBBS03gxtR9U7ZN5kAKJrWVpbrNFoxWD077D8T/RbDbx5Z/aLtaekDErxXu
 ov4+9LtQ6m4SC1AYnyMhHSuWbUgCqxJ/pJwvBEsKj60Uo/4lC3YJekq7H/hKoZIT5uc76jLlr
 FiKZJtDPiSNXozsf3j/r+WvjvCugZ3usksEAPoaAgeD4XaBUaS+Y7XmpJ03dQFeuhQg/Ld0aW
 eAaPBdaMoNmZb374iB2HUwcyIF+pX1tUyhe/3V9vvwXAjKkzbz3YUYu1b6Q6863iLvx/WEdDW
 2QrRaU07VDqUgHXULMG0AqVVpqCv+7UTct0TkS80YX0bVn5wez2laF7erdP1R2zvuzY4MGw4p
 aZ0e6sYH6RcI/U6Zu5f//p1IFTn6+Jyw2/FJpzwo+5ursQXvRrZkJWKat083uL6gHHGo/hBfn
 4WIbA6tBt7sWnxHVcfSHelOMrUMrkwZjYfKXDLDKVvFDgKEoAAcik9KDknlvQthHNQgLx2uhN
 qVGpZYax4UuvpUYRSZuW/EKkhpoqigAAAfQX+RI2vZEfy+YHteyc6iDvetabJ9Qv33UG9W9gN
 HB2wOkd0ssgiq/+LVqvx7Qt6i3lY1YVb8HtjSE/xp4XhGZSL7wRU2TZej6TO+3A9ctI8YDreR
 ms+ZBK9edo0Fx3fqoixU09i8eompQM2FsElE+BAsbv8WkpH/r+7XN2G9yChJdkVH17MpGjr+w
 ARzJN26T05+/nzUamMpdEKHJnOcoQnXyKmvFD4QUdZnFI9L4TTqKC9Nj2jhffLQ+lVZKbgrNB
 1sE04nFn/ohHf5mjwwpzsSjwnwIiKWtXyzCsH7+XYWm225QpDAvWVwbE5tQ42BmN9VA4599hV
 KoTQOL9LWQl9odDBn1ALCj0VQfh+HEK51Xb19Lh/7zpHShi9JdtW3xDUtt5OsBlxiT7/Wznb/
 FEGIdI2iypSdrpx4yhZmYMqy5EwdnmuYiKYfZfg3kBc4FypHGWaxNCdblH38eJKym4bVuiKjY
 TUIcTxkaOlFNBA4sK8cCvnh07xpc5X4/Dr+p7DjLYNA1o0/xEBrRu4FU2kb/GUUwgx2jGQYgJ
 4YRv/flbCB/RxCIjJZtKDMTFwPfRLGTKvkMo4lWa7kNmmao7X/1F0IPXdaAd2WXYkHfV07Skn
 nSGMki4MT0c1GPmLpHCIgc7sDyoeKm1Pie/YiVHBOZCSYd6SmQggq+bvg/APa33urjMfcvt9J
 1cBxIol2SZ1eiEwKZSoTmH4rvvdeb5uGXh4qc1rYoxhRLLsDBZQmIo60V/yD+ZdDjr38hVYaj
 7jvO5yORY9O/IBIyG7QWwv8iVg/hQuFXAmPSdfIJr59PguelBj5ZRKbbaRrQpeDoM/Fe+mCUK
 Vd2KW3ZdePZa5S8133gS7iO8ODHnU2l87SgXKo2ykBocz6uDkT/+OgEZ99ITY/Pgw38cIf/HR
 vRirB/lhHNb4tPmNVqv7FulzykzbgC2AZ1ZQGkbYLMobzY/ZibtubKrt+0hSQqHKLl7tcQ0QD
 kL1y6ksybRNYvcQMQfJUsBPB+wCuoloC94csZETQcMvbmlk3j6XTN/5pJgmiRAXLRXnsVvMMx
 iptEsc4HIBqS+TjosA1jGom7eaQ0al4WZ7XO/TfDg+9LZeBfuuhT8GQvfGvWyEIwJoI1Ca40m
 Ilm/2kjluSWwjOIYr55NpgZxC3uoFz4tIvPk8gKO3C4+QQl9BfWdRnerDT10eU0ZNdXUkX3KV
 OqL9GMrf1v1oeEELvV64w9GSZzIlTcqdfAEgsh0EyUlhLvLLC4LTYOAU0UWrQN974wZNTbCmZ
 CJuUuP0Ij/22SABHDZ5UOccVkV75FbM7shajuVoJUuCTZ4CiIC6LCAAK+Q2omJQY0pOtHObs9
 iiWV1amyrERNju2gDlLcq/BkTJ4HvAmADe6pdbFBePsKGzVLTeuvJ9ntaJeI8enexoBAZ+A52
 4teJ+rMjM5DyxJpD9qFWI9boILuPEF6K8DzcneZwZGRhUw2RKrkhudTIHg9dzUwFEnVPLxbhg
 yFulJvO4bELQSShA5lM5ijoAIA7ADs8R8O1lI0RUWQZJ9rXyp2rawOdGLfCj+2Re6OsFTHNAN
 ugPYsQ2lE79RnIo5Er1rojH6y/A4CrcLfh0X4hv9yMaMiBGJQ48y46f3MPSHhxjbXkt6C+gbE
 vkQkTJM9gripJuGbF4loQ+a1t94S7tDSAiDfpIJ6iCkduMFdPpHzO0Xzt2ETloYvR5jtS+hGh
 Z1xtuZ6kJr/cyitskmDjWtFq8HcAGr5xdC1P/UD57oL4J2ZokNrbuaaSVwvZwJONYfgzWFcGV
 dBloRKnkP2tfVDzcRqM6LkwHQC8W0tJYZRSRyGpZMNVeyFEHnwpm4aQoBA3VRvGubCEkD5d5u
 mFz/aSFlaVOChPX0JL2jm/DgJZL2s8se9fY19jwTGzPnxKgmfVMHrvjynF5AbKO42zI1B4kv7
 HXqAs9N7+uEaTbanjSY+6S9Q0opkoKZBMfv1Z0+aosEJ78zMCcTjAzo3t8J3R20f4Y2OmQle+
 FQzW3ILmB5OAB4PbmLS2IYXtkkoJTPlUAsPl0yPYprnROh3j/AHIdNpb6J57nXTV+4qEeAnsN
 H+dF5UUIbumYvNrNnPuVemifUy3mLD18Ov5XHScfwq0DlBo/M/dVBCuzU6R0PoXQmPOkaDoKB
 jDmg+zM7p1tB01Ta/d9ckfyRF6CUWggMNkyboj1PowjWPA7FrSrnseuPJr2TATrYBJPbn19TV
 0RB98w4VYG/IPa6YxH/ksxJXdtcvdsdqbfrsbKOVgV5TiL/64+6TYNlMWfKJ+eV5hC4tQOhY6
 lY1Za9vy7Lm3VRxHQywEscX0cYyNjD3qJbu73LqJzmhdrsJIyHZob4WGsWuSueO8XjnNIi6WZ
 x3nzdZ7gFItX6Byp5QIW4atRHTK4hkqDonp1MIrKeSgg6y0t4K1KlTM4poNyZ18NNBiJoi8Fo
 op7FW6ldOP37o0Fyyu8egl6BB687dERUnEabz6yWtExIJNrHOqXtTKUAy1bXfaSczQHLum2B0
 tO/JZJJ9oogHW1XNBzuSxJZaw01CVcNmK8ElSD62WFtcwh+gM/WftLSK4q+CPOjl+Pmbj/FAO
 srGJksPiDD/cOsrYE1e+xH+aIwbcwAkwMjNpyKEWroFc6ekLm0YRSJQvVrl0YjQeDGr0Xeu9+
 FmWN2KHcaLpYUeZr2yjZZXLbWjbkaKR6AsNVwD2DIcbJtNjE/F44lzJDhHu4huXXcMzEYCFez
 wRmgQqLfC8N764CzAwVnYSpkLIxqKbhx/5Y3+m0ZwT+I7u1mb1/ks5cqQ4B0T7YM4CiUxL2UA
 J5i3r0TJGSbl65K6PeLCOT6PHW1mkhWSo/LIHzT4QDlMtTMJHWtYSL2PgoYt/ETVhi0I+lnzZ
 wdnBetccclbGn2ZrCsv3HCzM/gbysUMGeFszWS6K2UDJaEyqjrOJIJzWaTDt8ePM7vp+Ogw8L
 FBYk7J6AgSJ3c6Bob3TcEWDRl5Uj1Acw4wJuAdFGzZvOKhqoeSBLLl/RPyYwwvz75VeSC6UMq
 wGKZ7W00BQf+8SAeGWSQ9CYBCAurmxcXMdmjc1QGxQyQ2sd/vcFu833EEyhgyHDK7bjYucTv2
 zVfPo3JJctG3RKyNROtU9qODZtANqtzQ9DMb8Tug7GyTuCJkjZo1V67MxbuIY0Lys8Gqu39+t
 lz+aRW/MNO+oHOwhq9eWX0yNPD4y3Lp0CKH2tI2dKJzebcHEsg8qGPgdu2lfZbSeAbLlppbVC
 4AxRLTfQlpLvZx1mmnrYKRn/7iiy395CImd+hvuU1WmfGRGDoAK25iHzhJBy3nLSZSZ1mW9Aq
 +MFGJl75ZIJ8ym2E0c6BFW46C4/FeNweP5A/oV1AzR96i7A679g6l2Wtp9bGjYhc66slUcniA
 7jU/iWov/g88tp3LqGc+a05VdWqSX+Ez+k1YDY8N6GwxVIMjqxnUTw5NhHFA==



=E5=9C=A8 2025/11/24 23:29, Filipe Manana =E5=86=99=E9=81=93:
> On Sun, Nov 23, 2025 at 11:32=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
[...]
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 3cf30abcdb08..3a76cea1d43d 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -7181,8 +7181,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_=
inode *inode,
>>                  if (found_key.objectid !=3D objectid ||
>>                      found_key.type !=3D BTRFS_EXTENT_DATA_KEY)
>>                          goto not_found;
>> -               if (start + len <=3D found_key.offset)
>> -                       goto not_found;
>=20
> Your point about the inefficiency for the readahead case is valid, but
> this may be dangerous in other contexts.
>=20
> If a caller of btrfs_get_extent() passes a specific length, it may
> mean it has locked the range in the inode's io tree only for that
> range.
> For the readahead case, the caller has typically locked a larger range
> in the io tree - except when attempting to read the last page/folio
> for the readahead range and there's hole that crosses that limit.
>=20
> By allowing to return an extent map for a larger range:
>=20
> 1) We can now return a stale extent map.
>       After the path is released in btrfs_get_extent(), another task
> may insert a new file extent item (such as a direct IO task).
>=20
> 2) While another task adds the new file extent item, it will also trim
> the hole extent map created by the task that has just finished calling
> btrfs_get_extent().
>      The trimming (typically done in btrfs_drop_extent_map_range())
> means updating the extent map's length, start fields, etc, while the
> task that just called btrfs_get_extent() is using it, causing a race
> with unpredictable results.

I agree with the concerns, although I failed to trigger any regression=20
with several days of fstests runs, the limited benefit vs potential bugs=
=20
is not really worthy.

Thus I'm fine discarding this series.

>=20
> We've had problems of this sort in the past.
> It's a bad idea for a task to create extent maps beyond the range it
> has locked in the inode's io tree.

However I also find several btrfs_get_extent() call sites without=20
explicit extent locking.

Call sites like find_first_non_hole() and btrfs_zero_range() rely on=20
inode lock then waiting for ordered extents.

And buffered writeback path in extent_writepage_io() which relies on the=
=20
(sub)page range being locked and the extent map is also pinned.

I'm wondering should we concentrate all extent maps related call sites=20
to use proper extent locking to be extra safe.

Thanks,
Qu

>=20
> Thanks.
>=20
>=20
>>                  if (start > found_key.offset)
>>                          goto next;
>>
>> --
>> 2.52.0
>>
>>
>=20


