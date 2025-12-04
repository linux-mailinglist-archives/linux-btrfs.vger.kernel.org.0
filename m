Return-Path: <linux-btrfs+bounces-19506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E4CA2421
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 04:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B773045087
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 03:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98D2C15A2;
	Thu,  4 Dec 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bHE7OVM0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A6398FA8
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764819146; cv=none; b=iBr/IvUtVkq0d4Hu8u86/lWVgQTH0ZydDPIH1iYEWwto6ZuPy400hIYAa+kBZD4eWWygml/JkLrk3I9zXhzZAQFBj6wKGUGjTlalpukNLqdwf678+rtomSCZSg4ZiYeLyo/hjbY+pXPxAnb0rZzsmdGj3afRraKRvKEFAYFXI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764819146; c=relaxed/simple;
	bh=GVJ56vOjOe/Ba1LyAE93M6v5VuozR3eBq0Vz9DsAR9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jKQ3vvmTG3kpiAZJZ6KcO3X6jeKZMf9NDbJQaHVMbTnquegnkErvMor1x3vSvsoj6oIvJKFWxt8WKdvuPDjPQM59cFkzLYb/2aAtFLPjRwqQe0nxCGlnKD2I9A5+IuD/Z0uioI1O7LZnlfZwxAB5UyiBP2XMYcWqDvYB/h8kaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bHE7OVM0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764819136; x=1765423936; i=quwenruo.btrfs@gmx.com;
	bh=XfAKWFlF902NmzFW8mQ4mE7TFsXMBiFx9w3eGi7zdeU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bHE7OVM0PZcNpxeWKZFCh+hQssJhv0OOFgxWEMWil0wSg3p4ZZd3/qpy1snqTnnC
	 /+clNjW1qKuzxojcd7BMXoagALUvE7Q8DE9StYSaN6UiyyQ8X/R22+DUBTTg4LZqe
	 2FH6fmsPb+yjtFIMUbmylhSfHWCptFEeY4G1tRbQZP7oMzG3hKV7O5fYu/NaZAoTm
	 DzhweTFxE4ubbuSsEPUdNYKkoFD94KNDJICyDUxehoIAPQQCou9107cwCnN53tSkH
	 iUh1FxhaRBUShNjNcx+qQqXaxfSCj3AIpPBxitQ7r1m+RlXEDlxAuhs6O0i3kpvw+
	 DndPqgwI+sWRQbFRQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFKGZ-1vFmqs3f6v-005tSV; Thu, 04
 Dec 2025 04:32:16 +0100
Message-ID: <241764c4-ef43-4491-9b9e-dcf34e12a741@gmx.com>
Date: Thu, 4 Dec 2025 14:02:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: squota inheritance improvements
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1764796022.git.boris@bur.io>
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
In-Reply-To: <cover.1764796022.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dryCn/jSlyqTUuJ1nf5XQS2ZRHHYt1c6AbxZbUv3dXiHYekfsY3
 ktT7Zw8yLt1f2necNSRjJ20asj1povRxZqyYi6+QjoiKR7bUiPbVOUeNmQ4hzbLHNlNq9Yl
 2LQVkEbrrrv3ygZbDSgjt0+umOrGp6NI2psU5Wk+YSpLtVAHbPKkcy6vZUzlm5yKlKCNr5I
 F5Cx0KznV7bcMLyntatjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fvZvK/Cp7l4=;MYqcYB4YB9V5YhmSdUiC7bCBV8c
 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
 D1mCd6t0/voLLnF81Pq1H+b+Sg=



=E5=9C=A8 2025/12/4 07:41, Boris Burkov =E5=86=99=E9=81=93:
> One bug fix for an off-by-one metadata accounting error and two generic
> improvements. Details in the patches.

Reviewed-by: Qu Wenruo <wqu@suse.com>

>=20
> Boris Burkov (3):
>    btrfs: fix qgroup_snapshot_quick_inherit() squota bug

Thanks for the bug report of regular qgroup.

>    btrfs: check squota parent usage on membership change
>    btrfs: relax squota parent qgroup deletion rule

And don't forget to remove the stray new line at merge time.

Thanks,
Qu

>=20
>   fs/btrfs/qgroup.c | 93 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 78 insertions(+), 15 deletions(-)
>=20


