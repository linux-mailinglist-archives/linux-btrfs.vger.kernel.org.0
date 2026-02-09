Return-Path: <linux-btrfs+bounces-21533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMbECq6siWndAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21533-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:45:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F03510DB14
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11EFC30086FF
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68A36402D;
	Mon,  9 Feb 2026 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uMZCicxt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B1258CDF
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630273; cv=none; b=MLJI+200k+b+cb+xJ/M9aH617Wbc8lGBMI1MTl+UZWuBP4sIkyl4SUVkBowQaOhTwlcy9S9FYdQ4HryJpXDT2rpkUTiwYxSRFm0UBofFoQsk9aNDXPI6D6RZUF8ZeRdIdN4JndsZ2L0l6hpUeGh1PWHqNz/rZVmmip67gn47Xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630273; c=relaxed/simple;
	bh=1OzwvGfE7ux7jLzP273ZziVMqt77l6PNFv58CwDQApU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds6tkCjeW2hif5iMQhvHi7Bx6FAZnbt1eFPeWNHbI7RORly209IqtexNBn+wuGcq8K+OD+WqzIj/HowUczAExg8fB4EdKdABPToiKjznAUYp61ioAFoiCOFwzOqNX4F0oHfU5SrUXiwBF1Lmy2x+LFggYtZ4B0N/Tc5Kff41XQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uMZCicxt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770630270; x=1771235070; i=quwenruo.btrfs@gmx.com;
	bh=zVFuYrxI+XJD52BU7VVWtXTdY4BGuOrVKo1pBVlq74Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uMZCicxtr3GFPUPVsi4E7OynkJWevZSroCETWFUjaa1ye9HZhVWbj/2xtywFgMfF
	 DSn3EdMXihaeDd7eOLTFznicPG71ESPwp/8B7nSnH72GTPBsgvqBL6dPnZH7yATab
	 x6VY4qaLIF/USdyWF9juAeHt8OnGWLZylt/8AF4ANVnf4CLnCA7Zl2M2JYJGcjCMP
	 /jzwAWghufoLV9Y0tKrsx9MiqHpHGAhCVBLO1/3Q7Sk4kofCw84xfZYy3S+xR6XHy
	 /6VFBybjmuLHXRPPxwOBo59vmFEUGK8WWVyXi7I6nPjzp+zZ1aQ59FX0/2JilnD38
	 s5Nonuqgd1eH9rxM+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1vFm5E3har-00nNKd; Mon, 09
 Feb 2026 10:44:30 +0100
Message-ID: <a02158b0-79e6-4aa0-ba0d-7bade437e103@gmx.com>
Date: Mon, 9 Feb 2026 20:14:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix the inline compressed extent check in
 inode_need_compress()
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
References: <3cd5a484ffc3d8a499b062cbda89793d560b85d7.1770607799.git.wqu@suse.com>
 <CAL3q7H55JWn1ehjTWHg74hqd7P2pSBptcGO4XoFjkBuhqfBQCQ@mail.gmail.com>
 <58b91c8e-6728-45f7-9de9-11c1b3e959e5@suse.com>
 <CAL3q7H6dpXiR9dAXZ+kKXPMbrUVL9qS6E+Nx0Cfrrm2wj4Gshg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6dpXiR9dAXZ+kKXPMbrUVL9qS6E+Nx0Cfrrm2wj4Gshg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VQhjPhuOoVfC8sNojh/R+PCgub2naV17QTdlxmhBcAdOrVfacpX
 3QBq0pILQmxii0/cJu0LtgtN12EJpNRYXAdCPX003W72xFfiE+DzAX+A+4TWT0ZwdeanRnP
 ZNyX3sZpnF6Lqwn8MbefA/UTjjkiS/veLtn5g4Mv8yE2DpxVwDbJ5QSmWej+dbVY9cea4ef
 FVd/Etp9iKirXy2IiqJqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ntx+HDUc7xE=;+pSSDNblqzOuW0auonnrAy3ODTD
 rspRyYNjRBNmuk8QJErgjBoTqiyroiz+RNNWpXDyF0j/m6VsAWdTJeeWerFsgN2+3JL/j2zzN
 yh7yJ0KJLkHcPS195JZpZRidPjDGAKiQkkMnmV8wzNvTBDLhHpOepFXYesRf3RYuApiYBTHPE
 pD9+AVLjZDHX6GdVPZZU3tBRq8QnZ8EmZM+bgWnFBmxXu7s+Xr/Gg7I/slEcLtdrswCSpCcae
 Z4ZGwhzB/H3RgFkW0VB5Qfk4qhmtyAs27KE6FujCHVO5HdLgDXjuXg0IBrsWuhTUyeWQAtZuw
 t+kWNm/4YRWJtNi1+1/0iNHfVuvn83pZU/fNnxp5dG9hlxcujMo9xTavbqoFIvQr+5sauohaR
 9vaR1J1xjY3CGYcHd5Qer/NnutFXrHjfBkmV5XVW//bz1WhxlO3AcmlJzJa3zk96NWNaU8vXz
 CFHjusoE/5NnaIjXc/bpf6+121Pq41ndFOJ1hJzicsMp1knrwal3TV2vgsTatMiKlm54tLiVc
 dPi0H+YxvU7KitmM3J6pHJIkToqmnvHmBnfwl4t3qsSAXBMN7Dc6ZQBzd1USkIZOJe2kbGBPV
 bleThBdKn89fAkqdkvINGYVqWXVNBIg6S4/PSWRHVt0zAijfY/L2JwSfyr0jZCiYozC5Q7uFY
 rVQ2ppgrIGZpqrDC9fQXLsGhLdoAUHZOWBBBi7qfbVooiua+Qq4f9xUbv8ZPzaw4BcvgdZ4fk
 MC8ZKT7Dclx+r+vQ3b1f/n+5D6aWFROXzXgVj3IJoMUbWV/3dk7bgAQU+OSfxEmqh7hmC0jR5
 NZvXDtSnrqiyYbHxmP7OMRWPnUk4vHo+t34EbfEtEbkao6BNQ5Yv4Xg6cPdBEDjz23Ch764OM
 elu/2N5E1zB8R3Tco7FHdnJaPUldP81g2lBaJKeoD+sPEHtXYibh8FaIUBQ8PTgn/3ivzBKk6
 aNBkGv59D7td+cBkWWerZTAY8eyCIuZJSLlqPgr+Mlavo7977q8L29WsiZJqG7HOEAfj25Su3
 giiJ+MwKtTULQEf0YgHYWLR2b9kKJ1dMykqPKKp6/hqrPFOrq0/ajDsgPkJhzLuOKeUPmegoT
 UpQx+Li2TUWKWqlWhITvzsb91A93hfkLm3QVEMh9RLD+rjib7Ho7HXnHPtu2gKEh3kt6DbxL2
 fyJFd34weX048kgDZpJJ3xqy8hmvlC5BHiZCVVw1rL9xs3SIkF1bJJyb9f4UJ5UazA4lHudHC
 1IGvapBOp5poN3amoZA3KtIO2W8d+Kg6LiRGryhTuSiICJsOLPuvuA2P4zewSyNbJhypBYaWy
 K6EgFCEDCHvSpFXGgL0oFJgT9uE6zJjqZdaL1wFrdgB9JDclhPI4o14zYsOcQybZKAODm2YAo
 mvcldUn4mohd0poN04SdgPuWgEnSECxwKkIt4CqRkFofNO5QyNVZ9EMNCqP6DaC2tgVbKlG2c
 7L6MyeeZ0VA+VdUSXDRbgssCLyQrCOB8LyuuSYQIglbP3cqTf2wpq4pXfhoEfXnEgN+S0doH/
 yjYJWzhKceWN6UyZTlPdX84dmaILRYWFkrdl6wJAwAGiNMgaP81nJvsY3JSMr7k7jsMdyGtqm
 CwecLvaMCta7JEJHeVG+FLFCp36JWgJEXBaLTjelbUZAQ25mMv7qpx6IIYuDcgZlPi5iu9B2c
 CEtrtlkdiCHEF+/c/WcZxE+eRJ9WuDI5ZZXlzawuQcPelTbO3FS2YJIi8Q/i+wM/MKOyDfU8z
 UW+pRIN7yrIXc1QmhcRjQINpC7Dal7JYqPpj/9E/emtzbhhoEgxeHNS6aWsm5dwn9Kymp3Q8O
 4jlN92hrfuKAtpSAubudqo06PKlbx2r7KzK5+hpIn87IwlrR+dk0DmQyKW1RfmRWBbhqTZnNZ
 13WCI4SVzpn0qeRqYoJ+g/zWkJgRQyUM0m+ySGHVnRku0yoq/4y+eV6CNDHN2PyCd1AUM2LH4
 jqiRqpjKPC5GYB7TypnJ+qV+Z5GrrjZGLNjkg92DFlO9pkpo1A36Yz6jjnP71uyI/VpMe0Yxs
 5vyyxwcxEvjTyMQjfJvcTxKwcVoYTMV8W4juLcU/LmxHeHBX2x2DKDqUr+jaDCnCKpGdu6Z5y
 N5I9onJh7AwuKenmsHzoGxoNjDJkgS7Z2QyEj1OTDPCfPe+0CXFo/mRgvGYO0VgQtgQGRNajJ
 +/023Wrw1rORVaLxjBV7qOlIBgvQRi8Hhh/MvKT42NrZPArtgVlqFijPXkrlU6eUYFFJnuEMp
 S/6teh+NJxGTHJjQh9bOR4BnJORPEZh7wIZq7mMPQLh3AH+x7LLqrCqp7zMMX4vBycC9HVVgN
 H5RkCERLLX/shJnuGuGLVpmuLuLHbCe4xJbq0DLIBU6qHSUvEQixwILMzq1Hvov/yoOUgh327
 PdrMftcSJUKnZ8j4eFIlxLnMLnLs5m64aALw4dEfhJWYH+4mJSk7Rl0jmoCQdl4/8Aj5qSBXg
 mDsNN00UA2tzr8fmmNoRClP5FRl7CyRJS5TFCeorN/nykZKCmvQqyGucOLn9+ss4GYA+N3/PL
 gx7lPj19kJymsyv7pzZL3mVzDiRKWob94BbH11LXScM0uq1FcmNIZlZPUblddBCPJwBdLd+QS
 3J7sfnxjOtyA12TAK1OQ5XEedT+I2jAZWzPmF2aL5MMopLCPmiEPaxseJD3i7R8updnayC0jB
 LOOG+KGxLv60fHzpH9LYmQlHlT3fA6+TkvAfWBUWoQksJ9uzPc8ycMhf6i/Ybd8Z8CO4RXIVj
 AuFBbSppEY/Xq3t5IWFUpjhN+EOO3oyIC+QR8u2wSZhSFb5yHzsNbh/YxqXOdUoQgohUKqUWk
 mc3tWR5GHJAeOBA9niEsZ/IxXYLE333rWnaipLGAwOCRbeKfEQFP2yamVV0/SRtWrSAqBBA2m
 n5kt11JpIk60p9KjN63FYToBanmiI/pXNr4j3oTXwzN4Iv1UdPPlhWrs6CIfRTjVNKrel73Ra
 gpuMz0QVHY5si5MJULBD2oSi4s9Az2M7+/2J5EzTxilYjhm+ERlGTIp9sSthbtsEug1HY29WH
 0vap0dSkjFNChfZAhu/JrkzvlgSLi++ubOoH7FwPNq2y45fRk8SgLCXy9/TM34jKXM7MZlmBT
 g2GkcHSlh514HqpwYxE1QwdhuRNbOoZUtoQsJfHIYru9TC/GZo6FWyvfXHygdq3Tt5nF5GRdZ
 wHCEXoglpRsu5xtOoU49vhSwLKWyx7GaUK+cSvlAy84UGE8bDW/bkqlYMiZb+2UtykhK5pocy
 v2ltz2O3hQorwVsNlKXZyAHH+DWn9pa+AUxlQAgRR4nBZyBGv0W9QMgt4zFG9MlenKxE7GPoq
 YEzSvDCM8V+hUdJjhyZM1RDS+7hEdEd3ZWG0ky4XVIq+Oa5u6i5Yvmt3BbmUURkiHyNa2V8yX
 vX9k+Yqrh5YhpYCa1StnyPzujRKXmjjoJwL00rk5oqe3q4VY23S40i3cW3Xp1ujjYPFz5LPAw
 BTZQWEPPObj7wdXIioNzlhfs1F15WL8i3Ag4ttyTVlBwZIIHp/vbYsRvLorL9NxVo0jH1wNCN
 9uIZTAMoAmbhI5xqiyiJB1vpUq2uJzHFj+1+2qy4NrlJ09ygjFULWOj9V93Y/grXT4c25At77
 JP49n+1jnPo95YF7BZiyKukDQvhv/C8qPGXMQT5CPmVY4BTVG3Paq1voZWRSQqyKpG2NK/AZQ
 BCmnsR5UbmdrMDubZ6T0Tm/jVK1rfUgzTyxv22c9r82n/XAKQiqwKY+uxKcjNSA86Py7rhqYJ
 86wP3suoRI83LbggsavdpvaUtk4NW4BzGG13WvIJLmryBCsXa+DZXJfqGRu7wZvt48Q4smeql
 G5RPH6t9BfiqPcp7hyrgqvqDm6pkFlEtUcJTePLeRkyG4VduG9sFZ9Oy7BM1enfeIy1lt33eo
 y2nUjKx/IG9FJGre2Motbpc5r1G/dklQ0D3IOSJP2TZ/OCJqctGPvhB3Ijc1ZnCpxiuFJi7f2
 BS8C50G4b+S78cr4DGlf6Vzf0VbTEBHyS7TLfgNTHsto/acpBkZjZ2jMGdW4sLc/zWUi9a/BP
 uyJpezUYuwePvscMLmms++AeHRNYaX7bItVKYdZJD8jfTSB0fftKWKGQtAY9REUwQPXnsjYPL
 2+wZm0c8KhMChUQBYbLnkjaBt3RpeiTzooaBQUjcOk30GDfx7ErNPA2h9EpUptqhoYH+ZFjbX
 5a0cbxLASvlHC0JLZrq1LZ/vFQ6VzRxvHYPp/AeO6emL20tmyrae86/7DNGTW7SkYmN8KiT0m
 7PhvjvaJFGvt0sB2aiEyrnD21iEfC+Hdd9X0AvOkYd/ZMkb9ibOAHMa20KPFMjsFErmsUIPEr
 CWvhVAq0+F7T2rsyEuo70hXNbs8DD7Jr8ItrL7ft4USLWcG4XTa2L5vO+YAMw3Wt4p0MEqn8Q
 wdLd2P4qoNj0TleERqw740VMW11RUpYmV9xFdNbsR3nvzmWX5pf4//top6Z0aF81e3xgZ1wWw
 f1NHKoxhzAnie/M+9lggzcQx7GCFERWwNDepIPpTe602RH0uz/gXXcVkbAPCG0wbSGoxcE4LR
 wpbORywdE8fVjIt2nO+e8pQRyrzJ5naGQ4zSFAeTapPed24+9jK2+hWv8gajdQUsoRzc0NGU8
 /av7s4Y/vKYw4zsV1y+Yic0WVjDnqUkhQusTI/2w37MI9wkj07DU9dLtUg4HYBiLVOCMxR74j
 AG13bkEF/Tzd8BNT5yFonBa90WjT9S0O5u1L4rBMSjraGbEChQ7HLDGIWZxh3IruQza0j+v5k
 EGCPRPQFx2QygpRWTaUbeuWTjoq0C+Sy2tve5PkSMcWA0iG4yAvQDJLXzv/Ac/uD9eOHjsGfj
 aHdznXpl/ZdmF232+M1pYBCi80LZB7NwQkLQf8p6/WYDx2J/2Uo5ZXRiwmSqWCo1DH3E4HJZT
 BQUy4IS0hDaQyHl1dacRkDl368a0+BWQqoj1I8w8PHpdAv8nfDAidgrrdSzb4bV254NU0b/0a
 ok/ud9itTJK3CxZl+Ht2BMh0GFQMFnyDuZiiuzx+DKEYwdevO4gi/92hLqTsg3EUOZbkK8Un6
 XhiPdtyeEj8mSVNyocHKalHlRzBfwD9APNyqPmUj/UsFOzcZ8ACv2NrXNMaM+yZhPgF2vaKjz
 QAHCdTreNgNgR0Q1jWPIQqp/rkU5xT78o/IhISzkannxo/pcyveG8WW8E5VPi178ScZJWu4q3
 sa0LTe0YSqwDVRVioUlbemrqWG4QPLn3WlrUV2GVt7nB5T+17ng==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21533-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,meta.com:email,gmx.com:mid,gmx.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F03510DB14
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/9 20:11, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Feb 9, 2026 at 9:37=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2026/2/9 19:55, Filipe Manana =E5=86=99=E9=81=93:
>>> On Mon, Feb 9, 2026 at 3:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> [BUG]
>>>> Since commit 59615e2c1f63 ("btrfs: reject single block sized compress=
ion
>>>> early"), the following script will result the inode to have NOCOMPRES=
S
>>>> flag, meanwhile old kernels don't:
>>>>
>>>>           # mkfs.btrfs -f $dev
>>>>           # mount $dev $mnt -o max_inline=3D2k,compress=3Dzstd
>>>>           # truncate -s 8k $mnt/foobar
>>>>           # xfs_io -f -c "pwrite 0 2k" $mnt/foobar
>>>>           # sync
>>>>
>>>> Before that commit, the inode will not have NOCOMPRESS flag:
>>>>
>>>>           item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
>>>>                   generation 9 transid 9 size 8192 nbytes 4096
>>>>                   block group 0 mode 100644 links 1 uid 0 gid 0 rdev =
0
>>>>                   sequence 3 flags 0x0(none)
>>>>
>>>> But after that commit, the inode will have NOCOMPRESS flag:
>>>>
>>>>           item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
>>>>                   generation 9 transid 10 size 8192 nbytes 4096
>>>>                   block group 0 mode 100644 links 1 uid 0 gid 0 rdev =
0
>>>>                   sequence 3 flags 0x8(NOCOMPRESS)
>>>>
>>>> This will make a lot of files no longer to be compressed.
>>>>
>>>> [CAUSE]
>>>> The old compressed inline check looks like this:
>>>>
>>>>           if (total_compressed <=3D blocksize &&
>>>>              (start > 0 || end + 1 < inode->disk_i_size))
>>>>                   goto cleanup_and_bail_uncompressed;
>>>>
>>>> That inline part check is equal to "!(start =3D=3D 0 && end + 1 >=3D
>>>> inode->disk_i_size)", but the new check no longer has that disk_i_siz=
e
>>>> check.
>>>>
>>>> Thus it means any single block sized write at file offset 0 will pass
>>>> the inline check, which is wrong.
>>>>
>>>> Furthermore, since we have merged the old check into
>>>> inode_need_compress(), there is no disk_i_size based inline check
>>>> anymore, we will always try compressing that single block at file off=
set
>>>> 0, then later find out it's not a net win and go to the
>>>> mark_incompressible tag.
>>>>
>>>> This results the inode to have NOCOMPRESS flag.
>>>>
>>>> [FIX]
>>>> Add back the missing disk_i_size based check into inode_need_compress=
().
>>>>
>>>> Now the same script will no longer cause NOCOMPRESS flag.
>>>>
>>>> Fixes: 59615e2c1f63 ("btrfs: reject single block sized compression ea=
rly")
>>>> Reported-by: Chris Mason <clm@meta.com>
>>>> Link: https://lore.kernel.org/linux-btrfs/20260208183840.975975-1-clm=
@meta.com/
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Fix a off-by-one bug in the disk_i_size check
>>>> ---
>>>>    fs/btrfs/inode.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index b6c763a17406..7b23ae6872fc 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -811,7 +811,8 @@ static inline int inode_need_compress(struct btrf=
s_inode *inode, u64 start,
>>>>            * do not even bother try compression, as there will be no =
space saving
>>>>            * and will always fallback to regular write later.
>>>>            */
>>>> -       if (start !=3D 0 && end + 1 - start <=3D fs_info->sectorsize)
>>>> +       if (end + 1 - start <=3D fs_info->sectorsize &&
>>>> +           !(start =3D=3D 0 && end + 1 >=3D inode->disk_i_size))
>>>
>>> Can we avoid the negated compound expression?
>>>
>>> Instead of
>>>
>>> !(start =3D=3D 0 && end + 1 >=3D inode->disk_i_size)
>>>
>>> Do
>>>
>>> (start > 0 || end + 1 < inode->disk_i_size)
>>>
>>> Which is more straightforward to read, and it's what we had originally=
 too.
>>
>> The problem is, I find the original code very hard to read.
>> It takes me quite some time to understand it.
>>
>> The negated one is more straightforward, it shows exactly all necessary
>> requirements for an inlined extent:
>=20
> For me it's the opposite. When I read the negated version, I have to
> convert it first to the original, non-negated version.

OK, I'll settle down on the original checks, and hopes the next time I=20
check it can do the conversion inside my head.

Thanks,
Qu

>=20
>>
>> - File offset 0
>> - Covers the full file size
>>
>> I don't know if it will help to introduce a short helper, and make it
>> more readable like:
>>
>>          if (end + 1 - start <=3D fs_info->sectorsize &&
>>              !can_inline_range())
>=20
> Adding a helper is just complicating things...
>=20
>>
>>
>> BTW, here we can not use can_cow_file_range_inline() directly, as at
>> delalloc time our end + 1 is always block aligned, which will make
>> can_cow_file_range_inline() to always return false due to the max_inlin=
e
>> check.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Otherwise:
>>>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>
>>> Thanks.
>>>
>>>>                   return 0;
>>>>           /* Defrag ioctl takes precedence over mount options and pro=
perties. */
>>>>           if (inode->defrag_compress =3D=3D BTRFS_DEFRAG_DONT_COMPRES=
S)
>>>> --
>>>> 2.52.0
>>>>
>>>>
>>
>=20


