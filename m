Return-Path: <linux-btrfs+bounces-8948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFC99FB03
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DD21C23B9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909971B0F3B;
	Tue, 15 Oct 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k408pg+D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536971B0F22
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030349; cv=none; b=HtuvfGW4Niei2VKt7ZRTQw8aqquSam+DbguCY04OlecUprsMt6Z59eNoHkhjNLo/y92Gfyts3SvVv/D7AKLmL47i+FCcU5RTpiktiU870EAbA/jITeD6HYD1Fo1aR0TPsOGhlCVoX6PlU6WpH4RF1/dWmqdDmxJbD/sWh11CeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030349; c=relaxed/simple;
	bh=jKrTA+B5ZLJQaqHkDQw851yIAHjeHK4H+8suGCTQXQY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O94AL+Z0dhoS9335Qm38AohSQDTumbQUVUx0VTVSL3W0ZbUNBAxUL2E05OtzpJnY5wF5ApvSXbW5vFLbZhzSPmqG4R4V9+Q8oS8k0tin46mPTrrYL0mJ7VVkImZ4WqqF3T82gtvXFCxVq9cvSX1cnOygySCqiX7aZ6aFbSWR8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k408pg+D; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729030337; x=1729635137; i=quwenruo.btrfs@gmx.com;
	bh=jKrTA+B5ZLJQaqHkDQw851yIAHjeHK4H+8suGCTQXQY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k408pg+DCmZKkK5eowfoEkDp3ATNcdnMU8t0OptEDObtGHqRAWEMEmDPp9WFx8/Z
	 Z7+LD2M2kIP5N97x2S2/yRgTQ6L9L3rqQTQOnSv1BwaBgNNhNh4jPD6+wO58IXLbt
	 awyG02l4/65okrGYHBJtxlPSTzZkI7zEMFLhd/D+0p7zUEn1v3TjGVrzndXBDtKZS
	 YYCu5G4rkhGhejRecAYWgAF0xa7QKNMBmX7eUV3B4lHmwCxCQ3cKTqxtl32nqEX0f
	 B9wQkL1mS1DX7YeN2FbNAkAH5oql0Eb2Oe+BuE+4dK8mGuGieIp8hJNnjD/tgWLYs
	 mUbRJk71QuJmKmJ85A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1tyFxo0kwb-012Hke; Wed, 16
 Oct 2024 00:12:17 +0200
Message-ID: <483e1bd7-83d3-42fc-96e1-8c2b75dd5c7f@gmx.com>
Date: Wed, 16 Oct 2024 08:42:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <a9aa42f6bc2739ab46ce015f749e15177f8730d6.1729028033.git.boris@bur.io>
 <08994c44-da91-4944-8b9a-4522865e4faa@gmx.com>
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
In-Reply-To: <08994c44-da91-4944-8b9a-4522865e4faa@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fc51dlDUNz3Ri5VnKIkgZyczhACaLJ1NvmaIma4i9OtQAIGk2AZ
 QtJLktdWnrkC4CyLEu1grOOb/MbgVS5aG6eEqcTK6jRPLQsBJhoKBFmRkrsFCinLQ7ZjXmK
 Ge+NAqsDYmlSU6+W775LQNmNQVnAL/F/dYRE7Lo+JrZCE7kcxjyrYI2Cie4MXvjGn7z8uF1
 QNzvfpvn84RV3ckivHhTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wXlhMwXrlWA=;78AzZ3KbZrtOSB0WKJBtWb0uoDS
 0Qt6KcEEWGugih2UEQjD79HA3dlttOkAn4JkpB3nx8jziS450XOR4ZkYPvciyYzfSDO0j8xhD
 3Ep+9pC7YhaBZGS5VKNYBrf6MgFRmW97DAuQkz+P1F6MZOwwkxTS8Ra72y+qT2Al5VEH6PGSi
 Z4OWqRXbZEPkVvmyGttHXamzRDiaiwb3bapVqvz1Q0cf1Gis6kI8zZE0HXp8vtbAwzDgJdOU+
 +aLfNPaZcFJmWDIghbHjXC/lTBx06bDjspFZEg6ad40MX4G28//U/OBkcrP9DJ/xb8cjV0uVO
 kZJgSGROWFfpgdvxaffMiFiL9byJt8X7/4HomZ/i2MlHtU/LKMkDyK+fMiubMKANwulL1AEkn
 fg0bqKHURAk9TL0J1fyNexJQJRsVXOrErLRW16evA7fpgRul/zDmN6fN498AybiFvAy0RJu7z
 Mimos5lomYIYsJWbha1Ee3E3Sxr53fKEVdtnNXU/kYusvlf+t88r0Fde1bx4ywHqmopT4G/g9
 OGVZnrHmOPZLhl40R2CnMWqfKIzK35GKpWg5/fxlY1VAxLsBFfeeySaF+MJ0ifCrEQ3mNcbW8
 zCEk0P1s7h5lgGCzAlZvw6tWuHDGK6xHP3/W0R5y8PCGaqGk1xB4TQscPYG6JbG1p9qkQuF9n
 H9TpI4PYUUhjTCfMt5ZUMWf8R852QHD0lU0jhVKS+DwYQNtqXp18EY6BHPvNFcQcMpI6g29q4
 IQLHFFJ9Yk2VADsyC3RF3o4OZrUAD2+5F/2dnLw3VcDL1OCRrAZToW5mR+5XOL4reSZCyVG3Z
 drfW4B+5otzOSh8RHfTDb2yHHwOeMNt+fTdxKGBM4CmFM=



=E5=9C=A8 2024/10/16 08:30, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/10/16 08:08, Boris Burkov =E5=86=99=E9=81=93:
>> If you follow the seed/sprout wiki, it suggests the following workflow:
>>
>> btrfstune -S 1 seed_dev
>> mount seed_dev mnt
>> btrfs device add sprout_dev
>> mount -o remount,rw mnt
>>
>> The first mount mounts the FS readonly, which results in not setting
>> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
>> somewhat surprisingly clears the readonly bit on the sb (though the
>> mount is still practically readonly, from the users perspective...).
>> Finally, the remount checks the readonly bit on the sb against the flag
>> and sees no change, so it does not run the code intended to run on
>> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
>>
>> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN an=
d
>> does no work. This results in leaking deleted snapshots until we run ou=
t
>> of space.
>>
>> I propose fixing it at the first departure from what feels reasonable:
>> when we clear the readonly bit on the sb during device add.
>>
>> A new fstest I have written reproduces the bug and confirms the fix.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>
> The fix looks good to me, small and keeps the super block ro flag
> consistent.
>
> IIRC the old behavior of sprout is, adding device will immediately mark
> the fs RW, which is a big surprise changing the RO/RW status.
>
> So the extra Rw remount requirement looks very reasonable to me.

Forgot to mention, although it's a trivial change in the behavior, if we
are determined to go this path, the man page of the "SEEDING DEVICE"
chapter also need to be updated.

Thanks,
Qu
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
>> ---
>> Note that this is a resend of an old unmerged fix:
>> https://lore.kernel.org/linux-
>> btrfs/16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur=
.io/T/#u
>> Some other ideas for fixing it by modifying how we set BTRFS_FS_OPEN
>> were also explored but not merged around that time:
>> https://lore.kernel.org/linux-btrfs/
>> cover.1654216941.git.anand.jain@oracle.com/
>>
>> I don't have a strong preference, but I would really like to see this
>> trivial bug fixed. For what it is worth, we have been carrying this
>> patch internally at Meta since I first sent it with no incident.
>> ---
>> =C2=A0 fs/btrfs/volumes.c | 4 ----
>> =C2=A0 1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index dc9f54849f39..84e861dcb350 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2841,8 +2841,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
>> *fs_info, const char *device_path
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_blocksize(device->bdev_file, BTRFS_B=
DEV_BLOCKSIZE);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (seeding_dev) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_clear_sb_rdonly(sb);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* GFP_KERNEL al=
location must not be under device_list_mutex */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seed_devices =3D=
 btrfs_init_sprout(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(seed_=
devices)) {
>> @@ -2985,8 +2983,6 @@ int btrfs_init_new_device(struct btrfs_fs_info
>> *fs_info, const char *device_path
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->chunk_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&fs_info->fs_devices->devic=
e_list_mutex);
>> =C2=A0 error_trans:
>> -=C2=A0=C2=A0=C2=A0 if (seeding_dev)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_sb_rdonly(sb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (trans)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_end_transa=
ction(trans);
>> =C2=A0 error_free_zone:
>
>


