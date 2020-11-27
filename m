Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA72C5EB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 03:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392211AbgK0CRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 21:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392209AbgK0CRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 21:17:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051AC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 18:17:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p22so3785285wmg.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 18:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bM4K3jonKQ07aDVSLa9T4qKZV0xw80A7vE7k6wfXHEs=;
        b=GlNjWolu6a7HlN/XiOmIEzjvzM1FEBwD9c9MgfUGE1FvMd6o2tiSXuEalz3Ph6RYvN
         Dz/JFsTuNwCNW4ete5RJ0yaJ4PWbmzZEQDyu6Gf9vL/9a7pm0XqOQtDgx/CoQfRlHThL
         EA0as3M1j+UtlLdJA8tqy+Sz38nqXTIpGSWDul4iUBGPXWyDNMn/tyTlHcCnzEPlw/4e
         8HeWsKLcgg7hHNKooD3gNtZKdRBih+HSfh9s8H/+gSteHu9ZocyZJGjrtR3yFe6MTvJf
         J8e1PcPBDdegSxrzKk4u+eCTWJWjFeC61mcIt6rWfwmDKnh5WtXEz/btNoHKHyAwHrXd
         0SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bM4K3jonKQ07aDVSLa9T4qKZV0xw80A7vE7k6wfXHEs=;
        b=ZVfZL1g+YHXIN/p47jTvdBh8bS9cnVIv2Nz6UIngKFtUiieYc+RCxTmIyD2jZ+fag2
         OGNuJZwJK20wrlsA/CsKH707Usaw8aeBPVBxCvSRwehTsX8X5G/F0lhDge6zlLtQA+r8
         myCgX53/t3ZxF7H7m7cQFN16zKdDS8zdDcXTTE3cxxZ2U4GpBsIAQ+FAA3tp0+8Aimbs
         AziXwtnvRYwk+4Xygc86Xv6pq1vTelPQZBeHkjT5FUdgiTjNMPDMjxKdhZV+Mg7naGHu
         wxEzqGV1alTP0LJUZIry1iXDW1Fr1QM0Oz9LjGhXgHHkMPo0OBU/F2lq/whA/EJR+QY8
         pwVw==
X-Gm-Message-State: AOAM530iV6SUdM5bNKZujBKrbz+q5O3lFVfPSLuz6gaHhz9RgUvVrS/G
        SWyBOUyT3Iu1HWsNcfGOptRc+kRE9vKFZg==
X-Google-Smtp-Source: ABdhPJyOGfdcvBet13yISJikOwzCuQLjRYxyf8d0IqaAvtwCZB307d8aau7yu+lhxUlSpfsxo/qmZA==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr6315512wml.5.1606443427968;
        Thu, 26 Nov 2020 18:17:07 -0800 (PST)
Received: from ?IPv6:2a02:6d40:2b80:c700:9f1e:596f:842b:eef6? ([2a02:6d40:2b80:c700:9f1e:596f:842b:eef6])
        by smtp.googlemail.com with ESMTPSA id f23sm10606040wmb.43.2020.11.26.18.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 18:17:07 -0800 (PST)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fef04da3-fb9e-aca6-4bd4-965a1263c45e@googlemail.com>
 <CAJCQCtS5_oUiTi0u0Twjwea-92-tzj6HNsbwy37e=8iSVky2CQ@mail.gmail.com>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject: Re: Safe unmounting of external btrfs disk
Message-ID: <1c60c4a1-cff1-84a8-6acc-8f752aa5e265@googlemail.com>
Date:   Fri, 27 Nov 2020 03:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS5_oUiTi0u0Twjwea-92-tzj6HNsbwy37e=8iSVky2CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Thanks for the reply!

Am 27.11.20 um 00:38 schrieb Chris Murphy:
> On Thu, Nov 26, 2020 at 11:35 AM Oliver Freyermuth
> <o.freyermuth@googlemail.com> wrote:
>>
>> Dear BTRFS experts,
>>
>> I've had a rather strange occurence with my external BTRFS backup disk last night,
>> which makes me question what is the correct way to safely remove a USB drive with BTRFS on it.
>>
>> Here's the timeline:
>> - 02:00:00 am: btrbk starts running.
>> - 02:01:17 am: btrbk deletes the last old subvolume from the disk
>>                  (I have btrfs_commit_delete = no, so the delayed deletion basically starts some time after).
>> - ~02:18 am: I performn an "umount" of the disk.
> 
> How was this done? If it's "umount" on cli, what was the exact command
> and did it complete?

It was "umount" on the only mountpoint the device was mounted to.

Of course, I have to add at this point that everything is in my logs, apart from the "umount" command,
which is only in non-timestamped shell history.

Since the shell in which I ran "umount" was already closed when I checked the kernel logs,
it's only my memory we rely on here. While I am 98 % sure I entered the command, and only then unplugged the disk,
the same way I do it every day (unless the days I shut down the system and unplug then),
I give 2 % to my memory playing tricks on me and will bump that by +1 % each time I think about it
due to the unreliable way human brains work.

> 
>> - ~02:18:43 am: I unplug the USB drive.
>> - 02:25:05 am: My kernel tells me this:
>> [19268.944902] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> 
> This suggests the file system was not actually unmounted as far as the
> kernel was concerned, at the time the device was removed.
> 
>> Is this behaviour expected?
> 
> No, btrfs should block umount until it's done writing and flushing. It
> is still possible those writes are in the drive's write cache, and
> could get lost by disconnecting the drive before those writes are on
> stable media, but Btrfs wouldn't know about that and wouldn't
> complain. At next mount, it might know something went wrong only if
> the lost writes were out of order, like the super block was update on
> disk but the new trees it points to were lost. That'd be a drive bug,
> not a Btrfs bug.

That's what I had hoped and would have expected.
So indeed the only valid explanation up to this point would be that my memory played a trick on me.
The good news is: I usually do this test about once per day. So if it was *not* a human memory fault,
it will happen again.

>> If yes, how to "unmount" correctly (btrfs filesystem sync only seems to work on mounted filesystems)?
>> I believe udisks unmounts and then quickly removes power, so this would basically be similar to what I did manually here.
> 
> Enable scsi event tracing:
> 
> # echo "scsi:*" > /sys/kernel/debug/tracing/set_event
> 
> On an HDD (i.e. nossd mount option), for 'umount' I get a bunch of
> WRITE_10 commands that look like tree updates. Followed by
> SYNCHRONIZE_CACHE. And then I see two WRITE_10 commands that
> correspond to superblock 1 and 2. Followed by SYNCHRONIZE_CACHE. And
> then one WRITE_10 for the 3rd superblock. That's it. And that should
> be sufficient and nothing else happens after that - all of this is
> blocking until it's done, as in, the drive itself claims the command
> is done.

I can confirm the very same observations here, thanks for the nice explanation
of what these translate to!

> 
> For this command:
> 
> # echo 1 > /sys/block/sdb/device/delete
> 
> I see two commands, SYNCHRONIZE_CACHE and START_STOP. That's it.
> 
>  From this I conclude umount should be sufficient. I'm not certain
> deleting the device is really necessary but it doesn't hurt.
> 

Ok!
Then I will go this way from now on. If I manage to reproduce this with may daily "detach the backup disk"
routine, it should show up again soon. If now, I have to run a memtest86 on my brain,
too bad these are not CoW and can not be scrubbed...

Cheers and thanks,
	Oliver
