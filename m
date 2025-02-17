Return-Path: <linux-btrfs+bounces-11519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD40A38E56
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 22:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A471891A98
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C81A4F2F;
	Mon, 17 Feb 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="H5V8PrLG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3F1A3150
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829407; cv=none; b=N8RXcw3qUL0zIJZymYv1pDVNsmJGnRoZ3EBxfMR4dFjYA0kBEPCvkxSGbgQzCmmfwuetHveE2jIbH5PbQCvQWN8NszwztUS2WYSD9owiq4/vIrwmOqoWB5FPd4r2iXzOY+vp8JUhwYbsKR1FkO55KVIHLtnvZPBWt1FNpIA+i44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829407; c=relaxed/simple;
	bh=99GdmTTYZXwgDohLSltrPwgDy9F+DcvXAAQafcORdHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dMJritLwipzxwn1QOPISoK6CjEKK6LuVrWrkQ3HSOfxKHyPEAfWSh9gxp/MI3n1UyPwEEUiVs2VTQ6BU6D+gXfwJiq3nogqbZE95L5b94SsRmfiypKxcjnNYAlY7P5wfPcXrMslOh/KGcWgi9Gf6OZ/+butmdfgpn17zGY3bGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=H5V8PrLG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739829399; x=1740434199; i=quwenruo.btrfs@gmx.com;
	bh=Fm//2gWNSIufVeK9dPpq5lv0nA9Scv8OvSmZrlVERso=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=H5V8PrLGKnpV5jSlyOD91CBFxld62Iw38xwW6D/5z3kCLm/T+Rkg5hN2gIdkDfs8
	 gykZJLIeUxbX7wIl/De6WaTS8UOPHZLsZGlFhUeQowWb9MkdEdQGA2sFBHO95EZ9p
	 3XcL49PqBDeERVN1QDQLr/D/F6RgvPAtgoI5NM8apmmHAqMXave0XeVFBJkgnPcHx
	 2SOL8mxpYe4fX4CgLD554jxj97/us6EXBstYUOlpwaG6BIZltMEHylYSNG9MkKmuV
	 MSFjhmG7hakOUVj9RKkZ7xTJxy7TNxH2pjW+lHgpqzmB1xYCP72r5fRkJVyocF7TT
	 9J6N9YWQpKiRO+Lwow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mirna-1t7UtW2Jt6-00dBXd; Mon, 17
 Feb 2025 22:56:39 +0100
Message-ID: <f7936288-daf8-446a-b97b-686080b09a9d@gmx.com>
Date: Tue, 18 Feb 2025 08:26:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: some fixes related to the extent map shrinker
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1739710434.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1739710434.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KpkpJMIPjkQ9Lqw5AfGqy9XxroLP+LtebnTs6D0Fain+C8NJipe
 FCPEkWnp7JA7vQ0oZkGby7lFSMm49Qioxwmcv1iupQl1FECYyDjoJYOEicK782k+MzbeUfW
 5ScCeJnz+ApiFXByJt5XgYWDjLvoyDiOkp92GqDUU6QZrx9uFhpU16AmTWsSCfXMw92Zco+
 wyQdVUZA9vKm9StTlucKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gMHtXLML+ZU=;p28eXBKx3VNXp7pBg7vru22Z1kd
 DqPBgaErhybAuZLy1xAGn2SvESW7mlqlXOU1Mwro2ZwY8cytQrVzLmK9eeeYw5KX+JAwKSY9s
 nx3opXCEturF0EV94jBJQBSh5cyOFSMyAEqgu9itj049VVBumA0eCAZIehrwVHJ82031BtEGs
 aTcO9sSa4Jjd4Km+cdPUjWuCvniKyXLAvsvJ18fHCgQ5CdBTtVQWDlNqODlFGOM1nlrHr2voZ
 enIVAfB1AqhpMkr/D7x8VS2vYB7Wd+QLO3lbToeRBu4MzuQ4aBJf1lQXGUfIaY2FLiSVRcBeL
 T+vq+N/S5znkuCK7BpZ2q5G6imp4SRhoddAHuZmY9Rov7sSXRVJi0hJwvkBTC7/IbB/vOUtbT
 RfQxZx+o11p1hjB4zK1MDyO7ItrhYjOIybiwjT6D70cHjp9WhA97aa8Gaij7cHMhks3uhvVYC
 unVm2ZWaZrF6lwlC4BZTCyDJAgqcFUBLqgKKKRyCZHE4TEa4vxQk9qONPefOlXFbgiqLQszjp
 yrDBOfwJKCE5+f+dZZjpWObOqX0GEQHWeCABzE2K2550DjTit0QNCMWdbfPNzrntkUJ6gnRST
 QSieGU0fklLSunFNdjc/t8ZB6SehKfoz/sXqllTnbrLwDm9jif+2ykWbnjE2FpxEON1XjmibW
 DLNNmeMZFJ1Nj9xGyl9M/AXb3zHUh0AKzPsd/VmsbVSUEWhpzSxizl3YSMY2QEDcS46Tq+4BH
 7wbzBoIxsEaO1sLus7nAtL3hh6xOVQlC7Lq0hzoWsMZkVWUeW7Q+vNby8QLyowLGQL4m7aaoo
 WOQini4NI1gEMj/bq3XiJOGETjSU72ENx9h4CzPkJ4OeCzrg6N9A/pgfNJgASagC9Zw3IBndr
 nIsjJQOdDURvBqIaQ3TUGon1HXQzKt8B8ZX2b70KCAChgqu4EroBHaG+ZUsVR+Pc8Ibf8iZsX
 Exp78mmKNajH2ADQS20JhMbl3JHh8ZSDN4UyCFPApj3DLSLYlV+7G+0PZByDN2m+3lwXCz/xU
 0QzUqww1j5AOeizIZPlVt8fYNdrpZ6sMJuuvC5K9xEcgZtRQJ2dJwmQo117WLmTmV/BUWhnhP
 ea/Uif9/YAcZL43nExCJa3taemVMkWNl1vqAJPaIn0zg9kauo9RTDsTmIGd9vrOsX7saF4M5W
 l0g7U5wkzKz2bZRXtOpA8qV7cNiTsHruQrJqUTUpxTXjHUpBLaRtrnAM86ipZ61qwAOZsl1WZ
 9GTTGBsMyIv+9WsU8xrNrtgp1JmjldtAQoVpNDi4hFYLX1+1Q/0m0ZxssZrzqnWgKugcnuCTK
 u14OCyQ7NeJ4yOg4HETO/7hBGJm1wX9K1ce8j3qWQuIQo/YQzuUZSc9H6u99PXIThrN9H2lDz
 G1L06wQ7N8I7rn68jyaA0/ZjlI1ylKwmMBEuQM4/A7XxfD9a0G/uQBXqQb



=E5=9C=A8 2025/2/16 23:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> A few fixes and improvements for the extent map shrinker. The first is a
> use-after-free that is likely hard to hit and the other two fixes make
> things more efficient by avoiding grabbing and dropping (iput) inodes
> which don't have extent maps loaded as well as eleminating the need to
> do delayed iputs, as that's not needed anymore.
>
> These are related to a recent report from Ivan Shapovalov where the
> cleaner kthread was using over 50% of CPU doing a lot of delayed iputs:
>
>    https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc36=
e42e12f.camel@intelfx.name/
>
> More details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Filipe Manana (3):
>    btrfs: fix use-after-free on inode when scanning root during em shrin=
king
>    btrfs: skip inodes without loaded extent maps when shrinking extent m=
aps
>    btrfs: do regular iput instead of delayed iput during extent map shri=
nking
>
>   fs/btrfs/extent_map.c | 82 ++++++++++++++++++++++++++++++-------------
>   1 file changed, 58 insertions(+), 24 deletions(-)
>


