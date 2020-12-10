Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774D62D65D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 20:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbgLJTDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 14:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390799AbgLJTDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 14:03:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBCC0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 11:02:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 3so6403434wmg.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2adLtIK2GZntBA44Bcw1mMDYm7TKPgtgYgXsvLB7rg=;
        b=qtlQuOIwTySrVGDMeQ1pFtdW8lqZKQycD+fP0QpWthNItRlmW9aiO9Hkqe1m11FS0k
         qhIFPFK5lrrW+1XujH9fbdh4P8NyQM6vvLBijpPOMK0ofntFch364wE9xXGmhvMKyCC8
         nmec50uqN/hujKnklgKpWu/vwGUAWvwgWnXu4L27/3SkXkGfqonR7rZ09RW3RdTDMi8z
         j7hKv+IJ/SPXp8ETSujnOIzFw3y34Vj7KVJLKLv/iYaLfHDrbpQn+7+tXX/NijvYKCCR
         FXxsBZk26+QsVk8ywWU2Gx9aDDMGqufSWaYejpE/fumADwpaWNrP4kN44d6L6vCtGI4m
         t/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2adLtIK2GZntBA44Bcw1mMDYm7TKPgtgYgXsvLB7rg=;
        b=AFn837/JsfHv7pxuqz+eWvEsINc/sgj59PxCzzkuppR1K60jI43OX4jKFaay9/nA10
         26wMxvxOl0uFZAYZL69U4XzHvTl1vsNoPk/JXFKC2d/e+AbOrkiev4TRC95kv2mmSVnX
         uGwKNydcqWp5EQLaRXiM6/Dw3Y4VcXSe1d3YoMEeqWZz1WdJIP/uAwBI1IIEXUEFrDtK
         jpfTQ7sxIoOhl1ptV1gZOF8ZH/Nihmghr4v80wRMSsyiFKyunWiaZuU9cDhAM61x/wsF
         ozRDr2vufODkO+U2/jNN3ZgdCtjE8OSnm2/OeL9rJRriChgUS+NBaRKRDzPMkf2iX71M
         cRWQ==
X-Gm-Message-State: AOAM532aMwKy70yGCq5qMSw/Z3ptVsXE68PblkhCyiUK9t7ClHwtFsN+
        zcVgFaH4n42NJtE/YFwEY38cxJe9SBzenHyyUbD5Pg==
X-Google-Smtp-Source: ABdhPJyoyWSdaJdvMQW2ATb65/xgcUwKUSuvWcsgUNs7uvo22teWzYeYnUzNYxWxnegANohqrUvFg0NhDKAV9RI2Cqk=
X-Received: by 2002:a1c:7710:: with SMTP id t16mr9548773wmi.11.1607626970246;
 Thu, 10 Dec 2020 11:02:50 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
In-Reply-To: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 10 Dec 2020 12:02:34 -0700
Message-ID: <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com>
Subject: Re: btrfs swapfile - Not enough swap space for hibernation.
To:     Sreyan Chakravarty <sreyan32@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 4:30 AM Sreyan Chakravarty <sreyan32@gmail.com> wrote:
>
> Hi,
>
> I have a swapfile in a swap subvolume, I have used the
> btrfs_map_physical script to get the resume_offset, and the swap file
> was created with the +C attribute.
>
> But when I try to do a `systemctl hibernate`
>                  Not enough swap space for hibernation.

If the journal doesn't have more information about why it says this,
and if the error is reported in the journal by systemd-logind, enable
debug logging for logind and reproduce and the try to figure out why
logind is complaining:

https://github.com/systemd/systemd/issues/15354#issuecomment-610385478

There is a possibility there isn't enough contiguous space in the
swapfile for the hibernation image. i.e. when you fallocate the
swapfile, it may be comprised of one or even dozens of separate
extents and if one of them isn't big enough for hibernation entry then
it'll always fail.

As far as I'm aware there isn't a way to ask fallocate for a minimum
extent size. I've sometimes had to fallocate multiple files in a row
to get a swapfile with few fragments and then delete the rest.

You can use filefrag -v to see the extent sizes. Those extents are
basically holes that swap code writes into. The swap code isn't
writing swap or hibernation images via Btrfs. It's just asking Btrfs
"what are the ranges and locations I can use" and Btrfs reports that
and then the swap and hibernation code use those areas directly.


> $ lsattr /var/swap/fedora.swap
> ---------------C---- /var/swap/fedora.swap

> UUID=7d9dbe1b-dea6-4141-807b-026325123ad8 /var/swap
>    btrfs   subvol=swap,rw,nodatacow,noattime,nosuid,x-systemd.device-timeout=0

OK you're confused. You do not need both chattr +C on the file and the
nodatacow option. You only need one of those. You should realize that
the nodatacow option applies file system wide. It's non-obvious but
really only the VFS mount options can apply separately to bind mounts.
And on Fedora, since subvolumes are mounted to specific mounts points
and are thus effectively bind mounts behind the scenes, it seems like
you can apply some mount options to specific subvolumes as if they are
separate file systems. But that's not what's going on, they're just
bind mounts. So you can do atime for one mount point, noatime for
another. And same for ro or rw. Those are VFS options. The Btrfs mount
options apply file system wide, that includes nodatacow, compress, and
so on.

Further problem now that you're using nodatacow is that you have a
bunch of nodatacow files that have been created in the meantime. And
those do *not* have chattr +C so you have no easy way to find them.
You'd have to parse 'btrfs inspect-internal dump-tree' for the
nodatacow flag.

nodatacow files are also no compression and no data checksums. So I'm
betting this is not what you want.




-- 
Chris Murphy
