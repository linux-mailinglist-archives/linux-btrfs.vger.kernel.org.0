Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7FA1AE02
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2019 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfELTqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 May 2019 15:46:42 -0400
Received: from gourmet.spamgourmet.com ([216.75.62.102]:40783 "EHLO
        gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbfELTqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 May 2019 15:46:42 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
        (envelope-from <btrfs.5.gumpish@a-bc.net>)
        id 1hPuQj-0006f4-2r
        for linux-btrfs@vger.kernel.org; Sun, 12 May 2019 19:46:41 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
        by gourmet7.spamgourmet.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <btrfs.5.gumpish@a-bc.net>)
        id 1hPuQi-0006eq-O1
        for linux-btrfs@vger.kernel.org; Sun, 12 May 2019 19:46:40 +0000
Received: by mail-pf1-f174.google.com with SMTP id g9so5964842pfo.11
        for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2019 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=8dUZy0e+E2jdvMvDE2xgfZUyN+ceokfCTPy/f08ywPE=;
        b=QZ3M8+6F2nzbYurABJa9N/A4E8NvOfxDOktpqAKeNqODnk9Fd2Jwgv+2P1QrgmanPn
         7Nhyojs9GW9uGTpanCS1CC+pvAzjQFKXocjZlWJrkE5y1pRCwnLeOhOBJhRPJxNfkWeV
         qNU/sDd/6sun9CYbcAnBnIahaa+m/uvcYjylMGFeUiN4fLrw2azgy2q6IWiXeLRaTEpO
         6qTb3RQtoSxkhcmgRCTfOfSyTvSFyy/qkj2Mg5q2LTc/ighXho9ajXgVsriLnFu1tCl4
         0BC/GUt6UKOlKwSzA2hM781WrCD9ttjTsuIyJYOM5SQZsnEoLxDU3bBCkDzhUgXHRBm+
         4xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8dUZy0e+E2jdvMvDE2xgfZUyN+ceokfCTPy/f08ywPE=;
        b=Bii8QE28qc7RXxDnNLZ5u3S/AOIv8SU05D4ivupoQPU63I6Tt+WAXNDipdysGmb7ZR
         aK1A9yzvyv/Vub92f2TkC4FNAlb67+/+Plw0XJc8Pj6QePXvIWouKeeK6wsCsvhTjWyW
         e8Rv40TkkqKjebXi5a5yK7xH+mPWOA+GbHP6nlp6nSNFey+i1asuxTO/UA4+brd3K6RK
         j6blANorY5zT7bOfguWEdP3vGHnU4Oft1/9LTWB37B5xpOhCsTptJfNEj7BBCq9g2Iyj
         ob3PwB1fhocs8WqNZrVa5LUXUHUbaDNQzGU4DfsCDNYxCO49pLsTTA0pGM8tgrsAWA8/
         7w2w==
X-Gm-Message-State: APjAAAVCCdqKgUBAfuIo2s/0269eipHCE11CbGRtzXOcNZwg4s6dGTKm
        kpDahrin9llXr2sb2k5SZYCyxQIUlPXUSMMr7BqXGWqzg+c=
X-Google-Smtp-Source: APXvYqz0DGbwGcP8jmbIda+v6xiebZpATPd/Y5SU1cLo+qMW878LAISJDWlCS+rUgzumfcd8tQFUTZ7EgrEsuKUoR68=
X-Received: by 2002:a65:57ce:: with SMTP id q14mr13181199pgr.109.1557690399611;
 Sun, 12 May 2019 12:46:39 -0700 (PDT)
MIME-Version: 1.0
From:   btrfs.5.gumpish@a-bc.net
Date:   Sun, 12 May 2019 14:46:13 -0500
Message-ID: <CAOCS=fOv7dsg2-BfhOrMdapWcWhd_YkHb7mWxUE5DeZsBmptog@mail.gmail.com>
Subject: Bad tree block start, can't mount but data seems intact
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello. I have a btrfs partition which I'd been using for several
months with no problems until last week when it suddenly stopped
mounting.

It would be a pleasant surprise if there was a relatively painless way
to restore the drive to normal functionality, or at least recover any
files which might be intact, so I'm hoping someone here might take an
interest.

It may be worth noting that the partition is an SSD encrypted with
luks, though I experience no errors when mapping the partition, and I
have been able to dump the decrypted content of the partition and the
text of just about every plaintext file I can think of seems to be
perfectly intact.

Here's the required information for support requests, per the wiki
page about the mailing list, although these commands are being run in
a fresh installation of the same OS I had been using on the broken
partition (Xubuntu 18.04):

$ uname -a
Linux foo 4.18.0-18-generic #19~18.04.1-Ubuntu SMP Fri Apr 5 10:22:13
UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v4.15.1

$ sudo btrfs fi show
Label: none  uuid: cc6d8bac-f4f2-417c-bc59-ef4841617697
Total devices 1 FS bytes used 21.93GiB
devid    1 size 137.84GiB used 24.02GiB path /dev/mapper/sdc2_crypt

Label: none  uuid: 1d09eb6e-841e-465d-8c1d-75076b1c4b9a
Total devices 1 FS bytes used 83.26GiB
devid    1 size 110.57GiB used 107.57GiB path /dev/mapper/borked

Partition doesn't mount, can't run btrfs fi df /path/to/mount/point

Here's the output from dmesg when attempting to mount:

[ 4985.360439] BTRFS: device fsid 1d09eb6e-841e-465d-8c1d-75076b1c4b9a
devid 1 transid 344552 /dev/dm-1
[ 4990.973466] BTRFS info (device dm-1): disk space caching is enabled
[ 4990.973467] BTRFS info (device dm-1): has skinny extents
[ 4990.979229] BTRFS error (device dm-1): bad tree block start
17642829462275766793 120516247552
[ 4990.979237] BTRFS warning (device dm-1): failed to read tree root
[ 4991.008004] BTRFS error (device dm-1): open_ctree failed


/dev/mapper/borked (aka /dev/dm-1) is the drive in question. I'm
curious about the discrepancy between "FS bytes used" and the bytes
used on the following line. I don't have extensive experience with CoW
filesystems or troubleshooting filesystems in general so it's all
quite mysterious...

Since the drive only has ~110GiB capacity, it's certianly
understandable that 17642829462275766793 isn't a valid byte address.

I've followed some guidance from the web but haven't had any luck.
Here's what I've tried so far:

I tried a 'rescue chunk-recover', which reported 111 recoverable
blocks (i.e. 100% of the drive, zero unrecoverable chunks) and "Chunk
tree recovered successfully". Unfortunately the "bad tree block start"
error during mount did not change at all and the partition still would
not mount. I ran the chunk-recover process a second time and it
produced output identical to the first run so it seems to not be doing
anything. Maybe there's an undocumented flag you have to provide in
order for the tool to actually write changes to disk?

I tried doing a 'rescue super-recover' just to see what happened and
it reported 2 superblocks which were already in good condition and it
didn't take any action.

After dumping the contents of the drive with dd, I tried 'check
--repair', but it immediately terminated with the following output:

enabling repair mode
Opening filesystem to check...
checksum verify failed on 120516247552 found 4D050B32 wanted 0EB4D74B
checksum verify failed on 120516247552 found 4D050B32 wanted 0EB4D74B
bad tree block 120516247552, bytenr mismatch, want=120516247552,
have=17642829462275766793
Couldn't read tree root
ERROR: cannot open file system

I tried using 'inspect-internal dump-tree -b ...' pointing it at
various locations aligned with the sector size and all of them
generate a checksum verification failure, similar to what's shown in
the output above. It seems weird that every single block would be
generating an invalid checksum when there's so much perfectly intact
data on the disk.

'restore -v ...' yields the following:

checksum verify failed on 120516247552 found 4D050B32 wanted 0EB4D74B
checksum verify failed on 120516247552 found 4D050B32 wanted 0EB4D74B
bytenr mismatch, want=120516247552, have=17642829462275766793
Couldn't read tree root
Could not open root, trying backup super
checksum verify failed on 120516247552 found 4D050B32 wanted 0EB4D74B
checksum verify failed on 120516247552 found 4D050B32 wanted 0EB4D74B
bytenr mismatch, want=120516247552, have=17642829462275766793
Couldn't read tree root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 118726066176
Could not open root, trying backup super

'mount -t btrfs -o ro,usebackuproot' produces the following:

[ 7808.542029] BTRFS info (device dm-1): trying to use backup root at mount time
[ 7808.542030] BTRFS info (device dm-1): disk space caching is enabled
[ 7808.542031] BTRFS info (device dm-1): has skinny extents
[ 7808.542797] BTRFS error (device dm-1): bad tree block start
17642829462275766793 120516247552
[ 7808.542801] BTRFS warning (device dm-1): failed to read tree root
[ 7808.542933] BTRFS error (device dm-1): bad tree block start
17642829462275766793 120516247552
[ 7808.542936] BTRFS warning (device dm-1): failed to read tree root
[ 7808.547606] BTRFS error (device dm-1): bad tree block start
16167207305002578331 120515936256
[ 7808.547610] BTRFS warning (device dm-1): failed to read tree root
[ 7808.547692] BTRFS error (device dm-1): bad tree block start
11402994761705913451 120516100096
[ 7808.547695] BTRFS warning (device dm-1): failed to read tree root
[ 7808.547777] BTRFS error (device dm-1): bad tree block start
1442009718635089341 120514871296
[ 7808.547781] BTRFS warning (device dm-1): failed to read tree root
[ 7808.556796] BTRFS error (device dm-1): open_ctree failed

Thanks for reading.

