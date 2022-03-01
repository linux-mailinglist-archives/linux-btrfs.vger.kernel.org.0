Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7391C4C93A5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 19:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiCAS45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 13:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiCAS45 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 13:56:57 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Mar 2022 10:56:14 PST
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322860CDB
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 10:56:14 -0800 (PST)
Received: from [192.168.1.27] ([78.12.27.75])
        by smtp-17.iol.local with ESMTPA
        id P7eNnAmE4PSXeP7eOnKpiD; Tue, 01 Mar 2022 19:55:11 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1646160911; bh=ALSq0uJ2oXjNo6OrSd7z0/xokSqk4UoHmQ3aEzsXyoQ=;
        h=From;
        b=Fjne9j2mGPOVhq78h1Oz+kviutjnWQzkPZw8ozIpZGP5NYH8EQHRpWSrARmODMeVV
         5a+k29kAv33z/4bVdXCb9fK2qErX0qMEoEkPOKgzvELcMPQDOoQdM5p04twalSk2Rr
         ad6IISB+wweNX3ZrQ5KxkZScylJwETbEXSs9QvrpwgbnAbgsxFy7yTE5NGErZL1F9x
         tKDZzcEQQg1MJYO70CzEqaV/RvWyVg/A50mYZRW+kgmlFDlnJBGats+sU9CQbNEB4t
         LH0sIi2/bjpqmLobk0mFTkhYS3RstNHSje02bNBaf/zp/xt4eAk9sliXVNxlG0AbjO
         QWxeExWVtUehw==
X-CNFS-Analysis: v=2.4 cv=SMyH6MjH c=1 sm=1 tr=0 ts=621e6c0f cx=a_exe
 a=aCiYQ2Po16U8px2wfyNKfg==:117 a=aCiYQ2Po16U8px2wfyNKfg==:17
 a=IkcTkHD0fZMA:10 a=jQOAGkExK5hwufOmteUA:9 a=QEXdDO2ut3YA:10
Message-ID: <e8d1a33a-a75a-1a25-b788-a2da5019e6c4@inwind.it>
Date:   Tue, 1 Mar 2022 19:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
 <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
 <Yh42nDUquZIqVMC0@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <Yh42nDUquZIqVMC0@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMa8KSTxVkCywEJ8ueOEbjbevnnKXCk6ixm6RdYKF46J6WON7JRNk7dcK1lmky9dMzuxV+Q577ApFamt81yTB6vJteIN01KP+Ay8yOVTR3q9Qb1HVlc1
 Qs6xu3WfaSZqdpg3YoiiSsjOUposdscE/TVU6iCY29Lw4KAdgGZgQvTsNutXM6AvYwZTyVg9gOnVwsxD3CPMaVka8pxMsIWWONfC+Af1vVIIDgtE2k+Kexsy
 IrFGdI7b3TADC9Bc1ww3DjNfl5iLxQdfkfN7SCqvUMeyUkeGw3F/CaxI1TNa7H3ifO4l6u0xjQzvbGEAETfcEPw76gLT1bacXy+SFu6fX88MycGq9Q3PnSfW
 awk0KKJr13Df/Z+iV56NwN4ReRN1pg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2022 16.07, Josef Bacik wrote:
> On Mon, Feb 28, 2022 at 10:01:35PM +0100, Goffredo Baroncelli wrote:
>> Hi Josef,
>>
>> On 28/02/2022 18.04, Josef Bacik wrote:
>>> On Wed, Jan 26, 2022 at 09:32:07PM +0100, Goffredo Baroncelli wrote:
>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>
>>>> Hi all,
>>>>
>> [...
>>
>>>> In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
>>>> to help the detection of the allocation_hint feature.
>>>>
>>>
>>> Sorry Goffredo I dropped the ball on this, lets try and get this shit nailed
>>> down and done so we can get it merged.  The code overall looks good, I just have
>>> two things I want changed
>>>
>>> 1. The sysfs file should use a string, not a magic number.  Think how
>>>      /sys/block/<dev>/queue/scheduler works.  You echo "metadata_only" >
>>>      allocation_hint, you cat allocation_hint and it says "none" or
>>>      "metadata_only".  If you want to be fancy you can do exactly like
>>>      queue/scheduler and show the list of options with [] around the selected
>>>      option.
>>
>> Ok.
>>>
>>> 2. I hate the major_minor thing, can you do similar to what we do for devices/
>>>      and symlink the correct device sysfs directory under devid?
>>>
>> Ok, do you have any suggestion for the name ? what about bdev ?
>>
> 
> You literally just add a link to the device kobj to the devid kobj.  If you look
> at btrfs_sysfs_add_device(), you would do something like this (completely
> untested and uncompiled)

I will give an eye to your code; thanks. However my question was more basic.

Now we have:

.../btrfs/<uuid>/devinfo/<dev-nr>/major_minor

with the link, as you suggested, I think that we will have:

.../btrfs/<uuid>/devinfo/<dev-nr>/bdev -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
                                   ^^^^

(notice 'bdev', which is the name that I asked)

looking at your patch, it seems to me that the link will be named like the device name:

.../btrfs/<uuid>/devinfo/<dev-nr>/sdg3 -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
                                   ^^^^

which is quite convoluted as approach, because the code has to find a name that matches a device (sdg3), instead to look for a fixed name (bdev).

Because I know that every people has a strong, valid (and above all different !) opinion about the name, I want to ask it before issue another patches set.
For the record, I like 'bdev' only because I saw used (by bcache)

IMHO, the btrfs world had been simpler if devices/ sysfs directory was populated by the btrfs-dev-nr instead the device name



> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 17389a42a3ab..cc570078bf7d 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1450,8 +1450,10 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device)
>          devices_kobj = device->fs_info->fs_devices->devices_kobj;
>          ASSERT(devices_kobj);
>   
> -       if (device->bdev)
> +       if (device->bdev) {
>                  sysfs_remove_link(devices_kobj, bdev_kobj(device->bdev)->name);
> +               sysfs_remove_link(&device->devid_kobj, bdev_kobj(device->bdev)->name);
> +       }
>   
>          if (device->devid_kobj.state_initialized) {
>                  kobject_del(&device->devid_kobj);
> @@ -1628,10 +1630,23 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
>   
>          nofs_flag = memalloc_nofs_save();
>   
> +       init_completion(&device->kobj_unregister);
> +       ret = kobject_init_and_add(&device->devid_kobj, &devid_ktype,
> +                                  devinfo_kobj, "%llu", device->devid);
> +       if (ret) {
> +               kobject_put(&device->devid_kobj);
> +               btrfs_warn(device->fs_info,
> +                          "devinfo init for devid %llu failed: %d",
> +                          device->devid, ret);
> +       }
> +
>          if (device->bdev) {
>                  struct kobject *disk_kobj = bdev_kobj(device->bdev);
>   
>                  ret = sysfs_create_link(devices_kobj, disk_kobj, disk_kobj->name);
> +               if (!ret)
> +                       ret = sysfs_create_link(device->devid_kobj, disk_kobj,
> +                                               disk_kobj->name);
>                  if (ret) {
>                          btrfs_warn(device->fs_info,
>                                  "creating sysfs device link for devid %llu failed: %d",
> @@ -1640,16 +1655,6 @@ int btrfs_sysfs_add_device(struct btrfs_device *device)
>                  }
>          }
>   
> -       init_completion(&device->kobj_unregister);
> -       ret = kobject_init_and_add(&device->devid_kobj, &devid_ktype,
> -                                  devinfo_kobj, "%llu", device->devid);
> -       if (ret) {
> -               kobject_put(&device->devid_kobj);
> -               btrfs_warn(device->fs_info,
> -                          "devinfo init for devid %llu failed: %d",
> -                          device->devid, ret);
> -       }
> -
>   out:
>          memalloc_nofs_restore(nofs_flag);
>          return ret;
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
