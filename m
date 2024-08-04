Return-Path: <linux-btrfs+bounces-6969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0304A946D1D
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 09:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA41F21B00
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6501862A;
	Sun,  4 Aug 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bA6cU47R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943F17C8B
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Aug 2024 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758094; cv=none; b=RThSqsZaUhXFlFmAMnR1FFSZmbjgU6GI6txqu0gBP0u+D/2V4SAycmd6vnGNbPWNHsfxI6Fg4Xl2/2gsvrd0uXXZIp7VzA00tUIqRc781eSwiGgYGQUM7Laj+l+8Zsr/eFJeg46jVvSN7GXBzTZxao6OCEmDNZMpzFw8yYnRc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758094; c=relaxed/simple;
	bh=mqtQbjzAF33y+n/YU547V2n6gH8QVQcUxVcF0gTTIN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtHVqWpb9PsF1oTqTlrUnFqszpLDfnlvMoDUx7GA4bVl+M0aIFAjPAmAB+1+As+/3IQebqXy2zhiQJzMCJoq21GWbYJ5dSA4uoZwOll4u4ABjPI21Axccg/jAd75DlEsBnDKe9tod6oo/XrvfsccvaWxGx3RWjeXybmceVeoIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bA6cU47R; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722758087; x=1723362887; i=quwenruo.btrfs@gmx.com;
	bh=uyVelt/G4ihEt2c1WpNLdGu7vE6aHbc6ei3FQbhrdIM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bA6cU47Ra3n9qdIXGmH3u4nx97sjnc3IXTxYTkG2BgegeN/K8GJAs7ZShy2/hnd5
	 VB3gGUXuxAL8U1zEAWpPRqBEWew2gZjqMFp07/zLaf6d7CmNrFs86Uc5zHGqRfv0G
	 8L2HLpnGPAKnM+ow1W1XxztxgJ+Mk6V1J0pIacjHDCwLVSAS1Zm/OA+crLZpJLJNl
	 Qo2cVMS4dsY/zS5N4/sqXaLHsigkwn4B74ZMTz43nQIHvJ7QM0Ld8qBcFH1F8QzSn
	 nDf5fwuGA6gmAMWp3Vkfa4ibzTTA0Se6D9xaUn1LDybp/w9WUzfEV4AsLp+rywUxS
	 QExoY+iVEcmEokmofw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1srM6X3TrH-00QcC0; Sun, 04
 Aug 2024 09:54:47 +0200
Message-ID: <4d20359c-4516-4a33-abdc-3f1b11c02e06@gmx.com>
Date: Sun, 4 Aug 2024 17:24:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] btrfs-progs: use libbtrfsutil for btrfs subvolume
 create
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@meta.com>, Omar Sandoval <osandov@fb.com>
References: <20240802112730.3575159-1-maharmstone@fb.com>
 <20240802112730.3575159-2-maharmstone@fb.com>
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
In-Reply-To: <20240802112730.3575159-2-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgkbHyalA2IcE1770u0/HhOQ+VfULUPxWNVaDSHSLpjjInixpOt
 oV05bsdqK4ZVV2y+3NgNT2skGbqXOYUbv2Z+TCi0OJc6+iY5dstqo7ALdlnxUFQNy4JUwaI
 MIEzNBie15PK5msdjP95J1bUX4qRXg+EN0OXwD2AhQkLif+qz1Qm1TqBDMNdhFVdZ72fbI+
 J3r7lNWWNnDLI+SELHL+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:77IwYXvETpQ=;Lj7Q/Hz1bg8hQsNnM12iYKWjpDG
 /3+5idlKzoarLXuKnOlQBTlOCEIRxBqfzRgdgB8u4FBqk4KP8Z4bmV8HjPadXU1kw9pmxsX3p
 HHfesMgiGF4zxRC/mrq4kFOnB+f39oq8sm5/EO0D/tVJ8m0/47CDntzm2oEhUuPktL883TUR8
 +A43T7W7On1yUg4i3XUVDlcyog48iaWsFGBBho2VWpiXOubBwUrbgF6lcBKaGzH6phP3JJexS
 sc2yG3ezCG4L9FPnoyK4UZGSQNZ+C75/s+jsrkvYPw5R9Z4EmxG8yPelxPlhYKpfnmR3jNYD7
 Zj4K6bJOM99Ao1fTGz0q5wXV3aYE2CYYuzGIfEeW9MdMDYarc8rGajACSvnchLBS0TVywiFwu
 CEKPLXl7H6zKZg/tt0ZhEilDose2VKNQL5e0X2l9gtqIgHR+9T5uyZ8scbxXaNWn6VEZ4nw0y
 FfNPkAfimPPHMigy3RxgadQnF43+r9AJ8D46ePFM9dMX9apAvfzRHDPU/WAm9wHyUezpu6iYU
 NI07ixvLDBIFSVxQ7RtfWUXJ+khXvMwj2c3yrzwsn+hGTaYjI5gXJu+V+c4dh42KSAITFZc8P
 2gsMLPJBJ1c1NA0XHY0Ur4AJlPSiNKI+1prLnd4FTH7Dp+OJ0Z8DN7kSZepTrDWCAi4a5nGfc
 v3OclXDV8cFUS6AB9IqFUyMzsMBWHYZyM5LTpEg6NOJBdzt88t4aoZrcUGexIaQY3OGfXzMZD
 bNQNYoksKbvtXlL6FekFLfC0OPx7e4S5RBe/PA+p4GkBZBhbNwQ2ZdvAtgAdlBZoZQejUhk5p
 bzy/8CPvSFLvFR1IYm8Z8zwA==



=E5=9C=A8 2024/8/2 20:57, Mark Harmstone =E5=86=99=E9=81=93:
> From: Mark Harmstone <maharmstone@meta.com>
>
> Call btrfs_util_subvolume_create in create_one_subvolume rather than
> calling the ioctl directly.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Co-authored-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/subvolume.c | 100 ++++++++++++++++++++---------------------------
>   1 file changed, 43 insertions(+), 57 deletions(-)
>
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index b4151af2..2a635fa2 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -46,6 +46,7 @@
>   #include "common/units.h"
>   #include "common/format-output.h"
>   #include "common/tree-search.h"
> +#include "common/parse-utils.h"
>   #include "cmds/commands.h"
>   #include "cmds/qgroup.h"
>
> @@ -140,28 +141,15 @@ static const char * const cmd_subvolume_create_usa=
ge[] =3D {
>   	NULL
>   };
>
> -static int create_one_subvolume(const char *dst, struct btrfs_qgroup_in=
herit *inherit,
> +static int create_one_subvolume(const char *dst, struct btrfs_util_qgro=
up_inherit *inherit,
>   				bool create_parents)
>   {
>   	int ret;
> -	int len;
> -	int	fddst =3D -1;
>   	char	*dupname =3D NULL;
>   	char	*dupdir =3D NULL;
>   	const char *newname;
>   	char	*dstdir;
> -
> -	ret =3D path_is_dir(dst);
> -	if (ret < 0 && ret !=3D -ENOENT) {
> -		errno =3D -ret;
> -		error("cannot access %s: %m", dst);
> -		goto out;
> -	}
> -	if (ret >=3D 0) {
> -		error("target path already exists: %s", dst);
> -		ret =3D -EEXIST;
> -		goto out;
> -	}
> +	enum btrfs_util_error err;
>
>   	dupname =3D strdup(dst);
>   	if (!dupname) {
> @@ -179,19 +167,6 @@ static int create_one_subvolume(const char *dst, st=
ruct btrfs_qgroup_inherit *in
>   	}
>   	dstdir =3D path_dirname(dupdir);
>
> -	if (!test_issubvolname(newname)) {
> -		error("invalid subvolume name: %s", newname);
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -
> -	len =3D strlen(newname);
> -	if (len > BTRFS_VOL_NAME_MAX) {
> -		error("subvolume name too long: %s", newname);
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -
>   	if (create_parents) {
>   		char p[PATH_MAX] =3D { 0 };
>   		char dstdir_dup[PATH_MAX];
> @@ -223,47 +198,57 @@ static int create_one_subvolume(const char *dst, s=
truct btrfs_qgroup_inherit *in
>   		}
>   	}
>
> -	fddst =3D btrfs_open_dir(dstdir);
> -	if (fddst < 0) {
> -		ret =3D fddst;
> +	err =3D btrfs_util_subvolume_create(dst, 0, NULL, inherit);
> +	if (err) {
> +		error_btrfs_util(err);
> +		ret =3D 1;
>   		goto out;
>   	}
>
> -	if (inherit) {
> -		struct btrfs_ioctl_vol_args_v2	args;
> +	pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, newname)=
;
>
> -		memset(&args, 0, sizeof(args));
> -		strncpy_null(args.name, newname, sizeof(args.name));
> -		args.flags |=3D BTRFS_SUBVOL_QGROUP_INHERIT;
> -		args.size =3D btrfs_qgroup_inherit_size(inherit);
> -		args.qgroup_inherit =3D inherit;
> +	ret =3D 0;
>
> -		ret =3D ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE_V2, &args);
> -	} else {
> -		struct btrfs_ioctl_vol_args	args;
> +out:
> +	free(dupname);
> +	free(dupdir);
> +
> +	return ret;
> +}
> +
> +static int qgroup_inherit_add_group(struct btrfs_util_qgroup_inherit **=
inherit,
> +				    const char *arg)
> +{
> +	enum btrfs_util_error err;
> +	u64 qgroupid;
>
> -		memset(&args, 0, sizeof(args));
> -		strncpy_null(args.name, newname, sizeof(args.name));
> -		ret =3D ioctl(fddst, BTRFS_IOC_SUBVOL_CREATE, &args);
> +	if (!*inherit) {
> +		err =3D btrfs_util_qgroup_inherit_create(0, inherit);
> +		if (err) {
> +			error_btrfs_util(err);
> +			return -1;
> +		}
>   	}
>
> -	if (ret < 0) {
> -		error("cannot create subvolume: %m");
> -		goto out;
> +	qgroupid =3D parse_qgroupid_or_path(optarg);
> +	if (qgroupid =3D=3D 0) {
> +		error("invalid qgroup specification, qgroupid must not be 0");
> +		return -1;
>   	}
> -	pr_verbose(LOG_DEFAULT, "Create subvolume '%s/%s'\n", dstdir, newname)=
;
>
> -out:
> -	close(fddst);
> -	free(dupname);
> -	free(dupdir);
> +	err =3D btrfs_util_qgroup_inherit_add_group(inherit, qgroupid);
> +	if (err) {
> +		error_btrfs_util(err);
> +		return -1;
> +	}
>
> -	return ret;
> +	return 0;
>   }
> +
>   static int cmd_subvolume_create(const struct cmd_struct *cmd, int argc=
, char **argv)
>   {
>   	int retval, ret;
> -	struct btrfs_qgroup_inherit *inherit =3D NULL;
> +	struct btrfs_util_qgroup_inherit *inherit =3D NULL;
>   	bool has_error =3D false;
>   	bool create_parents =3D false;
>
> @@ -281,7 +266,7 @@ static int cmd_subvolume_create(const struct cmd_str=
uct *cmd, int argc, char **a
>
>   		switch (c) {
>   		case 'i':
> -			ret =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
> +			ret =3D qgroup_inherit_add_group(&inherit, optarg);
>   			if (ret) {
>   				retval =3D ret;
>   				goto out;
> @@ -304,13 +289,14 @@ static int cmd_subvolume_create(const struct cmd_s=
truct *cmd, int argc, char **a
>
>   	for (int i =3D optind; i < argc; i++) {
>   		ret =3D create_one_subvolume(argv[i], inherit, create_parents);
> -		if (ret < 0)
> +		if (ret)
>   			has_error =3D true;
>   	}
>   	if (!has_error)
>   		retval =3D 0;
>   out:
> -	free(inherit);
> +	if (inherit)
> +		btrfs_util_qgroup_inherit_destroy(inherit);
>
>   	return retval;
>   }

