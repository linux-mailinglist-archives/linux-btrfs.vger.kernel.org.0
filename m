Return-Path: <linux-btrfs+bounces-21898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJQNLvognmnOTgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21898-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 23:06:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA218D08B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 23:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A3A3066BD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A1134252C;
	Tue, 24 Feb 2026 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OXbNN8VT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A133BBB1
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970728; cv=none; b=ogUT6i51Ed35iUOU6laXzx/M5/CgFQL8UVah+5bEQdP41CjHaDA34GdhbmYJpGT2qsrhHzfC8n/BQpYgKm+yUwc1PA/NSkQ1yw2Hn08qChGi9/cXwFp5AfTJt/1NSEvRXocT6ZR6wGaKmRsB0ykYCbQvNGusE8B9JoU3paR4drE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970728; c=relaxed/simple;
	bh=smQML5QzHsm3qeuhcTs9UFiHV8+fXBdV4L4DzH6iKa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tTTeH2hT0tOam9cP+Ybtuy2P7QnKvjAp5h2zou0aa1+/HV4wiaq+p8dRR1FAiSUxIp6dj/YuR1BHgESRKWFvORKZYYg3exR+Ky4PFQ55NwNwL+3qUjRPXVEPtyCeg/5LLL7s1zoFOVKC9HpIHZLUlAVZABmzNSMIhRNc4Wmo4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OXbNN8VT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771970724; x=1772575524; i=quwenruo.btrfs@gmx.com;
	bh=smQML5QzHsm3qeuhcTs9UFiHV8+fXBdV4L4DzH6iKa0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OXbNN8VTBN72la2L0OVAgghpBzWKUFWVfc8uBf3hJe5WWqMl5ZheNgx/7Mmuw1E3
	 IAYK/OdKFSx5Kirbl7JjOxANzhmYhC0W1xLYzBTrm4SuA0ugncLsjQAeQ8WHKdiiS
	 Q4x/Dh74LDINp8DXjIfx47bP0HHWptJiPNs3gPDdXCOpYZnZgDU3MUAgk6xpL7vzy
	 kYaul0J9hEVX+GZJw84HPI2UvD7slTyE/pyhi5gBg7BpE/flEyGZNK6MLgzIOtccS
	 3GbVQKYOgT08CI+rt/2vwASyLR/zz7inAU7ikPhjsWcr8NiGZBJynV+E5t2uGS7Sb
	 1TovngX4JE9qbXKJJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDEg-1vUiBg0jC4-00ctMr; Tue, 24
 Feb 2026 23:05:24 +0100
Message-ID: <77158431-2976-4f9b-bf3f-003fb2f7846b@gmx.com>
Date: Wed, 25 Feb 2026 08:35:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do compressed bio size roundup and zeroing in one
 go
To: Anand Jain <anajain.sg@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <5d98d50379077b98164f3b962ada7b0526e1d4bb.1771544612.git.wqu@suse.com>
 <92829df2-8c66-49eb-879d-0fbc1cb178cd@gmail.com>
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
In-Reply-To: <92829df2-8c66-49eb-879d-0fbc1cb178cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hl3zZHHqaE+QXY7tjxbCTdTOyWTQrbBcNvTG0QSrT6ecNLm0x0k
 hc1baAdquMOa5DUylfBM1yfTyTF/ciNnPc2BqbrFQJMmyB18oIFXEpDfXP2VakpWNNzjeRD
 86TXipg1UfYscckfAtsieNv5yTshOfpTXtVGg0PgBB8HTghO83MMrXGorngr6kIRZypFzWO
 b9nAJO9T05b6tUeCGsS9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nIIqhk1JnIM=;8M38uRCi6w7gR22mWQ1sdL0N0UR
 VYehC4lLncnCjJmOG5glON0o9nKa83xm6vBYXxw1YAuTlSrYqFNG/0Zby83mhDkNMTKNKo3A+
 WUopBkEBaIMaTbahyGYD7+zJL9P9xwZrHrKs9T1s2uwyxdIMz2sYiNtd6bVTHgHuzKobFPtgP
 amwD+XyYPALjOfVN09lF0zrIo6xjiQYtNTA2t35zqC8LUWrHaDbFll+TyapcetxpdejuiIWWT
 Pzo9J7JR9nV5RZRzuCq0UfRWVMsQ2hCKV1r3zcPTBy3gNqU7naZwuVmNXmLX8SN5WZmigSZY8
 RcLSiFCcpUvdqPO7mJOcFa9U06y7palLHE7pEnyc+T7pXn/hnr2Z1LnT/H/UNuKTlwc+Wajnk
 fLvFtsVtIcadxodVGOZrcIza/2F01AF9wvZPZ1O96DqZj9x/fv2bvpQxp/7tlHaqcLp1p0u5d
 UEgR3KLAV8ai5Iw7TWL07Qb/PKO7czpyrHZb8Pvsl6Iar76AWBsE6gnAL6a1TOBmbT3kNLFS6
 gk68AS/EPmRCl8rWjkV0+IvumvfYJj1EUI8AaM6Qo9F4LOVCbm1Iowi5VxmKs7TBccsQngKC1
 aXyR5phPid6cS4A+dD8i+gD3tUFqijxOGdFVVbejC5wRDZEBeq7IEcs+YY4IBx3i3I1ZIk2dn
 zGKjxZeAfRpGkN64/mB7HDtTK83ZW+KybkbOx//s/bxlyPJQ/5WZObOO06aW7CFbKR3iu1RpT
 wI+kKepycHl7MG3pPMcCLg2/KT66YbQDGvuEhE1QaKvp1hNKH6kh9oDrWjamslKnszGwXMNz7
 6jfh7KNFKNQAPUfDD01rcmKWf3BwN2bvzztGXUgHW7iGBv5nmR47doZFtQs0b4PU0HK2VlSGo
 +wC3fVYbZD4K7uHt0gJWV+Ev2e/rZNy757TwQzclrE0U9VF8v0J8/64jPapVEW3pDzDSQOmSG
 1Ryyvt7b/4ZTUnSrhCBotUJ9t7yVjF0J4CStFw4WD0/yum2QW46KFGvqhln2hPVgUGSoAQkQ9
 qz0Lt/XHJ5h9oByX+4tec1hZ2qqPgCdM+AHgITcq1kG2J+VKvy7kNGA7+Qm3rSHleDU4qYmKX
 tKrl9TV3ql2FVTL+YZ+9sl+FGDCKawkuDoZ74BfODrgZSuQGLDznjpV2I0WYeDzBAQopvRJpO
 DPmS+ZORgadrME1eymQQlCMt+untd97wmLd6dxUOZkviVzxH+krBrW5Tqdsojxr1GiExJJiVL
 HGLjnhnoaXAMp6wp/tIwNWc00ZbvDsFkmcpolYfMuwKCQqHF/40gLRTpCkFfAf8ID/3LuLaFi
 widM84zw+InF7boCHqakg6S0bUyhd3zjpSjrqlFuuyLGv3VOkl55L6QcIVYrHP0XzPRa3kV3S
 4dDFjWU0nzVruqNT4tFHZEsRcX7NVl0IdfYqjoaLzAdRDRlTMQKgUdPMt03MZ/lDdh+QzQawJ
 6GtGCiGLvSxeqBaB47O+086az/sOlJ02XbXsZjHv/T8Q5sEk/OzuzzuBKI7aRDb8wyxaX5xI7
 mW/5v1iK2WxzGgu0Qj8cQN2EOw0LDF7ONLGunPP/xtRtNyLizTbR/ezIEFherKYLU0Y/N7uC4
 dQh4rYBcVJ6pS8xEcBRaetglTooAU8cEosI7EijOBGHW0F0OXu3yN1yt63+qUQbYtPjf0wPCo
 lGRAiiNqkv/CI90hA4oQ6QNJv9UWLQhrMCjA/b1l2/fkCidAnxOtTMrtyQeqU4ZM3T9nphHfU
 Xx4dSKLT7guT3QXDExJXkEA2qgLFXUzq8FUqHD5/TG+7PEBJ807Ii1EaeW3yl3g8MAX8v6l/R
 2TEfIe+RBrUOnRJbDS9f62rUN/aSziKUboyUuNTFaPwOlY9TX4ptEmBZ3DxHoPemxbRFkhTfF
 8EULA2wvW7ZSfnhc45x0353Zjb6JuKV071cbUaH7CXd+Si7JBRyQcZJ9iifpdSe+8o6eIgbWC
 M+lwbWdOFNQTfI3x14VfXZ9PrFXbmP8Jp1uXNjaKaQ5Mk0r0ek0WBnUcYbn+A8g5Q5JV6FysV
 0ZvqLmzB9pc/yqd7s2MPf0Slt2QT94ushgDAoVXcrm0dbV0QJEf+YKo/hPvzyMjBEy8iQhZ8t
 45J9XN9f7YHog86eDVCc7bSAuz6MdHOhY+YyCH2r1crIZ5w4qjzYLsf4Sz+AUK2x5jU4fN95d
 ng1Y+d5PezWCOesi2SrrsvcuKWCIPk1y/s9DAIz9jC6ZCkaChRb2XUjfYXcvogmb42X/BPGuA
 G+myxmz6A/+bVGvMrd3YpcKrcIve1iAD8llrU1QzoRN1nqwU6aL59TtwoH1cq5EBzMR/oJ7B8
 +/WWpVXBKKkzZzUY0egLQXZHZ4ewOfZtqyal6xxkGo/B2dhB1t2acOr/qX7x4wHQkX9ji9s3O
 HswztsF3Sa5jmkoBkd1P0Kpz7tVO7RXhA1FvQQA7SXtnD9jmJfgk9kj4uZehjUmGz8IBDlAGF
 w65M60q+nAAMztdloHSC+3r6syNsaSl/rl3URV1xljzA7c04ue08oM+Oc/py1v/lh2HnVc8wQ
 U1Ty7fVFaN+3S+hoWz4wawfY1bikgoCsmU1KlGFikXm5W/XILG69cdf/+phn/XYYRcuWjWCaj
 teBoZisApBqVfloGj9bg63anIinvpm2rJvGFKlEdBY7JjhCbRbRbv13T4+zh2nCBncRUNR176
 JCPKnXYknYhxXFfS0MrLzxM93D1klyDqb/GrgdUhRfKY9WLSbzemo1Vh+EvNBkjssRquHuigP
 8zzYeg7NKotPjqqMPnv4lr1E7R/43RZ8A9c6bxUdhY0M+qFZf/SBmaCpxpL8yro61vWq7EExn
 ZFbR8mrpONKJaho5s83B3sZD1DSljGL/mKSTrdggM1DwdkAKXzeF7okF+y67sCwsAg69LpYAH
 fegQuU+cvzvhQYoR/TyQAjKqRole5C2JTD7C+yWnXJii4Twew2tGBj0XXV0VWtOT2yed8bTFK
 3JMi5LKYlNXJCNCRLjytJATZS89231MgA/sVHdNGoHLtOpCdRpd7Yqe6Wh33O3zOYFp2+dApu
 8tDmVWcKhJx4nOLS0+m9p30AkIAVOU9KrP6R5mef1SJdW/PW53y9RuHkSdRcDJjpKKgDKhwIQ
 g4kBDmYreCK53ONh48cPb3Gz3boLU+NObJRqsTHG3sTBq+cQ44D8uqBGOdS2RFTXgnw2b+WvX
 IMeeyOskbKJjruZFWO8n6BcYTPq3a3tWRZ8XlxK3jdtRup7Q/HdMedfGbNK+d2u9J6bg7LC2G
 xxFev30/VjSGf3BchX+lxY8Y4xsLJIXFTHaFh/A+LEly/2Rk8B6X7u6CqvbyryyfWHcoTE4Mf
 P9qiIa1r5jcTkMxwljPtbfSKcLQq0qffkQwl6C1CfkgkN+uO04oZ+Tpil6ledPcC5YdBGZyW2
 j68kMLuDv5DfpUB1IVDC6DKSprZWe8gZW7m/PlVzwSEnnhbH7/SF2GsNlengJJkpxfVAghM1q
 XPwsF5fhnPoQnxT17qPDgL9WaxR2lk9GNvs9SGFz/2+rzn+bra0O2D5+EC9ieLp2fqUSVDXpW
 AdAetaA0Sp1TsoCxmJavPoxUWbaLinCSHGojejYQ4gofQA03RgtIYQ81lwaR5om9CEbxiXtxb
 JZX/4Mr9nj2rmcz4wbz/jcEqlTr8JvTwyyOg7t3EtDAf/3CRuwvGJUPtgupFSIFRtLxrL5744
 MCSW0XCCZYwsckj22Yt0LkRM1/X12d06HFo2hmN7iuPF/BrX+eI9gc0gYTiEa9s6r7UQhSg75
 yXRk+WmDLJ99l5CzsYpHopZbXjuFKrcdz7Fqe8EFzucqCegezeks/PxfDCV5R7Qq6TyGYZ6Od
 si2z2FiluK/hJxpu8H1y5RgFHHszfteqb9JPQld7FfHo1MAorv9xgR8QPGj76cTU6KcsRZPK+
 lzu9gCJnvwAwYGmdCCzZkoQp7BjSmyBqb5V4+c0M+oxsDzU0c6p/nH2EhtRtH+DE3RBC2NUOy
 8vmgzuzz2EiNps7c+hjmpxSJI6+l2JtUXSD8WlOvvHuqOP9MuJkEXbofKKKzwfdHJxL8IMnyV
 NrGzM4yc7rbsIzhmCgXGJ8+QEU5yOOicqVIh9MXmubp5xDcRu6yjDZoo5oLQf5cH31zCsO9P3
 QtfdXI9XFJKqfSWf/hR9ZmVrabPQyDVNIzVGglhVZDbqUPfTs+cpduu1AltPUolbmK1Z5vX8C
 p446kYF8uXjcCeQK4fdbET2itDoka/o6nCfFuuKOW4oGp7Tytb71p2csXZ+FWEif6zYs/EaaQ
 8PYn0/h/ox2BKWoCBNSnLKsHRmr6W/aMGVjv8yAyaoJmzt2nRpnAJ0OK6zSXZaxt50Uj6uPf6
 jsxw9pQYaeZDpl5UC9wFT7cMcr9S811yyOlB/+HkD1wlGS9OfmmPNUULaJFZxAF61qKaHngwb
 ceuUA5huvexaQmSP3RjjmVnOSSLTqmGT7lXvbOfaxU9DPsL7kf63ya8gNAIAI3ISytgLZwkHQ
 qtaM7K3awYHcGD0Lqv9QdC+YxSmM8agzDeoL0b+/OBviUmgjth5SIhXQnYoP9hLsPmPqxrQo+
 Oe18j//dQqSICK9w3X0T6DAh2kw8peCc8CloviTE+Vb+F7mjRw+0GVBWGbgr4I/eBeTZL91aY
 w0goytjCx2KeFNAl86L1B4QqND4SAXrVdoRgMxDM53HNEONJNLW91Ik6hYyUr0RUwZJ1IoLwx
 HHs1VlBsHEozu0CIcYsKPJGIhjb/dt8+paytc1xOVtUB+KqbDe9ca3l331MT/b2jrTywWtoVR
 CbrqwHG3/fpoyrEABrWSXMeZd2tIP0A7bGIwQaeHTKQQImBycIXJPezsd41K5BsagyEx4B1/T
 TZAUWj6JGyVcEnsTZ6jSxpebelUSaUoOJRC9cD8rqGL4w9hfDGmL4FVn/sAM2MHnqjOrO5b4B
 i5Xgu5b0ZL+p7iNxWxCr96iY7CcpLnZusd5Ifk6EX1GprHJFyQnQ3BGv1VGb1X++SEfUt/Kdd
 roDupw5dLLpYAClzKtWH8ECyp5nEOXZ6FgpCQwU2/Rn9gwMaHi6WFh9pPBsqDcrBLUvrDyMbb
 CNVm61ix48gxERksZ8QBohvlC3BQt74MjRS9wd+20NL2ymlsFtWJy+7LC5JVhXCLMoiY08nwi
 JDwVcjQSVpaDyq1NoA5tm84e4tVUvunNSh+TYZHuCVk/jEY3jkb9/JN19Kf3D0/IPPzDde4i3
 QFg7nxfTN+qfLooiRpSDyY7ereIVLJBBht1uXqS7djrdJyQtvrA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,gmx.com:server fail];
	TAGGED_FROM(0.00)[bounces-21898-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmx.com]
X-Rspamd-Queue-Id: 0FCA218D08B
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/25 00:11, Anand Jain =E5=86=99=E9=81=93:
>=20
> Looks good to me.
>=20
> Reviewed-by: Anand Jain <asj@kernel.org>
>=20
> Anan
>=20
>=20
Thanks for the review, and my bad, I forgot this depends on this series:

https://lore.kernel.org/linux-btrfs/a2c390b6c3f092299ed394f10c5ecf45d065ad=
3d.1771363048.git.wqu@suse.com/

Will get this patch merged after the inline refactor.

Thanks,
Qu

