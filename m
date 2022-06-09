Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D655441BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 05:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiFIDBe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 23:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIDBd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 23:01:33 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1043D6319
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 20:01:28 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nz8QK-0003yl-61 by authid <merlin>; Wed, 08 Jun 2022 20:01:28 -0700
Date:   Wed, 8 Jun 2022 20:01:28 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220609030128.GJ22722@merlins.org>
References: <20220608000700.GB22722@merlins.org>
 <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org>
 <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org>
 <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org>
 <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org>
 <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 08, 2022 at 06:46:53PM -0400, Josef Bacik wrote:
> Ok I've added some stuff to fix the device extents.  Go ahead and run
> with --repair and lets see how that goes.  After that finishes run
> again without --repair so we can see what's still broken, I imagine
> I'll have to clean some other stuff up.  Thanks,

Can't determine the filetype for inode 69105, assume it is a normal file
Can't get file type for inode 69105, using FILE as fallback
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 69105
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 69135
reset isize for dir 69136 root 164823
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 69136
Trying to rebuild inode:69252
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 69252
Trying to rebuild inode:74108
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 74108
Trying to rebuild inode:74132
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 74132
Trying to rebuild inode:74193
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 74193
Trying to rebuild inode:74838
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 74838
Trying to rebuild inode:76221
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 76221
Trying to rebuild inode:76328
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 76328
Trying to rebuild inode:76329
Moving file f to 'lost+found' dir since it has no valid backref
Fixed the nlink of inode 76329
found 43825717248 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 10846208
total fs tree bytes: 6848512
total extent tree bytes: 1146880
btree space waste bytes: 3705949
file data blocks allocated: 67228672000
 referenced 67225485312
gargamel:/var/local/src/btrfs-progs-josefbacik# mount -o ro,recovery /dev/mapper/dshelf1 /mnt/mnt
mount: /mnt/mnt: wrong fs type, bad option, bad superblock on /dev/mapper/dshelf1, missing codepage or helper program, or other error.
gargamel:/var/local/src/btrfs-progs-josefbacik# dmtail
[3890613.672704] BTRFS info (device dm-1): flagging fs with big metadata feature
[3890613.694891] BTRFS warning (device dm-1): 'recovery' is deprecated, use 'rescue=usebackuproot' instead
[3890613.759915] BTRFS info (device dm-1): trying to use backup root at mount time
[3890613.782884] BTRFS info (device dm-1): disk space caching is enabled
[3890613.802960] BTRFS info (device dm-1): has skinny extents
[3890613.826455] BTRFS error (device dm-1): super_num_devices 1 mismatch with num_devices 0 found here
[3890613.855092] BTRFS error (device dm-1): failed to read chunk tree: -22
[3890613.876716] BTRFS error (device dm-1): open_ctree failed

btrfs check ends with:
root 164624 inode 73099 errors 1400, nbytes wrong, some csum missing
root 164624 inode 73100 errors 1400, nbytes wrong, some csum missing
        unresolved ref dir 791 index 0 namelen 25 name f filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 3676 index 0 namelen 62 name f filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 3752 errors 200, dir isize wrong
        unresolved ref dir 73103 index 540 namelen 4 name f filetype mismatch
root 164629 inode 3965 errors 200, dir isize wrong
        unresolved ref dir 4179 index 0 namelen 10 name f filetype 1 errors 6, no dir index, no inode ref
root 164629 inode 4549 errors 200, dir isize wrong
        unresolved ref dir 4698 index 0 namelen 69 name f filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 5506 index 0 namelen 53 name f filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 5546 index 0 namelen 57 name f filetype 1 errors 6, no dir index, no inode ref 
root 164629 inode 39921 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 759824384, len: 2143326208
        unresolved ref dir 10205 index 356 namelen 34 name f filetype 0 errors 3, no dir item, no dir index
root 164629 inode 40537 errors 1400, nbytes wrong, some csum missing
root 164629 inode 72418 errors 1400, nbytes wrong, some csum missing
root 164629 inode 72429 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 1333788672, len: 3217154048
        unresolved ref dir 72438 index 4 namelen 49 name f filetype 0 errors 3, no dir item, no dir index
root 164629 inode 72433 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 892338176, len: 14957748224
        unresolved ref dir 34951 index 13 namelen 46 name f filetype 0 errors 3, no dir item, no dir index
root 164629 inode 72587 errors 200, dir isize wrong
root 164629 inode 72588 errors 1000, some csum missing
root 164629 inode 72592 errors 200, dir isize wrong
root 164629 inode 72593 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 42074112, len: 413642752
        unresolved ref dir 75036 index 19 namelen 45 name f filetype 0 errors 3, no dir item, no dir index
root 164629 inode 72639 errors 200, dir isize wrong
root 164629 inode 72640 errors 200, dir isize wrong
root 164629 inode 72672 errors 200, dir isize wrong
        unresolved ref dir 73103 index 1386 namelen 5 name f filetype mismatch
root 164629 inode 73001 errors 1400, nbytes wrong, some csum missing
root 164629 inode 73006 errors 1400, nbytes wrong, some csum missing
root 164629 inode 73009 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 13869056, len: 53100544
        unresolved ref dir 72672 index 134 namelen 26 name f filetype 1 errors 1, no dir item
root 164629 inode 73045 errors 1400, nbytes wrong, some csum missing
root 164629 inode 73066 errors 1400, nbytes wrong, some csum missing
root 164629 inode 73067 errors 1000, some csum missing
root 164629 inode 73082 errors 1400, nbytes wrong, some csum missing
root 164629 inode 73083 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 197263360, len: 399777792 
        unresolved ref dir 3747 index 30 namelen 70 name f filetype 0 errors 3, no dir item, no dir index
root 164629 inode 73086 errors 1400, nbytes wrong, some csum missing
root 164629 inode 73094 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes:
        start: 0, len: 524288 
        unresolved ref dir 74963 index 32 namelen 56 name f filetype 0 errors 3, no dir item, no dir index 
root 164629 inode 73097 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
Found file extent holes: 
        start: 0, len: 524288
        unresolved ref dir 74963 index 36 namelen 56 name f filetype 0 errors 3, no dir item, no dir index
root 164629 inode 73099 errors 1400, nbytes wrong, some csum missing
root 164629 inode 73100 errors 1400, nbytes wrong, some csum missing
        unresolved ref dir 791 index 0 namelen 25 name f filetype 1 errors 6, no dir index, no inode ref
        unresolved ref dir 3676 index 0 namelen 62 name f filetype 1 errors 6, no dir index, no inode ref
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
cache and super generation don't match, space cache will be invalidated
found 21916315648 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 8880128
total fs tree bytes: 6799360
total extent tree bytes: 606208
btree space waste bytes: 2518033
file data blocks allocated: 36729012224
 referenced 36727418880

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
