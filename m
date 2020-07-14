Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D46521ECF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgGNJdq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgGNJdp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 05:33:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73003C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 02:33:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so20464929wrp.2
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SVDq9ikmuEu6hxdKmcpQCPs01SGSrojj2SgL9yQGBYc=;
        b=E0UB7az1O3DPLVmWoEtrFS6tjeMDM3mEVQ4p4My4jhzHgR9UpOzTmBNaAwSHXQ0lSi
         kwpTbdMWxKep0jtIxVlNQZwseO/yCJgJqD2XzUyiOa+LxEF01EK59cUcY5W+mZ7eqlTo
         nYWSK/x/0MCx0I2J38rDB3gtSThfDAnc+qZHOMzcWBY4FCoeo+7bwWqPKYbSvOuk2Lcz
         zgXAp9+c5nl435ziFHwRc/FmHuL0FA2j4gRmdeblwxG0QI5EjuP8ZbSqa1ZltrNp+1G0
         xoahZ1oH+Tt7HmVzBBEAamGptiZmmh3QDbkZLNF/hZCjhYDVCcDSmAKaUMwsPFfP1BjY
         GBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVDq9ikmuEu6hxdKmcpQCPs01SGSrojj2SgL9yQGBYc=;
        b=q940LV6BfiJIqZSH2A5KriDBhtSGuKDzCZE9470IABsRQZIVfsyA3Sv7Kbnepjsjbk
         WNBOi5QCV0Jh550yYvpXNVcvlbZfSiPoeiKZDUwPMCK6mwuU9S2rQWavESV4+4DqpXwi
         losKI07d8B1jB61IYJtePxN+AqeglMhwwVxcmfRK3fYBibRoj7yWfc0ftcmVjziaIMJV
         6gB5tHZzcYbNHRgY36rCweLUlyHToHr5mjwI/XWvCY+OY/s+eGJDpqJpZUOPFymia5RJ
         gNbzk5t3SqGI9SRi8FMT2Hp7OS/p3JI9G3ZEmcY16BSBIsmee4hIhr8hhMZzIiZ00GXx
         JIpA==
X-Gm-Message-State: AOAM533fc5b5/SCvLsv+f5JJEfW9drhEF8EwH8N6O0e6mU5s+4UaS6p3
        JnJj3urWtPP5DTZEkJUJVPAFXExP
X-Google-Smtp-Source: ABdhPJywyDqDBQCvI6sr/SrQDZbzp2lgN6LcqDdzovZONV57XFhxFeSHizEnwDhDYsUeiTIC8bz6FQ==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr4028467wrm.401.1594719223796;
        Tue, 14 Jul 2020 02:33:43 -0700 (PDT)
Received: from [192.168.1.145] ([213.147.166.141])
        by smtp.googlemail.com with ESMTPSA id d18sm28988204wrj.8.2020.07.14.02.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 02:33:43 -0700 (PDT)
Subject: Re: "missing data block" when converting ext4 to btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <90fff9c0-36c5-d45c-d19b-01294fc93b1e@gmail.com>
 <763ee221-92fa-a84c-db8e-9d05e88bab0c@gmx.com>
 <09c51964-9762-a7a7-02c3-ac398790ff0d@gmail.com>
 <b49c8f68-5897-7bc1-21d5-03125e798a76@gmx.com>
From:   Christian Zangl <coralllama@gmail.com>
Message-ID: <409fb0aa-7c7f-db52-6442-d746b9944fa3@gmail.com>
Date:   Tue, 14 Jul 2020 11:33:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b49c8f68-5897-7bc1-21d5-03125e798a76@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-14 10:09, Qu Wenruo wrote:
> 
> 
> On 2020/7/14 下午3:58, Christian Zangl wrote:
>> On 2020-07-14 08:10, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/7/14 上午3:46, Christian Zangl wrote:
>>>> I am on a test VM where I am trying to convert a second disk to btrfs.
>>>>
>>>> The conversion fails with the error missing data block for bytenr
>>>> 1048576 (see below).
>>>>
>>>> I couldn't find any information about the error. What can I do to fix
>>>> this?
>>>>
>>>> $ fsck -f /dev/sdb1
>>>> fsck from util-linux 2.35.2
>>>> e2fsck 1.45.6 (20-Mar-2020)
>>>> Pass 1: Checking inodes, blocks, and sizes
>>>> Pass 2: Checking directory structure
>>>> Pass 3: Checking directory connectivity
>>>> Pass 4: Checking reference counts
>>>> Pass 5: Checking group summary information
>>>> /dev/sdb1: 150510/4194304 files (0.5% non-contiguous), 2726652/16777216
>>>> blocks
>>>>
>>>> $ btrfs-convert /dev/sdb1
>>>> create btrfs filesystem:
>>>>           blocksize: 4096
>>>>           nodesize:  16384
>>>>           features:  extref, skinny-metadata (default)
>>>>           checksum:  crc32c
>>>> creating ext2 image file
>>>> ERROR: missing data block for bytenr 1048576
>>>> ERROR: failed to create ext2_saved/image: -2
>>>> WARNING: an error occurred during conversion, filesystem is partially
>>>> created but not finalized and not mountable
>>>
>>> Can btrfs-convert -r rollback the fs?
>>
>> No:
>>
>> $ sudo btrfs-convert -r /dev/sdb1
>> No valid Btrfs found on /dev/sdb1
>> ERROR: unable to open ctree
>> ERROR: rollback failed
>>
>> If I do `fsck -f /dev/sdb1` I get lots of errors:
>>
>> t-arch:~$ sudo fsck -f /dev/sdb1
>> fsck from util-linux 2.35.2
>> e2fsck 1.45.6 (20-Mar-2020)
>> Resize inode not valid.  Recreate<y>? yes
>> Pass 1: Checking inodes, blocks, and sizes
>> Deleted inode 3681 has zero dtime.  Fix<y>? yes
>> Inodes that were part of a corrupted orphan linked list found.  Fix<y>? yes
>> Inode 3744 was part of the orphaned inode list.  FIXED.
>> Deleted inode 3745 has zero dtime.  Fix<y>? yes
>> Inode 3747 has INLINE_DATA_FL flag on filesystem without inline data
>> support.
>> Clear<y>? yes
>> Inode 3748 was part of the orphaned inode list.  FIXED.
>> Inode 3748 has a extra size (6144) which is invalid
>> Fix<y>? yes
>> Inode 3751 is in use, but has dtime set.  Fix<y>? yes
>> Inode 3751 has imagic flag set.  Clear<y>? yes
>> Inode 3752 was part of the orphaned inode list.  FIXED.
>> Inode 3753 was part of the orphaned inode list.  FIXED.
>> Inode 3754 is in use, but has dtime set.  Fix<y>? yes
>> Inode 3755 was part of the orphaned inode list.  FIXED.
>> Inode 3755 has imagic flag set.  Clear ('a' enables 'yes' to all) <y>? yes
>> Deleted inode 3801 has zero dtime.  Fix ('a' enables 'yes' to all) <y>?
>> ...
> 
> This sounds like the cause.
> 
> As btrfs completely rely on the used space reported from ext*, and if
> the fs is corrupted, then a lot of things can go wrong.

No, maybe you missed it but I did a fsck before the convert (see above). 
It reported no errors.

Only after the failed btrfs-convert I get the errors.


>>
>>> If you can rollback, would you provide the ext4 fs image?
>>
>> You mean the vmdk from VMware? I do have a backup.
> 
> Would you mind to run e2fsck on the backup first to see if that's the
> problem?

The backup has no fsck issues.

> If the fixed fs can not pass btrfs-convert still, would you mind to send
> the fs image?

How/where would you like me to send it?

Thanks, Christian

> 
> Thanks,
> Qu
> 
>>
>> Thanks!
>>
>> Christian
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> $ uname -a
>>>> Linux t-arch 5.7.7-arch1-1 #1 SMP PREEMPT Wed, 01 Jul 2020 14:53:16
>>>> +0000 x86_64 GNU/Linux
>>>>
>>>> $ btrfs --version
>>>> btrfs-progs v5.7
>>>
>>
> 

