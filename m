Return-Path: <linux-btrfs+bounces-6968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA53E946D1C
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 09:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661C51F210BC
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9D1862A;
	Sun,  4 Aug 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ei4bQGn/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A897494
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Aug 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758059; cv=none; b=se9KiBv1S1zK7VU/92W6VHpv5tYWdDZRYhdqxdfsepApQrJ2UyOwmAHj/bT9rvNPay8vCAznJHnswgBa12Hp+9a7cBaChchFQ6uZj1mR+VsiLtZ2muqZF9zj3M+NOJJ9C6HWC58YbHa7Owv1adXU7+F1OyPWCs5pn077qKadXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758059; c=relaxed/simple;
	bh=wi6dSJ+IayTjItgak9jaSxgIbexmO4aipFNWKVK0vk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwXiAb9LTOiBrNtfNw49wbi81Ir2gwCjUOBSZspBY1gJK7g1fyaG8G0z9yIzeTBoMti12suUQNm3QXyPs/xZiXtBzc1O2CpWKgWFcblZ1WWS5dz7MENMXO4HWEyKEpydcersC8vEvN6rHU/i5VVVeoC+IbjhglIflT2eYdkHe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ei4bQGn/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722758052; x=1723362852; i=quwenruo.btrfs@gmx.com;
	bh=RedMG6ICVuFGPMvNg6vfPiEaRLi1LW8NY08WU/0VTxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ei4bQGn/KutipuBghBCjee+zSct+soHcREcnSiRVrWticAy3NflDnig4iGjAieDU
	 QbJv0aBKpIR92ZXPbdYmBcc33PXbE7qNugQcALbFYm+WC4yCwf1SOdtsVRaLy9UPH
	 ya25MiSBTYyT+IyLCnd+371Ps5rGMJGZQgK54RtRAoSx8FQDlQRGfCJ/R2ZZvkfhX
	 lN7T6k4kw1PJHX9l3BiZb5dbH8StDNWFk6Te3N53JUW5w7VbAtkPlegeVfYJ7uUdy
	 Olh+V+UmsGVoRqCiXBbh739Qp2PIP0laXmH+D/jTZtvtb3tWls0YMb2DPIRrCjnQu
	 wIhsPZ1/SWMi2Ld9xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1s50fg2u7H-00mQKJ; Sun, 04
 Aug 2024 09:54:12 +0200
Message-ID: <83171aa0-17fb-4a31-9d3a-bf04e68ce922@gmx.com>
Date: Sun, 4 Aug 2024 17:24:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] btrfs-progs: use libbtrfsutil for btrfs subvolume
 snapshot
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <maharmstone@meta.com>, Omar Sandoval <osandov@fb.com>
References: <20240802112730.3575159-1-maharmstone@fb.com>
 <20240802112730.3575159-3-maharmstone@fb.com>
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
In-Reply-To: <20240802112730.3575159-3-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUjrcKNIxTdhxH8yu2zDFycYpRVCLGre/nnHzBmW1HDH6+fPYxU
 +NSjmj5FKW/GSfoJmvE+94BAiZ4Q9bm/Yt65eV4zEpzpX+/PXh+Y7AKAY2cyhqvj1sXemJ6
 vhVMrFy/rZzw4CsXbD8NUFs6nCltFTl021C93b/wQXPQ4tA41KWb7DlKUb/n8OgCg7r2cQ4
 S75rycjyW5lcsFAqL85EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DHw7afoBMf4=;JUy/m9APejurycgr+f98ZAiBsXK
 6JpvdXUIDaJqrCBqzLvQgg2L7dKWz7V/YrpGds3SoYti0jRppJBORh8zTOddohl4xfLf1Ipaf
 uJkxt5RljzAabw1h53N+R4R6lLIPoWOlTveqZY0uWZL/+xmnFktvYY1H9jFzowvLMysvvXr4f
 kUie+kCUJ3Vl2VPLeWeImMF+5/Fy8sI8S6KLYjVhEcnDNaPCB0tVfziqGPZDrmMFylDLBkVyT
 zxWdw6D/Uwq3AiJZmdkM7t2wQuhBCMl60iVJnjsrnGUUBJq11DwfPbtAgmtfZ2TBf439fomct
 bGpqkqjsgLlp7kg65iU8OU3p5GIL/s8hXzCIvEXWDMWToDD6grz58ce0ZMvhyzxGjm7HXQ/I9
 Xs+YAvr7U63+En46wntS0Lwc32fdg1OSSWpuj/eEJuIpszDbUbZsIny5WgiWiQ+rtDmTOq4z/
 LKV+7bmpv8aKO9RuBK3nG4evE8ZWIBGIn+potEmtzC4yvDs8TkOGkNCyTtYqoC0l93amXLKHW
 vModV+dnO2BhRMwcS2UqtdxzwYTkMC0NJAelIOWNHO7YwJvaJucmdmvdX4XUonoTmDfRUCekd
 /pWMcn9dE47HdGPD80qCI5OymrZYzF4D6joWEOVYjs+aZiInesvQPE0RheKctcBh6sV5qt2Qv
 3Pxl5Nl6WpTgHIayaNmb/sR3VhUSHcYdLW+HgNvmRw3RjeMc26jlf5BPjGNw5k21Uvoe0r3Te
 hf84W3rQMefunO1jp/k1DeOBAeLoFMonWcIaHxxqVASXpG/FtJrWldFnqNrgoZ1rx0PnnzG+i
 1I5pn6yUpf523oLYvh1m57YA==



=E5=9C=A8 2024/8/2 20:57, Mark Harmstone =E5=86=99=E9=81=93:
> From: Mark Harmstone <maharmstone@meta.com>
>
> Call btrfs_util_subvolume_snapshot in cmd_subvolume_snapshot rather than
> calling the ioctl directly.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Co-authored-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/subvolume.c | 94 +++++++++++++++++-------------------------------
>   1 file changed, 33 insertions(+), 61 deletions(-)
>
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 2a635fa2..a9664039 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -635,18 +635,11 @@ static int cmd_subvolume_snapshot(const struct cmd=
_struct *cmd, int argc, char *
>   {
>   	char	*subvol, *dst;
>   	int	res, retval;
> -	int	fd =3D -1, fddst =3D -1;
> -	int	len;
> -	bool readonly =3D false;
> -	char	*dupname =3D NULL;
> -	char	*dupdir =3D NULL;
> -	const char *newname;
> -	char	*dstdir;
> +	char	*dstdir =3D NULL;
>   	enum btrfs_util_error err;
> -	struct btrfs_ioctl_vol_args_v2	args;
> -	struct btrfs_qgroup_inherit *inherit =3D NULL;
> +	struct btrfs_util_qgroup_inherit *inherit =3D NULL;
> +	int flags =3D 0;
>
> -	memset(&args, 0, sizeof(args));
>   	optind =3D 0;
>   	while (1) {
>   		int c =3D getopt(argc, argv, "i:r");
> @@ -655,14 +648,14 @@ static int cmd_subvolume_snapshot(const struct cmd=
_struct *cmd, int argc, char *
>
>   		switch (c) {
>   		case 'i':
> -			res =3D btrfs_qgroup_inherit_add_group(&inherit, optarg);
> +			res =3D qgroup_inherit_add_group(&inherit, optarg);
>   			if (res) {
>   				retval =3D res;
>   				goto out;
>   			}
>   			break;
>   		case 'r':
> -			readonly =3D true;
> +			flags |=3D BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY;
>   			break;
>   		default:
>   			usage_unknown_option(cmd, argv);
> @@ -696,72 +689,51 @@ static int cmd_subvolume_snapshot(const struct cmd=
_struct *cmd, int argc, char *
>   	}
>
>   	if (res > 0) {
> +		char *dupname;
> +		const char *newname;
> +
>   		dupname =3D strdup(subvol);
>   		newname =3D path_basename(dupname);
> -		dstdir =3D dst;
> -	} else {
> -		dupname =3D strdup(dst);
> -		newname =3D path_basename(dupname);
> -		dupdir =3D strdup(dst);
> -		dstdir =3D path_dirname(dupdir);
> -	}
> -
> -	if (!test_issubvolname(newname)) {
> -		error("invalid snapshot name '%s'", newname);
> -		goto out;
> -	}
> -
> -	len =3D strlen(newname);
> -	if (len > BTRFS_VOL_NAME_MAX) {
> -		error("snapshot name too long '%s'", newname);
> -		goto out;
> -	}
>
> -	fddst =3D btrfs_open_dir(dstdir);
> -	if (fddst < 0)
> -		goto out;
> -
> -	fd =3D btrfs_open_dir(subvol);
> -	if (fd < 0)
> -		goto out;
> +		dstdir =3D malloc(strlen(dst) + 1 + strlen(newname) + 1);
> +		if (!dstdir) {
> +			error("out of memory");
> +			free(dupname);
> +			goto out;
> +		}
>
> -	if (readonly)
> -		args.flags |=3D BTRFS_SUBVOL_RDONLY;
> +		dstdir[0] =3D 0;
> +		strcpy(dstdir, dst);
> +		strcat(dstdir, "/");
> +		strcat(dstdir, newname);
>
> -	args.fd =3D fd;
> -	if (inherit) {
> -		args.flags |=3D BTRFS_SUBVOL_QGROUP_INHERIT;
> -		args.size =3D btrfs_qgroup_inherit_size(inherit);
> -		args.qgroup_inherit =3D inherit;
> +		free(dupname);
> +	} else {
> +		dstdir =3D strdup(dst);
>   	}
> -	strncpy_null(args.name, newname, sizeof(args.name));
>
> -	res =3D ioctl(fddst, BTRFS_IOC_SNAP_CREATE_V2, &args);
> -	if (res < 0) {
> -		if (errno =3D=3D ETXTBSY)
> -			error("cannot snapshot '%s': source subvolume contains an active swa=
pfile (%m)", subvol);
> -		else
> -			error("cannot snapshot '%s': %m", subvol);
> +	err =3D btrfs_util_subvolume_snapshot(subvol, dstdir, flags, NULL, inh=
erit);
> +	if (err) {
> +		error_btrfs_util(err);
>   		goto out;
>   	}
>
>   	retval =3D 0;	/* success */
>
> -	if (readonly)
> +	if (flags & BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY)
>   		pr_verbose(LOG_DEFAULT,
> -			   "Create readonly snapshot of '%s' in '%s/%s'\n",
> -			   subvol, dstdir, newname);
> +			   "Create readonly snapshot of '%s' in '%s'\n",
> +			   subvol, dstdir);
>   	else
>   		pr_verbose(LOG_DEFAULT,
> -			   "Create snapshot of '%s' in '%s/%s'\n",
> -			   subvol, dstdir, newname);
> +			   "Create snapshot of '%s' in '%s'\n",
> +			   subvol, dstdir);
>
>   out:
> -	close(fddst);
> -	close(fd);
> -	free(inherit);
> -	free(dupname);
> -	free(dupdir);
> +	free(dstdir);
> +
> +	if (inherit)
> +		btrfs_util_qgroup_inherit_destroy(inherit);
>
>   	return retval;
>   }

