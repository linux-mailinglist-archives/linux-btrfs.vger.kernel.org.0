Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47049A75B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 03:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiAYChj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 21:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3414696AbiAYAsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 19:48:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4035C09B047
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jan 2022 14:33:05 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n32so8371918pfv.11
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jan 2022 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=THV19xrf/EUjgZMeFj3fJrfd24dWkKBMNv6JxAYwnqI=;
        b=pWrJVIad3q2w9jtF9DrMkwqfG5lZEBuTKYpXYgztjg4ac4ZWK/1il5y1+eaE/Czsi7
         hKdakLbOFP1rdJxzKs5y+t+9KDVQ7wQYdcTkW7qfPt7XcRf40hJ2O0xCVQ9mE8Hcg7l1
         q7pbhgdwlVAH7f1fwwHQsiW10hM9nqZiJAt3yoTbXJrVRV9wvbMkbI31E5Acl5id1E0n
         NiWfD2Bh/obFnzg4bYQg6UWksKb4lcA16QAH708qohCW94L4jnt1mfgW6ARTmD7VbodP
         WFy1iclF+MMYhILo4kwcGj3iuJOe7db6W+DsMsPFKFY4vwmcRv0tm6NCjdQEw4p6fJo3
         sEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=THV19xrf/EUjgZMeFj3fJrfd24dWkKBMNv6JxAYwnqI=;
        b=nBLPzn0egF+C35IC0yDeG75phWLPbx1gUm1eevMvoQMlW0SUikc8iMFxdIVuCEcxua
         gs1P9hVZCt0MAEdawiqyXWd+U29uJ0kx18eL9+Tp2AaUSKOsjEDXIgiO3JEc1hctlBup
         fqjh3VkbGyols6KDBSFZb/dQquDp8Kvc9kKdcWxaR9Dpommy60fN62RqWfaPIv4u0ml6
         MpJ/tkYPYkicUQNEt6Ma6aTDLwWBJ2lkbyeRwXGMC9h+6pBttl24220/Z4X+g1ZltmdZ
         graYdX8drDU/2UVht8+qCXFeTDpgy9bny4oaAtEfrEyG5gW7SCBdQXvZ4coRemQlgvr5
         gNag==
X-Gm-Message-State: AOAM5330EMsDDS650LiQI138twGDRG7BPxBzngGBIeQHr1YOb4f6ayb4
        N+91p78rsN+lxuUxxP8Zgg/GhQ==
X-Google-Smtp-Source: ABdhPJyZp9IOyl87B2BLSx+NDC/wl+xgsnixY+Z5dMdJTS48ItlpLruhDWpo6DswIZ5R6dgG+rui2A==
X-Received: by 2002:aa7:904d:0:b0:4bc:a970:be1 with SMTP id n13-20020aa7904d000000b004bca9700be1mr15613731pfo.65.1643063585246;
        Mon, 24 Jan 2022 14:33:05 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::d09d])
        by smtp.gmail.com with ESMTPSA id e1sm12530739pgu.17.2022.01.24.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:33:04 -0800 (PST)
Date:   Mon, 24 Jan 2022 14:33:04 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 09/17] btrfs: add BTRFS_IOC_ENCODED_READ
Message-ID: <Ye8ovb+nABMXgksN@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <111c7aadb3fa218b7926a49acf3fb34654d89a75.1637179348.git.osandov@fb.com>
 <20220124215435.GK14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124215435.GK14046@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 24, 2022 at 10:54:35PM +0100, David Sterba wrote:
> On Wed, Nov 17, 2021 at 12:19:19PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> 
> > - We don't do read repair, because it turns out that read repair is
> >   currently broken for compressed data.
> 
> Is there a reproducer, and a fix?

Reproducer:

# Create a filesystem with data duplicated at 2 physical locations on the same
# disk.
$ mkfs.btrfs -f -d dup /dev/vdb
# Mount it with compression enabled.
$ mount -o compress /dev/vdb /mnt
# Write some compressible data (octal dump of random data).
$ dd if=/dev/urandom bs=4k count=1 | od > /mnt/foo
# Force it on disk.
$ sync
# Get the locations it was written to on disk.
$ ~/repos/osandov-linux/scripts/btrfs_map_physical /mnt/foo | column -ts $'\t'
FILE OFFSET  FILE SIZE  EXTENT OFFSET  EXTENT TYPE                   LOGICAL SIZE  LOGICAL OFFSET  PHYSICAL SIZE  DEVID  PHYSICAL OFFSET
0            20480      0              regular,compression=zlib,dup  20480         298844160       8192           1      575668224
                                                                                                                  1      1005125632
# Corrupt one of the copies.
$ dd if=/dev/zero of=/dev/vdb bs=4k count=1 seek=575668224 oflag=seek_bytes
$ sync
# Now, re-read the file until we read it from the corrupted copy. To make sure
# we read from disk, we drop the page cache between each read.
$ while ! btrfs device stats /dev/vdb | grep -q 'corruption_errs\s\+[1-9]'; do echo 1 > /proc/sys/vm/drop_caches; cat /mnt/foo > /dev/null; done
$ dmesg | tail
[ 3240.222922] BTRFS info (device vdb): has skinny extents
[ 3240.235245] BTRFS info (device vdb): checking UUID tree
[ 3298.885372] bash (481): drop_caches: 1
[ 3298.924648] BTRFS warning (device vdb): csum failed root 5 ino 257 off 575676416 csum 0x8941f998 expected csum 0x05a3d0cd mirror 1
[ 3298.924657] BTRFS error (device vdb): bdev /dev/vdb errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
[ 3298.926221] BTRFS info (device vdb): read error corrected: ino 257 off 0 (dev /dev/vdb sector 1124352)
[ 3298.926473] BTRFS info (device vdb): read error corrected: ino 257 off 4096 (dev /dev/vdb sector 1124352)
[ 3298.926516] BTRFS info (device vdb): read error corrected: ino 257 off 16384 (dev /dev/vdb sector 1124352)
[ 3298.926555] BTRFS info (device vdb): read error corrected: ino 257 off 8192 (dev /dev/vdb sector 1124352)
[ 3298.926614] BTRFS info (device vdb): read error corrected: ino 257 off 12288 (dev /dev/vdb sector 1124352)
# Now check that the copies match.
$ dd if=/dev/vdb bs=4k count=1 skip=575668224 iflag=skip_bytes status=none | sha256sum
6ffd32b49d77b9e4ae07fd1c598b8407bc4cbb2fdb7244420589703f35605996  -
$ dd if=/dev/vdb bs=4k count=1 skip=1005125632 iflag=skip_bytes status=none | sha256sum
3646164006a08d908f5cbd6131ce413c8de49566560bf7ac6bc9432ac792605d  -
# Oops, they don't. Check the corrupted copy.
$ dd if=/dev/vdb bs=4k count=1 skip=575668224 iflag=skip_bytes status=none | head
0006000 006760 154362 010427 177511 151544 074422 116513 105472
0006020 045224 041623 063647 150022 006147 155332 053640 077304
0006040 173561 102237 155233 021641 165413 114564 004351 006141
0006060 075766 007723 017005 142265 175347 110221 071117 004421
0006100 045713 040102 005447 127414 173546 075206 042537 176547
0006120 120721 117062 177257 171012 130114 031767 165144 103776
0006140 054556 152447 123212 023000 062570 103502 057476 065541
0006160 064364 151221 117125 133463 076760 133756 133026 171622
0006200 164705 031677 005544 027201 130024 177437 102433 005170
0006220 144353 136645 147416 035017 173440 121605 050052 050325
# It contains decompressed data, and not even for the correct offset: this is
# the 4th block of the file.

I don't have a fix. Rohit Singh from my team is ramping up and working
on a fix.

This bug has been present as far back as I could follow the history. I
think it's just been masked by the fact that 1) repairing the bad copies
with bad data doesn't make things "worse" and 2) the page cache caches
the good data, so once you've repaired it once, you don't see it again
until you reboot or the page is evicted.
