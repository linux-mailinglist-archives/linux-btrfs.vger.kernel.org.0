Return-Path: <linux-btrfs+bounces-4995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E88C5D8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 00:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95961F2231E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 22:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179F181D12;
	Tue, 14 May 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hcDkuliU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AB181BAC
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724942; cv=none; b=gkbwrrp+X4QHK7S2Gy7uKSGONK9fo/CywfPk5BsKllN1y/JNTkh9oHtSAgY5GFtHfZBOrph8X6WFjup2qC25ZU+330sZ6T52qBD4H6a3fSqwMevc+TA9QqIKyHx70up1QWgUTQsVhxX78051b8Y0zo9edXUL9acWoQKZILRpXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724942; c=relaxed/simple;
	bh=A2spy/b3bAB68b6V/I7PA/LSITWJz29RPrbuTB6ox00=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZOBJn4yBkPTG+dXYI5sVRbZ0bfB5VqUcVQDP9fqsCVUmhziNpc0A3lGbsAHZoUavdKUeYi3snSP1Nuvu9HBhJotFDRZTVvwA/1LfdyKc0ImpWL1vtUolUt4Ur1s16xfTa1y4kaniY/O8jFJSGxZh9PVgG4nSRDSyV5133T/+LfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hcDkuliU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715724934; x=1716329734; i=quwenruo.btrfs@gmx.com;
	bh=oteQ0t0siRf+unwjwK04ZptcGejMYutnTLELTHxHS1o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hcDkuliUEUSY6AfYd5/U0okunPyEsxg7Le5MUhDdgK4E7nqv2URfEQ9k12UPL99F
	 XAstMYsoxJJsoid9+/VclGcuXk+tYMePifjh1KqvV3QGTAjXKj6VgYZhzpdJOYqRS
	 MSovq+TrSYKR51VJoruNxRAkpDr+WNeQJpvr3yMyhLJQnRRkzOLDuQSaUQGnyrpbu
	 nt2TyiStTdC3tcrYAMP06WCEzX0YqELw+UUCS9E4KWyuZkZk2XlRfInLXSAvOwg1V
	 q7Vc09zZblaUb9z45w9fnH1skq61KUEvcA5ZyWduP2/3PD3z3hs9YfATpjwQotWl8
	 zYVnMq4kz77da0yvZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1sUkYO3oPR-00wiBy; Wed, 15
 May 2024 00:15:34 +0200
Message-ID: <67e9e462-b6d4-4c6d-b409-ae13ab9714a8@gmx.com>
Date: Wed, 15 May 2024 07:45:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: drop extent maps after failed COW dio write
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715688057.git.fdmanana@suse.com>
 <affef2b4ccd4d0f9a0272cd5883a5922d36bac31.1715688057.git.fdmanana@suse.com>
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
In-Reply-To: <affef2b4ccd4d0f9a0272cd5883a5922d36bac31.1715688057.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:llVTBaDrjCslgvrP9rS6JcybYzWJG1vURgM5dqcXNCK7spvcguC
 HFEYqczSDEuDBpxanf8YCUfTJft6zVJXlJjmSybEJVSalKKIUdgdkB7U9GOuMUK+H8wfRl4
 wGc0MCZeXAcX+UiUUKlZk5OBS0/g0dnR+vz4TKJs3zbUzq8/acHaSuKNVBLoEg+NT5MW/QZ
 4795syob84d0rUEwtrj7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:txSDqzOxO/s=;WHIABZwDQNM+4S2Fink3JNyetXH
 rJksj7PXByQFGoRTJei0azkkagtKysj0LX4JRM2KOch5gM0iW6KSCRUMdJYYkBWtKhJrWRRDu
 0YkU0VqvBHFCqppO6+3QuNU91DoUll/yU6nPpzxf7y77UPPNqrLHLRnLk9bxua2Q4BUSCf7iq
 sXQYWt9yNqDKJAwru+1+wgSiGcRmwFIXEh8hFgv5Ar7ZbT9D4DczZeX9cDrkdiwfy82Nr/qdo
 FYn/IOCUbM/yBESFRzgvGZc/sW8HVodP2zOIKZfnQwv7b/BQ0FOHbrTa+Y5mPrxp35rcR/bua
 vmZPYmuSfQECnfyGlC0KU1uTKho63E8GFAnsV9hz0QqRNh8TlZ3OcUsl6YuR0ofww1f0MR5wV
 d7n01cI/cnrncWP49qJYePJuDNZQc3yGHgsR0OY16EV9/4ql0YyzOy58js4xQ2RLtfJy8P4Fv
 1URBP7Z3Jago1iVEQGv9Q5+h71C0FbIzfe+Ad0x30gRj2rArl14Fz3ps1rDniUi3ARkgdcSfC
 0B8ci4i9EzGUWyEo5KT8cLpsq7l4Q2Qt6Vp5IG//R20V4+DMfj6M1vK6wzLcs9tSGLSGBBHZk
 6YWfWh7hoakO9j7+zIca2t2NvX3mXk4LSot8N2XnuXPkvqKkF4vYQmFGP9c+RWPpnkTJJpd2B
 WnQKmjG9NCZb1GYlUW2PH/3TJTXHCZ4aPXXDz4JJ219+0e/DvbnBt4b/fSMzdDjY+frGeBjDW
 lJiEJZD0CIxQgRLSjBdRZcSxLGoUiMSnZwgVpLjYoAvOmv0ZXKBgUwDhLATdyH9yUFKkVQ+6d
 uqHbK9FUoXa1OuiyDwOZrG7FvzSZdSO17ssTYpY1PtLJY=



=E5=9C=A8 2024/5/14 23:53, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> During a COW direct IO write if the call to btrfs_extract_ordered_extent=
()
> fails, we don't submit any bios, cleanup the ordered extent but we leave
> the extent maps we created for the write around.
>
> These extent maps point to locations on disk that were not written to,
> since we haven't submitted a bio for them, and they are new an in the li=
st
> of modified extents.
>
> This means that if we fsync the file after, we log file extent items bas=
ed
> on those extent maps, which are invalid since they point to unwritten
> locations. If a power failure happens after the fsync, on log replay we
> get a corrupted file range.
>
> Fix this by dropping the extent maps if btrfs_extract_ordered_extent()
> failed.
>
> Fixes: b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small question inlined below.
> ---
>   fs/btrfs/inode.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5a1014122088..f04852e44123 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7888,11 +7888,28 @@ static void btrfs_dio_submit_io(const struct iom=
ap_iter *iter, struct bio *bio,
>   	 * remaining pages is blocked on the outstanding ordered extent.
>   	 */
>   	if (iter->flags & IOMAP_WRITE) {
> +		struct btrfs_ordered_extent *oe =3D dio_data->ordered;
>   		int ret;
>
> -		ret =3D btrfs_extract_ordered_extent(bbio, dio_data->ordered);
> +		ret =3D btrfs_extract_ordered_extent(bbio, oe);
>   		if (ret) {
> -			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
> +			/*
> +			 * If this is a COW write it means we created new extent
> +			 * maps for the range and they point to an unwritten
> +			 * location since we got an error and we don't submit
> +			 * a bio. We must drop any extent maps within the range,
> +			 * otherwise a fast fsync would log them and after a
> +			 * crash and log replay we would have file extent items
> +			 * that point to unwritten locations (garbage).
> +			 */

Is regular read also being affected?

Since the em is already inserted, and we're doing DIO, there should be
no page cache for the whole dio range (as long as we didn't fallback to
buffered IO).

In that case, the problem is not only limited to fsync, but also any read.

Thanks,
Qu
> +			if (!test_bit(BTRFS_ORDERED_NOCOW, &oe->flags)) {
> +				const u64 start =3D oe->file_offset;
> +				const u64 end =3D start + oe->num_bytes - 1;
> +
> +				btrfs_drop_extent_map_range(bbio->inode, start, end, false);
> +			}
> +
> +			btrfs_finish_ordered_extent(oe, NULL,
>   						    file_offset, dip->bytes,
>   						    !ret);
>   			bio->bi_status =3D errno_to_blk_status(ret);

