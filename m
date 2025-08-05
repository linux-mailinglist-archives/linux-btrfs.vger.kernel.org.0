Return-Path: <linux-btrfs+bounces-15846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81DB1AC53
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 04:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29C3189FE37
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148B117C21C;
	Tue,  5 Aug 2025 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OEoPGtXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48C1853
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754359323; cv=none; b=bvVTVLwKnXha2vzhhN1uUx/uOcpLK2XT8g7GwEdVelacQxwz5B5hfXVGiVeKLAyjfkUaiQhS78fzUJYlE3f5VUhakq81bIYTFruSN2Jrj7SmBe1QyaLO1dFBhCHeRP7PBQqzOj2m5KOwV4putvHx8m2a+xVTchdBYxy0gE3f34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754359323; c=relaxed/simple;
	bh=qb+D3nFESaVUboWNO7ULdJJsZu7AROAMDBZKSwCjtqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BKvpfD7iwa3sOLRZN3OdoL7vVyfQr56CgLGyUMLl4GD2jF01dxMoVk/PHBCf/Z3+aY2m2Z/7D4R5FG0lXuxi4eir0CEUvr/O9dgX62qbbu8hydg+3RJP9c1EXBfPxzt43dRSOD/87Sqh8RzX5mJLCxFbg/3xjnfoADQ/13Qla0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OEoPGtXd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754359318; x=1754964118; i=quwenruo.btrfs@gmx.com;
	bh=qb+D3nFESaVUboWNO7ULdJJsZu7AROAMDBZKSwCjtqU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OEoPGtXdNaROLQ7Z80AC7dODjpAYvdvXvGHNssw6+9VlRjRbtFFkbV4fUHHmLt62
	 2zI+cslLKiv1ux1DUqw8o799MBoVj5iCxzvqvjLbcmbiJI8GqtGU19WOmvDRt+q0C
	 /dRxlmI5H0A4McejV+gOlFFxujkDLaHzNLrDd6t9/bIMMhi4XSpoclM/XwhQ0w6nS
	 XGVP/AZ+GbbjBGvjp3nE2fmQ8mIR2DANi/L+gcwzCQ34UONaPUQE1J9ztBMYkCZwY
	 Uvbcxff9PEeJhf8ZkFgx3rQR1gwXv5DozU1EcPttKSGAHgSSqz3EleJ9D9aqqbDtr
	 9IwWeuElUgiDmaW9xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUnK-1uS89609ly-00zKtr; Tue, 05
 Aug 2025 04:01:58 +0200
Message-ID: <caca6423-5b69-4eb6-8be9-53c798668f6f@gmx.com>
Date: Tue, 5 Aug 2025 11:31:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Corrupted btrfs?
To: Josh Rodgers <joshrodgers@tutanota.com>,
 Linux Btrfs <linux-btrfs@vger.kernel.org>
References: <OWrk-6K--F-9@tutanota.com>
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
In-Reply-To: <OWrk-6K--F-9@tutanota.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RsXe6sgTkKN7WukzEqoADA6T93pI6urdP/6Pn9ROzyfYdg/8j9h
 8PLx1uSidwE4mVej3NY93OuykXtWaoY/0231HYcRainvK1yxnNugsvBvYL5sPWT9ew9tGQh
 nS3ImjQ+WlExKlpjQgWDrFS+zzaizwiSm/yjFtQsDRaUmqY8FVoUgBzUC895sTwv3rL95bD
 EAtrGJJg86jNKy4klbt8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NA+0/1G2kY8=;AHIgqcY3G6BLsPaRZM+aA0Do3j7
 OyQa42/OHYVGayMVHxGJ9JU/6uXP2oVn+70dRLDsu1hqupjTWoVWTIpub4C6VJWo89Gh2iJd2
 Pod5wyNLIzpmy5CRXbQy9y99uPgA7fUUfqEHk/wuqlsHtZK7hVWymM8KEP3SdhD8dnuioj+/s
 sp0RnUywFji405w4bWKCurdgzw1WLbdnQ4m9usFk+rDo+jO6PZIjOj0TVsFxp4ay3BuOBDLBb
 LofV//yZoiOyHBdZK3F/0Q8x5Z3Sgo3ao83Eur84XhQHi7fbDVUzoHlD4VhuclXscM/LYSKZz
 bz+qOAB/8JLfR6857HSITQ6lpqqQ7cxTTN5+QkB7mJEEOJkftlON7WExmIaOMKDWS+3OXg2Wo
 FFl6ETl7+xM/UMbdXjqvSIhwhMxLGrZW+p+DN5EZA5mY58P8/kVxDi+asZnrX5TPL9pt/Nut6
 tUn59wIdazRE7Uj9qrXITj44x+KPlZ8u4fPypYp0quQ/SfCBT5t4UIw4Sh6zuVwT4AvFKlDv8
 X1OcPPeiLhGcDSZEaY2oYCmeDvLcy7c8BNQMI0elvzXet/zVzKjXO2Xt65EOPoLet4rfeCvWO
 8j+yZ64+wAmnvw8vENTz5OQK9leLHi33SIpP94Zc1oF4Hzj88qFgGFDQmnvDIIqO/xKr1boXB
 fiMOpS3oQGQmWYiDn+KeYRyIrAmKMEzqw+e3b+sTxfX4QMqgHHrYmEt1FM4xLDHnpCMkB8doI
 zwXbI3jNbhZRjdVPUMEOA4L7DjjjFLO+/EeV+zsvSkjLHS7MFIeONudjsdUHRGJgq7mLk4lxy
 XX2iIIIXVhkoSjTVZ4jnWKdEjlWZWnPvY7+DxGEDZJuf4t3GU5BxZMFdK692cZRbmt6+HiV0t
 FPDnTtyqJ22Nk6RY1FmKvRq0DqmnGQiBuKW8TwCnV0ubW/4dF87nGCN7L+oV2S4XWxKnscKSw
 r+lymHqMn/P6pLRg9z3iK7BAATHR76XMBPczn3A0FfxCg3POi3VR+X+4MPV9jpD/FrjwkabhU
 1Cbhy2TzMe6+LQkX09AsUWKx2sW79OTnobQaVDicapxURaFtDoOBxx36HHpGA2C4FVy9wLhkg
 phDkVwXO5m6eibY1UvZjTI8+1CXANyEmJkh4tJ2lDoVXNDl7Jhq35srSZtHvP4YAeoB9rwmOQ
 1FFP1GzcTaypZt+UmnLhJKiNfNoP8AHmzvA+N/3sUhic05fM+3YU+pXqxfUonSy8JIyTCNDk4
 qGDMiQJwUDa8db56DNkcsOLh/5qq1sHTQDfvgpsbHUhXk7hLrv8dSiLlmRuDWQ/lVjUkpvPjB
 LUdtjg0pBF/33xnPeBoXqu5+DoKY7nGgGMIvH2fIJajcCqXw0LsPZsKglOs7b7Icei9KGc8L/
 AifQocDUsvlbqmbayNSgh0/VkUFObEI2xrQS2GSaTvpZtSLrvZRhodVbR6u9sef1eMSbM0KU7
 84GegDT9mzSSSVqRgw+0jHVr8Gj0pXFsn+1vFiBZfdzKJqfZz3SUqyO0bRN/6ixawtj5lfGd2
 Dw969ZgFv84jsTfFCyhpzOC1IYsdfF5HvYa6QfrgyEQdzloiEjpfnYnqgBXFQwNm/kt3KziHg
 pKdyqUw3TzIfGzMG3tmek17y96vHpN7uP6Tv7/e1UxZnjPAaIUy0msufE9ikVdwnOGkL/RhLp
 1uCIEwmKPauRKX2Xi9aIVH3UtdPLOy9fdVgpATW+G9CNMA8hvu6G0MzE8TvsqylTt4DpGsZ+q
 uDwge2x822bjVC6Wydi27Ri40+QCa5Ak3FXSOcmMbQyNjJ0BSrJO8ZYXXPzWuUbjCK1aEHMCU
 puZgBClR9Fi0XxwYaRWgXFLGGvtBL6qwdeb84jcbr9sg6idRT5TOKyfk5cHcV4v1CEq5y1H3n
 13XwW1ueaIHGexcGZOWocQEa+igQc4iKwAWY41rYd6B6GqVYpiKE9QoXbcea7TQ+HwjQXUg0H
 MCKEMN8qEverCjbSdpUVvatIi1+oPVtN3lJl1SxZ0ZSsLV6YzCX8x3CnntJZoi8MCvwn3GHDR
 XZA6ofIDUbC06s1JuA+ePiLt1TekroabK53mZg53neFfQVC9VDakJ2/rlnWFoCxIpJZsB4GG/
 jArkD4TU72sGG0BPbVz5gA7xI2Hvr75bbFPYHkDyYrgGYzCt2gWX0GJ+abnfk/04KC6NQ7XYC
 IBcHKmPuI40ylTcsmbaY3jj+K8egZpToWje5YFFIeT1VuYPCrg6yM8hy/jemhq4bRYKctkWdN
 r3C22Xnywy14qnm25B/9gdw+hkumdeZdR04U9uWmNpP/1WFgmPqhyyBxlZMfLB3PrhNbVqfTo
 CLfWVuX7YWm1VF6DCt49TTrcD+QkcOrxMk3B2fZMOMgmzi/2WMCIziK/60MICIDaHxlVD+7T3
 lDiu8xmgU6MTNryokZ03+bfI64dohlbF5r1uLZf15Q0dE54KTrut9VfKYgUX1bmfCq8WdP/gN
 6OAKVsC8bf5R09ayzI5mzVJ1azM0y4FMx6y5ai1xssjjjj4FIbyeHamb6klSlq/STTFnWLH9l
 c2NnDf1aqJzFdL1bB5ITa7s1ez3aemFYyN3kRM33qxs4l6Ys3SIj8KTWPYCwUE3d/mF/vKJlt
 ogEnSsk2kdM0p7s0t3ViXE+elTn34aVd1m8694KyajMBUW4NsvLSyzvftLw2P1yQwHR9afwbr
 w35dnaSI53o8gCERBTMng19aQ7R3vudYPNjvzrCmOzlCAB7sMBgV8eGocyfvj9OUMw3l4uUsN
 b4k8WT3PWx6PxRVzUVD2u2Iwgddp4UJ8kjGAftkfIya3GC1xpmuHr7gSON8v604FT8WgntG51
 MIG+evfMuLx78giC8fr1Qwlt2IBO0rRJiUO9rDxKGKT+wxkwS4FrI+SOZv5+xSaxV49URevlc
 mBDclc5ndsUtYgivdJ4w0GKOyZe143c+LieLIlkw0rUgEEEDVYXJfnVKsqJ7oLrjXDIrDIOCx
 rNgkVRz8GuxwAr1LODgU4sOdHxdkRflmhwANLoUI/jQh36xhbvCxTehZ62o5uKw91+EHLicVQ
 mjRMHeFfMKlPFez6x7k273Q5Qym1MtwhgoU2l9AXkG2cPmvun5bKCPaGNYYvxu744A3O12xRZ
 TyRwdYP4oMMPkaN03nsstD1f//8rx7lcOdSLTHeAj7KoXLaupR/VSJz09f3/TTOPJ/l6u8Id8
 +QHEZIfBnbE64fVJXxEg8wGslGcd5Vh3g4bic+YAIoOQJ5VAm4VJzb4qV7gEfXrXEqxQ3Qn8q
 zzGVBXec3S3rxJ2yUoiIG2EOITbuUOx1QHXsBHXvi0f4WpXqgM1iTJ7Fx8aavFvmrPr1eLhHN
 uGEM1fnY9tn8Zw/DlxUIfOgL37fMazDydd60KkSuoWkujdUyaGaHZmQsN+izWtxC+byY2xbqp
 BUc41QDn3APWh+vFEG6UTZqp40O9hvLYpMDuR33m8=



=E5=9C=A8 2025/8/5 10:32, Josh Rodgers =E5=86=99=E9=81=93:
> I had an issue with my unraid server where after upgrading to 7.0.1 my=
=20
> cache drive is showing unmountable or no filesystem. I ran a btrfs check=
=20
> and i received the attached output from that check. I wanted to consult=
=20
> the experts before doing any repair.

This type of corruption seems to be caused by a regression in ntfs2btrfs=
=20
or winbtrfs. That regression itself should have been fixed, the damage=20
is persistent though.

If that's the case, considering that's the only corruption, it's=20
possible btrfs check --repair (latest release) can repair it.

Thanks,
Qu

>=20
> Thank you,
>=20
> Josh Rodgers


