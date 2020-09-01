Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5279725920B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIAPCM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIAPCL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 11:02:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC80C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 08:02:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so1485893wmh.4
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HssCtA7j2xQP7IXsZGu4F0WwKUcMO1DNXhOFSVUPbkI=;
        b=FHU/bqOb/HhE4DTNrG2INnuyKGzlC4tawMwyw2LfSn/A6vJLDzvE99cKNNN1pWwvp3
         L4xlA9bzahmG1W9/7+//RjbD+IhT7w8LM3vkODIeFRPUHVVLjNWdYBXe6ksLrIzak9/l
         pnEZqz1840Wm9Q3MFIc79++KZs0zGVDSX7ZGj4Plbz9x410z5vGUwxvJR1Ywu75FA3VN
         eNivwWWs81wb/r+gOjl3ov5WZ2SJdP7Bc8KeQsDzGeIjfeQsfwsgJVpd2l4Td31M/DwV
         8TdIf+krYLEfIqUVQmnYrckSgFfBoVSjHCgoI2MJLqUSdli3go4P2E6/P4hdtkj8Et4n
         3o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HssCtA7j2xQP7IXsZGu4F0WwKUcMO1DNXhOFSVUPbkI=;
        b=IcofoUpo5tuwtJxQicn7GqYmC+2NtCFXFkKEmaC7JPLWI/2K2IN9AWCewgfsJCCP3r
         G+uOvHBS2Z5LlcYU8dQhXhwLEqgvt2KkwA8oqe6XlCOzUcl2/X/69KJt7oVyoTo/0acR
         5MJgpZTg+iTgRIFiJk+X6JbA/POpxZQtx+TxlcPwinI0WZLgRneMzeJmPHYuwfyVk0fu
         97rzBtHKousDYjx5RLai+1JVgafOpHiDkBBgtg+P+qQnnoAGbdkC05N5JsDMELqPT3Wi
         zlgs7CDnFriTUu3NOvOA4Uog8/FWrhGcHYHJjlix+Xy37cyC0gKNPAS56DgxZCR/R2E4
         2FvA==
X-Gm-Message-State: AOAM533+6MCcnoYbM0jOxHWbvFX8RrfBkIGLFUmGVh3O1eJnlWhWBPut
        KItgIlpj3CJpuF6T9uCRWnknyqlPcUh8DWw3L0Or4A==
X-Google-Smtp-Source: ABdhPJxpFpsAeXZJkjGiNcpSHmN/99IwTdokNWfZ+dUrOZt3NHwT6GisjTMBxjtpq468OAyjxFc0hrf7+uIjbQoA+p4=
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr2169015wmm.128.1598972529130;
 Tue, 01 Sep 2020 08:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
 <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com>
 <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com>
 <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com>
 <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com>
 <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com>
 <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com>
 <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com>
 <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com> <KzGwc4OhDq6qR43tQSjynifhYV7E1mfeZeQjBWWRNwithi65kenn7yS22w-bbi_OHYXAkYA6y44iMYCYLAWu2g2V3s47Uor_aYMRk-NgoOU=@protonmail.com>
In-Reply-To: <KzGwc4OhDq6qR43tQSjynifhYV7E1mfeZeQjBWWRNwithi65kenn7yS22w-bbi_OHYXAkYA6y44iMYCYLAWu2g2V3s47Uor_aYMRk-NgoOU=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 1 Sep 2020 09:01:19 -0600
Message-ID: <CAJCQCtSB3QrA74tAH=_Fa-f8WWXJUANgt1_0PRbLcDUgBho-GQ@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 27, 2020 at 12:48 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:
>
> > > > OK is the sysfs output from before or after the homectl resize? And it
> > > > matches with the second strace fallocate -l 300g ?
> > >
> > > Figured it out. The sysfs is the first strace before the resize.
> >
> > Shoot. I confused myself and am not sure, so I need you to tell me
> > which strace that sysfs goes with, the 403g or 300g.
>
> Sorry, I haven't put it clear. I've resized it right after I was able to log in a couple of days ago. So both straces and /sys/fs outputs are after resize. And /sys/fs output is after the second strace (-l 300G).

Andrii,

We're trying to reproduce this problem and need more information.
Could you provide the following:

1. ls -li  /home/azymohliad.home
2. filefrag -v /home/azymohliad.home | grep -m 10 shared
3. Pick any line, multiply the first extent (4th column) by 4096, this
is the bytenr
4. btrfs inspect-internal dump-tree -t 5 /dev/nvme0n1p2 | grep -C 10 <bytenr>

Thanks!

-- 
Chris Murphy
