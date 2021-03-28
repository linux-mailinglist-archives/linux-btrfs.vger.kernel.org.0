Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB834BD85
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 19:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhC1RTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhC1RTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 13:19:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12296C061756
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 10:19:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s17so13310517ljc.5
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Mar 2021 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jQvg2OH8vmLJ4pyHNw+zUztfb4oy75+pPttCvvDMsH8=;
        b=ej7jVfJEyiOV51fqevA5G/Xr1ceW47/x1X1B73ynoilpKQpGnUTWns5w8uAJ27PwAW
         79R/XPCbGTqiVJhAJuSxNlrRXH3koDNppM0iWkaAxVxtteeptS5yudeajD8JvJhVsodC
         9MKmqWA9/tz4ZcL8oUv/F3XjAcSYTtovzxppVSzEvnluq84NQylm6RwmRgPrklk80EgF
         TukWRaxnI1EpmN8CznyT2G7GRc1WMT7gLUhYb97cdiTCQWcq5tMJubp19jDMtgUjbYq0
         Bzhkn2Rh2kZpUT/wrxb1fDPpVLWTaOYjdauHM6M9PYiy7TCKWJNE3hYQyGEOC67pPK4k
         eTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jQvg2OH8vmLJ4pyHNw+zUztfb4oy75+pPttCvvDMsH8=;
        b=HkJ4NWG8MHkrTWheQLmbZXmWjPluosS9BdDQymUgnz/o8GrDiiefYe6LBYpmuMDc0v
         vA3Ris2J758Vvk7I5dMFMqX/GOKNQ+rSmsAHGNwGRcAvZCWlusyiNyO2tPFYRrhn/Mcw
         ALHD7JMP2IYCpmMkBlDUu0K1U1neFFId5NZrbuhVOHqBEy98KA+Uz9I2BlnfauYgTMyF
         P18WI1BsezOb8BprR6+6cFOsAbPIHtDoXYoddEVGp0wFOdiF5E94FuE7GfY9uKTUJ8A8
         A4cQF/UoLGQG2Aiy1nWWdzug//C/vYiKlKZdHYTTYsyFnyN3yVZ6ENSpA1IBN/BWwHJO
         tlrg==
X-Gm-Message-State: AOAM531JEDoOdk/oyIkPwa96+vI3kS50fL/yoKHk+GG8TBG2pq+8luZH
        hf5slM/rqCfsbUkKaEIsqM/kSkW+pkY=
X-Google-Smtp-Source: ABdhPJwRUd4905cxKP0mphmqT6h/3FgHHg8N/HNMvxTtyWJq4YzXYxq0eK9hge1Pc+qR/sSp4UdQoA==
X-Received: by 2002:a2e:8919:: with SMTP id d25mr9311612lji.187.1616951949421;
        Sun, 28 Mar 2021 10:19:09 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:f67d:23b0:24c5:db70:4d19? ([2a00:1370:812d:f67d:23b0:24c5:db70:4d19])
        by smtp.gmail.com with ESMTPSA id z1sm2121956ljo.134.2021.03.28.10.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 10:19:08 -0700 (PDT)
Subject: Re: Disk usage difference in the output of `btrfs fi show` vs. `btrfs
 fi du`
To:     =?UTF-8?Q?Zolt=c3=a1n?= <zoltan1980@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAGtRCvfHfjFFZZQCEHR+ff-JfNCCOMq=B0PxaCc-_+a6XKEg+A@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <eb075afb-e9ca-5783-f8a2-1bd6b1192dd7@gmail.com>
Date:   Sun, 28 Mar 2021 20:19:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAGtRCvfHfjFFZZQCEHR+ff-JfNCCOMq=B0PxaCc-_+a6XKEg+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.03.2021 15:28, Zoltán wrote:
> Hi,
> 
> I have read a lot of caveats about interpreting the free space
> reported for btrfs volumes, but could not find anything about the
> perceived inconsistency in the disk usage reporting described below.
> 
> I have a btrfs volume with about 135GiB used for data, as reported by
> `df`, `btrfs fi show` and `btrfs fi usage` alike:
> 
> # btrfs filesystem show /volumes/main/
> Label: 'main'  uuid: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
>         Total devices 1 FS bytes used 134.12GiB
>         devid    1 size 193.43GiB used 165.01GiB path /dev/sda2
> 
> However, `btrfs fi du` reports ~17GiB exclusive usage and ~80GiB
> shared usage, which adds up to only 97GiB (compared to the 135GiB I
> would expect):
> 
> # btrfs filesystem du -s /volumes/main/
>      Total   Exclusive  Set shared  Filename
>    1.73TiB    17.20GiB    80.13GiB  /volumes/main/
> 
> (The reported total usage exceeding the disk capacity by an order of
> magnitude is expected as the volume contains many snapshots.)
> 
> The mount point corresponds to the root subvolume, thus all subvolumes
> should be accounted for by `btrfs fi du` (according to its
> documentation):
> 
> # mount | grep /volumes/main
> /dev/sda2 on /volumes/main type btrfs
> (rw,noatime,ssd,space_cache,autodefrag,subvolid=5,subvol=/)
> 
> Do I misunderstand the meaning of exclusive and shared usage or is
> there some other issue causing this behaviour? I would expect the disk

It probably does not take in account exclusive usage of other
subvolumes, likely snapshots.

> usage reported by `df`, `btrfs fi show` and `btrfs fi usage` to be the
> sum of the exclusive and shared usage reported by `btrfs fi du`.
> 
> The output of `btrfs fi usage`, for completeness's sake:
> 
> # btrfs filesystem usage /volumes/main/
> Overall:
>     Device size:                 193.43GiB
>     Device allocated:            165.01GiB
>     Device unallocated:           28.41GiB
>     Device missing:                  0.00B
>     Used:                        134.12GiB
>     Free (estimated):             57.00GiB      (min: 57.00GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              194.72MiB      (used: 0.00B)
> 
> Data,single: Size:162.00GiB, Used:133.41GiB (82.35%)
>    /dev/sda2                     162.00GiB
> 
> Metadata,single: Size:3.01GiB, Used:720.88MiB (23.41%)
>    /dev/sda2                       3.01GiB
> 
> System,single: Size:4.00MiB, Used:48.00KiB (1.17%)
>    /dev/sda2                       4.00MiB
> 
> Unallocated:
>    /dev/sda2                      28.41GiB
> 
> Thanks,
> 
> Zoltan
> 

