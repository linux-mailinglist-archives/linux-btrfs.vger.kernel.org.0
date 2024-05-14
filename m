Return-Path: <linux-btrfs+bounces-4958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9CC8C4D27
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 09:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41031283A56
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A81400A;
	Tue, 14 May 2024 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rhMXsQTq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB9D2FA
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672291; cv=none; b=sWrCkVoeayBbnhOPXaBaoUnX3TIOSeWYI3AKNBHDIQ2WHzhr8kr5ZUDMwNPS8FQkF9wARkggWXUnVBaLz5TCqRvSWek60wQwUe5yXQqYi3tuNJxNJRfkXQCmouCU+DTLfJBYCi8nCh2bzXuXB6fdEyfG2V+LVN20hWwq3MJCXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672291; c=relaxed/simple;
	bh=w+TasOoW6SN1hNzwLK0KbPRwhC6lP22gZL+I5HH/zJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UmRdfpc23f0YBBYsdB8obuFF2VHsvqfTJxaHRXcyAET0Cc6NH4O0VAFkVq+H/FRDI6Z0VO48U7uKF38K98dy5UuO5Sa0L/wg1j0C31stWgFKDz8VJSl5jAcA43T86ob2bVoY8F+LpL5Tk87XizTRMzQe9F6pBsuiXASHzkut8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rhMXsQTq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715672283; x=1716277083; i=quwenruo.btrfs@gmx.com;
	bh=buKLfZs9lfCF2xYzpNP3r7A8S/R3PXuD4sxJjZDwj/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rhMXsQTqbS468HxNLmfqbIyJkOsqB/YR9BiBc30EaCBSHwkMsDLDpBX4qioZo1l0
	 OGKsO1FuN8/fsGRw4VXOqItwmv2yom1SglbR3/omB1cG90LSkm6Axt/S3drN/g+XZ
	 /igKkuePxkhIKqnJTzj4LqLZU6Jdcv8AM9iW0c4oKZCv4YgCueF8xbsR49f1d35a9
	 tk8bOd9J44UZ12d4IVpjZDJ7tmkZ9b4JB08HMf65e/oeB+OrESCqZ434MVu9ygfF5
	 rFvajpmXwe/edoWlKwd+yWSwbsptS8mmpnWu3Pv1NvkECg/mHziFPHAuBjHailw2x
	 ud2j7nLOpSOZkuqyiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTABZ-1s0ZSY33d9-00UbYM; Tue, 14
 May 2024 09:38:03 +0200
Message-ID: <9974f3e7-ffc8-4fc1-a8d5-ab9b14fc14cb@gmx.com>
Date: Tue, 14 May 2024 17:07:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix misspelled end IO compression callbacks
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <4a9ef85f3ad20b4a423a695dc90c9fb028135faf.1715620538.git.fdmanana@suse.com>
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
In-Reply-To: <4a9ef85f3ad20b4a423a695dc90c9fb028135faf.1715620538.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SbLPSaabEYAFjDDBUy9Aol3W18mvSe/cIipHvwxitvO8aTs1oj5
 6e4XOkKkKwxLsJ+gyCDKNKJXBOphhR6xEV2ogeX7vQtWR9GrsDgTMjSMkKzPWULIkpENSX8
 osFgC237IbDI2a1PbaKw42nVPSQCAVjo7Qa1fRbYlJFdiuIplD0tyY4tchsVrwRjZyFdsyh
 Jk/KcE0/4Riw6TuDFFrmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g8JzGlU39rc=;IhRWwvMv02miSfvqwIn34dmtxrf
 paA/M/GPRnvUoS0Lvvfc5FF4XwvtZPQSJ53nyHYgBoX7NppHwZX4iUtgtRz+EZ9pQjuc0vUgs
 KTrD5m4k9gAS0fWVIdugjT/ChfJ2erCiWkNd038Y8UunViQuKUqR1U8jo9xyJCLzGHon+uQkq
 N871Y12aFjq6e72qCreF5YZ1dNr2luHcmSjm26et1N3EMyUoEnCGI8UZYRgcqmQdG4r99P47u
 jqggvCEc1TAvp4roIZy5k0oIraSNG4HxenxxNsm5qzHC/Q3EYrHcRpagxK5jK0dYqbLB2UYKD
 DDoHIklf70cy7x9LdqsWP7K40EcPF7xaD9rbZDDfn+478ljRWQCngvfweNiFkEmNzW9umSAhe
 YoYLB0XOh03WrrIbLppy1JDNd3dxO+u9ZfjLJUmZMRct7oNmSCbRifiJCBflWPgnzlyiFOmjG
 2TRU+97Bz/yBsx1BQcEXlpB6Pd7QNM08wnduP3iHYoZ8g+C3wO6MVmGk7lckqLFyLPE1CGd4a
 SnjHoK2yb9NP9BhKD0EON6exMYDbXgB9AhYgi+W6xXb8n2l9PTOzytqDyb6h2SXUGN5CLAfIX
 5mxSYv3GI3pA0G7Xci3vDLMh1rsxQaHu2dR7HLFY0qoWsv8FLl61P5g3imXfPA6/AgP0aRbWH
 em8ooxvwfuayRDbOiD9Lw1tao1u3zug/Gv+vJR0R9nFuzds/Ra5SxMsVxMJcKAKAgQutWA3Kd
 Md5owWzrJ2vHQN1h3aHm+CRTL+0oSpOj/xJyOQ3S17IfVhdR7JgD9mW/K+h9C6lKRyyQdyP4Z
 8mSYYxUlsXcals3HZpYOFwQFoCbhP1o0uQ6vhwKPIqEH8=



=E5=9C=A8 2024/5/14 02:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Fix typo in the end IO compression callbacks, from "comprssed" to
> "compression".
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

All my bad.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/compression.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 6441e47d8a5e..7b4843df0752 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -261,7 +261,7 @@ void btrfs_free_compr_folio(struct folio *folio)
>   	folio_put(folio);
>   }
>
> -static void end_bbio_comprssed_read(struct btrfs_bio *bbio)
> +static void end_bbio_compressed_read(struct btrfs_bio *bbio)
>   {
>   	struct compressed_bio *cb =3D to_compressed_bio(bbio);
>   	blk_status_t status =3D bbio->bio.bi_status;
> @@ -334,7 +334,7 @@ static void btrfs_finish_compressed_write_work(struc=
t work_struct *work)
>    * This also calls the writeback end hooks for the file pages so that =
metadata
>    * and checksums can be updated in the file.
>    */
> -static void end_bbio_comprssed_write(struct btrfs_bio *bbio)
> +static void end_bbio_compressed_write(struct btrfs_bio *bbio)
>   {
>   	struct compressed_bio *cb =3D to_compressed_bio(bbio);
>   	struct btrfs_fs_info *fs_info =3D bbio->inode->root->fs_info;
> @@ -383,7 +383,7 @@ void btrfs_submit_compressed_write(struct btrfs_orde=
red_extent *ordered,
>
>   	cb =3D alloc_compressed_bio(inode, ordered->file_offset,
>   				  REQ_OP_WRITE | write_flags,
> -				  end_bbio_comprssed_write);
> +				  end_bbio_compressed_write);
>   	cb->start =3D ordered->file_offset;
>   	cb->len =3D ordered->num_bytes;
>   	cb->compressed_folios =3D compressed_folios;
> @@ -588,7 +588,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *=
bbio)
>   	compressed_len =3D em->block_len;
>
>   	cb =3D alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
> -				  end_bbio_comprssed_read);
> +				  end_bbio_compressed_read);
>
>   	cb->start =3D em->orig_start;
>   	em_len =3D em->len;

