Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988583E8741
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 02:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhHKAbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 20:31:18 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38334 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhHKAbS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 20:31:18 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 802A0B2431F; Tue, 10 Aug 2021 20:30:52 -0400 (EDT)
Date:   Tue, 10 Aug 2021 20:30:52 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Konstantin Svist <fry.kun@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Trying to recover data from SSD
Message-ID: <20210811003052.GA29026@hungrycats.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 10, 2021 at 02:56:22PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/10 下午2:44, Konstantin Svist wrote:
> > It's a Micron MTFDDAK512MBF, firmware M603
> 
> CC Zygo to see if he also hits such hardware.

I only have one data point for Micron M600 series, and this is it.

> > I don't know how to do that (corrupt the extent tree)
> 
> There is the more detailed version:
> https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf597299a@gmx.com/
> 
> Or if you can re-compile btrfs kernel module, this patch would allow
> your to mount with rescue=all, without destroying the existing extent
> tree root:
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210719054304.181509-1-wqu@suse.com/
> 
> 
> > Is there any other way to pull files off of the drive?
> 
> Either btrfs-restore or above rescue=all mount option.
> 
> Since btrfs-restore doesn't give you the recent files, I guess the
> rescue=all method is the only alternative.
> 
> Thanks,
> Qu
> 
> > 
> > 
> > On Mon, Aug 9, 2021, 22:24 Qu Wenruo <quwenruo.btrfs@gmx.com
> > <mailto:quwenruo.btrfs@gmx.com>> wrote:
> > 
> > 
> > 
> >     On 2021/8/10 下午12:41, Konstantin Svist wrote:
> >      > Not sure exactly when it stopped working, possibly had a power
> >     outage..
> >      > I was able to pull most of a snapshot with btrfs restore -s --
> >     but it's
> >      > months old and I want the more recent files from.
> >      >
> >      >
> >      > Testing the SSD for bad sectors, but nothing so far
> >      >
> >      >
> >      > While trying to mount:
> >      > [442587.465598] BTRFS info (device sdb3): allowing degraded mounts
> >      > [442587.465602] BTRFS info (device sdb3): disk space caching is
> >     enabled
> >      > [442587.465603] BTRFS info (device sdb3): has skinny extents
> >      > [442587.522301] BTRFS error (device sdb3): bad tree block start, want
> >      > 952483840 have 0
> >      > [442587.522867] BTRFS error (device sdb3): bad tree block start, want
> >      > 952483840 have 0
> > 
> >     Some metadata is completely lost.
> > 
> >     Mind to share the hardware model? Maybe it's some known bad hardware.
> > 
> >     Just a small note, all filesystems (including btrfs) should survive a
> >     power loss, as long as the disk is following the FLUSH/FUA requirement
> >     properly.
> > 
> >      > [442587.522876] BTRFS error (device sdb3): failed to read block
> >     groups: -5
> >      > [442587.523520] BTRFS error (device sdb3): open_ctree failed
> >      > [442782.661849] BTRFS error (device sdb3): unrecognized mount option
> >      > 'rootflags=recovery'
> >      > [442782.661926] BTRFS error (device sdb3): open_ctree failed
> > 
> >     Since the fs is already corrupted, you can try to corrupt extent tree
> >     root completely, then "rescue=all" mount option should allow you to
> >     mount the fs RO, and grab as much data as you can.
> > 
> >     But I doubt if it's any better than btrfs-restore.
> > 
> >     Thanks,
> >     Qu
> >      >
> >      > # btrfs-find-root /dev/sdb3
> >      > ERROR: failed to read block groups: Input/output error
> >      > Superblock thinks the generation is 166932
> >      > Superblock thinks the level is 1
> >      > Found tree root at 787070976 gen 166932 level 1
> >      > Well block 786399232(gen: 166931 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 781172736(gen: 166930 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 778108928(gen: 166929 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 100696064(gen: 166928 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 99565568(gen: 166927 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 97599488(gen: 166926 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 91701248(gen: 166925 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 89620480(gen: 166924 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 86818816(gen: 166923 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 84197376(gen: 166922 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 76398592(gen: 166921 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 72400896(gen: 166920 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 63275008(gen: 166919 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 60080128(gen: 166918 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 58032128(gen: 166917 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 55689216(gen: 166916 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 52264960(gen: 166915 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 49758208(gen: 166914 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 48300032(gen: 166913 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 45350912(gen: 166912 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 40337408(gen: 166911 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 71172096(gen: 166846 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 61210624(gen: 166843 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 55492608(gen: 166840 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 36044800(gen: 166829 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 34095104(gen: 166828 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 33046528(gen: 166827 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 31014912(gen: 166826 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 30556160(gen: 166825 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 777011200(gen: 166822 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 766672896(gen: 166821 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 690274304(gen: 166820 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 175046656(gen: 166819 level: 1) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 766017536(gen: 166813 level: 0) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 765739008(gen: 166813 level: 0) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > Well block 32604160(gen: 152478 level: 0) seems good, but
> >      > generation/level doesn't match, want gen: 166932 level: 1
> >      > # btrfs check /dev/sdb3
> >      > Opening filesystem to check...
> >      > checksum verify failed on 952483840 wanted 0x00000000 found
> >     0xb6bde3e4
> >      > checksum verify failed on 952483840 wanted 0x00000000 found
> >     0xb6bde3e4
> >      > checksum verify failed on 952483840 wanted 0x00000000 found
> >     0xb6bde3e4
> >      > bad tree block 952483840, bytenr mismatch, want=952483840, have=0
> >      > ERROR: failed to read block groups: Input/output error
> >      > ERROR: cannot open file system
> >      >
> >      >
> >      > # uname -a
> >      > Linux fry 5.13.6-200.fc34.x86_64 #1 SMP Wed Jul 28 15:31:21 UTC 2021
> >      > x86_64 x86_64 x86_64 GNU/Linux
> >      > # btrfs --version
> >      > btrfs-progs v5.13.1
> >      > # btrfs fi show /dev/sdb3
> >      > Label: none  uuid: 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
> >      >      Total devices 1 FS bytes used 171.92GiB
> >      >      devid    1 size 472.10GiB used 214.02GiB path /dev/sdb3
> >      >
> >      >
> > 
