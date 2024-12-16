Return-Path: <linux-btrfs+bounces-10402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925A9F2C13
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAB41883F24
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977C1FFC7C;
	Mon, 16 Dec 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EB4njlJ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377B1FFC46;
	Mon, 16 Dec 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338295; cv=none; b=BGmxprPnl87o8oseTBRQyREypxRS4hupyV9VcSWiM3Q/Bw2dxbPnM9wcYjocaI+ewqrddsCsDb7ethscyP68Uijlxa+dOXGYME4Vxq7faVzcSl3hbqJzaF2R6zoQ6TKlDW4BjYQs+kRydwky7fx/br3GwpVd9m4IbChFl2/GGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338295; c=relaxed/simple;
	bh=+0CRY7YoBxaiDhSiQ9UO3uPz+oVPE9BxAjrUiun3BRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jC0HMOciX6ZiAXDMfev+xfENQNM+aXOIQjcNX6FwbAKt1wy0nguHGdEHwxcseNigKcR7bnKgFuHDSGMopmGqnm6QM2fo8LRCTA5kb5XPm7bCZgkiW1CpBUwhTT63U3UZfEbtchpWHOfZ1X9GQ/SzdWtyvvr0XWIHmoIVxSCjvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EB4njlJ7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734338272; x=1734943072; i=quwenruo.btrfs@gmx.com;
	bh=VVo2iQa2OqykvIwVRX3t3WWQluYM++WCOu7KRLbe2VQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EB4njlJ7wZnJaGYtLcT5vckcUxTR79uaNWEI3AvXG8dCQcymyi5+Cu3ZgSm97tAx
	 4ul2qBINy5+SaS/p1CuWazDdo7t5XkACWJS7bSoVmaf3I5u/UmIC3ckllvZeJlwYG
	 yO2DRmMSjt07cBK3XWkWXnC9gHF/pHwd+H1BkKocbvzgQ4qbDXlOFEOlzUUeBI5Sq
	 NkP0xF9Q+dbBWcDPXCPFpEbn+C8LxmdIBzpGJsafnoFUUEm4NE/MB5F9rLtOk7SVM
	 CKnMK/meNfc+50wqAmERE3sHQNowPOXLiMaUanpr+DbvVxpurErUD+IOYk9kqtmaJ
	 v1B80kv9b5qh8EGO2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQv8x-1sz7ns1zUd-00MfFM; Mon, 16
 Dec 2024 09:37:52 +0100
Message-ID: <b46ad433-04a5-47d4-9cd0-84f4ab3b86e5@gmx.com>
Date: Mon, 16 Dec 2024 19:07:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid opencoded 64-bit div/mod operation
To: Arnd Bergmann <arnd@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Anand Jain <anand.jain@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Boris Burkov
 <boris@bur.io>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241216083248.1816638-1-arnd@kernel.org>
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
In-Reply-To: <20241216083248.1816638-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7bemtGciY5P/jAHqXkVt/PZ+Bs2Ujc7n2pNW8RISo5qGIkVwrN+
 zajiPZzTePtr2FtAQhpAvSL4ILIa+isH85zr9zOUK2itUtl8UiBsG5j91XsXfoFXzVVnOel
 0ECIsIKVdZUWNH2I7uuOnLOduOcb7lpK3vNnqBXZmQFEY8TG4WHb3jBPKHmYuwoyJgACtU5
 hG7AbXewACfXBk7tGvb6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OhJPsoBUczw=;JUrKA7cTwWqoXTSnOCFv08Gm+W9
 f7WO0ThjOom9fV1w22HsqBRJLT/2+NhcKjSZ2gbk/p2kO5jmgTWPyHfNjMv/4iHe+ObqcCsTo
 lMjTrXb3RK5ocCidCmLQ9Y+fo9/P+T5D0rmK2askasnQ/Scw3Di2i7VaA80GHOKKN8wSwMvSe
 DR2cnMeI0jV0yvcIvoNEzps5ZpNxF5yGIueS44Q9cOMwnGSuGMz2R3nr3DocGK2OosuU6lFvj
 mLcc9wjD7dGHSQ99FlW4+8Tg6nYXupQLDX0gpvTqiT82f8kaBoplD7+nJ2gGieYFGbtIqRIyg
 l6sNeEZQdpqIXFNe+OOoTFFYS0hn8wfOmnW1HsH+67MgVp/qUwReqik78KSNXPqgTJdz8hYEA
 qCg24YTaSut2ZcAup/CIyu8Fag2fmioR7onYOvFA/OYCVJ9KnWCc6wS9boQFvsTQqfhjk2z3Z
 sRWAxq0wdYtcB+WBNTnniqFOHwpCzxAQ3mAYW/YC4O1zjDFwrfgFT+afMHTkhVMxrVRiK8AzS
 Aobrtcq0Pzkb73zVK2FRsUSxstqabJa5zGxMPGjGMddhnlkGonNR6k9XZxXKhQBCSdaPuiC/i
 /QjXZ+RSWDdlTgppEEu4HE8/IZZIncokil0gUkunbBIV+Y8TZC0IIshJr9SPGj3OFP8kRVcCl
 qy+8GyMPj9uoRm+NT+/4Gxc8k/3iA3ZWfbb4d4pOH05RkSz9McGET8qjULA3ooB+VSREqFver
 wcR1h/N1mG6GdW3SBFQxf7LJI0d5P73TyLrjIhF45H1XGDcwMCihmn1wYlHZ56Utp/NvzKrbE
 nES+/O0Wos4miWXnbNfNr/Uez6L2V+IcB+LFVlsaSw2kIHhSLpfGolqSNnP18HFEt1JFoEydX
 6sC2V2ViVNoAhyA3+KctYmi384d1A+NjPPmjewiLzzQnj1o8BRirXbvBLmULhMVo0mJFqc0p2
 bOX+MnMKY0hk+Fd9a86Aws9g7cHOdzLwtaF+eaCrHzPITJpl5A8+FvjlNBQuDJNk5oa41ADi0
 1xphE4NrzHW7GMyW34zVulhPiQ/TRUlkRWVs/DR/N/V/zDKla/+2nXlb4XJVfBXdFZ4szzaHx
 dXAOl/HDhXHJaLz3oahWgezETZRsWS



=E5=9C=A8 2024/12/16 19:02, Arnd Bergmann =E5=86=99=E9=81=93:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Dividing 64-bit numbers causes a link failure on 32-bit builds:
>
> arm-linux-gnueabi-ld: fs/btrfs/sysfs.o: in function `btrfs_read_policy_s=
tore':
> sysfs.c:(.text+0x3ce0): undefined reference to `__aeabi_ldivmod'
>
> Use an explicit call to div_u64_rem() here to work around this. It would
> be possible to optimize this further, but this is not a performance
> critical operation.
>
> Fixes: 185fa5c7ac5a ("btrfs: introduce RAID1 round-robin read balancing"=
)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   fs/btrfs/sysfs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 50bc4b6cb821..67bc8fa4d6ab 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1433,7 +1433,9 @@ static ssize_t btrfs_read_policy_store(struct kobj=
ect *kobj,
>   #ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	if (index =3D=3D BTRFS_READ_POLICY_RR) {
>   		if (value !=3D -1) {
> -			if ((value % fs_devices->fs_info->sectorsize) !=3D 0) {
> +			u32 rem;
> +			div_u64_rem(value, fs_devices->fs_info->sectorsize, &rem);

The original check is already bad, it's just a IS_ALIGNED().

So a much simpler solution is:

+			if (!IS_ALIGNED(value, fs_info->sectorsize)) {

Thanks,
Qu

> +			if (rem) {
>   				btrfs_err(fs_devices->fs_info,
>   "read_policy: min_contiguous_read %lld should be multiples of the sect=
orsize %u",
>   					  value, fs_devices->fs_info->sectorsize);


