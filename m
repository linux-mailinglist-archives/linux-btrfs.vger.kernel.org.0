Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0E4B8255
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiBPHzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 02:55:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBPHzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 02:55:04 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1768E4B
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 23:54:51 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 5C7911F0D76; Wed, 16 Feb 2022 02:54:49 -0500 (EST)
Date:   Wed, 16 Feb 2022 02:54:49 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     BERGUE Kevin <kevin.bergue-externe@hemeria-group.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Root level mismatch after sudden shutdown
Message-ID: <YgytyaZBRK9VirCf@hungrycats.org>
References: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 09, 2022 at 10:53:32AM +0000, BERGUE Kevin wrote:
> Hello everyone.
> 
> 
> After a sudden shutdown my btrfs partition seems to be corrupted. After a few hours of reading documentation and trying various repair methods I found an error message I can't find anywhere so I'm sending it your way hoping you can at least explain what the issue is. The disk was running with linux 5.16.5 at the moment of the crash, my recovery environnement is a linux 5.15.16 machine with btrfs-progs v5.16.
> 
> 
> To retrace my steps a bit:
> 
> - I tried to mount my partition normally:
> # mount /dev/mapper/SSD-Root /mnt/broken/
> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/mapper/SSD-Root, missing codepage or helper program, or other error.
> 
> - I then looked at the relevant logs from dmesg:
> # dmesg
> [ 2118.381387] BTRFS info (device dm-1): flagging fs with big metadata feature
> [ 2118.381394] BTRFS info (device dm-1): disk space caching is enabled
> [ 2118.381395] BTRFS info (device dm-1): has skinny extents
> [ 2118.384626] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
> [ 2118.384900] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
> [ 2118.384905] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
> [ 2118.385304] BTRFS error (device dm-1): open_ctree failed
> 
> - After some reading about the "parent transid verify failed" errors I tried to mount the volume with the usebackuproot flag:
> # mount -t btrfs -o ro,rescue=usebackuproot /dev/mapper/SSD-Root /mnt/broken/
> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/mapper/SSD-Root, missing codepage or helper program, or other error.
> And the dmesg content:
> [ 2442.117867] BTRFS info (device dm-1): flagging fs with big metadata feature
> [ 2442.117871] BTRFS info (device dm-1): trying to use backup root at mount time
> [ 2442.117872] BTRFS info (device dm-1): disk space caching is enabled
> [ 2442.117873] BTRFS info (device dm-1): has skinny extents
> [ 2442.123056] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
> [ 2442.123344] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
> [ 2442.123348] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
> [ 2442.124743] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
> [ 2442.124939] BTRFS error (device dm-1): parent transid verify failed on 1869491683328 wanted 526959 found 526999
> [ 2442.124942] BTRFS warning (device dm-1): failed to read root (objectid=4): -5
> [ 2442.125196] BTRFS critical (device dm-1): corrupt leaf: block=1869863370752 slot=97 extent bytenr=920192651264 len=4096 invalid generation, have 527002 expect (0, 527001]
> [ 2442.125201] BTRFS error (device dm-1): block=1869863370752 read time tree block corruption detected
> [ 2442.125500] BTRFS critical (device dm-1): corrupt leaf: block=1869863370752 slot=97 extent bytenr=920192651264 len=4096 invalid generation, have 527002 expect (0, 527001]
> [ 2442.125502] BTRFS error (device dm-1): block=1869863370752 read time tree block corruption detected
> [ 2442.125508] BTRFS warning (device dm-1): couldn't read tree root
> [ 2442.125806] BTRFS critical (device dm-1): corrupt leaf: block=1869866401792 slot=117 extent bytenr=906206486528 len=4096 invalid generation, have 527003 expect (0, 527002]
> [ 2442.125808] BTRFS error (device dm-1): block=1869866401792 read time tree block corruption detected
> [ 2442.126174] BTRFS critical (device dm-1): corrupt leaf: block=1869866401792 slot=117 extent bytenr=906206486528 len=4096 invalid generation, have 527003 expect (0, 527002]
> [ 2442.126175] BTRFS error (device dm-1): block=1869866401792 read time tree block corruption detected
> [ 2442.126184] BTRFS warning (device dm-1): couldn't read tree root
> [ 2442.126599] BTRFS error (device dm-1): open_ctree failed
> 
> - I then tried a check:
> # btrfs check /dev/mapper/SSD-Root
> Opening filesystem to check...
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> Ignoring transid failure
> ERROR: root [4 0] level 0 does not match 1
> 
> Couldn't setup device tree
> ERROR: cannot open file system
> 
> 
> I think the "root [4 0] level 0 does not match 1" error is the real
> cuprit but I can't seem to find any info on this message anywhere. 

The real culprit is the "parent transid verify failed" event.  Everything
printed after the "Ignoring transid failure" message is nonsense and
should be ignored, which is probably why nobody writes about it.
So let's write about it...

btrfs check should not continue to process the page after a transid verify
failure--the probability of success is not exactly zero, but pretty close.
Any information btrfs check gets from the page will be wrong, and could
cause further corruption if it somehow got past all the other validation
checks.

Parent transid cannot be ignored with any useful effect.  btrfs almost
never writes metadata items in the same location on disk twice.  Each
version of the filesystem tree places its metadata in new locations,
overwriting metadata from older versions of the tree.  There's no preset
metadata locations--if you want to find any metadata item, you have to
search for it in a tree, or scan the entire disk to find it.

If a metadata page write is dropped, the effect is that future reads
of the tree will get a random metadata page from an older version of
the filesystem tree.  To prevent errors, btrfs labels every metadata
page with the transaction ID it was created in, and every pointer to
a page in btrfs metadata has a matching transaction ID number.  If the
transid doesn't match, btrfs knows that the wrong page has been read from
the disk.  To protect the integrity of the filesystem, btrfs treats this
event as if it was a read error, and tries to recover by reading the same
page from other mirror copies of metadata.  If this is successful, btrfs
will replace the metadata page that failed parent transid verification.

btrfs check ignores the transid failure.  Since the entire page is wrong,
most fields will fail verification after the transid check is ignored
(e.g. the root level check in this case).  The only fields that _won't_
fail verification are fields with a small number of distinct values,
like a stopped clock that is correct twice a day.  The messages following
"Ignoring transid failure" are garbage.

Unfortunately, if you have no intact mirror of the missing metadata page
(i.e. they were all corrupted by the same write reordering bug in the
storage stack), then btrfs can't access anything below the missing
metadata page in the tree, nor can btrfs safely update the tree.
That means the filesystem can't be mounted read-write (or will mount
read-write, but become read-only immediately upon detecting the parent
transit verify failure).  Data loss can be severe, from zero to 100%,
depending on which metadata pages are lost and how large the write
cache is.

In theory it is possible to repair a parent transid verify failure by
brute-force searching the disk for an older copy of the metadata items
in the missing page, reinsert the items into the filesystem tree, then
repair inconsistencies in the metadata.  AFAIK none of the existing btrfs
tools can perform this search.

If the drive firmware is the problem, then you might be able to use the
drive with 'hdparm -W0' or 'nvme set-feature -f 6 -v 0 -s' or 'smartctl
--set wcache,off' (you'll need to run it on every boot and resume from
suspend if applicable).  It's a brute-force solution, but it usually makes
a drive with broken firmware usable.  Another solution might be to swap
the SSD for a model with stronger countermeasures against power failure.

> I
> tried a bunch of other commands including:
> - btrfs rescue zero-log
> - btrfs rescue chunk-recover
> - btrfs check --repair
> - btrfs rescue super-recover
> - btrfs check --repair with the tree root found by btrfs-find-root
> - btrfs check --repair --init-csum-tree --init-extent-tree
> - btrfs restore
> 
> I'm aware I probably executed some commands that don't make a lot of sense in my context but all of them failed with either the "root [4 0] level 0 does not match 1" message or a more generic "could not open ctree" or equivalent.
