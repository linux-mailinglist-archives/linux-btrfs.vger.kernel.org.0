Return-Path: <linux-btrfs+bounces-4077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75B89E504
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 23:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7AA282686
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E101158A1C;
	Tue,  9 Apr 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DTbSETZP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B87C6D4
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698547; cv=none; b=thmf4Zy2ja/+NRAbLrnXrO8oAjf4GVkRv/uW/bHG/JAv2sW2Z9pgI8EYx8G9J0E9ISv6Ze6zFfNuddkhh3sk2ebH2E7ZQn7VwXsocgC9oQRZ1GKWQxi3ELIWzEjeiJ87G46E3fzUsDnCLxAbUdclc3u+deeFUZeUClhS08fRhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698547; c=relaxed/simple;
	bh=RjYwVBeSjQEANCApEFnuJ9/P0ISucl6bE5GrFJT/bog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Obv/J3Jhv/p6NRIUO0N/G/+Q+8RCGa08IIV5PM6wNGqe1GurrCfizUGXOaq1+QyKeq7uYlO6+WUfin+cz5qUEEWP76yksrHMnGAWl2YA/u3/HjZJF19qT6iIYLHnRv3b/e7nzwa8EogpMEo5tzMJmFAafloJKN5myJsLSefojq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DTbSETZP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712698540; x=1713303340; i=quwenruo.btrfs@gmx.com;
	bh=U7I4aW/M96EKO5SoEyhUghsQhMXjhltWL/B9PRgXIfM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DTbSETZPECybWBC9Vy3RAmHOZGRIF/mXwFOlR21PSakTl/fWVmXYVMcLgzgRS7F1
	 jsu45hmjxbnRBq5xyE+65oM0Q/lpCu72l3eqIgJ3PKQTbTXvGM31Ag6dN1dp21wrE
	 3cmbki3zj604kpkSLCZ2bA6tvMNNGBLumtwAa3TVKsLkjve5pvvmHAHCslPk3QogO
	 I22XZ392qnGxtCc/JES47UaWoK4ag/6Bzuz+LKawHPev9E7IYrFzYNacmKdpJ44VL
	 akXhdQuHSbyyhd+d0+G0tlf5Cfs2NyEWBprW505ldRRBI+UWkgDb34wk31761j/4H
	 Cz4DpTgxNobsd6DquQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wyy-1romp53ygG-005agR; Tue, 09
 Apr 2024 23:35:40 +0200
Message-ID: <c13f0fe7-c70d-4ce9-a821-11a6acbdfc2f@gmx.com>
Date: Wed, 10 Apr 2024 07:05:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: run relocation repair when/only needed
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com
References: <4f457478390d84f5ecdc3818e239cdb652654ea0.1712672186.git.naohiro.aota@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <4f457478390d84f5ecdc3818e239cdb652654ea0.1712672186.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vkfCOgUutpN7hDyjj9TnwL7NC4by+zN3rNPQF4U/RcsWnGVgS7m
 Gh7md/bHTLyVwNms4Z3hxQKG6lMoAOVIQWcPUU1CP9lYHQPSKyJIJRGoWnX+wf1qD8dUbG+
 1fxbGrA1QNnJishbZnxdnV9kYt9cxpqDhdq9fuYyYvF3uHHkcaXfubLWbsPfUx38tgHIF0b
 0IP+DQTdWV/ZeetrN+iaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S8tiMuUG2/8=;oJkUoFi68ltl6QNSrt/xtTgXMGS
 pvay7QsD6GE7fpHYuQu+MiSsMomBKKIOgOcmEMPKgascivafBlXHAYugsLFt8iMx+3SfAv0b8
 XJ/V/gC2gkkaxpmk2nhyTwQz2yheNKAlPM3dz3aW04giH8y9J9Tx2yqtDn34UCQU05kD1jTLX
 rJHlgZUI4ktqHJasI+CHuj7c1nZezv3sfnul/OetHsdcNek529s0x2FVyM/bTUdgWZLqzYvBu
 I0OYfrQlSpzsL2vEIWqwOiC6jdFGSu5LEKvfXGxF8sS7Dqz4du4p6rKSyHEbFhaKKL0WtWim1
 w028rXQMDvbHKrRwNlfmdlyhHM8JK8ZzNREtylLz11AqeHZnWnCwHqEjK6PLB2wKqAzt3qm5x
 NCztW4kUD/c6k/7rHSXORjurVHcKXOhHEsiNintelxH0j+Pasd5LlyT3Ja/ci1TgNvQF4Wk9L
 InuON+RPN1XX2enqhFcH8ZvWgkcdbs/mfFmtg13frk8vNjusduDsEaXyWJyJ3kvn1Giv2GrEu
 +VYkx0IsoFtFCPwXeWjGDMw7tDImXa/hBWQqcaipwXk7nRcZdIgfjFxwR8M0ggmld72z0Mrzd
 OpFruyOjSvMUW6M/IfsLYJQp9cryyfot+J6qaX/U7Ux/A15s9hyTdxlk/6Cdq0jAqIh9+gGxh
 lrG6iq39PToJjVtiCcBqYNX6gnRKW/uQHSb/ILM0vXsLm2iDU6i+koVc5c3lG4ocZrw1bkgf6
 7TQogGL35GngLhPAuQptrRvHTYwvku/ZDM0o003z0Lljmry2tmc1N2ETFpZfUpunFb3yhbIDv
 B11tvLKsnvnHORjQ+LsS9yFN0eq3fwl8tD6wvbEf3t878=



=E5=9C=A8 2024/4/9 23:48, Naohiro Aota =E5=86=99=E9=81=93:
> When btrfs scrub finds an error, it reads mirrors to find correct data. =
If
> all the errors are fixed, sctx->error_bitmap is cleared for the stripe
> range. However, in the zoned mode, it runs relocation to repair scrub
> errors when the bitmap is *not* empty, which is a flipped condition.
>
> Also, it runs the relocation even if the scrub is read-only. This is mis=
sed
> by a fix in commit 1f2030ff6e49 ("btrfs: scrub: respect the read-only fl=
ag
> during repair").
>
> The repair is only necessary when there is a repaired sector and should =
be
> done on read-write scrub. So, tweak the condition for both regular and
> zoned case.
>
> Fixes: 54765392a1b9 ("btrfs: scrub: introduce helper to queue a stripe f=
or scrub")
> Fixes: 1f2030ff6e49 ("btrfs: scrub: respect the read-only flag during re=
pair")
> CC: stable@vger.kernel.org # 6.6+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index fa25004ab04e..4b22cfe9a98c 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1012,6 +1012,7 @@ static void scrub_stripe_read_repair_worker(struct=
 work_struct *work)
>   	struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>   	int num_copies =3D btrfs_num_copies(fs_info, stripe->bg->start,
>   					  stripe->bg->length);
> +	unsigned long repaired;
>   	int mirror;
>   	int i;
>
> @@ -1078,16 +1079,15 @@ static void scrub_stripe_read_repair_worker(stru=
ct work_struct *work)
>   	 * Submit the repaired sectors.  For zoned case, we cannot do repair
>   	 * in-place, but queue the bg to be relocated.
>   	 */
> -	if (btrfs_is_zoned(fs_info)) {
> -		if (!bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
> +	bitmap_andnot(&repaired, &stripe->init_error_bitmap, &stripe->error_bi=
tmap,
> +		      stripe->nr_sectors);
> +	if (!sctx->readonly && !bitmap_empty(&repaired, stripe->nr_sectors)) {
> +		if (btrfs_is_zoned(fs_info)) {
>   			btrfs_repair_one_zone(fs_info, sctx->stripes[0].bg->start);
> -	} else if (!sctx->readonly) {
> -		unsigned long repaired;
> -
> -		bitmap_andnot(&repaired, &stripe->init_error_bitmap,
> -			      &stripe->error_bitmap, stripe->nr_sectors);
> -		scrub_write_sectors(sctx, stripe, repaired, false);
> -		wait_scrub_stripe_io(stripe);
> +		} else {
> +			scrub_write_sectors(sctx, stripe, repaired, false);
> +			wait_scrub_stripe_io(stripe);
> +		}
>   	}
>
>   	scrub_stripe_report_errors(sctx, stripe);

