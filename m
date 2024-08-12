Return-Path: <linux-btrfs+bounces-7110-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BCA94E61B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 07:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E766A1C208FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 05:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ECC14B940;
	Mon, 12 Aug 2024 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VXMezo+V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF04D8CE
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723439836; cv=none; b=LgkjKJASdG8i6AsVi5i9sg598U8Lah42A/5twcrytBpIjmbO+E1UtbD0Qfi1rLCI7ZGbKyEo/beim30bUly2qy6yOhMTFkbxlVXEYSdBJrqqDXpE2D7AS6+1UVja2ASEIF0/6+1qo6eEo/ObMFDPthjAVjehmeyX3XVGGo5WUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723439836; c=relaxed/simple;
	bh=IJ3kGiSsoqP5e1nXglLPHHuxXV6xYrUhxeB0/EFdR/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWH2zZIPmRcQ8MBGxWIirOJruNjz6DMPgyh63OlquKKW8tZbOImxMwIsl3wp37cx4lWxCKNdBsgLg/ENdc8Ket/I5dgYyc3y9+TW6uTqP3s8xHF5VUlAy63TgYbucY+T/s7tlZFJHFl/W+MCXp0SApECLoe5jNcZGtnPn8p4Kpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VXMezo+V; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723439828; x=1724044628; i=quwenruo.btrfs@gmx.com;
	bh=IJ3kGiSsoqP5e1nXglLPHHuxXV6xYrUhxeB0/EFdR/o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VXMezo+Vfkey8iDW4qNg+LByK3zFSEc1Yzro99ZmrcKg3bsAI49NIBaVcOZDBYp1
	 MbridY74a1hnVNrigLQSVkAm2szafYmlp7z+RD9oP0+NDuTxPJWBf2n8PQGdMhyyM
	 Yaeec8K/eErWVE9MxAwDfgMkFvHR3mbPsJz0ABV3Zz/bOESaZaLvhR/ZUMqUUGHgn
	 Xcjm1cfy4zhOgUAFIGH3ufVLyLHtV79HzLohB4BlFJOIenoSN9GZEoHMVrXJAw1DW
	 1uuNdAN+qtZ4w93fZASVKMkj2y6zk6Ol+3T2xuXjiUvsj8RNAl9nlt9JNnAwWuxR4
	 a4KR9BLMWcEv2qw6Qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1sjEyB021n-00Vnt5; Mon, 12
 Aug 2024 07:17:08 +0200
Message-ID: <9bedda40-76fc-427e-8cbc-dfa613dafa7e@gmx.com>
Date: Mon, 12 Aug 2024 14:47:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix invalid mapping xarray state
To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <cb40bca119cc0519bb5e17f6a9060a35a839ea28.1723189951.git.naohiro.aota@wdc.com>
 <20240809150844.GA25962@twin.jikos.cz>
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
In-Reply-To: <20240809150844.GA25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hV6ctlm0rFPw6JZ9ItFVynNsSHwaDI+tYdq7zfNucGHdrQxcu9O
 ykQ3DHFmCOL7a/nE/Zq48kZn7PYZ071+Bn0WKPeSmEsWCuCDF5RrAjZUiQw1KhpKZZ96pU5
 w7BBuq4YtlPBd4USNQ4X3G5JuIfhm1K8VzP6KeODhgaxBMX+jYiVcyyxQfNDvFFgHUl9Dn3
 UrJDcSIgafy2E8IxTzclA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J8Sn8CGj9cc=;RcLhzmqga2uxyF6WaYUOPxzwhge
 OKLsrj6CT4BfSHOHZexEv4uMokSCXHUsZRBzzsxOfRb5R3GcS9myH1rYdNlwH4NjzR62oewsD
 32NTscDcpYSPKfmJ/+F5P6a1Zpevf1l0B7d32f/ynj0ccpshIWRnADod+pdKX4CKZQlirW1k2
 g9xeNio6/z+XYt8gQnN/VDEK/M+fmiB9JysRAN63OmQUPYHDeOSKi3qYeJlifVJVzTCeqg8gC
 eAjCMlOPmlSqKKbl2Uk60i1PCV9thD/Zlt5qIjTljTf45UzaGGSiU99WdCMLukyhF4BLslZCn
 vGBljCaiFmLQjSJg6tPaVJAc8gogEmX9iKJpLGY77pYt3io6caJvc2uC7ME9H/2EkFOiOqyXp
 kITzSqZm4bqPFkTdDnaKAGrvL4EjKUaO8IGxijwK+7KQleIfLeZAiibJjdVWc8IIvwFewfSaX
 9iwCuh8Gi4fYeyYIL4Gx+Ge63ohdrE8BDmsZrpK9mxdbYx/sA/g2x6KWjcpFE6Dhd2sDZXGx0
 EpoB18WEPsEAywblRECjMRFefP5uKDppRjGjucqtGZF6FK2nb8NSmStnqI1wvlsPwcuvYqSa/
 mdKyqAGNpal5Aa+k6Unfdu+UtyaOBeaBSlTSEWW5kZ+zTJPULCdRGLA4oGlljrh/N1yxUDz0+
 ky4jRaE4Ju9wj2dU0+9F96go+Ik49U+ds+hQurpNCj2ZL62qQX4mosUrxiTepc0vQX18M5p8j
 tI28fi89/b58vNfN3Z8AqXWlrdpcbSkXdDgaGx+nB72v/zxuu4p0DJjoJG+06LCXpdtoAafLD
 YM5DSkZoO3gXRHJc8Lcw/kQvQsXOfC7bc9+DbAVptPrzQ=



=E5=9C=A8 2024/8/10 00:38, David Sterba =E5=86=99=E9=81=93:
> On Fri, Aug 09, 2024 at 04:54:22PM +0900, Naohiro Aota wrote:
>>
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Fixes: 97713b1a2ced ("btrfs: do not clear page dirty inside extent_writ=
e_locked_range()")
>
> This is fixing a regression in 6.11 but the patch does not apply to
> anything that could be used as a base branch (master, misc-6.11,
> for-next).
>

Are you using a wrong branch?

This patch can be applied without any conflict (although a typo, beging
-> being) on for-next (89af55f1ed3d4354a629f08b87dfcafa3aabb90e).

For upstream RCs, it's only conflicting with the recent change on the
folio usage, only a `page_folio(page)`->`folio` change.

Thanks,
Qu

