Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADD168A7A
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgBUXnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 18:43:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39809 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUXnu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 18:43:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id e16so700706qkl.6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=su0KjUtmR03UwzapzyaXaHBuGt3rCBrQ3GKAZsjYuHE=;
        b=cd/H0z9OY9W0hgGGngjC6/CpyX8UgXlxZEP6ynKZTSyG59IKkEM8eSwGrznTgCr0HQ
         RPtHihyvZw/uWqFJ+b+XifvZ6DRiz+CSyk/PiYiOUfv8goS2xB90t3quUQE3qGcF23qE
         4khNiPT5/SNByERDt5XVnyM32V9iVH+PJKNe3u05PDhjpoLUq6qA2z3JhjqEmPB26con
         A5HFLQbQV30s7uHHwWBXnCQ/aeDfIapK56hTAG61S8CRHu9Vb1dHSdbWOIEre8j4XDtk
         lSyTjuNvkc5uDPvowp4IGNuJv1hJ8nKX0uIS3x1GYwxzOs4hLLfoCaqVFIyI59C2UxCv
         Xy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=su0KjUtmR03UwzapzyaXaHBuGt3rCBrQ3GKAZsjYuHE=;
        b=Eqk9dqI6wesbw5Zqb7wWub3DHvX72zsMeqeMGXMmlrIdjB0hjoHEl8z0iaudJEqFfD
         9kKHVLnHIlNkVRNYViKYJxyW6QFhFusfJ/3oXsqWpjiaZv+fj0cyyx67b7G/xhayLxdj
         jwlhllfm3MhBJMZMMbym8djVzC/voSWSh/OdRAliLpFtHINq/cuR2ZlA6xlVQZQB4gUY
         Iu+YCvWFFntrdxUTIx10pTEZMh0gzMt7WrQyDp6H379MxNgcAn63M6VVZaKm907cnyO8
         KgrtJyODD+MKnvtkBWAYiVk9PovmHCnrdG0kbeEaR9wkrhEiUaQx1WJQFjBahL8HPyCG
         +l0Q==
X-Gm-Message-State: APjAAAVEOBcvaM4m+hN67fUEe6ViZgNI8nRTuiLSl28PPsFVHjgM1dCr
        XXlLeVpJs4wsDBcNK/CGP8grXOVXZdw=
X-Google-Smtp-Source: APXvYqwWxmJYKz+24iYpW9AuPwJWM/nSE4ZsJ8Ojs6lMj2p5NLsE04/8e3Vra6zykLu5yw79uqRHGw==
X-Received: by 2002:a05:620a:1353:: with SMTP id c19mr12449962qkl.114.1582328627729;
        Fri, 21 Feb 2020 15:43:47 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::31fe])
        by smtp.gmail.com with ESMTPSA id v24sm2288145qkj.33.2020.02.21.15.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 15:43:46 -0800 (PST)
Subject: Re: btrfs filled up dm-thin and df%: shows 8.4TB of data used when
 I'm only using 10% of that.
To:     Marc MERLIN <marc@merlins.org>, Roman Mamedov <rm@romanrm.net>
Cc:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <2656316.bop9uDDU3N@merkaba> <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org> <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org> <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
Date:   Fri, 21 Feb 2020 18:43:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221230740.GQ19481@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/21/20 6:07 PM, Marc MERLIN wrote:
> Ok, first I'll update the subject line
> 
> On Fri, Feb 21, 2020 at 10:45:45AM +0500, Roman Mamedov wrote:
>> On Thu, 20 Feb 2020 21:38:04 -0800
>> Marc MERLIN <marc@merlins.org> wrote:
>>
>>> I had a closer look, and even with 5.4.20, my whole lv is full now:
>>>    LV Name                thinpool2
>>>    Allocated pool data    99.99%
>>>    Allocated metadata     59.88%
>>
>> Oversubscribing thin storage should be done carefully and only with a very
>> good reason, and when you run out of something you didn't have in the first
>> place, seems hard to blame Btrfs or anyone else for it.
> 
> let's rewind.
> It's a backup server, I used to have everything in a single 14TB
> filesystem, I had too many snapshots, and was told to break it up in
> smaller filesystems to work around btrfs' inability to scale properly
> past a hundred snapshots or so (and that many snapshots blowing up both
> kinds of btrfs check --repair, one of them forced me to buy 16GB of RAM
> to max out my server until it still ran out of RAM and now I can't add
> any).
> 
> I'm obviously not going to the olden days of making actual partitions
> and guessing wrong every time how big each partition should be, so my
> only solution left was to use dm-thin and subscribe the entire space to
> all LVs.
> I then have a cronjob that warns me if I start running low on in the
> global VG pool.
> 
> Now, where it got confusing is that around the time I put the 5.4 with
> the df problem, is the same time df filled up to 100% and started
> mailing me. I ignored it because I knew about the bug.
> However, I just found out that my LV actually filled up due to another
> bug that was actually my fault.
> 
> Now, I triggered some real bugs in btrfs, see:
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs fi show .
> Label: 'ubuntu'  uuid: 905c90db-8081-4071-9c79-57328b8ac0d5
>          Total devices 1 FS bytes used 445.73GiB
>          devid    1 size 14.00TiB used 8.44TiB path /dev/mapper/vgds2-ubuntu
> 
> Ok, I'm using 445GB, but losing 8.4TB, sigh.
>    LV Path                /dev/vgds2/ubuntu
>    LV Name                ubuntu
>    LV Pool name           thinpool2
>    LV Size                14.00 TiB
>    Mapped size            60.25%  <= this is all the space free in my VG, so it's full now
> 
> We talked about fstrim, let's try that:
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# fstrim -v .
> .: 5.6 TiB (6116423237632 bytes) trimmed
> 
> Oh, great. Except this freed up nothing in LVM.
> 
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs balance start -musage=0 -v .
> Dumping filters: flags 0x6, state 0x0, force is off
>    METADATA (flags 0x2): balancing, usage=0
>    SYSTEM (flags 0x2): balancing, usage=0
> ERROR: error during balancing '.': Read-only file system
> 
> Ok, right, need to unmount/remount to clear read-only;
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs balance start -musage=0 -v .
> Dumping filters: flags 0x6, state 0x0, force is off
>    METADATA (flags 0x2): balancing, usage=0
>    SYSTEM (flags 0x2): balancing, usage=0
> Done, had to relocate 0 out of 8624 chunks
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs balance start -dusage=0 -v .
> Dumping filters: flags 0x1, state 0x0, force is off
>    DATA (flags 0x2): balancing, usage=0
> Done, had to relocate 0 out of 8624 chunks
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs fi show .
> Label: 'ubuntu'  uuid: 905c90db-8081-4071-9c79-57328b8ac0d5
>          Total devices 1 FS bytes used 8.42TiB
>          devid    1 size 14.00TiB used 8.44TiB path /dev/mapper/vgds2-ubuntu
> 
> 
> Well, carap, see how 'used' went from 445.73GiB to 8.42TiB after balance?

Wtf?  Can you do btrfs filesystem usage on that fs?  I'd like to see the 
breakdown.  I'm super confused about what's happening there.

> 
> I ran du to make sure my data is indeed only using 445GB.
> 
> So now, I'm pretty much hosed, the fielsystem seems to have been damaged in interesting ways.
> 
> I'll wait until tomorrow in case someone wants something from it, and I'll delete the entire
> LV and start over.
> 
> And now for extra points, this also damaged a 2nd of my filesystems on the same VG :(
> [64723.601630] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
> [64723.628708] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
> [64897.028176] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
> [64897.080355] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
> 

This will happen if the transaction aborts, does it still happen after you 
unmount and remount?  Thanks,

Josef
