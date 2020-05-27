Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E951E377D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 06:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgE0Erz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 27 May 2020 00:47:55 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43406 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0Erz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 00:47:55 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 810EC6E1C55; Wed, 27 May 2020 00:47:37 -0400 (EDT)
Date:   Wed, 27 May 2020 00:47:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Michael Thomas <mt@bxx5.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Any news about rescue data from a raid5 in the last years?
Message-ID: <20200527044737.GF10769@hungrycats.org>
References: <41c53dd1-b553-bc2e-115d-b227f97c43c2@merkens.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <41c53dd1-b553-bc2e-115d-b227f97c43c2@merkens.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 26, 2020 at 04:44:25AM +0200, Michael Thomas wrote:
> Hey,
> 
> I just wanted to ask if it's maybe possible to restore data from an old,
> failed, raid5 btrfs fs. There are some files on it which I lost lately and
> before I format the drives I wanted to give it another shot after some (6?)
> years.
> I'm not sure what I tried before, but there are 3 drives there, was 4 before
> but 1 died (and this seems to be the problem of the disaster).
> I tried to add 1 new, but that didn't worked.
> So, there are 3 devices and as far as I understand, there are still no good
> tools to rescue data from them, are they? btrfs restore and other seems only
> compatible with 1 drive.
> 
> But maybe someone can give me a hint what I can try before giving up.
> 
> If I try to mount:
> mount -o degraded,subvol=data,ro,device=/dev/mapper/sdb,device=/dev/mapper/sdd,device=/dev/mapper/sde
> /dev/mapper/sde /mnt/test
> 
> dmesg give this errors:
> BTRFS warning (device dm-4): suspicious: generation < chunk_root_generation:
> 176279 < 176413
> BTRFS info (device dm-4): allowing degraded mounts
> BTRFS info (device dm-4): disk space caching is enabled
> BTRFS warning (device dm-4): devid 4 uuid
> 16490fb1-df5e-4c81-9c07-4f799d0fc132 is missing
> BTRFS warning (device dm-4): devid 5 uuid
> 36436209-c0d4-4a5e-9176-d44c94cb4b39 is missing

That's 2 missing disks.  Assuming that is accurate (were there 5 in
total?), it is not likely recoverable with raid5.

raid5 tolerates only one disk failure--two or more failures, and you'll
only be able to get 64K contiguous chunks of data without any idea
what files they belong to.

If the messages are _not_ accurate, you might have a corrupted superblock
on one of the disks that is making 'btrfs dev scan' fail.  If you can
identify which disk that is, 'btrfs rescue super-recover' might help
(though it sounds like you already tried and it didn't).

> BTRFS critical (device dm-4): corrupt leaf: block=1095416938496 slot=151
> extent bytenr=1095389085696 len=16384 invalid generation, have 176581 expect
> (0, 176280]
> BTRFS error (device dm-4): block=1095416938496 read time tree block
> corruption detected

You may have more luck with kernel 4.19, which is a LTS kernel without
the read time tree block corruption detector; however, that won't be able
to read past the corrupted tree block, it will only let you mount the
filesystem to try to salvage other data.

> BTRFS critical (device dm-4): corrupt leaf: block=1095416938496 slot=151
> extent bytenr=1095389085696 len=16384 invalid generation, have 176581 expect
> (0, 176280]
> BTRFS error (device dm-4): block=1095416938496 read time tree block
> corruption detected
> BTRFS warning (device dm-4): failed to read root (objectid=4): -5
> BTRFS error (device dm-4): open_ctree failed
> 
> (usebackuproot changed nothing and super-recover prints "All supers are
> valid, no need to recover")
> 
> Do you have any hint, advice to get (some of) this data back?
> 
> 
> Best,
> Michael
