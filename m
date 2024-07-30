Return-Path: <linux-btrfs+bounces-6866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B295940E66
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 11:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6C21C20F21
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C07197A75;
	Tue, 30 Jul 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ITKGDWuV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DED196D90
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333341; cv=none; b=ugfusdw4l8GDIFugpLWhcFvqGpGP+7bHvHVaeHruf5WzdwCyc76npPBcLZkJ6ZPQAkmfh3ZfhgFglviXS2f1kWZNlNV8pNHO2vZj/lI3i8vfnumvIeMr8cnV0QLUVJIgroVFudirs6ftmtZVhtgHkln6Tb7TneGBQpeg3DFdSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333341; c=relaxed/simple;
	bh=3c3x4Pwg94TcD0CItScU/sed9T+slh/4G+Vw81Wcqx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QCpL5Q3JXn8lpQmvAhehhZi4g9RTMeU521WS9ETsomm90pIjngR9QI5yuzYgEWuI4zJAN3Ph1Nl+MSY4UjzXYBTbi+AjX+bfbfMqhkm4HyRhaE0DWEhyJhKTGLIOflgFxAN9v7TlvmQg0AiiVfFdOCHc5Bfn13bJHH3oAbf1WOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ITKGDWuV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722333333; x=1722938133; i=quwenruo.btrfs@gmx.com;
	bh=NadnmfOvW/uJweHCu20tMxH+S/c6MqDTYbPVwMjm8rs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ITKGDWuV5XAYzYCCIdBlgVbTJm3vVbtf/oHGVkaREcOQlF+uSdS/fU3R1SV407Ue
	 NyIUVFNV0oejBdi9pq9BxCoZP0apglh40BbGtGrt4w3Mz4tVhQMsIU0AqlxP0ddXs
	 oohe4XLhsIz8yB/xRDupUX3hsQbXEnVkwUNkMsfPZaXNWHRq+DnGIIbXxdSBwVSUp
	 vknzERWK9DuTaxo9gypRGFT086ESvmu04SSMoUt39BhSw1paQ7jnYFb2TNpFQ+hrW
	 NZobE1jclMl7n/amUn2++043JMgWqvtzjKCaCVRweLFhNZp0+t0JGOifx3Y8kJmiO
	 cPkbMZB2rZ3DQrlB2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1smE7x0xdJ-00Miki; Tue, 30
 Jul 2024 11:55:33 +0200
Message-ID: <d67ca8a6-9b5f-4ba1-aae3-70e1cb22ecda@gmx.com>
Date: Tue, 30 Jul 2024 19:25:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240730093833.1169945-1-maharmstone@fb.com>
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
In-Reply-To: <20240730093833.1169945-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fKTC5JqRrRIz0O7MYxEcOuH5A9vSvLgNQigvqqkME3NACYBvL7r
 syFH1S8kIXZGg1UPS0ajp2gkg7q67qp24YuokJMZZzjNkrDE/3mEtRBcKHNd9stefa/Icdq
 ax9DlHtX6KssessQVSRHuJ/YucA46fQGHLJM0QoZUG5LZhbBegBJQz57/tiTNjB9Citd9vN
 qollQ/ia6Dz1ntMK4Jhyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t5nFdq4lucg=;tkd52cOEyzI436jjNmIxdqT3TpN
 sz1uVTbjh8VxuRzAPuwqPWClKj1PxBnuUHvwOMtMALtGj+5Pi0ivQdpfDlVQWzxb+VOkwC7Jb
 Nw3/DIKpfC7HRZldQDBL5cM5T/tTfaG9CC3cwI+ZRkD8pDQk4FJJXAOkEamf5GczoIWU85nqV
 PdiSKPjsMsmJyUphVLO9GD7jIMKxgU/gHOl508dYGv6qwbEa787zJOFZhhZRrGAAjFQd9zYGn
 WzE2BW9KNzJd0UkCgmc4vYzqp1Di84mfUGmgVuIKj0eOUovsw6Y6WKz13A2hAm7kNVMbck0NE
 tDIlzNRkNn5pjk5XJ0KFxL54oqViDCpePZaJYDpgqzHKvrO9dTjB+HldM2hQ3lkwHt5W92ACk
 tbcODWo8lqUISM37sLFBA6lNxxawNPKeQSdPHTKRKbqXIc8+l8FlTA0uS+l952qGuGfWLd27F
 2Nz0smcBgcbjC1f+vGyAQYBke5rvf+hYoR63xDi2zfGFTkZ74IDdCQq56ukBdgiCE3AvEDCin
 ZXerELDA7JFsKm9QQqWMtKcaIryLR8J37zaa5Lwz9v4C2qz5/crEn8wuhnu7lD4sLFGxpQyRg
 G6knfMxRB+NdyFYeslTMpmzEED6orIVpcENjorxVxVSHOzrmOcw5RRljcAD8kgZXmo8wm+aqp
 1DXoN4SnM+XMW0jBC0IRiSJvDTgLrdqpwXtjfCYJFXDD24DsYYGhwIU2H+qOp+Re7wzPamHmB
 VUEd+UjZoteubc41+UKPEsVsEsDk9MAzYUJXQYqIUc4mmMWO7R2a5xotyUrlGReNSRqKfLWwT
 YvASzO/TTXxw9tAKYDV3fcbQ==



=E5=9C=A8 2024/7/30 19:08, Mark Harmstone =E5=86=99=E9=81=93:
> This patch adds a --subvol option, which tells mkfs.btrfs to create the
> specified directories as subvolumes.
>
> Given a populated directory img, the command
>
> $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home --subvol i=
mg/home/username /dev/loop0
>
> will create subvolumes usr and home within the FS root, and subvolume
> username within the home subvolume. It will fail if any of the
> directories do not yet exist.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Unfortunately I'm still not a fan of splitting the handling of subvolume
and directory creation.

Why not go a hashmap to save all the subvolume paths, and check if a
directory should be a subvolume, then go btrfs_make_subvolume() and
btrfs_link_subvolume() inside that context?

> ---
> Changes from first patch:
> * Rebased against upstream changes
> * Rewrote so that directory sizes are correct within transactions
> * Changed --subvol so that it is relative to cwd rather than rootdir, so
> that in future we might allow out-of-tree subvols
>
>   mkfs/main.c                                 | 316 +++++++++++++++++++-
>   mkfs/rootdir.c                              | 125 +++++++-
>   mkfs/rootdir.h                              |  21 +-
>   tests/mkfs-tests/034-rootdir-subvol/test.sh |  33 ++
>   4 files changed, 479 insertions(+), 16 deletions(-)
>   create mode 100755 tests/mkfs-tests/034-rootdir-subvol/test.sh
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index e000aeff..6c98b954 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -442,6 +442,7 @@ static const char * const mkfs_usage[] =3D {
>   	"Creation:",
>   	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (fil=
esystem size is sum of all device sizes)"),
>   	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root di=
rectory"),
> +	OPTLINE("-u|--subvol SUBDIR", "create SUBDIR as subvolume rather than =
normal directory"),
>   	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to=
 minimal size"),
>   	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
>   	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
> @@ -1016,6 +1017,19 @@ static void *prepare_one_device(void *ctx)
>   	return NULL;
>   }
>
> +static int subvol_compar(const void *p1, const void *p2)
> +{
> +	const struct rootdir_subvol *s1 =3D *(const struct rootdir_subvol**)p1=
;
> +	const struct rootdir_subvol *s2 =3D *(const struct rootdir_subvol**)p2=
;
> +
> +	if (s1->depth < s2->depth)
> +		return 1;
> +	else if (s1->depth > s2->depth)
> +		return -1;
> +	else
> +		return 0;
> +}
> +
>   int BOX_MAIN(mkfs)(int argc, char **argv)
>   {
>   	char *file;
> @@ -1057,6 +1071,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	char *label =3D NULL;
>   	int nr_global_roots =3D sysconf(_SC_NPROCESSORS_ONLN);
>   	char *source_dir =3D NULL;
> +	LIST_HEAD(subvols);
>
>   	cpu_detect_flags();
>   	hash_init_accel();
> @@ -1087,6 +1102,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			{ "data", required_argument, NULL, 'd' },
>   			{ "version", no_argument, NULL, 'V' },
>   			{ "rootdir", required_argument, NULL, 'r' },
> +			{ "subvol", required_argument, NULL, 'u' },
>   			{ "nodiscard", no_argument, NULL, 'K' },
>   			{ "features", required_argument, NULL, 'O' },
>   			{ "runtime-features", required_argument, NULL, 'R' },
> @@ -1104,7 +1120,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			{ NULL, 0, NULL, 0}
>   		};
>
> -		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
> +		c =3D getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKqu:",
>   				long_options, NULL);
>   		if (c < 0)
>   			break;
> @@ -1210,6 +1226,27 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   				free(source_dir);
>   				source_dir =3D strdup(optarg);
>   				break;
> +			case 'u': {
> +				struct rootdir_subvol *s;
> +
> +				s =3D malloc(sizeof(struct rootdir_subvol));
> +				if (!s) {
> +					error("out of memory");
> +					ret =3D 1;
> +					goto error;
> +				}
> +
> +				s->dir =3D strdup(optarg);
> +				s->srcpath =3D NULL;
> +				s->destpath =3D NULL;
> +				s->parent =3D NULL;
> +				s->parent_inum =3D 0;
> +				INIT_LIST_HEAD(&s->children);
> +				s->root =3D NULL;
> +
> +				list_add_tail(&s->list, &subvols);
> +				break;
> +				}
>   			case 'U':
>   				strncpy_null(fs_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
>   				break;
> @@ -1274,6 +1311,154 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		ret =3D 1;
>   		goto error;
>   	}
> +	if (!list_empty(&subvols) && source_dir =3D=3D NULL) {
> +		error("the option --subvol must be used with --rootdir");
> +		ret =3D 1;
> +		goto error;
> +	}
> +
> +	if (source_dir) {
> +		char *canonical =3D realpath(source_dir, NULL);
> +
> +		if (!canonical) {
> +			error("could not get canonical path to %s", source_dir);
> +			ret =3D 1;
> +			goto error;
> +		}
> +
> +		free(source_dir);
> +		source_dir =3D canonical;
> +	}
> +
> +	if (!list_empty(&subvols)) {
> +		unsigned int num_subvols =3D 0;
> +		size_t source_dir_len =3D strlen(source_dir);
> +		struct rootdir_subvol **arr, **ptr, *s;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			char *path;
> +			struct rootdir_subvol *s2;
> +
> +			if (!path_exists(s->dir)) {
> +				error("subvol %s does not exist",
> +				      s->dir);
> +				ret =3D 1;
> +				goto error;
> +			}
> +
> +			if (!path_is_dir(s->dir)) {
> +				error("subvol %s is not a directory", s->dir);
> +				ret =3D 1;
> +				goto error;
> +			}
> +
> +			path =3D realpath(s->dir, NULL);
> +
> +			if (!path) {
> +				error("could not get canonical path to %s",
> +				      s->dir);
> +				ret =3D 1;
> +				goto error;
> +			}
> +
> +			s->srcpath =3D path;
> +			s->srcpath_len =3D strlen(path);
> +
> +			if (s->srcpath_len >=3D source_dir_len + 1 &&
> +			    !memcmp(path, source_dir, source_dir_len) &&
> +			    path[source_dir_len] =3D=3D '/') {
> +				s->destpath_len =3D s->srcpath_len - source_dir_len - 1;
> +
> +				s->destpath =3D malloc(s->destpath_len + 1);
> +				if (!s->destpath) {
> +					error("out of memory");
> +					ret =3D 1;
> +					goto error;
> +				}
> +
> +				memcpy(s->destpath, s->srcpath + source_dir_len + 1,
> +				       s->destpath_len);
> +				s->destpath[s->destpath_len] =3D 0;
> +			} else {
> +				error("subvol %s is not a child of %s",
> +				      s->dir, source_dir);
> +				ret =3D 1;
> +				goto error;
> +			}
> +
> +			for (s2 =3D list_first_entry(&subvols, struct rootdir_subvol, list);
> +			     s2 !=3D s; s2 =3D list_next_entry(s2, list)) {
> +				if (!strcmp(s2->srcpath, path)) {
> +					error("subvol %s specified more than once",
> +					      s->dir);
> +					ret =3D 1;
> +					goto error;
> +				}
> +			}
> +
> +			s->depth =3D 0;
> +			for (i =3D 0; i < s->destpath_len; i++) {
> +				if (s->destpath[i] =3D=3D '/')
> +					s->depth++;
> +			}
> +
> +			num_subvols++;
> +		}
> +
> +		/* Reorder subvol list by depth. */
> +
> +		arr =3D malloc(sizeof(struct rootdir_subvol*) * num_subvols);
> +		if (!arr) {
> +			error("out of memory");
> +			ret =3D 1;
> +			goto error;
> +		}
> +
> +		ptr =3D arr;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			*ptr =3D s;
> +			ptr++;
> +		}
> +
> +		qsort(arr, num_subvols, sizeof(struct rootdir_subvol*),
> +		      subvol_compar);
> +
> +		INIT_LIST_HEAD(&subvols);
> +		for (i =3D 0; i < num_subvols; i++) {
> +			list_add_tail(&arr[i]->list, &subvols);
> +		}
> +
> +		free(arr);
> +
> +		/* Assign subvols to parents. */
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			if (s->depth =3D=3D 0)
> +				break;
> +
> +			for (struct rootdir_subvol *s2 =3D list_next_entry(s, list);
> +			     !list_entry_is_head(s2, &subvols, list);
> +			     s2 =3D list_next_entry(s2, list)) {
> +				if (s2->depth =3D=3D s->depth)
> +					continue;
> +
> +				if (s->destpath_len <=3D s2->destpath_len + 1)
> +					continue;
> +
> +				if (s->destpath[s2->destpath_len] !=3D '/')
> +					continue;
> +
> +				if (memcmp(s->destpath, s2->destpath, s2->destpath_len))
> +					continue;
> +
> +				s->parent =3D s2;
> +				list_add_tail(&s->child_list, &s2->children);
> +
> +				break;
> +			}
> +		}
> +	}
>
>   	if (*fs_uuid) {
>   		uuid_t dummy_uuid;
> @@ -1823,6 +2008,51 @@ raid_groups:
>   		error_msg(ERROR_MSG_START_TRANS, "%m");
>   		goto out;
>   	}
> +
> +	if (!list_empty(&subvols)) {
> +		struct rootdir_subvol *s;
> +		u64 objectid =3D BTRFS_FIRST_FREE_OBJECTID;
> +
> +		list_for_each_entry_reverse(s, &subvols, list) {
> +			struct btrfs_key key;
> +
> +			s->objectid =3D objectid;
> +
> +			trans =3D btrfs_start_transaction(root, 1);
> +			if (IS_ERR(trans)) {
> +				errno =3D -PTR_ERR(trans);
> +				error_msg(ERROR_MSG_START_TRANS, "%m");
> +				ret =3D 1;
> +				goto error;
> +			}
> +
> +			ret =3D btrfs_make_subvolume(trans, objectid);
> +			if (ret < 0) {
> +				error("failed to create subvolume: %d", ret);
> +				goto out;
> +			}
> +
> +			ret =3D btrfs_commit_transaction(trans, root);
> +			if (ret) {
> +				errno =3D -ret;
> +				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +				goto out;
> +			}
> +
> +			key.objectid =3D objectid;
> +			key.type =3D BTRFS_ROOT_ITEM_KEY;
> +			key.offset =3D (u64)-1;
> +
> +			s->root =3D btrfs_read_fs_root(fs_info, &key);
> +			if (IS_ERR(s->root)) {
> +				error("unable to fs read root: %lu", PTR_ERR(s->root));
> +				goto out;
> +			}
> +
> +			objectid++;
> +		}
> +	}
> +
>   	ret =3D btrfs_rebuild_uuid_tree(fs_info);
>   	if (ret < 0)
>   		goto out;
> @@ -1835,8 +2065,24 @@ raid_groups:
>   	}
>
>   	if (source_dir) {
> +		LIST_HEAD(subvol_children);
> +
>   		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
> -		ret =3D btrfs_mkfs_fill_dir(source_dir, root);
> +
> +		if (!list_empty(&subvols)) {
> +			struct rootdir_subvol *s;
> +
> +			list_for_each_entry(s, &subvols, list) {
> +				if (s->parent)
> +					continue;
> +
> +				list_add_tail(&s->child_list,
> +					      &subvol_children);
> +			}
> +		}
> +
> +		ret =3D btrfs_mkfs_fill_dir(source_dir, root, &subvol_children,
> +					  "");
>   		if (ret) {
>   			error("error while filling filesystem: %d", ret);
>   			goto out;
> @@ -1853,6 +2099,59 @@ raid_groups:
>   		} else {
>   			pr_verbose(LOG_DEFAULT, "  Shrink:           no\n");
>   		}
> +
> +		if (!list_empty(&subvols)) {
> +			struct rootdir_subvol *s;
> +
> +			list_for_each_entry_reverse(s, &subvols, list) {
> +				pr_verbose(LOG_DEFAULT,
> +					   "  Subvol from:      %s -> %s\n",
> +					   s->srcpath, s->destpath);
> +			}
> +		}
> +	}
> +
> +	if (!list_empty(&subvols)) {
> +		struct rootdir_subvol *s;
> +
> +		list_for_each_entry(s, &subvols, list) {
> +			ret =3D btrfs_mkfs_fill_dir(s->srcpath, s->root,
> +						  &s->children, s->destpath);
> +			if (ret) {
> +				error("error while filling filesystem: %d",
> +				      ret);
> +				goto out;
> +			}
> +		}
> +
> +		list_for_each_entry_reverse(s, &subvols, list) {
> +			struct btrfs_root *parent =3D s->parent ? s->parent->root : root;
> +
> +			trans =3D btrfs_start_transaction(parent, 1);
> +			if (IS_ERR(trans)) {
> +				errno =3D -PTR_ERR(trans);
> +				error_msg(ERROR_MSG_START_TRANS, "%m");
> +				goto out;
> +			}
> +
> +			ret =3D btrfs_link_subvolume(trans, parent,
> +						 s->parent_inum,
> +						 path_basename(s->destpath),
> +						 strlen(path_basename(s->destpath)),
> +						 s->root);
> +			if (ret) {
> +				error("unable to link subvolume %s",
> +					path_basename(s->destpath));
> +				goto out;
> +			}
> +
> +			ret =3D btrfs_commit_transaction(trans, parent);
> +			if (ret) {
> +				errno =3D -ret;
> +				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +				goto out;
> +			}
> +		}
>   	}
>
>   	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
> @@ -1948,6 +2247,19 @@ error:
>   	free(label);
>   	free(source_dir);
>
> +	while (!list_empty(&subvols)) {
> +		struct rootdir_subvol *head =3D list_entry(subvols.next,
> +					      struct rootdir_subvol,
> +					      list);
> +
> +		free(head->dir);
> +		free(head->srcpath);
> +		free(head->destpath);
> +
> +		list_del(&head->list);
> +		free(head);
> +	}
> +
>   	return !!ret;
>
>   success:
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 2b39f6bb..e3e576b2 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -184,17 +184,58 @@ static void free_namelist(struct dirent **files, i=
nt count)
>   	free(files);
>   }
>
> -static u64 calculate_dir_inode_size(const char *dirname)
> +static u64 calculate_dir_inode_size(const char *src_dir,
> +				    struct list_head *subvol_children,
> +				    const char *dest_dir)

And before the --subvolume option, I'm more intesrested in getting rid
of the function completely.

Instead, if we go something like the following, there will be no need to
calculate the dir inode size:

- Create a new inode/subvolume
- Link the new inode to the parent inode

As btrfs_link_inode()/btrfs_link_subvolume() would handle the increase
of inode size.

As long as we're only using btrfs_link_inode() and
btrfs_link_subvolume(), then there is no need to go this function.

Furthermore it would make the whole opeartion more like a regular copy
(although implemented in progs), other than some specific btrfs hacks
just to pass the pretty strict "btrfs check".

Thanks,
Qu


>   {
>   	int count, i;
>   	struct dirent **files, *cur_file;
>   	u64 dir_inode_size =3D 0;
> +	struct rootdir_subvol *s;
>
> -	count =3D scandir(dirname, &files, directory_select, NULL);
> +	count =3D scandir(src_dir, &files, directory_select, NULL);
>
>   	for (i =3D 0; i < count; i++) {
> +		size_t name_len;
> +
>   		cur_file =3D files[i];
> -		dir_inode_size +=3D strlen(cur_file->d_name);
> +		name_len =3D strlen(cur_file->d_name);
> +
> +		/* Skip entry if it's going to be a subvol (it will be accounted
> +		 * for in btrfs_link_subvolume). */
> +		if (cur_file->d_type =3D=3D DT_DIR && !list_empty(subvol_children)) {
> +			bool skip =3D false;
> +
> +			list_for_each_entry(s, subvol_children, child_list) {
> +				if (!strcmp(dest_dir, "")) {
> +					if (!strcmp(cur_file->d_name, s->destpath)) {
> +						skip =3D true;
> +						break;
> +					}
> +				} else {
> +					if (s->destpath_len !=3D strlen(dest_dir) + 1 +
> +					    name_len)
> +						continue;
> +
> +					if (memcmp(s->destpath, dest_dir, strlen(dest_dir)))
> +						continue;
> +
> +					if (s->destpath[strlen(dest_dir)] !=3D '/')
> +						continue;
> +
> +					if (!memcmp(s->destpath + strlen(dest_dir) + 1,
> +						    cur_file->d_name, name_len)) {
> +						skip =3D true;
> +						break;
> +					}
> +				}
> +			}
> +
> +			if (skip)
> +				continue;
> +		}
> +
> +		dir_inode_size +=3D name_len;
>   	}
>
>   	free_namelist(files, count);
> @@ -207,7 +248,9 @@ static int add_inode_items(struct btrfs_trans_handle=
 *trans,
>   			   struct btrfs_root *root,
>   			   struct stat *st, const char *name,
>   			   u64 self_objectid,
> -			   struct btrfs_inode_item *inode_ret)
> +			   struct btrfs_inode_item *inode_ret,
> +			   struct list_head *subvol_children,
> +			   const char *dest_dir)
>   {
>   	int ret;
>   	struct btrfs_inode_item btrfs_inode;
> @@ -218,7 +261,9 @@ static int add_inode_items(struct btrfs_trans_handle=
 *trans,
>   	objectid =3D self_objectid;
>
>   	if (S_ISDIR(st->st_mode)) {
> -		inode_size =3D calculate_dir_inode_size(name);
> +		inode_size =3D calculate_dir_inode_size(name,
> +						      subvol_children,
> +						      dest_dir);
>   		btrfs_set_stack_inode_size(&btrfs_inode, inode_size);
>   	}
>
> @@ -430,7 +475,9 @@ end:
>   }
>
>   static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
> -			      struct btrfs_root *root, const char *dir_name)
> +			      struct btrfs_root *root, const char *dir_name,
> +			      struct list_head *subvol_children,
> +			      const char *dest_dir)
>   {
>   	u64 root_dir_inode_size;
>   	struct btrfs_inode_item *inode_item;
> @@ -468,7 +515,8 @@ static int copy_rootdir_inode(struct btrfs_trans_han=
dle *trans,
>   	leaf =3D path.nodes[0];
>   	inode_item =3D btrfs_item_ptr(leaf, path.slots[0], struct btrfs_inode=
_item);
>
> -	root_dir_inode_size =3D calculate_dir_inode_size(dir_name);
> +	root_dir_inode_size =3D calculate_dir_inode_size(dir_name, subvol_chil=
dren,
> +						       dest_dir);
>   	btrfs_set_inode_size(leaf, inode_item, root_dir_inode_size);
>
>   	/* Unlike fill_inode_item, we only need to copy part of the attribute=
s. */
> @@ -493,7 +541,9 @@ error:
>
>   static int traverse_directory(struct btrfs_trans_handle *trans,
>   			      struct btrfs_root *root, const char *dir_name,
> -			      struct directory_name_entry *dir_head)
> +			      struct directory_name_entry *dir_head,
> +			      struct list_head *subvol_children,
> +			      const char *dest_dir)
>   {
>   	int ret =3D 0;
>
> @@ -519,12 +569,21 @@ static int traverse_directory(struct btrfs_trans_h=
andle *trans,
>   		goto fail_no_dir;
>   	}
>
> +	dir_entry->dest_dir =3D strdup(dest_dir);
> +	if (!dir_entry->dest_dir) {
> +		error_msg(ERROR_MSG_MEMORY, NULL);
> +		ret =3D -ENOMEM;
> +		goto fail_no_dir;
> +	}
> +
>   	parent_inum =3D highest_inum + BTRFS_FIRST_FREE_OBJECTID;
>   	dir_entry->inum =3D parent_inum;
>   	list_add_tail(&dir_entry->list, &dir_head->list);
>
> -	ret =3D copy_rootdir_inode(trans, root, dir_name);
> +	ret =3D copy_rootdir_inode(trans, root, dir_name, subvol_children,
> +				 dest_dir);
>   	if (ret < 0) {
> +		free(dir_entry->dest_dir);
>   		errno =3D -ret;
>   		error("failed to copy rootdir inode: %m");
>   		goto fail_no_dir;
> @@ -555,7 +614,7 @@ static int traverse_directory(struct btrfs_trans_han=
dle *trans,
>   		}
>
>   		for (i =3D 0; i < count; i++) {
> -			char tmp[PATH_MAX];
> +			char tmp[PATH_MAX], cur_dest[PATH_MAX];
>
>   			cur_file =3D files[i];
>
> @@ -570,6 +629,33 @@ static int traverse_directory(struct btrfs_trans_ha=
ndle *trans,
>   				pr_verbose(LOG_INFO, "ADD: %s\n", tmp);
>   			}
>
> +			if (S_ISDIR(st.st_mode)) {
> +				if (!strcmp(parent_dir_entry->dest_dir, "")) {
> +					strcpy(cur_dest, cur_file->d_name);
> +				} else {
> +					strcpy(cur_dest, parent_dir_entry->dest_dir);
> +					strcat(cur_dest, "/");
> +					strcat(cur_dest, cur_file->d_name);
> +				}
> +			}
> +
> +			/* Omit child if it is going to be a subvolume. */
> +			if (!list_empty(subvol_children) && S_ISDIR(st.st_mode)) {
> +				struct rootdir_subvol *s;
> +				bool skip =3D false;
> +
> +				list_for_each_entry(s, subvol_children, child_list) {
> +					if (!strcmp(cur_dest, s->destpath)) {
> +						s->parent_inum =3D parent_inum;
> +						skip =3D true;
> +						break;
> +					}
> +				}
> +
> +				if (skip)
> +					continue;
> +			}
> +
>   			/*
>   			 * We can not directly use the source ino number,
>   			 * as there is a chance that the ino is smaller than
> @@ -589,7 +675,8 @@ static int traverse_directory(struct btrfs_trans_han=
dle *trans,
>
>   			ret =3D add_inode_items(trans, root, &st,
>   					      cur_file->d_name, cur_inum,
> -					      &cur_inode);
> +					      &cur_inode, subvol_children,
> +					      cur_dest);
>   			if (ret =3D=3D -EEXIST) {
>   				if (st.st_nlink <=3D 1) {
>   					error(
> @@ -638,6 +725,15 @@ static int traverse_directory(struct btrfs_trans_ha=
ndle *trans,
>   					goto fail;
>   				}
>   				dir_entry->inum =3D cur_inum;
> +
> +				dir_entry->dest_dir =3D strdup(cur_dest);
> +				if (!dir_entry->dest_dir) {
> +					free(dir_entry->path);
> +					error_msg(ERROR_MSG_MEMORY, NULL);
> +					ret =3D -ENOMEM;
> +					goto fail;
> +				}
> +
>   				list_add_tail(&dir_entry->list,
>   					      &dir_head->list);
>   			} else if (S_ISREG(st.st_mode)) {
> @@ -661,6 +757,7 @@ static int traverse_directory(struct btrfs_trans_han=
dle *trans,
>   		}
>
>   		free_namelist(files, count);
> +		free(parent_dir_entry->dest_dir);
>   		free(parent_dir_entry->path);
>   		free(parent_dir_entry);
>
> @@ -680,7 +777,8 @@ fail_no_dir:
>   	goto out;
>   }
>
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
)
> +int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
,
> +			struct list_head *subvol_children, const char* dest_dir)
>   {
>   	int ret;
>   	struct btrfs_trans_handle *trans;
> @@ -705,7 +803,8 @@ int btrfs_mkfs_fill_dir(const char *source_dir, stru=
ct btrfs_root *root)
>   		goto fail;
>   }
>
> -	ret =3D traverse_directory(trans, root, source_dir, &dir_head);
> +	ret =3D traverse_directory(trans, root, source_dir, &dir_head,
> +				 subvol_children, dest_dir);
>   	if (ret) {
>   		error("unable to traverse directory %s: %d", source_dir, ret);
>   		goto fail;
> diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
> index 8d5f6896..64402dbe 100644
> --- a/mkfs/rootdir.h
> +++ b/mkfs/rootdir.h
> @@ -33,10 +33,29 @@ struct directory_name_entry {
>   	const char *dir_name;
>   	char *path;
>   	ino_t inum;
> +	char *dest_dir;
>   	struct list_head list;
>   };
>
> -int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
);
> +struct rootdir_subvol {
> +	struct list_head list;
> +	struct list_head child_list;
> +	char *dir;
> +	char *srcpath;
> +	size_t srcpath_len;
> +	char *destpath;
> +	size_t destpath_len;
> +	struct rootdir_subvol *parent;
> +	u64 parent_inum;
> +	struct list_head children;
> +	unsigned int depth;
> +	u64 objectid;
> +	struct btrfs_root *root;
> +};
> +
> +int btrfs_mkfs_fill_dir(const char *source_dir, struct btrfs_root *root=
,
> +			struct list_head *subvol_children,
> +			const char* dest_dir);
>   u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_=
dev_size,
>   			u64 meta_profile, u64 data_profile);
>   int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_=
ret,
> diff --git a/tests/mkfs-tests/034-rootdir-subvol/test.sh b/tests/mkfs-te=
sts/034-rootdir-subvol/test.sh
> new file mode 100755
> index 00000000..ccd6893f
> --- /dev/null
> +++ b/tests/mkfs-tests/034-rootdir-subvol/test.sh
> @@ -0,0 +1,33 @@
> +#!/bin/bash
> +# smoke test for mkfs.btrfs --subvol option
> +
> +source "$TEST_TOP/common" || exit
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +tmp=3D$(_mktemp_dir mkfs-rootdir)
> +
> +touch $tmp/foo
> +mkdir $tmp/dir
> +mkdir $tmp/dir/subvol
> +touch $tmp/dir/subvol/bar
> +
> +run_check_mkfs_test_dev --rootdir "$tmp" --subvol "$tmp/dir/subvol"
> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
> +
> +run_check_mount_test_dev
> +run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list "$TEST_MNT" |=
 \
> +	cut -d\  -f9 > "$tmp/output"
> +run_check_umount_test_dev
> +
> +result=3D$(cat "$tmp/output")
> +
> +if [ "$result" !=3D "dir/subvol" ]; then
> +	_fail "dir/subvol not in subvolume list"
> +fi
> +
> +rm -rf -- "$tmp"

