Return-Path: <linux-btrfs+bounces-5349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09C8D2EBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711071C20CBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB53167D8B;
	Wed, 29 May 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lvJSR43P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD86D1A8
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968749; cv=none; b=fQbuNOOaojkn60eMDpfuq0QJBT6ayZjpBSg7hgk9Ud8ZHaSGhot2jeXTe81KKnyW+o6yRL9GRVppACusghX/mcgMxoUyU6fDtuB0cfM/k5Kn94t04H8QNpF8NIvAwQT0gxkSZskTnT1CY46wcXOt1txkWgirK9FDDyQKZFKo3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968749; c=relaxed/simple;
	bh=7NzpEX4F6lt6xVhLzcnOdRxSEf+YUCUp/4p1Xc3XAVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BIkoTQw7cnfeHYBpZk5AV0lCdIeV+BDXTlwjQTpNMQbsyeeY4yqRXkXY1tKwUIPnFViQmKrA9OGuhxaOLKrkFex1hSctTFce1/zDA3yqhodIODT4wnvL11Tm+kvunm8+6SRq3zCrdJ8ExbOJdGRMgn1hg3Eh6Qo29NVNfx93bJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lvJSR43P; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716968742; x=1717573542; i=quwenruo.btrfs@gmx.com;
	bh=+qHbpv2nwFWxAnI3GDWzf8+HA09Mj/CYGK7rrT4RR4k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lvJSR43PmLrb8uCaAbV2LAllkOF0mF3wY+CkbRDGxBwL3s4bXNtE/Iy0JFfMycpI
	 ZdaJiObqkrMPx6xRabKLQ//KAe3sbi0GQvHy8iUYFQCNQoULpwpm1Ta7bWuySIyMV
	 c/yX/15Y1t5S1XsMq6FGeNNFKd7d8Ke01PkzYZG7EXlMK0lRwI5Nj+uCcM5PoCJmT
	 IHaOx3kKBUJjXlUpxlDILh6uiAq+4SqWkS89r22Tk1z5aFzAIyPkmBjLxIOQwf5ih
	 9EfmAOOTa4xW9FWM2Y/MTNJ1/u20pVfXl77EpEOd4gg1JInVl3TBeTF77YcMKSzlM
	 t2K1pX57gfiyv+yM5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXhK-1rpaop3ZK6-00Mfdk; Wed, 29
 May 2024 09:45:42 +0200
Message-ID: <63ce80fe-879e-469a-8d93-49aeb8659191@gmx.com>
Date: Wed, 29 May 2024 17:15:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
 <20240529071325.940910-6-naohiro.aota@wdc.com>
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
In-Reply-To: <20240529071325.940910-6-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YvpSMyWeTEOeOFqV68NfBrr9LbjsDCh9wXBeN5uMXS0HkUDDd7n
 IjFU+gh4Ln/5kd1L0tnn+YHmGPa2sN51vod7Ky+umzWXs88ISQ42KCQZsunBQhgXLJmXIdr
 N6gZqyFLCU15VgegCJGGUfWaII/O2pzFwzBRrAmnB8utxWnLjVigftveHAhU+S6D4tMaa32
 9lojGu1szJza2a33mE0WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gy2DA9UP9UM=;OpWauj9zM8wPSGCk8Rb6rNn5V/B
 +21wDRj8ESGOkfPjKNcLr2gXaRiejhAVkM22xnK4Jx+a1Re8w+y/66tkAnxwxo0UUGLh7NFbf
 iSK2KRvmSrIRgcdEpgKA4ePQKgGMboL4VsUxuhsYw6Rtil3Z2G6FiqhIGT2e7PqlaFOKOvanc
 k02ewXIrScoqOXwbsivfNbJdGUbNEo0IZirOK6qhXyC90DkadVumIp1A8ia3P6HX2h59bWFsY
 w+gkPjNuL8coh5XicfeSeTfJvHzKBlwFEPWwkS4m5u1Zbu0S7Df2SCo0PMrbOaRsc8yBRr8qJ
 H3timt3EnOoHMJS5IzrDr45M8KKvUrgBHVN8hW/azgpV4xZmmtCFhs6Ibezd5h2i+ZvT14yBU
 +fJzfLK1b1giWpjHshU5X2gLSXArtcyG21jB9fqWiDavPv/Hjv6lAN6SekLEsszBU4azkH1Yl
 n4q1Yb4m6x7k17oTQweQ3TgDEH8KRdP0PhWz611uuy9Of9eWaEltqYKAuCAZg0Cwoa2LkQAu+
 zKwoB1JvBtX6swVdT9+RTtqXiFWkqRSEIgszmg0FGAtHYcOJv49RggFAtwHTy3zPPE5yPFBWW
 1Iu9CBlJEedjLnmgH5gFJB29SUPSWJwZ1n0/u6A0G9frZKsEBJsAswUFpjDYHPFsFCd0ANOZz
 jabFBVl3sNcGvzOpnqveIkyKowDw70YYF6caI3CnDaLPmArRrAJz6THKbdAbZ2fcMg1A2rFgv
 rpFW2q6pLHRGoztj03wUThMJevmWqYF4uHM+4vJ5sRIz4+R+bUHeYpYsElARxLpDHZFL/o7aB
 vKdhely9BQMDd1DZSvThYLkn507FB3NO5jMphn5pXdWLk=



=E5=9C=A8 2024/5/29 16:43, Naohiro Aota =E5=86=99=E9=81=93:
> While "byte_count" is eventually rounded down to sectorsize at make_btrf=
s()
> or btrfs_add_to_fs_id(), it would be better round it down first and do t=
he
> size checks not to confuse the things.
>
> Also, on a zoned device, creating a btrfs whose size is not aligned to t=
he
> zone boundary can be confusing. Round it down further to the zone bounda=
ry.
>
> The size calculation with a source directory is also tweaked to be align=
ed.
> device_get_partition_size_fd_stat() must be aligned down not to exceed t=
he
> device size. And, btrfs_mkfs_size_dir() should have return sectorsize al=
igned
> size. So, add an UASSERT for it.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

To David, since I have the write permission to btrfs-progs and reviewed
the series, can I push it to devel branch now?

Thanks,
Qu
> ---
>   mkfs/main.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index a437ecc40c7f..3446a5b1222f 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1591,6 +1591,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	min_dev_size =3D btrfs_min_dev_size(nodesize, mixed,
>   					  opt_zoned ? zone_size(file) : 0,
>   					  metadata_profile, data_profile);
> +	if (byte_count) {
> +		byte_count =3D round_down(byte_count, sectorsize);
> +		if (opt_zoned)
> +			byte_count =3D round_down(byte_count,  zone_size(file));
> +	}
> +
>   	/*
>   	 * Enlarge the destination file or create a new one, using the size
>   	 * calculated from source dir.
> @@ -1624,9 +1630,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		 * Or we will always use source_dir_size calculated for mkfs.
>   		 */
>   		if (!byte_count)
> -			byte_count =3D device_get_partition_size_fd_stat(fd, &statbuf);
> +			byte_count =3D round_down(device_get_partition_size_fd_stat(fd, &sta=
tbuf),
> +						sectorsize);
>   		source_dir_size =3D btrfs_mkfs_size_dir(source_dir, sectorsize,
>   				min_dev_size, metadata_profile, data_profile);
> +		UASSERT(IS_ALIGNED(source_dir_size, sectorsize));
>   		if (byte_count < source_dir_size) {
>   			if (S_ISREG(statbuf.st_mode)) {
>   				byte_count =3D source_dir_size;

