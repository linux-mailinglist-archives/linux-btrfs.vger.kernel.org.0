Return-Path: <linux-btrfs+bounces-11711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A7FA40593
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 06:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7FD19E240A
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2025 05:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4481F1932;
	Sat, 22 Feb 2025 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LDnbGJyY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F882C181
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Feb 2025 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740200602; cv=none; b=akBO8Amjbv7Bv6d0recHNAoLocUzBEMYsz+G6lloHy3rkwm4yXzsPRUEzrqmVufDmDLTq4c9NWmd5viC8apT6ptZztBm8W3V5ofTh1r9c6jIVya2TAN8x1XlKXOFJXVr3Mr5C10HGNuPG4aH+PA45hAIiyzcdWGqCy2LkyfG+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740200602; c=relaxed/simple;
	bh=nvWCXZWl51KV6Mf0cQYKUB+VTfW+k9BTLkmnSO3PRDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lm3Wb2agVa09GulKOJHm3oS+13uJJlHe3pES87mwZzww7F2xVz/6/ovxHI+YGwvQzS3oqsCcHvDzsVDV4P+dJ7MJslW6O0Tod799sfCcj6KSBNM1lb6u/BobWTtG8MP2nOZg3c+LEG8BATCGfxtglFo3OhWmsZUQa8J1Kd3Qeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LDnbGJyY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740200589; x=1740805389; i=quwenruo.btrfs@gmx.com;
	bh=nvWCXZWl51KV6Mf0cQYKUB+VTfW+k9BTLkmnSO3PRDI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LDnbGJyYjnd7Lkx9NFjwxC1GAHm16zbyB/lm2A7SqPHv7Mlq/NbIuzgYET0fsd+y
	 bzT6QrIuUuMQm/k/b+X5JGl+fCE2P0hAu8ZtATVftoiRs+P6ggrGe4Vpph8Kp/zZ3
	 25vadPFCy26bIvdw1Npqb3mAEk7CNlzHSGfDl7MPulV5GKyWBqzF9gOyrRhAgiYa5
	 oFgKd0IYi4rQRQf/udWLK6JBoJ3Ko/9HKsKLbHYGEqr17lcs2v1t1k38Gzl7LsyQp
	 pSNqjG0YG/iCAMTd7j/SfUci+uoT+5FNDQSD9U++a24uhcQ2nZK9SK8FBq/YRnUbD
	 qusjq0BUad1U98Eq8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLR1f-1u3VXD1Rr9-00Rs8X; Sat, 22
 Feb 2025 06:03:08 +0100
Message-ID: <decd6725-230b-4723-8919-9d5959f5ada0@gmx.com>
Date: Sat, 22 Feb 2025 15:33:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] btrfs: prepare subpage.c for larger folios support
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1740043233.git.wqu@suse.com>
 <1399d0f444eb0dfcc391c430193ccd8649ff2c90.1740043233.git.wqu@suse.com>
 <152ee58c-0ebe-4e58-a0a1-94e8c9c51d6d@wdc.com>
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
In-Reply-To: <152ee58c-0ebe-4e58-a0a1-94e8c9c51d6d@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pTJ7tqjPz8YLgZRu/TAAtsRP4ZoV9vl1hXSu0wqzhvM1i6hYZrB
 6FlHjtHALqCXuwKyT7gAeIPX9OFRYFdHMMauDZFSA/KsAf7HwDp3EmmTPMPm8uDxOyGr0pi
 c2wjIZhCYLv8Lh9rpM9OChbxahpLIm0TDKavn3rMUYleLkW8WfNjpGFw/IUgyMyQBNv5esS
 eu7TuHgOBE19fAdm0IRsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F7rP+uPEyxM=;e8goB7cxjx4Bhdn+Nm5WVgiWl4q
 iuR0sJP+Fd9lIBRoFpTQcyB4mncG+49orGMCrBDrNjLzZVZ238GdBx1drAUYov+kMtADiWbvU
 dkMjVKCzirRL9yFQr5TUWOZ5jFM9MVHiPlX7tDaKzDvJeQcVLu9SbXi8mx7TLN83NiRo5+1HT
 2pT1jUp0jmDQ7PWW07hivLfbH2evvdUoE1A2qQuOvW9Na4Z1Y37+7kQ4WaMp8eXSyOyqnGvPE
 m9mIfppG3moqgGwhuH1w4lCk8gmH9VuaQfx6G2SWZac1bkq2RLzaBDi09cHXwECILzuSQiep5
 fBN0tvpKs+Gn1NwxiCBBv5u4OUa1cuXsJKkmgGAOSO5hcpTGjxxZ5+cGLfikpXWZMVfUeTnuL
 baeIAauEi8XLfqhsUom4AksC0LuAkwWJrQ0DfT9AZIG1Gx81nNNVGfK42WX1BjYfusfZ8QVaK
 /8H92VAplE5DASRBf1tNTEEZu9z+i9RPhSpKuJrtrDcuJoIEeh4z70P8aysUCQxRHxwEDN/aF
 ZqnkVY4/qgAABDxv39lo5JPmg2JJ4uyQ+F6jkbeEVMwfR/3RkhpU0K2HzKdwWQ0Al0MQ8RXOK
 lEbctEX6AMU+PBkNEn/SIwHXr0vgr8s4Ar+6a08w2+bBEahX+CsyR3mRKcR9L/kErkC4DCuJN
 o9h+EG4WRpvCUJXXAQkkzqJIGKu0lsNPzj1W7SA/uXMMukM8nssyo0k9NLAVNOvrIf+gR/obH
 eluW9+MwNqcbY7GKnQqbNIxnLQKTzgyiK0tcrKQzraI/+KKoPLSzVFBmDP4iwvv2QpskIDFRd
 lK9J/Xnnrs++XWHjQNnbS6FhxRaeEbJxR3CGGb9hedhpP9JOVGR5e7vHqvkzX4C4+fWmZspuk
 vpIfN4nEpvk0QXzspa5ulvhs7fQliK6EBAddTwQR4NDNzXMrQbm2kFUX+wr55MHf1LgfZhYye
 qDTqhtH6/jO075O8KiYpB0NpMVd8HTAOp1DJtQd+QEJUl7tUldiUocFU+q0z2tyec7Vv9ISTP
 wGms/hLrObQUrDaBi3HblzH9hRqkkIZUvICRZbFXgnTO9Iy4vayQjp9gny4CATOJU7RZdnucg
 Y0YDCwrDWIaGd0Xh4YB0x8X/AVGw4ryTtnoSwZ1iLmtut1iC2w35nI7PTxxZPDEk5vk+G6CRW
 zHtwhnNMJTviytKM4YpeWof6AtDMZneRcbKhZ6MNVH701GJCq+naR5FFn/YX+dB15MIkeamO/
 EWFCUKPxcwjRuZ3OL+LrAsmQkvD9afU3M+o4oGjJdG4k6jrjZlyYvHyMKfIC7lI/GoQE6wv5k
 ly8JDM49EE6/GhzoQnQIdq1obP8ITn067qzNhLupUyeUxhJ3KXsQdrAS4PeI35Gw/OgMgiIv3
 9Oq8K3PljvVL0rJ1/ufwc4rqiUX5H40HBaJVg=



=E5=9C=A8 2025/2/21 22:36, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 20.02.25 10:24, Qu Wenruo wrote:
>> For the future of larger folio support, even if block size =3D=3D page =
size,
>> we may still hit a larger folio and need to attach a subpage structure =
to
>> that larger folio.
>>
>> In that case we can no longer assume we need to go subpage routine only
>> when block size < page size, but take folio size into the consideration=
.
>>
>> Prepare for such future by:
>>
>> - Use folio_size() instead of PAGE_SIZE
>> - Make btrfs_alloc_subpage() to handle different folio sizes
>> - Make btrfs_is_subpage() to do the check based on the folio
>
> I personally would split this patch in 3 doing the above. Or at least
> split out the brtfs_is_subpage() part in another patch.
>

Sure, and the next update will only be sent after all the dependency got
merged into for-next branch.

Thanks,
Qu

