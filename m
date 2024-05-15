Return-Path: <linux-btrfs+bounces-5028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9038C6DF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 23:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87D7283E9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 21:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004815B558;
	Wed, 15 May 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="byWGQLCq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C5155A57
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809657; cv=none; b=rbxHLAePNAtDiemjFs9Q6uEx8Ey0PkjcDY8MXpShtmw8g/CzexfWQwUBqeCJ1eGBqBAznrgsK2BJxge23Rizf+f+Od8eIe2IvWUqSWDWNl9Qcwz7TKb37XF6Yy+rvg8aByGEgxUmPtD+KeimBDb99y8sh0o9DOzwfPIjkqCLexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809657; c=relaxed/simple;
	bh=b1d39pVchLqcFFb4Zd/fRjrp3PAzp1r/zI5fD2olp4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcM8cGTijuouqvTAO49IYLIeszJKyZu+Sa2MhSgDURbifolAx9ZsOgp+REpXb1RRPdfgJWfo+u0xv0j3yR9nM6H0caHaUPxgGDO9aUZksUWIEvNrV6xPu7QWMD4jSi9hPysT+QoLANmoPSbZLmahSRGhjfN9Ma2MwKvj8X7jeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=byWGQLCq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715809650; x=1716414450; i=quwenruo.btrfs@gmx.com;
	bh=9ScNtmKiBc6e8rT9xB7jHT9iaHfNtm9v2QsVCgUkkPw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=byWGQLCqhFearVWiTfs+HYI2OG503v0wKlQ6VUPmdAcXp8txBihitFF9I57KbhN3
	 uCkRqbSGYPjhBeCHZfJQcY+79385qnUapuad3RkSJK0i2Kl+ZHuadYwzpEbpAyeRK
	 r1I8UHoohCzDNVgEA3SkpYKrEpOZPj80DJ2hhj/AdvduqiHl+jMNAIAwCoBy234sM
	 1cfrmp2fMaoxoHEg8rbBsf7tZDgf0ytl7RTb9PBTtGR84TN8ZFffacMVENl9nHizx
	 WwY8mHhpDMhmYZppvqTJOp5c0CiBKJfPfexF/bgqRwjpcJOPhZ41Qsa1cnOz+mTHp
	 Q6nNmezE6BG64FMpLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mirng-1sk0fd2Z4W-00etNa; Wed, 15
 May 2024 23:47:30 +0200
Message-ID: <16385ce4-fde3-4356-add1-dbe05d4f5052@gmx.com>
Date: Thu, 16 May 2024 07:17:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] btrfs-progs: support byte length for zone
 resetting
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-7-naohiro.aota@wdc.com>
 <d971380b-1867-4e8f-b9c8-aeda8aec2c79@gmx.com>
 <bxcsi225e5cpmvod6yx764nihpml6dyizjtgslmqajmvtn26mq@l2yuxz4myrye>
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
In-Reply-To: <bxcsi225e5cpmvod6yx764nihpml6dyizjtgslmqajmvtn26mq@l2yuxz4myrye>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j1NBO8eAe76VoUVdtMkkNrRq6yAyQhj3KZRh+Je2kvBdzUDwQ+P
 TvSxWm/7BKahsn7NkUS7O2D4VevtVMBaz2061c2FBtwW1VVuRb+/AtHYtV07MohX0T9/kNU
 6tTXdwdHPNlworXcson4969t6jjHCaoDS9a/YXNfve608YJg4CwNiymjOppeGdPub+w8JVP
 Mfh6Y44lc6j88NpFjUR/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EVTBDRgv6+A=;Lm3RYvFvIlFWSyCWE/tB9z99OnU
 z57F+MaztXSFCs/I0ZEbYRwwx1QjWTGM9Fso31ubuRiKmjzc8uiZUarJgzMsYaE+FpK9kozMH
 HkAB8leEOTVeDkQQSn5MwSx3Zj+SA03PoQ/njnk+SvadZdIfUeeY21t0+HYt6hzO6AIVEKtGT
 BAIzhZOVzOpMcfIOvfiaIKTN5AhI16K4D6qo/n4hQyfzZQ8o76T9YoNo2jwpWFLUwTUlQDNAO
 Md4ywrWuj+mJdttXbZyqcZA/z04MdMrjlwmHhcX6rQDyPwmY7iw7VLg2JlJAAcF83OvO3tS7P
 vxoezQELTo+KoW/qw96M9jSSOPMirQzA1u7y/rBI1KL0IVJSQ+UNxeu22S/mHuIhcsOwRAYGF
 9HK63Hy8LI9vfOOJaLbl6+ymY+nJwnALu8M/R6JN3iO3xwyxI9BBNokBHPSuiJ0qWM2pNGYJu
 YE9tdX7gII7IJsTA6SBKjqlcqpbdlEaNMK28YUOvVg4ewz+2elFHjxXHwK1WK3uNMvbPyC9dO
 QIx7/hYOWG7Bfh8qbq+BuIeQrsnIi2zCNlU0m55LQ+TAyc7VtYPY5m5ITVfGaX922TWblnfbw
 I72RcJIVTvI++bH2hQgTDOzmMqDjzhl00QpU59IciQVYbCq74MVg0rPTqhceT8kvY1/wZNqr0
 fVqS5P0EpgNhjhP+IXM0vqULuiXR6JxGmvMxXriKE7/y0n6vR1w5g3KOSh3M78jxHE/f4SFiR
 pB4mlX/q0XysM5SB05eZw8H9voNum1gRAG8mmJcRzsuNVwkOKEALt6VZnujYNBA6rPdNvze4Q
 xz9zgSTms/9fQxIHNzi9HWkNhYmzdAFfwYnxCKAlQ3RvE=



=E5=9C=A8 2024/5/16 01:41, Naohiro Aota =E5=86=99=E9=81=93:
> On Wed, May 15, 2024 at 08:29:55AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/5/15 03:52, Naohiro Aota =E5=86=99=E9=81=93:
>>> Even with "mkfs.btrfs -b", mkfs.btrfs resets all the zones on the devi=
ce.
>>> Limit the reset target within the specified length.
>>>
>>> Also, we need to check that there is no active zone outside of the FS
>>> range. If there is one, btrfs fails to meet the active zone limit prop=
erly.
>>
>> Mind to explain more on why an active zone *outside* of the fs range is
>> a problem?
>>
>> It's pretty instinctive to consider such active zones out of the fs
>> range as non-exist, thus should not cause much problem (until we want t=
o
>> expand the fs etc).
>>
>> This should just acts like the data beyond fs range in traditional
>> devices, and we never really bothered them.
>
> A zoned device may have an upper limit on the number of active zones, so
> you cannot write into zones beyond that limit at the same time.
>
> https://zonedstorage.io/docs/introduction/zns#zone-resources-limits

Oh, I forgot the active zones limits.

>
> So, if we have an active zone outside the FS, btrfs cannot utilize all t=
he
> active zones for it. In the worst case, if you have an active zone limit=
 =3D
> 8 and 5 zones are already used outside the FS, we cannot maintain the
> minimum necessary 4 active zones: superblock, data, metadata, and system
> block group.
>
> Technically, we can scan all the device zones to count active zones and =
try
> to live with the rest. But, I don't see a clear use case for that.
>
> However ... I just noticed we do it so because the current mount code ne=
ver
> checks the btrfs_device->total_bytes. The minumum active zone requiremen=
t
> check is broken for the "-b" case, though.

A new series for kernel would be great.

>
> I believe mandating no active zones outside the FS both at mkfs and moun=
t
> time is a clean way to go unless there is a request with a good reason.

Yeah, this sounds very reasonable now to require no active zones.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> ---
>>>    common/device-utils.c | 17 ++++++++++++-----
>>>    kernel-shared/zoned.c | 23 ++++++++++++++++++++++-
>>>    kernel-shared/zoned.h |  7 ++++---
>>>    3 files changed, 38 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/common/device-utils.c b/common/device-utils.c
>>> index 86942e0c7041..7df7d9ce39d8 100644
>>> --- a/common/device-utils.c
>>> +++ b/common/device-utils.c
>>> @@ -254,16 +254,23 @@ int btrfs_prepare_device(int fd, const char *fil=
e, u64 *byte_count_ret,
>>>
>>>    		if (!zinfo->emulated) {
>>>    			if (opflags & PREP_DEVICE_VERBOSE)
>>> -				printf("Resetting device zones %s (%u zones) ...\n",
>>> -				       file, zinfo->nr_zones);
>>> +				printf("Resetting device zones %s (%llu zones) ...\n",
>>> +				       file, byte_count / zinfo->zone_size);
>>>    			/*
>>>    			 * We cannot ignore zone reset errors for a zoned block
>>>    			 * device as this could result in the inability to write
>>>    			 * to non-empty sequential zones of the device.
>>>    			 */
>>> -			if (btrfs_reset_all_zones(fd, zinfo)) {
>>> -				error("zoned: failed to reset device '%s' zones: %m",
>>> -				      file);
>>> +			ret =3D btrfs_reset_zones(fd, zinfo, byte_count);
>>> +			if (ret) {
>>> +				if (ret =3D=3D EBUSY) {
>>> +					error("zoned: device '%s' contains an active zone outside of the=
 FS range",
>>> +					      file);
>>> +					error("zoned: btrfs needs full control of active zones");
>>> +				} else {
>>> +					error("zoned: failed to reset device '%s' zones: %m",
>>> +					      file);
>>> +				}
>>>    				goto err;
>>>    			}
>>>    		}
>>> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
>>> index fb1e1388804e..b4244966ca36 100644
>>> --- a/kernel-shared/zoned.c
>>> +++ b/kernel-shared/zoned.c
>>> @@ -395,16 +395,24 @@ static int report_zones(int fd, const char *file=
,
>>>     * Discard blocks in the zones of a zoned block device. Process thi=
s with zone
>>>     * size granularity so that blocks in conventional zones are discar=
ded using
>>>     * discard_range and blocks in sequential zones are reset though a =
zone reset.
>>> + *
>>> + * We need to ensure that zones outside of the FS is not active, so t=
hat
>>> + * the FS can use all the active zones. Return EBUSY if there is an a=
ctive
>>> + * zone.
>>>     */
>>> -int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zin=
fo)
>>> +int btrfs_reset_zones(int fd, struct btrfs_zoned_device_info *zinfo, =
u64 byte_count)
>>>    {
>>>    	unsigned int i;
>>>    	int ret =3D 0;
>>>
>>>    	ASSERT(zinfo);
>>> +	ASSERT(IS_ALIGNED(byte_count, zinfo->zone_size));
>>>
>>>    	/* Zone size granularity */
>>>    	for (i =3D 0; i < zinfo->nr_zones; i++) {
>>> +		if (byte_count =3D=3D 0)
>>> +			break;
>>> +
>>>    		if (zinfo->zones[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {
>>>    			ret =3D device_discard_blocks(fd,
>>>    					     zinfo->zones[i].start << SECTOR_SHIFT,
>>> @@ -419,7 +427,20 @@ int btrfs_reset_all_zones(int fd, struct btrfs_zo=
ned_device_info *zinfo)
>>>
>>>    		if (ret)
>>>    			return ret;
>>> +
>>> +		byte_count -=3D zinfo->zone_size;
>>>    	}
>>> +	for (; i < zinfo->nr_zones; i++) {
>>> +		const enum blk_zone_cond cond =3D zinfo->zones[i].cond;
>>> +
>>> +		if (zinfo->zones[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
>>> +			continue;
>>> +		if (cond =3D=3D BLK_ZONE_COND_IMP_OPEN ||
>>> +		    cond =3D=3D BLK_ZONE_COND_EXP_OPEN ||
>>> +		    cond =3D=3D BLK_ZONE_COND_CLOSED)
>>> +			return EBUSY;
>>> +	}
>>> +
>>>    	return fsync(fd);
>>>    }
>>>
>>> diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
>>> index 6eba86d266bf..2bf24cbba62a 100644
>>> --- a/kernel-shared/zoned.h
>>> +++ b/kernel-shared/zoned.h
>>> @@ -149,7 +149,7 @@ bool btrfs_redirty_extent_buffer_for_zoned(struct =
btrfs_fs_info *fs_info,
>>>    					   u64 start, u64 end);
>>>    int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devi=
d,
>>>    			    u64 offset, u64 length);
>>> -int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zin=
fo);
>>> +int btrfs_reset_zones(int fd, struct btrfs_zoned_device_info *zinfo, =
u64 byte_count);
>>>    int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo,=
 off_t start,
>>>    		     size_t len);
>>>    int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices);
>>> @@ -203,8 +203,9 @@ static inline int btrfs_reset_chunk_zones(struct b=
trfs_fs_info *fs_info,
>>>    	return 0;
>>>    }
>>>
>>> -static inline int btrfs_reset_all_zones(int fd,
>>> -					struct btrfs_zoned_device_info *zinfo)
>>> +static inline int btrfs_reset_zones(int fd,
>>> +				    struct btrfs_zoned_device_info *zinfo,
>>> +				    u64 byte_count)
>>>    {
>>>    	return -EOPNOTSUPP;
>>>    }

