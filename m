Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188F512EB93
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgABV51 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:57:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44014 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABV51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:57:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so40678388wre.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=925SrSniT97GHUIP4qFx0DOl0EjYy289hUtLusqKq0Y=;
        b=WZ73uj4vW0m/Xh3rSPPC0iuTfQHKsYbTcFxXXlEBfF/sGrUX6YKwZd4xtfDExs131a
         Y3wmTOA7uyA3kopFp+nYuX2JgPxwvED1Fh93V4e/x5ABhKAEBekUlX2/HBJU29Pdhzf6
         u0qPO9FAp18xwWV7rDHUFVG988/fd88YwUOydM2ISUlzsbmvnyc+HsYTSB8U4rhQUFIk
         A8OBDiGD3RFNj9SIVDTtgUCGZh+Iljf78vL/PaG1YA/TcFYKnc9WzihGlEeh8DODtB71
         E1aZDfepqiQHrGX8JhH97apIwlias4m4tU1VW4TElmmvh9KBLuhSyvRS6e/sIYbLkoa8
         7dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=925SrSniT97GHUIP4qFx0DOl0EjYy289hUtLusqKq0Y=;
        b=VSxClLVtYD0tZ8ROBrXUvO333hQwSLvdSrkQpg55Cndi9O3Vm3/przl1w9oOWkxzmg
         P8Mi5bgDRw0M3teImErdE1mYVd4oj//8rxbrcTrPNSLej120Il+Y7K+8fUvEIQNXed1Y
         6psLpkMAO4i+a8Uu4Ew3Z6VKfF18faAlJfT9vLWcgzgBpJEiiC1qhpHuF/TqaXwhthhm
         I0aAvnoug41A2RmgE4krX6hJN7qQ2fGSP0H5WENruTA9xT/+dSEI4/0kl5MDOPfgyzAi
         lw6admEl32P6ocFXOQUJjaduHcsV05d1crWO06DxdAUPsBJPO8liXKfc9hp4JcKczyrd
         nlZA==
X-Gm-Message-State: APjAAAV3W2yat7JO0m7KH7rE7lr4gpitO/QQ8C7idnoC+J8fCScmuoNM
        qdj0cCNTaiKuGPOhaLFmdNCIAiYwaVeyus1dDm8/5st8fMA=
X-Google-Smtp-Source: APXvYqzqcLa7HHvAlVxwy/9QeA985HUZ7lERTZMJkf4IyuK1c6I/NFHm3Bg2uQCzF2utF4S9QkbYvenCJ8XyRB4cJc8=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr86864923wrn.101.1578002244795;
 Thu, 02 Jan 2020 13:57:24 -0800 (PST)
MIME-Version: 1.0
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com> <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com> <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl> <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org> <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
In-Reply-To: <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 2 Jan 2020 14:57:08 -0700
Message-ID: <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 2, 2020 at 11:47 AM Leszek Dubiel <leszek@dubiel.pl> wrote:
>
>
>  > It might be handy to give users a clue on snapshot delete, like add
>  > "use btrfs sub list -d to monitor deletion progress, or btrfs sub sync
>  > to wait for deletion to finish".
>
> After having cleaned old shapshots, and after "dev delete" has
> completed I have added new fresh empty disk
>
>
>                   btrfs dev add /dev/sda3 /
>
>
> and started to balance:
>
>
>                       btrfs balance start -dconvert=raid1 -mconvert=raid1 /
>
>
> It was slow (3-5 MB/sec), so canceled balance.

I'm not sure why it's slow and I don't think it should be this slow,
but I would say that in retrospect it would have been better to NOT
delete the device with a few bad sectors, and instead use `btrfs
replace` to do a 1:1 replacement of that particular drive.

When you delete a device, it has to rewrite everything onto the two
remaining device. And now that you added another device, it has to
rewrite everything onto three devices. Two full balances. Whereas
'device replace' is optimized to copy block groups as-is from source
to destination drives. Only on a read-error will Btrfs use mirror
copies from other devices.


> Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s
> %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> sda              4,39  142,05      0,90      3,78     3,64 12,68
> 45,32   8,20    9,81    5,48   0,78   209,68    27,26 0,54   7,95
> sdb              4,66  155,25      0,97      4,03     4,52 13,11
> 49,27   7,78    9,25    4,68   0,73   213,20    26,59 0,49   7,89
> sdc              6,35  246,61      0,38      6,94     4,35 25,11
> 40,67   9,24   27,09   48,00  11,92    61,02    28,82 2,65  67,02

Almost no reads, all writes, but slow. And rather high write request
per second, almost double for sdc. And sdc is near it's max
utilization so it might be ear to its iops limit?

~210 rareq-sz = 210KiB is the average size of the read request for sda and sdb

Default mkfs and default mount options? Or other and if so what other?

Many small files on this file system? Or possibly large files with a
lot of fragmentation?


> Device            r/s     w/s     rMB/s     wMB/s   rrqm/s wrqm/s
> %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> sda              2,38  186,52      0,20      3,33     1,33 4,20  35,87
> 2,20    9,88    3,48   0,63    86,04    18,27 0,30   5,60
> sdb              1,00  108,35      0,02      1,99     0,00 2,73   0,00
> 2,46    8,92    3,78   0,41    18,00    18,85 0,27   2,98
> sdc             13,47  294,68      0,21      5,32     0,00 6,92   0,00
> 2,29   13,33   61,56  18,28    16,00    18,48 3,13  96,45

And again, sdc is at max utilization, with ~300 write requests per
second which is at the high end for a fast drive for IOPS, if I'm not
mistaken. That's a lot of writes per second. The average write request
size is 18KiB.

So what's going on with the workload? Is this only a balance operation
or are there concurrent writes happening from some process?




> iotop:
>
> Total DISK READ:         0.00 B/s | Total DISK WRITE:         0.00 B/s
> Current DISK READ:       0.00 B/s | Current DISK WRITE:       0.00 B/s
>    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
>      1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init
>      2 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kthreadd]
>      3 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_gp]
>      4 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_par_gp]
>      6 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 %
> [kworker/0:0H-kblockd]
>      8 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [mm_percpu_wq]
>      9 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/0]
>     10 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_sched]
>     11 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [rcu_bh]
>     12 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/0]
>     14 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/0]
>     15 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/1]
>     16 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/1]
>     17 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/1]
>     19 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 %
> [kworker/1:0H-kblockd]
>     20 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/2]
>     21 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/2]
>     22 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/2]
>     24 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 %
> [kworker/2:0H-kblockd]
>     25 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/3]
>     26 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/3]
>     27 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/3]
>     29 be/0 root        0.00 B/s    0.00 B/s  0.00 %  0.00 %
> [kworker/3:0H-kblockd]
>     30 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [cpuhp/4]


iotop -d 5 -o might be more revealing; all zeros doesn't really make
sense. I see balance and scrub reported in iotop.




-- 
Chris Murphy
