Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173AF2D1DE2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 23:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgLGW6t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 17:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgLGW6t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 17:58:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35FBC061793
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 14:58:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id x22so654434wmc.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 14:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YvZDFeHVuNW2Fi5ulaDGg7YvUsrFN8E+IH0zHk7qsM=;
        b=mZ6vHOLI7EiyDjyRyth62BsqenR4QJW2aBQkAKvzgUaJJcm1WbScYKVNa9jQa6Nu7T
         czunfZe2/r1QLV2jPZ3Tp/FPNmJE/Ec4y7QV7jaNN+Y3QpYhZ8mknFZ4cz4k50aFaKc+
         ai8VMI5Hyl8ESh8zi6+m+U1E1gonyGKuznUZjX2b4Z6f4B9Iv/GhnQ+haCUAGWy+cZHy
         nxtFrVYFQR/RRH6/mrw1+h4YVYvoWL1ELhhFHYRb3UpriO8LqzjQBBc4PGrCLthaWByd
         JjI3IiO5WAGfsWGCgrL9f5INMexFCq/cT9JhMjSDqzgQomMm/Nbjb2YFFjL9XCM8FrQG
         k/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YvZDFeHVuNW2Fi5ulaDGg7YvUsrFN8E+IH0zHk7qsM=;
        b=Yv0ViRrwL1p4xq+x9MpM2sHc36QQz5ZMb327P22SIvJUK2j0xywWDZIio17kfKFyp/
         k1MNA6g/471CkFS4s02E7bueIfSckUorAaAvgzuGBLyBrGcZXYcsJMOhvyAiaRQm3eaB
         sLX7Kak6tSQMnQU4OMo6nyTSNm61KZTWK+hWl3ODp+Q2YtwwN5caFVLLkrSithMpU5De
         A1u3MMoh9/OXaSa4X26aXTvIFkipDM8UPFt+yDrhv0eUKwBKEovAu0aohrbFa3GucsP6
         mZhsbAQy+RmwnKvCQ06FlhtmEGWu2qXm9sd9X6X6Mla4kpN83O8NsI1+J6/kWHxIlnv3
         7uvw==
X-Gm-Message-State: AOAM532lTI0vq728odhOpDNcSYUffXyTG+q+a1CFn92zRs2j0rsCJYNJ
        unDqMdetY+ITlhJVylgD1cCGgBQKbMGb4W1tdDHgG6ZES5FrcA==
X-Google-Smtp-Source: ABdhPJzplB5qsEbV/l9OK4hWXF0sszCyeESWijTXGGXOwR5Qa7hSyHNV0wn9467uQIIQcq6PVhJEqe/ce12AzgCJpM8=
X-Received: by 2002:a1c:7710:: with SMTP id t16mr1030706wmi.11.1607381887707;
 Mon, 07 Dec 2020 14:58:07 -0800 (PST)
MIME-Version: 1.0
References: <CAAdkh9xzT=wYY3jui3d4xF4kp20tB5EiL-KBJdMK69h1oWO3ig@mail.gmail.com>
In-Reply-To: <CAAdkh9xzT=wYY3jui3d4xF4kp20tB5EiL-KBJdMK69h1oWO3ig@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 7 Dec 2020 15:57:51 -0700
Message-ID: <CAJCQCtTXDufgm=ZYR4K7+-O_g=ztR9DDTUxCM67mKQRPGtWrWQ@mail.gmail.com>
Subject: Re: data Raid6 with metadata Raid1c3 appears unrecoverable
To:     Marcus Bannerman <m.bannerman@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 7, 2020 at 6:35 AM Marcus Bannerman <m.bannerman@gmail.com> wrote:
>
> Help!
> I have an array of 4x6Tb and 4x3Tb disks on BTRFS. I noticed I was
> getting csum errors in dmesg, and found that one of the 3Tb drives was
> failing. Smartctl reported a lot of read errors on one device. Short
> tests were failing at 90%, but SMART status was still OK(!). I tried
> removing the drive with a plan to then rebalance as I don't currently
> have a spare drive.
>
> $ btrfs devices remove /dev/sdX /raid
> ERROR: error removing device 'missing': Input/output error

There should be kernel messages at this same time.

Also, this is quite an expensive operation because it involves a file
system shrink, and restripe to the remaining devices. You're better
off leaving it degraded,rw  while waiting for the replacement drive
and using 'btrfs replace' to replace the bad drive.


>
> A lot of searching doesn't seem to give any advice on how to address
> this. Most are comments that you should wipe, but I'm hoping the raid
> will allow a partial recovery to save me time.
>
> So I tried running a scrub, to see if it can fix the system to allow
> me to remove the drive, maybe the errors are localised as Smartctl
> reports the drive is still "OK" despite increasing read errors, then I
> can remove the drive. The scrub starts reporting a lot of
> uncorrectable errors, dmesg is full of errors from the device that is
> failing. The scrub slows considerably and is telling me the scrub will
> take at least a week to complete (5.7Tb of data on the array) and the
> ETA is moving further away.
>
> So cancel the scrub, I shut the computer down, pull the drive, and try
> removing the device using the following command:
>
> $ btrfs devices remove missing /raid
> ERROR: error removing device 'missing': Input/output error
>
> Still no luck. Why can't I remove a failing drive from the array?

Need dmesg. Ideally all kernel messages from the start of the problem,
e.g. journalctl --since=-5d -o short-monotonic --no-hostname -k >
journal.txt




>
> Performing a scrub at this point gives 100% uncorrectable errors.
>
> I can still mount the drive, and access the data. I get errors like
> this on mount:
>
> [13044.573841] BTRFS warning (device sdd): devid 7 uuid
> 27b4ab26-ac60-4bc7-a8a7-ab1d87394512 is missing
> [13044.604734] BTRFS info (device sdd): bdev (efault) errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912020, gen 0
> [13044.604736] BTRFS info (device sdd): bdev /dev/sde errs: wr 0, rd
> 14, flush 0, corrupt 0, gen 0
> [13053.524470] BTRFS error (device sdd): csum mismatch on free space cache

That's space cache v1, which is stored in data block groups, which
means it's raid6, and subject to reconstruction by parity. And that
this is failing suggests at least one instance of bad parity, which
suggests something like a crash or power fail has happened and a scrub
hasn't been done since. So now it's in a difficult situation. Ideally
this setup should use space_cache=v2 which stores it as a b-tree in
metadata block groups, and is overall more resilient as well as being
subject to raid1c3 in this case.

But yeah don't change it now. The array needs to be healthy first. It
is possible to mount with 'clear_cache,nospace_cache' to avoid using
space cache entirely for now. That'll stop using the problem cache and
won't create a new one.


-- 
Chris Murphy
