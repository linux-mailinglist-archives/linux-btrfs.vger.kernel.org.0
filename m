Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B41BC79D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 20:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgD1SOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 14:14:40 -0400
Received: from mail.nethype.de ([5.9.56.24]:45481 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgD1SOk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 14:14:40 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jTUkf-002bz3-2S; Tue, 28 Apr 2020 18:14:37 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jTUke-0004hs-OC; Tue, 28 Apr 2020 18:14:36 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jTUke-0001du-Nm; Tue, 28 Apr 2020 20:14:36 +0200
Date:   Tue, 28 Apr 2020 20:14:36 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200428181436.GA5402@schmorp.de>
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428061959.GB10769@hungrycats.org>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, thanks for your reply!

On Tue, Apr 28, 2020 at 02:19:59AM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> That is _not_ expected.  Directories in btrfs are stored entirely in
> metadata as btrfs items.  They do not have data blocks in data block
> groups.

Ah, ok, yes, I agree then. I wrongly assumed directory data would be
stored as file data. I am actually very happy to be wrong about this, as
it makes me even more confident when facing a missing disk in production,
which is bound to happen.

That is strange then - I was able to delete the directories (and obviously
the files inside) though, but I did that _after_ "regenerating" the
metadata by balancing.

The only other inconsistency is that

   btrfs ba start -musage=100 -mdevid=2

kept failing with ENOSPC after doing some work, and

   btrfa ba start -mconvert=dup

worked flawlessly and apparently fixed all errors (other than missing file
data). Maybe the difference is the -mdevid=2 - although the disk had more
than 100G of unallocated space, so that alone wouldn't epxlain the enospc.

Just FYI, here are example kernel messages for such a failed balance with
only -musage:

Apr 24 22:08:01 doom kernel: [ 4051.894190] BTRFS info (device dm-32): balance: start -musage=100,devid=2
Apr 24 22:08:02 doom kernel: [ 4052.194964] BTRFS info (device dm-32): relocating block group 35508773191680 flags metadata|raid1
Apr 24 22:08:02 doom kernel: [ 4052.296436] BTRFS info (device dm-32): relocating block group 35507699449856 flags metadata|raid1
Apr 24 22:08:02 doom kernel: [ 4052.410760] BTRFS info (device dm-32): relocating block group 35506625708032 flags metadata|raid1
Apr 24 22:08:02 doom kernel: [ 4052.552481] BTRFS info (device dm-32): relocating block group 35505551966208 flags metadata|raid1
Apr 24 22:08:03 doom kernel: [ 4052.940950] BTRFS info (device dm-32): relocating block group 35504478224384 flags metadata|raid1
Apr 24 22:08:03 doom kernel: [ 4053.047505] BTRFS info (device dm-32): relocating block group 35503404482560 flags metadata|raid1
Apr 24 22:08:03 doom kernel: [ 4053.128938] BTRFS info (device dm-32): relocating block group 35502330740736 flags metadata|raid1
Apr 24 22:08:03 doom kernel: [ 4053.218385] BTRFS info (device dm-32): relocating block group 35501256998912 flags metadata|raid1
Apr 24 22:08:03 doom kernel: [ 4053.326941] BTRFS info (device dm-32): relocating block group 35500183257088 flags metadata|raid1
Apr 24 22:08:03 doom kernel: [ 4053.432318] BTRFS info (device dm-32): relocating block group 35499109515264 flags metadata|raid1
Apr 24 22:08:22 doom kernel: [ 4072.112133] BTRFS info (device dm-32): found 50845 extents
Apr 24 22:08:27 doom kernel: [ 4077.002724] BTRFS info (device dm-32): 3 enospc errors during balance
Apr 24 22:08:27 doom kernel: [ 4077.002727] BTRFS info (device dm-32): balance: ended with status: -28

> > multiple times larger than the memory size, i.e. it was almost certainly
> > writing to directories long _after_ btrfs got an EIO for the respective
> > directory blocks. 
> 
> There would be a surviving mirror copy of the directory, because it's in
> raid1 metadata, so that should be a successful write in degraded mode.
> 
> Uncorrectable EIO on metadata triggers a hard shutdown of all writes to
> the filesystem.  Userspace will definitely be informed when that happens.
> It's something we'd want to avoid with raid1.

Does "Uncorrectable EIO" also mean writes, though? I know from experience
that I get EIO when btrfs hits a metadata error, and that nowadays it is
very successfull in correcting metadata errors (which is a relatively new
thing).

My main takeaway from this experiment was that a) I did get my filesystem
back without having to reformat, which is admirable, and b) I can write a
surprising amount of data to a missing disk without seeing anything more
than kernel messages. In my stupidity I can well imagine having a disk
falling out of the "array" and me not noticing it for days.

Arguably, that is how it is though - a write error does not cause btrfs to
dismiss the whole disk, and most write errors cannot be reported back to
userspace, so btrfs would somehow have to correlate write errors and decide
when enough is enough.

OTOH, write errors are very rare on normal disks, and raid controllers
usually immediately kick out a disk on write errors so maybe marking
the disk bad (until a remount or so) might be a good idea - with modenr
drives, write errors are almost alwyays a symptom of something very bad
happening that is usually not directly associated with a specific block -
for example, an SSD disk mightr be end-of-life and switch to read-onyl, or
a conventional disk might have run out of spare blocks.

i.e. maybe btrfs shouldn't treat write errors as less bad than read
errors - not sure.

> > This is substantiated by the fact that I was able to
> > list the directories before rebooting, but not afterwards, so some info
> > lived in blocks which were not writtem but were still cached.
> 
> It sounds like you hit some other kind of failure there (this and the
> "page private not zero" messages.  What kernel was this?

5.4.28 from mainline-ppa (https://kernel.ubuntu.com/~kernel-ppa/mainline/).

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
