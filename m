Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15731F333
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 00:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBRX6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 18:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBRX6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 18:58:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D54C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 15:57:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a132so5228799wmc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 15:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5qqSqK/SoOLw+TsCqefUyjPihEfTtVASAB1PPVQtpg=;
        b=aM+FQIxjy0v5OvnTqCOA4fXI3Haz+CqAcjxQK5tOHmMDUD9SwLqoCxg6CM4HDs5t+8
         FoeElCJLKPayAc/1dgvEc8zQS2cHbZhx/w3exZTjMKqF3/pfabb8InJSRx2K2hfAqOwV
         S58Jo7bS7Ei9hWDPwBkX7yXpZZ6xc4vGN48zo/RYnFWvElbYML5RCQSaFr0m3vtl6/Sz
         PvrylZaL4wT+sH5etTPumKi7+nj3UUBf+VXI5FNWst8A8a/PBrjbVJZjADEENDNe/Zs+
         Ygty6gbA4+AhIgGeAIpv59bNJwZehfOIIDFwGf2VYphf7Zn0Ur9P0e0GNoaYSzZizfZs
         2fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5qqSqK/SoOLw+TsCqefUyjPihEfTtVASAB1PPVQtpg=;
        b=Q7aJqp9pinJoDGOENR6YxyCXHXDFjUdmMWh8SdVTyf7GqJAGkAP62sPCN3uxmnkwWs
         HrU6UScnHU7yNV4BvpaWK0QQA9vFZT2RYMG3gEpTzsSbIz96iogm+ScrMUmDkr/PVsq0
         MYlr7cvlb3ybr+032Jv81pfe0vAPdRGHieat7dfKRNKmMXXPPVF9kdeAYG/Uada5LL5L
         BFzTFkGnSv+qHRQbH2vzpynaaVf49Z/nc9EkCWXmZkRuU9fah7SJktQJ3eGfQKPRaBvn
         HcN4CqDR5PdSvtJKJQw5pR/J0mpQaQwhxbmqnEjrX4CGU2xObUmFfOtBi4dxxnHZVlRi
         FTrA==
X-Gm-Message-State: AOAM5311Lo79d/rbSu+HGqdk/IJM3HI26OpmTkqn5uyiCYV90dTAR10G
        hBterMy16aKkY5t/jvQU3JJLAuOvZ9wx+jXcN2g/dw==
X-Google-Smtp-Source: ABdhPJwGbhyA1RGQKlWrdZVZbGAeP6WI7plVOXhAQLWSYsgVLD72DCWA/9LxmUcKMpUItDbEpI9V0ouozquGMX8WEDQ=
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr5610512wmj.182.1613692658550;
 Thu, 18 Feb 2021 15:57:38 -0800 (PST)
MIME-Version: 1.0
References: <83750bf0-19a8-4f97-155c-b3e36cb227da@gmail.com>
In-Reply-To: <83750bf0-19a8-4f97-155c-b3e36cb227da@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 18 Feb 2021 16:57:22 -0700
Message-ID: <CAJCQCtQGyHJjPwmKxwxCBptfeb0jgdgyEXF=qvGf-1HBDvX1=w@mail.gmail.com>
Subject: Re: corrupt leaf, unexpected item end, unmountable
To:     Daniel Dawson <danielcdawson@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 7:43 PM Daniel Dawson <danielcdawson@gmail.com> wrote:
>
> I was attempting to replace the drives in an array with RAID6 profile.

metadata raid6 as well?

What replacement command(s) are you using?


> The first replacement was seemingly successful (and there was a scrub
> afterward, with no errors). However, about 0.6% into the second
> replacement (sdc), something went wrong, and it went read-only (I should
> have copied the log of that somehow). Now it refuses to mount, and a
> (readonly) check cannot get started.
>
>
> # mount -o ro,degraded /dev/sda3 /mnt
> mount: /mnt: can't read superblock on /dev/sda3.
> # btrfs rescue super-recover /dev/sda3
> All supers are valid, no need to recover
>
>
> For this, dmesg shows:
>
> [  202.675384] BTRFS info (device sdc3): allowing degraded mounts
> [  202.675387] BTRFS info (device sdc3): disk space caching is enabled
> [  202.675389] BTRFS info (device sdc3): has skinny extents
> [  202.676302] BTRFS warning (device sdc3): devid 3 uuid
> 911a642e-0a4c-4483-9a1f-cde7b87c5519 is missing
> [  202.676601] BTRFS warning (device sdc3): devid 3 uuid
> 911a642e-0a4c-4483-9a1f-cde7b87c5519 is missing

What device is devid 3?


> [  202.985528] BTRFS info (device sdc3): bdev /dev/sdb3 errs: wr 0, rd
> 0, flush 0, corrupt 26, gen 0
> [  202.985533] BTRFS info (device sdc3): bdev /dev/sdd3 errs: wr 0, rd
> 0, flush 0, corrupt 98, gen 0
> [  203.278131] BTRFS info (device sdc3): start tree-log replay
> [  203.454496] BTRFS critical (device sdc3): corrupt leaf: root=7
> block=371567214592 slot=0, unexpected item end, have 16315 expect 16283
> [  203.454499] BTRFS error (device sdc3): block=371567214592 read time
> tree block corruption detected
> [  203.454634] BTRFS critical (device sdc3): corrupt leaf: root=7
> block=371567214592 slot=0, unexpected item end, have 16315 expect 16283
> [  203.454636] BTRFS error (device sdc3): block=371567214592 read time
> tree block corruption detected
> [  203.455794] BTRFS critical (device sdc3): corrupt leaf: root=7
> block=371567214592 slot=0, unexpected item end, have 16315 expect 16283

16315=0x3fbb, 16283=0x3f9b, 16315^16283 = 32 or 0x20

11111110111011
11111110011011
        ^

Do a RAM test for as long as you can tolerate it, or it finds the
defect. Sometimes they show up quickly, other times days.


> [  203.455796] BTRFS error (device sdc3): block=371567214592 read time
> tree block corruption detected
> [  203.455820] BTRFS: error (device sdc3) in __btrfs_free_extent:3105:
> errno=-5 IO failure
> [  203.455823] BTRFS: error (device sdc3) in
> btrfs_run_delayed_refs:2208: errno=-5 IO failure
> [  203.455833] BTRFS: error (device sdc3) in btrfs_replay_log:2287:
> errno=-5 IO failure (Failed to recover log tree)
> [  203.747758] BTRFS error (device sdc3): open_ctree failed
>
>
> I've looked for, but can't find, any bad blocks on the devices. Also, if
> it adds any info...
>
> # btrfs check --readonly /dev/sda3
> Opening filesystem to check...
> warning, device 3 is missing
> checksum verify failed on 371587727360 found 000000FF wanted 00000049
> checksum verify failed on 371587727360 found 00000005 wanted 00000010
> checksum verify failed on 371587727360 found 00000005 wanted 00000010
> bad tree block 371587727360, bytenr mismatch, want=371587727360,
> have=1076190010624
> ERROR: could not setup extent tree
> ERROR: cannot open file system
>
>
> Note: I'm running this off of System Rescue 7.01, which has earlier
> versions of things than what the machine in question has installed (the
> latter being Linux 5.10.16, with btrfs-progs v5.10.1).
>
> # uname -a
> Linux sysrescue 5.4.78-1-lts #1 SMP Wed, 18 Nov 2020 19:51:49 +0000
> x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.4.1
> # btrfs filesystem show
> Label: 'vroot2020'  uuid: 5214d903-783a-4d14-ac78-046da5ac1db7
>         Total devices 4 FS bytes used 65.98GiB
>         devid    0 size 457.64GiB used 39.53GiB path /dev/sdc3
>         devid    1 size 457.64GiB used 39.56GiB path /dev/sda3
>         devid    2 size 457.64GiB used 39.56GiB path /dev/sdb3
>         devid    4 size 457.64GiB used 39.53GiB path /dev/sdd3


This is confusing. devid 3 is claimed to be missing, but fi show isn't
showing any missing devices. If none of sd[abcd] are devid 3, then
what dev node is devid 3 and where is it?

But yeah you're probably best off not trying to fix this file system
until the memory is sorted out.


-- 
Chris Murphy
