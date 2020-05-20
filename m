Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB681DBDA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETTLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgETTLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 15:11:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82C2C061A0E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 12:10:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so3504055wmb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2TXsNUQODZo0IkWWLQfJ0xL3QnpBsf0RYYr0LZo5i8=;
        b=H1L1UpMmcdXs9Pwb/6YaCSqyTR08VJD+KzR/ws3JjBgwOWhOntKOSrfSbQOSyuV15k
         970InbBAfMtDmumxDR3MHs2G+QMcjvlwC6jLAfscmydf1ceu7ORSGd8jdiEjP8lQWqCF
         gpH53XBP/dsBjTD6CowSq6JQpXRFt6TR/3YBpdlXmLov8uNFykxvQ6Frr9ywf4MlvmdE
         ngjg8vvjgbUmxaEK7oAz9Shqkv8HQPLngljoUVAKz+6UUMmcOH53arGaHaJ2QX4kpf0C
         jhe9uz4KWHHb7Y1O86AweEwuzFho7aE3oTdEndcyG+sAEeAzI+T8rUwmIX0cFtfiZa0V
         KwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2TXsNUQODZo0IkWWLQfJ0xL3QnpBsf0RYYr0LZo5i8=;
        b=hcN9DpKhSPlAXDA08HI5nfhrwkC/4lglkjnHw3TrNhv6cNw6rguC4ABT2el2MRvkjH
         bEgXXRFTH5UZmiZJpWtouXtcyDktz5li/H1vOQUzsFW46MwQV6PAT0P6fsaHwS0C/47L
         toUXWxdAWxLAgiv3tik6kKR+vR9cHppXq/tRBMiUqOyhSiKUefW3dSRLD+6XuHQFn7d1
         ygGDmNztnVCiBlBc2OAQ9cTjWIV1HCgb9CMI7ZkvKGc7mEg4MItBrezHok8cW8haR+79
         p82FK2owyEXGglFPfUrxYujWL4bwgFQDcEBcgzLPPaGxD+X7cfh1+h88ug2Y0u25mGmP
         LQdA==
X-Gm-Message-State: AOAM532oA0+K4bbHAG+OyP7ZPaRnhWexdvpUjHkgbh3jYEkaQ7pSLDhI
        0PIqn8W6xNyWH0nSUsleIB6NWqFEYclX6eTW18vPNqhB2qQ=
X-Google-Smtp-Source: ABdhPJzHwjJ5/CUM+tQAiW2jEusYbPa6r5/VS8HERlt+EoASIRHvlZ975HFfJ4VljUsDiOx05YeO5irosnt8j6GJIJE=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr5694717wmk.168.1590001858418;
 Wed, 20 May 2020 12:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzb4voyyBxOPNV0b72XTNTP6jNGibki+UMF31U_HqumUSMfSg@mail.gmail.com>
In-Reply-To: <CAHzb4voyyBxOPNV0b72XTNTP6jNGibki+UMF31U_HqumUSMfSg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 May 2020 13:10:42 -0600
Message-ID: <CAJCQCtSpWcA7yUJ7S=TkPmfLQr8+Y8TdiepxDzZFgv8KA-uEaw@mail.gmail.com>
Subject: Re: BTRFS RAID 5 Array looks clean in some states, but cannot mount
 and cannot recover
To:     Panicx <panicx@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 8:47 AM Panicx <panicx@gmail.com> wrote:
>
> Hello all,
>
> I had a recovery event a few days ago that completed, and as far as I
> can tell, the array is clean.
> root@xubuntu:/mnt/md0# mdadm -D /dev/mapper/vg0-lv0
> /dev/mapper/vg0-lv0:
>         Version : 1.2
>   Creation Time : Mon Mar 30 19:44:30 2020
>      Raid Level : raid5
>      Array Size : 17571291136 (16757.29 GiB 17993.00 GB)
>   Used Dev Size : unknown
>    Raid Devices : 4
>   Total Devices : 4
>     Persistence : Superblock is persistent
>
>   Intent Bitmap : Internal
>
>     Update Time : Tue May 19 19:04:43 2020
>           State : clean
>  Active Devices : 4
> Working Devices : 4
>  Failed Devices : 0
>   Spare Devices : 0
>
>          Layout : left-symmetric
>      Chunk Size : 128K
>
>            Name : TNAS-2CC8E6:UTOSUSER-X86-S64
>            UUID : cc80e7cd:c6b902c4:ef36b897:409e8f96
>          Events : 18518
>
>     Number   Major   Minor   RaidDevice State
>        0       8       20        0      active sync   /dev/sdb4
>        1       8       36        1      active sync   /dev/sdc4
>        2       8       52        2      active sync   /dev/sdd4
>        4       8        4        3      active sync   /dev/sda4
>
> I cannot mount it:
> root@xubuntu:/mnt/md0# mount -t btrfs /dev/mapper/vg0-lv0 /mnt/md0/
> mount: /mnt/md0: wrong fs type, bad option, bad superblock on
> /dev/mapper/vg0-lv0, missing codepage or helper program, or other
> error.
>
> I cannot check it:
> root@xubuntu:/mnt/md0# btrfsck /dev/mapper/vg0-lv0
> bytenr mismatch, want=441707118592, have=0
> Couldn't read tree root
> ERROR: cannot open file system
>
> I cannot mount it readonly with the backuproot option, either:
> root@xubuntu:/mnt/md0# mount -t btrfs -o ro,usebackuproot
> /dev/mapper/vg0-lv0 /mnt/md0/
> mount: /mnt/md0: wrong fs type, bad option, bad superblock on
> /dev/mapper/vg0-lv0, missing codepage or helper program, or other
> error.
>
> Please help :)  I'd like to get some baby photos/vids out of that
> array before I call it a lost cause.  Some of the photos are for
> babies that aren't here anymore, and they are all I have.
>
> root@xubuntu:/mnt/md0#   uname -a
> Linux xubuntu 4.15.0-20-generic #21-Ubuntu SMP Tue Apr 24 06:15:38 UTC
> 2018 i686 i686 i686 GNU/Linux
> root@xubuntu:/mnt/md0#   btrfs --version
> btrfs-progs v4.15.1
> root@xubuntu:/mnt/md0#   btrfs fi show
> Label: none  uuid: 9ef00e00-ea8a-4b29-b8b1-4ce6e85a7e7f
>         Total devices 1 FS bytes used 5.59TiB
>         devid    1 size 16.36TiB used 5.64TiB path /dev/mapper/vg0-lv0
> ## Note: I cannot mount the filesystem:
> root@xubuntu:/mnt/md0# btrfs fi df /mnt/md0
> ERROR: not a btrfs filesystem: /mnt/md0

I strongly advise not doing anything that changes things on disk.
Repairs will do writes. You need to be certain you understand the
problem before proceeding with any repair.

# btrfs rescue super -v /anydevice/
# btrfs insp dump-s /anydevice/

This won't fix anything but will state if any supers are found and if
they're good or bad, and then print one of them.

I suspect that the raid has not in fact been properly resumed and you
will need very careful and explicit advice from the linux-raid@ list.
Tell them everything that happened from the creation of the array, to
the problem that happened, to any fixes you attempted. Many data loss
cases involving raid are caused by users assuming a repair that is not
indicated and the repair attempt makes data recovery impossible.


-- 
Chris Murphy
