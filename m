Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004781D0629
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 07:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgEMFCG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 13 May 2020 01:02:06 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46552 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMFCG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 01:02:06 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2E8B76BF208; Wed, 13 May 2020 01:02:05 -0400 (EDT)
Date:   Wed, 13 May 2020 01:02:05 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Balance loops: what we know so far
Message-ID: <20200513050204.GX10769@hungrycats.org>
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 13, 2020 at 10:28:37AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/5/12 下午10:11, Zygo Blaxell wrote:
> > On Tue, May 12, 2020 at 09:43:06AM -0400, Zygo Blaxell wrote:
> >> On Mon, May 11, 2020 at 04:31:32PM +0800, Qu Wenruo wrote:
> >>> Hi Zygo,
> >>>
> >>> Would you like to test this diff?
> >>>
> >>> Although I haven't find a solid reason yet, there is another report and
> >>> with the help from the reporter, it turns out that balance hangs at
> >>> relocating DATA_RELOC tree block.
> >>>
> >>> After some more digging, DATA_RELOC tree doesn't need REF_COW bit at all
> >>> since we can't create snapshot for data reloc tree.
> >>>
> >>> By removing the REF_COW bit, we could ensure that data reloc tree always
> >>> get cowed for relocation (just like extent tree), this would hugely
> >>> reduce the complexity for data reloc tree.
> >>>
> >>> Not sure if this would help, but it passes my local balance run.
> >>
> >> I ran it last night.  It did 30804 loops during a metadata block group
> >> balance, and is now looping on a data block group as I write this.
> 
> OK, not that surprised the patch doesn't help.
> But still, the patch itself could still make sense for removing the
> REFCOW bit for data reloc tree.
> 
> But I'm interesting in that, after that 30804 loops, it found its way to
> next block group?!

No, it got cancelled.  My test scripts start a balance every (hour +/-
random(1 hour) and cancels a balance on a similar schedule.

> > Here's the block group that is failing, and some poking around with it:
> 
> In fact, such poking would be the most valuable part.
> 
> > 
> > 	root@tester:~# ~/share/python-btrfs/examples/show_block_group_contents.py 4368594108416 /media/testfs/
> > 	block group vaddr 4368594108416 length 1073741824 flags DATA used 530509824 used_pct 49
> > 	extent vaddr 4368594108416 length 121053184 refs 1 gen 1318394 flags DATA
> > 	    inline shared data backref parent 4374646833152 count 1
> > 	extent vaddr 4368715161600 length 120168448 refs 1 gen 1318394 flags DATA
> > 	    inline shared data backref parent 4374801383424 count 1
> > 	extent vaddr 4368835330048 length 127623168 refs 1 gen 1318394 flags DATA
> > 	    inline shared data backref parent 4374801383424 count 1
> > 	extent vaddr 4368962953216 length 124964864 refs 1 gen 1318394 flags DATA
> > 	    inline shared data backref parent 4374801383424 count 1
> > 	extent vaddr 4369182420992 length 36700160 refs 1 gen 1321064 flags DATA
> > 	    inline extent data backref root 257 objectid 257 offset 822607872 count 1
> 
> One interesting thing is, there are 5 extents during the loop.
> The first 4 looks like they belong to data reloc tree, which means they
> have been swapped, waiting to be cleaned up.
> 
> The last one belongs to root 257, and looks like it hadn't been relocated.
> 
> > 
> > The extent data backref is unusual--during loops, I don't usually see those.
> > And...as I write this, it disappeared (it was part of the bees hash table, and
> > was overwritten).  Now there are 4 extents reported in the balance loop (note:
> > I added a loop counter to the log message):
> 
> Then it means the last one get properly relocated.
> 
> The cleanup for the first 4 doesn't happen properly.
> > 
> > 	[Tue May 12 09:44:22 2020] BTRFS info (device dm-0): found 5 extents, loops 378, stage: update data pointers
> > 	[Tue May 12 09:44:23 2020] BTRFS info (device dm-0): found 5 extents, loops 379, stage: update data pointers
> > 	[Tue May 12 09:44:24 2020] BTRFS info (device dm-0): found 5 extents, loops 380, stage: update data pointers
> > 	[Tue May 12 09:44:26 2020] BTRFS info (device dm-0): found 5 extents, loops 381, stage: update data pointers
> > 	[Tue May 12 09:44:27 2020] BTRFS info (device dm-0): found 5 extents, loops 382, stage: update data pointers
> > 	[Tue May 12 10:04:49 2020] BTRFS info (device dm-0): found 5 extents, loops 383, stage: update data pointers
> > 	[Tue May 12 10:04:53 2020] BTRFS info (device dm-0): found 4 extents, loops 384, stage: update data pointers
> > 	[Tue May 12 10:04:58 2020] BTRFS info (device dm-0): found 4 extents, loops 385, stage: update data pointers
> > 	[Tue May 12 10:05:00 2020] BTRFS info (device dm-0): found 4 extents, loops 386, stage: update data pointers
> > 	[Tue May 12 10:05:00 2020] BTRFS info (device dm-0): found 4 extents, loops 387, stage: update data pointers
> > 	[Tue May 12 10:05:01 2020] BTRFS info (device dm-0): found 4 extents, loops 388, stage: update data pointers
> > 
> > Some of the extents that remain are confusing python-btrfs a little:
> > 
> > 	root@tester:~# ~/share/python-btrfs/examples/show_block_group_data_extent_filenames.py 4368594108416 /media/testfs/
> > 	block group vaddr 4368594108416 length 1073741824 flags DATA used 530509824 used_pct 49
> > 	extent vaddr 4368594108416 length 121053184 refs 1 gen 1318394 flags DATA
> > 	Traceback (most recent call last):
> > 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent_filenames.py", line 52, in <module>
> > 	    inodes, bytes_missed = logical_to_ino_fn(fs.fd, extent.vaddr)
> > 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent_filenames.py", line 28, in find_out_about_v1_or_v2
> > 	    inodes, bytes_missed = using_v2(fd, vaddr)
> > 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent_filenames.py", line 17, in using_v2
> > 	    inodes, bytes_missed = btrfs.ioctl.logical_to_ino_v2(fd, vaddr, ignore_offset=True)
> > 	  File "/media/share/python-btrfs/examples/btrfs/ioctl.py", line 565, in logical_to_ino_v2
> > 	    return _logical_to_ino(fd, vaddr, bufsize, ignore_offset, _v2=True)
> > 	  File "/media/share/python-btrfs/examples/btrfs/ioctl.py", line 581, in _logical_to_ino
> > 	    fcntl.ioctl(fd, IOC_LOGICAL_INO_V2, args)
> 
> I'm a little surprised about the it's using logical ino ioctl, not just
> TREE_SEARCH.

Tree search can't read shared backrefs because they refer directly to
disk blocks, not to object/type/offset tuples.  It would be nice to have
an ioctl that can read a metadata block (or even a data block) by bytenr.

Or even better, just a fd that can be obtained by some ioctl to access
the btrfs virtual address space with pread().

> I guess if we could get a plain tree search based one (it only search
> commit root, which is exactly balance based on), it would be easier to
> do the digging.

That would be nice.  I have an application for it.  ;)

> > 	OSError: [Errno 22] Invalid argument
> > 
> > 	root@tester:~# btrfs ins log 4368594108416 /media/testfs/
> > 	/media/testfs//snap-1589258042/testhost/var/log/messages.6.lzma
> > 	/media/testfs//current/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589249822/testhost/var/log/messages.6.lzma
> > 	ERROR: ino paths ioctl: No such file or directory
> > 	/media/testfs//snap-1589249547/testhost/var/log/messages.6.lzma
> > 	ERROR: ino paths ioctl: No such file or directory
> > 	/media/testfs//snap-1589248407/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589256422/testhost/var/log/messages.6.lzma
> > 	ERROR: ino paths ioctl: No such file or directory
> > 	/media/testfs//snap-1589251322/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589251682/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589253842/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589246727/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589258582/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589244027/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589245227/testhost/var/log/messages.6.lzma
> > 	ERROR: ino paths ioctl: No such file or directory
> > 	ERROR: ino paths ioctl: No such file or directory
> > 	/media/testfs//snap-1589246127/testhost/var/log/messages.6.lzma
> > 	/media/testfs//snap-1589247327/testhost/var/log/messages.6.lzma
> > 	ERROR: ino paths ioctl: No such file or directory
> > 
> > Hmmm, I wonder if there's a problem with deleted snapshots?
> 
> Yes, also what I'm guessing.
> 
> The cleanup of data reloc tree doesn't look correct to me.
> 
> Thanks for the new clues,
> Qu

Here's a fun one:

1.  Delete all the files on a filesystem where balance loops
have occurred.

2.  Verify there are no data blocks (one data block group
with used = 0):

# show_block_groups.py /testfs/
block group vaddr 435969589248 length 1073741824 flags METADATA|RAID1 used 180224 used_pct 0
block group vaddr 4382686969856 length 33554432 flags SYSTEM|RAID1 used 16384 used_pct 0
block group vaddr 4383794266112 length 1073741824 flags DATA used 0 used_pct 0

3.  Create a new file with a single reference in the only (root) subvol:
# head -c 1024m > file
# sync
# show_block_groups.py .
block group vaddr 435969589248 length 1073741824 flags METADATA|RAID1 used 1245184 used_pct 0
block group vaddr 4382686969856 length 33554432 flags SYSTEM|RAID1 used 16384 used_pct 0
block group vaddr 4384868007936 length 1073741824 flags DATA used 961708032 used_pct 90
block group vaddr 4385941749760 length 1073741824 flags DATA used 112033792 used_pct 10

4.  Run balance, and it immediately loops on a single extent:
# btrfs balance start -d .
[Wed May 13 00:41:58 2020] BTRFS info (device dm-0): balance: start -d
[Wed May 13 00:41:58 2020] BTRFS info (device dm-0): relocating block group 4385941749760 flags data
[Wed May 13 00:42:00 2020] BTRFS info (device dm-0): found 1 extents, loops 1, stage: move data extents
[Wed May 13 00:42:00 2020] BTRFS info (device dm-0): found 1 extents, loops 2, stage: update data pointers
[Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, loops 3, stage: update data pointers
[Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, loops 4, stage: update data pointers
[Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, loops 5, stage: update data pointers
[Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, loops 6, stage: update data pointers
[Wed May 13 00:42:01 2020] BTRFS info (device dm-0): found 1 extents, loops 7, stage: update data pointers
[Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, loops 8, stage: update data pointers
[Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, loops 9, stage: update data pointers
[Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, loops 10, stage: update data pointers
[Wed May 13 00:42:02 2020] BTRFS info (device dm-0): found 1 extents, loops 11, stage: update data pointers
[etc...]

I tried it a 3 more times time and there was no loop.  The 5th try looped again.

There might be a correlation with cancels.  After a fresh boot, I can
often balance a few dozen block groups before there's a loop, but if I
cancel a balance, the next balance almost always loops.
