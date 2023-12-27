Return-Path: <linux-btrfs+bounces-1143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C555681ED52
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 09:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D02283C3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Dec 2023 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28163C9;
	Wed, 27 Dec 2023 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MDni73pk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639746134;
	Wed, 27 Dec 2023 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703665628; x=1704270428; i=quwenruo.btrfs@gmx.com;
	bh=Z6hPMVJWLU4tAds3xMv+UZDId2TfWYBnwlRPIyjItZU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MDni73pkCtkTeck//XOO0RVzDEQj/5VkSBN8uYAp8FwfH4zLIZKIjE6IIDAqbD03
	 CWiMAoy7ATBM1OBDtT40fG2a1MjV0jRfOwQnW8sMNun6HuGdqhSYT5HG8dtnKJp+p
	 PlU88X4hhDqJ+sF5ZKl6JvegRzuj7yh6rUaD5rVQtXCRzSccxQIFuDKoVM53xGw1P
	 1kW+dFXLUQfSaNXZnqQYiuKvkvJknSgIsKoTPBrgkQSyC0iyFiYBztDwQLkjUQUlk
	 oFE0vxhlPdiAfvmbS5EO8UnEeA2YS/tBUDTNHM2+jRiT4LHbdT3xUrN5aN1EzfI+M
	 oeJQFlDsp3iT4Rv0Jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([118.211.64.174]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQEn-1qwYRA16uN-00oXFd; Wed, 27
 Dec 2023 09:27:08 +0100
Message-ID: <7d2bb5eb-a9cf-4884-aa75-ba9d6af9767f@gmx.com>
Date: Wed, 27 Dec 2023 18:56:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: migrate to the newer memparse_safe() helper
To: David Disseldorp <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, christophe.jaillet@wanadoo.fr,
 andriy.shevchenko@linux.intel.com, David.Laight@ACULAB.COM
References: <cover.1703324146.git.wqu@suse.com>
 <6dfa53ded887caa2269c1beeaedcff086342339a.1703324146.git.wqu@suse.com>
 <20231227172709.4402bc6c@echidna>
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
In-Reply-To: <20231227172709.4402bc6c@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QmZ09sZOAFaMcq5ZBhFXM4w5p80VSoRhTJqJ5DBqlckNgJ8eGlR
 n4+ZzIa3gZ8tNAZAcQ4nao9nY+4AVsy3EkuGWiktLwiDyHJeuF0gYqf8mIH1L+Q+DfcrogK
 3P0RHBB8UEkylFBhuX3Uun6fO1WP1tG6LEPC3Be3Yz/SoMOeL+pDBWmlrTRGoCdn5ffQSVr
 m2YlqKEhP2JxF1ySi16uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MZERzLhhOQo=;CIRSspjnIJHDL757gvXdbqkB/BJ
 IWqsdjGl1Le+9D6dqhDxu0DrN+GpZ/ie9S3pw5qmz7sEZnTTuMzkJmdPt1VFJsewKDBtv01rp
 6b3gB85FlDxTFfiaQBjynCQnMw1vh1DNhuk2NAD8/z5i6ANVOGGtF6ybGIv7gRICRtXCa5ATT
 m9+MNM6QTx6ycj6VsjwgJrIwAbRSqTQdt+V/6N/NwOwR/kv9HJ+KL28x7t5c6fYqO9QDp4SHk
 hm7kpSZ+azbYk1txOLTSMcjVctpg++FeekdKLyum4T3bvd0oPBGUfmw1hOhSfz09FRBdKLA6S
 vUBR9rhswy7qG7WJsfJIAedYsphHP/paictmZGpjB32nd31OyVvg+ZbVHLAvErN9ZKb/54t6S
 OE2NK1VvWw9w/9t7/J2/W8gydfky8b6nwj7wtApxBRPUWV/t1lME4BK3o1F1VHtUP5MudfU1w
 QbskJoypb6RvY4Gq4LW2MNouIe/fJim0pnfkrefgqBEHfKhtmw5Dtt4iCoCjLFa/YQHqTxBhv
 EmoTdpFf5BXgcRjKN/mWO7jKb2BPZYt+2HMWCjsiN/KvGNM8WfAiZoPnJ26y5p2SF/jia0zgT
 Obapdr1r++mo+6CULYwhZjxSfwDzwpT2dw2KxeODp23ni07bDJVSkNHB/QZbnF9j7fWBpKl/x
 2qqx2/7cAjP7T6zpwncl8Eyap7RK2+K+mFEFXzPQkwftNbPYXQFktcko5+EDWo471wnmN6ZxD
 Zz/HgBgLfffxb1cU/R4nzwVS7HHRhlYvz3XqiOeQRUSqAPmUI+KqjNzI/s0uzgBWOXJ4jIvgS
 aUAhipzJShBMza3xGNvVIfnt1+8b4mCLksXvQk7s2MmrWQ5fYsURDSLdGghEabNn3vWQ8Gu2o
 AR4nBBPbmEzVEDAh1lHXxtmsmuh/5B24BhSNADBJy1Iv5Ul3fOfWyRN6icrl2/FmSsVJESgtc
 E7XfEUpq2uMJaa2tazJyVaOhvqM=



On 2023/12/27 16:57, David Disseldorp wrote:
> On Sat, 23 Dec 2023 20:28:07 +1030, Qu Wenruo wrote:
>
>> The new helper has better error report and correct overflow detection,
>> furthermore the old @retptr behavior is also kept, thus there should be
>> no behavior change.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c |  8 ++++++--
>>   fs/btrfs/super.c |  8 ++++++++
>>   fs/btrfs/sysfs.c | 14 +++++++++++---
>>   3 files changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 4e50b62db2a8..8bfd4b4ccf02 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1175,8 +1175,12 @@ static noinline int btrfs_ioctl_resize(struct fi=
le *file,
>>   			mod =3D 1;
>>   			sizestr++;
>>   		}
>> -		new_size =3D memparse(sizestr, &retptr);
>> -		if (*retptr !=3D '\0' || new_size =3D=3D 0) {
>> +
>> +		ret =3D memparse_safe(sizestr, MEMPARSE_SUFFIXES_DEFAULT,
>> +				    &new_size, &retptr);
>> +		if (ret < 0)
>> +			goto out_finish;
>> +		if (*retptr !=3D '\0') {
>
> Was dropping the -EINVAL return for new_size=3D0 intentional?

Oh, that's unintentional. Although we would reject the invalid string, a
dedicated "0" can still be parsed.
In that case we should still return -EINVAL.

I just got it confused with the old behavior for invalid string (where 0
is returned and @retptr is not advanced).
>
>>   			ret =3D -EINVAL;
>>   			goto out_finish;
>>   		}
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 3a677b808f0f..2bb6ea525e89 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -400,6 +400,14 @@ static int btrfs_parse_param(struct fs_context *fc=
, struct fs_parameter *param)
>>   		ctx->thread_pool_size =3D result.uint_32;
>>   		break;
>>   	case Opt_max_inline:
>> +		int ret;
>> +
>> +		ret =3D memparse_safe(param->string, MEMPARSE_SUFFIXES_DEFAULT,
>> +				    &ctx->max_inline, NULL);
>> +		if (ret < 0) {
>> +			btrfs_err(NULL, "invalid string \"%s\"", param->string);
>> +			return ret;
>> +		}
>>   		ctx->max_inline =3D memparse(param->string, NULL);
>
> Looks like you overlooked removal of the old memparse() call above.

My bad, I forgot to remove the old line.

Furthermore, the declaration of "ret" inside case block is not allowed,
I'll fix it anyway.

Thanks,
Qu
>
> Cheers, David
>

