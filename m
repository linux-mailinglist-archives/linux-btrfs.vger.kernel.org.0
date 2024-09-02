Return-Path: <linux-btrfs+bounces-7732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAB9685A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E091B25A3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C0D185923;
	Mon,  2 Sep 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fgLURefY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25743184540;
	Mon,  2 Sep 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274899; cv=none; b=tmbV3Q2IrRcv3xIyr8eptZ6rY3xSk7bssBL8QR+Ao3xYqNYp3YeuuVoGR7xC2TqhBLgX1MGs48Ta+lejDBVb4JbOcl3FQco7/mC1Isqg1LJSjlP5UBz4vZSBZjmHHnWN9V3VaNJOP7qxVEM2oWSFTPPqSTu+jN2wPeFSCzw2VwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274899; c=relaxed/simple;
	bh=mdc1bq8VAoAIhHR6jJHFkPKYThrMQVvwzoZgjGZBc2g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rK/wY4g/y9+tJgY+IiX5OtrnVhn194VZbgeUtrlIHARXX25BEGvQIulmUNnwJN7Nx7+yM9pTaapC4S5k1SaXi0fsglcACGUM9I3iaj7dBLxmWzmVxI/bK2bmD6qi/vSAFmHgR2dIJMyINpThEFDWVXEQpC1rlftVeY2DEWJGWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fgLURefY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725274887; x=1725879687; i=quwenruo.btrfs@gmx.com;
	bh=OL38hzk/dlnMeGpmvpI268xq9IO5PsIRMbsIrMeuoaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fgLURefYNCsEtZ7F9huM6jUR+QvT4SPwpaNlubj++Dp0uNSk4W7Jpe1oIXPgn9sU
	 RhnghyoFI+3WnuF0MXcpl1a4FLxJTZP6vosJ0eyoYDh/B919c8y3ce2nGGgmmPCsQ
	 4c4ZCRzN4agh6NB/t4DvK/+lf40OLwW2LvAS88q9DXcmtCmsG7ldUMpudTWPJvi8F
	 XzV+XfT6UHEIe0wp1CYTNFLNcfFnoQ/zDWzxOEq83AC/ct4762D8I99NuuCjGwmvd
	 PMrO4VpCrDHOFqeWNSrmjyqgVNIU+YqGTRU0O91CTPDG7iHEhabGIx9zOBagv4E5j
	 va7ygLlS56p+kjEYKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1sgexy1lgm-00Gycn; Mon, 02
 Sep 2024 13:01:26 +0200
Message-ID: <e4903dac-cfd6-4513-b7ae-7f64c80fc8b6@gmx.com>
Date: Mon, 2 Sep 2024 20:31:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Don't block system suspend during fstrim
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
 <400d2855-59c2-47d2-9224-f76f219ae993@gmail.com>
 <745754f6-0728-4682-95a0-39807675bb18@gmx.com>
 <CAO0HQ0X3zk6aau50Ew2nmNP-pwNEkmgAoC2Ewmi30sGi7uQwDA@mail.gmail.com>
 <22c49ecd-e268-4738-853e-9f79ea1e87f7@gmx.com>
 <94178c8f-c9d6-4c3e-9d1d-6d465d379e0f@gmx.com>
Content-Language: en-US
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
In-Reply-To: <94178c8f-c9d6-4c3e-9d1d-6d465d379e0f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:95bbqwOlGcOq8sfGrB9mGcgKwb9EtcmiXtHyAgPSPXqG8i6oXaQ
 i5O+f4McLUlkZ7SxFG3k5M1OqANC29effb758qqPfuVag86drXUB3aosC2KdoMjSpcgJJZG
 Epe35wCQ9TbtSGszDCKFpqdzoxmcBPzwpHYWUsrGcdZcPwEjtGFGtbMq6YCGM6OXjm77RzQ
 tCDCY1bjvW33oYRpB7IDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KCJXx4ZgsIo=;qUt1HA+AcyXh0y+7M9EwMzo9YYc
 /pF0chiEA6iBNqf9VNy7QdaJhtehmgRq5V8WfeWgBzzM7jUJ0W1h5TMMM1kR6GCfrSD/t5xYa
 t4BFdhQvk1XEj8p3NfunfMXKFQwBm2HyL9Ps9Pr25vWomWRvxWPwp32hW5zpX9GQDDWPObzgx
 tM7FmgBZQ9599IKyPw69edIFx5FDih3whoAKLp//VDCqUnOqE9k91+17W+EBqSeZHeIPp4NqB
 vJ2A7APqLHreJWEaN1QXjfTqicCJTRZPa1gP+mjmEVGlQPduB8AmCGiQ7NPoCYzWzxXSj7Cma
 CG5ezOYhGzUMP6NitTDREHtnaHe0ONx7gZAglw/DeWNSPff0XDt2puixnpAmhN+G+1dBskGHW
 miJvJBNbfXC2haf1rwQg68uIXPNVRjLnYoOyxgrw5uoQU+Wlx+ntQ8y0SkSqrU3ti2CgE+KM8
 PExMmlxOaEj310gGZesRfJjo6GN4oEdUpUQy9Lqv6EsNBggV38yFa//cgkV4ggdWQgeWTSGzd
 pXu20uJy36Bj4vjslpzW6T7yVMZgZnE+O/pvL9lwhg4WCPcoZZLnULFW6lK8nIhDzX3oADBcw
 RvQdshJIHFZr1B/fEVZPw+SNuWWC8QBehqIpssBP9D/VK/jL1BadfN3KR3d5wOzIepOl2ZQMq
 yxIQuidsz0ZoNJuvWz2sZS3t/vGC73BjzCuhanh5Kkigq4UuvEz8DWx9rVwxJoKaauGBv2fcy
 8B4pPZmHnuKgNn7CpYffTV9UxQfFpM4r6VXvLRhG8rVSsxVs7dwoDteY7vR0ELuMMqmAK+nua
 HTLfCuXAe/h+MyBzWpHTC1qmRFX061BQ55eRlHSFIOKzY=



=E5=9C=A8 2024/9/2 18:47, Qu Wenruo =E5=86=99=E9=81=93:
[...]
> Forgot to mention that, even for error case, we should copy the
> fstrim_range structure to the ioctl parameter to indicate any progress
> we made.

Sorry to bother you again, I should have notice it earlier.

There is another possible cause of the huge delay for freezing, that's
the blkdev_issue_discard() calls inside btrfs_issue_discard() itself.

The problem here is, we can have a very large disk, e.g. 8TiB device,
mostly empty.

In that case, although we will do the split according to our super block
locations, the last super block ends at 256G, we can submit a huge
discard for the range [256G, 8T), causing a super large delay.

So the proper way here is to limit the size of each discard (e.g. limit
it to 1GiB, just as the chunk stripe size limit), and do the check after
each 1GiB discard.

So this may be a larger problem than we thought.

I would recommend to split the fix into the following parts:

- Simple small fixes
   Like always update the fstrim_range structure, no matter the return
   value.

- Proper discard size split and new freezing checks

Thanks,
Qu
>
> Thanks,
> Qu
>>
>> Just please update the commit message to explicitly mention that, we
>> have a free extent discarding phase, which can trim a lot of unallocate=
d
>> space, and there is no limits on the trim size (unlike the block group
>> part).
>>
>> Thanks,
>> Qu
>>>
>>> =C2=A0=C2=A0=C2=A0 Thanks,
>>> =C2=A0=C2=A0=C2=A0 Qu
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unloc=
k(&fs_devices->device_list_mutex);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 >
>>>
>>

