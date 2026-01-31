Return-Path: <linux-btrfs+bounces-21264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFyZAlZ7fmmEZgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21264-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 22:59:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C426C415C
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 22:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2435300490A
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 21:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E937385EED;
	Sat, 31 Jan 2026 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="X2m/jtV0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832036E496
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769896784; cv=none; b=m9F8IBArhSJsqDhKax+mfzodMLT44JbPOZSWYhNMvK5XyOtx1x2/tRwa/WMoB5btz252cvq019BN05PaKVT9wzu4YBonrMqZS2fIxbFfk8sXQM4s5idTsRtAzoro2itb8giiIoJgdh7pJM7hkegv0NiOws98uAi8qNCD+g78u1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769896784; c=relaxed/simple;
	bh=11d/MhfCkGYhJwQHHoWid8b78optb2QBnsiAyrNXzps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQXa1g20dj0Ja1iLoBr9PiMn80MiklqBxLjadZsTamCBeCcejRCJ7PRlHjkao1dIklfTTlbagOiDeSBJAMt+80eVkJ9SjjDIkbsE8sxMOEHkAHqMTvkBdxGMxOqa1m8SuIg82V2t+YfxOdOSX/09cN6VZyCjPr7gjYK1AhgBBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=X2m/jtV0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769896769; x=1770501569; i=quwenruo.btrfs@gmx.com;
	bh=0uQ68HfURRU+sagOhSpv9PAVCwENo/MuXeVVKjR13Dw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X2m/jtV0Q6aBJKHI7+aZCwVlQKLk8yznsXuRrTpLdGwnKD5P8N0Ap/NEDkSk4lAA
	 ccQe5o+B1G5DEXmHR6uS7LhiCkcB9nnMG8hYMohyMipjNxK2dlzfe1/ppqs2FDLsZ
	 /LGVKHVgH47jc0ImlZr70cLIXbOe7Ypgr7WFtJiKVNDgTVlr6rKyOq638eUx4MZQL
	 aq7D2X8NYYmd1+MtBtTdfmEOFNDP58uOC0H4WqbbP8H65DKERiQOiCHSrR8WDf4Ei
	 +eKTM5uI2pNdxp8Te6R6FQ6kbiKPqXiTnxZ/aoq9sbLF54UOtmg4CchnEkTfhCtkU
	 NnHrV+D4VC1T6dj91w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mbir8-1wHmjn0a8E-00b7cj; Sat, 31
 Jan 2026 22:59:29 +0100
Message-ID: <2946b081-4016-45e2-9bc2-75a1b7b4dd32@gmx.com>
Date: Sun, 1 Feb 2026 08:29:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, Leo Martins <loemra.dev@gmail.com>,
 Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <20260130214319.3714908-1-loemra.dev@gmail.com>
 <4bff1e42-57de-4169-b3c0-a2085182cbb3@suse.com>
 <20260131001118.GA1432933@zen.localdomain>
 <94167ea3-8174-4d35-a316-1f9e46fdb988@gmx.com>
 <20260131171630.GA2030728@zen.localdomain>
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
In-Reply-To: <20260131171630.GA2030728@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:usWwQKXlGtMkGGxDFd5yE1y1/1Xf1LdL+qNHsJU1zDVp8933Uvk
 YfvzdmDBcB8UI9/Sd4RGGQEccy/FudkMfyDS1SXNMqXvI4Ebz35wwSuPvCPOgsCpo+tFq7G
 l+NYEwxha33xUK7tUcFilLvtRLaAWg+Rvp6UoBP5i819wWhkbwjEcm4DtBx0qVj0MwsymPh
 vikO5XyACAmU3C0T8L9oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:akhtC0xHm7w=;4fOWV25E3m2nhdL0RdmPjiIzt6S
 1PUTwsY4ZIc1DA9XK8BiCkR9zwMuzZuN/eUAq3APro7pt0GPlCwEmZJuoD2xdS+nNOFNTxhY5
 1aeg6WaEzkU2QqHcaNvYHdyuMwiPf0O17ooFsiRDvOnWidkJiMbZl65c+NVk+soFoE0SSnGs/
 eoPLdmlI3ZkWQDRx/6mOWVtbcffZrwgTL6HzMa9ubh14V+VyjonDl5zSp7ViyQJP08Q1iEaaF
 aKflg1BN3KgBzWH6Hm+QyPuFPEJ5aKOYme/b9tPyq4Btto8QdS/jq3YbhMPw9rj3uMouUnUu/
 8fh1g6WNAfrvthieg6nb9i+Qt4xctD98LaP1hFtUHCp1tPltbsxWwmlwkpTMdevI30ELqKt1t
 Pz0AsUxuWhUgWMdQEIBVA3jFNm81peUaNjyhSbxasXpI9VEYGsRyLeDOvn2VIIc9P4Hz/ApxA
 FJlkX1JKS1ibuKE+xWupY0aFoquHkrgeelP/dEwnOQRuuNVZfCELh9WoVUd3CGJqU2qHSwOum
 dPlJQW7WfR3PDSSTMbTkmMgI5QIwKkCSh9lwdHIxJVcuo6hBP98akSVOwkRKOfRIWN6wRxQOi
 mn1P8wPPID5GUu7OjfugatX1hXwrmU30Y+Ezt7/9rhueWvBA+S/X0b9A8+elOoLSUYKSGLHyo
 GRhe7aT4Bveij0ft37Spb4IVJmolzPammGtlwYy6mpK97w6Jn2Y2Sea7CnMrN0jMtFVcRDO1U
 Yv4GmRkfkB7WVdaese04OVV0e3g7Nb+2b9GYPdE64sStuZUc/qVxhz1fEO1jTJVp6Z/Q/jJ6w
 s3+SC82BxejYVEEFB37ZiXWHQIornjUElrhOQHaH7MTF4uO+CLQKqC5v7grHm+WRIFEh20QIJ
 4wfrOI8ZmYwK1suIGA6HrmWbSHCrCMmAyaC8DVwW4+DGOHQWM/EbKpDDP/ZjgNsu7HiifBmwW
 ydsMXxEKhibQ1q2yGwxgB9RZ7ghMCu3JF5q5H2SNCA+abeiQGCYEE0EoN/bWeT6VjEERfSHuY
 6gAdR0exA7K8MlSV8RyAyMeYyERUBeoF3iMqxnXfc11YFwy7wgJnKSNvEsjKONU8AqDqBJM5P
 64S8EsEzCrmDHv3XsO3JszG6N9I3ATqT0vzwXTuiijZIExmjBpPfw4/Yz17bqC624IzWfbKZS
 bdH/iaN45c7JmCVnCcAzEhPh/xLX3T75uLuUrzvV03yVbMxF1SwPUM5lNMh05tF3m2KHWAV3a
 AdCkIjgLCXJVxaYm4Qlw8dw83t5Z9fDFJQ8BFHhZTiAhb19wlchqjD0cR7QpXPttfpGt+giYA
 YfjflrdOSZ//Au4NHai96TYXsHr8jnzmRDouKGraVault2fdcdbS8PK96YtAhFIvgjBzMMwMk
 g90UxpPO8Bh72snZJAlsGmQp3TdoNqrlvsXx/EfHUeKd2G5anbf4wT9Mm2rAbFbLiDeCitPel
 RAJqnt7dvBZFrF9Ig0arHHcJIy9knOA5Wcilj8VyTQANH01bwMWUYC9TTauzHSW4PtmfOY2Oj
 RcO2FqAR39Rx5i+u+LCPWMRIJ6rK8RN7DlhCdWiB1Zz+aDuizXkntW3izsbqUHw/Jn2uun1vO
 5lyXQ2AMGxMGQJ5PIungzhfHBNUS+kiSS93MKDL1pHjaE6Sw6A4LDazcNblKcJ4yX9fAubHje
 IorJycvAMH2V7A1NM/9wOl+F78WB0tXmd0bNg3FkF/cbAx7j6qiAKLYK+nJT3JaNYs05kPmTE
 uGQJHkoKzIS9wbpwOUsVaySTYgpAsgRrMkvZWDME4FsX0dXwg4B+vUBTyfFLiWB30z9vkRM1v
 uUPAAK8lfXrLzAQkkdYBHQVZ9dQXQWA8CWqqgAPPY7hWKyEZi7SgOFCeKmcXajPEL8DDI78f7
 ffJGGPxx1e1NxbgQ6A80Wbn8krWVuILqcuQ3UXLNuSVAlEPDKZzNoks47HPsOcZxT3XKAhsI8
 nblWsE3AT2JVwCMuU8GC5B1h/61ER3lOQOqshk2KWyer0A22rMIIEdWrTIBCsUOxmDLfmxVlV
 lZv8WV6H8BGtjMfflYae0eT4tbZu7TtU9nyk7nS+Yr9uNvI47VSqUe8IFYginqew1omUNFnS4
 4Neq6upPyZuBAWUD3YYtGNl59kcLT/m4cfZoETrb5ra663kFjIRXasYbAZKtOHqeJbh3WuJEQ
 6bTrycMRsB9sumDKl/50xUZWFETOGODHoIJkmVxvijJ+MzAwkVpCOYiPkm4ZIXHo+v36PjGGX
 ElNBG0/SG9Z9BAXqGD5mDctcUdzsuGJk/vqoW6HSa9qqezVzsjFlHQJBluFTpwiDtmXkvsmbt
 A/8iLYySzJF1II8NEb+WFRSPVT7uVr3O+g9MakRw5zWi5pb6zWWxwrQjUAbuyTaF9ucNDUGLe
 atm88oeTre4tYzVBqjviZk3U4cNYgIJhN1uW1QlJVnfZFLiPlUeaXCJGM8y/cKrQFrLQWIwqn
 xAlOBaG9OR7DxgSI+d1aIr1fVknR8KEMtmoySwgOmEYSeAFJai1rs7ICdatHAUgITRA29tpRc
 7L5xEbLSPqx/34uHeCKlIuMkmXn2ObY6v+AMO4uUe+bsNd3aSUV/LJfyzRtz6B5wELKfubC8G
 oKjs680xnt8LNGxp4h69ELc6wdwdrdgicoKGW3ihQPcuwYfKZA876KjESxtS+aNGOyRi4rkew
 hMyYEXMgNGcGdlnQjaUYhapSixzX1Sd6IXnLKpMNCnl6QvGqJgjDjH/mvVS2WdGiZy15qDx7M
 J2NAWu5iiipTWoubrjy+4QKRSn9tTUWf0xfESKu5fOZEWvJS0SG8A9UIdlg3zEm+3bZ/LINc/
 Tou14l/bGACwbW+Sffykse5u+x+j9fegrarna8hHnJzQ08dZkZOiNvwAbJ9f9qJimpYiPJvON
 /6O2yvl7xXad9LeHRhWoNqI6uMXqjCV0XDfOrSagUUXPXefB1DAi9YfI3V7HbHHwOVNvmRyVR
 71G3NKEQvbN6xnNPAFeeABFDpmRUVnY9VIOc2q9DcWRIEqoyq6hI7ZlBVK+1h4Wsupi+BbK+J
 SAe7QhAXxV4F7uWNjjvUjTTfhxxnF2qNfFiZyFXJfiE2dLe8qJrRqpcVJmJjBzLhpzYzHRw5O
 k2DjWOGshd4r5ff6VQgNlYpGuLOfR7bkbCP4ugOp3lKiA4YaHNC4Tf2HPVKrUQcNvz4DTN9k3
 P9ecTEr/QF+qPdmoj2wttqo9/uIuN+TMqLRh08CLdQX1yQ4qWr1/c/O0+TthaW3Y9l5wgK+RY
 VtXUI3a9Hfkg/DlRtRL+ZnD7Z7CpvyYB0HH/OQFTs/ob0ADD5KbGy+treHfV0w55Yxt9DfNZM
 s3OeLjIFMc1+0tP7kdFSZ/Kg9/NBRODsmg3FATQ4o5J4mOO2cx4wHQFPitjz5hR25V5CYqvW5
 X/zs9CC5oYMVX2u+LNKx7ZjjVmUQEcy6Pza4uBXxA/B2pMHaySD5ffvb035BpT/WK2FbYCZ5W
 Fawfh8c6MMnzsCdTiowldyodOr1u8zzDV1Ne73v/q/7lq4hsCpUad4vLbmH01df9qaXJJyGSq
 FPht1JA/UH3UaImJahwydSFROZQLxnj9t2G65wZviYIXvJPTpkjJyB92Dh6JktsbKV3E8KtV8
 y3psJsvpqR6fGPhU9pgG7NEPW4x+0FhtXBjdLb7R/uyDQWfEE0O0c5KORiH5K0niRdg6t26sb
 I0t4y6XlAkwwBO9fWmOBS+b78rBPU6x1AgJczL+UPiFTXS8BJBROK/89/DFf01jH5/tBrdrJV
 zDE3KOP8ievu92y13MHX+wYfe+cC6CNw3cseq7RO8LQQYxS7g1MIrplcmPpxE0B25O+sSkWt1
 cemkyLggNJVvGolyst0GMftG1grSe4zO7PVlCOxoav1kRzEI4zDgrWfe0wpwzCkGttnfHIZ2e
 FWh/ynpYEe/GHfh9RdZIyinH/f3icNelU9+Zz1Xm5qPyEwGAFmCjKyCZyAp9QOOHS9KvdhSy5
 TgNXDvT6MCWvT1SQ6X2sXMQDnA32SdYWnXXtJw48nyDW6yNVkFEC3VPjHRfABDhtafZmI6JSq
 o9+Af7Uup1LuZjJaqUGAM/jMxfZEDnKAZv4tJFutkjusBumAZRDuAP0Mhv3VR0/slsU3UikGv
 5uym5EWtgRR9fTtK461afLGG56CU8CPXvfCK16yKtOUORm8M9dz/oFmSR9p3yEbXl+juFzqai
 Pf/nAR3rwknaew0GAHU0jLwUyM/r9WV2q76GFDV8icdnOTx66TJJuyvumC5UggexjCrZqjlRB
 Od4VAd8my9x1Fc3+pO5yOA/XG5zOEnis4mufqSWEC654F8CBNplJepxxBCZY7keaBoud/mXwb
 hrYgSMY8/1UfWAf526S9ubqSFDv8SQDxQQWVJ8QNEYeTBYjyBz6YBbci3J3PP5oXD4VjOaHbF
 VnTVy/6jy3WyFV4ORa9kxCwX8cdrwtpcPDVPeit92/ydjk5gyfzuIka1GfWiNQIqM+KVo3iE1
 oaJhu+YruBp+gerGr4Np4CmHb3ZzJDPHhYOCy4/mrGGdLwabX38MbwJeJ6WWEbENzGyn63UAj
 YZFhSwJenfEHftSKis8O9nHFRCTrXH63PBHbtoXWfzkwnqphYV/vboCMDeIHfwsAg/hg3TqbX
 vXP6vdAL2eP6jMOdfUuFncGqCiXICAhiT9zJxe5fiYR0+JRrMHz5pGL878xU+Q798HLKRg+OK
 Hl5xZUWoKR9khaYPEr7Lp8WnOG2f6Xro9MBtK/KunWXMYY0Y+vBW36IsqCp0E59q/0CebuVT5
 t49i5vcL2zK43znMN5889ccIxuc01qggUWtt8S59BDc61rLtANbuM50PJWIjq9cvUOI36cc1x
 qKCFIXO6jmd+AQJ5L+1g4soVGUojcPGE0IRLw2G1Hjt0vmWHLjEHE0fP/NuPox9Ol2aDszqgH
 l9uXav6Q52vajD6baDi2MhNXd4d8Xgj6pRsKRWGRBg4Q4j7b7W+Nym8XO5zi93A4+CoAn1Jf5
 LwFkmnmUV5PHkkhlk3eES6CxqyjEMcLu8VmIRPo/j/UNysmP8IKDFXgj4vP38X9suYp+2N2jp
 2pnzWUliSKsaI4At1VgfJBrqcrPne45bm0lOISuNTe+DZDzBVRJqpmPg05fU/hAleGqR1mIpv
 KCNMjzfN30IbeYz1CmahWc+S3ilMHWxT+7VKaxhzi1xgD58Amye7/27LBh0ngz5tIdiDijchM
 nKATxsT/bzf6pR2ivZR0/RM9xWru200gb5Vpoe6o0o468Eb1XWsLCtxNusPMOSjBOy+h8Low=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21264-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,kernel.org,vger.kernel.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 9C426C415C
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/1 03:46, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Jan 31, 2026 at 11:36:54AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2026/1/31 10:41, Boris Burkov =E5=86=99=E9=81=93:
>>> On Sat, Jan 31, 2026 at 09:04:03AM +1030, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2026/1/31 08:13, Leo Martins =E5=86=99=E9=81=93:
>>>>> On Fri, 30 Jan 2026 12:49:55 +0000 Filipe Manana <fdmanana@kernel.or=
g> wrote:
>>>>>
>>>> [...]
>>>>>
>>>>>>
>>>>>> This was before a recent refactoring of should_cow_block(), but you
>>>>>> should get the ideia.
>>>>>> IIRC all fstests were passing back then, except for one or two whic=
h I
>>>>>> never spent time debugging.
>>>>>>
>>>>>> And as that attempt was before the tree checker existed, we would n=
eed
>>>>>> to make sure we don't change and eb while the tree checker is
>>>>>> verifying it - making sure the tree checker read locks the eb shoul=
d
>>>>>> be enough.
>>>>
>>>> That may still be racy not just to tree-checker, but with the extent =
buffer
>>>> writeback path.
>>>>
>>>> Even we locked the eb for tree-checker, but someone still modified th=
e the
>>>> eb after tree-checker but before submission, it can still be very
>>>> problematic.
>>>
>>> Agreed that it feels very fishy, like we can write an eb with bad csum=
,
>>> much like DIO and unstable pages. But do we think it *actually* matter=
s?
>>>
>>> In principle, if I buffered an eb, wrote total garbage to the disk dur=
ing
>>> the transaction, but then during the commit wrote out the correct eb, =
I
>>> think that is still OK. If we crash, that bad eb isn't reachable from
>>> any root when we mount again, right?
>>
>> Yes, that's correct, however still I'd prefer a more consistent behavio=
r
>> that doesn't introduce any bad csum at any timing.
>>
>> Causing temporary unreachable bad csum seems harmless, but it brings a =
much
>> bigger opening, that may or may not lead to bad csums for valid tree bl=
ocks
>> in the future.
>>
>> [...]
>>>> Although before all the new ideas/attempts, I'm wondering the followi=
ng two
>>>> points:
>>>>
>>>> - With the AS_KERNEL_FILE flag, how frequent we're re-dirtying COWed =
ebs
>>>>     We need extra benchmarks on this first.
>>>
>>> As far as I am concerned, any amount more than zero is a bug when you
>>> consider it from the perspective of the transaction block_rsv. If you
>>> had an 8 deep tree doing splitting, then a single re-cow you didn't pl=
an
>>> on will use space not in the block_rsv.
>>
>> I also have one question related to the exhausted block_rsv.
>>
>> If we COWed a tree block (the old is eb A, older than the current trans=
),
>> write the new one (eb B) back to disk, the space of eb A will not be
>> available until a full transaction is committed.
>>
>> But if we need to re-dirty eb B and COW it to eb C, shouldn't the space=
 of
>> eb B be available again?
>=20
> Eventually, yes. I think the details depend on exactly what happens with
> delayed refs. I haven't looked into this angle super closely yet.
>=20
> Unfortunately, Leo and I could not think of a robust way to wire the
> re-dirty cows to the block_rsv in a way that does not double dip from
> the block_rsv. (See my reply to your next question for why I am so
> obsessed with this...)
>=20
> How do you tell apart this sequence:
> I start a transaction that reserves num_items=3D1 (reserving for <=3D16 =
cows)
> I am doing cow in root R (cows=3D1)
> I cow down through node N (cows=3D2)
> I cow down to leaf L (cows=3D3)
> someone in direct reclaim evicts clean page of L
> I need to read L so I release the locks and loop
> someone in direct reclaim writes back N
> I cow down through N and re-dirty it because WRITTEN=3Dtrue (cows=3D4, W=
RONG)
>=20
> from this one:
> someone cows N
> someone in direct reclaim writes back N
> I start a transaction that reserves num_items=3D1 (reserving for <=3D16 =
cows)
> I am doing cow in root R (cows=3D1)
> I cow down through node N because WRITTEN=3Dtrue (cows=3D2, CORRECT)
> I cow down to leaf L (cows=3D3)
>=20
> You can't just save the "last cow-er trans_handle" or whatever,
> because after you release the locks and loop, some other writer can cow
> down through that path and it could get written back before you get
> another shot, so you wouldn't see that you were the last writer.
>=20
> You would have to track which ebs a search_slot has already cowed, but I
> fear that these "track the ebs" things run into the same issue Filipe
> raised about Leo's log_transid in the eb idea.
>=20
> Probably worth exploring this family of fixes a bit more though.
>=20
> We could consider an array/xarray on the block_rsv for ebs that block_rs=
v
> has cow-ed? I will have to think some more about that. (linked list is n=
o
> good because one eb might go on multiple such lists) We could
> preallocate the storage when we size the block_rsv too, which is a
> much better time to get an ENOMEM (start_transaction) than search_slot.
>=20
>>
>> So from the perspective of space usage, re-dirtying a COWed block (in t=
he
>> current transaction, except log trees) should not cause extra space usa=
ge
>> except the temporary usage before freeing eb B and copy its content to =
eb C.
>>
>> It should always be the space of the original old on-disk eb, and the n=
ew
>> COWed eb, no matter how many times we redirtied it.
>>
>> Or is the problem exactly at the space reservation for such eb B?
>>
>=20
> Yes, the problem is the reservation done at start_transaction() is not
> properly accounted. See Leo's original email for a good explanation of
> the details, but tl;dr:
> btrfs_insert_delayed_dir_index was seeing an ENOSPC migrating items from
> a transaction block_rsv that had been exhausted by re-dirtying
> accounting an arbitrary number of cows to that block_rsv.

OK, I see the problem in my idea now.

It's focusing on the pinned bytes of the space info (aka, global pinned=20
bytes), not helping the block_rsv of the transaction.

And I can not find any way to improve my current idea to handle such=20
situation at all.

In that case I'm afraid breaking metadata COW is the only solution.

Thanks,
Qu


