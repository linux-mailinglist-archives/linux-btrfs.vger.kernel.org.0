Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499515136CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348289AbiD1O0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348288AbiD1O0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 10:26:06 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31090B645B
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 07:22:51 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1nk52e-0003yt-H8; Thu, 28 Apr 2022 15:22:48 +0100
Date:   Thu, 28 Apr 2022 15:22:48 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     "alex.challis" <alex.challis@btinternet.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Recovery of BTRFS critical (device md126): corrupt  leaf, bad
 key order: block=10872141938688, root=1, slot=119
Message-ID: <20220428142248.GF15632@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        "alex.challis" <alex.challis@btinternet.com>,
        linux-btrfs@vger.kernel.org
References: <24c3cfee.732c.180707358a1.Webtop.117@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c3cfee.732c.180707358a1.Webtop.117@btinternet.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 02:54:09PM +0100, alex.challis wrote:
> Dear BTRFS Team
> 
> Have a NetGear ReadyNas that uses brtfs for the data volume
> (/dev/disk/by-label/33eaff11\:HDD1).
> 
> Was attempting to stop a running container (Docker CE) around the time the
> failure happened. Had just docker pulled a new version of container. Not
> 100% sure they were related but NAS dropped data volume into RO mode around
> the time of stopping the container. Subsequent attempts to docker rm the
> container failed with read-only file system errors. Upon re-boot the data
> volume would no longer mount.
> 
>  uname -a:
> Linux fatterboy 4.4.218.x86_64.1 #1 SMP Sun Nov 7 15:20:05 UTC 2021 x86_64
> GNU/Linux
> 
>   btrfs --version:
> btrfs-progs v4.16
> 
>   btrfs fi show:
> Label: '33eaff11:root'  uuid: e360cd8a-7496-4714-a0b7-dadb4829e6f5
>         Total devices 1 FS bytes used 993.29MiB
>         devid    1 size 4.00GiB used 2.45GiB path /dev/md0
> 
> Label: '33eaff11:HDD1'  uuid: 9dbd11f2-da2f-4f68-a4e9-552cbc90d1e0
>         Total devices 2 FS bytes used 4.25TiB
>         devid    1 size 5.44TiB used 4.41TiB path /dev/md126
>         devid    2 size 461.13GiB used 7.03GiB path /dev/md127
> 
>   btrfs fi df /HDD1 :
> Data, single: total=2.04GiB, used=979.09MiB
> System, DUP: total=8.00MiB, used=16.00KiB
> Metadata, DUP: total=204.56MiB, used=14.19MiB
> GlobalReserve, single: total=16.00MiB, used=0.00B
> 
>   dmesg > dmesg.log
> Attached
> 
> 
> Culprit seems to be:
>  dmesg | grep -i btrfs
> [    1.337264] Btrfs loaded, crc32c=crc32c-generic
> [   23.296969] BTRFS: device label 33eaff11:root devid 1 transid 2341967
> /dev/md0
> [   23.297437] BTRFS info (device md0): has skinny extents
> [   24.505292] BTRFS: device label 33eaff11:HDD1 devid 2 transid 1424350
> /dev/md127
> [   24.643613] BTRFS: device label 33eaff11:HDD1 devid 1 transid 1424350
> /dev/md126
> [   24.800256] BTRFS info (device md126): has skinny extents
> [   24.894582] BTRFS critical (device md126): corrupt leaf, bad key order:
> block=10872141938688, root=1, slot=119
> [   24.894596] BTRFS error (device md126): failed to read block groups: -5
> [   24.894811] BTRFS error (device md126): failed to read block groups: -17
> [   24.898074] BTRFS error (device md126): failed to read block groups: -17
> [   24.912298] BTRFS error (device md126): failed to read block groups: -17
> [   24.912851] BTRFS error (device md126): parent transid verify failed on
> 10872188272640 wanted 1424347 found 1424349
> [   24.912857] BTRFS warning (device md126): failed to read tree root
> [   24.933058] BTRFS error (device md126): open_ctree failed
> 
>  btrfs-debug-tree -b 10872141938688 /dev/disk/by-label/33eaff11\:HDD1
> <clip>
>         item 117 key (1127493074944 METADATA_ITEM 0) itemoff 27954 itemsize
> 33
>                 refs 1 gen 23101 flags TREE_BLOCK
>                 tree block skinny level 0
>                 tree block backref root 7
>         item 118 key (1127493107712 METADATA_ITEM 0) itemoff 27894 itemsize
> 60
>                 refs 4 gen 718838 flags TREE_BLOCK|FULL_BACKREF
>                 tree block skinny level 0
>                 shared block backref parent 4593432821760
>                 shared block backref parent 4593432788992
>                 shared block backref parent 4593432756224
>                 shared block backref parent 4593432723456
>         item 119 key (2211708928 UNKNOWN.0 0) itemoff 27834 itemsize 60
>         item 120 key (1127493173248 METADATA_ITEM 0) itemoff 27801 itemsize
> 33
>                 refs 1 gen 29828 flags TREE_BLOCK
>                 tree block skinny level 0
>                 tree block backref root 7
> <clip>
> 
> Key 119 is out of sequence and type UNKNOWN (!?)

The first elements of the key tuples for 118-120 are:

0x10683d38000
0x00083d40000
0x10683d48000

   This, along with the UNKNOWN.0, suggests that something has written
a very small number of zero bytes into the metadata page while it was
in RAM (probably 4 or 8 bytes, as nothing else seems to be damaged).

   It's definitely happened in RAM, as the checksum is correct. We'd
have had a csum failure if the corruption happened on disk.

   This is an indication either of a broken driver that's done some
bad pointer arithmetic and stomped on memory that it doesn't own, or
(more likely, in my opinion) some bad RAM that's flipped a bit on an
address held in kernel memory somewhere, and led something to zero the
wrong area of RAM.

> Please advise on recovery please?

   I don't think there's anything in btrfs check that could fix this
(although I might be wrong). Your first task, though, should be to try
to identify and replace the broken RAM on this machine. Once that's
done, one of the devs may be able to help you with a custom patch to
btrfs check to fix it -- but don't do that until the hardware's
repaired.

   Hugo.


-- 
Hugo Mills             | I spent most of my money on drink, women and fast
hugo@... carfax.org.uk | cars. The rest I wasted.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                            James Hunt
