Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B93AE38C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhFUG4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 02:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUG4V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 02:56:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4AEC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 23:54:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id i68so27813234qke.3
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 23:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nltd2L+P+0kFVQxVIOjywIePX7+/qERrhMzGxaBX8s=;
        b=vVWO4/kUZBMapRbsCoEwd26kTq9VA7icrpEJzqZJCBjUI+WR5jpszLVbZPfxFZ/kmD
         7lZP0wq2TVFiahBgFldMWCBzJjQ9frF4CUPz1R2ky3B6wsxJ3LJZ9bsd9xKaLc5SmYSo
         jTG1yiImBlc4wDZzi2jPEiewKhE8olZ+XY+KS9KdqmOK8OoV4/I/ZZaZlBLHPXMiNBeD
         miaPBXjymuko59y9mjq/jsa2ABgZIpF4kqiKhIgjrFvXoFMx5S5xmLksXwemaviLwyXy
         tQcox04RvUBY3/Coc14I3H57DPWtUto8tvRMsN098UH1Ux2l2DNGygA/Y5LZPWSb+fwp
         Iagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nltd2L+P+0kFVQxVIOjywIePX7+/qERrhMzGxaBX8s=;
        b=nzQR4sMmDGflq4FjNfv13GQlLd/i0i3uaCmOG/rfUbCQsNmQBsZfq8pWYy5pbgfoSW
         flcXMQmk6Iau5wbZ6jpOGd+UheKN6AdVHrsltgEJaJSsQjuZLnU+9I9j8Vw1Mc2RkAN2
         NWcub+xNGgCkMbsbyZ2oiJAWMPyQ+knnOFJ4yorFdukpYdSVkE5Jxx20MdpP16AtMKqF
         1oX0QKsax5jRAts8tlXi6vBj07Mh/DKkvzyMx5HlxmHX7BskcI9BTNevjvPhAlKhI2/P
         7AcEdzHem+5GNkgvZNB+E9a5iog283NzktUApLlg25+ZHuoaSzzVrNofawAhwv5AlgNs
         6gNg==
X-Gm-Message-State: AOAM530jazh7N2qeA9WbvKJbjLFh4NPKAHp10nWxmE/il8wasMSQ/q1c
        YQeie1hUTbBGox9XsRnNZZPMjS6ZDviV7SFevVMiTK/AVnM=
X-Google-Smtp-Source: ABdhPJzfnD5vXG2eEbI7bH3+zp3pKF4Eov350ksU01vp7joJAv+ZpV6ds2EfzYvQ7EeAmYJyLzURm1ZdNGgQyMXmQFs=
X-Received: by 2002:a25:dfd0:: with SMTP id w199mr30850632ybg.337.1624258446391;
 Sun, 20 Jun 2021 23:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <CAJCQCtSWxp+=nEJRFzEjEA0Lxt-rC+6Dq_CtpCNPmapzFw6WPA@mail.gmail.com>
 <ab0e8705-e18f-90eb-c42b-318c04a2101c@gmail.com> <CAJCQCtQXOgHTDAiGCWEN8_RaLNk26o9iDvtNcEBg9EVZ0yfdLg@mail.gmail.com>
 <CAHw5_hkJu-O8+F2WNFvab=z4LFfy2QYh0u6yr-CPmcSQHGjEXQ@mail.gmail.com> <CAJCQCtSjJPh_jVJLK_esiK=HGOAmc4L-XByBN19RRq1mCbhFkQ@mail.gmail.com>
In-Reply-To: <CAJCQCtSjJPh_jVJLK_esiK=HGOAmc4L-XByBN19RRq1mCbhFkQ@mail.gmail.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Mon, 21 Jun 2021 02:53:55 -0400
Message-ID: <CAHw5_hkx7nsSJVDy3wCBnzkzZpBPFwVPHtEcAPG7YP+7VBKarg@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> This output is slightly confusing because it's an older btrfsprogs
> that doesn't fully understand raid1c4 or raid56.  But the gist is that
> there's not enough space on 4 drives to create a metadata block group,
> which it wants to do for some reason even though there's ~600MiB
> available in metadata bg's currently.

I went ahead and installed a new btrfs-progs (I was luckily able to
install a new version from a newer Ubuntu release):

btrfs fi us /media/camino/
WARNING: RAID56 detected, not implemented
Overall:
    Device size:          96.42TiB
    Device allocated:          75.44TiB
    Device unallocated:          20.99TiB
    Device missing:             0.00B
    Used:              74.21TiB
    Free (estimated):          15.17TiB    (min: 6.08TiB)
    Data ratio:                  1.46
    Metadata ratio:              4.00
    Global reserve:         512.00MiB    (used: 1.59MiB)

Data,RAID1: Size:37.59TiB, Used:36.98TiB (98.38%)
   /dev/sde       4.62TiB
   /dev/sdj       6.32TiB
   /dev/sdg      11.22TiB
   /dev/sdd       4.69TiB
   /dev/sdp       6.10TiB
   /dev/sdl       5.26TiB
   /dev/sdb       4.65TiB
   /dev/sda       5.70TiB
   /dev/sdn       5.68TiB
   /dev/sdf       5.41TiB
   /dev/sdm       5.71TiB
   /dev/sdc       5.80TiB
   /dev/sdo       4.01TiB

Data,RAID6: Size:13.77TiB, Used:13.75TiB (99.83%)
   /dev/sde     849.14GiB
   /dev/sdj     964.87GiB
   /dev/sdg       1.45TiB
   /dev/sdd     775.98GiB
   /dev/sdp       1.14TiB
   /dev/sdl       2.00TiB
   /dev/sdb     808.33GiB
   /dev/sda       1.56TiB
   /dev/sdn       1.58TiB
   /dev/sdf       2.07TiB
   /dev/sdm       1.56TiB
   /dev/sdc       1.46TiB
   /dev/sdo       2.37TiB

Metadata,RAID1C4: Size:66.00GiB, Used:65.62GiB (99.43%)
   /dev/sde       9.00GiB
   /dev/sdj      14.00GiB
   /dev/sdg      66.00GiB
   /dev/sdd      15.00GiB
   /dev/sdp      28.00GiB
   /dev/sdl      15.00GiB
   /dev/sdb      14.00GiB
   /dev/sda      18.00GiB
   /dev/sdn      18.00GiB
   /dev/sdf      12.00GiB
   /dev/sdm      11.00GiB
   /dev/sdc      16.00GiB
   /dev/sdo      28.00GiB

System,RAID1C4: Size:32.00MiB, Used:12.97MiB (40.53%)
   /dev/sdg      32.00MiB
   /dev/sdl      32.00MiB
   /dev/sdf      32.00MiB
   /dev/sdo      32.00MiB

Unallocated:
   /dev/sde       1.02MiB
   /dev/sdj       1.02MiB
   /dev/sdg       3.44MiB
   /dev/sdd       1.02MiB
   /dev/sdp       1.02MiB
   /dev/sdl      14.09MiB
   /dev/sdb       1.02MiB
   /dev/sda       1.02MiB
   /dev/sdn       1.02MiB
   /dev/sdf       1.60TiB
   /dev/sdm       1.02MiB
   /dev/sdc       1.02MiB
   /dev/sdo     881.16GiB

> This is part of upstream btrfs-progs, but isn't packaged by most
> distros. Download that and set proper perms and run it.
> https://github.com/kdave/btrfs-progs/blob/master/btrfs-debugfs
>
> sudo ./btrfs-debugfs -b /mntpoint
>
> You'll get a lot of output, and chances are your mua will wrap it
> badly to the list so you might want to post it in a pastebin expiring
> in a week or so.

Here's the output of that command:

https://bin.snopyta.org/?f0bd7079c19a2737#2rdiNXaAHq6uD7hbCPFHYJH3LUWjjT3bX1AMB1eguuLY

> sudo btrfs insp dump-t -t chunk /dev/any

and this one:

https://bin.veracry.pt/?7d6e3eb722c98f0b#DSQ3Kv4HG6QwzVTtKS9VXF9UhbEP3YqtgGusX3VG8exV
-- 
Thanks,
Asif
