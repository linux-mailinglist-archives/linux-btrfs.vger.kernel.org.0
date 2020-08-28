Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF202561FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 22:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH1U1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 16:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1U1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 16:27:50 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B208C061264
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 13:27:50 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id k18so120941uao.11
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 13:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2n8Y57XH0O2uptRv287tvpsnfQuxqQOpDOcjobzuNMI=;
        b=GlCq8OI1eUJiP19ugSaldKmpKhL1vcnCI4A9x4rcllsvovnvW9AbEqcFZxv+73RSTF
         3pR/F1eYQY6eUrV/n03/HTf1nRr4iORsCV86LQfYZYFSu4QPiE2EsPhXK4FUoIjkhTTn
         OiJi47haDmBnaGffgrIux0fKRQLztwaRNVcf8a5GFPZ5YnREPF0KPMI9Zc+z9FUZGAHx
         EgC4x4ZdPHL4nVLfvBcVm11z2Ho4s1injSBlDT6euBo/anXc+gYLZTZl6GiEO/+Z92c+
         8mfVojeXH164DUO0gBswmYWz+rtvd1jILcB/xsKPlo4XPvSAA4irRgEU7rt0788eHSlT
         pUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2n8Y57XH0O2uptRv287tvpsnfQuxqQOpDOcjobzuNMI=;
        b=LwjSgZD0GiaQ9NDPtzXhNCd9MTUrnZiteVe+FwTET5+x+nOjo6m0nML8KqSjqV77EB
         pbGdSphRvmYoX4KOYVMjJteH762dsxZZL+ls8RKzqrpl1Gw/pKteapdISs1x+EgSSknn
         MF6WOOUYb/+WrcNwobakw4RElENUG4JHNTN15NjuISFj4yt7PwoM2EjLymY8BkWlm6Ye
         FiigeOrh8++cFbLkw0PA7Dv65r9ksFDmbXkfDiBxGvK42B73hnjy1Jpx0EdW8cVJ3d93
         lUdLChD5KIofVeRzcoZ+2GQIe7EgP9BNNnsI25EbQQ3B/UQuC6pwDGWgN8xtfthifUER
         4j+w==
X-Gm-Message-State: AOAM530QM1+qHUh/e8gUf76PGGHnzkGScW0CbXGF27bt00F0Zio7zGY8
        tmiLTUdk/LRvGJyJ7lztF1sPkAwrIwVjkthf2lRsJE4D
X-Google-Smtp-Source: ABdhPJwMvyzpuC9uNI3aZATN/uiwt49KmmVY1fAx45Q2TmFXf08KEUWlcOXXykACMvHcjEv102VoN0Pvfk1SxgewZ14=
X-Received: by 2002:a9f:26a5:: with SMTP id 34mr418344uay.67.1598646469179;
 Fri, 28 Aug 2020 13:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <CALpYhWwfmBNqDgSGf4DawArhSMWDyoCHFWb4dESoRtMV1Dd3Eg@mail.gmail.com>
In-Reply-To: <CALpYhWwfmBNqDgSGf4DawArhSMWDyoCHFWb4dESoRtMV1Dd3Eg@mail.gmail.com>
From:   Tristan Plumb <wild.rugosa@gmail.com>
Date:   Fri, 28 Aug 2020 16:27:38 -0400
Message-ID: <CALpYhWwqOpa8PL0ymEkUvr1jpQAmi+Hz39cysbU0utvv6KUTKA@mail.gmail.com>
Subject: Re: [help] bad csum and magic on both superblocks
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In case someone comes across this having seen something similar. This
is what it looks like when you have removed a disk from a multi-disk
btrfs. I've recovered my old drive enough to get the data off and
found that it wasn't using the old drive anymore.

Cheers,
Tristan

On Sun, Aug 23, 2020 at 3:36 PM Tristan Plumb <wild.rugosa@gmail.com> wrote:
>
> I had two nvme drives set up with raid1 metadata and rai0 data. One of
> them failed, as far as I
> can tell it shorted the 3.3v rail to ground, but the other is mostly
> fine. However, neither of the two
> superblocks have correct checksums or magic, though they appear to be
> practically identical.
>
> None of the tools that I've tried to use so far, other than
> inspect-internal dump-super, have
> provided an option to skip the superblock checksum and magic test, so
> I get results like:
>
> [root@ping:~]# btrfs restore -l -i /dev/nvme1n1p2
> No valid Btrfs found on /dev/nvme1n1p2
> Could not open root, trying backup super
> ERROR: superblock checksum mismatch
> No valid Btrfs found on /dev/nvme1n1p2
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 190805180416
> Could not open root, trying backup super
>
> The other contents of the superblock looks fairly reasonable however.
> Would people
> recommend that I add an option to ignore the checksum/magic errors
> (which is my inclination),
> or that I repair the superblock manually somehow? Or (and my real
> reason for bothering you all)
> is there another option/approach that someone would suggest?
>
> Cheers,
> Tristan
>
> [root@ping:~]# uname -a; btrfs --version
> Linux ping 5.4.59 #1-NixOS SMP Wed Aug 19 06:16:29 UTC 2020 x86_64 GNU/Linux
> btrfs-progs v5.7
>
> [root@ping:~]# btrfs inspect-internal dump-super -s 0 --force /dev/nvme1n1p2
> superblock: bytenr=65536, device=/dev/nvme1n1p2
> ---------------------------------------------------------
> csum_type 0 (crc32c)
> csum_size 4
> csum 0x344a5afc [DON'T MATCH]
> bytenr 65536
> flags 0x1
> ( WRITTEN )
> magic ........ [DON'T MATCH]
> fsid badf716b-44c3-42a5-af84-bb91fccf0f47
> metadata_uuid badf716b-44c3-42a5-af84-bb91fccf0f47
> label
> generation 730413
> root 914966282240
> sys_array_size 97
> chunk_root_generation 730413
> root_level 1
> chunk_root 912808476672
> chunk_root_level 1
> log_root 0
> log_root_transid 0
> log_root_level 0
> total_bytes 2171858845696
> bytes_used 369171148800
> sectorsize 4096
> nodesize 16384
> leafsize (deprecated) 16384
> stripesize 4096
> root_dir 6
> num_devices 2
> compat_flags 0x0
> compat_ro_flags 0x0
> incompat_flags 0x161
> ( MIXED_BACKREF |
>   BIG_METADATA |
>   EXTENDED_IREF |
>   SKINNY_METADATA )
> cache_generation 730413
> uuid_tree_generation 730413
> dev_item.uuid a792e7c4-88a8-4e2e-9d68-39baa50b6d0d
> dev_item.fsid badf716b-44c3-42a5-af84-bb91fccf0f47 [match]
> dev_item.type 0
> dev_item.total_bytes 190805180416
> dev_item.bytes_used 4328521728
> dev_item.io_align 4096
> dev_item.io_width 4096
> dev_item.sector_size 4096
> dev_item.devid 1
> dev_item.dev_group 0
> dev_item.seek_speed 0
> dev_item.bandwidth 0
> dev_item.generation 0
>
> [root@ping:~]# btrfs inspect-internal dump-super -s 1 --force /dev/nvme1n1p2
> superblock: bytenr=67108864, device=/dev/nvme1n1p2
> ---------------------------------------------------------
> csum_type 0 (crc32c)
> csum_size 4
> csum 0x942b7232 [DON'T MATCH]
> bytenr 67108864
> flags 0x1
> ( WRITTEN )
> magic ........ [DON'T MATCH]
> fsid badf716b-44c3-42a5-af84-bb91fccf0f47
> metadata_uuid badf716b-44c3-42a5-af84-bb91fccf0f47
> label
> generation 730413
> root 914966282240
> sys_array_size 97
> chunk_root_generation 730413
> root_level 1
> chunk_root 912808476672
> chunk_root_level 1
> log_root 0
> log_root_transid 0
> log_root_level 0
> total_bytes 2171858845696
> bytes_used 369171148800
> sectorsize 4096
> nodesize 16384
> leafsize (deprecated) 16384
> stripesize 4096
> root_dir 6
> num_devices 2
> compat_flags 0x0
> compat_ro_flags 0x0
> incompat_flags 0x161
> ( MIXED_BACKREF |
>   BIG_METADATA |
>   EXTENDED_IREF |
>   SKINNY_METADATA )
> cache_generation 730413
> uuid_tree_generation 730413
> dev_item.uuid a792e7c4-88a8-4e2e-9d68-39baa50b6d0d
> dev_item.fsid badf716b-44c3-42a5-af84-bb91fccf0f47 [match]
> dev_item.type 0
> dev_item.total_bytes 190805180416
> dev_item.bytes_used 4328521728
> dev_item.io_align 4096
> dev_item.io_width 4096
> dev_item.sector_size 4096
> dev_item.devid 1
> dev_item.dev_group 0
> dev_item.seek_speed 0
> dev_item.bandwidth 0
> dev_item.generation 0
