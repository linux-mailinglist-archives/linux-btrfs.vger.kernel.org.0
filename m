Return-Path: <linux-btrfs+bounces-15636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B68FBB0E5BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 23:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739B61C240E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5015023A564;
	Tue, 22 Jul 2025 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bcsT3lnx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0753C47B
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220937; cv=none; b=uemNq5IIUMqDAN0GOIPeuxIvJwVVs0tFwTLTITkVC2GVB12X8HO7Dqo/B3vRDB00lnDe5OaPRCiH7OYduyXbFGoXLqJhKO7GvyRoFxjjYGKDpAY8EdHgvSOB6DdwcZmmar7QeLXo2Ww333dG1xc/xS08E2xKcefQWRI2UrHYf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220937; c=relaxed/simple;
	bh=9mq5zCzIh6xxyoEC0951ebVvcbu6i1uCQAIDAa9d/ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHTOFU+mnCAcgMbEXm+sayHPq+xrneoCZWsz5KzhXAHXMt364GYHJD9Fg4IM/6CpOgLjpQkLqxIF7aGqY7/radrV3Hi+vXowNJB/tZb3gbXAOrkdgYF1bkQ5N/F0o8TwtRmn6rjh2koKPTSZQyE1mfOK5rvFcW93kWmjapi5fhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bcsT3lnx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753220930; x=1753825730; i=quwenruo.btrfs@gmx.com;
	bh=qkFl/cxEg85D7e+h3V5YCoVUrIfwlnCBco0omPNucbU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bcsT3lnxtRW2D8O4C6PWVb9Ev6lHkHSpMwQrOu4QFShXfN1A3kIVRzFzvJ2ljxDm
	 CNC6FfKnUZayVHsp9I1KAXloAB4+ngvskDdUv47XPuH5fEKVC7A1NeczUFRhLVLE/
	 ipvYqYVvWb6p6AZeqB6WQiMZS5uJ5CaA0VoQvL0viW/3P5Dk8BMr3fsO/N6VtkY0y
	 97GLJLIE/YCrGLsGbAKCZDeZMedDH/+ksQ8nMAeTzvJe81yHFNzHCLruAjM1QlLx/
	 nhrDB3oBl0GfLy2tZ7jkvusMGokDiCvIqR7SBlK/pcUgKY13HtYjPCYBLe1B/pqWr
	 cRGBHhj8fT3Jr1M1Vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ81-1vAchL0Xf3-00RieB; Tue, 22
 Jul 2025 23:48:50 +0200
Message-ID: <c7e2fcbe-05ee-450c-bdbd-4d41c9bd6fbe@gmx.com>
Date: Wed, 23 Jul 2025 07:18:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] [v2] btrfs: Fix incorrect log message related barrier
To: sawara04.o@gmail.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 johannes.thumshirn@wdc.com, brauner@kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <20250722153840.5620-1-sawara04.o@gmail.com>
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
In-Reply-To: <20250722153840.5620-1-sawara04.o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0WtJiDfpdj7Xapo07zR1elDqBdO+g9zifpLDBLq1vNCQhir6wjj
 GyJKO99MwfjKQgry10pjGdX/bEI6N5dppx6cTek/QyVuVowboggKfaztGIHRmYNKv/ltgB7
 y2mqttEVT6EPwGZHauIwpapR4nRq4qIn/fnzsguX9U+xRj+ZVLE6kdv/oEzj1t4yBKPaymP
 J2s4ifIWhF1T5uXIr29Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qXj/kiCKfN4=;cDhn5uAm3N2IzWTXZHQfh/3MRiB
 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



=E5=9C=A8 2025/7/23 01:08, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
>=20
> Fix a wrong log message that appears when the "nobarrier" mount
> option is unset.
> When "nobarrier" is unset, barrier is actually enabled. However,
> the log incorrectly stated "turning off barriers".
>=20
> Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a0c65adce1ab..51b910e2774e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1453,7 +1453,7 @@ static void btrfs_emit_options(struct btrfs_fs_inf=
o *info,
>   	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
>   	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
>   	btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allo=
cation scheme");
> -	btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers");
> +	btrfs_info_if_unset(info, old, NOBARRIER, "turning on barriers");
>   	btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
>   	btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space cac=
hing");
>   	btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free space=
 tree");


