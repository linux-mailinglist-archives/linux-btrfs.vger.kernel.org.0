Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E9A1B8F66
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDZLUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 07:20:24 -0400
Received: from mailfilter04-out30.webhostingserver.nl ([195.211.73.156]:47133
        "EHLO mailfilter04-out30.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbgDZLUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 07:20:24 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2020 07:20:21 EDT
X-Halon-ID: ac0a17f5-87ad-11ea-8ec5-001a4a4cb95f
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter04.webhostingserver.nl (Halon) with ESMTPSA
        id ac0a17f5-87ad-11ea-8ec5-001a4a4cb95f;
        Sun, 26 Apr 2020 13:04:17 +0200 (CEST)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.6])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <fntoth@gmail.com>)
        id 1jSf57-003CWr-8Q; Sun, 26 Apr 2020 13:04:17 +0200
Subject: Re: Help needed to recover from partition resize/move
To:     Yegor Yegorov <gochkin@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <74123781-3080-6742-5088-57b7bbc83158@gmail.com>
Date:   Sun, 26 Apr 2020 13:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Op 25-04-2020 om 12:24 schreef Yegor Yegorov:
> Hi, I have been stupid enough to try to move and extend my btrfs
> partition using a GUI software of my distro. The operation ended with
> an error. From the logs of the operation, I understood that the
> movement of the partition succeeded, but some finishing operation is
> failed. I don't have this log anymore, so I can't provide further
> information on that.

Which GUI software did you use?

I had already 2x (yeah, but to my defense there was a long time in 
between) a similar problem with partitionmanager (KDE Partition 
Manager). In that case I only did a move (overlapping), which took hours.

When it apparently succeeded and I tried to mount btrfs complains 
similar to your tail below..

In both cases the fix was the same: I restored partition start/end with 
fdisk - and that was all. No data was lost.

Then used gparted (Gnome Partition Manager) to do the same - that worked.

Crazy.

> Now I ended up with btrfs partition that can't be mounted. Here the
> output of the various system and btrfs tools:
> 
> $> mount -t btrfs /dev/nvme0n1p3 /mnt/
> mount: /mnt/: wrong fs type, bad option, bad superblock on
> /dev/nvme0n1p3, missing codepage or helper program, or other error.
> 
> $>dmesg | tail
> [11637.931751] BTRFS info (device nvme0n1p3): disk space caching is enabled
> [11637.931754] BTRFS info (device nvme0n1p3): has skinny extents
> [11637.936339] BTRFS error (device nvme0n1p3): bad tree block start,
> want 1048576 have 6267530653245814412
> [11637.936350] BTRFS error (device nvme0n1p3): failed to read chunk root
> [11637.950289] BTRFS error (device nvme0n1p3): open_ctree failed
> [11637.950893] audit: type=1106 audit(1587809374.388:663): pid=14229
> uid=0 auid=1000 ses=2 msg='op=PAM:session_close
> grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11637.951039] audit: type=1104 audit(1587809374.388:664): pid=14229
> uid=0 auid=1000 ses=2 msg='op=PAM:setcred
> grantors=pam_unix,pam_permit,pam_env acct="root" exe="/usr/bin/sudo"
> hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11674.981082] audit: type=1101 audit(1587809411.415:665): pid=14277
> uid=1000 auid=1000 ses=2 msg='op=PAM:accounting
> grantors=pam_unix,pam_permit,pam_time acct="go4a" exe="/usr/bin/sudo"
> hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11674.981423] audit: type=1110 audit(1587809411.415:666): pid=14277
> uid=0 auid=1000 ses=2 msg='op=PAM:setcred
> grantors=pam_unix,pam_permit,pam_env acct="root" exe="/usr/bin/sudo"
> hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11674.985959] audit: type=1105 audit(1587809411.422:667): pid=14277
> uid=0 auid=1000 ses=2 msg='op=PAM:session_open
> grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> 
> $> btrfs check /dev/nvme0n1p3
> Opening filesystem to check...
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: cannot open file system
> 
> $> btrfs restore /dev/nvme0n1p3 /mnt/
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 188743680000
> Could not open root, trying backup super
> 
> $> btrfs rescue chunk-recover /dev/nvme0n1p3
> Scanning: DONE in dev0
> Check chunks successfully with no orphans
> Chunk tree recovered successfully
> 
> $>btrfs rescue super-recover /dev/nvme0n1p3
> All supers are valid, no need to recover
> 
> $>btrfs rescue zero-log /dev/nvme0n1p3
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: could not open ctree
> 
> $>btrfs-find-root /dev/nvme0n1p3
> WARNING: cannot read chunk root, continue anyway
> Superblock thinks the generation is 49
> Superblock thinks the level is 1
> 
> $>btrfs check --repair /dev/nvme0n1p3
> Starting repair.
> Opening filesystem to check...
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: cannot open file system
> 
> 
> $> btrfs check --repair --init-csum-tree --init-extent-tree /dev/nvme0n1p3
> Starting repair.
> Opening filesystem to check...
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: cannot open file system
> 
> 
> 
> 
> $> uname -a
> Linux go4a-HP-Spectre 5.7.0-1-MANJARO #1 SMP PREEMPT Tue Apr 21
> 20:48:43 UTC 2020 x86_64 GNU/Linux
> 
> $> btrfs --version
> btrfs-progs v5.6
> 
> $>  btrfs fi show
> Label: none  uuid: 1e1d4296-9d34-4070-9d8b-18d5dfbad486
>          Total devices 1 FS bytes used 85.02GiB
>          devid    1 size 97.17GiB used 97.17GiB path /dev/nvme0n1p7
> 
> Label: 'data'  uuid: 90e9d74c-3606-4028-9e72-c10e76f44a7c
>          Total devices 1 FS bytes used 169.51GiB
>          devid    1 size 175.78GiB used 172.02GiB path /dev/nvme0n1p3
> 

