Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD439100D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 07:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhEZFhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 01:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhEZFhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 01:37:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE413C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 22:36:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id q7so667710lfr.6
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uemRb4z1TRPQTZCM3LCBA9gy68xtKsr3/WHEK6Do0vw=;
        b=F4EVI2ySZD3inBB0FzFcJBOqvHwJD5GhxhA3fj5D5FC5Y0+PMSpEebKcfyKjLi77cG
         vVgpDhc0dOAozMlyx+fIdNwdhJfEwNUxgdStdYiecwywCN10/Anpgxa7ajfjQpqk4AUz
         PIDor3S9ExJleDi1kVeUgLYS2IXk2UHVvDVP9i2qAYBFrwkZmIP20AZ2VXG512pXC85a
         uEfb5wl0a1k368YNmJkN66w80kX65mhHUjFNCy1Ye/KJ6tE3H9HjJDe400yow7ObFAfy
         XTH+zP0gTOi2XRIh4lK6O+V6q/eV22va8kITjkOUG9IKzfDjwO0tNcNb9ca1w4MEIkiO
         ykAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uemRb4z1TRPQTZCM3LCBA9gy68xtKsr3/WHEK6Do0vw=;
        b=XJ5vJimTgQKtxxqThbESVNQcorPGnpyMayDhGE3Dz1TiXv3IoxzErbUPurWnNW425J
         2y9wM57stJysjhXAYiyJ82IeO1wZNvTEnKpXR8cmgS0Zg6H1DMMqd/3+Em610/vO48j+
         bqfan/ReCpQYRSkcL/Nbzg5LRg6istWYWkE0wTUSdW/frKMt3boqJf5C1m9jJZvRYUmD
         PLBmFuOowFeFcb2SEJM1GswPtb8uk1OVwxtplBxK8aFRNbDmrACigvDkzwFkiiRZuOSZ
         Wgf3kgjOmEA4/y7eShe5mYWm/E/GyB+m2kEh915K7i+CsuOZuLXFHTzhEzD9oLlXUjot
         7W6w==
X-Gm-Message-State: AOAM533ykCnoxYH3KmbPxzv9D8+/NRg0JjSDKSynByMKTXegaLx3rLtx
        uqgIEFtGInvGgRUghBtZWUQjE4v2AOKUIg==
X-Google-Smtp-Source: ABdhPJyxtRDqrmBWIyk96Yb4huyy7yz/3W0IoyljFbBQFBy3nIEQ7fMX7JzOvhiBPuQkTSp0C6tbeQ==
X-Received: by 2002:a05:6512:3e2:: with SMTP id n2mr960626lfq.301.1622007361608;
        Tue, 25 May 2021 22:36:01 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:1d76:7528:44a1:ad66:3ca4? ([2a00:1370:812d:1d76:7528:44a1:ad66:3ca4])
        by smtp.gmail.com with ESMTPSA id m10sm969779lfp.57.2021.05.25.22.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 22:36:01 -0700 (PDT)
Subject: Re: some principal questions to "disk full"
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
References: <1771321158.76542899.1621959622455.JavaMail.zimbra@helmholtz-muenchen.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <2c00a97f-ac79-147c-ddd2-7ff4a90ca941@gmail.com>
Date:   Wed, 26 May 2021 08:36:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1771321158.76542899.1621959622455.JavaMail.zimbra@helmholtz-muenchen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25.05.2021 19:20, Lentes, Bernd wrote:
> Hi guys,
> 
> it would be great if you can help me to sort out my understanding of BTRFS and its problems with "disk full".
> I'm using BTRFS on several systems and this is now the first time that i have a "full disk".
> I'd really like to understand the problem and also how to solve it.
> I gave my best to read and understand https://btrfs.wiki.kernel.org/index.php/FAQ.
> 
> My setup:
> Ubuntu 18.04
> kernel 4.4.0-66-generic
> 64 bit
> 
> My disk:
> root@pc65472:/data# btrfs fi show /
> Label: none  uuid: 3a623645-a5e1-438e-b0f3-f02520f1a2eb
>         Total devices 2 FS bytes used 350.08GiB
>         devid    1 size 420.00GiB used 420.00GiB path /dev/mapper/vg1-lv_root
>         devid    2 size 2.00GiB used 1.00GiB path /dev/loop0
> (the loop device is from an effort of "btrfs balance" i will report later on).
> 
> Is it correct that the 420GiB shown as "used" in the line of devid 1 means "allocated" ?

Yes

> Allocated means ... "not usable, reserved" ?

btrfs is using two stage space management. First large areas (chunk,
block group) are allocated on device, then each chunk is subdivided in
extents as needed. You have 420iGB of block groups and inside of these
block groups 350,08GiB was used by actual data.

> What is "unallocated" ? A kind of "free, usable" ?
> 

Device space not belonging to any block group. Yes, it is "free,
usable", but so are 69.92GiB inside of allocated space.

> root@pc65472:/data# btrfs fi usage /
> Overall:
>     Device size:                 422.00GiB
>     Device allocated:            421.00GiB
>     Device unallocated:            1.00GiB
>     Device missing:                  0.00B
>     Used:                        350.08GiB
>     Free (estimated):             70.29GiB      (min: 70.29GiB)

Which is what it tells you - it is sum of unallocated space and unused
allocated space.

>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
> Data,single: Size:413.99GiB, Used:344.69GiB
>    /dev/mapper/vg1-lv_root       413.99GiB
> 
> Metadata,single: Size:7.01GiB, Used:5.39GiB
>    /dev/loop0      1.00GiB
>    /dev/mapper/vg1-lv_root         6.01GiB
> 
> System,single: Size:4.00MiB, Used:80.00KiB
>    /dev/mapper/vg1-lv_root         4.00MiB
> 
> Unallocated:
>    /dev/loop0      1.00GiB
>    /dev/mapper/vg1-lv_root           0.00B
> 
> "Device size" and "Device allocated" is slight bigger than shown with "btrfs fi show"

Both show exactly the same 422GiB and 421GiB.

> It seems the output of "btrfs usage /" adds the loop-device in its calculation, and "btrfs fi show" doesn't. Correct ?

No.

> 
> I think the reason for "disk full" is the metadata:
> Metadata,single: Size:7.01GiB, Used:5.39GiB
>    /dev/loop0      1.00GiB
>    /dev/mapper/vg1-lv_root         6.01GiB
> 
> Before i added the loop nearly all space for the metadata was occupied (5,4GiB from 6GiB). That's the problem ?

It depends, but in general everything btrfs does requires allocation of
additional metadata to complete the operation. You are certainly very
low on available metadata space.

> Only 600MB were free for metadata, that's roundabout the "Global Reserve", and that's, following the wiki, to little.
> 
> I deleted som old snapshots and now have enough space. I started a "btrfs balance".
> My first effort with an additional device (the loop device) didn't suceed.
> 

Showing actual logs with actual error is better than giving vague
description.

> What can i do to prevent a "disk full" situation ?

The only universal answer - do not fill up your disk. Seriously.

> Running regulary "btrfs balance" in a cron job ?
> 

If you are using more or less recent kernel version, you need not run
btrfs balance at all except when possibly converting profiles or adding
new device. btrfs became reasonably good at managing free space.

> Is there a way to transform allocated space to unallocated space ?
> 

Only by using balance. But that requires sufficient free space to
allocate additional metadata during balance.

Normally btrfs is using different space to store data and metadata. So
even if you have 60GiB of free space inside data block groups, it cannot
be used to allocate metadata.

You can try running "btrfs balance start -d usage=0" - it does not move
any data, just removes completely empty block groups. Also running
balance with small usage (like 1 to 5) percentage may help in compacting
block groups.

Running full balance should certainly be avoided.
