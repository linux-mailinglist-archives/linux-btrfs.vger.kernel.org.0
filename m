Return-Path: <linux-btrfs+bounces-2442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3379A85712B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 00:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50211F21B6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBD145324;
	Thu, 15 Feb 2024 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TXf7seIp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D591E4AE
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038441; cv=none; b=HFhcU18rgX3HsugE1Y3a5A+gghsX+cHoeWl+vTQztIGCOfF/3q0oT5S0I2/qRLHP2w/8RjiHnjgmOK60/kSdKH7hHAPTRJUiyTQOTB5yHvY7TmuomSTUYgvGAjRxwZ0dOmMKcC7EcpVKilGlQV2346sOYjQrWPzQcDPL/jiuwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038441; c=relaxed/simple;
	bh=KU/pYsDQGXyjiA4YgXpm8/mMTgcUfjO9YKrctEtLPxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnmaVgZtRfg8kZxV0Uw2HbCGD91ud0QGdkHhCmVBcZs/Wck+UtEFrLY3L4+tUGNHIC4E0NDwfEUp6ZhC5OiGUkllxGeEtJ+WL+q10Ebk2SQfr5Y3D5DBsWpSmmbslkHiwbDqkIjALWpoRiuTTr1h73X1V6Nd8CBFt1pXv00v4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TXf7seIp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708038425; x=1708643225; i=quwenruo.btrfs@gmx.com;
	bh=KU/pYsDQGXyjiA4YgXpm8/mMTgcUfjO9YKrctEtLPxU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TXf7seIp4zvSdsvmCICI2vez04MHl0TP0x0pSJ0lEvBc+UsPVav+DwnBKuJtOxja
	 oJo9yzGs666WbAMtGCEyBXG/gBam7h2gHzsDkGo7k2W7H2tvdgjFLhgNz/g56I4xy
	 ilcrSegJ+gsu/a4bkcGJbs5qQMnY0QNpdevzOC5LkZwCWRaNEBijb31Cbf23jUb3C
	 uQbrUrFALeQ0eFLFaJUbSN4nDIRNrj2yi4DHUWyvJSk8S7zbMEKqxdQQqfHlyyoq/
	 i/GAIodhYTJ9woPPIur9OvXwOzhch7w7KCNH0THSDgyz3gbzPAIr9qqf4Z5Qc2pTf
	 6l82cgG3Ll9xBPjsYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1rS3fk31xg-00QUI4; Fri, 16
 Feb 2024 00:07:05 +0100
Message-ID: <fedffe54-abfe-4ef7-a66e-a5a60bb59576@gmx.com>
Date: Fri, 16 Feb 2024 09:37:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] btrfs: defrag: prepare defrag for larger data
 folio size
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1706068026.git.wqu@suse.com>
 <5708df27430cdeaf472266b5c13dc8c4315f539c.1706068026.git.wqu@suse.com>
 <Zc5y0IRJdqjmstvp@casper.infradead.org>
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
In-Reply-To: <Zc5y0IRJdqjmstvp@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+JUMQyUBT8FpEpk0NHBCtt3NgYMDYwA7knzOS/ye+WiVaqYZvfJ
 QQ8XhR5HPcH+O9vynZdkJOfVG9CQ7Fzau3FMEatOSvDgqRrSIp5dx4IcEpogmwfWViG0MUy
 sEEv8aUae19AUFGeu0tU5riZ6MpAet/aKSXDWc/Zoy8AS89t9xjJlCwpO0Vv+Zp6f707jjl
 0JzFfGz8wJcAyyViFS9Jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NX40rvx/dYM=;H5t3gVz+H4G3SBkDUif5obEyI2Y
 vRCyPaDXWJeW31IlLU7zrfA8iOI/WVJhR33y6KXMdoLv3mpwdIMcxhgbrF87xqoaGh8xvTu2a
 98xrjJXCd8DIrAq6f4yUKVZnkUjvoa5rXa8nS6f/wOl21aX3QuVMS0gXeKbuhfeiypS2zEECa
 y8h1OpLxqb64+BNrvjhU9w95O4B5EAOBnrUOOaGevxiNU7Fe7M2aA1yRBFHlHlICS5RFz31LS
 Vhs8RXyyz4DR8aTO8bt/+IrapD/KrTp56E/18onYU/LECME4LHHu18uAV+90yLooLqTVMvm9J
 PY6RppwPGYPUa7HPC4aYJI8dZGa/W+FYXphBCVl0OjX93mUe4+BoHksv3W9Vj47n663CXyt3y
 C31KFYWXG0Nf18Py5v2MFHEp0lpCl2zP4ZhcRWtZI8BflLeR5oImN0vAqB+u5/7aBQwUMzYo7
 xrN98mLuUwXHI2iuFIbqKj8MPZae5M3M9mVtV31icF9TAutznZlnO8b98UED+UwZ23PUrprW1
 J42YItX9qXq5Qj3AYmUNzu4K4qsFvhSmVTckfxv4Z/SF4BWVnO2NSlUoCfoDVpIC5XC5h2mlP
 N4+6UEQT2qxOh3sRESD6btyzRg8vA+1q0pqmCJP0ge7PwICWmci09mbT8j2Scku4Zgk7e2Bwv
 ZrQg9EwkMV5HJF34tZXauUcdYfw8qxi9SB94YcV4phKlJNIyXOAMOdIG+RUcWYfqwh0KKav+5
 QdnquIaOXiy0fhgrIMieKcwb2+QZpDmyao+B/vmrsvIEjtMKQ3cAp4O4WVA1wOCqtXpt0/l+w
 naQmspYD5GrjaBSGoLNtXxxoucpmnVlhGw6r4z+MkMSHs=



=E5=9C=A8 2024/2/16 06:53, Matthew Wilcox =E5=86=99=E9=81=93:
> On Wed, Jan 24, 2024 at 02:29:08PM +1030, Qu Wenruo wrote:
>> Although we have migrated defrag to use the folio interface, we can
>> still further enhance it for the future larger data folio size.
>
> This patch is wrong.  Please drop it.
>
>>   {
>>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>   	struct extent_changeset *data_reserved =3D NULL;
>>   	const u64 start =3D target->start;
>>   	const u64 len =3D target->len;
>> -	unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
>> -	unsigned long start_index =3D start >> PAGE_SHIFT;
>> +	unsigned long last_index =3D (start + len - 1) >> fs_info->folio_shif=
t;
>> +	unsigned long start_index =3D start >> fs_info->folio_shift;
>
> indices are always in multiples of PAGE_SIZE.

So is the fs_info->folio_shift. It would always be >=3D PAGE_SHIFT.

That folio_shift is assigned inside the first patch:
(Although in the first patch, there is a bug that it should assign
folio_shift, not sectorsize_bits again)

+	fs_info->folio_size =3D PAGE_SIZE;
+	fs_info->folio_shift =3D PAGE_SHIFT;
+	if (sectorsize > PAGE_SIZE) {
+		/* For future multi-page sectorsize support */
+		fs_info->folio_size =3D sectorsize;
+		fs_info->folio_shift  =3D fs_info->sectorsize_bits;
+	} else {
+		fs_info->folio_size =3D PAGE_SIZE;
+		fs_info->folio_shift =3D PAGE_SHIFT;
+	}

>
>>   	unsigned long first_index =3D folios[0]->index;
>
> ... so if you've shifted a file position by some "folio_shift" and then
> subtracted it from folio->index, you have garbage.

For the future larger folio support, all folio would be in the size of
sectorsize.
Mind to explain why the folio->index would be garbage?

Thanks,
Qu

>
>

