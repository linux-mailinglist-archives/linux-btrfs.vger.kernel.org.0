Return-Path: <linux-btrfs+bounces-2304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C189085062D
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 20:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F781C2391A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAFF5F85C;
	Sat, 10 Feb 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="E92LXmRD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A158210EE;
	Sat, 10 Feb 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595120; cv=none; b=cGZqslIWXLUwX1J7cLcVXrv0YOSZ6Z/iGV6dmaLMHt+YZ3qlnev5Vhl16vLuJ4p8U23I7oBwpYdK4HTI76xFkJHXszVQ8v653Tf8PFOA299obE/cLgkbEFA+O0xgNZsazvSEQqU097Mte4iCidKlBcFSAE8AiMYNpZntUlhGKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595120; c=relaxed/simple;
	bh=koYHB+LfHTOCdNbuZstaplHn5QB7RJEolk3kSeeN77I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3fGTe7UdgywsEWBY/Vc9wqRxX5S2IO2n2ouAqw7gbCsn2lVNkC1GpgUYM7S+fKMLr4fvBdnnuWfbpWOuFneljltYGZOnniUhrHUyGFvFO/tF0U0UaXBsjHbLzH3jnFJMNoVt05oAbGSJNikZw34eiiouK3KYKT83789UcTRrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=E92LXmRD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707595115; x=1708199915; i=quwenruo.btrfs@gmx.com;
	bh=koYHB+LfHTOCdNbuZstaplHn5QB7RJEolk3kSeeN77I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=E92LXmRDzBAb23Wn2gh1qXYndO5R9F6WM1aX03qRf4/Ic3ge8ksb2EOm0FyuBP09
	 +auUPakqu/BklKsm4o7J8S0ZWiPJBejZL7cdbdiRXEOYfmHzWqdD+MPhNR5evqNZB
	 FpMv5yUppIDK5UiU/r9mm8Y6AseURrjbxoCO1kLGObkXOiKG98f8nBFUwbstg53KP
	 tiZZsHFCUgWagKpNZ8ppKUdLkLVzH3tA2oApgMX/krb430S3h7V76A/1yUpRDVsai
	 sugue//w2fk1LbgO/xmL3ZmOP9Mz7tPdZ796/9kMfv61lC+VAE1ATu08XTEODED5K
	 GpsNr+/i9XYGbN6FEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOiHl-1rLtBd3Q8V-00QEXM; Sat, 10
 Feb 2024 20:58:35 +0100
Message-ID: <4fc1b0c6-f84d-43c7-b396-695658c7fcb4@gmx.com>
Date: Sun, 11 Feb 2024 06:28:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
To: Celeste Liu <coelacanthushex@gmail.com>, wqu@suse.com
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
 <20240210143411.393544-1-CoelacanthusHex@gmail.com>
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
In-Reply-To: <20240210143411.393544-1-CoelacanthusHex@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CB4SVBGZJm6sZaK0u0eU5KrljpRP9MVbZfsUVfS9K9wh0/u1LaT
 1OVu+LV38CJnFMMuLY+nHrotk9OkDnGdncgLWB8z3Zd2M9H482jfcijqc8CftOsQBzQfsEO
 6X0obHq2w2srT/0nxz6Y2Nt1zM0THDat2jKXoDRSvw/QPdk5d7q4+6+0ZumH6xrpMaQoDSt
 3CTBI/kMKA9qRMrN5G83g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uYfxRMO7EmE=;jFQ9T/JUZXFLKFxffm44wGDBnNa
 RQvKEkNaTE4Fo1sMOvzd5wZ3j5D5toc2HQ2sOi7e3YSgDM1TdkmVVJ2mh11Bz9KZnPPy1kQnb
 XaYcLA/BtUHpPA2ZTMjQ/zsZ4E5zddtl4ODFjWYzvcTIa0IV9AlY7E3tYyaC/fAGox8qQr9f4
 0CPWg0LOJhGdaIMApSJo15llD7V3Phl8KpCy/niw9ZurkQ3gD6UJRksTiW2hp6TbiSReu4/E7
 0SgGvUXUhzML3eCHKQD5rLu66BzGJZkgVWR4nBq+gi1fQBUOAxaoi/wbYwI77ghwzk6xK5KPI
 7XlWpmU38VxUTmistY+t4/qduxjpBFIZlBQI5AMaSt0gTIfFrOsu/gWgFsBbvIJi1PMO1LbZe
 PNRFMqVWricqw6iin2YfFEY7zZwrNgh/KOjJvWJ2j+fl2l1dtIjM3F7EFBZB56meARBNa5ugi
 fBqcLQljtLe2N2WPHbsCYZZG+PzP2FaItXYfeZ8hDRyQEoTrbTWKPe1PRnZx7hDYiaqWZgX0w
 13bpR2rhwKxEjtHcplRU6YBVTjjHbux5o5sXgpTGLu6csGNnTHDmwnC7MdoD+yA8d6vct8n6Q
 qlFb9eeJghJ+SQV+74eoyN5jO+rC5EfjLv9C6+8SmScBjvaVVIIROhEahSfp8/xXaaHtzvNM4
 YN6H9ghoEZbyxXiR/HZtmxDa58ES9AMwXjXRskb+SrrErlNUgoRLkbh6gF6k1lveKPnZ262Mh
 2zNtoxOkKfAByIPD5PZjSWH48XHFtCWTDyKQc2Dlfh69SSkMgdWuB1hqyaKn3hdR05O53CvG3
 7jZzxZVZ1CBMaRGG795CrLEXsdGkS5TqpOtK08+HUcgm8=



On 2024/2/11 01:04, Celeste Liu wrote:
> On 3/2/23 09:54, Qu Wenruo wrote:
>> [BUG]
>> During my scrub rework, I did a stupid thing like this:
>>
>>           bio->bi_iter.bi_sector =3D stripe->logical;
>>           btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
>>
>> Above bi_sector assignment is using logical address directly, which
>> lacks ">> SECTOR_SHIFT".
>>
>> This results a read on a range which has no chunk mapping.
>>
>> This results the following crash:
>>
>>    BTRFS critical (device dm-1): unable to find logical 11274289152 len=
gth 65536
>>    assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>>    ------------[ cut here ]------------
>>
>> Sure this is all my fault, but this shows a possible problem in real
>> world, that some bitflip in file extents/tree block can point to
>> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
>> is not configured, cause invalid pointer.
>>
>> [PROBLEMS]
>> In above call chain, we just don't handle the possible error from
>> btrfs_get_chunk_map() inside __btrfs_map_block().
>>
>> [FIX]
>> The fix is pretty straightforward, just replace the ASSERT() with prope=
r
>> error handling.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Rebased to latest misc-next
>>     The error path in bio.c is already fixed, thus only need to replace
>>     the ASSERT() in __btrfs_map_block().
>> ---
>>    fs/btrfs/volumes.c | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 4d479ac233a4..93bc45001e68 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_in=
fo, enum btrfs_map_op op,
>>    		return -EINVAL;
>>
>>    	em =3D btrfs_get_chunk_map(fs_info, logical, *length);
>> -	ASSERT(!IS_ERR(em));
>> +	if (IS_ERR(em))
>> +		return PTR_ERR(em);
>>
>>    	map =3D em->map_lookup;
>>    	data_stripes =3D nr_data_stripes(map);
>
> This bug affects 6.1.y LTS branch but no backport commit of this fix in
> 6.1.y branch. Please include it. Thanks.
>
Just want to make sure, are you hitting the ASSERT()?

If so, please provide the calltrace and btrfs-check output to pin down
the cause.
Just backporting the patch is only to make it a little more graceful,
but won't solve the root problem.

Thanks,
Qu

