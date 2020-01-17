Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9617140C5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAQOXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:23:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35303 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgAQOXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:23:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so21886591qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c2vD23z3W0Yyx0s4TfdnxwSZ5AHNsGKsPtX1Sb61msg=;
        b=kmJc5oA2ChPXeK5t3r4t/qSBeGpBJmctvbA5We0S2tSlkIQh1uZQhDmFhGFXMxxoAy
         B6rDLo7ug1zOBGjh8dPBh8uQlZMvdNo21siXw2GhNsi1by1vyqrTTjTufwIPXTU+liZc
         XuZs2385+28lJhLbwZElpixJPcyEr7K07j2Ufh7ywsIQJxTTufK/S5vazQgfHuIny46h
         2ud5kqlrI+q9+EQgeyqnKvxP6tAQacbd6hpYNTaK8oCoXV7elcEnc6m9lzvWsjKACvF7
         qAbj89QiCZ+anuzFu+q9gq7oMqw3P3DQMLQ1GardXutCbM8eMC/oy4+FDyexwIXYc6n+
         k+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2vD23z3W0Yyx0s4TfdnxwSZ5AHNsGKsPtX1Sb61msg=;
        b=T0nzERhpqYR2OFHVzfSXD9MRk50pa18ZHeK2F9odO/N03xKHHe4GcIvnoICJ7Lz/b9
         cjelwQ+rZBhtRe21UWaFvKvvPs2dzPWW/+/4sL2Aar30VAmq4iC2u4SJu6/rIZGLNumG
         w2BIRuFAHJbpHyCd36+vdATkQFsP5MSHhWaYCITrGpZa0qd+T9HvHY19ABKNPdxl17HW
         R3+MlxrLnL6qJBEwohCCPymkxv3q6LX4JBNgVD2Ef9SxOthaBzpPsboeJ3HqCyV/PkPG
         AA4g42+MlQ08ZjisRH0S60HQSayX5L9cI62emFH7tyyEME9X2ds1UpL7SMPApW5DUFvx
         Q+sQ==
X-Gm-Message-State: APjAAAW64KO7ff8L3k/rl9f3nKJPsNIvH9IeZyQTcAI4GLH1cWm5EvMy
        ZjKoZFrMefCqHCKZTBqjHmThnWxjkEf9YA==
X-Google-Smtp-Source: APXvYqzZkr2gNuvj1q1/rpe71gamvBHYGmB2XPqx59m98IQQvCtXxTPiDnQpXPnS84Pt/VWKG1kb6w==
X-Received: by 2002:ac8:1385:: with SMTP id h5mr7491598qtj.59.1579270989482;
        Fri, 17 Jan 2020 06:23:09 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m68sm11753077qke.17.2020.01.17.06.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:23:08 -0800 (PST)
Subject: Re: [PATCH v3 3/5] btrfs: remove identified alien btrfs device in
 open_fs_devices
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-4-anand.jain@oracle.com>
 <550c6454-be48-51bb-1196-40586e3649b7@toxicpanda.com>
 <f04ad491-ad34-0a0d-e2ba-11ad3713bedd@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <699ff38f-dcc8-de0b-3569-d07d9616bc4f@toxicpanda.com>
Date:   Fri, 17 Jan 2020 09:23:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f04ad491-ad34-0a0d-e2ba-11ad3713bedd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/17/20 4:10 AM, Anand Jain wrote:
> 
> 
> On 1/16/20 11:56 PM, Josef Bacik wrote:
>> On 10/7/19 5:45 AM, Anand Jain wrote:
>>> In open_fs_devices() we identify alien device but we don't reset its
>>> the device::name. So progs device list does not show the device missing
>>> as shown in the script below.
>>>
>>> mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
>>> mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdb
>>> sleep 3 # avoid racing with udev's useless scans if needed
>>> btrfs dev add -f /dev/sdb /btrfs
>>> mount -o degraded /dev/sdc /btrfs1
>>>
>>> No missing device:
>>> btrfs fi show -m /btrfs1
>>> Label: none  uuid: 3eb7cd50-4594-458f-9d68-c243cc49954d
>>>     Total devices 2 FS bytes used 128.00KiB
>>>     devid    1 size 12.00GiB used 1.26GiB path /dev/sdc
>>>     devid    2 size 12.00GiB used 1.26GiB path /dev/sdb
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Why not just remove the device if there's any error?  I'm not sure why these 
>> particular checks make a difference from any other error?  Thanks,
> 
>   That's interesting, but disadvantage is user has to re-run the
>   device scan if we remove the device for a non-alien device which can
>   fail temporarily in btrfs_open_one_device() function stack such as
> 
> 
>      *bdev = blkdev_get_by_path(device_path, flags, holder);
> 
>    If user land has opened the device with O_EXCL this shall
>    fail with -EBUSY. So here we shouldn't remove.
> 
> 
>       ret = set_blocksize(*bdev, BTRFS_BDEV_BLOCKSIZE);
> 
>    This can fail if the bdev does not accept the blocksize and its
>    rather a good idea to remove the device as we won't be able to
>    use this device any time. So as this is not a temporary issue,
>    here we could remove the device.
> 
> 
>          *bh = btrfs_read_dev_super(*bdev);
> 
>    This function is still an incomplete (because we don't yet handle
>    the corrupted super block #1, there is a patch in the ML but
>    in dispute, I think). Needs clarity on how a completed function
>    will look like. So here it depends on when this function completes.
> 
> 
>       bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
> 
>    Read can fail momentarily for transport/disconnect/plug-out issue
>    and which can reappears and assume if there isn't systemd auto scan
>    so here we shouldn't remove.
> 

Alright that's fair, thanks,

Josef
