Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EAB1D1286
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgEMMVq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 08:21:46 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44844 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbgEMMVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 08:21:46 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 88DF76C0007; Wed, 13 May 2020 08:21:40 -0400 (EDT)
Date:   Wed, 13 May 2020 08:21:40 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Balance loops: what we know so far
Message-ID: <20200513122140.GA10769@hungrycats.org>
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
 <20200513052452.GY10769@hungrycats.org>
 <6fcccf0b-108d-75d2-ad53-3f7837478319@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fcccf0b-108d-75d2-ad53-3f7837478319@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 13, 2020 at 07:23:40PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/5/13 下午1:24, Zygo Blaxell wrote:
> > On Wed, May 13, 2020 at 10:28:37AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2020/5/12 下午10:11, Zygo Blaxell wrote:
> >>> On Tue, May 12, 2020 at 09:43:06AM -0400, Zygo Blaxell wrote:
> >>>> On Mon, May 11, 2020 at 04:31:32PM +0800, Qu Wenruo wrote:
> >>>>> Hi Zygo,
> >>>>>
> >>>>> Would you like to test this diff?
> >>>>>
> >>>>> Although I haven't find a solid reason yet, there is another report and
> >>>>> with the help from the reporter, it turns out that balance hangs at
> >>>>> relocating DATA_RELOC tree block.
> >>>>>
> >>>>> After some more digging, DATA_RELOC tree doesn't need REF_COW bit at all
> >>>>> since we can't create snapshot for data reloc tree.
> >>>>>
> >>>>> By removing the REF_COW bit, we could ensure that data reloc tree always
> >>>>> get cowed for relocation (just like extent tree), this would hugely
> >>>>> reduce the complexity for data reloc tree.
> >>>>>
> >>>>> Not sure if this would help, but it passes my local balance run.
> >>>>
> >>>> I ran it last night.  It did 30804 loops during a metadata block group
> >>>> balance, and is now looping on a data block group as I write this.
> >>
> >> OK, not that surprised the patch doesn't help.
> >> But still, the patch itself could still make sense for removing the
> >> REFCOW bit for data reloc tree.
> >>
> >> But I'm interesting in that, after that 30804 loops, it found its way to
> >> next block group?!
> >>
> >>>
> >>> Here's the block group that is failing, and some poking around with it:
> >>
> >> In fact, such poking would be the most valuable part.
> >>
> >>>
> >>> 	root@tester:~# ~/share/python-btrfs/examples/show_block_group_contents.py 4368594108416 /media/testfs/
> >>> 	block group vaddr 4368594108416 length 1073741824 flags DATA used 530509824 used_pct 49
> >>> 	extent vaddr 4368594108416 length 121053184 refs 1 gen 1318394 flags DATA
> >>> 	    inline shared data backref parent 4374646833152 count 1
> >>> 	extent vaddr 4368715161600 length 120168448 refs 1 gen 1318394 flags DATA
> >>> 	    inline shared data backref parent 4374801383424 count 1
> >>> 	extent vaddr 4368835330048 length 127623168 refs 1 gen 1318394 flags DATA
> >>> 	    inline shared data backref parent 4374801383424 count 1
> >>> 	extent vaddr 4368962953216 length 124964864 refs 1 gen 1318394 flags DATA
> >>> 	    inline shared data backref parent 4374801383424 count 1
> >>> 	extent vaddr 4369182420992 length 36700160 refs 1 gen 1321064 flags DATA
> >>> 	    inline extent data backref root 257 objectid 257 offset 822607872 count 1
> >>
> >> One interesting thing is, there are 5 extents during the loop.
> >> The first 4 looks like they belong to data reloc tree, which means they
> >> have been swapped, waiting to be cleaned up.
> >>
> >> The last one belongs to root 257, and looks like it hadn't been relocated.
> >>
> >>>
> >>> The extent data backref is unusual--during loops, I don't usually see those.
> >>> And...as I write this, it disappeared (it was part of the bees hash table, and
> >>> was overwritten).  Now there are 4 extents reported in the balance loop (note:
> >>> I added a loop counter to the log message):
> >>
> >> Then it means the last one get properly relocated.
> > 
> > No.  In these cases the extent is removed by other filesystem activity.
> > If balance gets stuck looping, it can never break out of a loop if it
> > is the only writer on the filesystem.  I've left it looping for days,
> > it makes no progress.
> > 
> > When balance is looping, it is always stuck waiting until the extents
> > are removed by something else.  In this particular case, the extent was
> > overwritten by another process removing the extent's last reference so
> > it was no longer part of the block group any more.  It is possible to
> > break a balance loop by simply deleting all the files with extents in
> > the block group.
> > 
> > I wrote some scripts that dump out the extents in the looping block
> > group, find the files they belong to, and run the defrag ioctl on them,
> > thereby removing all the extents in the block group so the balance loop
> > will end, without deleting the data.
> 
> This should definitely be fixed.
> 
> >  I used the script for a while and
> > was able to balance hundreds of block groups more than I would have been
> > able to without the script; however, the script couldn't run defrag on
> > extents that were not reachable through open() (e.g. extents referenced
> > by a deleted snapshot),
> 
> And data reloc tree.
> 
> > so it couldn't work around the balance loops in
> > all cases.
> 
> For the single data extent hanging you are able to reproduce, can you
> send me a binary dump of that fs when it's hanging?

Oops, I should have thought of that.  Oh well, it's still looping from
my 5th try last night...

Here's a looping image with a single file (this one has 13 extents).
I've stopped the VM in the middle of a balance loop and captured btrfs-image
from the host.  Then resumed the VM to make sure it's still looping.

Kernel log:

	[96199.614869][ T9676] BTRFS info (device dm-0): balance: start -d
	[96199.616086][ T9676] BTRFS info (device dm-0): relocating block group 4396679168000 flags data
	[96199.782217][ T9676] BTRFS info (device dm-0): relocating block group 4395605426176 flags data
	[96199.971118][ T9676] BTRFS info (device dm-0): relocating block group 4394531684352 flags data
	[96220.858317][ T9676] BTRFS info (device dm-0): found 13 extents, loops 1, stage: move data extents
	[...]
	[121403.509718][ T9676] BTRFS info (device dm-0): found 13 extents, loops 131823, stage: update data pointers
	(qemu) stop

btrfs-image URL:

	http://www.furryterror.org/~zblaxell/tmp/.fsinqz/image.bin

> Thanks,
> Qu
> 
> > 
> >> The cleanup for the first 4 doesn't happen properly.
> >>>
> >>> 	[Tue May 12 09:44:22 2020] BTRFS info (device dm-0): found 5 extents, loops 378, stage: update data pointers
> >>> 	[Tue May 12 09:44:23 2020] BTRFS info (device dm-0): found 5 extents, loops 379, stage: update data pointers
> >>> 	[Tue May 12 09:44:24 2020] BTRFS info (device dm-0): found 5 extents, loops 380, stage: update data pointers
> >>> 	[Tue May 12 09:44:26 2020] BTRFS info (device dm-0): found 5 extents, loops 381, stage: update data pointers
> >>> 	[Tue May 12 09:44:27 2020] BTRFS info (device dm-0): found 5 extents, loops 382, stage: update data pointers
> >>> 	[Tue May 12 10:04:49 2020] BTRFS info (device dm-0): found 5 extents, loops 383, stage: update data pointers
> >>> 	[Tue May 12 10:04:53 2020] BTRFS info (device dm-0): found 4 extents, loops 384, stage: update data pointers
> >>> 	[Tue May 12 10:04:58 2020] BTRFS info (device dm-0): found 4 extents, loops 385, stage: update data pointers
> >>> 	[Tue May 12 10:05:00 2020] BTRFS info (device dm-0): found 4 extents, loops 386, stage: update data pointers
> >>> 	[Tue May 12 10:05:00 2020] BTRFS info (device dm-0): found 4 extents, loops 387, stage: update data pointers
> >>> 	[Tue May 12 10:05:01 2020] BTRFS info (device dm-0): found 4 extents, loops 388, stage: update data pointers
> >>>
> >>> Some of the extents that remain are confusing python-btrfs a little:
> >>>
> >>> 	root@tester:~# ~/share/python-btrfs/examples/show_block_group_data_extent_filenames.py 4368594108416 /media/testfs/
> >>> 	block group vaddr 4368594108416 length 1073741824 flags DATA used 530509824 used_pct 49
> >>> 	extent vaddr 4368594108416 length 121053184 refs 1 gen 1318394 flags DATA
> >>> 	Traceback (most recent call last):
> >>> 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent_filenames.py", line 52, in <module>
> >>> 	    inodes, bytes_missed = logical_to_ino_fn(fs.fd, extent.vaddr)
> >>> 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent_filenames.py", line 28, in find_out_about_v1_or_v2
> >>> 	    inodes, bytes_missed = using_v2(fd, vaddr)
> >>> 	  File "/root/share/python-btrfs/examples/show_block_group_data_extent_filenames.py", line 17, in using_v2
> >>> 	    inodes, bytes_missed = btrfs.ioctl.logical_to_ino_v2(fd, vaddr, ignore_offset=True)
> >>> 	  File "/media/share/python-btrfs/examples/btrfs/ioctl.py", line 565, in logical_to_ino_v2
> >>> 	    return _logical_to_ino(fd, vaddr, bufsize, ignore_offset, _v2=True)
> >>> 	  File "/media/share/python-btrfs/examples/btrfs/ioctl.py", line 581, in _logical_to_ino
> >>> 	    fcntl.ioctl(fd, IOC_LOGICAL_INO_V2, args)
> >>
> >> I'm a little surprised about the it's using logical ino ioctl, not just
> >> TREE_SEARCH.
> >>
> >> I guess if we could get a plain tree search based one (it only search
> >> commit root, which is exactly balance based on), it would be easier to
> >> do the digging.
> >>
> >>> 	OSError: [Errno 22] Invalid argument
> >>>
> >>> 	root@tester:~# btrfs ins log 4368594108416 /media/testfs/
> >>> 	/media/testfs//snap-1589258042/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//current/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589249822/testhost/var/log/messages.6.lzma
> >>> 	ERROR: ino paths ioctl: No such file or directory
> >>> 	/media/testfs//snap-1589249547/testhost/var/log/messages.6.lzma
> >>> 	ERROR: ino paths ioctl: No such file or directory
> >>> 	/media/testfs//snap-1589248407/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589256422/testhost/var/log/messages.6.lzma
> >>> 	ERROR: ino paths ioctl: No such file or directory
> >>> 	/media/testfs//snap-1589251322/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589251682/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589253842/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589246727/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589258582/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589244027/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589245227/testhost/var/log/messages.6.lzma
> >>> 	ERROR: ino paths ioctl: No such file or directory
> >>> 	ERROR: ino paths ioctl: No such file or directory
> >>> 	/media/testfs//snap-1589246127/testhost/var/log/messages.6.lzma
> >>> 	/media/testfs//snap-1589247327/testhost/var/log/messages.6.lzma
> >>> 	ERROR: ino paths ioctl: No such file or directory
> >>>
> >>> Hmmm, I wonder if there's a problem with deleted snapshots?
> >>
> >> Yes, also what I'm guessing.
> >>
> >> The cleanup of data reloc tree doesn't look correct to me.
> >>
> >> Thanks for the new clues,
> >> Qu
> >>
> >>>  I have those
> >>> nearly continuously in my test environment, which is creating and deleting
> >>> snapshots all the time.
> >>>
> >>> 	root@tester:~# btrfs ins log 4368594108416 -P /media/testfs/
> >>> 	inode 20838190 offset 0 root 10347
> >>> 	inode 20838190 offset 0 root 8013
> >>> 	inode 20838190 offset 0 root 10332
> >>> 	inode 20838190 offset 0 root 10330
> >>> 	inode 20838190 offset 0 root 10331
> >>> 	inode 20838190 offset 0 root 10328
> >>> 	inode 20838190 offset 0 root 10329
> >>> 	inode 20838190 offset 0 root 10343
> >>> 	inode 20838190 offset 0 root 10333
> >>> 	inode 20838190 offset 0 root 10334
> >>> 	inode 20838190 offset 0 root 10336
> >>> 	inode 20838190 offset 0 root 10338
> >>> 	inode 20838190 offset 0 root 10325
> >>> 	inode 20838190 offset 0 root 10349
> >>> 	inode 20838190 offset 0 root 10320
> >>> 	inode 20838190 offset 0 root 10321
> >>> 	inode 20838190 offset 0 root 10322
> >>> 	inode 20838190 offset 0 root 10323
> >>> 	inode 20838190 offset 0 root 10324
> >>> 	inode 20838190 offset 0 root 10326
> >>> 	inode 20838190 offset 0 root 10327
> >>> 	root@tester:~# btrfs sub list -d /media/testfs/
> >>> 	ID 10201 gen 1321166 top level 0 path DELETED
> >>> 	ID 10210 gen 1321166 top level 0 path DELETED
> >>> 	ID 10230 gen 1321166 top level 0 path DELETED
> >>> 	ID 10254 gen 1321166 top level 0 path DELETED
> >>> 	ID 10257 gen 1321166 top level 0 path DELETED
> >>> 	ID 10274 gen 1321166 top level 0 path DELETED
> >>> 	ID 10281 gen 1321166 top level 0 path DELETED
> >>> 	ID 10287 gen 1321166 top level 0 path DELETED
> >>> 	ID 10296 gen 1321166 top level 0 path DELETED
> >>> 	ID 10298 gen 1321166 top level 0 path DELETED
> >>> 	ID 10299 gen 1321166 top level 0 path DELETED
> >>> 	ID 10308 gen 1321166 top level 0 path DELETED
> >>> 	ID 10311 gen 1321166 top level 0 path DELETED
> >>> 	ID 10313 gen 1321166 top level 0 path DELETED
> >>> 	ID 10315 gen 1321166 top level 0 path DELETED
> >>> 	ID 10317 gen 1321166 top level 0 path DELETED
> >>> 	ID 10322 gen 1321166 top level 0 path DELETED
> >>> 	ID 10323 gen 1321166 top level 0 path DELETED
> >>> 	ID 10327 gen 1321166 top level 0 path DELETED
> >>> 	ID 10328 gen 1321166 top level 0 path DELETED
> >>> 	ID 10330 gen 1321166 top level 0 path DELETED
> >>> 	ID 10333 gen 1321166 top level 0 path DELETED
> >>>
> >>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>
> >>>>> From 82f3b96a68561b2de9712262cb652192b8ea9b1b Mon Sep 17 00:00:00 2001
> >>>>> From: Qu Wenruo <wqu@suse.com>
> >>>>> Date: Mon, 11 May 2020 16:27:43 +0800
> >>>>> Subject: [PATCH] btrfs: Remove the REF_COW bit for data reloc tree
> >>>>>
> >>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>>> ---
> >>>>>  fs/btrfs/disk-io.c    | 9 ++++++++-
> >>>>>  fs/btrfs/inode.c      | 6 ++++--
> >>>>>  fs/btrfs/relocation.c | 3 ++-
> >>>>>  3 files changed, 14 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >>>>> index 56675d3cd23a..cb90966a8aab 100644
> >>>>> --- a/fs/btrfs/disk-io.c
> >>>>> +++ b/fs/btrfs/disk-io.c
> >>>>> @@ -1418,9 +1418,16 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
> >>>>>  	if (ret)
> >>>>>  		goto fail;
> >>>>>  
> >>>>> -	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
> >>>>> +	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
> >>>>> +	    root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID) {
> >>>>>  		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
> >>>>>  		btrfs_check_and_init_root_item(&root->root_item);
> >>>>> +	} else if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID) {
> >>>>> +		/*
> >>>>> +		 * Data reloc tree won't be snapshotted, thus it's COW only
> >>>>> +		 * tree, it's needed to set TRACK_DIRTY bit for it.
> >>>>> +		 */
> >>>>> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> >>>>>  	}
> >>>>>  
> >>>>>  	btrfs_init_free_ino_ctl(root);
> >>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >>>>> index 5d567082f95a..71841535c7ca 100644
> >>>>> --- a/fs/btrfs/inode.c
> >>>>> +++ b/fs/btrfs/inode.c
> >>>>> @@ -4129,7 +4129,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
> >>>>>  	 * extent just the way it is.
> >>>>>  	 */
> >>>>>  	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
> >>>>> -	    root == fs_info->tree_root)
> >>>>> +	    root == fs_info->tree_root ||
> >>>>> +	    root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
> >>>>>  		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
> >>>>>  					fs_info->sectorsize),
> >>>>>  					(u64)-1, 0);
> >>>>> @@ -4334,7 +4335,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
> >>>>>  
> >>>>>  		if (found_extent &&
> >>>>>  		    (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
> >>>>> -		     root == fs_info->tree_root)) {
> >>>>> +		     root == fs_info->tree_root ||
> >>>>> +		     root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)) {
> >>>>>  			struct btrfs_ref ref = { 0 };
> >>>>>  
> >>>>>  			bytes_deleted += extent_num_bytes;
> >>>>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> >>>>> index f25deca18a5d..a85dd5d465f6 100644
> >>>>> --- a/fs/btrfs/relocation.c
> >>>>> +++ b/fs/btrfs/relocation.c
> >>>>> @@ -1087,7 +1087,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
> >>>>>  		 * if we are modifying block in fs tree, wait for readpage
> >>>>>  		 * to complete and drop the extent cache
> >>>>>  		 */
> >>>>> -		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
> >>>>> +		if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID &&
> >>>>> +		    root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID) {
> >>>>>  			if (first) {
> >>>>>  				inode = find_next_inode(root, key.objectid);
> >>>>>  				first = 0;
> >>>>> -- 
> >>>>> 2.26.2
> >>>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>
> >>>
> >>
> > 
> > 
> > 
> 



