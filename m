Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57C724B6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjFFS3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbjFFS3f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 14:29:35 -0400
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 11:29:31 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04951984
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 11:29:31 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id B228D9B9B5; Tue,  6 Jun 2023 19:20:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1686075618;
        bh=SOWFmdIwLk3nkenPgpQ1AKw55ezZDSL9Hr0Vb9GDoT8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=FQiAu6TsYsaaKLgsQuiSjQz5Xt0JisjQZtV/WEZJR338Q9wjr0EQYpf56R5KPrsja
         BEZUwLG//TMR9GmtpRuDpHhlGRU6ecmj0oCEQcK5e5z9VktVi4MGTB+BStnLDJIwaX
         IVzES7U59V/WPDpgREVAPEKrsH3/NvVbjs4G4f3cVCeE+eSjqaY1+UqZ7MJ8AbD15r
         Wo7sjQ7kALKr0rbTKAI6LxylMpW+2+NfsLF6pKfkxBIdtDwR1wV7/kGqzITFIa+iwE
         AT9m5UykwC0OQeM1S4rtOTwD69ud2hoRAljEIxn4xuHODJqyL28Ov6bgw7JrRjJEN+
         ju8vxuQUuvr6Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 9BD339B6B9;
        Tue,  6 Jun 2023 19:19:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1686075599;
        bh=SOWFmdIwLk3nkenPgpQ1AKw55ezZDSL9Hr0Vb9GDoT8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=Ci4vHwaU6BLm0QUFvCGzCr5/IFBsSkgWsyZKCNYPuPcXXv04qnqAxnNUBPke50ZBE
         uE2dLYPZ6wJyRsItLsWqi/J1xJNc0lD9iu8rH1NevdhP69y2xEdLnyPZN2wOe1ehb2
         xnb/Ue0XpbhA0PdDwDyXzXs9Y0aqEBW+i8iIXQy325i68xfR6qBnTowdJadktZtUMg
         kJ+EBqOBHQi1yfwJR42NFN/ze+i/vPYTgGf8FLvdBWvEnFwFgdnPIfrYsQ9THjndKI
         GeDjLQgbFeNKPTtAQlLN61gwO2/f/DK8yVQQ4mk48MhcjA7SuszB01uDaK3ZTMkZSR
         uulTwAvhguxaA==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 6C6A8336A4A;
        Tue,  6 Jun 2023 19:19:59 +0100 (BST)
Message-ID: <76e36274-5067-676a-f3e8-9232b1fc8cb0@cobb.uk.net>
Date:   Tue, 6 Jun 2023 19:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: How to find/reclaim missing space in volume
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
 <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
In-Reply-To: <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/06/2023 05:47, Andrei Borzenkov wrote:
> On 06.06.2023 04:46, Marc MERLIN wrote:
>> On Mon, Jun 05, 2023 at 08:00:02PM +0300, Andrei Borzenkov wrote:
>>> On 05.06.2023 19:26, Marc MERLIN wrote:
>>>> I have this:
>>>> sauron [mc]# df -h .
>>>> Filesystem         Size  Used Avail Use% Mounted on
>>>> /dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
>>>> sauron [mc]# btrfs fi show .
>>>> Label: 'btrfs_pool2'  uuid: fde3da31-67e9-4f88-b90d-6c3f6becd56a
>>>>     Total devices 1 FS bytes used 847.89GiB
>>>>     devid    1 size 1.04TiB used 890.02GiB path /dev/mapper/pool2
>>>> sauron [mc]# btrfs fi df .
>>>> Data, single: total=878.00GiB, used=843.85GiB
>>>> System, DUP: total=8.00MiB, used=128.00KiB
>>>> Metadata, DUP: total=6.00GiB, used=4.04GiB
>>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>>
>>>
>>> btrfs filesystem usage -T is usually more useful than both the above
>>> commands.
>> sauron:/mnt/btrfs_pool2# btrfs fi usage -T .
>> Overall:
>>      Device size:           1.04TiB
>>      Device allocated:         890.02GiB
>>      Device unallocated:         177.73GiB
>>      Device missing:             0.00B
>>      Used:             851.85GiB
>>      Free (estimated):         211.93GiB    (min: 123.07GiB)
>>      Data ratio:                  1.00
>>      Metadata ratio:              2.00
>>      Global reserve:         512.00MiB    (used: 0.00B)
>>
>>                       Data      Metadata System
>> Id Path              single    DUP      DUP       Unallocated
>> -- ----------------- --------- -------- --------- -----------
>>   1 /dev/mapper/pool2 878.00GiB 12.00GiB  16.00MiB   177.73GiB
>> -- ----------------- --------- -------- --------- -----------
>>     Total             878.00GiB  6.00GiB   8.00MiB   177.73GiB
>>     Used              843.79GiB  4.03GiB 128.00KiB
>>
>>>> sauron:/mnt/btrfs_pool2# du -sh *
>>>> 599G    varchange2
>>>> 598G    varchange2_ggm_daily_ro.20230605_07:57:43
>>>> 4.0K    varchange2_last
>>>> 599G    varchange2_ro.20230605_08:01:30
>>>> 599G    varchange2_ro.20230605_09:01:43
>>>>
>>>> I'm confused, the volumes above are snapshots with mostly the same data
>>>> (made within the last 2 hours) and I didn't delete any data in the FS
>>>> (they are mostly identical and used for btfrs send/receive)
>>>>
>>>> Why do they add up ot 600GB, but btrfs says 847FB is used?
>>>>
>>>
>>> Each subvolume references 600G but it does not mean they are the same
>>> 600G.
>>> If quota is enabled, "btrfs quota show" may provide some more
>>> information,
>>> otherwise "btrfs filesystem du" shows shared and exclusive space (you
>>> need
>>> to pass all subvolumes in question to correctly compute shared vs
>>> exclusive).
>>
>> Right, I did check/know that the snapshots shared the same data, but it
>> doens't hurt to confirm:

But your output doesn't confirm that. The problem is that the concept of
"shared" is not useful as it tells you nothing about how many times each
file is shared. The files in the last snapshot could all be completely
different from the first and you would still see that output.

You need to do pairwise comparisons. A check between the first and the
last would tell you if there was much change.

My "extents-lists" scripts (https://github.com/GrahamCobb/extents-lists)
were my hack to do such comparisons - there may be better ways to do it
nowadays. If you use those tools you could try:

extents-expr -s /mnt/btrfs_pool2/varchange2_ro.20230605_10:01:40 ^
/mnt/btrfs_pool2/varchange2_ro.20230605_18:02:02

That would show you the amount of data shared between the two specified
directories.

Graham

>>
>> sauron:/mnt/btrfs_pool2# btrfs filesystem du -s *
>>       Total   Exclusive  Set shared  Filename
>>   597.57GiB    20.00KiB   588.75GiB  varchange2
>>   597.57GiB     4.00KiB   588.75GiB 
>> varchange2_ggm_daily_ro.20230605_09:59:26
>>   597.57GiB       0.00B   588.75GiB  varchange2_last
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:30:33
>>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_17:35:32
>>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_17:40:32
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:45:32
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:50:32
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:55:32
>>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_18:00:32
>>   597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_18:05:32
>>   597.57GiB     8.00KiB   588.75GiB  varchange2_minly.20230605_18:10:32
>>   597.57GiB    16.00KiB   588.75GiB  varchange2_ro.20230605_10:01:40
>>   597.57GiB    12.00KiB   588.75GiB  varchange2_ro.20230605_11:01:31
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_13:01:28
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_14:01:30
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_15:01:29
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_16:01:32
>>   597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_17:01:31
>>   597.57GiB       0.00B   588.75GiB  varchange2_ro.20230605_18:02:02
>> sauron:/mnt/btrfs_pool2# df -h .
>> Filesystem         Size  Used Avail Use% Mounted on
>> /dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
>>
>>
> 
> Well, I have had it once, there were deleted but not freed subvolumes
> 
> https://lore.kernel.org/linux-btrfs/ecd46a18-1655-ec22-957b-de659af01bee@gmx.com/T/
> 

