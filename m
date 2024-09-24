Return-Path: <linux-btrfs+bounces-8206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448F984C9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E879F1F24943
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 21:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EF013CA8A;
	Tue, 24 Sep 2024 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zr1GFwb3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF1139D
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212573; cv=none; b=Ale13u4HlsDyCf3l8TY/z+UlUmo+jR6q4eA3KygYxGk4Ps20CnwXvrNt4BerBwWlzRCpOAHytvSKlOtPl9Afp/EpQHAXk5+6slB0wCrAeEm8WjNndmmRXCZFT8Kmdmc5LdaCUbmDSJt/k0mv8WvQsIxKs4p08l/hDFTP32J0s9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212573; c=relaxed/simple;
	bh=bCq1YVHeCqCaaHd2XTxdHf1uG9xaWvj2aO9CY++YFSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoU5PnoQlJZLPN4Ofrsb0WXLRGMrF1Fj+CnA62c03CQb3ViHB1g2EhQkrEGaA+0s+A+Vv5rf7zotyk5aHrcyLs0gG+/Dzf+80RJAqac7Z4VgR3ImaaS2zRV7pam/86le2HDQvRTulXBSokliV2TgFfqfVydn0BVpB/sER3D9f/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Zr1GFwb3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727212564; x=1727817364; i=quwenruo.btrfs@gmx.com;
	bh=/Ka+Rr557q6UUuzMUBxJI0mpElY6PoY/SK9GJPHo/lk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zr1GFwb3hsPYIJIeznYqWvVbQJLC7hQJWtFxbgLuaQLwGhN+8Bsa0VD5d+AZ9chS
	 GUzMka3HM6uRNT8X7W5yHOosoi//MMlaNUZFSlJ1QOxyEcrWHQ8vnZ4z/hZf7ae9r
	 B8eLzpdl5pCjjJErSyXqBOLTEDtgN4+5z6hlhDdxiNyj9rKAEz02LcGH3d2jxowtd
	 2ASzEwCBl/trrP7+23+M0XE/I96WrFj5JN0ik7WOTWF0RH0e43S+WDtqhapmK5UWp
	 J+bzaj4mT8UdEiZibwxFYF3xUnMdVA6vHKbwTvwQnZ670DvefRRmZIj1pbrdirSJF
	 SE0Oy7gK+WAaC+EN5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bfq-1rs8kf1lx0-013G6c; Tue, 24
 Sep 2024 23:16:03 +0200
Message-ID: <4c15c43e-a706-4389-8b61-3535e273ba56@gmx.com>
Date: Wed, 25 Sep 2024 06:46:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: canonicalize the device path before adding it
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Fabian Vogt <fvogt@suse.com>
References: <cover.1727154543.git.wqu@suse.com>
 <c6408ea85cd10e4042df528708dd9c2ec1db78c0.1727154543.git.wqu@suse.com>
 <CAL3q7H7aL-M3dyu7f7w1bBb5zUP00KMp=F-jWV-Q0hZH6LD=yw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7aL-M3dyu7f7w1bBb5zUP00KMp=F-jWV-Q0hZH6LD=yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GBTvfHGdA0RsKlNcCdrQIAlEwJsqwsfy3dfsvLEs2Erb8M3wDMy
 x7ZvIQSxFeeZpfd6llWYp7I3XkgNfxhzan7edJ5g8kJW2PCvrf16q9oPV2dHcs9Tzpm0dOS
 P7qZlArnXJBO60E1JPX87mAALJEos6T5ETjfcvDMtOOhn8HkwZK6C4W7nIKoN/VOMitFcgG
 aJnl97/3bEKM7rnYtj7eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KwWFAFtSpjA=;+BQS22H7PpFFGfoUj7xRjl3HPa+
 68LaqoWa4vgYX56NhhL5ZsUKSiFcz4yjjDY23zCStJjVlEDrx1cxDQ+mDf0W4WP9M7x/P142I
 kiN51ViyuHdOegmRbqKrcV+BX3pkk45yOyoK1LiunK8BaNj+C825sfXRNOuOA0plKbD8fAsbj
 hE5rvcB0AD/4kguUUWj0IQfBI7pajtSFzNBz6uW77KH6/2RaWa0VCNNjHi36iMyPUVae9GXOb
 Vk1K0+MR/s9gBqlTg5rZNvTxn/lFCuMJS2ZqvXcq+ob5cXqYVATK2HcZpMav0yo3aVT77LRia
 9WV7mIk5LAWqUdP9ZCop1gO4+BIkAyIQ6yWgNyKKcPpn1laxDKBKmNR7xTQkodOU/7wCTZAgw
 6kjmc7e0KqHOcM3ZhweHPoDlt/cB43IPPBW7kqDVJjpPHNxqzkXLMPNGdZhtUj3dhQg+/Aojd
 pU8iRqUVrozVW9TLtJbZ0iNOpB5aHU5d0nzgA+Asz1rdrzeQngw09QDewpV+5nVEtnH3nG72I
 vn/SqIGNfrHQRlvJKJI1XcTWMc0HXvYUYHa5vNRQfx50/eAJV5DTeheZ5fsK5tlBqrOXnlGPG
 ph14skLoJl5NSK+IJPE52acpJ3b/ELRy48iWVhTYTzkhmYm02rJJNtGPRym10icaPWtY0cdrf
 6l66xQ5YMfolG4TloEjsNdf6P3sRVUJG8eYKw91TyTO6aNyIxI2kiR34eSiXKZQriCEvX99f0
 srsPw2CJf3ckq479NjuU+ivPHuGNvYVnT+mJqy2GWezlTVLEdJT3gNNtP72GhNe+M3svBDSDp
 Rq108z8FgiV7fgeOI/fzoWep4XgUTVRh3Ccijr8g5Zv/A=



=E5=9C=A8 2024/9/24 21:42, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Sep 24, 2024 at 6:18=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [PROBLEM]
>> Currently btrfs accepts any file path for its device, resulting some
>> weird situation:
>>
>>   # ./mount_by_fd /dev/test/scratch1  /mnt/btrfs/
>>
>> The program has the following source code:
>>
>>   #include <fcntl.h>
>>   #include <stdio.h>
>>   #include <sys/mount.h>
>>
>>   int main(int argc, char *argv[]) {
>>          int fd =3D open(argv[1], O_RDWR);
>>          char path[256];
>>          snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
>>          return mount(path, argv[2], "btrfs", 0, NULL);
>>   }
>>
>> Then we can have the following weird device path:
>>
>>   BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 trans=
id 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (18440)
>>
>> Normally it's not a big deal, and later udev can trigger a device path
>> rename. But if udev didn't trigger, the device path "/proc/self/fd/3"
>> will show up in mtab.
>>
>> [CAUSE]
>> For filename "/proc/self/fd/3", it means the opened file descriptor 3.
>> In above case, it's exactly the device we want to open, aka points to
>> "/dev/test/scratch1" which is another softlink pointing to "/dev/dm-2".
>>
>> Inside btrfs we solve the path using LOOKUP_FOLLOW, which follows the
>> symbolic link and grab the proper block device.
>>
>> But we also save the filename into btrfs_device::name, still resulting
>> the weird path.
>>
>> [FIX]
>> Instead of unconditionally trust the path, check if the original file
>> (not following the symbolic link) is inside "/dev/", if not, then
>> manually lookup the path to its final destination, and use that as our
>> device path.
>>
>> This allows us to still use symbolic links, like
>> "/dev/mapper/test-scratch" from LVM2, which is required for fstests run=
s
>> with LVM2 setup.
>>
>> And for really weird names, like the above case, we solve it to
>> "/dev/dm-2" instead.
>>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1230641
>> Reported-by: Fabian Vogt <fvogt@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 79 +++++++++++++++++++++++++++++++++++++++++++++=
-
>>   1 file changed, 78 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index b713e4ebb362..8acb3c465783 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_sup=
er_block *sb)
>>          return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>>   }
>>
>> +/*
>> + * We can have very wide soft links passed in.
>
> Wide? Did you mean wild in the sense of unusual?

My bad, I mean "weird".

>
>> + * One example is "/proc/<uid>/fd/<fd>", which can be a soft link to
>> + * a proper block device.
>> + *
>> + * But it's never a good idea to use those weird names.
>> + * Here we check if the path (not following symlinks) is a good one in=
side
>> + * "/dev/".
>> + */
>> +static bool is_good_dev_path(const char *dev_path)
>> +{
>> +       struct path path =3D { .mnt =3D NULL, .dentry =3D NULL };
>> +       char *path_buf =3D NULL;
>> +       char *resolved_path;
>> +       bool is_good =3D false;
>> +       int ret;
>> +
>> +       path_buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
>> +       if (!path_buf)
>> +               goto out;
>> +
>> +       /*
>> +        * Do not follow soft link, just check if the original path is =
inside
>> +        * "/dev/".
>> +        */
>> +       ret =3D kern_path(dev_path, 0, &path);
>> +       if (ret)
>> +               goto out;
>> +       resolved_path =3D d_path(&path, path_buf, PATH_MAX);
>> +       if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
>> +               goto out;
>> +       is_good =3D true;
>> +out:
>> +       kfree(path_buf);
>> +       path_put(&path);
>> +       return is_good;
>> +}
>> +
>> +static int get_canonical_dev_path(const char *dev_path, char *canonica=
l)
>> +{
>> +       struct path path =3D { .mnt =3D NULL, .dentry =3D NULL };
>> +       char *path_buf =3D NULL;
>> +       char *resolved_path;
>> +       int ret;
>> +
>> +       path_buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
>> +       if (!path_buf) {
>> +               ret =3D -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       ret =3D kern_path(dev_path, LOOKUP_FOLLOW, &path);
>> +       if (ret) {
>> +               pr_info("path lookup failed for %s: %d\n", dev_path, re=
t);
>
> Why not btrfs_info(), or better yet, btrfs_warn()?

Oh, it's some debug code not removed.

In fact there should be no need to output anything.
We can always fallback to the super weird name.

>
> It accepts a NULL fs_info argument and allows for a more standardized
> btrfs message, with a proper prefix, etc.
>
>
>> +               goto out;
>> +       }
>> +       resolved_path =3D d_path(&path, path_buf, PATH_MAX);
>> +       strncpy(canonical, resolved_path, PATH_MAX - 1);
>
> Please don't use strncpy(). This is strongly discouraged due to
> security issues, see:
>
> https://github.com/KSPP/linux/issues/90
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-o=
n-nul-terminated-strings

Thanks a lot for pointing to this.

Thanks,
Qu
>
>> +out:
>> +       kfree(path_buf);
>> +       path_put(&path);
>> +       return ret;
>> +}
>> +
>>   static bool is_same_device(struct btrfs_device *device, const char *n=
ew_path)
>>   {
>>          struct path old =3D { .mnt =3D NULL, .dentry =3D NULL };
>> @@ -1408,12 +1472,23 @@ struct btrfs_device *btrfs_scan_one_device(cons=
t char *path, blk_mode_t flags,
>>          bool new_device_added =3D false;
>>          struct btrfs_device *device =3D NULL;
>>          struct file *bdev_file;
>> +       char *canonical_path =3D NULL;
>>          u64 bytenr;
>>          dev_t devt;
>>          int ret;
>>
>>          lockdep_assert_held(&uuid_mutex);
>>
>> +       if (!is_good_dev_path(path)) {
>> +               canonical_path =3D kmalloc(PATH_MAX, GFP_KERNEL);
>> +               if (canonical_path) {
>> +                       ret =3D get_canonical_dev_path(path, canonical_=
path);
>> +                       if (ret < 0) {
>> +                               kfree(canonical_path);
>> +                               canonical_path =3D NULL;
>> +                       }
>> +               }
>> +       }
>>          /*
>>           * Avoid an exclusive open here, as the systemd-udev may initi=
ate the
>>           * device scan which may race with the user's mount or mkfs co=
mmand,
>> @@ -1458,7 +1533,8 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, blk_mode_t flags,
>>                  goto free_disk_super;
>>          }
>>
>> -       device =3D device_list_add(path, disk_super, &new_device_added)=
;
>> +       device =3D device_list_add(canonical_path ? canonical_path : pa=
th,
>
> Can use the shortcut:    canonical_path ?: path
>
> The rest looks fine, thanks.
>
>
>> +                                disk_super, &new_device_added);
>>          if (!IS_ERR(device) && new_device_added)
>>                  btrfs_free_stale_devices(device->devt, device);
>>
>> @@ -1467,6 +1543,7 @@ struct btrfs_device *btrfs_scan_one_device(const =
char *path, blk_mode_t flags,
>>
>>   error_bdev_put:
>>          fput(bdev_file);
>> +       kfree(canonical_path);
>>
>>          return device;
>>   }
>> --
>> 2.46.1
>>
>>
>


