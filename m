Return-Path: <linux-btrfs+bounces-8205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F482984C96
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 23:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B351F2492D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 21:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9013D251;
	Tue, 24 Sep 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bKiPn7F7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F767F460
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212338; cv=none; b=dGgWn2LMPYCVWjkOJ9GMFfH3ZqQRFvFLc+Gu94id6e56CWWyabbDOxBloIUifn7IXLd8Y9a3pBEhXWujQncULI7PUEV+tuSe6C2RVbilazLStWkNFOam/U56r8BF5QG7+xPXp8De51aEpRjsXhABIglZ6eUbtIkm/z6zAZPEzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212338; c=relaxed/simple;
	bh=O8vdg853YYNbqdpFD+lVAqeZUMDFTczJgpZhw1vm3lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCnieYgjyF+IPDLKxnq9sTxu8FaGD2ZpJeK4Ole4S64KGFwTD9lk/EBzFRAJ93mMrAdgFK/b7qie1JtxGREBzwCqhSVILz/M0if5OQ+MLGZdGbQHTCqTXUBmWVUXv40kDPawLZWCW0VtMXPphWm1gEtRb+ElrVRH4Nnkf1xwAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bKiPn7F7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727212328; x=1727817128; i=quwenruo.btrfs@gmx.com;
	bh=3Wq39LfGPQeqnfvzN5eKdkKwcqQtoXpjP9SnX4cbgmw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bKiPn7F7Rfg/BlX4Ag0/6+jWLsC/FgQqBZAXMCrshteuN/WdLwop6SiOFlBaSck+
	 8Pdda56XISfkTBxMjd+KnWR7kHYabxdLU0TKPi3ba0NGkzYACqxsCHV88Jq3ujQTG
	 crRg477bIlAQvtaekhApSgqKwKvxPWT4OCW2/O5ok36QAq5hNOaCJPGSG7w8QCF1q
	 EQ2OWCPWQ6eZlkMrnjJ3mgMsXp5G+/8qXT23/69N80mzBksHURzgPERAbggF7+12V
	 B9Xg9ury7Xx9VjuqnHgakPe5Qv9RNp7zrnUrQsUUoCMlb8m6+nEL8jOsPYqIy1Wml
	 MNKgt7oLYQQ3H5T8Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1rzsBp47ek-0162Zk; Tue, 24
 Sep 2024 23:12:08 +0200
Message-ID: <3748a184-eb72-4edc-91d3-809c3e3bb5b8@gmx.com>
Date: Wed, 25 Sep 2024 06:42:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: avoid unnecessary device path update for the
 same device
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1727154543.git.wqu@suse.com>
 <bb5f08852d68f7424b1113deb74586527912c290.1727154543.git.wqu@suse.com>
 <CAL3q7H5c3CiWSaag8Sb=Wrqtj6CRYAkEA9bj69TuVgjKh-YNDA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5c3CiWSaag8Sb=Wrqtj6CRYAkEA9bj69TuVgjKh-YNDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sT0TBpo+JsI3Pk8s+i8fTg1nPp925NoK70k3M9BRiMiKwyzO6Oy
 oIuU2v6z5qlXAewAVKRKW6V+T+WeZFaS66G4HZtMbV3DQQLooSU8nruHk7BTyYOff90zN13
 3VL5WvvOXSfHLbQ9JTRuKcgZ/hUAclaeBi0knHswGZCxrV1vpxgONevO2pF4b51+DajBe2v
 w/NFBkXd/5DNDd+mlXzvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ILZH+G69pq8=;ZNnHOWrfnQ80YUUtdmqSXYMpJUo
 24HqYJCRHeB2WXR3PQ91DEch9QAJlLY+7/g6zAEjCZ2v4Mc5SHzfg10Xn5Z4AJ+aJxGFghFrI
 JowuOZotNhsRGn3EGV5ddSXfyUdcV38oc2beg270TsnRmNr9M4wnSGrUkSxW8HdHfdk/3SBNk
 FNWZNbCPJHyZVr+xDHKxE8b1hUM1kEy+ZA2+PLsFJ2EyYvXD27SI70M1Q7nDaiI6a+XTYuqvg
 ikFwff1TMdMZmQ+bqUExa49+bmCnLWYeJsIgewMIMvtIObZFIPQIsOg80mvIwVD9qTU8Q7rCU
 QSyd5LTmo1ag6Xrg4qsBKo7Rcjytgmv4bUGCv617BwjNswxeizz2A7rl87f6fTjKqJzaq8CPU
 u9haEtQNhs4g7EZt83xQW3VucdEDlLZpVNU+GzsJ7oVJuxgaAt/OoOntbC/eO3hYccSKTs/w+
 n7Rz9FW4l9XjX4dvIpdosc8wlX2gGw4r2Ay+mYhyDKheUTd0ual51S/DZ1KrWRPgyRLyY+LMh
 aV5CBOo0cpYRffebFHIXF9lZDUnsF36VJ4/MtYRR0/xH1aKvaBfGjNAmXX6bEDrHSFU6m9tg2
 ixYy9qCVg6ML2RfRl9Vll5ZcZdix43d/S0v5XCxs5L1dGRT7eo3cZlN/b+AA104qLHvDLNS8/
 0Y2f4MBnoFaeKN+fJU8hpUx3cvUMwaofKUnS9R4ZLHnAixGqxwqvf8W8rnrgAFz0LmDdx8+f2
 osTMK47Nm6VysctRNvFEmvTDqphjBnAzSCiTjfUplOauTx/Rv44CQ7VoAJblv6zOd4HGy6JxL
 HWbAabau2hEZbQmiAQX5PvsRuasR+Glc1jGdqOsHIEWlk=



=E5=9C=A8 2024/9/24 21:17, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Sep 24, 2024 at 6:17=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [PROBLEM]
>> It is very common for udev to trigger device scan, and every time a
>> mounted btrfs device got re-scan from different soft links, we will get
>> unnecessary renames like this:
>>
>>   BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 trans=
id 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (11096)
>>   BTRFS info (device dm-2): first mount of filesystem 2378be81-fe12-46d=
2-a9e8-68cf08dd98d5
>>   BTRFS info (device dm-2): using crc32c (crc32c-intel) checksum algori=
thm
>>   BTRFS info (device dm-2): using free-space-tree
>>   BTRFS info: devid 1 device path /proc/self/fd/3 changed to /dev/dm-2 =
scanned by (udev-worker) (11092)
>>   BTRFS info: devid 1 device path /dev/dm-2 changed to /dev/mapper/test=
-scratch1 scanned by (udev-worker) (11092)
>>
>> The program "mount_by_fd" has the following simple source code:
>>
>>   #include <fcntl.h>
>>   #include <stdio.h>
>>   #include <sys/mount.h>
>>
>>   int main(int argc, char *argv[]) {
>>          int fd =3D open(argv[1], O_RDWR);
>>          char path[256];
>>
>>          snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
>>          return mount(path, argv[2], "btrfs", 0, NULL);
>>   }
>>
>> Note that, all the above paths are all just pointing to "/dev/dm-2".
>> The "/proc/self/fd/3" is the proc fs, describing all the opened fds.
>
> This is redundant to say, we all know everything inside /proc belongs
> to procfs, and self/fd/X corresponds to an open fd by the calling
> task.
>
>> The "/dev/mapper/test-scratch1" is the soft link created by LVM2.
>
> What would be more useful here is to have all the steps to reproduce
> the problem:
>
> 1) How you invoke that test program, what the arguments are;
> 2) Any other steps that one should run to reproduce the problem.
>
> Can we also get a test case for fstests?

 From my tests with ext4, it's really btrfs' ability to change path name
halfway saving us.

For ext4, the weird device name will stick there forever, and I do not
even know if this is the expected behavior or not.

> Even if it's caused by a race and it doesn't always trigger, with
> several people often running fstests frequently, possible regressions
> will be quickly detected.

So far I haven't hit a case where the proc name can stay persistent,
udev rescan always saves us.

I guess the only reliable way to get such situation is to disable udev
or on systems without udev completely.

>
>>
>> [CAUSE]
>> Inside device_list_add(), we are using a very primitive way checking if
>> the device has changed, strcmp().
>>
>> Which can never handle links well, no matter if it's hard or soft links=
.
>>
>> So every different link of the same device will be treated as different
>> device, causing the unnecessary device name update.
>>
>> [FIX]
>> Introduce a helper, is_same_device(), and use path_equal() to properly
>> detect the same block device.
>> So that the different soft links won't trigger the rename race.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Since there's a publicly accessible report for this, at
> https://bugzilla.suse.com/show_bug.cgi?id=3D1230641, can we please at
> least get a Link tag here?

Sure.

>
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
>
> This can simply be: ... =3D { 0 }

Unfortunately that will trigger designated-init warning since the
structure has __randomize_layout attribute.

>
> But I don't mind this more verbose initialization.
>
> With the change log fixes:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for the review,
Qu

>
> Thanks.
>
>> +       bool is_same =3D false;
>> +       int ret;
>> +
>> +       if (!device->name)
>> +               goto out;
>> +
>> +       old_path =3D rcu_str_deref(device->name);
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


