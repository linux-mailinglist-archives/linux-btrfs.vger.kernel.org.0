Return-Path: <linux-btrfs+bounces-3678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18F88EF47
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28711C34D68
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E514E2C1;
	Wed, 27 Mar 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kZmwkTSQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB78380
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568141; cv=none; b=XGCS43V2LXQiKJmhLKiEXeVBccTPjqqwCRPiwg4WXFY2SzqRyoDR9tjO4u3JKW3m4kleYJwyAS9HKtDKo7mC/Kuy6YGkp+MNd9yiALEq0Nf8I2ohS8eV/OW1Ofi1gxKeejtLW0RxTmdf4qCQ5lyPyMELuO6l300Clg/DamFHGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568141; c=relaxed/simple;
	bh=IT/1f2w6O5reHJ/+QmmDck2ptlMt+qsNK8nj5tdMbg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRUm0XEfuthr2E3Q7hCUu5OYBua2kgKCfvedsbmfbZxZi0ajs1zvuxCop3S4kKh9iO+LLvCn3vPheSnG7JMbMG4kxwUWbGcXmmhxGwabPBfGfgMZ3WmatRUAn6a6ApQeWh89Lq1MezP1TcE6l0+M5OhZu8MNP1Oney9Ms0svmgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kZmwkTSQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711568129; x=1712172929; i=quwenruo.btrfs@gmx.com;
	bh=O2A+eFslvr4Zfnu8asjjt3c2vNHOMwk2qABBAkexrV8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kZmwkTSQH6J6neMQjrvsFlnPSETQtUFOfi1YZNV+tI/gVNcq/I+xyF1LW0mDjsV5
	 ZBCTx79+0NAFsdcjNm56vQhXt2zdjYY4Rj82SxdBuAXsgo7ZJmG8eBZHN+aGIIeCW
	 vYiqjQiS7PKE0kEhu9+yv4tx+vqXwLnM9Mk1OxMeRWfA8DNG8jo/CbfpDXl1Axjg8
	 7C00fIwQTlNwgAHXXYXIDlAVPM4vv8AIYzFxSFaBbGq1H5ykbHuIFXv2BxI7txHvZ
	 YyZAWZMeY9EDVVuuPqyydKdDONj2bqJBZwhh3sWGq7jmk+e4/Z9yLhUon9vX5eLBR
	 /nTiPzEu61zVhdNkBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3siA-1spCCW2urw-00zoB0; Wed, 27
 Mar 2024 20:35:29 +0100
Message-ID: <700d7bf5-2ffa-4ff6-9ca1-2497bb700d56@gmx.com>
Date: Thu, 28 Mar 2024 06:05:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] btrfs: correctly model root qgroup rsv in convert
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <71f49d2923b8bff3a06006abfcb298b10e7a0683.1711488980.git.boris@bur.io>
 <245057c8-e7fb-4ad0-9e88-d21ae31cf375@suse.com>
 <20240327172031.GA2470028@zen.localdomain>
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
In-Reply-To: <20240327172031.GA2470028@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9SybuEdRYX/Vrgw43QSGYfJtHKa/0CFL8UvwFOpw7DJCAu+NjNR
 I6+eJyCEoXRSN18XV14rgBGS/8dosNj2+SzytQe899ulX1alGUtQo/uDQpzvnYSbj+iKgkL
 rrP7cyyF1nNXWKykf7k9X1F+qEt0DAJshBbn3GVoi/4JEvy8otkNKLGAhWPrICkCwPOTpTi
 JWRGBIL+BbeenEtK9tEOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oKweKNiaEnk=;qBFyBVgW6XNuzsvDRTUsv5p41nj
 1ww57v9Eb/iAjYzfZIgAsr4HjE3WVpoLH0oGxR+MDN/rKN+V/U4PHmjA0+ySZZ4fFf46lOUny
 kA7SB8GexFB1gHF0u00thBzIB7HusrplNdC6aol2QkbEyXRcbk+FCs03fpZtprk/a3QvncT8y
 GpRGgg9lo5ySjbbBCGRRU+7jMIga8TwK6o8Ia+ihPkjWjWA4/3db7AhhykymgLRUKZ7C1Ux+a
 QTzHsIl9D8eUMB/SpWwayrFSHIXFRwpJRUYcBNvPD9XxNGsSO2g+hNbwM1IvxE9SfS+wpbeev
 9gRsZ1G3Yw1FtFUMJqsm0m56QPNFiS78ulmPL6B5RpWFBK/a1wpW5Ou1M6ofydyaX3I9Ucm3/
 P+F5rIMooOdd3oD39tgMlQ+MrDV8G1uijPvn/iY2ltJxaStRIL130iFDrMDELgl15mpSowV0C
 eF/NzyGSpDFBqlM7wlUnOvjla4A1MImdqur4HhIQ3CR3DUSVCnhqsHtksJvJGqLBRmuFBaOee
 9GVsIPwX9EhCn2S9e5SlreLWWBsDo1hh+CMc5V8gGuiYPovvoGckJjkW+RIO8+LtY3W9Lb45L
 KyQAKE+CUX8EVV7zZgsVXTFGgwwRJTb7LIEMY/yUfg3xUMQ9THzOSPgCm1rxYquQsqT37sLfI
 8EaApIo4nF2nV8hPlcKWuIw/VP43R79ZVESIS097EGpQ+ukRc/Zej+t6EAYaPs84bvhoyLYNZ
 Kswdz/f12Sk0LrslCvw7Op1YDSLdiHjxB2e89BiV+q4vb1Vh6ggCwk4QIRpaZFDgmh2uhYwn7
 CB3u2u4WuS0yxhna6Tk1/zkDDpjlc19y9WzJzhWHg9k2k=



=E5=9C=A8 2024/3/28 03:50, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Mar 27, 2024 at 08:30:47AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/3/27 08:09, Boris Burkov =E5=86=99=E9=81=93:
>>> We use add_root_meta_rsv and sub_root_meta_rsv to track prealloc and
>>> pertrans reservations for subvols when quotas are enabled. The convert
>>> function does not properly increment pertrans after decrementing
>>> prealloc, so the count is not accurate.
>>>
>>> Note: we check that the fs is not read-only to mirror the logic in
>>> qgroup_convert_meta, which checks that before adding to the pertrans r=
sv.
>>>
>>> Fixes: 8287475a2055 ("btrfs: qgroup: Use root::qgroup_meta_rsv_* to re=
cord qgroup meta reserved space")
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>    fs/btrfs/qgroup.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>>> index a8197e25192c..2cba6451d164 100644
>>> --- a/fs/btrfs/qgroup.c
>>> +++ b/fs/btrfs/qgroup.c
>>> @@ -4492,6 +4492,8 @@ void btrfs_qgroup_convert_reserved_meta(struct b=
trfs_root *root, int num_bytes)
>>>    				      BTRFS_QGROUP_RSV_META_PREALLOC);
>>>    	trace_qgroup_meta_convert(root, num_bytes);
>>>    	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
>>> +	if (!sb_rdonly(fs_info->sb))
>>> +		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
>>
>> Don't we already call qgroup_rsv_add() inside qgroup_convert_meta()?
>> This sounds like a double add here.
>
> qgroup_rsv_add doesn't call add_root_meta_rsv. AFAICT, this is the
> separate accounting in root->qgroup_meta_rsv_pertrans to fixup underflow
> errors as we free.

My bad, it's true that we have extra per-root accounting that's not the
same as qgroup rsv.


>
>>
>> And if you have any example to show the problem in a more detailed way,=
 it
>> would be great help.
>
> I don't have a reproducer for this, it was just something I noticed. I'm
> fine to drop this patch if you don't think it's worth the churn (and
> certainly if I'm just a dummy and didn't see where we already call it)

In that case, I think you're correct and the patch looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> In fact, this counter only exists to avoid underflow, but PERTRANS is
> cleared by exact amount, and not via btrfs_qgroup_free_meta_pertrans, so
> it might just be moot to track it at all in this way.
>
>>
>> Thanks,
>> Qu
>>>    }
>>>    /*
>

