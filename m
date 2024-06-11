Return-Path: <linux-btrfs+bounces-5641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD11903471
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7CC1C219A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB417332F;
	Tue, 11 Jun 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bP243VAW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891B172798
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092553; cv=none; b=sZXmepyjUt3b6NT16UpnSiElZA7MJyRnYexpa0n00gfcPkmpKWK1EtpJH9hutT3HvXP3DtKoUmX3QI7S9OoViyDu30cduOvlx1kYM6+Xe996sJeToqA00LbpjfR6diYwv4xOlNeWaNUrkrlYByLlmvwKqgHykyIw6ARocRgyPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092553; c=relaxed/simple;
	bh=wIjFDsqjbZ5CynEtXP2S+5LS8rCRuU5lAZL4PYu03FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dO9ocTzYLR5b6g4kQTLs+SzuRzycSaIJmqetTDMsxSzH4osCceYwpP8OcMa1ZDbC5M83pJS98VKt3T+035vG9BKE4/apXcWHleuy8p0D7z5exZ4DBOPO6FwToYhevr0ChaZCMo3OSMvOjoU17lYpS1HO931qmzNE1scqCc2jfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bP243VAW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718092541; x=1718697341; i=quwenruo.btrfs@gmx.com;
	bh=pzLMI/Rn7C3uYRvn0KmNEOzk6MOyzJSzUpR6SSDXvok=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bP243VAWeHbsCklrQzasdZc/9QNoCN3kYVcs8U/GGwSp/yBktt4WiFQUN6jQdgiJ
	 Epbv5kgS+6NZz0ABPn649aGkcSBeHGb44wWmg2AKJ4/hs8H767MojaAmAs70UijUn
	 uO9EdVG0pbFhOcxiS6zC9hNdhFnbQ+LJesAVYhCXUBt8QF5pHmb0j3EvSAV5WWLtQ
	 UZrlb7+Sn7zvca4tR/HnG6xkABTga4Qw+pI1ELBj+m0RWwP51rTkTA5UVtVlcR6GW
	 H3umGml/nkALolSxLZSDommZB71pau3ZKDlIPJd0eegrmR7KxnuJcPi6Uw3bF1eBS
	 +NLX/gh5Rhjstp3nug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1souKF2k7n-00ZFjK; Tue, 11
 Jun 2024 09:55:41 +0200
Message-ID: <ba0047db-a1d1-4150-9595-62406c34395e@gmx.com>
Date: Tue, 11 Jun 2024 17:25:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: tests: add convert test case for block
 number overflow
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>, linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com
References: <20240611073443.1207998-1-srivathsa.d.dara@oracle.com>
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
In-Reply-To: <20240611073443.1207998-1-srivathsa.d.dara@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j5Z6LgpSfIEfpdaJB45kdw5BZT5xBO1HE3LxogWDPJhy0AyXxVp
 A4qOFxTXKACtpOgxfE86FizBpYqnzl9bfUMvK05++jk2hklmQABwcOBbc9qMbYD2C1ExTUE
 sxi8k6aPbOi5Di39qaPkmYlpQc0cC/fjcjdrcEJMnhU9h/UfpCTYWeBY0Rv1WQO5x4tZXWk
 gT2WXl4ex4RO8c51LV4XA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a6WrAqvLuqo=;WMx2o9uxhV1aBfgOuiKHTxZU/TQ
 LxqzGKzS680DUfTGy17ABiL9OYwxk8XnFGq1foKeZJUBUjul5SQNBAjCIlfZZsZE6G5goZaDD
 HDWTvI6KLZr2xCVQuXjWNcSXeOpdP022G77GI/LdXIPvzVcIQwq8hdlFp0w2rB8f+Lfd+OaJ1
 rHDOKYUINZ8upnIbPhWIFsWv2QTSB0p6YLZ7HZwjsSxXGwV2+twfzPPxH3uGwdWxk2g8PY4Ps
 naChkOmrlInhCp5VdhjgudqDCMjNctINuBjizAi71LKKieBXYR1QO3tUKpGeDrV0gdYo0nh5P
 v+MY8A/GwRDI32TOc0aTX1R2JecmD6eV8Zoi+TEj74M+aSu+9QsvIDJ1GNc9BZuPcdF805baC
 4Vof27j5bbBdP9qS9nHA9/usNBdmZnUQinmJ3VSqQJc8PH1gDOuX+cozH5KoJiHnYzIS7O/Th
 nfYtNYkF5+oEkDRYFScsqU/ytBq+YFx1CeyVBEH0uA+oaZ0RxChQSg8VP5ZVuYQBL99pa47O1
 L0WBR2PEu/jMuWaPw2f2ktzeqaTQ7TMIdI+JwPziuC/t9EtOsVPdX0Y3lW0YIQqYbwPzwfMUM
 Dsk+vCYvQGUMtJ8US1tO+HRu+NOK3fgex1u5ca6Ic2DSdv1yKspDWj+T9e37AoxMuUXB+wn0P
 +V98eIHq5p6qHnXG3llUFixNpYxVQiooKq6j0BAoKrg8gaMpy6miGvhWfgWTSEh1SxHVBe0Kz
 6dogOHxN5OhrBQbCgdsO7DoGWb22S4qXroa8aHxBVJ/o12u85psZc6NkZvgh3dnygEkTQS6Z4
 NbUdCxKSI5uoQP9pb+/Y1sqHzOeaGaPnrQihqVa98o7Rw=



=E5=9C=A8 2024/6/11 17:04, Srivathsa Dara =E5=86=99=E9=81=93:
> This test case will test whether btrfs-convert can handle ext4
> filesystems that are largerthan or equal to 16TiB.
>
> At 16TiB block numbers overflow 32 bits, btrfs-convert either fails or
> corrupts fs if 64 bit block numbers are not supported.
>
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   .../018-fs-size-overflow/test.sh              | 22 ++++++++++++-------
>   1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/tests/convert-tests/018-fs-size-overflow/test.sh b/tests/co=
nvert-tests/018-fs-size-overflow/test.sh
> index 1c2860fa..202e9039 100755
> --- a/tests/convert-tests/018-fs-size-overflow/test.sh
> +++ b/tests/convert-tests/018-fs-size-overflow/test.sh
> @@ -1,6 +1,6 @@
>   #!/bin/bash
> -# Check if btrfs-convert can handle an ext4 fs whose size is 64G.
> -# That fs size could trigger a multiply overflow and screw up free spac=
e
> +# Check if btrfs-convert can handle an ext4 fs whose size is 64G and 16=
T.
> +# These fs sizes could trigger overflows and screw up free space
>   # calculation
>
>   source "$TEST_TOP/common" || exit
> @@ -10,11 +10,17 @@ check_prereq btrfs-convert
>   check_global_prereq mke2fs
>
>   setup_root_helper
> -prepare_test_dev 64g
>
> -convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
> -run_check_umount_test_dev
> +for size in '64g' '16t'; do
> +	prepare_test_dev $size
>
> -# Unpatched btrfs-convert would fail half way due to corrupted free spa=
ce
> -# cache tree
> -convert_test_do_convert
> +	convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
> +	run_check_umount_test_dev
> +
> +	# Unpatched btrfs-convert would fail half way due to corrupted
> +	# free space cache tree
> +	convert_test_do_convert
> +
> +	run_check_mount_test_dev
> +	run_check_umount_test_dev
> +done

