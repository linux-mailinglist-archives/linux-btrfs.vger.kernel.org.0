Return-Path: <linux-btrfs+bounces-15069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B3AAECB67
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 07:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F247A6284
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 05:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413791B21AD;
	Sun, 29 Jun 2025 05:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ioNmlTLV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E338DEC;
	Sun, 29 Jun 2025 05:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751174643; cv=none; b=LGg000QFB+4a2R2fuiK/eHmHN+1XlcQIPMkYI03L3bgprtlhqmAwTKGukWHXNRYP+WAEGP7KyO4iT57O+/R9NbR6V0/yqyHk0yDMPGjKHGi2H2iKbVwSc1p3W7CsODaEMZEFBWAN3IPNSghKLwE51svwOzaJEtwoycZuOMeZtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751174643; c=relaxed/simple;
	bh=V8fEHtT76vegC3onSgi1qb/BEsqpMBiIWV9YQwdBceg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZW7buUcoRDqdUNznhabVTeTEXlZNT8pG5vLufwVeOVyhJb8VbtnN3zIfSdqs+ea9lMKYw65PM7fjh4KrURE/8pHgLngcNr1hRUd6XaznTSiTrPcsiU7WYnlWjaNtg9O1lYYIGiwUkins4GTGRiaQvJIlNaF2a87cFHm/Rlll/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ioNmlTLV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751174637; x=1751779437; i=quwenruo.btrfs@gmx.com;
	bh=L3ziar3UqNTYhkj2768VqnkyLx/1HnEJcaLq6yc74gw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ioNmlTLVUmxOLRkfL8zcp2iZj1ssa5LjYpP7hFfViFM7YMUybfJJmIvqW0y/fcRv
	 TYYRnPi/qFFdi0s1Tyst1laznS+B441qcQnMILHKwGjh3W8zR/+lXfLkMvt9XReNT
	 CRfC0MdjGkxpAvZkabsGp/pa3STYo7WfWeDepYuJlJ0TGGCeS3UfJX8IPYeduXzpJ
	 4OioJL+E4ySkSgQFvPEUJawxRAGSKT0KW0muBl/e2UHin3qXAk+gGzmq900AZYGvK
	 l0/RRzXOty2z6tF5KUKvjbotHeD4RrHsp4YLwLU6KPZTXDAHwbjXE97aSAgTgMuQN
	 /HrOSAbNwfbLaGxH6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1uUxhB3sMf-006P1H; Sun, 29
 Jun 2025 07:23:57 +0200
Message-ID: <d70e95b2-bf1b-4ce7-b57e-9442b484ddf0@gmx.com>
Date: Sun, 29 Jun 2025 14:53:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use in_range() macro in volumes.c
To: George Hu <integral@archlinux.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
References: <20250629050425.139456-1-integral@archlinux.org>
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
In-Reply-To: <20250629050425.139456-1-integral@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mN51IKQr+XgiMSqTbyDUoZpMKBAN0m48ToYRezABTb037HDwkCl
 GggBobsn50y2lOPwdaUlhLCnIraEa5WzIzhALEHTbZWewyKk8ZohE+Czsm6vkqmE9AmdXfX
 qlLCGMc4E21TAUrbY86bmt/P9rnDdH6sZR0pjcxXyWGecEp41q8rz7U7lR542t66iKZnfHQ
 yJ0KCzMXRHGV//TXjXvOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oxzoU1LJBuE=;P9feEv73lHudAdT/MF2WK0Q0qlG
 5ohQv5dS++OvTLGeRhBlLsdl+SY09u8846JW0e9UvQpQpgfKI9vfciSifkd70F17+n8ar85dX
 IurqNde3ESdFO+M0fGL4Kt3ZHQJ+8haJMPRh0fyeGiF8HqK4g8WIYhGirXEM6QN7rbukRHIjv
 /jmUp8GUlxmLhYXOjtt6eGcafCQLnEXnVOam4ruqs80uVkIIOj737e40GMayA5CRX97kMEyjh
 9jNyXONEOeLP6sUpmnO+t1PMcVQ0t7X/7iStSFFlCHPxeWzZuwa2YwxC7cePDO34OD13vXh2w
 QJllRGKCqVIAeDnHcjVMliOEBtiemUd4gz/G218NcoIw+YFZulwV16TUB6NO+mJXoh+WPKNlN
 k4AlkN/x25BdZuQiQodS+uWCpIfCI37kCc/ngegsLeW0m9MxzA1ZiRNjhLrZVtukuQzpOV9Bq
 5Bk+vePdAOKOQEz761pLrb0pHFVG+pQ/nuVpLyhv6Z6ZDB1I5xJ9eSNxO2nJQuZACfgIcoqu2
 rmYd5EosNJNnyUTGDcki3m3fbe2ondSwiDhYCELTchMm18f+0mIuN76TrDX/dXITudXesdS/o
 SFR+8FD3sXnzF8N9tAzwuwinWgfleid/GVQe0lyUGAg2raneYfIe9oG2MbSTjO8a6nWD61zg6
 J8/vx5d2L/Lo+PcZ6BIIV1FFnYD7ma8IU9lvtFmsnvy9EAktggraIhL7Grlqc9N/2neApJytF
 QzlU7d+9mw6BUo6JFWKyepF7WZjwaT1ZQhy9WMovfIJPqJ1LlycaD69dp+l03VPP8QAksjif3
 /vZ+cIz8CW/4oYw0nqbD63JHFCwAC70THgEVc1nLYMORJatnr7p5Qc6tiJKQFKvRUkJ13ei2g
 jgMhCJRyRBZqsRWhUnn9z2FllqMnpyqykae7H6bhJDGXc9NQ8/LR45jkHzzsGk4Z7LCRsRDTk
 k4fpmTykYXBz7FgX3FHEsVqIU3aXuEhwQvqBNDc+Ncy6z09NWF1qrvRZ8uEbYiqy2EQ0h2y0g
 eNhChcbJ0SM9DWMvitWCALQbqpDOb0cQREfZwMKZ5JShhHfZ64PH1pD9FMZLN9dE0gDL9/YBG
 B9JpeCw/R3teWm5QZFT6HyafDG0zka9a/UtfhR85RzMqjGPHhkf7XJwnGNFEHasox9WWLZucO
 tGrnqiiFMe3nc7hbjRDyLEBFAzGCzuGDQqplOm71JqpSpAY3QJplNTYm9/sEHK8DWLCY5uAnb
 fxjugF2h3fMlOXSLjAoIbOHQnBBR551d68p9H3oAQAbcdmPuEfJ/L761Tuw/d12S0uCNKsOJD
 ro7d6DwEi6UREuj/s5Z03p3GicIMWj4Y932QzpGO06n25j1dppngE+QBb+CraJdvOed2nbIvm
 qoxDPgVjF1ZqTZ/6N7fENWX0xa7mzlfEwnDvqq5QPWfqvXcVj9yiz5EzTMcbK1qjCRlYrh48F
 7Iy12IN1uWggxf1Dldw7BpKihsS1zSvTfxgrnKW1WYf6963vtBnFNiewrnS6bkPkbsBWboiT8
 yVG5UG1d5a582ju1Wa2c7wcDsXLxxw4esu5p20wtu8NhN+a5jU5bgczL65SYdazgUvgF6PyR9
 aBe6ml/2WczuDvQbACRPwtgy9gDMRBZ8+8VF+aS1V1w2xiHOcZ57tD4tsEjpmn6nks8IfgJfT
 pplZxcxql7IZYQ51hcDqfW+gMjuuYxQ6P6PVyOv98Agi6YKq08hE5QbJGqVdoVU5z+X8tle3c
 dbt7UXXGB6dO+EyVJelY9JQCSAMULcF0/rrSnnkQwHfbeFrMPmMAuCTG+KVPTAsLol85CFszL
 +L/6Aj3triP8hAAT3ew+FpQqK3+9CvKSM9aaxfDVcxsZHFCzQbcelxHUIKWpGZyhtryH1Mi2u
 GL5Smf+WfFmO9Lf5i/NLFO+9T3hnPGPyDxK1H+ol4oJMUHmDpchl7DzU4zE+M3Q3FNCSCkMeT
 Gziv+fv7j4NKTz6JmqwoYXtTwNfKUYzK6OjURrxb4uTu8adtEP8nhm2qb/zmXys95h7QG4JWg
 gMfixaBF/Vz8WOsH/eZeVhNvYfa3UVxxqzDHF0cUYPStUD3Fca1GNqM+XZGoT7xE6NkRwLQ17
 nh6IL1u1incQnCHAYwXJ6thVFU+qye5Nf90fo463caApnuXFqc+fDmo31b0k10jDl56BQHNYP
 lcWbwqF/T/WCvhZMBt14uyWL0kLcdG4ZKvTQ/JdcjbcF2mOX6TwfJ8h8P0fxwRbuuPCp1Euac
 lvf4kPUWOjSJdX7ETtum/KyyJuBbfzS8exZtVQd7KdIOJ/xAbEyxln7THgZUz5aAs+Cy4TOv9
 5I5TbWDT7egYkRWpWMA2Ma/dSc5eM7QKt7cHMVmFZBpX3WxizDbk+NSY90S8pnWiL8tUE1MD0
 bHOxWzo6pi4suQKAJfpZ8D9rq4VUxU/gngrqmm1uBzW0T4cfRfHYnx9+peeIV81Sn8In6F/JB
 jh5mO/mX+O/nsxusN8p0COibFo/5Z8t69SGEEhY04iptbknbuFroiTCLPSn8xmj0X54kQX19a
 e5egTUpinQKhFgZ3F06/gwqNYKNOiLKj+LQ00jAbsmivCGuF3eaAlO+epHTMDw1bVsoe30eI2
 xMF909yfGByzNIGgDj8KYdU5TGMZleIsCB4KOBdS5KQLRWtIaPA/K5Fv+LrqSNXY6qDIK5nNz
 1DWxwz9VV8tZ4aifNWoHRwxaFr2ycQ7kLElQoDVquMQiHEiO+H9CWhPalRDXyJ3FidcZ9dCoW
 OzmN2o6x9UuRfZrXMzi+ZmnYy9zaI57vsWf9F+GoOVP4Q0GeWV6JOXtPW+GuUiHpvGg/RRoes
 CwJ77iCFnhnNa/b4u76bQn/BnTMqpSkwLuhoqV20zU7lax6hr7hmETZi1W0qA1XBh09yQ95zL
 NPcERjnBnRFaUKwOiK/+kFcA440cQVK83H1HiDBesOK83h8XgdbGgdJBV8UID1y6nnnJ4jXmj
 02ljY5zVohEyizFJ8Q7NnkkVnHDiHqPa1M3Q1AgYBYE8LIoTJN1NFY6kmpqBDddIpn8MgzezZ
 7vQAFTQSxxuhMXFvZmhwKLeHENfv5xXOaplhRzYhWBHaHYRJqvhAGF7Bt791rhNvlmjlpgf3L
 f72GISwGTvqHSlmrKjvkwlYTES0YO6EPYgF8oAQyHEmOpxlR/Frbzu9pHLYgYrviqPOKMtHI5
 PNSRcRqLvFBXxC0yhePa79tuUXJ70mUfYBHVAD20qPcnBNwytzUa5V44dD9sztNppLc8H2ekN
 VXLFVaRbd3qq3fj1qmLRirl3+/Uivn1H2rzd/zxDFZL9P1V3rSl1qxSSejJRPeGZ95x69jb6J
 rk+Ri5NWKsxn/M9gMqS8BLZarwRPR0BQXqc+0pGxPo/1enjmFcZFqV2iJK9u0tG8RZgb+Z9VL
 Wz9XCMfEu9VlzuZ5rfcaC0ibsHufKsBvZCSi2X0FO8Dg9Ynv9E0uBt1eJILPV4EcLHI/HixUs
 7Il6Bc/bkEA==



=E5=9C=A8 2025/6/29 14:34, George Hu =E5=86=99=E9=81=93:
> Replace "if (start <=3D val && val < (start + len))" in volumes.c
> with in_range() macro to improve code readability.

 From the comment.

  * Decide for yourself
  * which behaviour you want, or prove that start + len never overflow.
  * Do not blindly replace one form with the other.

So please explain in the commit message that those conversions are safe.

>=20
> Signed-off-by: George Hu <integral@archlinux.org>
> ---
>   fs/btrfs/volumes.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f475b4b7c457..c5479dce0cb2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3198,7 +3198,7 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct=
 btrfs_fs_info *fs_info,
>   		return ERR_PTR(-EINVAL);
>   	}
>  =20
> -	if (unlikely(map->start > logical || map->start + map->chunk_len <=3D =
logical)) {

E.g. in this case, tree-checker should have make sure that map->start=20
and map->chunk_len do not overflow, so it should be safe.

Thanks,
Qu

> +	if (unlikely(!in_range(logical, map->start, map->chunk_len))) {
>   		btrfs_crit(fs_info,
>   			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
>   			   logical, logical + length, map->start,
> @@ -3841,7 +3841,7 @@ static bool chunk_usage_range_filter(struct btrfs_=
fs_info *fs_info, u64 chunk_of
>   	else
>   		user_thresh_max =3D mult_perc(cache->length, bargs->usage_max);
>  =20
> -	if (user_thresh_min <=3D chunk_used && chunk_used < user_thresh_max)
> +	if (in_range(chunk_used, user_thresh_min, user_thresh_max))
>   		ret =3D false;
>  =20
>   	btrfs_put_block_group(cache);
> @@ -6211,9 +6211,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(str=
uct btrfs_fs_info *fs_info,
>   			if (i < sub_stripes)
>   				stripes[i].length -=3D stripe_offset;
>  =20
> -			if (stripe_index >=3D last_stripe &&
> -			    stripe_index <=3D (last_stripe +
> -					     sub_stripes - 1))
> +			if (in_range(stripe_index, last_stripe, sub_stripes))
>   				stripes[i].length -=3D stripe_end_offset;
>  =20
>   			if (i =3D=3D sub_stripes - 1)
> @@ -7047,11 +7045,10 @@ static int read_one_chunk(struct btrfs_key *key,=
 struct extent_buffer *leaf,
>   	map =3D btrfs_find_chunk_map(fs_info, logical, 1);
>  =20
>   	/* already mapped? */
> -	if (map && map->start <=3D logical && map->start + map->chunk_len > lo=
gical) {
> -		btrfs_free_chunk_map(map);
> -		return 0;
> -	} else if (map) {
> +	if (map) {
>   		btrfs_free_chunk_map(map);
> +		if (in_range(logical, map->start, map->chunk_len))
> +			return 0;
>   	}
>  =20
>   	map =3D btrfs_alloc_chunk_map(num_stripes, GFP_NOFS);
> @@ -8239,8 +8236,7 @@ static void map_raid56_repair_block(struct btrfs_i=
o_context *bioc,
>   		u64 stripe_start =3D bioc->full_stripe_logical +
>   				   btrfs_stripe_nr_to_offset(i);
>  =20
> -		if (logical >=3D stripe_start &&
> -		    logical < stripe_start + BTRFS_STRIPE_LEN)
> +		if (in_range(logical, stripe_start, BTRFS_STRIPE_LEN))
>   			break;
>   	}
>   	ASSERT(i < data_stripes, "i=3D%d data_stripes=3D%d", i, data_stripes)=
;


