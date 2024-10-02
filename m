Return-Path: <linux-btrfs+bounces-8460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8498E49D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 23:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194CD1F23563
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C821731E;
	Wed,  2 Oct 2024 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mJ4qPxQ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F941D1E60
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903401; cv=none; b=ZjDA0VuvsfjwBtfSkzmOCJBmxlzkZO9iJx7wTlErWMHr30d5R2SHTz+vEJFB9QtPjD2FE2RlQDpxfYsWYJ0WCSC/DwxpZ+QAYYBvfVS00XYAyH5pS7VTruq1cUALTfmzGdUtJFQH2j8uQCDGBIpR09FrTiZFb+Wd/rFgOAR17r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903401; c=relaxed/simple;
	bh=ozdXz8GoA3OndJpr+hYcEuxk2O8mX/4Ta11WMauN6iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYSR3ijDvO2BELPthmbQ1gDoFzjyJHM2FtMbDdT0Ixh/Zeyl/K9LTQ3mIDMkMvYJBthntT7jbiSvQrnVlfI3UMJnHj1O3CNC4YZGG4tKvtmyPvIRDCWfOa3CY6Rv8E43NdhTXxJAEfJIevqgtyWJEQh6kDtFaNUWyzSVCa8ms5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mJ4qPxQ7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727903388; x=1728508188; i=quwenruo.btrfs@gmx.com;
	bh=0qshPNFPmGUsyiF1YMMwQqz9gw0wnmE4vsWRU/OumjY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mJ4qPxQ7jLcQjUOqvoxLjd4xBbuXLWDl3Yr5bjabtpDwzky3nNC6NtvpcgKVx6Mw
	 7ZgfnJAOPN+J3S3hBgMrBYgrraj5nPBD6btAL0p1Xisj5sTca9mBhCzURtqOGSjKv
	 6VVaxs/F7XjU3xZW45EtKIwFmcHOajqmzrtZ8HHac/MXgpqfyFsjk/htkHzfG1NPF
	 4/R4ZQqiC7YddzbfKuGidcChCqJwBR/NE1hCdeBh63yC8m5/EehmseM5TELejDZfX
	 VgmxAUxw2fZ9lZN4qOI38/Uah1MnqSR4ddscq72MRk3LSVKPlv6Z7JUgMV0Ma4R57
	 Pe43J3S4qlVKhg0htQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1sEU3t46B0-00o1ag; Wed, 02
 Oct 2024 23:09:48 +0200
Message-ID: <421d016b-672e-4eb7-bd0c-3269eb675f66@gmx.com>
Date: Thu, 3 Oct 2024 06:39:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: avoid unnecessary device path update for
 the same device
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 Fabian Vogt <fvogt@suse.com>
References: <cover.1727222308.git.wqu@suse.com>
 <3b02eabf87e477dd25e21a4c2cf7720e530d7531.1727222308.git.wqu@suse.com>
 <CAL3q7H50O_LA8vje8JSH+xVM07VA55G286bWtUwfCdpzfVavfQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H50O_LA8vje8JSH+xVM07VA55G286bWtUwfCdpzfVavfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6gqbC0k7d0Wnpx3xJ/pxJ1FYUUVO2gJC0wq7f2LVzoelICVAcmx
 3waHDRe4iMy91p+JOVFiKcLelcsTlMgQWFjMmp3bU5xgJtDvwHoIYQnK/8IhhStxvud9/OC
 IfFEIYK1YRRP/xdtpyG5h18HBwu5Zf0hHoDeVIP20epXT4HkU7X80ydltgj/fgzWaMmMP47
 iTYuaqr6j3ZMSPvZWMRhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zCruLa0vqvA=;oFh0RV6ojloTz8QboX9uL8knJLX
 ksmqmLZE70SF0ieVMZceOiU5FhjE23tltpcoSeD1T0Ifd8GI6ej2j8SYMiiXPYHKESzC8zd2I
 78nTei8Xkp0mXiR0HYWaXG/2+48QD+Oekys+kkR5RwNeK5SgFnih+n8UjOPeNIXCKoTTBgOil
 GOgS6avqmrPauu5cX+Rv3WPhCiu0DoKLuVUsMoLF5RLbl9J7TXrtAy6hRgCgryJTggVPogVy0
 pMFsgav1a8kYblfs9rSg1D75JpWxQnpI37w0cKh29EgvMYuhhHjvWZQqDwngBR5qyjk9jcv2d
 pjn1V2VaSeZQxd7LmGTZ3Dmxd7HUiuJhm3t2VPQBmlYf6/dn/tb7SqZemestoym4El5CDGbta
 DZYhKNipHEyS6FL8SWh1CdhJY49x09lbRdzMXmusn+fcdMeKpZTIhTIJhNgLhHFwr4EmwZBUL
 k2ZU/BlcFbxclM/ECjma+AYCP3IpyGCEb3WcnKuolJDhGW94ip08ZS9ifI97WVBLpw4yEqVYl
 wevr8VazZtqPvg3cM2IjByYHqDozqbq17FpPZbB9yHQ8O39k/6b7VqXdCZ6QlTVtekC8sfd01
 v5sxK0X6Q8wXpyxRQdTxlxDG5kzydmteQRuKE2R8sSZMzDVj6t8ZBZV5ESRQ9Bxyr8mt6V7Fr
 Rvs0pekVraOEeCKyD7ysAwNO9mz6zWGa67RWAugMpLdFMsQTRHK6EYsztKsa5uzy2d4keQEEQ
 i6tUd+Xrb7obKzvFYBEocdgDhj/kUEJ38rTlr2mb478pdYFU2/Y9G5Wri6pdGDSUVz+ar09aC
 QKlcS6r/Qu0lVGtrdjk5wMeA==



=E5=9C=A8 2024/10/2 23:44, Filipe Manana =E5=86=99=E9=81=93:
> On Wed, Sep 25, 2024 at 1:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [PROBLEM]
>> It is very common for udev to trigger device scan, and every time a
>> mounted btrfs device got re-scan from different soft links, we will get
>> some of unnecessary device path updates, this is especially common
>> for LVM based storage:
>>
>>   # lvs
>>    scratch1 test -wi-ao---- 10.00g
>>    scratch2 test -wi-a----- 10.00g
>>    scratch3 test -wi-a----- 10.00g
>>    scratch4 test -wi-a----- 10.00g
>>    scratch5 test -wi-a----- 10.00g
>>    test     test -wi-a----- 10.00g
>>
>>   # mkfs.btrfs -f /dev/test/scratch1
>>   # mount /dev/test/scratch1 /mnt/btrfs
>>   # dmesg -c
>>   [  205.705234] BTRFS: device fsid 7be2602f-9e35-4ecf-a6ff-9e91d2c182c=
9 devid 1 transid 6 /dev/mapper/test-scratch1 (253:4) scanned by mount (11=
54)
>>   [  205.710864] BTRFS info (device dm-4): first mount of filesystem 7b=
e2602f-9e35-4ecf-a6ff-9e91d2c182c9
>>   [  205.711923] BTRFS info (device dm-4): using crc32c (crc32c-intel) =
checksum algorithm
>>   [  205.713856] BTRFS info (device dm-4): using free-space-tree
>>   [  205.722324] BTRFS info (device dm-4): checking UUID tree
>>
>> So far so good, but even if we just touched any soft link of
>> "dm-4", we will get quite some unnecessary device path updates.
>>
>>   # touch /dev/mapper/test-scratch1
>>   # dmesg -c
>>   [  469.295796] BTRFS info: devid 1 device path /dev/mapper/test-scrat=
ch1 changed to /dev/dm-4 scanned by (udev-worker) (1221)
>>   [  469.300494] BTRFS info: devid 1 device path /dev/dm-4 changed to /=
dev/mapper/test-scratch1 scanned by (udev-worker) (1221)
>>
>> Such device path rename is unnecessary and can lead to random path
>> change due to the udev race.
>>
>> [CAUSE]
>> Inside device_list_add(), we are using a very primitive way checking if
>> the device has changed, strcmp().
>>
>> Which can never handle links well, no matter if it's hard or soft links=
.
>>
>> So every different link of the same device will be treated as a differe=
nt
>> device, causing the unnecessary device path update.
>>
>> [FIX]
>> Introduce a helper, is_same_device(), and use path_equal() to properly
>> detect the same block device.
>> So that the different soft links won't trigger the rename race.
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1230641
>> Reported-by: Fabian Vogt <fvogt@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 995b0647f538..b713e4ebb362 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -732,6 +732,32 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_sup=
er_block *sb)
>>          return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>>   }
>>
>> +static bool is_same_device(struct btrfs_device *device, const char *ne=
w_path)
>> +{
>> +       struct path old =3D { .mnt =3D NULL, .dentry =3D NULL };
>> +       struct path new =3D { .mnt =3D NULL, .dentry =3D NULL };
>> +       char *old_path;
>> +       bool is_same =3D false;
>> +       int ret;
>> +
>> +       if (!device->name)
>> +               goto out;
>> +
>> +       old_path =3D rcu_str_deref(device->name);
>
> There's a missing rcu_read_lock / unlock btw. It's triggering warnings
> in the test vms.

Thanks a lot, I was also wondering if it's the case, but the zoned code
gave me a bad example of not calling rcu_read_lock().

Shouldn't all btrfs_dev_name() and the usages inside zoned code also be
fixed?

Thanks,
Qu
>
> Thanks.
>
>> +       ret =3D kern_path(old_path, LOOKUP_FOLLOW, &old);
>> +       if (ret)
>> +               goto out;
>> +       ret =3D kern_path(new_path, LOOKUP_FOLLOW, &new);
>> +       if (ret)
>> +               goto out;
>> +       if (path_equal(&old, &new))
>> +               is_same =3D true;
>> +out:
>> +       path_put(&old);
>> +       path_put(&new);
>> +       return is_same;
>> +}
>> +
>>   /*
>>    * Add new device to list of registered devices
>>    *
>> @@ -852,7 +878,7 @@ static noinline struct btrfs_device *device_list_ad=
d(const char *path,
>>                                  MAJOR(path_devt), MINOR(path_devt),
>>                                  current->comm, task_pid_nr(current));
>>
>> -       } else if (!device->name || strcmp(device->name->str, path)) {
>> +       } else if (!device->name || !is_same_device(device, path)) {
>>                  /*
>>                   * When FS is already mounted.
>>                   * 1. If you are here and if the device->name is NULL =
that
>> --
>> 2.46.1
>>
>>
>


