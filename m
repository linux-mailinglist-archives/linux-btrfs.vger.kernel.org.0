Return-Path: <linux-btrfs+bounces-8323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17779989A23
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 07:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398BF1C21136
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 05:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB513D281;
	Mon, 30 Sep 2024 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T/rDSI0T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3101B815
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674281; cv=none; b=KbqeyBbP0+InmEBZcF4AiAXema2VdxTmDAeGxWwooizV9JWpB/jDA9Ze7k0g3x982JDx6Uu34+3psY8rG1OnlQ0lQydqkglA4Ip7R4yT8hP7oLZ1Nv/62FIQRUMeQeAbpi/6IbdsKdAArQ+22siuJVNpa/Zu8EY6+YI81Itxu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674281; c=relaxed/simple;
	bh=7CIrMej7ZDRT8dMlCc4svKdSQFAcDojDd6ghdFe5wmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hV93gKM4nGIT0xF+4YV9mOE1GhIwrx3B912zat6+VYfbCuWex53eozbuUMvbnbVzySToJdJcG/lo5/1gdHOHLw3M4AlI5K3aGOw98Qlx+l4T0KggBJMHbXykECTOngc7QWMRzA6NBeX3/lpSbkHwGbq2kTU7rnaa1Q29ShsUNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T/rDSI0T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so2778985e9.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Sep 2024 22:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727674277; x=1728279077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DC6pZk/RKUUC4y2/pn1yNsoMHqFD1oSXEc7/MIhfwWE=;
        b=T/rDSI0TN3q36pb2P9zXCVc8J6lNN9rIzU//W87lgwacALaLvA+hj1MJhVxhQVZMe+
         wv1+4d6H2RnZotG4BVQ2Qaw4LAlD3D4a9oPmaCHKesmyeu+iPRevOzS9RQMr2Mnk2F+j
         n+FtOMG4hUyuCcbl18zPAsj0xfUAryOY/GtUU/DIQvvhxnrxFL434ZNZjNLA1PXLy5Np
         fVTaB6IZyx9cRMy6zta+WtuLQwQykCQmF6YpfgL+RowejjCR+SPCrfvVYKyHql3i6yw7
         IBEPLJ4N7B+ut92EOVuoqeEvuOpD08u+8si/By3n8ajhGb3+6SN004KsId/DPO/U0ggh
         YGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727674277; x=1728279077;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC6pZk/RKUUC4y2/pn1yNsoMHqFD1oSXEc7/MIhfwWE=;
        b=t2lSlfGiOvKm+2ngof1YcIbaPVRR4iz3Jr5uxpbV4E4ff1M4ZkqZwIyGNJcx0mcHYm
         TqUHv0nROm7ZObBUt2dC978zUtn4bQNpV296yReWtZKrqXJROeePZrwFRKCd40JbrIqX
         a1OGapc9SeC3oxorOjQmfo8LbohWgFuZrCcZaYN5wShjhT+AJkdIk+umNdye+cLQT+ja
         Qm6/d3nCE0NZT9sVbIkrt6IZce4tph7Zy7JMROfT5v16L7tAdtaDdGXksOE1f9I82ypy
         +biT5qZX5ZU7NL+YyExIA5arBA7zVdNdW/NvD/7rnDC90mJ+DkDrPRpKbzXUOnwoSdcf
         1k7A==
X-Forwarded-Encrypted: i=1; AJvYcCUr3Xh/VvRiBLCYulLVty7C/l8W9Kf0UUCrtn5WMJadO55ybfdefhXQ35mdOx9vs8R9umkj7ykC8QCoHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jOD3urHu5r8RlRIU6Uxl3VAM+lSy2WUtJgVci2S9oRNdesA9
	NkqtYCf8GgBCm3L96QkdispxJHMLfIry9L5JojVc5lwstm4fpgxMsKe3f8S1qJs=
X-Google-Smtp-Source: AGHT+IHeWNNPUU/3jmZcmfqMLuJcz0goTSCI9bBYLD1w1cXzsgvX6qvQG/zsZceMiib1/xRjBkhhGw==
X-Received: by 2002:adf:ab08:0:b0:37c:cd8a:50e3 with SMTP id ffacd0b85a97d-37cd5ab7109mr5661346f8f.13.1727674277003;
        Sun, 29 Sep 2024 22:31:17 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d5ef28sm47514945ad.50.2024.09.29.22.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 22:31:16 -0700 (PDT)
Message-ID: <97e23756-2740-45ea-a1d6-7cf95a115e8b@suse.com>
Date: Mon, 30 Sep 2024 15:01:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: canonicalize the device path before adding
 it
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: Fabian Vogt <fvogt@suse.com>
References: <cover.1727222308.git.wqu@suse.com>
 <3b0eb4cd4b55ae567abfc849935b4a72cea88efb.1727222308.git.wqu@suse.com>
 <af8014ff-d4c2-4f43-8602-49d11d4977fa@oracle.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <af8014ff-d4c2-4f43-8602-49d11d4977fa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/30 14:56, Anand Jain 写道:
> On 25/9/24 5:36 am, Qu Wenruo wrote:
>> [PROBLEM]
>> Currently btrfs accepts any file path for its device, resulting some
>> weird situation:
>>
> 
> 
>>   # ./mount_by_fd /dev/test/scratch1  /mnt/btrfs/
>>
>> The program has the following source code:
>>
>>   #include <fcntl.h>
>>   #include <stdio.h>
>>   #include <sys/mount.h>
>>
>>   int main(int argc, char *argv[]) {
>>     int fd = open(argv[1], O_RDWR);
>>     char path[256];
>>     snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
>>     return mount(path, argv[2], "btrfs", 0, NULL);
>>   }
>>
> 
> Sorry for the late comments. Patches look good.
> 
> Quick question: both XFS and ext4 fail this test case—any idea why?

Because they are single device filesystems (except the log device), thus 
they do not need to nor are able to update their device path halfway.

> Can a generic/btrfs specific testcase be added to fstests?

I can add it as a btrfs specific one, but I guess not a generic one?

Thanks,
Qu

> 
> Thanks, Anand
> 
>> Then we can have the following weird device path:
>>
>>   BTRFS: device fsid 2378be81-fe12-46d2-a9e8-68cf08dd98d5 devid 1 
>> transid 7 /proc/self/fd/3 (253:2) scanned by mount_by_fd (18440)
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
>> Inside kernel we solve the mount source using LOOKUP_FOLLOW, which
>> follows the symbolic link and grab the proper block device.
>>
>> But inside btrfs we also save the filename into btrfs_device::name, and
>> utilize that member to report our mount source, which leads to the above
>> situation.
>>
>> [FIX]
>> Instead of unconditionally trust the path, check if the original file
>> (not following the symbolic link) is inside "/dev/", if not, then
>> manually lookup the path to its final destination, and use that as our
>> device path.
>>
>> This allows us to still use symbolic links, like
>> "/dev/mapper/test-scratch" from LVM2, which is required for fstests runs
>> with LVM2 setup.
>>
>> And for really weird names, like the above case, we solve it to
>> "/dev/dm-2" instead.
>>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1230641
>> Reported-by: Fabian Vogt <fvogt@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/volumes.c | 79 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 78 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index b713e4ebb362..668138451f7c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -732,6 +732,70 @@ const u8 *btrfs_sb_fsid_ptr(const struct 
>> btrfs_super_block *sb)
>>       return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>>   }
>> +/*
>> + * We can have very weird soft links passed in.
>> + * One example is "/proc/self/fd/<fd>", which can be a soft link to
>> + * a block device.
>> + *
>> + * But it's never a good idea to use those weird names.
>> + * Here we check if the path (not following symlinks) is a good one 
>> inside
>> + * "/dev/".
>> + */
>> +static bool is_good_dev_path(const char *dev_path)
>> +{
>> +    struct path path = { .mnt = NULL, .dentry = NULL };
>> +    char *path_buf = NULL;
>> +    char *resolved_path;
>> +    bool is_good = false;
>> +    int ret;
>> +
>> +    path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +    if (!path_buf)
>> +        goto out;
>> +
>> +    /*
>> +     * Do not follow soft link, just check if the original path is 
>> inside
>> +     * "/dev/".
>> +     */
>> +    ret = kern_path(dev_path, 0, &path);
>> +    if (ret)
>> +        goto out;
>> +    resolved_path = d_path(&path, path_buf, PATH_MAX);
>> +    if (IS_ERR(resolved_path))
>> +        goto out;
>> +    if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
>> +        goto out;
>> +    is_good = true;
>> +out:
>> +    kfree(path_buf);
>> +    path_put(&path);
>> +    return is_good;
>> +}
>> +
>> +static int get_canonical_dev_path(const char *dev_path, char *canonical)
>> +{
>> +    struct path path = { .mnt = NULL, .dentry = NULL };
>> +    char *path_buf = NULL;
>> +    char *resolved_path;
>> +    int ret;
>> +
>> +    path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +    if (!path_buf) {
>> +        ret = -ENOMEM;
>> +        goto out;
>> +    }
>> +
>> +    ret = kern_path(dev_path, LOOKUP_FOLLOW, &path);
>> +    if (ret)
>> +        goto out;
>> +    resolved_path = d_path(&path, path_buf, PATH_MAX);
>> +    ret = strscpy(canonical, resolved_path, PATH_MAX);
>> +out:
>> +    kfree(path_buf);
>> +    path_put(&path);
>> +    return ret;
>> +}
>> +
>>   static bool is_same_device(struct btrfs_device *device, const char 
>> *new_path)
>>   {
>>       struct path old = { .mnt = NULL, .dentry = NULL };
>> @@ -1408,12 +1472,23 @@ struct btrfs_device 
>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>       bool new_device_added = false;
>>       struct btrfs_device *device = NULL;
>>       struct file *bdev_file;
>> +    char *canonical_path = NULL;
>>       u64 bytenr;
>>       dev_t devt;
>>       int ret;
>>       lockdep_assert_held(&uuid_mutex);
>> +    if (!is_good_dev_path(path)) {
>> +        canonical_path = kmalloc(PATH_MAX, GFP_KERNEL);
>> +        if (canonical_path) {
>> +            ret = get_canonical_dev_path(path, canonical_path);
>> +            if (ret < 0) {
>> +                kfree(canonical_path);
>> +                canonical_path = NULL;
>> +            }
>> +        }
>> +    }
>>       /*
>>        * Avoid an exclusive open here, as the systemd-udev may 
>> initiate the
>>        * device scan which may race with the user's mount or mkfs 
>> command,
>> @@ -1458,7 +1533,8 @@ struct btrfs_device *btrfs_scan_one_device(const 
>> char *path, blk_mode_t flags,
>>           goto free_disk_super;
>>       }
>> -    device = device_list_add(path, disk_super, &new_device_added);
>> +    device = device_list_add(canonical_path ? : path, disk_super,
>> +                 &new_device_added);
>>       if (!IS_ERR(device) && new_device_added)
>>           btrfs_free_stale_devices(device->devt, device);
>> @@ -1467,6 +1543,7 @@ struct btrfs_device *btrfs_scan_one_device(const 
>> char *path, blk_mode_t flags,
>>   error_bdev_put:
>>       fput(bdev_file);
>> +    kfree(canonical_path);
>>       return device;
>>   }
> 


