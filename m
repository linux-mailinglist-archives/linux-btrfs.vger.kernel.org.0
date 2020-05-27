Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544821E3577
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgE0CVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 22:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0CVI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 22:21:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1872C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 19:21:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so18183664wru.12
        for <linux-btrfs@vger.kernel.org>; Tue, 26 May 2020 19:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=710liskjMynXDxkmidpoFhbrjw8fu7pPM4yNQswldmA=;
        b=L98gcpZaTCoH19noiIVvoizwKEkMGTb+XDfrVC2wPVLQVOC/CYuiMQ+xsl735OIRhz
         lPn5ZJslgzyFE+052ZtzF+0v+iK+ZgflJzJaPEMo9qCczh5lE9suiNIil1RZulI1xWAi
         mgJ5IWZo/MZqriMthG86GsxJqoSXMo9b2ueNh2jC+NBIewohLEd/A9ts8huNLPUNO0og
         gADzN1NOrM+I8Kbdif9dz2BV4tsqIpU2RXMyscsf5L7nUoVeYsvNsLU37pcDYqlOvmS2
         wQUnRn6HEM89es9tqX4+uyX753oku46NtuM7i9dv4B/Vy3r7298RS0ME2YHQ4Xi0HVlF
         jONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=710liskjMynXDxkmidpoFhbrjw8fu7pPM4yNQswldmA=;
        b=hDN3nMEatyqJd/G9EuRm8om7iVKGwSoKek+dXa39HmhG0y8ECdu3pzyk+sCBjGO758
         QJWX1+Qwk1tx+89Z0Zwri4veWIDJsKex6EYPdx3dBUGuSmcxtDYFzpskvR8rTGPogg8G
         Ulse1tm+ve14RZeG5dY0GfEE1JEICBGWrJgysnO2VkmkhoPKuClQcwOghkknq2KQWXyr
         WcdCCe5uK/kXiUn7KlPNoi4Vi3lHX2QPnd54CYomnkK0WCc0/xhz7Bwq6QqMuHwYKTfI
         N3qzIz1hcWuDnoiWCK6tsqN4kgCVZCUt8RBzpnq3UbnPagu77INq01YcNuFMlx2f4bxD
         VaDg==
X-Gm-Message-State: AOAM531I0UnNDdp2jowIFJ5UfgcqvnYmta648+JfxdDPrtaB1Zl1QzOW
        s5qDkjUEMghVk4r95fOqzpvVhrOp43X9/HVQ15K5XnyBoxQbxw==
X-Google-Smtp-Source: ABdhPJxxdCbJQA2zdD5FmxznEzq3DXQvo0poCg37eDqap7IKm4qkbvVw7AAGFgYIg6MlRMMo2hrHlsSaRRrQyqEEF2M=
X-Received: by 2002:adf:e883:: with SMTP id d3mr12754589wrm.274.1590546062958;
 Tue, 26 May 2020 19:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
In-Reply-To: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 26 May 2020 20:20:46 -0600
Message-ID: <CAJCQCtSyJp0LiaO246NcEX-p7rk8-h1NocW4o4rJgN=B1Kwrug@mail.gmail.com>
Subject: Re: Planning out new fs. Am I missing anything?
To:     Justin Engwer <justin@mautobu.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 24, 2020 at 7:13 PM Justin Engwer <justin@mautobu.com> wrote:
>
> Hi, I'm the guy who lost all his VMs due to a massive configuration oversight.
>
> I'm looking to implement the remaining 4 x 3tb drives into a new fs
> and just want someone to look over things. I'm intending to use them
> for backup storage (veeam).
>
> Centos 7 Kernel 5.5.2-1.el7.elrepo.x86_64
> btrfs-progs v4.9.1

I suggest updating the btrfs-progs, that's old.
>
> mkfs.btrfs -m raid1c4 -d raid1 /dev/disk/by-id/ata-ST3000*-part1
> echo "UUID=whatever /mnt/btrfs/ btrfs defaults,space_cache=v2 0 2" >> /etc/fstab
> mount /mnt/btrfs

Add noatime.
https://lwn.net/Articles/499293/

I don't recommend space_cache=v2 in fstab. Use it once manually with
clear_cache,space_cache=v2, and a feature flag will be set to use it
from that point on. Soon v2 will be the default and you won't have to
worry about this at all.

fs_passno should be 0 for btrfs. man fsck.btrfs - it's a no op, it's
not designed for unattended use during startup. XFS is the same.


> RAID1 over 4 disks and RAID1C4 metadata. Mounting with space_cache=v2.
> Any other mount switches or btrfs creation switches I should be aware
> of? Should I consider RAID5/6 instead? 6tb should be sufficient, so
> it's not like I'd get anything out of RAID5, but RAID6 I suppose could
> provide a little more safety in the case of multiple drive failures at
> once.

single, dup, raid0, raid1 (all), raid10 are safe and stable. raid56
has caveats and you need to take precautions that kinda amount to hand
holding. If there is a crash or power fail you need to do a scrub
(full file system scrub) when raid56. It's a good idea, but not "very
necessary" with other profiles. If you mount raid56 degraided, you
seriously need to consider not doing writes or being very skeptical of
depending on those writes because there's some evidence of degraded
writes being corrupted.

You can check the archives for more information from Zygo, about
raid56 pitfalls. It is table on stable storage. But the point of any
raid is to withstand a non-stable situation like a device failure. And
there's still work needed on raid56 to get to that point, without
handholding.

If you need raid5, you might consider mdadm for the raid5, and then
format it with btrfs using defaults which will get you DUP metadata
and single copy data. You'll get cheap snapshots. Faster scrubs. And
warnings for any corruptions of metadata or data.

Also consider mkfs.btrfs --checksum=xxhash, but you definitely need
btrfs-progs 5.5 or newer, and kernel 5.6 or newer. If those are too
new for your use case, skip it. crc32c is fine, but it is intended for
detection of casual incidental corruption and can't be  used for
dedup. xxhash64 is about as fast, but much better collision
resistance.

-- 
Chris Murphy
