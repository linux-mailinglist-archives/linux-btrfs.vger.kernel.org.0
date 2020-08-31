Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A279C257E97
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgHaQWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 12:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgHaQWU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 12:22:20 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE17C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 09:21:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cr8so705959qvb.10
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pY+3zfQNWN8pIw7CFLbJAjpXN9WcdISxf2xKO2zObQ=;
        b=JxARXq/MLpA0K7gAFeT9KcSVBO3RVkk8pJGA3WXy1AJ4LiZPvCTi9eoHLK8+MAzx6U
         vumHpI412vhq3c/szFlAVtmoUCnMg+5T3HL4O5umImmZ6Mo9lPeKEHaUKI2gSWELM5O5
         UAuuZmJv5KV2f4buzYQg/CEyEnpGy/9UJn05othw+W3kx721NhZsUB+sDEi9rzXjWEX/
         WP5lHGi5Db/ZCZuTk6oNXB8yR4AR70ASXBPNLOF2HyWQPiG4VMsoxqsAq/lsURmoCMUk
         IKcnNN2IfISYcdICGw2YxuV0S7amF9n8xrrnz9gVJf+A0tuEuTwaWgsJ24PvbCq7G3Wc
         W40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pY+3zfQNWN8pIw7CFLbJAjpXN9WcdISxf2xKO2zObQ=;
        b=TRe9KktTJNzjpjHFqJU8B+oO5thrliuJSunC9fYiKLJctxxEgAAGrDaXoRT+4k9Z0v
         BNIFjBC+X26y3om7MgBjBQgcHccfe/Mp+V2ykPH80Q1hd2HhH5EUo2kVCF9ClLiiKjTD
         KYkHnGaUqieWk6I2ergNJfZTyOLE9I50JBSZrZ0V/DHKVJ8WthMjiM6d3lXzsl/UYMff
         CGqo7tMyaKZFHRr66u01jsr+ol+m7mfoMo5na4VGU0duV/r/dddVNjrXaFj45zl6KCJe
         C0VpUPO/V5CUoROAvVz/DcFls+MLs8A2PQHfsUkvcV8PcnXfClZ2hdoFtOgqi/+i2m6G
         KoXg==
X-Gm-Message-State: AOAM530PrZ8+c0mU1Gjjd9FkTPLZbrWB4rfvCHu1UrYoYHXG12Sy1+FV
        wVeBmVMCo+BMjsanp3rZik1MTT01SRwWHYjW
X-Google-Smtp-Source: ABdhPJx5GA2NXc2kZ0OTPRyYAhLSBn/WI9iTz/XqclUE9CmgmqaPcUyMdT1xNGXn1qsSXR+7OHc0pA==
X-Received: by 2002:a0c:cb83:: with SMTP id p3mr1790441qvk.121.1598890914260;
        Mon, 31 Aug 2020 09:21:54 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q126sm9971806qkb.75.2020.08.31.09.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 09:21:53 -0700 (PDT)
Subject: Re: [PATCH 01/11] btrfs: initialize sysfs devid and device link for
 seed device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1598792561.git.anand.jain@oracle.com>
 <2db650ec206db1cb3e68590951b59e222fb10116.1598792561.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1df53e43-2ec8-8e67-8a79-ec90782e9e3a@toxicpanda.com>
Date:   Mon, 31 Aug 2020 12:21:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2db650ec206db1cb3e68590951b59e222fb10116.1598792561.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/30/20 10:40 AM, Anand Jain wrote:
> The following test case leads to null kobject-being-freed error.
> 
>   mount seed /mnt
>   add sprout to /mnt
>   umount /mnt
>   mount sprout to /mnt
>   delete seed
> 
>   kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
>   WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
>   RIP: 0010:kobject_put+0x80/0x350
>   ::
>   Call Trace:
>   btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
>   btrfs_rm_device.cold+0xa8/0x298 [btrfs]
>   btrfs_ioctl+0x206c/0x22a0 [btrfs]
>   ksys_ioctl+0xe2/0x140
>   __x64_sys_ioctl+0x1e/0x29
>   do_syscall_64+0x96/0x150
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7f4047c6288b
>   ::
> 
> This is because, at the end of the seed device-delete, we try to remove
> the seed's devid sysfs entry. But for the seed devices under the sprout
> fs, we don't initialize the devid kobject yet. So this patch initializes
> the seed device devid kobject and the device link in the sysfs. This takes
> care of the Warning.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Ok again, this will not work.

Mount a seed fs, you get fs_info->fs_devices pointed at the seed device, and 
fs_info->fs_devices->devices_kobj is what is initialized.

Now you sprout.

This does clone_fs_devices(fs_info->fs_devices), which doesn't copy over 
fs_fdevices->devices_kobj.  Now we take this clone device, and set 
fs_info->fsdevices to the cloned fs_devices, and we add the original fs_devices, 
which had the sysfs objects init'ed already, to fs_devices->seed_list.

It appears to me you are completely ignoring this aspect of sprout.  Maybe I'm 
missing something, but I've gone through this code twice now to see if what I 
think is happening is actually happening, and I'm convinced this is wrong.

If it's _not_ wrong, and I _am_ missing something, then you need to explain why 
I'm wrong, and then go back and fix what needs to be fixed to make this whole 
process more clear, and _then_ you can do this patch series.  Thanks,

Josef
