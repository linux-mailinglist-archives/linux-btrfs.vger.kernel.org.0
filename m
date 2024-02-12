Return-Path: <linux-btrfs+bounces-2311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4D850CF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 03:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C8EB22CB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 02:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B946BF;
	Mon, 12 Feb 2024 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SRIQM7JG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C64411;
	Mon, 12 Feb 2024 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706680; cv=none; b=b5q+RpxenzWJo+C3Qq9cRG4DS3meygwtMz3PCO7mIyu20tqn095bBikEwB0HYS6eLmow7K4SkwQfQs6f/0wE87mp/urF8Yu/C/u75ggiJ1olwR49POIjxUyJ4Qc5CorRzlErjlG0O14yRKiIdUnDXbZ02VsH0yyklT1S3vq6V4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706680; c=relaxed/simple;
	bh=ztGjQYrAp08NQlI0sP7paMk2fx24gJxOAohk64a2zus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LS2mPHts84eFypV82WKS5G531rz4XcKRvkxlW1tWsIfTViUzsZ7ZFE80SOD0tloUcKdoRU1iK/8Q0StBD9AfXPkDecaskaQavT6khmbxJtMaIT7q6G76C++hWBY1PuhEaf4fqdlpquy0wkJQ9RgEEoKlQa1aua8105Wa4L+aA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SRIQM7JG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707706670; x=1708311470; i=quwenruo.btrfs@gmx.com;
	bh=ztGjQYrAp08NQlI0sP7paMk2fx24gJxOAohk64a2zus=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=SRIQM7JGO2xyIqO0K9HSQ1xXD+FfL4v27jcMjJJEi2I8xAfoFJ0c2ECpPWNMV6lJ
	 FH4VDoZD+ZxQLGyrzR/+76VdtM813ISNPd0wCXdojyEPHXZ0rCDZqM0JVQyGNfiKK
	 4weXwHHuKXa2ymKr2oAErX7hmvLf4JD2UUaHvyeyFE8+ybANmEP9Ob5DEcPj2EdkE
	 +d9Z8L8/ZANVSAailt+Ob3bPS3XYMm6Tmoed1ef5XOehDKgCF4udIv7M4AKTCaurE
	 uTMWGD4yigyYfQc7tw6ox+5cec5W3NBg9+a4KHcM3eqIH65PzNR3hGXY9OxAphKxP
	 gDz1zb4+b9u3jdOhmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1rL93B46gu-00PPqJ; Mon, 12
 Feb 2024 03:57:50 +0100
Message-ID: <8dbda6ea-b78d-4b31-ba40-cfc63c48145e@gmx.com>
Date: Mon, 12 Feb 2024 13:27:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/736: fix a buffer overflow in
 readdir-while-renames.c
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <eff8549698ca7a61089e17727b3e1d45a4839e6f.1707650891.git.fdmanana@suse.com>
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
In-Reply-To: <eff8549698ca7a61089e17727b3e1d45a4839e6f.1707650891.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:antg1QBcPKFTy5MgYh70ewxcOkB6CKxhWNlnwMNtgxNlyhfSECm
 4ugfe0xpXQFBPdPdzz36eurIi8/HgNPOY49IPKvi61eAxRS722FguT1qI7LjbXa2xPyRNSf
 6qcZuAP/RTbQbbvKMfB/McqBCh382hd43AP2xyrwZu+Y7vll0FAczuG1uNj3MVk3obWKgi5
 piuWvHsCXEda2Qq0XF+Kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gBBtNlOj2Yo=;N880Pu0mutMyX2qnPYAfcALoaUi
 Yzxvfb+GyPXY2/jaBIVuqXOEdH9hKJjQixl1vm482ABaaHVi4IFIMgx2Snll3VCkLO2/d//cT
 lwtMhxcN8FzbZJlKDgIN72+VpdPJKIx+05S7EYctiDeJTcqM2poXopMsb+DOBY75ukW/7/3fH
 BTQc8nWddo+uJ90+XI8awRXIMIyRnG86KJGB8dvIXy3/ZHq7lxZm6P00jR7NQulIF42gCfung
 n+UMqwPrWNDYG+YosNYAu0S3y5czhEdhOX9kzoY0BwqGre9xE58FnfshQFpwnoHPIq0WYobS/
 otiE8Pd6n5oOUEdvLXgGDo6fHRUYU41lkhLLQIZlJvRgfbp8WobVypZO1/oDMy6ad8XBk+wiW
 FwjfcDZZH3tn51nk6Dhbpamwmqp/Np5PbUxUjTHW25bZ2RRnH/00gNCWlfAqLyCHa/um3PSXU
 STJSiFOMjzGQXKfGjy0BeSn7NsXQmTYJIJsXIve2+CtcCGH003GBjd09SdiyasypHpDbD8jts
 r3Ck+uDXvwdpfnGUa9GLnGHVfrvhEveQATZY7PNiL7VEkvpg+ZnlnCwVQ9n04x8UYCelJ3d3U
 xja5zfXqXdb+m1rsVeFp1zdaDKTkq4dED7ecy9JQv5muyQAUAwXRunayM6bsA0kM5Sbz9a8WW
 3Wup7DZBi2q3I5QOtzt/N122XBhkdG4Xya1u7z93T8iX+dFZSGcYBNB9h9D6ahXMTj327qOcM
 mWbfUqb7Uus1f3RNT+FrDUt/teJU3zt4K8OZJTOvOdKakXUUoYHFw5QBAPUt+kauMETII7pf7
 BDUUrEW/SeX2+1rbcUkj+G36P/0Q+OFKr9rLbuSTz73VE=



On 2024/2/11 21:58, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The test is using a 32 characters buffer to print the full path for each
> file name, which in some setups it's not enough because $TEST_DIR can
> point to a path name longer than that, or even smaller but then the buff=
er
> is still not large enough after appending a file name. When that's the
> case it results in a core dump like this:
>
>    generic/736       QA output created by 736
>    *** buffer overflow detected ***: terminated
>    /opt/xfstests/tests/generic/736: line 32:  9217 Aborted              =
   (core dumped) $here/src/readdir-while-renames $target_dir
>    Silence is golden
>    - output mismatch (see /opt/xfstests/results//generic/736.out.bad)
>        --- tests/generic/736.out	2024-01-14 12:01:35.000000000 -0500
>        +++ /opt/xfstests/results//generic/736.out.bad	2024-01-23 18:58:3=
7.990000000 -0500
>        @@ -1,2 +1,4 @@
>         QA output created by 736
>        +*** buffer overflow detected ***: terminated
>        +/opt/xfstests/tests/generic/736: line 32:  9217 Aborted         =
        (core dumped) $here/src/readdir-while-renames $target_dir
>         Silence is golden
>        ...
>        (Run diff -u /opt/xfstests/tests/generic/736.out /opt/xfstests/re=
sults//generic/736.out.bad  to see the entire diff)
>    Ran: generic/736
>    Failures: generic/736
>    Failed 1 of 1 tests
>
> We don't actually need to print the full path into the buffer, because w=
e
> have previously set the current directory (chdir) to the path pointed by
> "dir_path". So fix this by printing only the relative path name which
> uses at most 5 characters (NUM_FILES is 5000 plus the nul terminator).
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   src/readdir-while-renames.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/src/readdir-while-renames.c b/src/readdir-while-renames.c
> index afeefb04..b99c0490 100644
> --- a/src/readdir-while-renames.c
> +++ b/src/readdir-while-renames.c
> @@ -55,10 +55,16 @@ int main(int argc, char *argv[])
>
>   	/* Now create all files inside the directory. */
>   	for (i =3D 1; i <=3D NUM_FILES; i++) {
> -		char file_name[32];
> +		/* 8 characters is enough for NUM_FILES name plus '\0'. */
> +		char file_name[8];
>   		FILE *f;
>
> -		sprintf(file_name, "%s/%d", dir_path, i);
> +		ret =3D snprintf(file_name, sizeof(file_name), "%d", i);
> +		if (ret < 0 || ret >=3D sizeof(file_name)) {
> +			fprintf(stderr, "Buffer to small for filename %i\n", i);
> +			ret =3D EOVERFLOW;
> +			goto out;
> +		}
>   		f =3D fopen(file_name, "w");
>   		if (f =3D=3D NULL) {
>   			fprintf(stderr, "Failed to create file number %d: %d\n",

