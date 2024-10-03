Return-Path: <linux-btrfs+bounces-8480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF8498E95C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 07:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8381F246B7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 05:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31CA42069;
	Thu,  3 Oct 2024 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="X7C5R+Es"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74428F7;
	Thu,  3 Oct 2024 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933468; cv=none; b=LtpcnN1cABt6mQ3l/rrRmGpUl5cV0z6BFmApLLR3EHk9JeYVqwUiD6VN36Gs8euY9A5zlzrCrLQpDzQBLpBQowfTcNs4nMbsNC3IbDvL68h6y0WdvAaZMPCa0koqoYX9wjIC4gUZRB4IuqZ0pRg+GExk2ICxoqT0dDqFmnsSiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933468; c=relaxed/simple;
	bh=NvARsuItf8DlMX454D9iJqxa7bb4jBw6MW/VlXhfsEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2uPJI3d9Uu+sFMVMe9onZZJByGRQXSaHkETxDZn/OuNHgOjdY/G0L3iUTIB20WsllFpTolvFoISphSohZX6o7DT14Gdd2MbOK0KTwL9hUf97VahKEo61O+7BibA4iaNFtabwtr5fnU89H0dzLuyIjZxSzuasrSRMT/WiZ/gV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=X7C5R+Es; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727933441; x=1728538241; i=quwenruo.btrfs@gmx.com;
	bh=Zl1obNz/3oMNLB9se3FGjTAWFDQwQ63HsqHi1/Mt2U4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X7C5R+EsKJSx3FUa4Q4EuqZjVTo/9uri3fmSMDe84xqds7ma9NF4xm7jtYvKrTgu
	 SfnCMVrfKlL6oSnrhRY9ET8ez95o4M2GJ61VaCk/T4qK155bhe1f0RA+cJdq3BlOq
	 QIDznvaaza/hm6QfHPMSwoDwEQMKXifSKIA6dFclgJz8M0Z+Z6geKrSYJMkyt+8l7
	 uT1trSwugak9+p269Z5e6nkAV3z3hs7BsM5xgc0Nx/YiBbA4b1zWvEOvLLb2FpMc1
	 lzi4Snsvh9Dxrpq3qdbkuFKJJRDXj9AP4wl3cl4RH+d3ZTIDtscb0TiLMEqTZyLQA
	 UbC37evwm7/OyTZQKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1sVJv03aWg-00WDOG; Thu, 03
 Oct 2024 07:30:41 +0200
Message-ID: <d4aa6ca7-3fd6-4a26-b77b-d385bf8a53a3@gmx.com>
Date: Thu, 3 Oct 2024 15:00:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: update some tests to be able to run with
 btrfs-progs v6.11
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
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
In-Reply-To: <7914963e2c04a864edc45d7510de515c59b4fc95.1727882758.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CGuteIu9LPk0ohc4YWSK+R03bHI1vXNG04Bhz2zp4xR1+7XuqaC
 iWxD4QIRBOC68Q5cYpmBKFASh6m0IndjkPzm2BlrrirDHI8W0iHcEj3OQEB6au5m+9LurHa
 eeZl7jg5eUbsNYn3yHej8HZyrKB9+ryNU7XIMsOc6viWtbAQiZ1aZEMAfXrUXs34o6bC6Ru
 /7US+9sZcUVZeT4HUEwtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OkygZnpJpxM=;xht/E/fjxT1clCi06yVdjW/WL1x
 6KRAe7hgavGxYRzWgfy2Y4a3vy021lCM32ox3/iQozTDkHiYB2GFnbKFiUfWSWn+l2CZwO1EB
 zmzuZkibpuF2MG3Ega94LNHKHWMt5qoP5V1S3W0bYLiEN+nKNn6iyDKqJfAvCIokLqdBeLPVK
 WgbkkiVp6nYYXi+JlXGQ/rxrPg7Nla21huX6YvoHJW4YqdHnfqfMKpKfbWFWlUP1QkheBnMkx
 dHQVhhjGroz2AJ7wSnAwMoE6649BaXXaobyVXWVqAwReNVanzIhZJnNT5TI48qoEifi3u0Mzv
 Bczp1qOFWaA4WipVExcg/LsJgeyhvDatQSqKCx5dcgfne9r/JOqD7Y/hBifid6abM1ZF40kdf
 legFosvkCgr+ATmzIw5edlrdEL2z3BhnMa8m2fpCNGoIZ0KIL5FRFVm3ZQSO0OFyHqiEOn1hM
 uOROV8mkM6tWpTZwjh4foenh6HXtlFToSkm1SUrrSkd4MlceIqmuXlSj3ncB7ZOd2sQfZVoFm
 zfT2u8Rr6i5/caMz3F1M9pO4BT4hMkd2k61JcEC4tfqvQSE03szQ3E+kvJmwnuLZ35nJdS/fl
 AJL651jz2Fu9zQ44DcP1bplaEFYkVXNDioa+CInMOtFxK5qLmh8ToEh2VABAQbGlc2/IxOwTu
 3OBeqPuYMUnVp2Fk8Tj6a9yw8OBj4vj3pSCgTMIj98ov9WXi/45cuhAsAwOrIs+LZ5s7r4Apt
 IGtiUgTQkcMi9Wy2+MITWhwNV956+HBAqKFljZBv6D7okndsscfyhEh7hwUCMLt/sLVIfySu7
 Y6FR6R9zZonJayzXNrGvil8w==



=E5=9C=A8 2024/10/3 00:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> In btrfs-progs v6.11 the output of the "filesystem show" command changed
> so that it no longers prints blank lines. This happened with commit
> 4331bfb011bd ("btrfs-progs: fi show: remove stray newline in filesystem
> show").
>
> We have some tests that expect the blank lines in their golden output,
> and therefore they fail with btrfs-progs v6.11.
>
> So update the filter _filter_btrfs_filesystem_show to remove blank lines
> and change the golden output of the tests to not expect the blank lines,
> making the tests work with btrfs-progs v6.11 and older versions.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   common/filter.btrfs | 5 ++++-
>   tests/btrfs/100.out | 2 --
>   tests/btrfs/218.out | 1 -
>   tests/btrfs/254.out | 1 -
>   4 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index 5a944aeb..6c53dffe 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -30,11 +30,14 @@ _filter_btrfs_filesystem_show()
>   		UUID=3D$2
>   	fi
>
> -	# the uniq collapses all device lines into 1
> +	# Before btrfs-progs v6.11 we had some blank lines in the output, so
> +	# delete them.
> +	# The uniq collapses all device lines into 1.
>   	_filter_uuid $UUID | _filter_scratch | _filter_scratch_pool | \
>   	_filter_size | _filter_btrfs_version | _filter_devid | \
>   	_filter_zero_size | \
>   	sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
> +	sed -e "/^\s*$/d" | \
>   	uniq > $tmp.btrfs_filesystem_show
>
>   	# The first two lines are Label/UUID and total devices
> diff --git a/tests/btrfs/100.out b/tests/btrfs/100.out
> index aa492919..1fe3c0de 100644
> --- a/tests/btrfs/100.out
> +++ b/tests/btrfs/100.out
> @@ -3,9 +3,7 @@ Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>   	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
> -
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -
>   =3D=3D=3D device replace completed
> diff --git a/tests/btrfs/218.out b/tests/btrfs/218.out
> index 7ccf13e9..be11074c 100644
> --- a/tests/btrfs/218.out
> +++ b/tests/btrfs/218.out
> @@ -2,7 +2,6 @@ QA output created by 218
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -
>   [SCRATCH_DEV].write_io_errs    0
>   [SCRATCH_DEV].read_io_errs     0
>   [SCRATCH_DEV].flush_io_errs    0
> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
> index 20819cf5..86089ee3 100644
> --- a/tests/btrfs/254.out
> +++ b/tests/btrfs/254.out
> @@ -3,4 +3,3 @@ Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>   	*** Some devices missing
> -


