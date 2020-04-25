Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E073B1B89AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Apr 2020 23:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDYVzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Apr 2020 17:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgDYVzL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Apr 2020 17:55:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D74C09B04D
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 14:55:10 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l78so14181148qke.7
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmKxcQX/9eMu6RxPN8hk7+g/66cfuo7MRDWG3aaMjRQ=;
        b=WNAkkKdQLF3ep2nbaBlbkgx/F58Wi8JjfsmLqXuUBNrYNOUBFfbIckxJiBjIXwtNzN
         tDOR27Z5eY+YVnyAwX0Lrp299JsSsQyylid5Nv0n19ZD1YKVXNONcS0vBjKC3e05zKll
         7Q6ia5YZbF9RCsdrrSWplz1OW7dHHkiBJvOgVXhEmRX4UZXkBWkR019Uavu7WL2Ar/EH
         GrTVadUsWM4uSThRdmrnC9MKIW4tLYhr20nurQ1tEAN5FzYED3FyMNQy3LRFnNE+ZP7d
         /RsaEXlLcAhnvFo/UuzDjU+np8+rgVDBagUFXDSTrhfqpAjXlH9GQY4JHkbdz6fgAKAc
         jlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmKxcQX/9eMu6RxPN8hk7+g/66cfuo7MRDWG3aaMjRQ=;
        b=kyTsOANmzboo/V52Xx9DqxgSfpmgEXamx1Jg5ljes5apI11s5hP7Rzd0kQWrlaYc+5
         pY4887hVDFMT8Y6k5uR2B3sQUejfC2Rk4ZDCfagoMf9xb0zK/8i0LernLKs3y4aJkHyz
         bkepd/Fvq2YOH7PNpgCrjpKOi+EJ1phXazsEJeuY6K7r9/M6yJxpOErlFzKrSWZfZRpb
         OEDzSP5m5F5wbIMP88e/lez7yZxidfcT5Mg1FtMLO6nonhMJPPdODdqMmwBVWFpE1FHv
         T/HDf57e1SwSk9iavHtnRr2+PaRj0AzENr+qvVrG1sVjPLxPtE/CkaCNCusyb5KDmbES
         sp+A==
X-Gm-Message-State: AGi0PuaJKb7PM1vy2jP+bOdzCmIkjn/+sYx6p7iGC1r/pPiwgEEsJ1jd
        Jvqzu6VR7TUFT8TnUvpgz043qvKEj+C5aFHrFBU=
X-Google-Smtp-Source: APiQypLSEyldEoH03mmjjO3VStI6hPDAHlvohgs/zhkzij1eMOZ3SX3g6I26pOyIDvkmbgJRfIRBANH5Xl60b3vM1XU=
X-Received: by 2002:a37:9ad0:: with SMTP id c199mr14689045qke.472.1587851710002;
 Sat, 25 Apr 2020 14:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
 <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com>
In-Reply-To: <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com>
From:   Yegor Yegorov <gochkin@gmail.com>
Date:   Sun, 26 Apr 2020 00:54:58 +0300
Message-ID: <CAP7ccd8u-pStGzCau+bcYEVjRy+SPE+JQz169i_2NiY8dfUXuQ@mail.gmail.com>
Subject: Re: Help needed to recover from partition resize/move
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> You need to fix the partition/filesystem size mismatch first.
>
> fdisk -l /dev/sda
> btrfs insp dump-s /dev/sdaN

Hi Chris, thank you for taking the time to help me.

The reason I performed all those actions is that those are the actions
that are suggested in order to recover btrfs mount failures. I tried
to perform them in order from the least to the most dangerous and only
tried the next one after the previous one didn't help. In any case, I
did have dumped the failed btrfs partition to .img file in case the
things will go terribly wrong. I was hoping that I could just restore
it if to much damage were introduced. But I did take an image only of
the failed partition and not the entire drive, so now I'm afraid that
maybe the data needed to restore the partition is gone or overwritten,
because this data may be in the area outside the partition itself as
you suggested.

In any case, here are the outputs of the commands that you asked for:

$> fdisk -l /dev/nvme0n1
Disk /dev/nvme0n1: 476.96 GiB, 512110190592 bytes, 1000215216 sectors
Disk model: SAMSUNG MZVLW512HMJP-000H1
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 63C1ED58-4B39-428F-90F1-9CA561B96111

Device             Start        End   Sectors   Size Type
/dev/nvme0n1p1      2048     309247    307200   150M EFI System
/dev/nvme0n1p2 775952384  796432383  20480000   9.8G Linux swap
/dev/nvme0n1p3    309248  368949247 368640000 175.8G Linux filesystem
/dev/nvme0n1p7 796432384 1000214527 203782144  97.2G Linux filesystem

$> btrfs insp dump-s /dev/nvme0n1p3
superblock: bytenr=65536, device=/dev/nvme0n1p3
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x043ea018 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    90e9d74c-3606-4028-9e72-c10e76f44a7c
metadata_uuid           90e9d74c-3606-4028-9e72-c10e76f44a7c
label                   data
generation              49
root                    8612052992
sys_array_size          97
chunk_root_generation   46
root_level              1
chunk_root              1048576
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             188743680000
bytes_used              182011633664
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        48
uuid_tree_generation    48
dev_item.uuid           e2815a2c-6ec8-45c6-baae-7f429a5f0f78
dev_item.fsid           90e9d74c-3606-4028-9e72-c10e76f44a7c [match]
dev_item.type           0
dev_item.total_bytes    188743680000
dev_item.bytes_used     184704565248
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
