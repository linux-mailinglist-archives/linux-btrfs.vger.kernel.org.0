Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1CE366714
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhDUIjk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Apr 2021 04:39:40 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:28436 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDUIjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 04:39:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 471503F4D8;
        Wed, 21 Apr 2021 10:39:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fwcmqlm1j91w; Wed, 21 Apr 2021 10:39:05 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 2C3B03F3B2;
        Wed, 21 Apr 2021 10:39:05 +0200 (CEST)
Received: from [8.40.140.149] (port=46498 helo=[10.82.237.104])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1lZ8O0-000Jpz-Fm; Wed, 21 Apr 2021 10:39:04 +0200
Date:   Wed, 21 Apr 2021 10:39:00 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     me@jse.io, Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <cb91b4d.31d1aaa2.178f395218a@tnonline.net>
In-Reply-To: <CAFMvigfQ+XotjO_578LvSvycD3sbLcV_AP6A+B0U+ybApU2zGA@mail.gmail.com>
References: <CAFMvigdvAjY60Tc0_bMB-QMQhrSJFxdv2iJ6jXbju+b5_kPKrA@mail.gmail.com> <9bdb8872-3394-534f-a9e3-11dcc5ea2819@gmail.com> <CAFMvigfQ+XotjO_578LvSvycD3sbLcV_AP6A+B0U+ybApU2zGA@mail.gmail.com>
Subject: Re: Replacing disk strange (buggy?) behaviour - RAID1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Jonah Sabean <me@jse.io> -- Sent: 2021-04-21 - 02:23 ----

> Thanks for the reply, it's appreciated!
> 
>> Mounting raid1 btrfs writable in degraded mode creates chunks with
>> single profile. This is long standing issue. What is rather surprising
>> that you apparently have chunk size 819GiB which is suspiciously close
>> to 10% of 8TiB. btrfs indeed limits chunk size to 10% of total space,
>> but it should not exceed 10GiB. Could it be specific Ubuntu issue?
>>
>> So when you wrote data in degraded mode it had to allocate new chunk
>> with "single" profile.
> 
> That's strange as I didn't write actual data to the disk during that
> time. Perhaps Ubuntu wrote some hidden file or something to it, I have
> no idea, but I didn't interact with the filesystem beyond doing the
> replace after mounting it. Still... 10% of 8TiB may be what's
> happening and if so that's really strange... and massive. I'd don't
> think it was a single chunk equal to 10% though, as when I converted
> it to raid1, I specified the soft filter with `-dconvert=raid1,soft`,
> and the resulting output once it was complete was:
> 
> Done, had to relocate 825 out of 1648 chunks
> 
> So the hypothesis that it was one large chunk doesn't make hold up to
> me knowing that output. I thus assume the chunks were all 1GiB given
> that many. Unfortunately I didn't save the output of the balance with
> `-dusage=0`, but I do recall it being in the 800s as well.
> 
>> > Why didn't it free
>> > those up as it replaced the missing disk and duplicated the data in
>> > RAID1?
>>
>> Device replacement restored mirrored data (chunks with "raid1" profile)
>> on the new device. It had no reasons to touch chunks with "single"
>> profile because from btrfs point of view these chunks never had any data
>> on replaced device so there is nothing to write there.
>>
>> > Shouldn't it all be RAID1 once it's complete,
>> No. btrfs replace restores content of missing device. It is not
>> replacement for profile conversion.
> 
> Makes sense, knowing that I would expect that. I just have no idea why
> it allocated 800GiB, especially since I didn't write anything to the
> single disk during the convert process, much less ~800GiB.
> 
>> > Everything was RAID1 all up until the disk replacement, so it clearly
>> > did this during the `btrfs replace` process.
>>
>> No, it did it during degraded writable mount.
>>
>> > Did I do this wrong, or
>> > is there a bug?
>>
>> There is misfeature that btrfs creates "single" chunks during degraded
>> mount. Ideally it should create degraded raid1 chunks.
> 
> Hmm... would be nice to see this then. Is there a patch for it,
> assuming it's planned?
> 
> Thanks,
> -Jonah

I've been testing the replacement feature and in IMHO there is often (usually?) a single block group created when mounting a RAID1 or RAID10 filesystem degraded with a missing disk. 

I think this is because there will always be some metadata updates if you mount a filesystem rw,degraded with missing disks. 

And on principle I think it is correct. It clearly shows to the user that there is data not protected by redundancy. 

So I think we should simply amend the official docs to check for multiple profiles and issue a balance with soft filter. 

It is what I suggest on my personal wiki space https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk

Take care, stay safe. 

/Forza


