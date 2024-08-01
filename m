Return-Path: <linux-btrfs+bounces-6950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADF945468
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 00:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AA22867A5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 22:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EA214B97B;
	Thu,  1 Aug 2024 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WIY8V9bO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9B14AA9
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550010; cv=none; b=FUTe2SxUKQwNxw4HkMMMBXb0EFSwIkaEFD0HlNlH2W0ID7H20Om3Vaq5JGDIrrjl8X2aGOXNh2retQsCFJqWKYcJejfmyhlGoHROl3jE93dJ75TGUz2tt2at3Rtf657WPztsabqCImMXKQ2arCFkfAgIayGIX0QIulOf2o8pziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550010; c=relaxed/simple;
	bh=wTeINWnCCaS9cs1sqMFsrQJQ1jL/EBjFo43dcIwyhjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5d1wVYCdXhC4+ivnLciA9XyqFpEFsDElwvccT8gTLQQ3q7e/Jo4W9N/QRIdrzbt5riwXDJhoYSnxOKVfeI17faBGSuspS3M+bkL9OQ9hk7J7Lthe6/bMjzon9K6CXkog4+f5s0ynSMQGwIaWoKWDLu846PEHszWTWPlLKSos+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WIY8V9bO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722550002; x=1723154802; i=quwenruo.btrfs@gmx.com;
	bh=s+Mzb1hHS+u2RjphILoiFtLsUPIrQ3LoNVdzE4ER3PA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WIY8V9bOckjQ6J7iVqHaxz/3MwHJa31dqYFmoH/d6dhqQ38795UqLbRqSojekCre
	 hBW1fOcAn4bachZxsmtEM0vJt21bqLW6Ixf4306vrrlr7n2lSwQM+aVz2vOPy6Wc9
	 bFzR1noQeIwIXsRUP1UrH9vdHaY2P4xrdspaIUOTdgD/3+6QBlOHE5VcPAefuNFKa
	 F+E8U/x7wbuXwHqj7eq8hca3Wki6mui5wsp2QF1O/2qxdJ4dDLJ9S58h/04cLwbSL
	 ayWVDTjsGtoBMOZKoo22XaCXyiFI8fCTEq4CnK8qlTOM8c19V2oPecT3v/bDlQ2Ua
	 A9gAXGE5HcJ6Z+H/1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGyxN-1sW7QQ3mdP-00CCqx; Fri, 02
 Aug 2024 00:06:42 +0200
Message-ID: <82ab8aa0-d4c7-4dbb-99f7-a63df5ab9c81@gmx.com>
Date: Fri, 2 Aug 2024 07:36:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: add recursive subvol delete
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Mark Harmstone <maharmstone@meta.com>
References: <20240627152156.1349692-1-maharmstone@fb.com>
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
In-Reply-To: <20240627152156.1349692-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDNjc9HCZSs7cyl2mSoJ99jZ5q1maL+uYjBJ1693Bd4uJbHsGn8
 rAyJCggiwF8Fr/fzN9MN00zb1I0QsZVO0eOjqeUNPK0usNe3ocE7K81DwgDrkkc1o6C8aZy
 NWSFkKScdjWmZkOtSqPIU1B5IrrGoCzwlXozFx+Ub9x0yjHBGvAuOl/tq4YJ+i9h7jkJsGc
 QUVN3jsTX4WCD9+CCeZjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sdGBEJt7yU4=;gTw2qdKiuGG3YG6P+axHVo7TfUh
 1J9PBYlSAeg0rtCAOQUI4VKf4SyH1DiqAZxQqeshdB6jUvPU1j248PWAccXoNn5Cts4/nuCGx
 oHo0Coax1tW8L5Cbj+W07l3ONvHpzsTsDFTz3CUw3LdwyHnXQbpaFjKyLVSXLClfzNpYbxPtg
 ESMWu5SPw+YD/hk88AnyDk7YIxVDuTh2qkI09S2LQh4pGJlWBhzE6m6GLVrgUzabk5PDERlll
 1zQ9hX/fCZYbCD3lSuomvmdutPiRSN2n92VpjLstKnpdTdYwn9ekcjp6klAnfh1jMEyUPN11n
 68sxpDdmxjICcR/cMhQSpQZy4/UEU7mxc12fQR3UwvAoJ/6LcSeIFPnMrsH4+oWLHRLZ4DeNV
 g2TqGctXyrpO27QHoyicwu0s+OCgWKyXti0rXYpgFM/qS4Ox9Ofhh9RlWZoprgMyANdCC01tI
 nG7kMw9j9AxqEMoZYE+AuFKiGLfwh/dnTasFZVslY9rsrlyB3yUOxvzVLsoDhe2UJLhf2IB6v
 nH/pmrVr1rjJy/J6x0D5JmUDjKKYpKud1uyFuC5ODvYw/BQdRpNCcMhGMcZokiOMlMUgCRKKG
 ASzHc+CUqG+QCfOZ0EKqOfzC/GLnxnN8tXegvtiFHeP1HAG3+P6eACLkZhIqLEpYKCrcEWarS
 y6FmYbASEpswsO8FQSFHcoT0bVppkn333tt0vJnX6XSQxRVbXVSXikSbqYCF71/jmVbtmK75z
 U3O6ZjT2Pm4qreJrLQqI+bnA51nNlsOKX/Usb5xntIqwMpFZ9u0q9LmTijeZApVlPSqwa5wah
 WGRrrdclW4cUBcUBLZhKw/TnQTBxtiWlQyvKzS2tXwAf0=



=E5=9C=A8 2024/6/28 00:51, Mark Harmstone =E5=86=99=E9=81=93:
> From: Omar Sandoval <osandov@fb.com>
>
> Adds a --recursive option to btrfs subvol delete, causing it to pass the
> BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE flag through to libbtrfsutil.
>
> This is a resubmission of part of a patch that Omar Sandoval sent in
> 2018, which appears to have been overlooked:
> https://lore.kernel.org/linux-btrfs/e42cdc5d5287269faf4d09e8c9786d0b3ade=
b658.1516991902.git.osandov@fb.com/
>
> Signed-off-by: Mark Harmstone <maharmstone@meta.com>
> Co-authored-by: Mark Harmstone <maharmstone@meta.com>

Looks very reasonable to me, especially the flag is already there.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   Documentation/btrfs-subvolume.rst |  4 ++++
>   cmds/subvolume.c                  | 15 +++++++++++++--
>   2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-sub=
volume.rst
> index d1e89f15..b1f22344 100644
> --- a/Documentation/btrfs-subvolume.rst
> +++ b/Documentation/btrfs-subvolume.rst
> @@ -112,6 +112,10 @@ delete [options] [<subvolume> [<subvolume>...]], de=
lete -i|--subvolid <subvolid>
>           -i|--subvolid <subvolid>
>                   subvolume id to be removed instead of the <path> that =
should point to the
>                   filesystem with the subvolume
> +
> +        -R|--recursive
> +                delete subvolumes beneath each subvolume recursively
> +
>           -v|--verbose
>                   (deprecated) alias for global *-v* option
>
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 52bc8850..b4151af2 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -347,6 +347,7 @@ static const char * const cmd_subvolume_delete_usage=
[] =3D {
>   	OPTLINE("-c|--commit-after", "wait for transaction commit at the end =
of the operation"),
>   	OPTLINE("-C|--commit-each", "wait for transaction commit after deleti=
ng each subvolume"),
>   	OPTLINE("-i|--subvolid", "subvolume id of the to be removed subvolume=
"),
> +	OPTLINE("-R|--recursive", "delete subvolumes beneath each subvolume re=
cursively"),
>   	OPTLINE("-v|--verbose", "deprecated, alias for global -v option"),
>   	HELPINFO_INSERT_GLOBALS,
>   	HELPINFO_INSERT_VERBOSE,
> @@ -367,6 +368,7 @@ static int cmd_subvolume_delete(const struct cmd_str=
uct *cmd, int argc, char **a
>   	char	*path =3D NULL;
>   	int commit_mode =3D 0;
>   	bool subvol_path_not_found =3D false;
> +	int flags =3D 0;
>   	u8 fsid[BTRFS_FSID_SIZE];
>   	u64 subvolid =3D 0;
>   	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
> @@ -383,11 +385,12 @@ static int cmd_subvolume_delete(const struct cmd_s=
truct *cmd, int argc, char **a
>   			{"commit-after", no_argument, NULL, 'c'},
>   			{"commit-each", no_argument, NULL, 'C'},
>   			{"subvolid", required_argument, NULL, 'i'},
> +			{"recursive", no_argument, NULL, 'R'},
>   			{"verbose", no_argument, NULL, 'v'},
>   			{NULL, 0, NULL, 0}
>   		};
>
> -		c =3D getopt_long(argc, argv, "cCi:v", long_options, NULL);
> +		c =3D getopt_long(argc, argv, "cCi:Rv", long_options, NULL);
>   		if (c < 0)
>   			break;
>
> @@ -401,6 +404,9 @@ static int cmd_subvolume_delete(const struct cmd_str=
uct *cmd, int argc, char **a
>   		case 'i':
>   			subvolid =3D arg_strtou64(optarg);
>   			break;
> +		case 'R':
> +			flags |=3D BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE;
> +			break;
>   		case 'v':
>   			bconf_be_verbose();
>   			break;
> @@ -416,6 +422,11 @@ static int cmd_subvolume_delete(const struct cmd_st=
ruct *cmd, int argc, char **a
>   	if (subvolid > 0 && check_argc_exact(argc - optind, 1))
>   		return 1;
>
> +	if (subvolid > 0 && flags & BTRFS_UTIL_DELETE_SUBVOLUME_RECURSIVE) {
> +		error("option --recursive not supported with --subvolid");
> +		return 1;
> +	}
> +
>   	pr_verbose(LOG_INFO, "Transaction commit: %s\n",
>   		   !commit_mode ? "none (default)" :
>   		   commit_mode =3D=3D COMMIT_AFTER ? "at the end" : "after each");
> @@ -528,7 +539,7 @@ again:
>
>   	/* Start deleting. */
>   	if (subvolid =3D=3D 0)
> -		err =3D btrfs_util_delete_subvolume_fd(fd, vname, 0);
> +		err =3D btrfs_util_delete_subvolume_fd(fd, vname, flags);
>   	else
>   		err =3D btrfs_util_delete_subvolume_by_id_fd(fd, subvolid);
>   	if (err) {

