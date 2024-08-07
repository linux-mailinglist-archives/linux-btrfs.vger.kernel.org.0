Return-Path: <linux-btrfs+bounces-7037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CC294B328
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 00:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FBB1F23897
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C3715444E;
	Wed,  7 Aug 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mcmlLXoG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871B145B26
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723070280; cv=none; b=qa00jK1dbeXH0wwbD57g1Vk/QE+A92AUR8EBX9h3yIIse9JOrgE5yGLxYilNkEInzcELmQddnOI5HVcKf9xNDgXWm+Vp4wW73q7BZxxD46pwBkMZNYku54zReKQIUzY8FpbDRadBofIJQruoZTI4sPtL07BllvjO/1Czw5//vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723070280; c=relaxed/simple;
	bh=cL82H2KoFvry/LNufyUid7IAXApnz8X9aaZIEM6YdGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LbN2QeUf2282l5vszDge/EabUHeGJbWt/PgdcTECv3ojIkfwlpmi1M5seWHvAvFgeIi7pNEUqbF90mNHrOftGyzeB6Z+Qy/ZIOQ8c1QoAGGTH4tfoWHahrxzvcFnNZxdDB0pg4RQ/+aQ8aZa5mUwAqELNL/AKTC+8OKxg5FZ6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mcmlLXoG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723070272; x=1723675072; i=quwenruo.btrfs@gmx.com;
	bh=viNtlgNWKrCMz3iMEBnLCndV4qPapCEC+6akuAIlu08=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mcmlLXoGoQ1fDA3ggtvEs19kVlaaR4ALN24Mj0+Snn3JRtblQYpJItvNfjHRI0QQ
	 o/CpWrIHmUq1HPcZ+re46DG1QWuI/BLj0cS4TINWet1EkBbV++SVC+I5kCbwFR+f0
	 eJ1aCa6SWCAIO1Ko1pg5xZwt27r8QuO/yXDQRTCRf/pOShjdPBPGksTM5hoS943y6
	 aTuN7vRUjaLPvdf7ELSm+Plp+iLULVXybPWo6axzkF/fbZiTEj2hmt+NMGmLLKITT
	 Wb9tMK1q8tyTuYQfv0JXl4b0++nWubQHoN48HdYNbL+rq3ngpvMrsh3s3QdKwCjPU
	 emSzJhsRLimrZdpr4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1rtNjd0D5t-00kxbW; Thu, 08
 Aug 2024 00:37:52 +0200
Message-ID: <80981aba-5434-42d6-9180-5ecf2625b3ba@gmx.com>
Date: Thu, 8 Aug 2024 08:07:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240807151707.2828988-1-maharmstone@fb.com>
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
In-Reply-To: <20240807151707.2828988-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XqwKXjxoZQ0Sr5E1rWuRB99aGN1si7scDl7VEqrWHrV3Rd9TTIt
 aWnfXNYEAA5KT9TBjjkCATpqIfnKqWhp3e9ea2xOIH3BsuYK+Y4djj0mW0D4iPvD5+opszG
 kMNGVcx2qYcJWrPo3SHkHy/r1MOVrs4eWr4PACp8x1ZRfs+NtYhFQr2mG1m5xas4pmflBnQ
 DTju8PjZp+mvCORdmFgjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n65y5ZWayao=;syFP5Djp3ehf8Yj4ea7ea4bZW1G
 6STKnaLdWyoW+TwLHQj8aOAqzO32KH9hdqFU2FPtijhHArkSAQ2OstpS8rrU4rAp3finChyyh
 VOSBswVwjUz8k5JPVw1CjFjbT/c9/NT9XpONAugRsdE+xCX/v3WP+f2afLm9L/9HOdcOfnTNc
 C8xaEgGDLNw01m88s6OXtpp4PGL4ZZDDO+MaJL5wChHzhgkfJ3fKbGfjPe6U9TdI1kL2ogGuj
 9OfZPfq1ZaffWDV4jeyRPRCOkclZwgmwlyDHW1ZLsa+S8LoVK9jP0iCjK/o/zK0ffMDFBxQ0n
 JdGZ5XKYz83BKZ11n4sj4cCrniUxQdUboNVfS28OM7HORD9zMSHbwxNSLVgF5khO9YwbvNlyI
 HhA0/UBOnONzqnXvqOMzheRUI8x30s15gXclucv89aqqCZE9d0DLe5qtt5Tv8Ty77tLuLBGAB
 5zcdXa9UTcx7RDck0X78o/evUrVLVS4KnX3ObHYZ9J1Ssf5UF+y75ugPDqcOZBY0e26E8qXfe
 zYV4EpgharxdW64zbwSjqI0NClSR2eMK0whirPSLjlxrYaxWR8Ww4/TShMJ7LarXzsgjXaZBA
 SiD3x6GoRXnuY3cBn8mGcRXdAB4kjWnh98jl87KN2AJD8t+R83d/2RA3yn3vvlo/1/3RQQp6I
 I3i+0ol0FlrkWYHk2mK+IQE529RfZX+S4muDOiueggV7h3yFpAeM5qu1EUW71jQq+J/sDOey8
 XuAU9rmUzehi5W9S5b13J1rKreFSIwuj3PGr4CLbGBvykoHT5SoMdxA01gwt2eBwNY9bfN2B/
 6vXI531L+0egiOwZmUbKEfNA==



=E5=9C=A8 2024/8/8 00:46, Mark Harmstone =E5=86=99=E9=81=93:
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

This version looks much better.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just some small code style related comments.

[...]
> @@ -1272,6 +1291,77 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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

We can skip the list_empty() check, as the later list_for_each_entry()
can handle empty list pretty well.

This will save us one indent.

[...]
> @@ -1821,24 +1911,42 @@ raid_groups:
>   		error_msg(ERROR_MSG_START_TRANS, "%m");
>   		goto out;
>   	}
> -	ret =3D btrfs_rebuild_uuid_tree(fs_info);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret =3D cleanup_temp_chunks(fs_info, &allocation, data_profile,
> -				  metadata_profile, metadata_profile);
> -	if (ret < 0) {
> -		error("failed to cleanup temporary chunks: %d", ret);
> -		goto out;
> -	}
>
>   	if (source_dir) {
>   		pr_verbose(LOG_DEFAULT, "Rootdir from:       %s\n", source_dir);
> -		ret =3D btrfs_mkfs_fill_dir(source_dir, root);
> +
> +		trans =3D btrfs_start_transaction(root, 1);
> +		if (IS_ERR(trans)) {
> +			errno =3D -PTR_ERR(trans);
> +			error_msg(ERROR_MSG_START_TRANS, "%m");
> +			goto out;
> +		}
> +
> +		ret =3D btrfs_mkfs_fill_dir(trans, source_dir, root,
> +					  &subvols);
>   		if (ret) {
>   			error("error while filling filesystem: %d", ret);
> +			btrfs_abort_transaction(trans, ret);
>   			goto out;
>   		}
> +
> +		ret =3D btrfs_commit_transaction(trans, root);
> +		if (ret) {
> +			errno =3D -ret;
> +			error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +			goto out;
> +		}
> +
> +		if (!list_empty(&subvols)) {

Same here.

[...]
> @@ -511,6 +590,20 @@ static int ftw_add_inode(const char *full_path, con=
st struct stat *st,
>   	while (current_path.level > ftwbuf->level)
>   		rootdir_path_pop(&current_path);
>
> +	if (!list_empty(g_subvols) && S_ISDIR(st->st_mode)) {

The same here.

> +		struct rootdir_subvol *s;
> +
> +		list_for_each_entry(s, g_subvols, list) {
> +			if (!strcmp(full_path, s->full_path)) {
> +				return ftw_add_subvol(full_path, st, typeflag,
> +						      ftwbuf, s);

Another optimization can be, to remove @s from the g_subvols list.
So that the next search will spend a little less time to do the search.

Thanks,
Qu

