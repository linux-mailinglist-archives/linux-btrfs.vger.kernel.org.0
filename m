Return-Path: <linux-btrfs+bounces-21767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPkEKs4vlmkhcAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21767-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 22:31:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 449FC15A201
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C762308325A
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6432E15B;
	Wed, 18 Feb 2026 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YdOSnB/1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F2326927
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449860; cv=none; b=QEx4v3wT9+94gOY7B55ROUUJejTABz13WDS/CZXn8XeMK9dZ61wIhiu4+fqwuAnZzR+2XIm8/TBeb1V5F0EiGJeQKQ0TfGjMGbZXOLRkvzbf7qQrF3/lU7d911bomYCQrlSKLp3QuzdSzR8qL/M8zdDISf5Q0q/pydxhyXowuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449860; c=relaxed/simple;
	bh=9sXB1/G8w9UwlT3PKnEqGa8/TrmminYgO5OGzl6IFnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F6G8J4CR03pCFHwN87Ni7mgrJFIxF/CXNGiKH5Kj/TBxakX22EpockyMSH+Ou/rJtPpkffSn9oV8T2yKLHrnMXF606Hm5WVcdfiHc/5TyKmh3alhWXSgs4tjlYtcMmHTYQWlsKLwjpsfgekfPsMS3j5AniYLvuvHqpE0ubLt7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YdOSnB/1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771449845; x=1772054645; i=quwenruo.btrfs@gmx.com;
	bh=BErBcXRtgMnFqkk7NSx8A51dP4+K3Iqn4vjTpxnr7IA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YdOSnB/1gbxWkQhzYSks4/w6BfHAl+UrJfFnJMHfWC6CmR8O31PDPU7IgzSVDHxF
	 tI/vW3PN3yvpmyqe5WOdqqLyAgj4H3CazWJaO6kdFNniVBB245gyyXp2Kq0BUTRP6
	 ghSm9hBjZnl7sxIyYkCHHstJtXWTI/6cO/iLd4bdDWwNBoRY4FLXaHKSLNG1t/un/
	 tU4NuquRw5Px4QdBc/6YeYbVxSQw14dljyGZlfJfGDfzbER0IKaN4F2R0VvkEYXwX
	 Nz6SPz3mch8xu1TahRehbBwjnH5rJIPnGX1C6Flu10IZJBymwuszfOGlONBL/YoA+
	 99VD3w2OfSWgxUK3Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVN6j-1wHsNn2Dwt-00P56O; Wed, 18
 Feb 2026 22:24:05 +0100
Message-ID: <fee98b19-d3b2-4c88-87ad-d14a76345049@gmx.com>
Date: Thu, 19 Feb 2026 07:54:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: print correct subvol num if can't delete because
 of active swapfile
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 kevinhu@synology.com
References: <20260218120322.327-1-mark@harmstone.com>
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
In-Reply-To: <20260218120322.327-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:THGGdBALKSUZKZzEuf2U+5nY7PP1EOrowSx+f0+eIj3XeRiLaJy
 TDCy3SvOZKy4vQOXRHse5gFdqcTGz/RqsudxIR0fdw2p69+xq1mYmbfskYwL33kzWCNNxHc
 t28aOFK57drOuMNqqkiTkpKR7lCfwWA35Dr+9hNymp++XZjvoy2J8u4ic2qYv41w8l2gfWa
 q53YKw+facS7KUpFBA37g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RW3mqcvqzD8=;oXY+c++AerGXb9cxdEDiUDd4pLZ
 3MInRgzaJVIus17qrB36WwO/8xiR4Wg1+tKJ+E0bYthqbjUEIOrEi5xZMYd2rxd1qjHB5mvol
 V4vzfN8WfYTP9o3n7umCcvnnvQrFO1uRqqBayQU+I1lwXgYYo3DTsrNrffEiRTBeRlKJ9NvYm
 PlpFdEBpcbu+zVLU6YA3UkvB1OU20AKdKmmJzlG2K94gmgMEzA8rB50yd5eFFdxaLz9fCMOeb
 RqW4o8lB24UtWsdUIozjcsBu7D1bhwpDnBR0IzTiX1LIB87e11yjwZ8lsJbSsuqvMUwNXCic7
 ofKbLqp9noqc9DpapFaRyTxqiFaYOQjS9qIegvbvZSWJYdNmhrwNqS/QAcPG8M6cAdM8c9+J3
 hMMqgMCLdGlJSjyLo4W04JDVoaQLhLAkKzg1vIPMU1Hf2L2BgkfT5nvGA1FQfh8u67n9bmNkC
 IHQiUUf/+/WYibX83TJZejSe1JrOIsU03u+1E23JLp0m9JOzIBwP+nHqnydhG+hB0zG8CSrXw
 p8v3TqEec182+7A8s1duqAk1a/p+PmPkN+RKk8/Q20B9QPxl8SRYj5cg9cyHTRv5tEqmq4M7C
 Q3aeV9WXBUZZfojqlz3Er2NdheK77TjWTOLuFhko4gMguJf4tQnvv5Uxk4pHcVwrdNqkUt2Cz
 Sg8zvgs0LTTRdeFzTcYj/jFJp33TJs8gSOwXIUy9kWck2gQA5Nsmn1ADhXzwNjSjXZgY/uKYv
 w0b9C5R69lNgoVNlQaRCGl7auCowNDF/6Q2d4CtIWRDA6E1LdWaSBxBOdThhjjCLhbhvZpw8m
 hnGBI8dev/QC+ME3tU7SvxkfmllZdVQggrdX4SOCSjPcWJ0aL+CpxeclHwdWIt+gVkIsciSDh
 MnYLMkWip1O2V83s0VSna/K1HX/8+q3+qK8XsVskZ/tlTSAJ6FzsKFZzy2G4u5vwFntQ8Vq6a
 9R/K4bvDfZ8qjEiPNz/i5oHcZMp/JkItwVympyRfZramiaaAh2hItidWKNgTjy988pjloY12J
 Ra9CxLJZQNfXMkI5gXr43eIHHwczT82M8V1WN2KtwR+VB6uUqvuOkGpcX1uY/bFX17r8VQwa9
 6QvYLyyWo3MpLlv8VekoVS4IUzmLMeE9EEx0Mewuv9VpoZ8W1aCfFunMCe8u4SvEkBbfz0str
 Ja+fVb7/F6WfWoF2/8uwgl2c25hN6hx9EOxZUwXX9hAtgp8vcZiNpwQGRcmtOkpurEAnp9Srw
 KR1hjL8Ru3c2jHAFq/ocB896ZjJm7yAtfJt5iQ0hmwyMH0S27STX0iwz0dRIrzC/8R3Y4w5cM
 mIvZYbAYl+OTwo4zX1iJel2xVMg59CRxOaXR6J9IqOXC4GHIKU39e26OjWZKPj4qKbgjA3Ve4
 nkWbqLeTtPVhbalnXTXAyDFFXi2T2joiBCVhavyLDNIjI9gvH6j6gpaIy+bqPGazvU8OZ3Enn
 wGmP/+FDfe5SS9qOH2EHzFyScZphzJVoD/aCZdPmpqGM9fjjj/3wgF7V95j8a8HkoLzcz1QuN
 TaPy3T5ZyqdXsSm3Q1dDdxIYBmMrSaRF68cbqtzJNdxQSsrHdJPwuUYn7Bf8J/tfSnfhmlBOL
 yashi4q5jcaeG3Jh7UEkPNnNjmLARCE7y0sUMKIs1rrNNWKMez2Am3FLEHIcaNQDDtkC5CrKn
 G7+nus/jhTPOjYgfJyHhEQKgED5DvX6zGv4qZzBzPXZJErLpYo5kAZMpJDaExBNat6Lmwpdnv
 Wy38EnxtMMpHDaEIhcCA6Nb+xks4ByiBG72UOdKxxemMa/VSu+0VG3Oi3GNlmmvtJvTRRdub9
 B8JNzmJ29SJWj8dl+uabugWJrxuHspHy/4Sa+giprE4oIE7fe99zCT80BZApQmRs8LWG7Hmto
 TfFXMoCcuV7c0Jv9IxCAQcGaULoyyV/E70ppHm7qY7Ntq40d6Jv0bg8li/TuAfftSvOly9rPn
 bEtFhhet/C5V6jXU+46DS5bLUil7w50t89qu2iidz2zCHiRsjblCVFOqgKhG0ehEqpijsraLT
 iiq4oF2qawUYAMS0wSWDsPQ4VKPLKSP0o4E8pImDq9vSl5mPAkQCuZDCUA99MBnz7aD7Jfv/n
 CbINAmEziXtPZZvVZIJ2X6kc68QejLzxc+RK/xUbu376gySQyY2ZeY0G60di8SMOEbwPo0p5Q
 WKKcHWKjvn4oD4uiFVpH71LH82FiTa5s8wo890MB+2s3gXqfOVDACqTte2YMNFNGvSiGr4+A3
 i2WouHxsmwAQvdvytcjhbeC9BSh9sC42/whMGQFHrDOFxHTMSPilFTl3vyhZNe9emwLOndQye
 cPpuq2Lnr7gQwtfB0s/XKnJhV1eHO+WdtmYU0XUrzWTc781BbfCd19yVsm9ya/eRX59HloIzr
 wD3D5DWiQpjq927qkYorTLLHlKtOgGgrXWeqQC37vBu189l2Qpnkt0C3b3GuV+gJFC08uIbrX
 xEZTCEi9D7fphROZNOXLZcjZPr80KwYzjPbJ3N8ZdZ2LPCB/YVblD/tbRsWhn7+cNZXr1YSGo
 c6uqrgXjA68CQ6a+IwqDY3BhvKSy/PCZ7DRTu0kgM3XpYagc26/DQ26P4RCuPqZkBqfk8yL3y
 GCGIic+Tq3kwSgxMDIohqD0cYn2lJSHw2XqMQAlholIHsGcqQfVOcTvGD48dVFkc9bRiuZ6R5
 cEUmVWa3LiJ/hFf+ZJ0l2wrg1W+as2pHJAnREr9+ihQfagzTyxSbPSF7jS8AfIFuU646Zex1W
 0PwyUeCGZ7vCCs6gV+LYqvbPJNyUueYsFcaSr3SVHcUeMUZUaeA98YjeMxOVNQFGT4qxQ1yu9
 jVVwqOVQwE0G1r+R85WS0MQFKmo6MPaSKB7IERhyf3vZOewBni+ikHP6HkSHl814yNeDub65K
 8Tp436XryEuVcrrYxcuXk5p+NpNbMk/HAfgeGE4SASubG/+r9+/8fiNlyyj8pN8AYaH7NJ3Td
 gEjf6apgWbeK/UlsL6Sr5rgbjsMZWb4hgkUTukWTu6ZVEa5tXC5x/mO5lXcgGDlH3w/wqO6D6
 lV4bCh3x8hr4Ix77m8j7CG02I4AcnF+nIA33dupiozfNgAuXz/gXCkFZUThHA1mc861s3iSIY
 EeYL6V7D59gE5vCLXx6HRLrEwhs8sSW3LZlEDypXFXDlqBztPJQAXz2RqC7HJgU6c2j1/JJgt
 3W9H33HgY9aVOWfXw0z7lJqHCS81UtKn+Wb6kr5nYxFupT2neYxZvaDIcJ/9Xq26MmgKn52bt
 0hvQOugAl9iELIQF2KZPIAZYHXbYSGkHECE9vGqlcGWmSkBwM0eEVW49OpEvi3yKgTrC8uhUt
 tgARFuZJj7RTmEE+ihdsUyEF1aZzFxUNdRl6RU3Zz+XbddmzqLVI1cG97BiFps+Cr7JYeauQe
 RvEMGgbV1googOcvk0RarTt5tF1MdvjHZ/4dI3ndTiOurhUcUB1UX6pQrPw4WZQZLhEGBD0u5
 mj0d+ECaGZ95NYmziCx853d0Lrpp6JkM41MzxZXUgFqLTAm6Rt9xenJK6E9h9Wzh8CNZTJ41G
 o8130eOG2TrgHJprrKbPZyaw7xd1urvk2T357/jXAGdJWHlvqP6qSWRz3iwnG23SpgVyTS4y3
 jh7B5ZjShZQDial/NpD9/SKolMnRg0tN0A3eCYiQUwe0q3+segTQ0SBY17s7mwxUHvw0VDRWk
 nXmUsuHRBVWw7hTD14bYbx6e8XxP+mzxPCvqo6Uf0du82HEL+cvWNsjSo4JvfXFSL3TUvs0UG
 Mi8D/3o66bJm2h1lVy09eIV4hovIs7jPlR07J492vF39ep8zybzAbgx3Ieo9pCoel+5mCK618
 K5L1UiHnoAcZ9bSMVPCWDz92spE5ljpd9/Sm78EBl+GkqQLCImx3AhxQzIaxCbzc/a3DvOTUe
 vadQ3S9bN+NKOA5KolRUuBTcoMHvo4lu8Z4CB5kOKTRA3WHd5/CMGd6uOFzKQMV4wD913MkF+
 gis5QgdifkJq5qBjvCYUDoB7y0ok4cTLwgiwDm07jFrLrt6we0CcSotYtT2gFQP71veDO5kKL
 paH1r6YcXDu1W9LqaftDvbBpQD/rCR7kAOQoCsdejHfzAMi82g/Fuzbc+rFY0bW8++tzCy5K7
 8SulDq8/8yjscdkcV+2PtlNNzcao6PjU1bf8SGA4twsAzkCrV1iADqk4TQsvOTkUt4EBkl4iF
 JdBjT91zLjxgUE0B8MMe0+/06fDpCpOaVbFf3CAwvGFP2stEZp7rDNcKib76v/5vw/Q2ULJdr
 K7mki90HgrqZYMvakKN/cZPzPHGY881gWkr0XEAqXYia5AavCIBfWH/q+RaybStpBfW+zgbwT
 m3tht8cYwaPPANJn/ZwG2P/xsl6hkrv3EatA6fCLWqXKwhRiwba2pCmiPs3OICXIldTby7p5z
 tYcR0eLji725z8g0aAQyLUWQQT9rg6C1AQut5GqTTmCyWbrg+Dwup4Vfb73Pe8XkuVHmcXraI
 uyDfec7eLWj6pUwo38YChd0/8zfVcbqr+37O8f00a7pIXvMHNVApCv/8Gmk1cYtYbHQ7SGgfu
 eRv4R7wH8xtQf2I9wKGewlCe1+JeMeaNfx9UoQIWB17SaZkJX0MAiTB5Z4SxVJACICQ0DOx5H
 53AYG6HMuzuKlkJVOFmoj6dgTAT+xPTtgm4OdlkZ3GPknm0Z9HR34oDx6ZxZISUDEetjdY40Q
 ZWmzLT2OieNtEyT1A0UB/g3p9vr2DRPC4QYM2dtIvInvromsqahWNEeID/xJpife62f6sxgsO
 SCuT9MWryaeVARQzD2sAdAFKcyNVehmW8U9tXj7oUBo65C2WVlsH9kO2Sw6JBz9/WvvSCBhy0
 4YiNCk2Jw+3qBtqgLMCT/lm8Uyxntd7BIUW9wjvKKX+0jeIk3ZVViSPAiej7AwD56r4VRwpvn
 IsUdhUpUn7oQ+yHRU+gMi/piWdv2lcVFgA5u6zr+zqkw8oWQX7evPnicdBlhiZQaRwsgzEijh
 SVXmrNiHrT0nJvi89l3K064fI3EGpMF0mcxiy4D7eqd8IXm6oroZ+sXPBSFIULu71slLD9+t/
 N/T6FBjRN1AdG5U9AwCLbqanEQXbZesgn4GjRszbJSerW6JJO9QP3cPVEoouuUS3dTD76WXqG
 ucGUt3FRhZjrcCL+ISgCui1WpTqW9fSTdJVBf2WcwojNyCjysViJOy1GirRlF7V2GCCc2bJue
 pN+Z45pw=
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
	TAGGED_FROM(0.00)[bounces-21767-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 449FC15A201
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/18 22:33, Mark Harmstone =E5=86=99=E9=81=93:
> Fix the error message in btrfs_delete_subvolume() if we can't delete a
> subvolume because it has an active swapfile: we were printing the number
> of the parent rather than the target.
>=20
> Fixes: 60021bd754c6 ("btrfs: prevent subvol with swapfile from being del=
eted")
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4523b689711d..233d91556fe4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4804,7 +4804,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir=
, struct dentry *dentry)
>   		spin_unlock(&dest->root_item_lock);
>   		btrfs_warn(fs_info,
>   			   "attempt to delete subvolume %llu with active swapfile",
> -			   btrfs_root_id(root));
> +			   btrfs_root_id(dest));
>   		ret =3D -EPERM;
>   		goto out_up_write;
>   	}


