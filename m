Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6FD1C7E1A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgEFXm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgEFXm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 19:42:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36604C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 16:42:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so4647716wmh.3
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQfgFqdgSqFMGGIxn9aTiS9O/SC+wyadcGtirAdIuaM=;
        b=MawTD28mgCSjaRB8YN1kyx3NmDkq6hqV+LnM945ZMwN2xtfDD7qLOuvISKIqRT+xQ1
         S3095NPqjW66IHOcLjZEtfxF8+wg19DSBH8QFfZiivdKf3ySP9v/o4pmKVN6bO/gvDZb
         ceEg2IfQ0yOu704jr4YvvYwBDF7nvx5X84PGcCmL17kES8OErDVqJcuDO69Leg4YsSB8
         K8ctu+P1FbtdHlDNwR60qZypVmfWlfsZoVGvCfA1LqWmxaucEGVNAn7xsdK71FQhzxo5
         4TBQB00xr1nYcuFnCYvh3TSoPmHDFUmk4nSlxMJVnkFGfZnEud33Q+d1NFTCWq7mJBmp
         6yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQfgFqdgSqFMGGIxn9aTiS9O/SC+wyadcGtirAdIuaM=;
        b=SabtpvH6DDqREH9b6Qnie+p8vhFXDpkjcsmshHyolg9n/BcL2qWcbxzEsaCosopqpI
         03wdbrOMjyBckOYYRH29FV02au7gKKRUbuGMcVVpPloIQddW/DF6HbyeYeQFl792/Cfg
         T/6Hyz1wDElHotV9PIrvcu9h/KXFWHU7sXSMCFcn8Bs8v+GcSIgteEG1GRpREd7dQeUA
         pd8NbsS4ei+RALn3/84aXhlkapq51z+simbcdlS4dJd0CJMeBzgjcKMMFmDc3VT/vQ9+
         0CRcHtTrV7CaiJZYZlKF+xVcJhccGskWb1xLoFksb8Fn+63Y+FgqxlgFFlVpgkt6+X91
         KcXA==
X-Gm-Message-State: AGi0PuaYpmgTtxeH1EPsO/aXa1/iA9ktX6GnMq1jRVXiyUm50u0JIbuY
        Kc/ND7RAijxQq59JAgVB9rWkcvB2Atd7jEuIml9ZVI9bAX/Wow==
X-Google-Smtp-Source: APiQypLMJHqzKS9QFqcCZ5S1/d310B24Y+vMIs93wGjEtMAoVRe3uNMqjEoc9LO4vHlFvZdkXqld7kFbZtSGESOfYNI=
X-Received: by 2002:a05:600c:2645:: with SMTP id 5mr6798860wmy.168.1588808575896;
 Wed, 06 May 2020 16:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
In-Reply-To: <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 6 May 2020 17:42:39 -0600
Message-ID: <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 5, 2020 at 2:39 PM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> On 5/5/20 7:51 pm, Graham Cobb wrote:
> > Is there actually a scrub in progress?
>
> The scrub has been going for a couple of days now, and has scrubbed
> considerably more data than exists on the disks.  Will it ever finish?

A raid1 volume has twice as many bytes to scrub as data reported by
df. Can you tell us what kernel version? And also what you get for:
$ sudo btrfs fi us /mp/
$ df -h

I'm using progs 5.6 and kernel 5.6.8 for this:

$ sudo btrfs scrub status /mnt/third
UUID:
Scrub resumed:    Tue May  5 08:45:41 2020
Status:           finished
Duration:         2:41:12
Total to scrub:   759.43GiB
Rate:             79.57MiB/s
Error summary:    no errors found
$ sudo btrfs fi us /mnt/third
Overall:
    Device size:         931.49GiB
    Device allocated:         762.02GiB
    Device unallocated:         169.48GiB
    Device missing:             0.00B
    Used:             759.43GiB
    Free (estimated):          85.17GiB    (min: 85.17GiB)
    Data ratio:                  2.00
    Metadata ratio:              2.00
    Global reserve:         512.00MiB    (used: 0.00B)

Data,RAID1: Size:379.00GiB, Used:378.56GiB (99.89%)
   /dev/mapper/sdd     379.00GiB
   /dev/mapper/sdc     379.00GiB

Metadata,RAID1: Size:2.00GiB, Used:1.15GiB (57.57%)
   /dev/mapper/sdd       2.00GiB
   /dev/mapper/sdc       2.00GiB

System,RAID1: Size:8.00MiB, Used:80.00KiB (0.98%)
   /dev/mapper/sdd       8.00MiB
   /dev/mapper/sdc       8.00MiB

Unallocated:
   /dev/mapper/sdd      84.74GiB
   /dev/mapper/sdc      84.74GiB

$ df -h
...
/dev/mapper/sdd    466G  381G   86G  82% /mnt/third

I think what you're seeing is a bug. Most of the size reporting in
btrfs commands is in btrfs-progs; whereas the scrub is initiated by
user space, most of the work is done by the kernel. But I don't know
where the tracking code is.

Some of the sizes you have to infer perspective. There is no one
correct perspective. So it's normal to get a bit confused about the
convention that applies. On mdadm/lvm raid1, the mirror isn't included
in any of the space reporting. It seems like it's reporting 1/2 the
storage. Meanwhile Btrfs reports all of the storage, and variably
shows data taking up twice as much space (as literally behind the
scenes each block group of extents has a mirror)


--
Chris Murphy
