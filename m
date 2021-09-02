Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3F3FEA55
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhIBIBc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhIBIBV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 04:01:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53683C061575
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 01:00:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w4so1918641ljh.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=94FP6kAAfpFCT6jUcq+GmynK77NL4lCKLlbPMZAJUhg=;
        b=CrW66NADTwJ/oVVq0VSLpXj86YhbDCoBT8vGVFP80t6tP87Pi0FumH74Zt0ODOw6XV
         jys9cBx+3DbW7IoWZ+qzo78OX+ZLJgqyF/CU28Q3w778cov66Y0vIr+LJaMIs8FkWJRi
         BJxfQHgYRbTvxUhrW0Wk5O6QhGPpjlXZY2Vvc8Mdl5OW/Q9WbKD0or53DEuxT2FkjzA0
         hLr6DvpPIH+I4XsCpe7ZcjTJrwJEKITMHiEErmcpGQAD8PafENzUVgcf+FYJDWm2U/E4
         TRFcD0/ZL/f+aIBR/g7ieH5+XMnzLFaTpnpG8XkamkqDvV4nc+m8gkYuwqTnMiQkrbf0
         jYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94FP6kAAfpFCT6jUcq+GmynK77NL4lCKLlbPMZAJUhg=;
        b=eSkWtpnPwW9TVy8UiFf/XXKH0bRGlYnTSlRBI71KoNXrHLNk8ra8ijp2+rVX4ujwTr
         0f9e6iimNqNOjeU6USrJlMQ76FcEVddIF+QH+0Si6X5H5K9rkw3J49n+xgAi/UZRLU9p
         WQwzAhybP2hClDDikI9IeHEiRXpGXVAOgdwXbwcxbHiXDvSBGwI6Lty4xjERexNWs4Js
         fso2/lU/PywvzZIQ8GXrRLym+xzVHn8iNlbzucyQlJyp5wlXicMIy/brMn0egfXJLaV+
         LNpdkNb0UzKC5wXQZmpT+boebK5WHgL7QJ6Rh0N+DfUZxQr0reftNg9P9VckULwvFu/C
         /R5Q==
X-Gm-Message-State: AOAM530vv8SL5cO86xqBQdzTPCe2MaEgf/pgR/TYq4pUvm5IZQesk3ZR
        l81AJaYfO0txY5aUpxRPqSbdkHEGiY4=
X-Google-Smtp-Source: ABdhPJw/pthDTrHYh36WcrnmBrOzI2ujV/Ln60Ql2YStOEwjjiVxfov8p2fLqNgN2X0NGROyuRIlcQ==
X-Received: by 2002:a05:651c:1144:: with SMTP id h4mr1450035ljo.48.1630569621346;
        Thu, 02 Sep 2021 01:00:21 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:8deb:5c9c:cef9:590c:9452? ([2a00:1370:812d:8deb:5c9c:cef9:590c:9452])
        by smtp.gmail.com with ESMTPSA id d21sm129995ljo.70.2021.09.02.01.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 01:00:20 -0700 (PDT)
Subject: Re: how to replace a failed drive?
To:     Anand Jain <anand.jain@oracle.com>,
        Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
 <70615a2e-bf3e-c56b-d536-48bd9cfdfb8c@oracle.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <3d2ca50d-3f86-4b8d-ea42-2d7ca0135c52@gmail.com>
Date:   Thu, 2 Sep 2021 11:00:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <70615a2e-bf3e-c56b-d536-48bd9cfdfb8c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.09.2021 10:45, Anand Jain wrote:
> On 02/09/2021 06:07, Tomasz Chmielewski wrote:
>> I'm trying to follow
>> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices
>> to replace a failed drive. But it seems to be written by a person who
>> never attempted to replace a failed drive in btrfs filesystem, and who
>> never used mdadm RAID (to see how good RAID experience should look like).
>>
>> What I have:
>>
>> - RAID-10 over 4 devices (/dev/sd[a-d]2)
>> - 1 disk (/dev/sdb2) crashed and was no longer seen by the operating
>> system
>> - it was replaced using hot-swapping - new drive registered itself as
>> /dev/sde
>> - I've partitioned /dev/sde, so that /dev/sde2 matches the size of
>> other btrfs devices
>> - because I couldn't remove the faulty device (it wouldn't go below my
>> current number of devices) I've added the new device to btrfs filesystem:
>>
> 
> 
>> btrfs device add /dev/sde2 /data/lxd
> 
>  Wiki is correct.
> 
>  $ btrfs replace start 7 /dev/sdf1 /mnt
> 

Where exactly user is supposed to find out the correct number of missing
device? Because
...

>>
>> # btrfs filesystem show /data/lxd
>> Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
>>          Total devices 5 FS bytes used 2.84TiB
>>          devid    1 size 1.73TiB used 1.60TiB path /dev/sda2
>>          devid    3 size 1.73TiB used 1.60TiB path /dev/sdd2
>>          devid    4 size 1.73TiB used 1.60TiB path /dev/sdc2
>>          devid    6 size 1.73TiB used 0.00B path /dev/sde2
>>          *** Some devices missing
>>

It only shows existing devices. "Some devices missing" is not exactly
helping. More useful would be "devid 7 missing".
