Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17E16AE00
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXRt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 12:49:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:57550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbgBXRt4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 12:49:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D7AEAD2A;
        Mon, 24 Feb 2020 17:49:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BC5ADA727; Mon, 24 Feb 2020 18:49:35 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:49:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Fix memory leak on failed cache-writes
Message-ID: <20200224174934.GB2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
 <20200218165026.GS2902@twin.jikos.cz>
 <SN4PR0401MB3598373E76D2D63694F8DB3C9B110@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598373E76D2D63694F8DB3C9B110@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 18, 2020 at 04:54:18PM +0000, Johannes Thumshirn wrote:
> On 18/02/2020 17:50, David Sterba wrote:
> > On Fri, Feb 14, 2020 at 12:57:58AM +0900, Johannes Thumshirn wrote:
> >> Fstests' test case generic/475 reliably leaks the btrfs_io_ctl::pages
> >> allocated in __btrfs_write_out_cache().
> >>
> >> The first patch in this series is freeing the pages when we throw away a dirty
> >> block group. The other patches are small things I noticed while hunting down the
> >> problem and are independant of fix.
> >>
> >> Changes to v1:
> >> - Move fix to the first position (David)
> >>
> >> Johannes Thumshirn (5):
> >>    btrfs: free allocated pages on failed cache write-out
> >>    btrfs: use inode from io_ctl in io_ctl_prepare_pages
> >>    btrfs: make the uptodate argument of io_ctl_add_pages() boolean.
> >>    btrfs: use standard debug config option to enable free-space-cache
> >>      debug prints
> >>    btrfs: simplify error handling in __btrfs_write_out_cache()
> > 
> > I've seen some weird test failures and this patchset was in the tested
> > branch (either for-next or standalone). I need to retest misc-next again
> > to have a clean baseline so I can see the diff.
> > 
> 
> Interesting, can you forward me the failures?

So it was test btrfs/125 but I can't say for sure which patchset causes
it, there are several reports but unlikely to be caused by yours.

btrfs/125               [14:07:58][ 9038.483946] run fstests btrfs/125 at 2020-02-18 14:07:58
[ 9038.894197] BTRFS info (device vda): disk space caching is enabled
[ 9038.897644] BTRFS info (device vda): has skinny extents
[ 9039.553603] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (29881)
[ 9039.557424] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (29881)
[ 9039.561587] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf devid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (29881)
[ 9039.581158] BTRFS info (device vdb): turning on sync discard
[ 9039.584130] BTRFS info (device vdb): disk space caching is enabled
[ 9039.587021] BTRFS info (device vdb): has skinny extents
[ 9039.589100] BTRFS info (device vdb): flagging fs with big metadata feature
[ 9039.595079] BTRFS info (device vdb): checking UUID tree
[ 9039.706233] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf devid 2 transid 7 /dev/vdc scanned by mount (29923)
[ 9039.711721] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf devid 1 transid 7 /dev/vdb scanned by mount (29923)
[ 9039.715946] BTRFS info (device vdb): allowing degraded mounts
[ 9039.717785] BTRFS info (device vdb): disk space caching is enabled
[ 9039.719914] BTRFS info (device vdb): has skinny extents
[ 9039.723260] BTRFS warning (device vdb): devid 3 uuid a55e3334-e24b-4220-93a2-9aaec7286042 is missing
[ 9039.726785] BTRFS warning (device vdb): devid 3 uuid a55e3334-e24b-4220-93a2-9aaec7286042 is missing
[ 9040.189984] BTRFS: device fsid 4d1f43bd-2b49-4905-a219-25dc10f1b5fe devid 1 transid 249 /dev/vda scanned by btrfs (29951)
[ 9040.211252] BTRFS info (device vdb): turning on sync discard
[ 9040.223781] BTRFS info (device vdb): disk space caching is enabled
[ 9040.225777] BTRFS info (device vdb): has skinny extents
[ 9050.252423] BTRFS info (device vdb): balance: start -d -m -s
[ 9050.256160] BTRFS info (device vdb): relocating block group 217710592 flags data|raid5
[ 9050.389701] btrfs_print_data_csum_error: 6540 callbacks suppressed
[ 9050.389706] BTRFS warning (device vdb): csum failed root -9 ino 257 off 5357568 csum 0xb5d704296aa5f2d5 expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.398381] BTRFS warning (device vdb): csum failed root -9 ino 257 off 5361664 csum 0xf2f7aa2e723d427e expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.398899] BTRFS warning (device vdb): csum failed root -9 ino 257 off 3424256 csum 0x15e7d27c0f4b4f20 expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.403918] BTRFS warning (device vdb): csum failed root -9 ino 257 off 5365760 csum 0x25464d4ee302ec50 expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.408525] BTRFS warning (device vdb): csum failed root -9 ino 257 off 3428352 csum 0xcd1278f31a795b3d expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.412556] BTRFS warning (device vdb): csum failed root -9 ino 257 off 5369856 csum 0x045d00c41342cf48 expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.417133] BTRFS warning (device vdb): csum failed root -9 ino 257 off 3432448 csum 0xab3b271dc78f0131 expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.425859] BTRFS warning (device vdb): csum failed root -9 ino 257 off 3436544 csum 0xa1e70b1d4d61d53f expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.430432] repair_io_failure: 9 callbacks suppressed
[ 9050.430435] BTRFS info (device vdb): read error corrected: ino 257 off 3424256 (dev /dev/vdd sector 196512)
[ 9050.430464] BTRFS info (device vdb): read error corrected: ino 257 off 3428352 (dev /dev/vdd sector 196520)
[ 9050.430473] BTRFS info (device vdb): read error corrected: ino 257 off 5361664 (dev /dev/vdd sector 198376)
[ 9050.430681] BTRFS info (device vdb): read error corrected: ino 257 off 3432448 (dev /dev/vdd sector 196528)
[ 9050.430762] BTRFS info (device vdb): read error corrected: ino 257 off 5357568 (dev /dev/vdd sector 198368)
[ 9050.430805] BTRFS info (device vdb): read error corrected: ino 257 off 5369856 (dev /dev/vdd sector 198392)
[ 9050.430853] BTRFS info (device vdb): read error corrected: ino 257 off 3436544 (dev /dev/vdd sector 196536)
[ 9050.432557] BTRFS info (device vdb): read error corrected: ino 257 off 5365760 (dev /dev/vdd sector 198384)
[ 9050.469621] BTRFS warning (device vdb): csum failed root -9 ino 257 off 13959168 csum 0x774317b489e76165 expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.476527] BTRFS info (device vdb): read error corrected: ino 257 off 13959168 (dev /dev/vdd sector 206720)
[ 9050.501930] BTRFS warning (device vdb): csum failed root -9 ino 257 off 16351232 csum 0xa735bf811aa10b77 expected csum 0xdbbbd8326f9b86ac mirror 1
[ 9050.512917] BTRFS info (device vdb): read error corrected: ino 257 off 17608704 (dev /dev/vdd sector 210392)
[ 9050.708681] BTRFS error (device vdb): bad tree block start, want 39059456 have 0
[ 9050.708684] BTRFS error (device vdb): bad tree block start, want 39075840 have 0
[ 9050.708699] BTRFS error (device vdb): bad tree block start, want 39092224 have 0
[ 9050.708700] BTRFS error (device vdb): bad tree block start, want 39108608 have 0
[ 9050.713287] BTRFS error (device vdb): bad tree block start, want 39059456 have 0
[ 9050.727830] BTRFS error (device vdb): bad tree block start, want 39059456 have 0
[ 9050.727849] BTRFS error (device vdb): bad tree block start, want 39075840 have 0
[ 9050.727854] BTRFS error (device vdb): bad tree block start, want 39092224 have 0
[ 9050.727876] BTRFS error (device vdb): bad tree block start, want 39108608 have 0
[ 9050.730601] BTRFS error (device vdb): bad tree block start, want 39059456 have 0
[ 9053.133149] BTRFS info (device vdb): balance: ended with status: -5
[failed, exit status 1][ 9053.200709] BTRFS info (device vdb): clearing incompat feature flag for RAID56 (0x80)
 [14:08:12]- output mismatch (see /tmp/fstests/results//btrfs/125.out.bad)
    --- tests/btrfs/125.out     2018-04-12 16:57:00.616225550 +0000
    +++ /tmp/fstests/results//btrfs/125.out.bad 2020-02-18 14:08:12.856000000 +0000
    @@ -3,5 +3,5 @@
     Write data with degraded mount
     
     Mount normal and balance
    -
    -Mount degraded but with other dev
    +failed: '/sbin/btrfs balance start /tmp/scratch'
    +(see /tmp/fstests/results//btrfs/125.full for details)
    ...
    (Run 'diff -u /tmp/fstests/tests/btrfs/125.out /tmp/fstests/results//btrfs/125.out.bad'  to see the entire diff)
---
