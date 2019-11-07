Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71600F30E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 15:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfKGOJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 09:09:48 -0500
Received: from aurora.thatsmathematics.com ([162.209.10.89]:53024 "EHLO
        aurora.thatsmathematics.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfKGOJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 09:09:48 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 09:09:47 EST
Received: from moneta.lan (68-118-231-109.dhcp.oxfr.ma.charter.com [68.118.231.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by aurora.thatsmathematics.com (Postfix) with ESMTPSA id 549027E200
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2019 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thatsmathematics.com;
        s=swordfish; t=1573135399;
        bh=jtfWvqqZly7M6QMWpIZTvG2sDwsPl4dEAdb0P7+q5hc=;
        h=Date:From:To:Subject:From;
        b=m/TWmmxDp14QEwmZWb7fMbL+1ybsPA0vQBsaI5N3hD6ijkFf2Dgh8WAH5K97CrBUy
         xnEtRynIHNH5xlJybyA/E39Dfc9DHrjGEROOZFWDKgB08O5If9fJ184JPDtmhbSsTg
         O+bUDu3gACWQ3cylTNzzpo+Psg8OZ0xnDy9mOqDE=
Date:   Thu, 7 Nov 2019 09:03:18 -0500 (EST)
From:   Nate Eldredge <nate@thatsmathematics.com>
X-X-Sender: nate@moneta
To:     linux-btrfs@vger.kernel.org
Subject: Defragmenting to recover wasted space
Message-ID: <alpine.DEB.2.21.1911070814430.3492@moneta>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had a confusing issue on a btrfs filesystem, where the amount of space 
used according to `df', `btrfs fi usage', etc, was about 50% higher than 
the total reported by `du' or `btrfs fi du', about 185 GB vs 125 GB, 
meaning that about 60 GB was somehow wasted.  I ruled out all the usual 
suspects (deleted files still open, files under mount points, etc) and 
eventually fixed the issue by doing `btrfs fi defrag` on a directory 
containing a few big files (Virtualbox disk images).

This is on Ubuntu 19.04, currently using kernel 5.0.0-32.

So everything is good now, but I have questions:

1. What causes this?  I saw some references to "unused extents" but it 
wasn't clear how that happens, or why they wouldn't be freed through 
normal operation.  Are there certain usage patterns that exacerbate it?

2. Is this documented?  I didn't see it mentioned anywhere in the 
documentation, and defragmenting was just a random thing to try, based on 
a few hints in various blogs and mailing lists.  Luckily it worked, but 
otherwise I'm not sure how I could have known that defragmenting was the 
solution.

3. Is this reasonable?  With all the other filesystems I've used, space 
that isn't occupied by your files is available for use, minus a reasonable 
amount of overhead for metadata etc, without needing any special 
administrative chores.  Should I take it that I can't expect this from 
btrfs, and I have to plan to defragment occasionally to keep the disk from 
filling up?

4. If this is not normal, and if I'm able to reproduce it, what 
information should I gather for a bug report?

5. Is there a better way to detect this kind of wastage, to distinguish it 
from more mundane causes (deleted files still open, etc) and see how much 
space could be recovered? In particular, is there a way to tell which 
files are most affected, so that I can just defragment those?

Thanks very much for any information or pointers.

Here is info about the filesystem, if it matters.  This is from after the 
defrag.  It has two subvolumes and no snapshots.

# uname -a
Linux moneta 5.0.0-32-generic #34-Ubuntu SMP Wed Oct 2 02:06:48 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
# btrfs --version
btrfs-progs v4.20.2 
# btrfs fi show /
Label: none  uuid: [xxx]
 	Total devices 1 FS bytes used 127.83GiB
 	devid    1 size 227.29GiB used 197.02GiB path /dev/mapper/nvme0n1p3_crypt

# btrfs fi df /
Data, single: total=194.01GiB, used=127.03GiB
System, single: total=4.00MiB, used=48.00KiB
Metadata, single: total=3.01GiB, used=817.80MiB
GlobalReserve, single: total=182.75MiB, used=0.00B

Prior to the defrag, the `used=` number in `btrfs fi df` was about 185 
GiB.

-- 
Nate Eldredge
nate@thatsmathematics.com

