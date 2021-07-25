Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707DA3D4C5E
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 08:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhGYFj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 01:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFj2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 01:39:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3883DC061757;
        Sat, 24 Jul 2021 23:19:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n10so266789plc.2;
        Sat, 24 Jul 2021 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5yDM229yNO4FMxdb7dwYLFirB4+FBvYJjOIDRQxk/Cc=;
        b=h3F0BeXYlOP4WTv6Kb5n6O+Jum9MOc5kZie2OxbkuO3iYS0QVBwrxPEdPXtQ8ABT7K
         HhmJkuonP1SN7NgHDpOWzFQYL9ZZ1IvFKFq9ipwYBcLZe7ewKPMnvbMc0DNYkMUZLobw
         CVkDvvsMncmoJRqOpBQoLlHvcKNd5GaS+QqDjQY/QTrY4x2WxrGlZ7qbZkK+qoLGdaDZ
         UqpgypA3ySCqNxgZD4tpM7bH/JACxcgMoYDSZx4+lsEVieMlFbQIK/1NNwS7uPlpmVF2
         unq8PAD8jz5T7Gt8c8p3o5AYuEp46ZcAY2kzVk0UWvJkTQJvwyistGm4hNXND5j0Na3s
         KaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yDM229yNO4FMxdb7dwYLFirB4+FBvYJjOIDRQxk/Cc=;
        b=czU4fj1sU0wN1u3JsRP1tZejrDLdcGdhryVGDJ8MF4DeQ7QEfQsvwH5c9ruCq9vGSK
         1jb/vq+PZNK6yqzO9hU44x1fMOG3zmqpKpxHdWkhl7u7+BCYI8VaQG9jm/EsDlvFQ9vv
         c76Lrwi+V1DO8A3sAFilcf8z6UofwNaeEj4VSQXbjSkxdzQAypLI6FQ3GCgoUduOTbQn
         BXX1xTy50wpkOjarAKIrl+6uGGJoZhbeA8ecYRqbkX/vYWn86Jcx/xlBM4njas5ULkHW
         /Ldqy55B9R4qtGQ6Ev+NKS/YO7HVwfSMqiLgaFLXmtN8r2tmrZaawLNYgwJ/9N3And0o
         y+Hg==
X-Gm-Message-State: AOAM532r31aXGrz0K7MpcFIdSUQ3s6SbKSnWwOWgK6F1A5eU4nEzQJfn
        HxKI4c43K22E17EWwmUbxJQ=
X-Google-Smtp-Source: ABdhPJwKpWDg+QUDLNjSAlISCC6Nynf1fAnEo7wHYEheWFlCKMokM7k6e8PbgtTg2hcxq5LodYjC5Q==
X-Received: by 2002:aa7:8683:0:b029:32e:2a35:941e with SMTP id d3-20020aa786830000b029032e2a35941emr12113330pfo.44.1627193997717;
        Sat, 24 Jul 2021 23:19:57 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id w18sm35874120pjg.50.2021.07.24.23.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 23:19:57 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
 <20210721175938.GP19710@twin.jikos.cz>
Message-ID: <9119934f-fb61-3b55-655c-9a7552e0b30b@gmail.com>
Date:   Sun, 25 Jul 2021 14:19:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721175938.GP19710@twin.jikos.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/7/21 1:59 am, David Sterba wrote:
> On Thu, Jul 15, 2021 at 06:34:03PM +0800, Desmond Cheong Zhi Xi wrote:
>> Syzbot reports a warning in close_fs_devices that happens because
>> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
>> on each device.
>>
>> This happens when a writeable device is removed in
>> __btrfs_free_extra_devids, but the rw device count is not decremented
>> accordingly. So when close_fs_devices is called, the removed device is
>> still counted and we get an off by 1 error.
>>
>> Here is one call trace that was observed:
>>    btrfs_mount_root():
>>      btrfs_scan_one_device():
>>        device_list_add();   <---------------- device added
>>      btrfs_open_devices():
>>        open_fs_devices():
>>          btrfs_open_one_device();   <-------- rw device count ++
>>      btrfs_fill_super():
>>        open_ctree():
>>          btrfs_free_extra_devids():
>> 	  __btrfs_free_extra_devids();  <--- device removed
>> 	  fail_tree_roots:
>> 	    btrfs_close_devices():
>> 	      close_fs_devices();   <------- rw device count off by 1
>>
>> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> 
> What this patch did in the last hunk was the rw_devices decrement, but
> conditional:
> 
> @@ -1080,9 +1071,6 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>                  if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>                          list_del_init(&device->dev_alloc_list);
>                          clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> -                       if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> -                                     &device->dev_state))
> -                               fs_devices->rw_devices--;
>                  }
>                  list_del_init(&device->dev_list);
>                  fs_devices->num_devices--;
> ---
> 
> 
>> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>>   		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>>   			list_del_init(&device->dev_alloc_list);
>>   			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>> +			fs_devices->rw_devices--;
>>   		}
>>   		list_del_init(&device->dev_list);
>>   		fs_devices->num_devices--;
> 
> So should it be reinstated in the original form? The rest of
> cf89af146b7e handles unexpected device replace item during mount.
> 
> Adding the decrement is correct, but right now I'm not sure about the
> corner case when teh devcie has the BTRFS_DEV_STATE_REPLACE_TGT bit set.
> The state machine of the device bits and counters is not trivial so
> fixing it one way or the other could lead to further syzbot reports if
> we don't understand the issue.
> 

Hi David,

Thanks for raising this issue. I took a closer look and I think we don't 
have to reinstate the original form because it's a historical artifact.

The short version of the story is that going by the intention of 
__btrfs_free_extra_devids, we skip removing the replace target device. 
Hence, by the time we've reached the decrement in question, the device 
is not the replace target device and the BTRFS_DEV_STATE_REPLACE_TGT bit 
should not be set.

But we should also try to understand the original intention of the code. 
The check in question was first introduced in commit 8dabb7420f01 
("Btrfs: change core code of btrfs to support the device replace 
operations"):
> @@ -536,7 +553,8 @@ void btrfs_close_extra_devices(struct btrfs_fs_devices *fs_devices)
>                 if (device->writeable) {
>                         list_del_init(&device->dev_alloc_list);
>                         device->writeable = 0;
> -                       fs_devices->rw_devices--;
> +                       if (!device->is_tgtdev_for_dev_replace)
> +                               fs_devices->rw_devices--;
>                 }
>                 list_del_init(&device->dev_list);
>                 fs_devices->num_devices--;

If we take a trip back in time to this commit we see that 
btrfs_dev_replace_finishing added the target device to the alloc list 
without incrementing the rw_devices count. So this check was likely 
originally meant to prevent under-counting of rw_devices.

However, the situation has changed, following various fixes to 
rw_devices counting. Commit 63dd86fa79db ("btrfs: fix rw_devices miss 
match after seed replace") added an increment to rw_devices when 
replacing a seed device with a writable one in btrfs_dev_replace_finishing:
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index eea26e1b2fda..fb0a7fa2f70c 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -562,6 +562,8 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>         if (fs_info->fs_devices->latest_bdev == src_device->bdev)
>                 fs_info->fs_devices->latest_bdev = tgt_device->bdev;
>         list_add(&tgt_device->dev_alloc_list, &fs_info->fs_devices->alloc_list);
> +       if (src_device->fs_devices->seeding)
> +               fs_info->fs_devices->rw_devices++;
>  
>         /* replace the sysfs entry */
>         btrfs_kobj_rm_device(fs_info, src_device);

This was later simplified in commit 82372bc816d7 ("Btrfs: make the logic 
of source device removing more clear") that simply decremented 
rw_devices in btrfs_rm_dev_replace_srcdev if the replaced device was 
writable. This meant that the rw_devices count could be incremented in 
btrfs_dev_replace_finishing without any checks:
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index e9cbbdb72978..6f662b34ba0e 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -569,8 +569,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>         if (fs_info->fs_devices->latest_bdev == src_device->bdev)
>                 fs_info->fs_devices->latest_bdev = tgt_device->bdev;
>         list_add(&tgt_device->dev_alloc_list, &fs_info->fs_devices->alloc_list);
> -       if (src_device->fs_devices->seeding)
> -               fs_info->fs_devices->rw_devices++;
> +       fs_info->fs_devices->rw_devices++;
>  
>         /* replace the sysfs entry */
>         btrfs_kobj_rm_device(fs_info, src_device);

Thus, given the current state of the code base, the original check is 
now incorrect, because we want to decrement rw_devices as long as the 
device is being removed from the alloc list.

To further convince ourselves of this, we can take a closer look at the 
relation between the device with devid BTRFS_DEV_REPLACE_DEVID and the 
BTRFS_DEV_STATE_REPLACE_TGT bit for devices.

BTRFS_DEV_STATE_REPLACE_TGT is set in two places:
- btrfs_init_dev_replace_tgtdev
- btrfs_init_dev_replace

In btrfs_init_dev_replace_tgtdev, the BTRFS_DEV_STATE_REPLACE_TGT bit is 
set for a device allocated with devid BTRFS_DEV_REPLACE_DEVID.

In btrfs_init_dev_replace, the BTRFS_DEV_STATE_REPLACE_TGT bit is set 
for the target device found with devid BTRFS_DEV_REPLACE_DEVID.

 From both cases, we see that the BTRFS_DEV_STATE_REPLACE_TGT bit is set 
only for the device with devid BTRFS_DEV_REPLACE_DEVID.

It follows that if a device does not have devid BTRFS_DEV_REPLACE_DEVID, 
then the BTRFS_DEV_STATE_REPLACE_TGT bit will not be set.

With commit cf89af146b7e ("btrfs: dev-replace: fail mount if we don't 
have replace item with target device"), we skip removing the device in 
__btrfs_free_extra_devids as long as the devid is BTRFS_DEV_REPLACE_DEVID:
> -               if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
> -                       /*
> -                        * In the first step, keep the device which has
> -                        * the correct fsid and the devid that is used
> -                        * for the dev_replace procedure.
> -                        * In the second step, the dev_replace state is
> -                        * read from the device tree and it is known
> -                        * whether the procedure is really active or
> -                        * not, which means whether this device is
> -                        * used or whether it should be removed.
> -                        */
> -                       if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> -                                                 &device->dev_state)) {
> -                               continue;
> -                       }
> -               }
> +               /*
> +                * We have already validated the presence of BTRFS_DEV_REPLACE_DEVID,
> +                * in btrfs_init_dev_replace() so just continue.
> +                */
> +               if (device->devid == BTRFS_DEV_REPLACE_DEVID)
> +                       continue;

Given the discussion above, after we fail the check for device->devid == 
BTRFS_DEV_REPLACE_DEVID, all devices from that point are not the replace 
target device, and do not have the BTRFS_DEV_STATE_REPLACE_TGT bit set.

So the original check for the BTRFS_DEV_STATE_REPLACE_TGT bit before 
incrementing rw_devices is not just incorrect at this point, it's also 
redundant.

Of course, I would hate to introduce a hard-to-find bug with a bad 
analysis, so any thoughts on this would be appreciated.

Best wishes,
Desmond
