Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17896A7446
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 20:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCATag (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCATaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 14:30:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594EF72B4
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 11:30:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bw19so14352408wrb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Mar 2023 11:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677699033;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JENZ2PyJ5xc39/uskeayg7L5ISKwfhAwyP5O+O4jvxA=;
        b=qpFz1cWxqsKzQT/GWTO3Ori1rCBY1AL2Wzj9NZAvVIz1hXM22+bZhDs1QAZFKev+Zh
         HFTkZyYmLiK/rgmE8gFIcPWTch2XgdS5tmECaAbOglb8YwHZlkYYJlvQNIFUMq1U1uaE
         xWIFf2VMM3nD6DPo6KVNBaf2aNv+Z+1/pqMtCnQhWvNQb8hKEXAtiHn8eMFonFGAfk22
         CCtDTF8AVRbtZ35VaVT1Cvc5hdc+4ASAnTFkL6ymo7OVLUBXB2e0tz/J0WTbkBHQzlvD
         nuSs2+kVw2IA78bOYn3THyrhMflRYMBs8ll9QR8Nrnzj97LEOSWZQ5SZ0jV6UDawRQw6
         iYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677699033;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JENZ2PyJ5xc39/uskeayg7L5ISKwfhAwyP5O+O4jvxA=;
        b=vm5yWnsIwZ8066GVkf6uWkLbGM+MJvj0XhIunYtBEljvT5MhX+8ZjTAWYlf2EyNpCv
         OFQscL+K0BxSgDeIQQ00iYhvRV3S/HVpdROUH32tMS+w4JJ39v7fTuBel/GBHWro2sdS
         zZC4ScAa3I/CLchkxC8ujjtwmVr/VMlsrYNyWK4EMrVMvwEdLqssHFTHCTnjnqkl6PGf
         HARpDDs7InHPFzb6eoBNke76RweAVDvH2CX6wykrVXMy7aVyy7as/eMd3y6vqgl7CIUS
         mLSTKnD45b8u+HWkgihCCUKnj1ioIWP0mX8335+d134g3ZMZ8+1S2C1T8A7dCQ1UobYe
         N43w==
X-Gm-Message-State: AO0yUKW+53eSFqdnRsv0fwi2ix6YtrbtSeHFK/By6jkMvWboisvmPYvJ
        7NF5zgVrbfNXwowmCc/vsojmDfHLBF2bZQ==
X-Google-Smtp-Source: AK7set8QnTr9A4GQGe/1DbFdDGe+ZopHLq2zkZiNlzyinLr3A9TuvJESDV4WSkgnaCTisa0f8Ud/tA==
X-Received: by 2002:adf:ee85:0:b0:2c7:d6a:d7fa with SMTP id b5-20020adfee85000000b002c70d6ad7famr6031609wro.25.1677699032743;
        Wed, 01 Mar 2023 11:30:32 -0800 (PST)
Received: from nz.home (host81-129-83-161.range81-129.btcentralplus.com. [81.129.83.161])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d424b000000b002c55521903bsm13231419wrr.51.2023.03.01.11.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 11:30:32 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
        id 6AFD3A4CD2F98; Wed,  1 Mar 2023 19:30:31 +0000 (GMT)
Date:   Wed, 1 Mar 2023 19:30:31 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <Y/+n1wS/4XAH7X1p@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi btrfs maintainers!

Tl;DR:

  After 63a7cb13071842 "btrfs: auto enable discard=async when possible" I
  see constant DISCARD storm towards my NVME device be it idle or not.

  No storm: v6.1 and older
  Has storm: v6.2 and newer

More words:

After upgrade from 6.1 to 6.2 I noticed that Disk led on my desktop
started flashing incessantly regardless of present or absent workload.

I think I confirmed the storm with `perf`: led flashes align with output
of:

    # perf ftrace -a -T 'nvme_setup*' | cat

    kworker/6:1H-298     [006]   2569.645201: nvme_setup_cmd <-nvme_queue_rq
    kworker/6:1H-298     [006]   2569.645205: nvme_setup_discard <-nvme_setup_cmd
    kworker/6:1H-298     [006]   2569.749198: nvme_setup_cmd <-nvme_queue_rq
    kworker/6:1H-298     [006]   2569.749202: nvme_setup_discard <-nvme_setup_cmd
    kworker/6:1H-298     [006]   2569.853204: nvme_setup_cmd <-nvme_queue_rq
    kworker/6:1H-298     [006]   2569.853209: nvme_setup_discard <-nvme_setup_cmd
    kworker/6:1H-298     [006]   2569.958198: nvme_setup_cmd <-nvme_queue_rq
    kworker/6:1H-298     [006]   2569.958202: nvme_setup_discard <-nvme_setup_cmd

`iotop` shows no read/write IO at all (expected).

I was able to bisect it down to this commit:

  $ git bisect good
  63a7cb13071842966c1ce931edacbc23573aada5 is the first bad commit
  commit 63a7cb13071842966c1ce931edacbc23573aada5
  Author: David Sterba <dsterba@suse.com>
  Date:   Tue Jul 26 20:54:10 2022 +0200

    btrfs: auto enable discard=async when possible

    There's a request to automatically enable async discard for capable
    devices. We can do that, the async mode is designed to wait for larger
    freed extents and is not intrusive, with limits to iops, kbps or latency.

    The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .

    The automatic selection is done if there's at least one discard capable
    device in the filesystem (not capable devices are skipped). Mounting
    with any other discard option will honor that option, notably mounting
    with nodiscard will keep it disabled.

    Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
    Reviewed-by: Boris Burkov <boris@bur.io>
    Signed-off-by: David Sterba <dsterba@suse.com>

   fs/btrfs/ctree.h   |  1 +
   fs/btrfs/disk-io.c | 14 ++++++++++++++
   fs/btrfs/super.c   |  2 ++
   fs/btrfs/volumes.c |  3 +++
   fs/btrfs/volumes.h |  2 ++
   5 files changed, 22 insertions(+)

Is this storm a known issue? I did not dig too much into the patch. But
glancing at it this bit looks slightly off:

    +       if (bdev_max_discard_sectors(bdev))
    +               fs_devices->discardable = true;

Is it expected that there is no `= false` assignment?

This is the list of `btrfs` filesystems I have:

  $ cat /proc/mounts | fgrep btrfs
  /dev/nvme0n1p3 / btrfs rw,noatime,compress=zstd:3,ssd,space_cache,subvolid=848,subvol=/nixos 0 0
  /dev/sda3 /mnt/archive btrfs rw,noatime,compress=zstd:3,space_cache,subvolid=5,subvol=/ 0 0
  # skipped bind mounts

The device is:

  $ lspci | fgrep -i Solid
  01:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd. XPG SX8200 Pro PCIe Gen3x4 M.2 2280 Solid State Drive (rev 03)

Can you help me debug the source of discards storm?

Is it an expected discard storm?

Is it problematic for SSD life span?

Thank you!

-- 

  Sergei
