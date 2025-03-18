Return-Path: <linux-btrfs+bounces-12392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08011A67E78
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66419424BC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 21:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDA206F08;
	Tue, 18 Mar 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sRmva31i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE01D9A49
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332136; cv=none; b=XytCId13vKjq4pzDXcHBlQ+6A9xQPpcV4AMX5IuZ4l54Hb+xwiTzqPU+w3GFWo42kQiiBYY9DNSahZCQuN+EcC2+vOE/L1g+kP7wxLtyZchzGUopKV/+439nMZwQCkxb98W5IMQ4SRP44phjb6pQEosEtz/M3SXZDeIBaREqcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332136; c=relaxed/simple;
	bh=965O8YXyqZCcAzwuQtk34s3bpIFoqr05VvY92gFTZ50=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xok44Uuz1wLfXDIMmE0JNA7Bh5b3Sj1XzzhoMOzuKCTr7cOlLTCIc7PDT1Morir7wYuBVsBvceP44uEcSxDy58HmcFh2x6+phBwzjkZ6HQBqyEnMuXf19WeOTQnU/63+0C79HjqJgfvI9dKNWnNRrmgYO5OFZ4sZx2w00kh/Aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sRmva31i; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1742332132; x=1742936932; i=quwenruo.btrfs@gmx.com;
	bh=rEPIqqlW5eOa6bJKTp46092fgkKYm/dJUNB0mgDSKso=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sRmva31i3uLNGxXJ1LwwhOSpwKIg4hy7qRZfZFKljb8zPWM7ohMsVTBjklCsceC1
	 MGUeyY3L2dYCctehDSZ4RIxGGHQa2YhSXZK9mI4nldYFTTa3AyOE4tdYkPsP72HLG
	 J+q0HOhe2AERtl/8I235Wnc5QGuGVscWS7wPGja9WRTK9kqkr3tCr9Kn4sud8eXPY
	 94A3vblco8kJbZVA4k09bbYyX+A0hAcMyjr69hWoBAh5j90bXFL2cOvd8ZktdvX1g
	 fGFOM6SnKkdnMfO7ZO/NuKmp8rL11jFAh5xfvBUANzbLsMkANlGaGKz0WrekZT4lP
	 ATzhuQZ180VXocyDyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mj8mV-1tHl822DA5-00bYEt; Tue, 18
 Mar 2025 22:08:52 +0100
Message-ID: <335d6148-6a0d-4d36-98a0-af80053b9519@gmx.com>
Date: Wed, 19 Mar 2025 07:38:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove call to btrfs_delete_unused_bgs() in
 close_ctree()
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20250318155659.160150-1-maharmstone@fb.com>
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
In-Reply-To: <20250318155659.160150-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MkE+u3wOCPLs1RNCY6wC5B6Etyklf7hzaPjF9FoUwmBIhrqmr0K
 Az+CYW1cYwZW3QySmHQkQk8tRCKtDBeM1UPJHv1s0aYvpYeL0P2x8A8viO7RXfH5DwTyfLd
 AXHS5NUjQMjpBTl3xuBwGGHh4KbH4E210qaD7B4GJCoHLFRtsoZURQqvbks4QYuAudfdVoY
 tKk1Kj6+d5UuXcL2GfsNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y6hejy2CF0o=;wrIl2zhGDFezUgfmmamCBQnmDPf
 vDrXimEsaC5WQ2sg6ssoGzB8QhDsVeRvC5B14AVYw54F+b6HoyF1xhBj4nZGiijVO5yL7zsMf
 fTFOdtg3WucJibkc8Cb+zejCodcUCSa7r03p0+Gv7pAm8cBfw+YQjez+Da9LSOtJuHBP8d2VB
 MMSzYTE0tkaIGTuMN6ZpTEMyq+Dw9+of5r3NsVDQeJ7ZaVFYl7X1Dv93tgTu2b/CII+m3AiQE
 s1bwTG43qS7T9Xl892E28SNr2HB0xO4kS7FqMCJ8ACySlmx3NDJ9WbpJbnWUsWMlaISLo/DMW
 pVIWJaz3MbdG8ATrq/sEpsLo2o8uUwfNMtPqEC/yxdxJpYALB7190WF79pWmS21crdVOwtEiO
 werLP/fmePIVAyB8kX0Yq1jxZThqcUDwGPSelpU1kvZgvhnb5Icq5G45gNV31tJrFhzDywa2m
 Yb55PHxwT/ifdwoY8JXaDBvM4ayZewnFuX8IC81rqJafOosFkSay4vXKzvIoFh7oxb45rHHbh
 8hQLLevpBSyhUhOtqOXaKtPFC6p09WE1Ith2vqPrChjwc90egueYov2kLaNATKdoOX5rAmMBL
 EjFogV+4s1CP605yogR7OKeeJhBaKuKsqoKXbl3BNktyFQP7x/Db4BVjcYpFHgUPG0Q21kfe1
 jLfwd2kaRFkc6IWzZNA4DiwuiKGwwqMgSA/YdeZIuLEpwzD/MIMAUj1sTqBY88azVDK9TlLsN
 R0eNpE6MciiNL7DVNJ/VILJdoMhBbLsk1UZfJKv+6MrW9nMsphlXDEejR8DwSzgusRnOmJFFp
 DEtWoO77rYWtxyryoy6IBrejCbbcKFTpHSm/Ma/2hkuYtG0xneKeg1h8EEY8QHexuEFbA6tLn
 FXmUxWELEPVikMasWR4AqDLXYz9dZcCUU+hKVCJY2TeskHa+UOTKCwHqrZetzSJYfMAWtwxe9
 qvfocpgDkQ8132A2iWZhq7QxkNuwXM5p4SaN7YqHiCJCMY7do3DkdMhoKKgZ/OvgdFVLbtCGb
 zGOwtEm9abjb66AszzMdVp/sSYLgVlUR9G6jEcfSNBTLCKvj6dGtB+Z0xo2S4XpaDg9UbYHH3
 mR433dfOVXGruNIDjJm88dSyx1ohO6339dTzpWlO7f8Fp1E6G2rhh/I6ByzzJo9YNdVtwZYyf
 hXbcwocxclvtrl9FssZUctIqP/saatp3FKHWBiP98OAkBBu0XEYtMl/Wo1wQXsiXXW5dzqOpe
 zFmAyRHiNEMYsteDeX74/w4zccHdxysqT0HeDARz5AktdWcbRyytmvA/NZU8pDUvgUwHgnCsa
 ObrMBll0dCUaRw2tNKPwVgiVqzXdtkeKLduonqtnuKM5GJD/PZzKwPvlYBGLWHWybHdBHaygC
 Y0MLuML/NVjhbLnkt0VcLrGPQijkkS7HuYXUOEpb8BjyuPzm+nHrPij07Tes4DTxyZK5PQC4/
 s6Oq/izbKJLFGyrNHaJxfH5273O8=



=E5=9C=A8 2025/3/19 02:26, Mark Harmstone =E5=86=99=E9=81=93:
> btrfs_delete_unused_bgs() returns early if the filesystem is closing, so=
 the
> call in close_ctree() will always do nothing.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1a916716cefe..7c114d5d0f77 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4412,12 +4412,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>   	btrfs_discard_cleanup(fs_info);
>
>   	if (!sb_rdonly(fs_info->sb)) {
> -		/*
> -		 * The cleaner kthread is stopped, so do one final pass over
> -		 * unused block groups.
> -		 */
> -		btrfs_delete_unused_bgs(fs_info);
> -
>   		/*
>   		 * There might be existing delayed inode workers still running
>   		 * and holding an empty delayed inode item. We must wait for


