Return-Path: <linux-btrfs+bounces-7330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF1957BE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 05:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639D11F237B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 03:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C349634;
	Tue, 20 Aug 2024 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="X/GDTaFQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2D481CE
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124335; cv=none; b=ubSiN0jH5bS5qFjpodZNyuONfzM/oiZr0uotLzYBw4cbI/VOiURGj2Y0zLAhx2VP1/zy16aNH/68KrpkZuXgsJ4YimNTpURgW7u7us074BS+wSp6t1xEcovTaBbKCKtkWHuRynF2+gDbSpv3qpeAhLna1E0Pl73MpMe4TLuB2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124335; c=relaxed/simple;
	bh=9ay9u76wmIJLLzpo3wttTFWS9C+9PeHHHIgznoPATFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRyvUN1mm1EMu5umjsfZo1IT5gFFye0RQOn5l2bGfb6NwvtE/+6CuOxLh5Hr6Z3bL6iBhlj8X/m6qGyG+O/PtzAIZIq4meQOZlq/3bVb0BdJ28+fmLU54AOIH81G7X/WoD8UoG8EUxOHozkBxWDOOv/tGIlQJDF8hOdfdgINU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=X/GDTaFQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724124328; x=1724729128; i=quwenruo.btrfs@gmx.com;
	bh=zmugbesm5vs8OGQb59p3lpVe4cu/b9nboI7qJpq5kbA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X/GDTaFQGJodd+VysDxE5CQA6g/EpdAlsHeaeghwOhlDTyOZriBG9jxbjXiXCuQg
	 Ll1cWA0JILF0H7M7M3Bz0jEbLMSq8ohD3ikidztBlgU/FoNOSNqVdRpOYguZRQDk8
	 KS4F+rf9Ot4erB1p96MSOdi5n8U4MSDe5AM5/MoazyjzmWvS97TYY/jMPNwbHtsVb
	 ZI/WS2xuBjrWTc7AVgMZKc6z0xTrZx0l9XphBVLFrjBQmSZGLxxKSWo7eKAB9BqmC
	 3Vggsi0rxGIFNPpq+bJKq3qpsy8napGmZfA8tIdM+V3uA86RYR269NqA7mOeZO6SS
	 xEoRLren57h3vto9OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sDg-1slDa12Nz0-008T2U; Tue, 20
 Aug 2024 05:25:28 +0200
Message-ID: <da517ae2-3cf5-4706-ae85-91135cd9f947@gmx.com>
Date: Tue, 20 Aug 2024 12:55:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: merge btrfs_orig_bbio_end_io() into
 btrfs_bio_end_io()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <2107a0e72fa6eac67583deb421ac1247b02b7723.1724057484.git.wqu@suse.com>
 <20240819143421.GK25962@twin.jikos.cz>
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
In-Reply-To: <20240819143421.GK25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7IeyID9vreVCVRzjlombZDuD1xWeyREnMU4MZ/opp+s0K7wSyjK
 Gl1UY0WBoAtGzqOOF+8mh4wYsttUYLGfbfFGtuxWYQCjnu0e5G63eW6pFVVDirF+4LXSJnX
 GMp+chMA5+Km+McgZXWAJKZEtaIkpdaeqvxIEgQLKxpTknGBAhnA0pEUFwUcsF3V+2ffBj5
 plENsvnhbDHzDVKVNGERg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5utXMz2IhfQ=;/lKj9M2cQIbRjZ5bPT2nckp7Jup
 nHVwNWlLgEV9ucK69Yx/VPzCB3gmMvmmRUjmbEXz2lfmPv/gEtpCS4+nDjSlEygY320hs6qWf
 DC5IPqnd8n5v5ybrCTcl1SOK1KPueZGKsgYUAUmdvNaJYSp2vzNbRJhb9gzmnxaEE2ZAmEP+O
 QMw4z6evAuikm/NpmmRm+PjiurUeQZD1PzxpHxYIHvH3XvTo2/fPa3S1S9IGmR8S4QGGiE17n
 572L/hSSbU0Q/ixisCtAVzgX7ZU/F1C96lCxor4QW9sblH6pAYhdjkxmKDwEbB47fLjPVn8Y3
 zN2SKWc3WRnzhNECE6FV9BFfoR5sQF7fMIAlgwyrtAZ1Ne27mnHjCg5rEYQHj1k+g+5DWgihO
 rytOy3OGBb3gGWmWT7klcAKIJqCQEhc8K4db3RMqiW/+idlSXjfoawr9M0u/qiuV6rEfp7KM6
 mNr91QpOKdySlDC5dErjQwARnbFEqhlsstTjwZAIbtX95p0P4DX174iIvDYy200ciRK1MCVc2
 iTSOPXtr5tzxDNtHADx0tEpb4ZXVWcoFlKwHhuxxveyOPgk/W4gkCr7J40QI0+haOWm8vBToQ
 b+f/iaWPK28ktvTCCoQm3hUdlDcqNkLHuxaUSDlFAWBqNwDaKeYw21CWIWOsz9Ayeyqc7wSH1
 YbcXreCOXXWZJW5OVnY2ztqV61FZS2s28gnWjzuJ0rjKRk66BEyxOnKnW8edgsoZEmX5fDV33
 lllKEaNrYLb0Jrt5oosEeIydic2186uF9oG4GAVbwFQ57YTjTyTvAAX4qy7IG/PnOvL9N/191
 hU/P20nQ0fD+U6CZ49pDUTlQ==



=E5=9C=A8 2024/8/20 00:04, David Sterba =E5=86=99=E9=81=93:
> On Mon, Aug 19, 2024 at 06:21:59PM +0930, Qu Wenruo wrote:
>> There is only two differences between the two functions:
>>
>> - btrfs_orig_bbio_end_io() do extra error propagation
>>    This is mostly to allow tolerance for write errors.
>>
>> - btrfs_orig_bbio_end_io() do extra pending_ios check
>>    This check can handle both the original bio, or the cloned one.
>>    (All accounting happens in the original one).
>>
>> This makes btrfs_orig_bbio_end_io() a much safer call.
>> In fact we already had a double freeing error due to usage of
>> btrfs_bio_end_io() in the error path of btrfs_submit_chunk().
>>
>> This patch will move the whole content of btrfs_orig_bbio_end_io() into
>
> "Move the ..."
>
>> btrfs_bio_end_io().
>>
>> For normal paths this brings no change, because they are already callin=
g
>> btrfs_orig_bbio_end_io() in the first place.
>>
>> For error paths (not only inside bio.c but also external callers), this
>> change will introduce extra checks, especially for external callers, as
>> they will error out without submitting the btrfs bio.
>>
>> But considering it's already in the error path, such slower but much
>> safer checks are still an overall win.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>
>
> Please fix the grammar in the changelog when you commit the patch.

Sure, although this depends on the use-after-free bug inside
btrfs_submit_chunk().

I'll commit when that fix got merged first.

Thanks,
Qu
>
>> ---
>>   fs/btrfs/bio.c | 26 ++++++++++----------------
>>   1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 088ceaca6ab0..0e4de33515fe 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -120,12 +120,6 @@ static void __btrfs_bio_end_io(struct btrfs_bio *b=
bio)
>>   	}
>>   }
>>
>> -void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>> -{
>> -	bbio->bio.bi_status =3D status;
>> -	__btrfs_bio_end_io(bbio);
>
> This leaves one last call to __btrfs_bio_end_io() so it can be moved to
> it's caller btrfs_orig_bbio_end_io().
>

