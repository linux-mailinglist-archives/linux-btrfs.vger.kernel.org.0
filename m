Return-Path: <linux-btrfs+bounces-18425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAAFC225F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 22:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824D33B8393
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB632E6A0;
	Thu, 30 Oct 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y+ZIOnWA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7646274FEF;
	Thu, 30 Oct 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858339; cv=none; b=bWKiz3EFiu46od/q62XgqSS01FClUXADKkZEYDUVh4+rcibpGC4LiJB+RYloCEPS1kHXl9CDoVIQFpvv4++yFO21uCEyg6cvXbLoJgTYN2Dot6BMYFunJ+9qxuZjUe9yxQNJIkUc7KeupAxO4ywuTY8LmB5wHi+DIzuopLClmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858339; c=relaxed/simple;
	bh=Q0jZ8IZW6wZIVS8CZ3IqZ+++7UbtuChpdrRJVQqgZsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U35MZyEdoYz/3/9jNE7KvZ5heGCXZPp0mbr2Slkwyp9VleuXzkSL/dZq7M9IaIDUkDptuoKuP8gdeWEynXk6ZU7ZdFxxUSdofH9qTZLrOvCFeAsPbTZBbNAtXfeytYHF1odFozZRmh6B6WM+xM7hG0ppmp6UBddcnxqMnxBas/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y+ZIOnWA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761858335; x=1762463135; i=quwenruo.btrfs@gmx.com;
	bh=0VfQ9Oqt1KzuPBGbAh6gNn2DhZi577qZAqMnKBBdwbs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y+ZIOnWAo1KGFqYKEGIQW2ur5pl7DtAWdG+kAwkYx2uQER0ClAHM+Pm48rue+Ike
	 No7xocvof9LpNkPOOUDXqkYFmwg4w5eP440ZRgvC7pDKJFcpGEfQc9HIy1/V+husT
	 APvOsk+iaRzQdIfLMmpoiSXvn8kMjKOEKPafsZkH9l1+jiSNmVB9hTGBi3baKUUmP
	 IrBzRMnN4LtbV1FQRmGOjh6X/WguC/WjVFgpsPrJvRwNsq58NNIt58nTnON9EyCLr
	 AOcFpjsWIioeDYMzrKUPWQuAor1a6SLn855Yc4ULEF8KdASFPCNn9owwLjnuReqFO
	 3cH8YNWZH0dqxarLAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKYx-1vYakz1PnL-00MHcc; Thu, 30
 Oct 2025 22:05:34 +0100
Message-ID: <6409438c-43b7-484c-bf8c-be5f3849ef2f@gmx.com>
Date: Fri, 31 Oct 2025 07:35:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make ASSERT no-op in release builds
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030182322.4085697-1-foxido@foxido.dev>
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
In-Reply-To: <20251030182322.4085697-1-foxido@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0BwIWSIRMFd9jHnn/tHjkaoahyyWt56sSovdasmuEKtg4UkyQaD
 IOmWWg/AgTdEPkgz48aa1paic4IeTaaLCKgJDwUnTQJZ7twNs03eMFeZ6RgYj8mOF4hsxZv
 rIBk2vhvswshSMQysH85Av53l9DVQ8mzxhsc/8gSGcZ7wvhBROYw1SQvhaeUfsXy1X/j3Oe
 4MUXP9lpEK4xdnh2hrnUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mI3+zPNMiRo=;vfdUYYTPnAam2kWMQAFS/lhV2Fu
 arGYPqbDQsA/RrZT1evg/RdarFkXrOIttd98I0JmUvYFrt8eXqWHUMdJTTpmqaU5Vy3bvKxkd
 Qk0Q+AnZOTM5hdN4UEUlr328ZEGJSdlKECSWa5+izJFbEIhrFvtexosJ3MPZ4lV21G0RuovPu
 ZWmKvTjGNvu0Q0G5hi1TAye4iUOkg6qlhg9Ih9D9rcsgJOddjPLuxjK1O5KSmtMOHg7rXXQb8
 VBJ0CXdQtbMa9+agJGNDX9e6/nX9O4gp12WVzfZ2BMYsIGe5Rv3UjHMOKveO9mNKwhnPETBk3
 xMuDUy6ao7OcxPp7u64eIoTBMiZZ42zbwdnTMRcIE0UCJqq/qjZzZ38vb9Fnzj+ycTSxnykrl
 QKc+apcKx4k8MW1B+7mmdbd0YEBNR67PCSehPb/cyYurwN9+HPbkHF8USnYoOHMJmlSjFjDg4
 4qNRB4Es7O1FSLpyb0q/nd3CPKqMIBSEvm/GGsNpOX7XmJRKMX9ZdNeScyYX1cjrM8mU05vTR
 qvhwwvYsGUwoe/XKjwbO5QsKiZd5RVyWk6UKthbpnkqeveSFXyKFUtxYXbyOp+kgBGlOfkQnA
 35HeiG2HCCyRgYEuzkFdoyZY6mja9qi7UC/LQkV/5KqfLjGztcyvZ45lxBALybe/NOozBPr3u
 ImtTnjGlCc7sPJIQj+B1XsjukaG+LpLjjn2mVIGpG6KsoiDjItWb8jAvstqI2d399ROYS7CA2
 hfQYX8NC9rup8BzqOBNBr2nyYEv9kvEeWbfxe0UkVeGG8rZ1Ics4U8tu0J87XtFRWIH0fyydA
 TamqVYVReuEhIQkIlvS6PfET0h9vGfmgawn711U/nDGI6p7E0nMFtt+vRaLcQzG8GdrIH1H6H
 BwftTeB7l6CE9FuutKvTCN1mPjRHg3Vw/yhYvStDTBoMHAA2T8hEeugevx3nWMdFl3Auyiga2
 KNQI/DFbg9yUnTGcUYRex/nNS6lxOCy/Z91Q2mRHcgpKDnzQ4J8Tv+8CQG8UGlCQHwTlnJs2i
 HRNQWdjywvg/XJlfMv5HX6Yhf9ZYdU1SYTmXHrnktqQOheyt/VVMdPgiIiGWQ8YSreUSirWV7
 m9r7KspgtAHGVYwnmfdEB+d7QKbRfUbW/bzZlULwTpL/v3qmQE0n4huQnQH2VyXgWfXLvs338
 6yHTpLwesLdyNXlfo5FvoZmHBozg0Ug+e4pfPt2Nb+Vhiv1QCaJIrQ+5pRKfiVB8JKPbfPBeR
 55hSgfPEas44zIt2SF43O+H7vmRBH4kr+Rl54Fpvat7CFcdeUyFXslWybZYsa8tIJUhu62nDn
 DYiR68966jl8bKJbVKLLCsdzXzjUxVP2SpgBGo7V3jOODaNpIl3L/Omr2Js+Z2AUZN8ns/JTo
 glGIwqcN5SlNZeWelS0O8fLa7vAEgHSTig9qq0e6WZ3SfT1k4unEXqyL6j2KyqokHz0rPsdAp
 UeJjXn9hGdQZKFHpKwfQTQ0d2Vz4FH/F0+B/5e3QDtNAXTMIvoTFLmUvpxlfFa9eVFKQrUZc4
 MV8X3GRsoPNKKn+l3ONCojV5PmO2IpZd3Ivb8dpPFlPWfuu0dF/Uy+Vhj21ULe40TloAJW6m8
 iVNu93NQak7xFL5NafPdLtr1xlAc8Z0wwMhyE8rc5lJ6XzLsljlq2L/jOr9LDL6gE1TtKc9g0
 KD++0RrkQKrMGvZj5pgKcCOTms6jE8h6eQYkKTWL3wwfQwjEIgi2SwsIokiuz/ZLxYL/Wdt+X
 UO5cwMxaYSUK0N8rPOKoX8VmtKryeALRu8W0NH9H82oZFIR7g5zm6VzfAgUx33RolXHxIwvt5
 7RQ9cqkiTsRh3VxhOPYBJE9bfhbNh6dnjMBsECiIuJY3ZrFhaRmZGIH51gaFEYSaD5MI5C3gr
 Ze8QNtTskQXu02VbM84GDsAG+AL2AKIaAYFqP9/SKYRZKx26ibaCAKeRsQxbr7aoKOss3nsKH
 UAR/qszqqUgvQmgf+tji0hIYsbzwSv0uDiXJ1nlzOkhc/fUSQXe/X0gMPDbem4a0eDaPnHzVz
 ue5t/0/iQJKmQfposJnxDd2IHC3/Xgwe38NAcsnVM1fTZqpkTeRmBNyJ9q9N9Zj2YwLlTt4Lt
 ZFVhghbc/TWroSf+dC1OjFdX5DthvPpPbm95A5FvYSETwp5DBD5NonC/5nfGZcFsAaZQWGYwU
 QggP/DaEWj/FbIUr61uvPWhl80wTTE/d8V4SxREGN+94oZsFfi0JDKOjPbLttCjywrkaqdSXv
 nz1o+lNBkqyAysrwUki2wRGMW1ol2DlctZR/Tw50yhay4CQJbKFD7/oU+p9nWI/Y+yuK6e/8Y
 85ZrrKRyD5r1LEQsL2UnvloX7e1p18TAYhtxBIokU0HqSg7URtRw92PGqpV5zk79JzOMpd3l1
 J9TdJNCJv+K5mVGSPDUunQikQhpi+mPHyPmwhfY4orsg9fOu/kswLB3pVsK7kramR7Fsk7ulB
 F022fT2VOv3iFrbM8gyqMBTvgYnVFx0ZUVlxmXFZ+632Lew40hU3SIOnWLcuo/nPaNA8RiY52
 HI+rmbRjyqsjvo3f6rYQVajLS327fOgwu2OkLHSsDQILOlghnWwJjNQEzwAbN9uJaXpPKaczZ
 cdMND0lI+l1zfxndzT/PotedA7WP6RJeSCRiaK8K7RBD2AGy4B4QTdEx08sJ/29n8cR/MCrCf
 DBz/pGhUOfGrDSqQk6SET3krTR+BUrYXEp7Kv9ufviKIRvryWxUc2CSaek8ui3TDnHcxInq7I
 8ktvmfFllqnxXfWjxdNyRqQm9agi95iwVIiJCeHlK7A7zEuhV+bEurBmVMD2/lIZhr2vAffYF
 4yvP8hSdR6sKUYzorp486wRO0exMw0yuOKVixENfkUImK2lTGHCzMdiw0IxYNbNh/3ndGEa3t
 oKJn8JBj4QygbUiHJLrTtvk9K7aQ9km3B3js6eVpIsJDNyN/M0DZN24U87xQZbAGlWdHbpYuk
 GMCQnGPf/dXTeLRORE9oliendel9TTjSjrpIX3O4nuFhhgUksuGSgtdMdS5dSkUGmID+Z3Q5V
 8B8Zyg/alWW+EYvaUr0XgrcpcCS1k7W1avU+qrIC60FYUs30peQviXJ9Mhf0cGx7Uxoco3vty
 dW31rWjtn4ByllZfbSDUQWAJw11TOB6b32yKwpQz1j9P/Z8V++AEtzw9Mr4eULfY2lIGTSP/a
 T1SCHXoX10L+Bh9kFn+7XqMZH6H/kgJmkVuQqw7rrMWRXfQpfBZgCqHPs1qJ31NIsbPTpx7Sf
 C0iAfr4obRl61yfXFxIbbT/8OJ5fDm5A6l0ynhj/skm4G6NcEVjhbDhBqyoh7EDkTjansmjv6
 fk0VTTedMdo2nqCgvjESG//LGEcM4fvH1Wf3eBmJCrGAvcbs5VZiP6vnAs3dHnH0GHIViT63E
 bLgYwU4LfuGPy7hqIb29qP3stJi6QwKu4PL2iMCBEh+TlTstiOr2JFRtU5XnzQLdkaxIv/zUV
 lSfRwEdHSDjoL7pq+0bMj+MgU5b9FNZIC7PIYKw+YS6sVu5FGhJEQf1tvl5FBbEuWDDOEO3zT
 jns/KoBk7WKTyyaJOBZ6eijs62Pc1OXNo0M2lztZg86F0c2SdN+X1gHe7pcgwxNeLlx40eYSB
 5TwHQH+lPBIa4WD2/CKQqztxVj+pXoCdi0rrSKxAXAs3X+gQcIMZJlcVs29UmWUU/qXKJcT3F
 slt9rwOm20w+b4TILZ1/MxYaN8rREsFtcaa4XNdnr1U1h9UPYQYjfUkdR/t7afIEhfoEqWt8R
 Vnkx3dTSR1gHPSEps/KKOeMq/IrmbPrK5s1bBrihZNhpZAbhkk+VUKK06kMVXUdfpfVwPaQjv
 C7bfh7Ws5tZxT32kHPqu8wZNi3yxkqlcCxgbk6r94J8CvxcUwgzkKZa6a3GP9qdGNgA/1e1CG
 htOOeGbGxcPvydPwb3wRIvlapGGb/CapWsiSLW+U7dbixEQhuiIZyp5Ax5/68QfgX2JsNYE3j
 JX8cktkDtqWgokIg35op/6+Q1EpL/lXMU7S3j+mY0/4XMkW5BwOCQyUIm1RJCysCpCKrxmKLt
 1hwABgjcpslTb9PK0zDN1ZlNOBpnqyBr9XqWKPhpC58ZfKfSh+r+OgVj2NLHQ9MV1Ub2R6sRz
 qfEutWM6VpKfn3usAFwoYq7NByiAE6lBq9lUCW6wPwl820H7zNTXQS8pedRyPmrLAvgJkhRvn
 vbAkGW51gAomcuAoO3eYdAFFIpZaL59MDPFKPivt+nHPROJBkj+mPNgVacvfcA3i5YUItKzLj
 4QMyVxTsjAKkfzg2Riu51ueC96zPgFBT+EyTOySDt9UfpU9mvb+rjMzhmlWPHKOXnhYrAeGJv
 kHiZo+B1LhDWS7Uz07xr9te+Gu7oyWT4RpIYS5z/5t4qXozmQSM6lUBu6MJjH3XrHMg1bWYr5
 IM+/wOIWlXWGvIdCnkWwgb3s4tlbiHcX1ZiFUt6MSxzCQlgAPu2bjtABzD0OYuiG2A3L3CBZ+
 AOFaCBO55qSRAEBYWlEhkkD4L4f/m569VOrbTVgLR0mcvJX6UStVIqjOy9p3HMK32zsGajLP1
 Pkh75wOgRdaT03t5VEI2c0dFmRTPQfeaP2B9MR0NEgFSLLVTSDqGk0Ya3l+U1/ebkPCGTKriu
 B+WzCQx+QaFy9jswHFoCvICNDDZXI/bRmufL4Dzq15E2P2vY4Kuu/WYR/ScnA4+GM5bqDSGwv
 aok0icBoTPaR67d/su9B1sddJkQD5MPAqrnrm9NOg8MN1ukXPYNNLWqRLiQjzyWGBzsdJl40d
 n0Fyb3LSzB022XC6CFaE0FaPNmf1PANq6xgX5OuSfddOHVBdj6L5HClVawPPbwffUEg9KMapH
 EGDPhr0pHQ2mn/vJJTyF6YKmO/bimHPCXCTxVD4keGf7BUOnlqSGnRajq7RHXDgeIgE0XyPHn
 llXBA8eavtYlNIW6B9r0SIPCfea5qHXzyORjB+QVbqaR9xykR1NeVaB4y/vHX3bxdytk4GSUP
 jX+z9L2s93EZ8l5GIP+Ukn7ZJnb3Uv6GnbxAYcoF9tIcaXFlSjmg6JruRK7mrvAqtjnFXeRso
 mHW736xu62jZBcZA6+ovTLlRxnik8uq2SfoZheuWhbnu8t6



=E5=9C=A8 2025/10/31 04:53, Gladyshev Ilya =E5=86=99=E9=81=93:
> The current definition of `ASSERT(cond)` as `(void)(cond)` is redundant,
> because all checks are without side effects and don't affect code logic.
>=20
> However, some checks has READ_ONCE in them or other 'compiler-unfriendly=
'
> behaviour. For example, ASSERT(list_empty) in btrfs_add_dealloc_inode
> was compiled to redundant mov because of this.
>=20
> This patch replaces ASSERT with BUILD_BUG_ON_INVALID for
> !CONFIG_BTRFS_ASSERT builds.
>=20
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
>=20
> ---
> .o size reductions are not that big, for example on defconfig + btrfs
> fs/btrfs/*.o size went from 3280528 to 3277936, so compiler was pretty
> efficient on his own
> ---
>   fs/btrfs/messages.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> index 4416c165644f..f80fe40a2c2b 100644
> --- a/fs/btrfs/messages.h
> +++ b/fs/btrfs/messages.h
> @@ -168,7 +168,7 @@ do {										\
>   #endif
>  =20
>   #else
> -#define ASSERT(cond, args...)			(void)(cond)
> +#define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)

And I do not think it's a good idea to use BUILD_BUG_ON_INVALID() here,=20
most ASSERT()s are checking runtime conditions, I understand you want to=
=20
avoid real code generation, but in that case there are more=20
straightforward solutions, like "do {} while (0)" as no-op.

Thanks,
Qu


>   #endif
>  =20
>   #ifdef CONFIG_BTRFS_DEBUG
>=20
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6


