Return-Path: <linux-btrfs+bounces-6967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B126946D1B
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019AE2817B6
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435541862A;
	Sun,  4 Aug 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TAHFm6Gc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B518028
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Aug 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722757946; cv=none; b=qfjjudmhtQ5e4BXJwcVhzN/8u1kfvsrOm9pOyNgicjTUg7KD3mNm87vULc0rqtxTnVhoOnfVY6+GreFSWImssb1LblkL/eLOM3S/23Gv/6d2H1aH4wnZG3bJCVZvfkS1PN6zN9f0qgo6e3Yyfq+6nUHmRtLf/J23t71fR2rn3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722757946; c=relaxed/simple;
	bh=4AjjspNgCXIop19iQXBMEqymIM1BRURPehfIUeEykmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvCSQ69B3KNe/zutRurPWfwkQ5OO+fcYtqLJzFPDR/iVJzrfNTyD7LfzkueW2th92PlxzlwAk7oH5WvQg8reAdJIFjMERynFHmx41GMdxlTWu2lvBKlK0U2FgFjaOQidYcmTCD/D2jmetKJI3tOG5NbqZyBJd7xW34gxBi2fqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TAHFm6Gc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722757938; x=1723362738; i=quwenruo.btrfs@gmx.com;
	bh=NvFb8+xq1kEY5Kb45wFK/gD4TlLr9Oe7KQWgl3eWtM4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TAHFm6GcoaKOnJLA2oY2DderVoUWHEV1XDxJI1X8SGtz739Y0XHyWTvtUzAQoE7f
	 2upPJry3rZ8Ym9w22uYYxKNS0WlcIvxBDUSTs7fCqvhIxA/Ego6JYxv1AH5pp6XjW
	 dezUR9Jy3tJ/NwzdzBp6hZpqKC4gv0ajCXaDMbEZ4alUfpoLFppBDrdQqMVGCa0tA
	 0e0fo2ry8jgzkK+Pt8jTTsfBQcVz6/gYGPSuFC33FxdHtoaYgvvqBx7BaeOPgPhJm
	 KQdC+pB6+AjxGJRlKZBPTvwW//zKJe/oJ+VHCblJ3xg2xw61wfyY4E4xQgmkLpm2t
	 x/p7I4om8/Wwrcj46A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1s6AuM2exL-00yR9Z; Sun, 04
 Aug 2024 09:52:18 +0200
Message-ID: <26d4dffc-0d90-408e-a2f6-059a5203856f@gmx.com>
Date: Sun, 4 Aug 2024 17:22:14 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs-progs: remove unused qgroup functions
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>
References: <20240802112730.3575159-1-maharmstone@fb.com>
 <20240802112730.3575159-4-maharmstone@fb.com>
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
In-Reply-To: <20240802112730.3575159-4-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZSQCBaAJTILi2M5avWz3CczWH6kYzIHhAFtfnnahWIUDiW/+6PC
 UYBiaaBqnL8qmJ8H+1aWzB5uDDhcj9Nnqw39VfBi219ZxCzTPG9ki7uuQuW1l0DNlTUtsww
 c+n9jfv40/uXsH4k5sqe3kZIQM0rZL3TryxWfcFoPDXVmWDSsLSlWuhQwmLta8pjuPUBEeF
 Mj07Pg0GIEuiDzGEXX5RQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3ccIMAAbkQg=;FtZCVisaBeuQcbSAkhV2wkln+ur
 FQMWcDiPOip/rfJ6O92spNBgl9v586IqtkIo/a8uMf7OWnyFSuqqLzZiNAqIZao9VfdZMRhdP
 MkMi/kR3wHX1N7B3cUbArIGHzE02V0XXBsaOxahj8oiWO1snWmbBlfmzrHski8nucI3W572xB
 gBGGiM9swbT9kOoZSdu8swz8d7vXwIsNLQ+IWn5Y28KH4RCkn02Stq7dTX140z5ZPl89nqL8T
 LXmsbmsREs1YKpn5UV1bkeAuwWl9vm2ET2KL/7adpoQctG+KbKE1njyvChTYa5bQhLbW4z9LR
 bjxOxgydfA+5CaWEgJQmZaQ1qQkWVX0osS5568OYn7LGHSjRAzFat2iEtsvW4v0HvQN0bT6db
 t0r7KyuB9JAoZgKCkUDxvy3ZSr7FoVtyKNINkqFe9PxBAwv1hhNZaPPHwtDERiwRrzDKdVirb
 JRRpndufc5z6QaKFcQ2tFcIiOdawTTzhzihsg2y6/VlI80e50aYbkUHvttaW7DpXAQmrQ/A2Y
 qVKuevWAQe4id5q9isyjh+Fjn8rijgM/fzaJ/9HJujjZtvPwZzcv/v+YxLKUzhb6LBmaBboBE
 gliXPvKsRu9RVBRpJdp+T+z8qC1wPo4d4rXsCP9xv7JWqv+wmZV505cZxdJeN38CdzWGzJ3F0
 KjeaiNhUGTzCWoeU4vb3Jw+uYsrOuzaS+PGB6W27tEykeG8F72WHEoWp5zhVILpoNADtsEPQG
 NADOoVQnk+za2+y+y/5kcLqChvFw4qiRgqHyG4mgkA00V1bxkjerysjmtfFUBytF6e2uzipJP
 XmHobL4s9Shm3sFkZi/4Nblw==



=E5=9C=A8 2024/8/2 20:57, Mark Harmstone =E5=86=99=E9=81=93:
> From: Omar Sandoval <osandov@fb.com>
>
> Remove functions that after the previous two patches are no longer
> referenced.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Co-authored-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
qu
> ---
>   cmds/qgroup.c | 64 ---------------------------------------------------
>   cmds/qgroup.h |  2 --
>   2 files changed, 66 deletions(-)
>
> diff --git a/cmds/qgroup.c b/cmds/qgroup.c
> index 20b97f7a..57052861 100644
> --- a/cmds/qgroup.c
> +++ b/cmds/qgroup.c
> @@ -1688,70 +1688,6 @@ out:
>   	return ret;
>   }
>
> -int btrfs_qgroup_inherit_size(struct btrfs_qgroup_inherit *p)
> -{
> -	return sizeof(*p) + sizeof(p->qgroups[0]) *
> -			    (p->num_qgroups + 2 * p->num_ref_copies +
> -			     2 * p->num_excl_copies);
> -}
> -
> -static int qgroup_inherit_realloc(struct btrfs_qgroup_inherit **inherit=
, int n,
> -		int pos)
> -{
> -	struct btrfs_qgroup_inherit *out;
> -	int nitems =3D 0;
> -
> -	if (*inherit) {
> -		nitems =3D (*inherit)->num_qgroups +
> -			 (*inherit)->num_ref_copies +
> -			 (*inherit)->num_excl_copies;
> -	}
> -
> -	out =3D calloc(1, sizeof(*out) + sizeof(out->qgroups[0]) * (nitems + n=
));
> -	if (out =3D=3D NULL) {
> -		error_msg(ERROR_MSG_MEMORY, NULL);
> -		return -ENOMEM;
> -	}
> -
> -	if (*inherit) {
> -		struct btrfs_qgroup_inherit *i =3D *inherit;
> -		int s =3D sizeof(out->qgroups[0]);
> -
> -		out->num_qgroups =3D i->num_qgroups;
> -		out->num_ref_copies =3D i->num_ref_copies;
> -		out->num_excl_copies =3D i->num_excl_copies;
> -		memcpy(out->qgroups, i->qgroups, pos * s);
> -		memcpy(out->qgroups + pos + n, i->qgroups + pos,
> -		       (nitems - pos) * s);
> -	}
> -	free(*inherit);
> -	*inherit =3D out;
> -
> -	return 0;
> -}
> -
> -int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inheri=
t, char *arg)
> -{
> -	int ret;
> -	u64 qgroupid =3D parse_qgroupid_or_path(arg);
> -	int pos =3D 0;
> -
> -	if (qgroupid =3D=3D 0) {
> -		error("invalid qgroup specification, qgroupid must not 0");
> -		return -EINVAL;
> -	}
> -
> -	if (*inherit)
> -		pos =3D (*inherit)->num_qgroups;
> -	ret =3D qgroup_inherit_realloc(inherit, 1, pos);
> -	if (ret)
> -		return ret;
> -
> -	(*inherit)->qgroups[(*inherit)->num_qgroups++] =3D qgroupid;
> -
> -	return 0;
> -}
> -
>   static const char * const qgroup_cmd_group_usage[] =3D {
>   	"btrfs qgroup <command> [options] <path>",
>   	NULL
> diff --git a/cmds/qgroup.h b/cmds/qgroup.h
> index 1fc10722..32309ce4 100644
> --- a/cmds/qgroup.h
> +++ b/cmds/qgroup.h
> @@ -36,8 +36,6 @@ struct btrfs_qgroup_stats {
>   	struct btrfs_qgroup_limit limit;
>   };
>
> -int btrfs_qgroup_inherit_size(struct btrfs_qgroup_inherit *p);
> -int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inheri=
t, char *arg);
>   int btrfs_qgroup_query(int fd, u64 qgroupid, struct btrfs_qgroup_stats=
 *stats);
>
>   #endif

