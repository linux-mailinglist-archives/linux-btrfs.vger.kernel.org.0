Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AEDBBD78
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 22:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502894AbfIWU7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 16:59:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38741 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502893AbfIWU7V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 16:59:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so10736312wmi.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AfG+/CtktRAjWIxxkOJwXVeko0RkG6PAKfhEVpcMCeo=;
        b=eXMfPeXbjQauk963salqeBj9B8IxnQVQaBdBQJ1OlogHUYKMxQYYyreNHpzHRKWZOy
         mv+ZH718WwGArRr2u9ij/6BiCPa7ObkYx2b4xSzA+uvTE94KK7BfBAP3O9MJ4HE+VX6J
         g0QwxxmGdJHruqno9bT9ePuk89fh4ffUbJoH0f+JXUnAsmffZW+fc84wOXAJZS5citl/
         XQEcxTjailrOiXIflNu/+7+8iosLznprwav3ROsC/p3OW7C5yF7aBbshJx8luQV0gujy
         /ism2G9HpvCQf3+ud3gJJNNLPipubzH8e/lLrQ/AboAZtrxp6YIccGRBd6ePj4TdyFNh
         r3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AfG+/CtktRAjWIxxkOJwXVeko0RkG6PAKfhEVpcMCeo=;
        b=tJ5gYjyZml07gAe27c1nSPhipByvAOuVjRkzMcqWegyUcpYqCBbbqFvx0FBuiHDAre
         yQ519NY2dxhHc+RvL6z+OJX2TXKCXB/S+9eqlpfMnthqr4I3h7Jn5HB87WvXXuQc5oFz
         e6PiC+M+bGbe0Eax+xKn9GxQHMizWZ6YLxPfJvRzztsMdEFFp5DdEtflkDz/XHuqIpZL
         Jc1xYk6XbdZzzGAHZ0bPUS4togwd/CQnAFWx3poGM1vrKKKw6S9WxsAMJ84ZejXUHqJt
         296kb/46q46Ab46YRVkVIE1EQjTt/xwvEu/y+4XowHpyvgU373Ew/EtnNFCMR/g5b7c/
         gH0w==
X-Gm-Message-State: APjAAAU88ohoFgOa9Cr1EtbVtDCvOO7kgX0ws0B1v+QIs3vLQV5hvt+n
        F09V/bg8ssJsoLc6BNBYUuFDYzWoWsr1D0BK5q+aQw==
X-Google-Smtp-Source: APXvYqwdwVoIcmnRhC9C+Yv85hi8GYr9LeLeLR/NZSmjprimIM0Oi8+KUt5JD6dG4jEw7ETp2LskVWl9Y5I4aVHkuj8=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr1095292wma.66.1569272359278;
 Mon, 23 Sep 2019 13:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com>
 <003f01d5724c$f1adae30$d5090a90$@gmail.com>
In-Reply-To: <003f01d5724c$f1adae30$d5090a90$@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 23 Sep 2019 14:59:08 -0600
Message-ID: <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
Subject: Re: BTRFS checksum mismatch - false positives
To:     hoegge@gmail.com
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 2:24 PM <hoegge@gmail.com> wrote:
>
> Hi Chris
>
> uname:
> Linux MHPNAS 3.10.105 #24922 SMP Wed Jul 3 16:37:24 CST 2019 x86_64 GNU/L=
inux synology_avoton_1815+
>
> btrfs --version
> btrfs-progs v4.0
>
> ash-4.3# btrfs device stats .
> [/dev/mapper/vg1-volume_1].write_io_errs   0
> [/dev/mapper/vg1-volume_1].read_io_errs    0
> [/dev/mapper/vg1-volume_1].flush_io_errs   0
> [/dev/mapper/vg1-volume_1].corruption_errs 1014
> [/dev/mapper/vg1-volume_1].generation_errs 0

I'm pretty sure these values are per 4KiB block on x86. If that's
correct, this is ~4MiB of corruption.


> Concerning self healing? Synology run BTRFS on top of their SHR - which m=
eans, this where there is redundancy (like RAID5 / RAID6). I don't think th=
ey use any BTRFS RAID  (likely due to the RAID5/6 issues with BTRFS). Does =
that then mean, there is no redundancy / self-healing available for data?

That's correct. What do you get for

# btrfs fi show
# btrfs fi df <mountpoint>

mountpoint is for the btrfs volume - any location it's mounted on will do



> How would you like the log files - in private mail. I assume it is the ke=
rn.log. To make them useful, I suppose I should also pinpoint which files s=
eem to be intact?

You could do a firefox send which will encrypt it locally and allow
you to put a limit on the number of times it can be downloaded if you
want to avoid bots from seeing it. *shrug*

>
> I gather it is the "BTRFS: (null) at logical ... " line that indicate mis=
match errors ? Not sure why the state "(null"). Like:
>
> 2019-09-22T16:52:09+02:00 MHPNAS kernel: [1208505.999676] BTRFS: (null) a=
t logical 1123177283584 on dev /dev/vg1/volume_1, sector 2246150816, root 2=
59, inode 305979, offset 1316306944, length 4096, links 1 (path: Backup/Vir=
tual Machines/Kan slettes/Smaller Clone of Windows 7 x64 for win 10 upgrade=
.vmwarevm/Windows 7 x64-cl1.vmdk)

If they're all like this one, this is strictly a data corruption
issue. You can resolve it by replacing it with a known good copy. Or
you can unmount the Btrfs file system and use 'btrfs restore' to
scrape out the "bad" copy. Whenever there's a checksum error like this
on Btrfs, it will EIO to user space, it will not let you copy out this
file if it thinks it's corrupt. Whereas 'btrfs restore' will let you
do it. That particular version you have, I'm not sure if it'll
complain, but if so, there's a flag to make it ignore errors so you
can still get that file out. Then remount, and copy that file right on
top of itself. Of course this isn't fixing corruption if it's real, it
just makes the checksum warnings go away.

I'm gonna guess Synology has a way to do a scrub and check the results
but I don't know how it works, whether it does a Btrfs only scrub or
also an md scrub. You'd need to ask them or infer it from how this
whole stack is assembled and what processes get used. But you can do
an md scrub on your own. From 'man 4 md'

 "      md arrays can be scrubbed by writing either check or repair to
the file md/sync_action in the sysfs directory for the device."

You'd probably want to do a check. If you write repair, then md
assumes data chunks are good, and merely rewrites all new parity
chunks. The check will compare data chunks to parity chunks and report
any mismatch in

"       A count of mismatches is recorded in the sysfs file
md/mismatch_cnt.  This is set to zero when a scrub starts and is
incremented whenever a  sector "

That should be 0.

If that is not a 0 then there's a chance there's been some form of
silent data corruption since that file was originally copied to the
NAS. But offhand I can't account for why they trigger checksum
mismatches on Btrfs and yet md5 matches the original files elsewhere.

Are you sharing the vmdk over the network to a VM? Or is it static and
totally unused while on the NAS?



Chris Murphy
