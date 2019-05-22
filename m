Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CDA267A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfEVQCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 12:02:53 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:43822 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVQCw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 12:02:52 -0400
Received: by mail-qk1-f170.google.com with SMTP id z6so1788998qkl.10
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2019 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LSX1uwEysf0i+XbQyxak14pGGhHDcDCU9Q3gNH3lQnk=;
        b=FN/Sf9o4SdAmF1hr6oWTFhxUHs0tf7CW9hbN4CXOKRDxMfc5CZw3ptYkoo4XS8s7Oe
         gybf9zRC+6CwTuzsKzzBPLdjT7jkIPx159C+eNHUNipzIgUcT9+x0uHQoTR3zXzrUFWZ
         ndl4NILDoWYnrz3ubp+bKqM9cu/ojxaSjhcL1XyXs4bURMUS2cZxiPjFrxqFu70AqTnX
         YYKZ3c0f8ZtNuef1lfTil9X09FrsTEygyy8tV9yIxExcStNxuqs/nik4jaf1DseI+5QH
         qi4Q+LJ6zZOB1qFQ5riwSmko7v8uAmqvie2gQVC5bXD8NFHvyBM7Lpk0N1IEEPFWphZc
         +xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LSX1uwEysf0i+XbQyxak14pGGhHDcDCU9Q3gNH3lQnk=;
        b=MKWgwQsykStMlbHQtPTbWSDk3K7q8MyxMdW9P2XTUz+ZONlGdrbsQu+sG4QGarbnBH
         nt4s0pqXuFo4EDCNEVfo9kvX6DVtoma5rLLGN6ECx/q56VT1dmXFuBnoC7mcSUVSnTM4
         rrx1JQbM80vjTbNcu9+X/yLWKwE71xfAiYActTRZ1V8rJ1IKUodh7Oq5JjYPnL5UjLDO
         Thx4v84i6c+1EpYdJ2NKB874K2SdT4wLLBTAWbjVMnHJt9lqgdayDEwfR/7qCWKmscc7
         pN5R+CGpnUHE3gUdUk1HQyjKlCCc6ZIq0I1Tc43XNWEgvP6c5bWLjKUjSixnO790jht6
         G5lg==
X-Gm-Message-State: APjAAAWYLdJJ68SF/vKvdh5aLxbAOlBWYHqyKoYOjZm1lB2N89B1FG49
        oe4lY6wP3e53VTqLpKZYfTA4hHWCuikwRf0J9A64Gg==
X-Google-Smtp-Source: APXvYqxb5OyBzgFawD20oAmNwvoqkyzRCr+sfrVPXkfFiNs07gTaSKR9X179mHnLURc0vRKWhfLTFJ5yOgbAOSVbNdc=
X-Received: by 2002:ae9:efcb:: with SMTP id d194mr61263843qkg.7.1558540971086;
 Wed, 22 May 2019 09:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk>
In-Reply-To: <20190521091842.GS1667@carfax.org.uk>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Wed, 22 May 2019 09:02:39 -0700
Message-ID: <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Hugo Mills <hugo@carfax.org.uk>,
        Erik Jensen <erikjensen@rkjnsn.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21, 2019 at 2:18 AM Hugo Mills <hugo@carfax.org.uk> wrote:
>
> On Tue, May 21, 2019 at 01:34:42AM -0700, Erik Jensen wrote:
> > I have a 5-drive btrfs filesystem. (raid-5 data, dup metadata). I can
> > mount it fine on my x86_64 system, and running `btrfs check` there
> > reveals no errors. However, I am not able to mount the filesystem on
> > my 32-bit ARM board, which I am hoping to use for lower-power file
> > serving. dmesg shows the following:
> >
> > [   83.066301] BTRFS info (device dm-3): disk space caching is enabled
> > [   83.072817] BTRFS info (device dm-3): has skinny extents
> > [   83.553973] BTRFS error (device dm-3): bad tree block start, want
> > 17628726968320 have 396461950000496896
> > [   83.554089] BTRFS error (device dm-3): bad tree block start, want
> > 17628727001088 have 5606876608493751477
> > [   83.601176] BTRFS error (device dm-3): bad tree block start, want
> > 17628727001088 have 5606876608493751477
> > [   83.610811] BTRFS error (device dm-3): failed to verify dev extents
> > against chunks: -5
> > [   83.639058] BTRFS error (device dm-3): open_ctree failed
> >
> > Is this expected to work? I did notice that there are gotchas on the
> > wiki related to filesystems over 8TiB on 32-bit systems, but it
> > sounded like they were mostly related to running the tools, as opposed
> > to the filesystem driver itself. (Each of the five drives is
> > 8TB/7.28TiB)
>
>    Yes, it should work. We had problems with ARM several years ago,
> because of its unusual behaviour with unaligned word accesses, but
> those were in userspace, and, as far as I know, fixed now. Looking at
> the want/have numbers, it doesn't look like an endianness problem or
> an ARM-unaligned-access problem.
>
> > If this isn't expected, what should I do to help track down the issue?
>
>    Can you show us the output of "btrfs check --readonly", on both the
> x86_64 machine and the ARM machine? It might give some more insight
> into the nature of the breakage.

On x86_64:
Opening filesystem to check...
Checking filesystem on /dev/mapper/storage1
UUID: aafd9149-9cfe-4970-ae21-f1065c36ed63
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 17647861833728 bytes used, no error found
total csum bytes: 17211131512
total tree bytes: 19333480448
total fs tree bytes: 202801152
total extent tree bytes: 183894016
btree space waste bytes: 1474174626
file data blocks allocated: 17628822319104
 referenced 17625817141248

On ARM:
Opening filesystem to check...
Checking filesystem on /dev/mapper/storage1
UUID: aafd9149-9cfe-4970-ae21-f1065c36ed63
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 17647861833728 bytes used, no error found
total csum bytes: 17211131512
total tree bytes: 19333480448
total fs tree bytes: 202801152
total extent tree bytes: 183894016
btree space waste bytes: 1474174626
file data blocks allocated: 17628822319104
 referenced 17625817141248

>    Possibly also "btrfs inspect dump-super" on both machines.

On x86_64:
superblock: bytenr=65536, device=/dev/dm-5
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x737fcf72 [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            aafd9149-9cfe-4970-ae21-f1065c36ed63
label            Storage
generation        97532
root            30687232
sys_array_size        129
chunk_root_generation    97526
root_level        1
chunk_root        20971520
chunk_root_level    1
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        40007732224000
bytes_used        17647861833728
sectorsize        4096
nodesize        16384
leafsize (deprecated)        16384
stripesize        4096
root_dir        6
num_devices        5
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x1e1
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              RAID56 |
              SKINNY_METADATA )
cache_generation    97532
uuid_tree_generation    97532
dev_item.uuid        39a9463d-65f5-499b-bca8-dae6b52eb729
dev_item.fsid        aafd9149-9cfe-4970-ae21-f1065c36ed63 [match]
dev_item.type        0
dev_item.total_bytes    8001546444800
dev_item.bytes_used    4436709605376
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        5
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0

On ARM:
superblock: bytenr=65536, device=/dev/dm-2
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x737fcf72 [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            aafd9149-9cfe-4970-ae21-f1065c36ed63
metadata_uuid        aafd9149-9cfe-4970-ae21-f1065c36ed63
label            Storage
generation        97532
root            30687232
sys_array_size        129
chunk_root_generation    97526
root_level        1
chunk_root        20971520
chunk_root_level    1
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        40007732224000
bytes_used        17647861833728
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        5
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x1e1
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              RAID56 |
              SKINNY_METADATA )
cache_generation    97532
uuid_tree_generation    97532
dev_item.uuid        39a9463d-65f5-499b-bca8-dae6b52eb729
dev_item.fsid        aafd9149-9cfe-4970-ae21-f1065c36ed63 [match]
dev_item.type        0
dev_item.total_bytes    8001546444800
dev_item.bytes_used    4436709605376
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        5
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0

Only difference appears to the extra metadata_uuid line on ARM. I
assume that's because the ARM system is running btrfs-progs v4.20.2 vs
v4.19 on the x86_64 system.

> > Also potentially relevant: The x86_64 system is currently running
> > 4.19.27, while the ARM system is running 5.1.3.
>
>    Shouldn't make a difference.
>
> > Finally, just in case it's relevant, I just finished reencrypting the
> > array, which involved doing a `btrfs replace` on each device in the
> > array.
>
>    If you can still mount on x86_64, then the FS is at least
> reasonably complete and undamaged. I don't think this will make a
> difference.  However, it's worth checking whether there are any
> funnies about your encryption layer on ARM (I wouldn't expect any,
> since it's recognising the decrypted device as btrfs, rather than
> random crud).

I took the sha256 hash of the first GiB of plaintext on each drive,
and got the same result on both systems, so I think things should be
okay, there.

>    Hugo.
>
> --
> Hugo Mills             | Prisoner unknown: Return to Zenda.
> hugo@... carfax.org.uk |
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |
