Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747ED52AD73
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiEQVW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiEQVWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 17:22:25 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3253DA60
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 14:22:23 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nr4e7-0005lV-9w by authid <merlin>; Tue, 17 May 2022 14:22:23 -0700
Date:   Tue, 17 May 2022 14:22:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220517212223.GL8056@merlins.org>
References: <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
 <20220516005759.GE13006@merlins.org>
 <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org>
 <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org>
 <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
 <20220517202756.GK8056@merlins.org>
 <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 04:39:18PM -0400, Josef Bacik wrote:
> What I *think* happened is you essentially lost random blocks from 1
> transaction.  This isn't particularly harmful, except you had a chunk
> allocation that happened, so you lost some of the chunk root.  I
> didn't realize this is what was happening until now.  If I had I
> probably could have pieced together these dev extents into chunks, and
> then all those blocks that we had that didn't map to a chunk probably
> would have been fine, because they were in the range that we lost.
> 
> It's not that you lost a lot of blocks, you just lost a few really,
> really important blocks, and then I failed to recognize what happened
> so I threw out more than I should have, plus all the other little
> wonkiness from experimental recovery tools.  Thanks,

Right, which is totally understandable. I'm still glad I have backups
(waiting to restore), but I very much appreciate your work right now as
it's fixing the bigger problem of recovering an unmountable filesystem.

Ultimately I don't care as much about how much data is lost, but I very
much care about btrfs check repair getting the filesystem back to a
mountable state, so I've been more than happy helping you get to that
state and I'm very thankful for all the time you spent on this so far.
Hopefully we're almost there :)

For extra points, files that have corrupted checksums, I'd love for them
to be renamed to file.corrupted, so that someone who cares about partial
data, can get some data back, and that you can recover much faster with
rsync if it only has to look for missing files, as opposed to running a
checksum on all the data on both sides, which would take ages.
I know in this case, I may end up with some amount of files silently
corrupted since we rebuilt the checksum table, not sure if there is a
way to do this like I described or some similar way, in the future.

I see you pushed another change, trying it now.

I have the full output saved if need be.

Device extent[1, 14812306210816, 1073741824] didn't find the relative chunk.
Device extent[1, 9544528822272, 1073741824] didn't find the relative chunk.
Device extent[1, 11231377227776, 1073741824] didn't find the relative chunk.
Device extent[1, 11406397145088, 1073741824] didn't find the relative chunk.
Device extent[1, 11416060821504, 1073741824] didn't find the relative chunk.
Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
incorrect local backref count on 2952871936 parent 13576823652352 owner 0 offset 0 found 0 wanted 1 back 0x55db601ea230
backref disk bytenr does not match extent record, bytenr=2952871936, ref bytenr=0
data backref 2952871936 root 11223 owner 258 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 2952871936 root 11223 owner 258 offset 0 found 1 wanted 0 back 0x55db80f5c6a0
backpointer mismatch on [2952871936 262144]
repair deleting extent record: key [2952871936,168,262144]
adding new data backref on 2952871936 root 1 owner 258 offset 0 found 1
adding new data backref on 2952871936 root 11223 owner 258 offset 0 found 1
Repaired extent references for 2952871936
incorrect local backref count on 4156227584 parent 13576823652352 owner 0 offset 0 found 0 wanted 1 back 0x55db607ad1f0
backref disk bytenr does not match extent record, bytenr=4156227584, ref bytenr=0
data backref 4156227584 root 11223 owner 259 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 4156227584 root 11223 owner 259 offset 0 found 1 wanted 0 back 0x55db80f5c570
backpointer mismatch on [4156227584 262144]
repair deleting extent record: key [4156227584,168,262144]
adding new data backref on 4156227584 root 1 owner 259 offset 0 found 1
adding new data backref on 4156227584 root 11223 owner 259 offset 0 found 1
Repaired extent references for 4156227584
(...)
adding new data backref on 10449820549120 root 1 owner 256 offset 0 found 1
adding new data backref on 10449820549120 root 11223 owner 256 offset 0 found 1
Repaired extent references for 10449820549120
super bytes used 14180042240000 mismatches actual used 14180042256384
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Block group[4523166793728, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[4524240535552, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[4525314277376, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[4526388019200, 1073741824] (flags = 1) didn't find the relative chunk.
Block group[4527461761024, 1073741824] (flags = 1) didn't find the relative chunk.
(...)
super bytes used 14180042240000 mismatches actual used 14180042272768
(...)
root 159785 inode 74938 errors 1000, some csum missing
root 159785 inode 74945 errors 1000, some csum missing
root 159785 inode 74952 errors 1100, file extent discount, some csum missing
Found file extent holes:
        start: 2477785088, len: 934416384
root 159785 inode 74958 errors 1500, file extent discount, nbytes wrong, some csum missing
Found file extent holes:
        start: 49020928, len: 1426894848
root 159785 inode 74964 errors 1100, file extent discount, some csum missing
Found file extent holes:
        start: 714735616, len: 24973312
root 159785 inode 74966 errors 1500, file extent discount, nbytes wrong, some csum missing
Found file extent holes:
        start: 13893632, len: 838578176
root 159785 inode 74967 errors 1100, file extent discount, some csum missing
Found file extent holes:
        start: 86638592, len: 357191680
root 159785 inode 74977 errors 1000, some csum missing
root 159785 inode 74983 errors 1000, some csum missing
root 159785 inode 74984 errors 1000, some csum missing
(...)
root 159785 inode 75025 errors 1000, some csum missing
root 159785 inode 75034 errors 1500, file extent discount, nbytes wrong, some csum missing
Found file extent holes:
        start: 132841472, len: 112558080
(...)
root 165299 inode 95692 errors 1000, some csum missing
root 165299 inode 95697 errors 1000, some csum missing
root 165299 inode 95698 errors 1000, some csum missing
root 165299 inode 95699 errors 1000, some csum missing
root 165299 inode 95700 errors 1000, some csum missing
root 165299 inode 95701 errors 1000, some csum missing
root 165299 inode 95702 errors 1000, some csum missing
root 165299 inode 95703 errors 1000, some csum missing
root 165299 inode 95704 errors 1000, some csum missing
root 165299 inode 95705 errors 1000, some csum missing
ERROR: errors found in fs roots

Starting repair.
Opening filesystem to check...
JOSEF: root 9
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
reset devid 1 bytes_used to 14599692746752
No device size related problem found
cache and super generation don't match, space cache will be invalidated
found 85080253587456 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 12561334272
total fs tree bytes: 11398840320
total extent tree bytes: 1138114560
btree space waste bytes: 2020110583
file data blocks allocated: 93624650268672
 referenced 93708263153664


[1969680.027665] BTRFS info (device dm-1): flagging fs with big metadata feature
[1969680.049987] BTRFS warning (device dm-1): 'recovery' is deprecated, use 'rescue=usebackuproot' instead
[1969680.049991] BTRFS info (device dm-1): trying to use backup root at mount time
[1969680.049992] BTRFS info (device dm-1): disk space caching is enabled
[1969680.049993] BTRFS info (device dm-1): has skinny extents
[1969681.639536] BTRFS error (device dm-1): logical 4523166793728 len 1073741824 found bg but no related chunk
[1969681.670760] BTRFS error (device dm-1): failed to read block groups: -2
[1969681.703366] BTRFS error (device dm-1): open_ctree failed




Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
