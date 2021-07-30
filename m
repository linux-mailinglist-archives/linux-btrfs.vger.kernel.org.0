Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7143DB277
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 06:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhG3Erf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 00:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhG3Ere (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 00:47:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D59CC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 21:47:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h14so15230793lfv.7
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 21:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GfoBaEEgE4a/aaWgnIEzL9XdbzxSCTjsE9xA6F8zv5U=;
        b=XqINuJm2k0EyYcDZA/jtWQKKoCA5kmhs1quEHx094iRMTNJPEea/n1Uw0BgjV1ZENc
         C+1WnkGTNMZRHu8mkTgdZrwUvyQp5y8zAbohJrZ8Otk6So0MPFZaP74HgSLCfMttnsye
         tydSoH8/fDHzTVMwcnGo7msLGVibeoCowtZVu7Ug596qi0Ry3UcfjsH03vdY3e7j6GA4
         TrVU6FwAzvznJb/rHFfRrjmkCuUu+4spHVMIHe/Wko7CmShGm7lEytSGWmgRAH50uARr
         FbeGv11a15I8fLwoUvstEOCjg7xcp7UoSixWq7MxL3uwKgBYpxGM4/jdSWBfKH0fS96k
         Xp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GfoBaEEgE4a/aaWgnIEzL9XdbzxSCTjsE9xA6F8zv5U=;
        b=APiwfoy08/oSnZ2pncAEG6qRyTcuQD60RPdoDEWzPzvTrHoUEpiliwjShfrDa8U3PV
         azpfph0yXXRyM6C78HO3n0mHSFdLummczr7c9o11+kb3trb0gRe+x8nWfGnmOh9iHaNB
         BYuZe/biP57eCvcHpm2aBry+S09uNss0ed1MBe1OhuEGTymJMddzyuIDM1Bjkg9Rtc/2
         G/TkWm3fhAcAFvOvlfuj5pSnXdQd1qkWrDeggxUn6CxXodD+F7uhWG0ZnPo0a9h3IqBG
         LKluTAbVo1n/TNausbG6M9gU+ZHFaMQ+FrrU9fSEaWWdDKehzdrGqZXoWGE4ZXJCTcAk
         7Vrg==
X-Gm-Message-State: AOAM530Lh2SAXypeEKQGV2szvqePMSRh79SocOlIcyQpj1mA3ePEYrA2
        Y9A+ktSx6H7wk0+STz8mJrnkfnGtLdCQOJzc
X-Google-Smtp-Source: ABdhPJwgxSiJ8IW2EPGYrWC0WudsuxkHY1WD/u5kWLZIIkf5osqeH82oIPqgiuD7RydMxoTNLcuf0Q==
X-Received: by 2002:a05:6512:1594:: with SMTP id bp20mr434264lfb.159.1627620448466;
        Thu, 29 Jul 2021 21:47:28 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:2c6:9453:c31a:df0e:37f0? ([2a00:1370:812d:2c6:9453:c31a:df0e:37f0])
        by smtp.gmail.com with ESMTPSA id y28sm44981lfk.140.2021.07.29.21.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 21:47:27 -0700 (PDT)
Subject: Re: Why usable space can be so different?
To:     Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <a5dd8f30-48f0-4954-f3fb-1a0722ae468f@gmail.com>
Date:   Fri, 30 Jul 2021 07:47:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29.07.2021 12:47, Jorge Bastos wrote:
> HI,
> 
> This is not a big deal, but mostly out of curiosity, I've noticed
> before that sometimes I couldn't fill up a single device btrfs
> filesystem as much as I would expect, recently I've been farming some
> chia and here is a very good example, both are 8TB disks, filled up
> sequentially with 100MiB chia plots, this one looks about what I would
> expect:
> 
> btrfs fi usage /mnt/disk4
> Overall:
>     Device size:                   7.28TiB
>     Device allocated:              7.28TiB
>     Device unallocated:            1.04MiB
>     Device missing:                  0.00B
>     Used:                          7.24TiB
>     Free (estimated):             34.55GiB      (min: 34.55GiB)
>     Free (statfs, df):            34.55GiB
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:7.26TiB, Used:7.22TiB (99.54%)
>    /dev/md4        7.26TiB
> 
> Metadata,DUP: Size:9.50GiB, Used:8.45GiB (88.93%)
>    /dev/md4       19.00GiB
> 
> System,DUP: Size:32.00MiB, Used:800.00KiB (2.44%)
>    /dev/md4       64.00MiB
> 
> Unallocated:
>    /dev/md4        1.04MiB
> 
> 
> 
> 
> In this one, filled exactly the same way, could only fit 2 less plots:
> 
> btrfs fi usage /mnt/disk3
> Overall:
>     Device size:                   7.28TiB
>     Device allocated:              7.28TiB
>     Device unallocated:            1.04MiB
>     Device missing:                  0.00B
>     Used:                          7.04TiB
>     Free (estimated):            239.04GiB      (min: 239.04GiB)
>     Free (statfs, df):           239.04GiB

Is you "plot" (whatever it is) 100MiB or 100GiB? Because your first
example has 34GiB available and from your description you cannot write
anything - but I would be very surprised if you could not write another
100MiB to it.

100GiB would fit your description.

>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:7.26TiB, Used:7.03TiB (96.78%)
>    /dev/md3        7.26TiB
> 
> Metadata,DUP: Size:8.51GiB, Used:7.96GiB (93.51%)
>    /dev/md3       17.02GiB
> 
> System,DUP: Size:32.00MiB, Used:864.00KiB (2.64%)
>    /dev/md3       64.00MiB
> 
> Unallocated:
>    /dev/md3        1.04MiB
> 
> 
> 
> 
> Maybe a full balance would help, but the disk was filled sequentially
> with one plot (100MiB file) at a time, there shouldn't be any
> fragmentation, it's as if it can't fully use the data chunks as the
> other one, kernel is 5.10.21, balance with -dusage=88 doesn't relocate
> any chunks, above that it fails with ENOSPC:
> 
> btrfs balance start -dusage=88 /mnt/disk3
> Done, had to relocate 0 out of 7446 chunks
> 
> btrfs balance start -dusage=89 /mnt/disk3
> ERROR: error during balancing '/mnt/disk3': No space left on device
> 
> 
> Any idea what could cause this difference, also two more disks (12 and
> 10TB) that fall somewhere in between:
> 
> btrfs fi usage /mnt/disk1
> Overall:
>     Device size:                  10.91TiB
>     Device allocated:             10.91TiB
>     Device unallocated:            3.94GiB
>     Device missing:                  0.00B
>     Used:                         10.71TiB
>     Free (estimated):            202.03GiB      (min: 200.06GiB)
>     Free (statfs, df):           202.03GiB
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:10.88TiB, Used:10.69TiB (98.22%)
>    /dev/md1       10.88TiB
> 
> Metadata,DUP: Size:13.00GiB, Used:11.79GiB (90.74%)
>    /dev/md1       26.00GiB
> 
> System,DUP: Size:32.00MiB, Used:1.25MiB (3.91%)
>    /dev/md1       64.00MiB
> 
> Unallocated:
>    /dev/md1        3.94GiB
> 
> 
> 
> 
> 
> 
> btrfs fi usage /mnt/disk2
> Overall:
>     Device size:                   9.09TiB
>     Device allocated:              9.09TiB
>     Device unallocated:           13.01MiB
>     Device missing:                  0.00B
>     Used:                          8.93TiB
>     Free (estimated):            169.67GiB      (min: 169.67GiB)
>     Free (statfs, df):           169.68GiB
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:9.07TiB, Used:8.91TiB (98.17%)
>    /dev/md2        9.07TiB
> 
> Metadata,DUP: Size:11.00GiB, Used:9.98GiB (90.76%)
>    /dev/md2       22.00GiB
> 
> System,DUP: Size:8.00MiB, Used:992.00KiB (12.11%)
>    /dev/md2       16.00MiB
> 
> Unallocated:
>    /dev/md2       13.01MiB
> 
> 
> 
> 
> 
> 
> 
> Thanks,
> Jorge
> 

