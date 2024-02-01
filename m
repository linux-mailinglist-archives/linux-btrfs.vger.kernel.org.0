Return-Path: <linux-btrfs+bounces-2047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B34084648C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 00:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38EE288AC1
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192C47F57;
	Thu,  1 Feb 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MywawCh3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879303FB37;
	Thu,  1 Feb 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830655; cv=none; b=FQoWKDGY8ByxB5IyoT3r9aEej6SQHNB2ARSH8H3zifYf3LEylWf+mUKG82OX/+xkir8AMoyaJBWkbJWCzxBbyLu4qM87fHJ1md1y1LXvSq6PUz1JoNizC1ql74KibY07bTpTRe2TWGB+QlIKIRg8dzVU0F743p+SCE90fKIevSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830655; c=relaxed/simple;
	bh=ulqo9lIohw2YR3GnVxtwZVMLOLV9R098if/SkPUo+iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gniq2kmF/w9B74pGYXNvxC/eLzXAMqIRnXKqk/uKwph9S3P8YAkB9r/Rx9bun07Ei5QBFiGfFUiWG+bC1G0JOPQ1+q8vWBl1kzV3kOSZnGXObh8cY4HSOfH6pXmTf9D6PvEL2aZMJkoE9gFarS1ltA6r4GMqLZJ4ECjwDX22iMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MywawCh3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706830647; x=1707435447; i=quwenruo.btrfs@gmx.com;
	bh=ulqo9lIohw2YR3GnVxtwZVMLOLV9R098if/SkPUo+iA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=MywawCh3PpqOsQsLWrIREfz+Gh/ElyjtI/NRovWBZMyWBxrYpiEyNBvqc5/ldKSE
	 sTNGgJOrs1vOGe8AoTuD92ssJpO4flj9IRbp93RjVyBVddzcThGqqriU6o+hIPCxJ
	 G2/P3bGktCS63Y2iduFbHMle4jF1xxx0zUDvKJ2NvBk4vvscWrNbR7ipLF+MOoi9v
	 QVv8R4Zdpvv423zbciPGGjfwFK1q8mKN5m/RWrp0nfPlbnHkkk4Stg1o5bB79yq/8
	 oiKF5UIH/seRbFLHwmr5lR1vsM2AyrqCPU7ukNmfprUA0c5HEC72QRgTmEYq0If5R
	 T/y1f7yfI7x3fbC92w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1qsFCI2cGe-00dqBE; Fri, 02
 Feb 2024 00:37:27 +0100
Message-ID: <92bf9623-48bd-477a-80a9-7c54ed7da20a@gmx.com>
Date: Fri, 2 Feb 2024 10:07:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: add a regression test for fiemap into an mmap
 range
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org, kernel-team@fb.com
References: <795fcb629a2bbfeaf39023d971b7cb3a468aa87f.1706819794.git.josef@toxicpanda.com>
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
In-Reply-To: <795fcb629a2bbfeaf39023d971b7cb3a468aa87f.1706819794.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lkfw5iY3L+zRsjDvozhlWDxrY+GNuBhuLzeJ6zhdOzbYZLGtKWG
 qtRzUg6gzNt9fGRNlnux8uBQP7UxS1BBTWJ3+jkJh87XgvSRNsw/WXLk5jaC63l+csP0KEF
 M1WisUN4+GRcH3W5RglKGuwq3T6n8L0sX4qJEEdwCqocsBauC6+Qz0LqFTFHjutZnYFSDh5
 DRq7iRhYMU8TqzREdlx7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tfGuxug6mmU=;qaFEwW+fuF7GSrd1J1rg1/pLggZ
 evZP7KBbxplxbjzyuLFyEglb3dbZ9uppwNWkHgwC/PTQtTHwotqXIlJEcnnECyWzTlcaeo7Av
 T9A9Nh3Tli8G5B2hrlNKKUsOVIV2tzahUfPPXTgD9I1DxBzQz+bQXu8YeqiZeikFxUyaNZEvB
 G0IuEx+FUwFVvSvEeYBZk1wAte1ndi4uBpS2V5FKDduwBRG/fdQPt/AtjfDUdUGfFWxwRzY5e
 PoRx0AVpxEF8k92PbUIHAcxhldoP7vIq6xihTwsg2Jbk1K3dAK5jHOSWF5uJR+ra6vp/G2t+o
 DDE8wUN2tn8p+YrtM1HI0zokXMbSlvVmTCIUGDTutd1eXMinLCCIbSnVDLZVOjz8Wodcd/pJl
 fZuodzzMtwSAVQdudbota7+GZ2o9ntjjkhFf9rCjbbWub3ME0d7mHLWSQhcr2bsaojNM00LCM
 UBBkq69eJCwuRs2zbsknNr5Nqw8KUUUKx5Cc8o7Etm0KCGqni7LQs6Bq1AZF1kaBn6d7KB4zw
 Gx2tmz+XmcE+77Le5mXog0rOPfw2/kas0hatso2XrQv1wHykXDbalj3Cn51wqck8CVINr25Pc
 QkazoqW4zH0D6wnqGsFsa/tJRGzXAeyY+WEohX+Nlsy3opEsojPLUP+El4xZba63MfNekvEZr
 VFXGh6N1XZQTuG/nwNVAx5HZpEucHFWBYeR/3/OcyUklKt66XSZlZ14dNSfDZE4gUEps6hEaS
 hQrFWbkEZOq3TtSV7fM1zCvtH5pW4LUa0TKaQWORDvHpCFF1a3NP6uJDyAy+O7dnZOCD/lqwU
 BzEuILNDgnA6xCekL8ERyL2tuGSuTyufy21JjYPaRxp4E=



On 2024/2/2 07:06, Josef Bacik wrote:
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   src/Makefile          |  2 +-
>   tests/generic/740     | 41 +++++++++++++++++++++++++++++++++++++++++
>   tests/generic/740.out |  2 ++

I guess you forgot to add the source file of fiemap-fault?

Thanks,
Qu
>   3 files changed, 44 insertions(+), 1 deletion(-)
>   create mode 100644 tests/generic/740
>   create mode 100644 tests/generic/740.out
>
> diff --git a/src/Makefile b/src/Makefile
> index d79015ce..916f6755 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -34,7 +34,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize pr=
eallo_rw_pattern_reader \
>   	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>   	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>   	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl
> +	uuid_ioctl fiemap-fault
>
>   EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>   	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/tests/generic/740 b/tests/generic/740
> new file mode 100644
> index 00000000..46ec5820
> --- /dev/null
> +++ b/tests/generic/740
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test fiemap into an mmaped buffer of the same file
> +#
> +# Create a reasonably large file, then run a program which mmaps it and=
 uses
> +# that as a buffer for an fiemap call.  This is a regression test for b=
trfs
> +# where we used to hold a lock for the duration of the fiemap call whic=
h would
> +# result in a deadlock if we page faulted.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto
> +[ $FSTYP =3D=3D "btrfs" ] && \
> +	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +		"btrfs: fix deadlock with fiemap and extent locking"
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program fiemap-fault
> +dst=3D$TEST_DIR/fiemap-fault-$seq
> +
> +echo "Silence is golden"
> +
> +for i in $(seq 0 2 1000)
> +do
> +	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> +done
> +
> +$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"
> +
> +rm -f $dst
> +
> +# success, all done
> +status=3D$?
> +exit
> +
> diff --git a/tests/generic/740.out b/tests/generic/740.out
> new file mode 100644
> index 00000000..3f841e60
> --- /dev/null
> +++ b/tests/generic/740.out
> @@ -0,0 +1,2 @@
> +QA output created by 740
> +Silence is golden

