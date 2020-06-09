Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36E11F49FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 01:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFIXJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 19:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgFIXJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 19:09:13 -0400
Received: from syrinx.knorrie.org (syrinx.knorrie.org [IPv6:2001:888:2177::4d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C1C05BD1E
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 16:09:12 -0700 (PDT)
Received: from [IPv6:2a02:a213:2b80:f000::12] (unknown [IPv6:2a02:a213:2b80:f000::12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 6BF7260940FE0;
        Wed, 10 Jun 2020 01:09:06 +0200 (CEST)
Subject: Re: BTRFS File Delete Speed Scales With File Size?
To:     "Ellis H. Wilson III" <ellisw@panasas.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
From:   Hans van Kranenburg <hans@knorrie.org>
Autocrypt: addr=hans@knorrie.org; keydata=
 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
Message-ID: <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
Date:   Wed, 10 Jun 2020 01:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

On 6/9/20 5:31 PM, Ellis H. Wilson III wrote:
> Hi folks,
> 
> We have a few engineers looking through BTRFS code presently for answers 
> to this, but I was interested to get input from the experts in parallel 
> to hopefully understand this issue quickly.
> 
> We find that removes of large amounts of data can take a significant 
> amount of time in BTRFS on HDDs -- in fact it appears to scale linearly 
> with the size of the file.  I'd like to better understand the mechanics 
> underpinning that behavior.

Like Adam already mentioned, the amount and size of the individual
extent metadata items that need to be removed is one variable in the big
equation.

The code in show_file.py example in python-btrfs is a bit outdated, and
it prints info about all extents that are referenced and a bit more.

Alternatively, we can only look at the file extent items and calculate
the amount and average and total size (on disk):

---- >8 ----
#!/usr/bin/python3

import btrfs
import os
import sys

with btrfs.FileSystem(sys.argv[1]) as fs:
    inum = os.fstat(fs.fd).st_ino
    min_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, 0)
    max_key = btrfs.ctree.Key(inum, btrfs.ctree.EXTENT_DATA_KEY, -1)
    amount = 0
    total_size = 0
    for header, data in btrfs.ioctl.search_v2(fs.fd, 0, min_key, max_key):
        item = btrfs.ctree.FileExtentItem(header, data)
        if item.type != btrfs.ctree.FILE_EXTENT_REG:
            continue
        amount += 1
        total_size += item.disk_num_bytes
    print("Referencing data from {} regular extents with total size {} "
          "average size {}".format(
              amount, btrfs.utils.pretty_size(total_size),
              btrfs.utils.pretty_size(int(total_size/amount))))
---- >8 ----

If I e.g. point this at /bin/bash (compressed), I get:

Referencing data from 9 regular extents with total size 600.00KiB
average size 66.67KiB

The above code assumes that the real data extents are only referenced
once (no dedupe within the same file etc), otherwise you'll have to
filter them (and keep more stuff in memory). And, it ignores inlined
small extents for simplicity. Anyway, you can hack away on it to e.g.
make it look up more interesting things.

https://python-btrfs.readthedocs.io/en/latest/btrfs.html#btrfs.ctree.FileExtentItem

> See the attached graph for a quick experiment that demonstrates this 
> behavior.  In this experiment I use 40 threads to perform deletions of 
> previous written data in parallel.  10,000 files in every case and I 
> scale files by powers of two from 16MB to 16GB.  Thus, the raw amount of 
> data deleted also expands by 2x every step.  Frankly I expected deletion 
> of a file to be predominantly a metadata operation and not scale with 
> the size of the file, but perhaps I'm misunderstanding that.  While the 
> overall speed of deletion is relatively fast (hovering between 30GB/s 
> and 50GB/s) compared with raw ingest of data to the disk array we're 
> using (in our case ~1.5GB/s) it can still take a very long time to 
> delete data from the drives and removes hang completely until that data 
> is deleted, unlike in some other filesystems.  They also compete 
> aggressively with foreground I/O due to the intense seeking on the HDDs.

What is interesting in this case is to see what kind of IO pattern the
deletes are causing (so, obviously, test without adding data). Like, how
much throughput for read and write, and how many iops read and write per
second (so that we can easily calculate average iop size).

If most time is spent doing random read IO, then hope for a bright
future in which you can store btrfs metadata on solid state and the data
itself on cheaper spinning rust.

If most time is spent doing writes, then what you're seeing is probably
what I call rumination, which is caused by making changes in metadata,
which leads to writing modified parts of metadata in free space again.

The extent tree (which has info about the actual data extents on disk
that the file_extent_item ones seen above point to) is once of those,
and there's only one of that kind, which is even tracking its own space
allocation, which can lead to the effect of a cat or dog chasing it's
own tail. There have definitely been performance improvements in that
area, I don't know exactly where, but when I moved from 4.9 to 4.19
kernel, things improved a bit.

There is a very long story at
https://www.spinics.net/lists/linux-btrfs/msg70624.html about these
kinds of things.

There are unfortunately no easy accessible tools present yet that can
give live insight in what exactly is happening when it's writing
metadata like crazy.

> This is with an older version of BTRFS (4.12.14-lp150.12.73-default) so 
> if algorithms have changed substantially such that deletion rate is no 
> longer tied to file size in newer versions please just say so and I'll 
> be glad to take a look at that change and try with a newer version.

That seems to be a suse kernel. I have no idea what kind of btrfs is in
there.

> FWIW, we are using the v2 free space cache.

Just to be sure, there are edge cases in which the filesystem says it's
using space cache v2, but actually isn't.

Does /sys/fs/btrfs/<UUID>/features/free_space_tree exist?

Or, of course a fun little program to just do a bogus search in it,
which explodes if it's not there:

---- >8 ----
#!/usr/bin/python3

import btrfs

with btrfs.FileSystem('/') as fs:
    try:
        list(fs.free_space_extents(0, 0))
        print("Yay!")
    except FileNotFoundError:
        print("No FST :(")
---- >8 ----

Space cache v1 will cause filesystem stalls combined with a burst of
writes on every 'transaction commit', and space cache v2 will cause more
random reads and writes, but they don't block the whole thing.

> If any other information is 
> relevant to this just let me know and I'll be glad to share.

Suggestions for things to try, and see what difference it makes:

* Organize incoming data in btrfs subvolumes in a way that enables you
to remove the subvol instead of rm'ing the files. If there are a lot of
files and stuff, this can be more efficient, since btrfs knows about
what parts to 'cut away' with a chainsaw when removing, instead of
telling it to do everything file by file in small steps. It also keeps
the size of the individual subvolume metadata trees down, reducing
rumination done by the cow. If you don't have them, your default fs tree
with all file info is relatively seen as large as the extent tree.

* Remove stuff in the same order as it got added. Remember, rm * removes
files in alphabetical order, not in the order in which metadata was
added to disk (the inode number sequence). It might cause less jumping
around in metadata. Using subvolumes instead is still better, because in
that case the whole issue does not exist.

* (not recommended) If your mount options do not show 'ssd' in them and
your kernel does not have this patch:
https://www.spinics.net/lists/linux-btrfs/msg64203.html then you can try
the mount -o ssd_spread,nossd (read the story in the link above).
Anyway, you're better off moving to something recent instead of trying
all these obsolete workarounds...

If you have a kernel >= 4.14 then you're better off mounting with -o ssd
for rotational disks because the metadata writes are put more together
in bigger parts of free space, leading to less rumination. There is
still a lot of research and improvements to be done in this area (again,
see long post referenced above).

If you have kernel < 4.14, then definitely do not mount with -o ssd, but
even mount ssds with -o nossd explicitly. (yes, that's also a long story)...

Fun! :) /o\

> Thank you for any time people can spare to help us understand this better!

Don't hesitate to ask more questions,
Have fun,
Hans
