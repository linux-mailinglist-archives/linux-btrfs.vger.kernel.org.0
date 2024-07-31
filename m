Return-Path: <linux-btrfs+bounces-6935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84F94395A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 01:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3A2284D69
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 23:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4016D9D9;
	Wed, 31 Jul 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XBNLDVRw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0116C695
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468387; cv=none; b=uyf32dIgDg3b4GQOhoQatzsnYZwGCAZwIq29sh6BNzwHndV7xg3X8pxBzMwEjqyr1uChJr4wNH7W2cvlBC98bHYjeFw4YnjgUADQo+4wCrS+1JNk5G9BjT0rUGVDVoNpLFwZR6REFGgMuT2wh60nD01aeFnAUR5nHXI7JlhH2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468387; c=relaxed/simple;
	bh=xa743HMtiBCBcthIcQKf2TapVI8UbfMyMxAkJzgg7q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mth0Koum/7BDrmg/A4EnRhY+7iemQuJHtmQQtG31QMOvkq4Fm3Beifp3h+LJOtv4QKDVuLnwb9ZBj+UX69JBLG65Y3W4SNaoIFS+C0AfrTjv0InTCemAn046sxwgMcNeSe8pEvmGKt2GUfYCPA4i9UW7iuhKaPCW+urrCIYhpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XBNLDVRw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722468347; x=1723073147; i=quwenruo.btrfs@gmx.com;
	bh=kpDq/jZ3HdiqNTIYRWYZibXknJVRHLCveDx9zuKGqzQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XBNLDVRwadUC9vpdJ4naJH3Yk5EtpXGmtowxB4VZojUrOURokTCVLJeHgXJO9i9m
	 8mRYB1TlIvkVjOaTu1AbUG1BuI+7/jdK5TQC7z0aAyeWC4hRBIN2S7m1ousl6Ll49
	 b46ySz5+LFsmXBCuhTYpKuZTKN/Cqbh9laQ0hDQwHrFeCPU/5T90on46ldQBSrgmV
	 65fU49duW2GfYrvyTCWLDt2tXsb9MlAn+rFjM67VnCYIruzX3yrgGSDhri48TlSQh
	 HH+rdPPau+vGVzYBG6qkewAGm+OpQUrdkJuQfKc9H/9ZXLhc2NsaKCmhA71shtytf
	 nVSNhVauJNK9jheGYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRMs-1sgyBD021c-00IZM0; Thu, 01
 Aug 2024 01:25:47 +0200
Message-ID: <b59af3c2-63f4-419c-ab3b-3832b9cfde16@gmx.com>
Date: Thu, 1 Aug 2024 08:55:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: locking comment for cow_file_range_inline
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <38338e851f80eb505894092dcd898de19ce720bd.1722459563.git.boris@bur.io>
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
In-Reply-To: <38338e851f80eb505894092dcd898de19ce720bd.1722459563.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yskTGPpA2qv+cPe1p/yyhAHs133ATQjloJerXj2ZA2BPvWapRgp
 ghk6lm6rL/4+Ei5AxeTWeyr1wK6mKD8wFibj6GUHAT30hP/+bgCwyjMwWpHR0huz3n9AZZl
 AMUULD+X1j6UkYlEvuvRlz1K4ZyvNvXT5dgzoUxtFRPOTaZV9jktUzURXo+78+kL146DARX
 JaBcFWzaQj9/jUcECfKmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kxr/QFRIJHU=;v0eH3PTYMJ85NRvCS6tvib88yp0
 51qJn69lIUj5g6sAHXfVbkxLbvA5KCmmVidl2gMC+k6t7o6aUHH+zAA+4VP/LRz0uqYprNI0J
 9iZTyJn3Y5130+5Pv1ieHd4MovCHT7wK2Di9zOIVvLoofCrrCNi/WyUCLX7Dlq10U0l3Bsiyn
 Yl12LpWa/ujFTfgAUURXxg/r3KZCaL2RLxlS/E0wwYQ3mjPLuyO9As34+0fwDxGm4rF4ppdTY
 yVQ6nKfuvSoKoxDN1dFAP/AWAX2cX3Df8Z0nC53lZ+YQB+2ElucI137xazb/PvjqLKFPj9zS8
 I+lcDaDdJ3JottxUrnoY3wbNHTzEI12LbuNrz+OzTB+Pi5V+R3oVJyl9cEr9pT3PD3RfQLe+4
 g7I2MKSqJ/k+cXvZp2kyyofQKjMyq0QT2gqUqdM+0xuHI4H87gWQN2uKL+QDkQolfEBJnMTuc
 IfLeuK9uspqZIIO4qZ6S2epf3PPVJKi+FrTWm7hQoWIWVp7s6yWjuUyy5B/IsmtuB32H04FVN
 nMGvhHCXkTvTC8tZaFDOkMNdk/NqpZ1DH6DlD/B/1iaWmNDoSlg0cKvuM7Xrdv6dybyAlva07
 d3D9Cf9PkWuNwFbfN0yxFc6JEFLj4BEQ3qmoytwmpA0GCH6e94He0U/BLxOSMAuOqHnDlbfDm
 MbWCr2zIi63RZp/7bmgD6nKmMcuh32KO0dx89pMSq1LgWZ4hGcgBMzW7JMeqdQlATZ4DVvwFl
 Cu4UdnqAIHSOohKAGUuVeK86wBI5dW/CwUneUMaqDh8v8wiFHkeKYjsp/vqUWNZ+XeWbhmNiR
 jGBNXIzZdtlq47s/U9FHj6Yg==



=E5=9C=A8 2024/8/1 06:29, Boris Burkov =E5=86=99=E9=81=93:
> Add a comment to document the complicated locked_page unlock logic in
> cow_file_range_inline. The specifically tricky part is that a caller
> just up the stack converts ret =3D=3D 0 to ret =3D=3D 1 and then another
> caller far up the callstack handles ret =3D=3D 1 as a success, AND retur=
ns
> without cleanup in that case, both of which "feel" unnatural and led to
> the original bug.
>
> Try to document that somewhat specific callstack logic here to explain
> the weird un-setting of locked_folio on success.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ed95040f4bb6..07858d63378f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -744,6 +744,20 @@ static noinline int cow_file_range_inline(struct bt=
rfs_inode *inode,
>   		return ret;
>   	}
>
> +	/*
> +	 * In the successful case (ret =3D=3D 0 here), cow_file_range will ret=
urn 1.
> +	 *
> +	 * Quite a bit further up the callstack in __extent_writepage, ret =3D=
=3D 1
> +	 * is treated as a short circuited success and does not unlock the fol=
io,
> +	 * so we must do it here.
> +	 *
> +	 * In the failure case, the locked_folio does get unlocked by
> +	 * btrfs_folio_end_all_writers, which asserts that it is still locked
> +	 * at that point, so we must *not* unlock it here.
> +	 *
> +	 * The other two callsites in compress_file_range do not have a
> +	 * locked_folio, so they are not relevant to this logic.
> +	 */
>   	if (ret =3D=3D 0)
>   		locked_folio =3D NULL;
>

