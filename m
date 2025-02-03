Return-Path: <linux-btrfs+bounces-11258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6AA267B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 00:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3797D188638E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF167211A09;
	Mon,  3 Feb 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="l66/Dyb+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DBE211474
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624089; cv=none; b=UEdfaQBsnPX6Y9CfLnDQ/2ob65Ern3PkQDXOJZJtKQubjWDD1YWf88LnJZZOk5T/loU7nwTpOAyp7fcSXsRqZfCbGg2jZMCTtvAThLsB5FFplMf96wZGlaiYAoxShnavEHKt9s4ZEF/9gWzEla7Cz9HYXATWfl5FZfS0JHByXBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624089; c=relaxed/simple;
	bh=2RbMXjfh5t9a1+8bUj32pcQ018xplozRc6T2jXEmi8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XB1NTpJKAlWB308EwhpDTviYYJGPCcB7DAdmj3rwEXaLHO96ogheNrn5ak+2y8xOS1CEii2WF3K+9Bxbbto0ek9oGLWBpGGY5Q2zcDVqkSPcYUwh1ntP1kC1To6tw+ZVHSd74gZ1JDuHKCvmd0Zh0aa8fCLEclZQJEff/1YjzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=l66/Dyb+; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738624082; x=1739228882; i=quwenruo.btrfs@gmx.com;
	bh=2RbMXjfh5t9a1+8bUj32pcQ018xplozRc6T2jXEmi8E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l66/Dyb+3t9DRB+uCJ7mor6Sr6BwD7DtVvl1AEYxY25yaZSvuJ3Dr0dpUUVbjpWm
	 /C5sCuz/GZr5plbenrWFWLISKLEgnD018fhjBLMSn1pcTpRcNgxrXHJtnoJwy8ROJ
	 2haeMQd8bQ3o2ZlzSG6ueqaJF4VD3ppdwseN7wQU0sDiUVCKmbayKIABK//hdTGmK
	 1Jgfr9rHLR3W2lkmsSkX2KaV3vxEFluwVkF911BUv30tQpJoJnyVFgNbhNYoI5qTz
	 c49QsYj+PENp/qg3+z1l/sl3l3ckCZoJZbhQsC/xGjbFHA8j7Rjv/ok+Ph6yPIK7n
	 mQp0B1bVBwCc28Dtbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof5H-1t3b8i0Vsf-00cHFQ; Tue, 04
 Feb 2025 00:08:01 +0100
Message-ID: <cdd05d4b-14ba-4c1d-bdfd-226f540fa726@gmx.com>
Date: Tue, 4 Feb 2025 09:37:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: balance: add extra delay if converting with
 a missing device
To: Jeff Siddall <news@siddall.name>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <c5f42e2e31ffc95f93e62eef7d51a01bfbc9471f.1738556153.git.wqu@suse.com>
 <93e25dd4-da69-4e66-a8ec-0d502d11ca60@siddall.name>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <93e25dd4-da69-4e66-a8ec-0d502d11ca60@siddall.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18torVHwmmgfNjfyHqUjVP3mH+q/ucHJbBKsSTsS0kooHNfCuef
 ueMnM6AOVqipYmxk/VpqklKtJ+AXaMVmIvR00I2kTr1Jj40BrBP/NV8t5Y/nKaW4CEwq6du
 R0yVgvHUe21NHr0NWR0If592bkMA2WD5KyOt+TEEaVEYfbpeCmSejTn7KrZztwOT03dTWxN
 7iWQhq8bHIKMRepqAvE5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dTvlpPYgd50=;8PYegm1rPH7amw5J5jMlpw0uXp3
 yLLIFzNGjNwxHYh6aTIJqCsUzj6qg/tpqFLsIwY5r2wdmflxSRLP4LJmRhVktLmsvjJqnw8QT
 RgvnfenGJnkZhE01eTyt6D2mw0CRu2lVi2CqHeVO2kDDtirrUfXR8Bc5znE34ohKuaQXjKfO8
 N2kMuIgOE7dVxvccqmhL1hNg/RE1hPYje2upxPbTk4OyJjKstSrDIua2i7A35KtgLmF5OBm7V
 SE4STB48Kd2jEvQoPpFqb9VqE2hbUx4BYFQJxPhE+AgQo62p4h7Oo5nM56r+jcP0wYyzHRlZZ
 CLC0y2qKxg8AWjUun5Y8nfXRzuVZWmJpuMiqV+RH6sexvvea6cPZ/Mz1WpjJ+CMffhi9rIvo+
 5Q7S7NCkqAOEwrgvK/hVBab+CKpkgCn4+cYhvqEWNrRri95Xw6+TD4e5iuFAOEHMmQlS/ivAp
 3j2zQXkqqV02koHLh7u3eORXkrkHmOLoiTKydoaGQfZ4zWKTPjv3ZQ4p+q1ts0BJYF7iBvx1N
 v1u+JU1g9WhQL/M7nc5rG2enZEtMrZnyALymgo2bcb0W+1bcmBQzFUv41HkQl/l2L2qgFzCf6
 CYugfh3QaHuHB0oYPi7tgwCwf0bV80gIIiHE/AY36f7BlXLViu3FEYjQJyV2cOOpoguI6BG+Q
 niwige7oEhLn9uLNioLd9LSjPAOud2ZdO/NvxOMBboJiAcAacjSDusaDbEQoaBcu8136GOhji
 +o489LcnFyJLGEoE1c9yxcXPVzW/JcD/QoNrwi8WR9Fliq0MdoqAbdRhW+Vy24ovv9FU/Er0Z
 lMs5HilmQJoWQL0M3St5qd2QbMxnbykxHtgZhdLvQOO3Kop+7nWkSfGivbhlZDWc4BlHENQNo
 mYLouXDjmUh2b4uAOdZ47hBKUvL2Ru3hguMu5e3aRjoT3IDWiNzFlcTnHxbgB4ypsoayMUHSN
 4sNVVtuwyg9t8jh+4+Ur5BtQP/Pgf+WvYufUE8OOdQSH92niAt/DX4xmDRZSzehIFYpYEcev0
 lDJ23xe72Lna3EEMCc/pK0kpoFn8KxlknKzGDh13cRiqPbBCoWWfCQZ0g20PuVLUpzmf6WTTm
 L18En5HqDDqdJ+bqdAtWRHGNLDtqaljIF/ltdHRstwXHwVx5nkPVc4AhVSnvrjydIK2kgUF8u
 u2XZJsaiiW/afinI2NKjXixafUdKiGideBnwOT7yIlAQvHtTCPW3aDZ2+2eQmGeCoKiMqeaoq
 4dwBB1W0O+k+eFo+QElSrpEYja2faqvQvH6cv6BHEQ1EvRsb/G1E3NthPKEwJjOfGr31IADUs
 i8w58+55eK/Qow1kFsyZbmbbw==



=E5=9C=A8 2025/2/4 00:57, Jeff Siddall =E5=86=99=E9=81=93:
> Thanks Qu!
>
> This, and the associated doc update, seems like a good start. Had I
> known this process was known not to work I wouldn't have gone ahead in
> the first place.
>
> Strangely, filesystem show did state that the device was missing so it
> must have done some kind of detection.

Unfortunately the detection is only done by btrfs-progs.

`btrfs fi show` do extra open on each reported device, to make sure that
device still exists.


>=C2=A0 If it knew it was missing then
> certainly any attempt to write to that device would fail so perhaps that
> logic could be leveraged here.

Unfortunately kernel btrfs is not that smart, it ignores the only event
reported from block layer, and continues as the device is still there.

Thanks,
Qu

>
> Jeff
>
> On 2025-02-02 23:16, Qu Wenruo wrote:
>> [BUG]
>> There is a reproducer that can trigger btrfs to flips RO:
>>
>> # mkfs.btrfs -f -mraid1 -draid1 /dev/sdd /dev/sde
>> # mount /dev/sdd /mnt/btrfs
>> # echo 1 > /sys/block/sde/device/delete
>> # btrfs balance start -mconvert=3Ddup -dconvert=3Dsingle /mnt/btrfs
>> ERROR: error during balancing '.': Input/output error
>> There may be more info in syslog - try dmesg | tail
>>
>> Then btrfs will flip read-only with the following errors:
>>
>> btrfs: attempt to access beyond end of device
>> sde: rw=3D6145, sector=3D21696, nr_sectors =3D 32 limit=3D0
>> btrfs: attempt to access beyond end of device
>> sde: rw=3D6145, sector=3D21728, nr_sectors =3D 32 limit=3D0
>> btrfs: attempt to access beyond end of device
>> sde: rw=3D6145, sector=3D21760, nr_sectors =3D 32 limit=3D0
>> BTRFS error (device sdd): bdev /dev/sde errs: wr 1, rd 0, flush 0,
>> corrupt 0, gen 0
>> BTRFS error (device sdd): bdev /dev/sde errs: wr 2, rd 0, flush 0,
>> corrupt 0, gen 0
>> BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 0,
>> corrupt 0, gen 0
>> BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0, flush 1,
>> corrupt 0, gen 0
>> btrfs: attempt to access beyond end of device
>> sde: rw=3D145409, sector=3D128, nr_sectors =3D 8 limit=3D0
>> BTRFS warning (device sdd): lost super block write due to IO error
>> on /dev/sde (-5)
>> BTRFS error (device sdd): bdev /dev/sde errs: wr 4, rd 0, flush 1,
>> corrupt 0, gen 0
>> btrfs: attempt to access beyond end of device
>> sde: rw=3D14337, sector=3D131072, nr_sectors =3D 8 limit=3D0
>> BTRFS warning (device sdd): lost super block write due to IO error
>> on /dev/sde (-5)
>> BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 1,
>> corrupt 0, gen 0
>> BTRFS error (device sdd): error writing primary super block to device 2
>> BTRFS info (device sdd): balance: start -dconvert=3Dsingle -mconvert=3D=
dup
>> -sconvert=3Ddup
>> BTRFS info (device sdd): relocating block group 1372585984 flags data|
>> raid1
>> BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0, flush 2,
>> corrupt 0, gen 0
>> BTRFS warning (device sdd): chunk 2446327808 missing 1 devices, max
>> tolerance is 0 for writable mount
>> BTRFS: error (device sdd) in write_all_supers:4044: errno=3D-5 IO
>> failure (errors while submitting device barriers.)
>> BTRFS info (device sdd state E): forced readonly
>> BTRFS warning (device sdd state E): Skipping commit of aborted
>> transaction.
>> BTRFS error (device sdd state EA): Transaction aborted (error -5)
>> BTRFS: error (device sdd state EA) in cleanup_transaction:2017:
>> errno=3D-5 IO failure
>> BTRFS info (device sdd state EA): balance: ended with status: -5
>>
>> [CAUSE]
>> The root cause is that, deleting devices using sysfs interface normally
>> will trigger the shutdown callback for the fs.
>>
>> But btrfs doesn't handle that callback at all, thus it can not really
>> know that device is no longer avaialble, thus btrfs will still try to d=
o
>> usual read/write on that device.
>>
>> This is fine if the user do nothing, as RAID1 can handle it properly.
>>
>> But if we try to convert to SINGLE/DUP, btrfs will still use that devic=
e
>> to allocate new data/metadata chunks.
>> And if a new metadata chunk is allocated to the removed device, all the
>> write will be lost, and trigger the super block write/barrier errors
>> above.
>>
>> [USER SPACE ENHANCEMENT]
>> For now, add extra missing devices check at btrfs-balance command.
>> If there is a missing devices, `btrfs balance` will add a 10 seconds
>> delay and warn the possible dangerous.
>>
>> The root fix is to introduce a failing/removed device detection for
>> btrfs, but that will be a pretty big feature and will take quite some
>> time before landing it upstream.
>>
>> Reported-by: Jeff Siddall <news@siddall.name>
>> Link: https://lore.kernel.org/linux-btrfs/2cb1d81e-12a8-4fb1-b3fc-
>> e7e83d31e059@siddall.name/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> cmds/balance.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 87 insertions(+)
>>
>> diff --git a/cmds/balance.c b/cmds/balance.c
>> index 4c73273dfdc3..5c17fbc1acb5 100644
>> --- a/cmds/balance.c
>> +++ b/cmds/balance.c
>> @@ -376,6 +376,45 @@ static const char * const
>> cmd_balance_start_usage[] =3D {
>> NULL
>> };
>> +/*
>> + * Return 0 if no missing device found for the fs at @mnt.
>> + * Return >0 if there is any missing device for the fs at @mnt.
>> + * Return <0 if we hit other errors during the check.
>> + */
>> +static int check_missing_devices(const char *mnt)
>> +{
>> + struct btrfs_ioctl_fs_info_args fs_info_arg;
>> + struct btrfs_ioctl_dev_info_args *dev_info_args =3D NULL;
>> + bool found_missing =3D false;
>> + int ret;
>> +
>> + ret =3D get_fs_info(mnt, &fs_info_arg, &dev_info_args);
>> + if (ret < 0)
>> + return ret;
>> +
>> + for (int i =3D 0; i < fs_info_arg.num_devices; i++) {
>> + struct btrfs_ioctl_dev_info_args *cur_dev_info;
>> + int fd;
>> +
>> + cur_dev_info =3D (struct btrfs_ioctl_dev_info_args *)&dev_info_args[i=
];
>> +
>> + /*
>> + * Kernel will report the device path even if we can no
>> + * longer access it anymore. So we have to manually check it.
>> + */
>> + fd =3D open((char *)cur_dev_info->path, O_RDONLY);
>> + if (fd < 0) {
>> + found_missing =3D true;
>> + break;
>> + }
>> + close(fd);
>> + }
>> + free(dev_info_args);
>> + if (found_missing)
>> + return 1;
>> + return 0;
>> +}
>> +
>> static int cmd_balance_start(const struct cmd_struct *cmd,
>> int argc, char **argv)
>> {
>> @@ -387,6 +426,7 @@ static int cmd_balance_start(const struct
>> cmd_struct *cmd,
>> bool enqueue =3D false;
>> unsigned start_flags =3D 0;
>> bool raid56_warned =3D false;
>> + bool convert_warned =3D false;
>> int i;
>> memset(&args, 0, sizeof(args));
>> @@ -481,6 +521,53 @@ static int cmd_balance_start(const struct
>> cmd_struct *cmd,
>> args.flags |=3D BTRFS_BALANCE_TYPE_MASK;
>> }
>> + /*
>> + * If we are using convert, and there is a missing/failed device at
>> + * runtime (e.g. mounted then remove a device using sysfs interface),
>> + * btrfs has no way to avoid using that failing/removed device.
>> + *
>> + * In that case converting the profile is very dangerous, e.g.
>> + * converting RAID1 to SINGLE/DUP, and new SINGLE/DUP chunks can
>> + * be allocated to that failing/removed device, and cause the
>> + * fs to flip RO due to failed metadata writes.
>> + *
>> + * Meanwhile the fs may work completely fine due to the extra
>> + * duplication (e.g. all RAID1 profiles).
>> + *
>> + * So here warn if one is trying to convert with missing devices.
>> + */
>> + for (i =3D 0; ptrs[i]; i++) {
>> + int delay =3D 10;
>> + int ret;
>> +
>> + if (!(ptrs[i]->flags & BTRFS_BALANCE_ARGS_CONVERT) || convert_warned)
>> + continue;
>> +
>> + ret =3D check_missing_devices(argv[optind]);
>> + if (ret < 0) {
>> + errno =3D -ret;
>> + warning("skipping missing devices check due to failure: %m");
>> + break;
>> + }
>> + if (ret =3D=3D 0)
>> + continue;
>> + convert_warned =3D true;
>> + printf("WARNING:\n\n");
>> + printf("\tConversion with missing device(s) can be dangerous.\n");
>> + printf("\tPlease use `btrfs replace` or `btrfs device remove`
>> instead.\n");
>> + if (force) {
>> + printf("\tSafety timeout skipped due to --force\n\n");
>> + continue;
>> + }
>> + printf("\tThe operation will continue in %d seconds.\n", delay);
>> + printf("\tUse Ctrl-C to stop.\n");
>> + while (delay) {
>> + printf("%2d", delay--);
>> + fflush(stdout);
>> + sleep(1);
>> + }
>> + }
>> +
>> /* drange makes sense only when devid is set */
>> for (i =3D 0; ptrs[i]; i++) {
>> if ((ptrs[i]->flags & BTRFS_BALANCE_ARGS_DRANGE) &&
>
>


