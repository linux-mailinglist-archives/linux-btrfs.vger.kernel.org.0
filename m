Return-Path: <linux-btrfs+bounces-12006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A7A4EF79
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 22:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23A63A974B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A6264F8C;
	Tue,  4 Mar 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wb/iO7eH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABE259CB0
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Mar 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124432; cv=none; b=HxvofIuqzxQCFbAXF+hk6kw7tvn0KhQUxxu33pH1ur8pNKeh7Pi8uw8f7YFBKp14a6YXGXcG7n/WBHYOd/I6FIQnQWpl6KIvEwF6kiCRUGIXeWLGlkEq6kjicYH7TJAZdpJgnRgW+fkqtTUiP5ISw3QKbAGVQbmVuPJApauUDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124432; c=relaxed/simple;
	bh=1wA0VM0E86qlBm3nuQXsXQZYhcZDkNqoAQO7Q8km8qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lrsnEbm8tsfxwOm3qgZ8Mpi/m9xeVyd03KfYL5fFhnfoXcTUe4JVte9U0fhgGjvcvxMqefb2CNTdPAuasjUDZln04E23L2o+7GlPivxW1yoeWiszUIi7IkJmN3GBnMlLz+3x6E359KVCs32Vj4C/FeF7ngrebSDdqtKrVDTV6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wb/iO7eH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741124428; x=1741729228; i=quwenruo.btrfs@gmx.com;
	bh=e/mJl7kff4ACxGCCxfUqj+vTgL2g+VPs09lZz5+EjNk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wb/iO7eH0tR3g0T0lF80Dl21wGm8TeMwtPtLOaU5FfDPRh5qrK61hV6uzxCRg3ec
	 zAz5iu7NJk4sry1w09VJ6z5aXPmZZIjqiIOvFiHWLHSW4+OmlW69/7dSHgr/YE2er
	 AJEV8tRvV1rYv/EYtx1N9kNRgXsw0QmRE3tbpPJ5dA+PJptbnSqYfp0NtUjmuBdPF
	 m8qPvxakX34OIniGLpV3go1/vhuA0kiW+zv6DY7Aa/7kEsN8OBiaLEL1yHid7W8Q8
	 XHixVm2L3MU9uz9pCdKGyopATRmV1rcJ0Z61iLC81NZK7O9eQiDy1esJG1tzAkvrp
	 +FR8dHXxQbTSYXps2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UZG-1tp1lh1mx0-00DwUn; Tue, 04
 Mar 2025 22:40:28 +0100
Message-ID: <e8cd2383-1466-4f4f-bc88-cf0ba8f04e60@gmx.com>
Date: Wed, 5 Mar 2025 08:10:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: fi defrag: allow passing compression levels
To: Daniel Vacek <neelx@suse.com>, linux-btrfs@vger.kernel.org
References: <20250304172712.573328-1-neelx@suse.com>
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
In-Reply-To: <20250304172712.573328-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yTTn0w0wkCQGfZkkvGBYhYibyG86WRKEsxFRHkbVwptIyA7fX2X
 QgTWO0DqTHB3aUqdzMkFULi0bXyi3XWkcuIQgc2/B48o/Jw8C01QxqRYZx9Zwj4WXP2m9KM
 hlw5ZrZNZ3kEijGYjPVLEgw6+WMyzuRyR4HekI+aNyXsJLRsrmt/cbH+fa2n7jB0gRnc6wT
 QSYVKmtFEPRaYAjOu0Krg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wa2OUovQbVY=;NUG1weRhH4kxn15+lGMeBogNiA/
 ozmKXpZOjiUpoPpAIme/yqiQ0O+vTI6BjaO3tFsS3qp8UvalfHWl8W88zKGDN+wYEAORvhGhF
 8PLesRG4qkSJOtT89Zi34v9JhRTYUBAGn9aC5PBsgQF6KwWPVLsje7H1ecg23wRuE4VB7hVPO
 pV3fE6tNhUbL4FklU2YPgHLAJFoSek0a6NCFS9qJBkfKwlPGD5asXRPjOO4XepAwiIxwga0R8
 xxVSnunTHFgxnyTHUCvMpCfLGnppVtGlDFZ/NFY0NOcfnPWtaADLb5orVig1YyjDF2GYUnT68
 89CKI3+/mvN5seg4QQK7TziTAM8NmIZOJSgcLwNr42xGIXpzi5CV3zGcfZIm+HYte5lMJRC4U
 8Z8ksOQ4B/LVr/s0lm4/QBujKn8v8T9EWUHAJOAamYNlc4e58XtmTFIbQLPxYFGqSyO0ceKjp
 Wr7XssuSLc7RJNXxFAx0K6S+qvrwPl/j0GYyZIp1I2fwsHmfeQLJ+6cAKdAd1IJiQMVmb06iX
 cXvCth9ndRGIPWNDfDOTu1vXEysW6gM+/tagldrWeM+NeOv9iTmVij7/n/ugqIFda+vf59eEz
 uVDB3rm2GGgOr2M1tSrbWXuFqY/vF7b65a8UPIjkpprAVWafcM9ZXZldaTZ2z50tIRaTCVkMD
 2q9zRM7yCXH4HIZz7qt2fsarTexyYZCBdm25shRAbusI+oqtQzppO7BZ/waq8t4fXA/Ls7N3D
 P7/78C5JA7J294ChByuAxyZDZ8Sv9wP7XX52ksPFHmZSby4VrWGN0EyAzJU1Z6vuouqE30fmd
 Prke39CKqjrszXN3sIXRPvSYbPu6LQVyjlLjnkm170eRYzwD7lgEzA8wayx6Mluji4Gc9GqXf
 yfNMGlnVWAoTBHMQjbq2j9sC6gLgPzcr8EFbg0y3ox/ZEwY0rJl5g6MroYhCEn14auqN7BE6T
 WN9XPf7xVJmONI8h2vZRoEhMzFC7Te5grNr1M94I/IVkBav7M7QAYQgV7L/zMU24yNaPUBlgT
 n5gFKbojULDOwTtkkNykvQBPUBp9mg+o9JStYCqO3HPMpSI5sFJL96Gj3B4Js0aSL7cEQjLbt
 Z9TxAqLNJhZLrIINuqL+JqCXDOWFbMNHrM8Z014mPxZkB11hUZ7Y7HIPXBsx/2qKEpvCaOH6o
 jSdlGmGTn+z+lMBwqzggXWQpMTUvag8UF8aELzjkCo6f491esrqmtAvBL1tyL+IFFWekCQV4w
 9GeMq+hcDFhdIG9KsbVVJRBOG2ERBsK2uKHGllmN5Zoseb1jZuAm+Bbgjkls3EZhx/bERkBN3
 VKsqH/80pAbjUAWvTk27oCBAvLOx6SYn3XrBCkD8KcDvSwAqMtZ7GjZDE5afFWu6YI4togyd+
 VxR8Kb9hkbTv4QkazOPpoNFseJqyKQ+H7CaQF3qYpTEYKSOz9/ed82lTJg



=E5=9C=A8 2025/3/5 03:57, Daniel Vacek =E5=86=99=E9=81=93:
> zlib and zstd compression methods support using compression levels.
> Enable defrag to pass them to kernel.
>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>   Documentation/ch-compression.rst | 10 +++---
>   cmds/filesystem.c                | 55 ++++++++++++++++++++++++++++++--
>   kernel-shared/uapi/btrfs.h       | 10 +++++-
>   libbtrfs/ioctl.h                 |  1 +
>   libbtrfsutil/btrfs.h             | 12 +++++--
>   5 files changed, 77 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/ch-compression.rst b/Documentation/ch-compres=
sion.rst
> index a9ec8f1e..f7cdda86 100644
> --- a/Documentation/ch-compression.rst
> +++ b/Documentation/ch-compression.rst
> @@ -25,8 +25,8 @@ LZO
>           * good backward compatibility
>   ZSTD
>           * compression comparable to ZLIB with higher compression/decom=
pression speeds and different ratio
> -        * levels: 1 to 15, mapped directly (higher levels are not avail=
able)
> -        * since 4.14, levels since 5.1
> +        * levels: -15 to 15, mapped directly, default is 3
> +        * since 4.14, levels 1 to 15 since 5.1, -15 to -1 since 6.15

I believe the doc updates can be a separate patch since it's not related
to the new defrag ioctl flag.

>
>   The differences depend on the actual data set and cannot be expressed =
by a
>   single number or recommendation. Higher levels consume more CPU time a=
nd may
> @@ -78,7 +78,7 @@ Compression levels
>
>   The level support of ZLIB has been added in v4.14, LZO does not suppor=
t levels
>   (the kernel implementation provides only one), ZSTD level support has =
been added
> -in v5.1.
> +in v5.1 and negative levels since v6.15.
>
>   There are 9 levels of ZLIB supported (1 to 9), mapping 1:1 from the mo=
unt option
>   to the algorithm defined level. The default is level 3, which provides=
 the
> @@ -86,8 +86,8 @@ reasonably good compression ratio and is still reasona=
bly fast. The difference
>   in compression gain of levels 7, 8 and 9 is comparable but the higher =
levels
>   take longer.
>
> -The ZSTD support includes levels 1 to 15, a subset of full range of wha=
t ZSTD
> -provides. Levels 1-3 are real-time, 4-8 slower with improved compressio=
n and
> +The ZSTD support includes levels -15 to 15, a subset of full range of w=
hat ZSTD
> +provides. Levels -15-3 are real-time, 4-8 slower with improved compress=
ion and
>   9-15 try even harder though the resulting size may not be significantl=
y improved.
>
>   Level 0 always maps to the default. The compression level does not aff=
ect
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index d2605bda..f3f93ff7 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -962,6 +962,7 @@ static const char * const cmd_filesystem_defrag_usag=
e[] =3D {
>   	"",
>   	OPTLINE("-r", "defragment files recursively"),
>   	OPTLINE("-c[zlib,lzo,zstd]", "compress the file while defragmenting, =
optional parameter (no space in between)"),
> +	OPTLINE("-L|--level level", "use given compression level if enabled (z=
lib supports levels 1-9, zstd -15-15, and 0 selects the default level)"),
>   	OPTLINE("-f", "flush data to disk immediately after defragmenting"),
>   	OPTLINE("-s start", "defragment only from byte onward"),
>   	OPTLINE("-l len", "defragment only up to len bytes"),
> @@ -1066,6 +1067,7 @@ static int cmd_filesystem_defrag(const struct cmd_=
struct *cmd,
>   	bool recursive =3D false;
>   	int ret =3D 0;
>   	int compress_type =3D BTRFS_COMPRESS_NONE;
> +	int compress_level =3D 0;
>
>   	/*
>   	 * Kernel 4.19+ supports defragmention of files open read-only,
> @@ -1095,18 +1097,18 @@ static int cmd_filesystem_defrag(const struct cm=
d_struct *cmd,
>   	if (bconf.verbose !=3D BTRFS_BCONF_UNSET)
>   		bconf.verbose++;
>
> -	defrag_global_errors =3D 0;
>   	defrag_global_errors =3D 0;
>   	optind =3D 0;
>   	while(1) {
>   		enum { GETOPT_VAL_STEP =3D GETOPT_VAL_FIRST };
>   		static const struct option long_options[] =3D {
> +			{ "level", required_argument, NULL, 'L' },
>   			{ "step", required_argument, NULL, GETOPT_VAL_STEP },
>   			{ NULL, 0, NULL, 0 }
>   		};
>   		int c;
>
> -		c =3D getopt_long(argc, argv, "vrc::fs:l:t:", long_options, NULL);
> +		c =3D getopt_long(argc, argv, "vrc::L:fs:l:t:", long_options, NULL);
>   		if (c < 0)
>   			break;
>
> @@ -1116,6 +1118,18 @@ static int cmd_filesystem_defrag(const struct cmd=
_struct *cmd,
>   			if (optarg)
>   				compress_type =3D parse_compress_type_arg(optarg);
>   			break;
> +		case 'L':
> +			/*
> +			 * Do not enforce any limits here, kernel will do itself
> +			 * based on what's supported by the running version.
> +			 * Just clip to the s8 type of the API.
> +			 */
> +			compress_level =3D atoi(optarg);
> +			if (compress_level < -128)
> +				compress_level =3D -128;
> +			else if (compress_level > 127)
> +				compress_level =3D 127;
> +			break;
>   		case 'f':
>   			flush =3D true;
>   			break;
> @@ -1165,7 +1179,12 @@ static int cmd_filesystem_defrag(const struct cmd=
_struct *cmd,
>   	defrag_global_range.extent_thresh =3D (u32)thresh;
>   	if (compress_type) {
>   		defrag_global_range.flags |=3D BTRFS_DEFRAG_RANGE_COMPRESS;
> -		defrag_global_range.compress_type =3D compress_type;
> +		if (compress_level) {
> +			defrag_global_range.flags |=3D BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL;

Since it's a newer flag, the ioctl() may fail with -EOPNOTSUPP on older
kernels, in that case it's better to fall back to flags without the new
COMPRESS_LEVEL one, and try it again. (With some warning showing that
the kernel doesn't support the new flag).

Thanks,
Qu

> +			defrag_global_range.compress.type =3D compress_type;
> +			defrag_global_range.compress.level=3D compress_level;
> +		} else
> +			defrag_global_range.compress_type =3D compress_type;
>   	}
>   	if (flush)
>   		defrag_global_range.flags |=3D BTRFS_DEFRAG_RANGE_START_IO;
> diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
> index 6649436c..d2609777 100644
> --- a/kernel-shared/uapi/btrfs.h
> +++ b/kernel-shared/uapi/btrfs.h
> @@ -645,7 +645,9 @@ _static_assert(sizeof(struct btrfs_ioctl_clone_range=
_args) =3D=3D 32);
>    */
>   #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>   #define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>   #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		=
\
> +					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
>   					 BTRFS_DEFRAG_RANGE_START_IO)
>
>   struct btrfs_ioctl_defrag_range_args {
> @@ -673,7 +675,13 @@ struct btrfs_ioctl_defrag_range_args {
>   	 * for this defrag operation.  If unspecified, zlib will
>   	 * be used
>   	 */
> -	__u32 compress_type;
> +	union {
> +		__u32 compress_type;
> +		struct {
> +			__u8 type;
> +			__s8 level;
> +		} compress;
> +	};
>
>   	/* spare for later */
>   	__u32 unused[4];
> diff --git a/libbtrfs/ioctl.h b/libbtrfs/ioctl.h
> index 7b53a531..08681f2e 100644
> --- a/libbtrfs/ioctl.h
> +++ b/libbtrfs/ioctl.h
> @@ -398,6 +398,7 @@ struct btrfs_ioctl_clone_range_args {
>   /* flags for the defrag range ioctl */
>   #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>   #define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>
>   #define BTRFS_SAME_DATA_DIFFERS	1
>   /* For extent-same ioctl */
> diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
> index 8e5681c7..ebc9fc2a 100644
> --- a/libbtrfsutil/btrfs.h
> +++ b/libbtrfsutil/btrfs.h
> @@ -608,7 +608,9 @@ struct btrfs_ioctl_clone_range_args {
>    */
>   #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>   #define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>   #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		=
\
> +					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
>   					 BTRFS_DEFRAG_RANGE_START_IO)
>
>   struct btrfs_ioctl_defrag_range_args {
> @@ -636,7 +638,13 @@ struct btrfs_ioctl_defrag_range_args {
>   	 * for this defrag operation.  If unspecified, zlib will
>   	 * be used
>   	 */
> -	__u32 compress_type;
> +	union {
> +		__u32 compress_type;
> +		struct {
> +			__u8 type;
> +			__s8 level;
> +		} compress;
> +	};
>
>   	/* spare for later */
>   	__u32 unused[4];


