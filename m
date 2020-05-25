Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5161E1542
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbgEYUjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 16:39:17 -0400
Received: from magic.merlins.org ([209.81.13.136]:35970 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389950AbgEYUjR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 16:39:17 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jdJsS-0006lI-H5 by authid <merlin>; Mon, 25 May 2020 13:39:16 -0700
Date:   Mon, 25 May 2020 13:39:16 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <Damenly_Su@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
Message-ID: <20200525203916.GB19850@merlins.org>
References: <20200524213059.GI23519@merlins.org>
 <CAJCQCtTWkRijC51qny+gLqFO=z-Jek4mbKN0O6udLKzzeNe_vw@mail.gmail.com>
 <20200525201620.GA19850@merlins.org>
 <CAJCQCtSqdJnVCPQEEeE1W3ux48tWerQuu-2_rySUdYM7GZJR9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSqdJnVCPQEEeE1W3ux48tWerQuu-2_rySUdYM7GZJR9Q@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 25, 2020 at 02:24:03PM -0600, Chris Murphy wrote:
> OK I didn't understand that the problem is with only the sending file
> system, not the receive file system. And also it sounds like the send
> did not cause the problem, but it's somehow a pre-existing problem
> that --repair isn't completely fixing up, or maybe is making different
> (or worse).
 
Correct on all points.

> So I guess the real question is what happened to this file system
> before the send, that got it into this weird state.

That too, but honestly there are a lot of variables, and it feels like a
bit of wild goose chase. 

Basically it looked like the issues with the FS are pretty minor (I was
able to cp -av the entire data without any file error), but that btrfs
check --repair is unable to make it right, which will likely force me to
wipe and restore.
I know chedk is WIP, and that's why I'm providing feedback :)

> > > Is no-holes enabled on either file system?
> >
> > Not intentionally. How do I check?
> 
> btrfs insp dump-s
> 
> It's not yet the default and can't be inadvertently enabled so chances
> are it's the original holes implementation.

The filesystem was definitely created a while ago (2-3 years?)

I have been recently been playing with bees, but I'm reasonably sure I didn't run in on that filesystem
it lists support for "HOLE extents and btrfs no-holes feature"


saruman:~# btrfs insp dump-s /dev/mapper/cr
superblock: bytenr=65536, device=/dev/mapper/cr
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x34a9cfed [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    4cb82363-e833-444e-b23e-1597a14a8aab
metadata_uuid           4cb82363-e833-444e-b23e-1597a14a8aab
label                   btrfs_boot
generation              3801933
root                    1686707896320
sys_array_size          97
chunk_root_generation   3801931
root_level              1
chunk_root              1679158165504
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             161057079296
bytes_used              112391540736
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x169
                        ( MIXED_BACKREF |
                          COMPRESS_LZO |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        3801932
uuid_tree_generation    3801932
dev_item.uuid           924bcb26-9c4c-4106-b3ce-1bb66e66de1f
dev_item.fsid           4cb82363-e833-444e-b23e-1597a14a8aab [match]
dev_item.type           0
dev_item.total_bytes    161057079296
dev_item.bytes_used     136423931904
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
