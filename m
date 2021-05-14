Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3CE380E5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhENQpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhENQpa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 12:45:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D8DC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 09:44:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g4so14497407lfv.6
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a3/4NP0KBXWuCUJP02PJpRNlDvQa7pQKIs1cFfndlxA=;
        b=QX4uMv3HDEhLtAFY84rfXw/ODYuedh4kkyFgdBzngxRrCBOpGQ8f4Rh0VXUdHWZH6R
         0IsdlSCCQrj8NLYbtQh8Ri9wVzh7APo8MVI5HmyNBh/aSTFPpF6G5BVmCYZ62pDWnihG
         4dDj9LWk3z29N/tbkOhZIFz8PXQ5w0CQHhgHKPARr36IoiMpUuLzz0Ts4CUcC5UmBZwk
         oowCbzI5i2i2FJ0gT0/8J4XCeBxDZYZagawDqDhii0ZIKr/1rFls/0wZ+h7AMLHkUKvl
         9IptqIriK2qZ++sFkJOpdORG7AC8f9smcbkH52IFfbcTv41u/FP1BtFuHEd4VR4M+X8V
         cDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a3/4NP0KBXWuCUJP02PJpRNlDvQa7pQKIs1cFfndlxA=;
        b=Q/U+yxoxYNOWZS3pmSZ7qs8mBKi0DNoK5lubK9ef5qCdMg5+xx0gVCwPxCHGGJBudo
         iDbnQP2WtapsdtQ+1voHcWe4Y7b7AylEG6Rz+xYrrrbdyxe7+3ak9ikmMIW3V8Uizz1b
         VQjA2XEeR8fHqh1EoXeImHgDwjkXSXZV1duKOgIrHJQCq8sG5ZYXPP1MidguSPFlRYjc
         /CI5+wnmW9p0jksViQk4AYonGg6vY5E1VQkT2OeKCJYJi7U7soPlcsHdUtnIQ/CT3vTE
         tUVYz+8Hl1Tbxr23i/8+XFjtDGOOfYgQGkdVUO+4aMZ7iJuhtqEQEvpPyujUk8Ovmtx2
         VW5w==
X-Gm-Message-State: AOAM533dp9gzD9z9IKAlliMTuDR2gmm4tLrCJyiWg7aft6x43gTIdwH3
        QqEpqFywIuvk79wZ67UJYbwY4xWfkM0UzQ==
X-Google-Smtp-Source: ABdhPJxen8KbypxwCOIIzW19OZ/hZS8lQCjnzj4YkLWBLLt5GQgug7lbhqWProe2nyMT42MQbYUDrQ==
X-Received: by 2002:a05:6512:3f9d:: with SMTP id x29mr32187428lfa.363.1621010655373;
        Fri, 14 May 2021 09:44:15 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:be19:6dbd:a91:f761:1766? ([2a00:1370:812d:be19:6dbd:a91:f761:1766])
        by smtp.gmail.com with ESMTPSA id d5sm816325lfi.144.2021.05.14.09.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 09:44:15 -0700 (PDT)
Subject: Re: Removal of Device and Free Space
To:     =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <b8e03f9a-19b0-9df0-6f06-7aa9bbd35e68@gmail.com>
Date:   Fri, 14 May 2021 19:44:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.05.2021 11:54, Christian Völker wrote:
> 
> Hi all,
> 
> I am running a three device DRBD setup (non-RAID!).
> When I do "df -h" I see loads of free space:
> 
> root@backuppc:~# df -h
> [...]
> /dev/mapper/crypt_drbd2          2,8T    1,7T  1,1T   63% /var/lib/backuppc
> 
> As written, the fs consists of three devices:
> 
> root@backuppc:~# btrfs fi sh /var/lib/backuppc/
> Label: 'backuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
>         Total devices 3 FS bytes used 1.70TiB
>         devid    3 size 799.96GiB used 799.96GiB path dm-5
>         devid    4 size 1.07TiB used 1.07TiB path dm-4
>         devid    7 size 899.96GiB used 327.00GiB path dm-6
> 
> root@backuppc:~# btrfs fi usage /var/lib/backuppc/
> Overall:
>     Device size:                   2.73TiB
>     Device allocated:              2.61TiB
>     Device unallocated:          128.00GiB
>     Device missing:                  0.00B
>     Used:                          1.70TiB
>     Free (estimated):              1.03TiB      (min: 1.03TiB)
>     Free (statfs, df):             1.03TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:2.60TiB, Used:1.69TiB (65.17%)
>    /dev/mapper/crypt_drbd2       790.93GiB
>    /dev/mapper/crypt_drbd1         1.07TiB
>    /dev/mapper/crypt_drbd3       774.96GiB
> 

That does not match the output of above. "btrfs fi sh" claims drbd3 has
327GiB allocated and "btrfs fi us" claims it is 774GiB. Not sure how it
is possible.

> Metadata,single: Size:9.00GiB, Used:3.95GiB (43.91%)
>    /dev/mapper/crypt_drbd2         6.00GiB
>    /dev/mapper/crypt_drbd1         3.00GiB
> 
> System,single: Size:32.00MiB, Used:320.00KiB (0.98%)
>    /dev/mapper/crypt_drbd2        32.00MiB
> 
> Unallocated:
>    /dev/mapper/crypt_drbd2         3.00GiB
>    /dev/mapper/crypt_drbd1         1.03MiB
>    /dev/mapper/crypt_drbd3       125.00GiB
> 
> So it tells me there is an estimated of ~1TB free. As the crypt_drbd3
> device has a size of 899G I wanted to remove the device. I expected no
> issue as "Free" shows 1.03TiB. There should still be 200GB of free space
> afterwards.
> But the removal failed after two hours:
> 
> root@backuppc:~# btrfs dev remove /dev/mapper/crypt_drbd3
> /var/lib/backuppc/
> ERROR: error removing device '/dev/mapper/crypt_drbd3': No space left on
> device
> 
> Now it looks like this:
> root@backuppc:~# btrfs fi usage /var/lib/backuppc/
> Overall:
>     Device size:                   2.73TiB
>     Device allocated:              2.17TiB
>     Device unallocated:          572.96GiB
>     Device missing:                  0.00B
>     Used:                          1.70TiB
>     Free (estimated):              1.03TiB      (min: 1.03TiB)
>     Free (statfs, df):             1.03TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:2.17TiB, Used:1.69TiB (78.24%)
>    /dev/mapper/crypt_drbd2       793.93GiB
>    /dev/mapper/crypt_drbd1         1.07TiB
>    /dev/mapper/crypt_drbd3       327.00GiB
> 

And now it actually matches.

> Metadata,single: Size:9.00GiB, Used:3.89GiB (43.23%)
>    /dev/mapper/crypt_drbd2         6.00GiB
>    /dev/mapper/crypt_drbd1         3.00GiB
> 
> System,single: Size:32.00MiB, Used:288.00KiB (0.88%)
>    /dev/mapper/crypt_drbd2        32.00MiB
> 
> Unallocated:
>    /dev/mapper/crypt_drbd2         1.03MiB
>    /dev/mapper/crypt_drbd1         1.03MiB
>    /dev/mapper/crypt_drbd3       572.96GiB
> 
> 
> So some questions arise:
> 
>     Why can btrfs device remove not check in advance if there is enough
> free space available? Instead of working for hours and then failing...
> 

Because nobody implemented it? I suspect it may not be entirely trivial
in general case and any estimation you do may become obsolete very fast
(your filesystem is in use and so space that was free may suddenly
become allocated when you need it).

>     Do I have to balance my fs after the failed removal now?
> 

Yes. Device removal moves whole chunks from device to be removed to
other devices. You need as much *unallocated* space on two remaining
devices as it allocated on device you are trying to remove.

btrfs balance start -d usage=0

would be a good starting point.

>     Why is it not possible to remove the device when all information
> tell me there is enough free space available?
> 

btrfs is using two stage allocator. Free space includes both unused
allocated space and unallocated space. Only the latter can be used for
device removal.

>     What is occupying so much disk space as the data only has 1.7TB
> which should fit in 1.8TB (two) devices? (no snapshot, nothing special
> configured on btrfs). Looks like there are ~400GB allocated which are
> not from data.
> 

It is your data, how do we know?

> Just for completeness:
> 
> Debian Buster
> 
> root@backuppc:~# btrfs --version
> btrfs-progs v5.10.1
> 
> Thanks for letting me know.
> 
> 
> Greetings
> 
> /CV
> 
> 
> 

