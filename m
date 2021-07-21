Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082F33D127B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbhGUOyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:54:50 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:39594 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbhGUOyj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:54:39 -0400
Received: by mail-il1-f182.google.com with SMTP id a7so2655676iln.6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 08:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mod1ViaYD0Pfs2Hzs88VNlBVAB/PGqlbg0N8wPaCzNk=;
        b=jo2+4vDdJlUIEf45PX6qb1uhuNN4a/Dq02okqK5Ul0EYDxAfFB+L7aPJuI4K7vWJh8
         h75NUjjxxk5cIhhYYY2rORu7h1DlJLSlKJWlcuILfPLvJjqAG4jk1vxnwiWs3ITau6iZ
         XNkrsOHvE8+E67BRcrgvCR20naESKb9xGjjjLIwLcJWeRdJ9p3KJUHD8cMt4CEjqeWFx
         WUe0Kv5WrKsOrRv/PCyo9mA5SViKHN6LvOwiX0Nrs5MY4WwVk/WuIMeVf9f5CyKbOWO6
         ksAtnkLc9lXNuROA5kgJz42JDYF9OlzcFfH3B2RBNHFs2SUcs+rdGGRDxEFh15P4Kfow
         HOIw==
X-Gm-Message-State: AOAM531E+jvj2oosT4eqsm/QrTCYxZPnIF7ybZu1Yp1u6Q+/kHG1WYKD
        28w4EljIIVayKAgqbgxkFC0=
X-Google-Smtp-Source: ABdhPJx10QC4IFZ45SxJyqz1FgQer0qmUJttNcXzRFVzLRsdAY6q3zTx+geCKzvLEHor44RC3HV92A==
X-Received: by 2002:a05:6e02:1d15:: with SMTP id i21mr24656714ila.307.1626881714431;
        Wed, 21 Jul 2021 08:35:14 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id a11sm12931860ilf.79.2021.07.21.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 08:35:14 -0700 (PDT)
Date:   Wed, 21 Jul 2021 15:35:12 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corruption errors on Samsung 980 Pro (FIXED for now)
Message-ID: <YPg+sDs6+tY6LO08@google.com>
References: <2729231.WZja5ltl65@ananda>
 <2078476.5JW8h9ZS4m@ananda>
 <92baa2b1-88ce-492f-f206-39b1dafc573a@gmx.com>
 <2087201.fsvZfV134Y@ananda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2087201.fsvZfV134Y@ananda>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On Tue, Jul 20, 2021 at 08:56:21AM +0200, Martin Steigerwald wrote:
> Qu Wenruo - 18.07.21, 02:16:19 CEST:
> > On 2021/7/17 下午4:31, Martin Steigerwald wrote:
> > > Martin Steigerwald - 16.07.21, 17:19:55 CEST:
> > >> Martin Steigerwald - 16.07.21, 17:05:59 CEST:
> > >>> I migrated to a different laptop and this one has a 2TB Samsung 980 Pro drive
> > >>> (not a 2TB Samsung 870 Evo Plus which previously had problems).
> > >>
> > >> Kernel is:
> > >>
> > >> % cat /proc/version
> > >> Linux version 5.13.1-t14 (martin@[…]) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #14 SMP PREEMPT Mon Jul 12 10:36:54 CEST 2021
> > >
> > > Another addition that might be important. I am using xxhash.
> > >
> > > I created the filesystem like that:
> > >
> > > % mkfs.btrfs -L home --csum xxhash /dev/nvme/home
> > >
> > > So it is xxhash, discard=async and space cache v2.
> > 
> > My educiated guess is async.
> > 
> > The reason is that all affected tree blocks are showing a fixed pattern:
> > have 0x48be03222606a29d expected csum 0x0100000026004000
> 
> Thank you.
> 
> Now it gets interesting. I just found, as I wanted to disable discard,
> that it was not enabled to begin with:
> 
> % grep home /etc/fstab
> /dev/nvme/home  /home           btrfs   lazytime,compress=zstd                                  0       0
> […]
> 
> It appears that out of caution after my experiences with Samsung 870 Evo
> Plus I went without "discard=async".
> 
> Also I stated the exact mount options further down in the mail. No
> discard in there:
> 
> > >>> It is BTRFS single profile on LVM on LUKS. Mount options are:
> > >>>
> > >>> rw,relatime,lazytime,compress=zstd:3,ssd,space_cache=v2,subvolid=1054,subvol=/home
> 
> So that part of my mail where I claimed I was using "discard=async" was
> inaccurate.
> 
> > This pretty much means those tree blocks have been discarded.
> > 
> > But I'm not familiar with that part.
> > 
> > Dennis is more familiar with this, maybe he could provide some idea on this.
> 
> Any other insights?

Sorry for the late reply.

I'm not particularly involved with btrfs these days. It seems there has
been some changes but nothing major looking at the review log of
fs/btrfs/discard.c.

This may be more insightful for Qu, but here's just a quick idea behind
async discard. The block_groups are what manage allocated space on disk
while the free_space_cache is effectively the negative of that per
block_group. I didn't do a disk modification so the free_space_cache
doesn't track the async state and will bring up a newly mounted file
system as completely untrimmed and async discard will do it's thing.

Async discard traverses the free_space_cache of block_groups and
performs allocation, trim, and freeing. By doing it this way, we avoid
racing with allocations and can live outside the transaction commit
lifecycle.

Sync discard operates on the freed region during transaction commit
before returning it to the free_space_cache.

Given the above, I find it hard that async discard would be directly
responsible for what you're seeing as it just relies on the
free_space_cache accounting. It's possible though there might be
something wrong with the on disk free_space_cache representation and
that would lead to potentially something like this.

Thanks,
Dennis

> 
> Best,
> Martin
> 
> > Thanks,
> > Qu
> > >
> > > Maybe something in this combination is not yet fully stable?
> > >
> > > https://btrfs.wiki.kernel.org/index.php/Status says additional checksum
> > > algorithms are stable. It also states free space cache is stable. And it
> > > states that asynchronous discards are stable. It does not explicitly
> > > mention xxhash or free space v2 are stable too. I bet it may be included
> > > in the general statement, but I am not completely sure.
> > >
> > > However what I just did is:
> > >
> > > % mount -o remount,clear_cache,space_cache=v2 /home
> > >
> > > And I now get:
> > >
> > > % btrfs scrub status /home
> > > UUID:             […]
> > > Scrub started:    Sat Jul 17 10:24:54 2021
> > > Status:           finished
> > > Duration:         0:01:43
> > > Total to scrub:   178.39GiB
> > > Rate:             1.73GiB/s
> > > Error summary:    no errors found
> > >
> > > Hopefully it will stay this way. Fingers crossed.
> > >
> > > So a good trick in case there is no file mentioned in kernal log may be to clear
> > > free space tree and see whether the checksum errors go away.
> > >
> > > If anyone can make any additional sense out of this, please go ahead.
> > >
> > >>> I thought this time I would be fine, but I just got:
> > >>>
> > >>> [63168.287911] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63168.287925] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> > >>> [63168.346552] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63168.346567] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> > >>> [63168.346685] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63168.346708] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> > >>> [63168.346859] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63168.346873] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> > >>> [63299.490367] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63299.490384] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> > >>> [63299.572849] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63299.572866] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> > >>> [63299.573151] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63299.573168] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> > >>> [63299.573286] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
> > >>> [63299.573295] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> > >>> [63588.902631] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> > >>> [63588.902647] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 13, gen 0
> > >>> [63588.949614] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> > >>> [63588.949628] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 14, gen 0
> > >>> [63588.949849] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> > >>> [63588.949855] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 15, gen 0
> > >>> [63588.950087] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
> > >>> [63588.950099] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 16, gen 0
> > >>
> > >> Additional errors revealed through scrubbing – will test the other
> > >> filesystems as well:
> > >>
> > >> % btrfs scrub status /home
> > >> UUID:             […]
> > >> Scrub started:    Fri Jul 16 17:08:49 2021
> > >> Status:           finished
> > >> Duration:         0:02:05
> > >> Total to scrub:   203.54GiB
> > >> Rate:             1.63GiB/s
> > >> Error summary:    csum=5
> > >>    Corrected:      0
> > >>    Uncorrectable:  5
> > >>    Unverified:     0
> > >>
> > >> Now totalling to 21 errors:
> > >>
> > >> % btrfs device stats /home
> > >> [/dev/mapper/nvme-home].write_io_errs    0
> > >> [/dev/mapper/nvme-home].read_io_errs     0
> > >> [/dev/mapper/nvme-home].flush_io_errs    0
> > >> [/dev/mapper/nvme-home].corruption_errs  21
> > >> [/dev/mapper/nvme-home].generation_errs  0
> > >>
> > >> Log:
> > >>
> > >> [64707.979036] BTRFS info (device dm-3): scrub: started on devid 1
> > >> [64730.009687] BTRFS warning (device dm-3): checksum error at logical 36997591040 on dev /dev/mapper/nvme-home, physical 34850107392, root 1054, inode 2295743, offset 2718461952: path resolving failed with ret=-2
> > >> [64730.009710] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 17, gen 0
> > >> [64730.009721] BTRFS error (device dm-3): unable to fixup (regular) error at logical 36997591040 on dev /dev/mapper/nvme-home
> > >> [64730.010996] BTRFS warning (device dm-3): checksum error at logical 36997595136 on dev /dev/mapper/nvme-home, physical 34850111488, root 1054, inode 4895964, offset 7676579840: path resolving failed with ret=-2
> > >> [64730.011014] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 18, gen 0
> > >> [64730.011024] BTRFS error (device dm-3): unable to fixup (regular) error at logical 36997595136 on dev /dev/mapper/nvme-home
> > >> [64730.011298] BTRFS warning (device dm-3): checksum error at logical 36997599232 on dev /dev/mapper/nvme-home, physical 34850115584, root 1054, inode 4895964, offset 7676579840: path resolving failed with ret=-2
> > >> [64730.011312] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 19, gen 0
> > >> [64730.011319] BTRFS error (device dm-3): unable to fixup (regular) error at logical 36997599232 on dev /dev/mapper/nvme-home
> > >> [64730.011603] BTRFS warning (device dm-3): checksum error at logical 36997603328 on dev /dev/mapper/nvme-home, physical 34850119680, root 1054, inode 4895964, offset 7676579840: path resolving failed with ret=-2
> > >> [64730.011616] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 20, gen 0
> > >> [64730.011623] BTRFS error (device dm-3): unable to fixup (regular) error at logical 36997603328 on dev /dev/mapper/nvme-home
> > >> [64730.011905] BTRFS warning (device dm-3): checksum error at logical 36997607424 on dev /dev/mapper/nvme-home, physical 34850123776, root 1054, inode 4895964, offset 7676579840: path resolving failed with ret=-2
> > >> [64730.011921] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 21, gen 0
> > >> [64730.011928] BTRFS error (device dm-3): unable to fixup (regular) error at logical 36997607424 on dev /dev/mapper/nvme-home
> > >> [64832.447560] BTRFS info (device dm-3): scrub: finished on devid 1 with status: 0
> > >>
> > >> Why is BTRFS unable to determine a path?
> > >>
> > >> How would I fix those when BTRFS does not tell me what file is affected?
> > >>
> > >>> during a backup.
> > >>>
> > >>> According to rsync this is related (why does BTRFS does not report the
> > >>> affected file?)
> > >>>
> > >>> Create a snapshot of '/home' in '/zeit/home/backup-2021-07-16-16:40:13'
> > >>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/output error (5)
> > >>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/output error (5)
> > >>> ERROR: martin/.local/share/akonadi/search_db/email/postlist.glass failed verification -- update discarded.
> > >>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/baloo/index": Input/output error (5)
> > >>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/baloo/index": Input/output error (5)
> > >>> ERROR: martin/.local/share/baloo/index failed verification -- update discarded.
> > >>>
> > >>> Both are frequently written to files (both Baloo and Akonadi have very crazy
> > >>> I/O patterns that, I would not have thought so, can even satisfy an NVMe SSD).
> > >>>
> > >>> I thought that a Samsung 980 Pro can easily handle "discard=async" so I
> > >>> used it.
> > >>>
> > >>> This is on a ThinkPad T14 Gen1 with AMD Ryzen 7 PRO 4750U and 32 GiB of RAM.
> > >>>
> > >>> It is BTRFS single profile on LVM on LUKS. Mount options are:
> > >>>
> > >>> rw,relatime,lazytime,compress=zstd:3,ssd,space_cache=v2,subvolid=1054,subvol=/home
> > >>>
> > >>> Smartctl has no errors.
> > >>>
> > >>> I only use a few (less than 10) subvolumes.
> > >>>
> > >>> I do not have any other errors in kernel log, so I bet this may not be
> > >>> "discard=async" related. Any idea?
> > >>
> > >> Maybe I still remove "discard=async" for now. Maybe it is not yet fully reliable.
> > >>
> > >>> Could it have to do with a sudden switching off the laptop (there had
> > >>> been quite some reasons cause at least with a AMD model of this laptop
> > >>> in combination with an USB-C dock by Lenovo there are quite some stability
> > >>> issues)? I would have hoped that the Samsung 980 Pro would still be
> > >>> equipped to complete the outstanding write operation, but maybe it has
> > >>> no capacitor for this.
> > >>>
> > >>> I am really surprised by the what I experienced about the reliability of
> > >>> SSDs I recently bought. I did not see a failure within a month with any
> > >>> of the older SSDs. I hope this does not point at a severe worsening of
> > >>> the quality. Probably I have to fit another SSD in there and use BTRFS
> > >>> RAID 1 again to protect at least part of the data from errors like this.
> > >>>
> > >>> Any idea about this? I bet you may not have any, as there is not block
> > >>> I/O related errors in the log, but if you have, by all means share your
> > >>> thoughts. Thank you.
> > >>>
> > >>> Both files can be recreated. So I bet I will just remove them.
> > >>>
> > >>> Best,
> > >>
> > >
> > >
> > 
> 
> 
> -- 
> Martin
> 
> 
