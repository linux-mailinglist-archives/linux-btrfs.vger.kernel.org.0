Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1516A805A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 11:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCBKyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 05:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCBKyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 05:54:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757C35BB
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 02:54:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x3so2890788edb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Mar 2023 02:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677754449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFIbpnaOzy8SEXP5oHAUpThqS5b8ilVzxmeWdGs8Rko=;
        b=SVpKQ4/u58sbMompNUAJFUfR76o9gmHRKjJX+kREhSl7jTgz242MCksEUNoOepIQvu
         66TkpuC0xspBBz0YilFDghI/Awu0PaaNdrRP3LmphiYTO+dUXGYfWrfsleQhdUlZxEjq
         Avl2MqTjm7H1WfOFE2dD40AIErS5o0TkTXf7r2+2NPGRFmwFZIATL5ffX8Hlo6NsjfXo
         pfziUl9kYwfpXBjIBgsp83rxAP/vJo5nsMVyZdf+Tmskj7o8kSk5PoxoFx09DFG+kMmR
         vI/5qUdw5AFw6awjqOo3xEfgId9lthcqs9zE89Nma9KIZUvifaFTpf81hlOhSHLs2y+Z
         tiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677754449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFIbpnaOzy8SEXP5oHAUpThqS5b8ilVzxmeWdGs8Rko=;
        b=JOIrLkUnuNrrxFlUQYtXfMOgM0XJXUM/QomRHm2PgXE9rlvEQ83EFEdEbzYgGKY9Cz
         QPbgjwfG0OjRedQW7r45K46HcL4+1vJy715pkQhXk3HmGX+rGlkib0LvdSbV0QaRnzTm
         tTKZQ+ULedTAqpXC2DAnnw4iDlCDF5su8rMvVqZE4iu6xumcgpUfWesBcZ4QJLIUdjBV
         oaThkAIu7ofKGzoPN0GsXrWkcCRL000cHhOyHpK8DtZQPAD6fKMgecCsxzZgdC8FSYDQ
         2dlkWGX7w4W2T2BQqc0hLJOnEf/EInxsAMkumQUjoy+w2hgOeWGKdWa6XU26WAKO++vp
         oPKA==
X-Gm-Message-State: AO0yUKWoEnYQNOMD+nNiF4hchNuh5HOi/LXmJaYcvGMgucpEuf2Lyanw
        pSE8Txz+MjGfsD68CdaL0Ps=
X-Google-Smtp-Source: AK7set8UxvaFfDVzlyamWySMlUxW+C43g8wHb1l28jl0sO9Jflso+fhg6HM7heAH2x4l6rZwCrUKGw==
X-Received: by 2002:a17:907:b15:b0:8aa:bf48:aae1 with SMTP id h21-20020a1709070b1500b008aabf48aae1mr10992178ejl.6.1677754448859;
        Thu, 02 Mar 2023 02:54:08 -0800 (PST)
Received: from nz (host81-129-83-161.range81-129.btcentralplus.com. [81.129.83.161])
        by smtp.gmail.com with ESMTPSA id lt20-20020a170906fa9400b008e97fdd6c7csm6899115ejb.129.2023.03.02.02.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:54:08 -0800 (PST)
Date:   Thu, 2 Mar 2023 10:54:06 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230302105406.2cd367f7@nz>
In-Reply-To: <94cf49d0-fa2d-cc2c-240e-222706d69eb3@oracle.com>
References: <Y/+n1wS/4XAH7X1p@nz>
        <94cf49d0-fa2d-cc2c-240e-222706d69eb3@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2 Mar 2023 17:12:27 +0800
Anand Jain <anand.jain@oracle.com> wrote:

> On 3/2/23 03:30, Sergei Trofimovich wrote:
> > Hi btrfs maintainers!
> > 
> > Tl;DR:
> > 
> >    After 63a7cb13071842 "btrfs: auto enable discard=async when possible" I
> >    see constant DISCARD storm towards my NVME device be it idle or not.
> > 
> >    No storm: v6.1 and older
> >    Has storm: v6.2 and newer
> > 
> > More words:
> > 
> > After upgrade from 6.1 to 6.2 I noticed that Disk led on my desktop
> > started flashing incessantly regardless of present or absent workload.
> > 
> > I think I confirmed the storm with `perf`: led flashes align with output
> > of:
> > 
> >      # perf ftrace -a -T 'nvme_setup*' | cat
> > 
> >      kworker/6:1H-298     [006]   2569.645201: nvme_setup_cmd <-nvme_queue_rq
> >      kworker/6:1H-298     [006]   2569.645205: nvme_setup_discard <-nvme_setup_cmd
> >      kworker/6:1H-298     [006]   2569.749198: nvme_setup_cmd <-nvme_queue_rq
> >      kworker/6:1H-298     [006]   2569.749202: nvme_setup_discard <-nvme_setup_cmd
> >      kworker/6:1H-298     [006]   2569.853204: nvme_setup_cmd <-nvme_queue_rq
> >      kworker/6:1H-298     [006]   2569.853209: nvme_setup_discard <-nvme_setup_cmd
> >      kworker/6:1H-298     [006]   2569.958198: nvme_setup_cmd <-nvme_queue_rq
> >      kworker/6:1H-298     [006]   2569.958202: nvme_setup_discard <-nvme_setup_cmd
> > 
> > `iotop` shows no read/write IO at all (expected).
> > 
> > I was able to bisect it down to this commit:
> > 
> >    $ git bisect good
> >    63a7cb13071842966c1ce931edacbc23573aada5 is the first bad commit
> >    commit 63a7cb13071842966c1ce931edacbc23573aada5
> >    Author: David Sterba <dsterba@suse.com>
> >    Date:   Tue Jul 26 20:54:10 2022 +0200
> > 
> >      btrfs: auto enable discard=async when possible
> > 
> >      There's a request to automatically enable async discard for capable
> >      devices. We can do that, the async mode is designed to wait for larger
> >      freed extents and is not intrusive, with limits to iops, kbps or latency.
> > 
> >      The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .
> > 
> >      The automatic selection is done if there's at least one discard capable
> >      device in the filesystem (not capable devices are skipped). Mounting
> >      with any other discard option will honor that option, notably mounting
> >      with nodiscard will keep it disabled.
> > 
> >      Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
> >      Reviewed-by: Boris Burkov <boris@bur.io>
> >      Signed-off-by: David Sterba <dsterba@suse.com>
> > 
> >     fs/btrfs/ctree.h   |  1 +
> >     fs/btrfs/disk-io.c | 14 ++++++++++++++
> >     fs/btrfs/super.c   |  2 ++
> >     fs/btrfs/volumes.c |  3 +++
> >     fs/btrfs/volumes.h |  2 ++
> >     5 files changed, 22 insertions(+)
> > 
> > Is this storm a known issue? I did not dig too much into the patch. But
> > glancing at it this bit looks slightly off:
> > 
> >      +       if (bdev_max_discard_sectors(bdev))
> >      +               fs_devices->discardable = true;
> > 
> > Is it expected that there is no `= false` assignment?
> > 
> > This is the list of `btrfs` filesystems I have:
> > 
> >    $ cat /proc/mounts | fgrep btrfs
> >    /dev/nvme0n1p3 / btrfs rw,noatime,compress=zstd:3,ssd,space_cache,subvolid=848,subvol=/nixos 0 0
> >    /dev/sda3 /mnt/archive btrfs rw,noatime,compress=zstd:3,space_cache,subvolid=5,subvol=/ 0 0
> >    # skipped bind mounts
> >   
> 
> 
> 
> > The device is:
> > 
> >    $ lspci | fgrep -i Solid
> >    01:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd. XPG SX8200 Pro PCIe Gen3x4 M.2 2280 Solid State Drive (rev 03)  
> 
> 
>   It is a SSD device with NVME interface, that needs regular discard.
>   Why not try tune io intensity using
> 
>   /sys/fs/btrfs/<uuid>/discard
> 
>   options?
> 
>   Maybe not all discardable sectors are not issued at once. It is a good
>   idea to try with a fresh mkfs (which runs discard at mkfs) to see if
>   discard is being issued even if there are no fs activities.

Ah, thank you Anand! I poked a bit more in `perf ftrace` and I think I
see a "slow" pass through the discard backlog:

    /sys/fs/btrfs/<UUID>/discard$  cat iops_limit
    10

Twice a minute I get a short burst of file creates/deletes that produces
a bit of free space in many block groups. That enqueues hundreds of work
items.

    $ sudo perf ftrace -a -T 'btrfs_discard_workfn' -T 'btrfs_issue_discard' -T 'btrfs_discard_queue_work'
     btrfs-transacti-407     [011]  42800.424027: btrfs_discard_queue_work <-__btrfs_add_free_space
     btrfs-transacti-407     [011]  42800.424070: btrfs_discard_queue_work <-__btrfs_add_free_space
     ...
     btrfs-transacti-407     [011]  42800.425053: btrfs_discard_queue_work <-__btrfs_add_free_space
     btrfs-transacti-407     [011]  42800.425055: btrfs_discard_queue_work <-__btrfs_add_free_space

193 entries of btrfs_discard_queue_work.
It took 1ms to enqueue all of the work into the workqueue.
    
     kworker/u64:1-2379115 [000]  42800.487010: btrfs_discard_workfn <-process_one_work
     kworker/u64:1-2379115 [000]  42800.487028: btrfs_issue_discard <-btrfs_discard_extent
     kworker/u64:1-2379115 [005]  42800.594010: btrfs_discard_workfn <-process_one_work
     kworker/u64:1-2379115 [005]  42800.594031: btrfs_issue_discard <-btrfs_discard_extent
     ...
     kworker/u64:15-2396822 [007]  42830.441487: btrfs_discard_workfn <-process_one_work
     kworker/u64:15-2396822 [007]  42830.441502: btrfs_issue_discard <-btrfs_discard_extent
     kworker/u64:15-2396822 [000]  42830.546497: btrfs_discard_workfn <-process_one_work
     kworker/u64:15-2396822 [000]  42830.546524: btrfs_issue_discard <-btrfs_discard_extent

286 pairs of btrfs_discard_workfn / btrfs_issue_discard.
Each pair takes 10ms to process, which seems to match iops_limit=10.
That means I can get about 300 discards per second max.

     btrfs-transacti-407     [002]  42830.634216: btrfs_discard_queue_work <-__btrfs_add_free_space
     btrfs-transacti-407     [002]  42830.634228: btrfs_discard_queue_work <-__btrfs_add_free_space
     ...

Next transaction started 30 seconds later, which is a default commit
interval.

My file system is of 512GB size. My guess I get about one discard entry
per block group on each 

Does my system keeps up with scheduled discard backlog? Can I peek at
workqueue size?

Is iops_limit=10 a reasonable default for discard=async? It feels like
for larger file systems it will not be enough even for this idle state.

-- 

  Sergei
