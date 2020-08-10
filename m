Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9E2412F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgHJWYs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 10 Aug 2020 18:24:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33748 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgHJWYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 18:24:48 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id AA3AD7AA9D3; Mon, 10 Aug 2020 18:24:44 -0400 (EDT)
Date:   Mon, 10 Aug 2020 18:24:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     =?utf-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>,
        linux-btrfs@vger.kernel.org
Subject: Re: raid10 corruption while removing failing disk
Message-ID: <20200810222444.GP5890@hungrycats.org>
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
 <4c967884-2252-a21d-a994-80df64a7e6ef@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <4c967884-2252-a21d-a994-80df64a7e6ef@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 11:21:29AM +0300, Nikolay Borisov wrote:
> 
> 
> On 10.08.20 г. 10:03 ч., Agustín DallʼAlba wrote:
> > Hello!
> > 
> > The last quarterly scrub on our btrfs filesystem found a few bad
> > sectors in one of its devices (/dev/sdd), and because there's nobody on
> > site to replace the failing disk I decided to remove it from the array
> > with `btrfs device remove` before the problem could get worse.
> > 
> > The removal was going relatively well (although slowly and I had to
> > reboot a few times due to the bad sectors) until it had about 200 GB
> > left to move. Now the filesystem turns read only when I try to finish
> > the removal and `btrfs check` complains about wrong metadata checksums.
> > However as far as I can tell none of the copies of the corrupt data are
> > in the failing disk.
> > 
> > How could this happen? Is it possible to fix this filesystem?
> > 
> > I have refrained from trying anything so far, like upgrading to a newer
> > kernel or disconnecting the failing drive, before confirming with you
> > that it's safe.
> > 
> > Kind regards.
> > 
> > 
> > # uname -a
> > Linux susanita 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34
> > UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > 
> > 
> > # btrfs --version
> > btrfs-progs v4.15.1
> > 
> > 
> > # btrfs fi show
> > Label: 'Susanita'  uuid: 4d3acf20-d408-49ab-b0a6-182396a9f27c
> > 	Total devices 5 FS bytes used 4.90TiB
> > 	devid    1 size 3.64TiB used 3.42TiB path /dev/sda
> > 	devid    2 size 3.64TiB used 3.42TiB path /dev/sde
> > 	devid    3 size 1.82TiB used 1.59TiB path /dev/sdb
> > 	devid    5 size 0.00B used 185.50GiB path /dev/sdd
> > 	devid    6 size 1.82TiB used 1.22TiB path /dev/sdc
> > 
> > 
> > # btrfs fi df /
> > Data, RAID1: total=4.90TiB, used=4.90TiB
> > System, RAID10: total=64.00MiB, used=880.00KiB
> > Metadata, RAID10: total=9.00GiB, used=7.57GiB
> > GlobalReserve, single: total=512.00MiB, used=0.00B
> > 
> > 
> > # btrfs check --force --readonly /dev/sda
> > WARNING: filesystem mounted, continuing because of --force
> > Checking filesystem on /dev/sda
> > UUID: 4d3acf20-d408-49ab-b0a6-182396a9f27c
> > checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
> > checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
> > bytenr mismatch, want=10919566688256, have=17196831625821864417
> > ERROR: failed to repair root items: Input/output error
> > 
> > # btrfs-map-logical -l 10919566688256 /dev/sda
> > mirror 1 logical 10919566688256 physical 394473357312 device /dev/sdc
> > mirror 2 logical 10919566688256 physical 477218586624 device /dev/sda
> > 
> > 
> > Relevant dmesg output:
> > [    4.963420] Btrfs loaded, crc32c=crc32c-generic
> > [    5.072878] BTRFS: device label Susanita devid 6 transid 4241535 /dev/sdc
> > [    5.073165] BTRFS: device label Susanita devid 3 transid 4241535 /dev/sdb
> > [    5.073713] BTRFS: device label Susanita devid 2 transid 4241535 /dev/sde
> > [    5.073916] BTRFS: device label Susanita devid 5 transid 4241535 /dev/sdd
> > [    5.074398] BTRFS: device label Susanita devid 1 transid 4241535 /dev/sda
> > [    5.152479] BTRFS info (device sda): disk space caching is enabled
> > [    5.152551] BTRFS info (device sda): has skinny extents
> > [    5.332538] BTRFS info (device sda): bdev /dev/sdd errs: wr 0, rd 24, flush 0, corrupt 0, gen 0
> > [   38.869423] BTRFS info (device sda): enabling auto defrag
> > [   38.869490] BTRFS info (device sda): use lzo compression, level 0
> > [   38.869547] BTRFS info (device sda): disk space caching is enabled
> > 
> > 
> > After running btrfs device remove /dev/sdd /:
> > [  193.684703] BTRFS info (device sda): relocating block group 10593404846080 flags metadata|raid10
> > [  312.921934] BTRFS error (device sda): bad tree block start 10597444141056 10919566688256
> > [  313.034339] BTRFS error (device sda): bad tree block start 17196831625821864417 10919566688256
> > [  313.034595] BTRFS error (device sda): bad tree block start 10597444141056 10919566688256
> > [  313.034621] BTRFS: error (device sda) in btrfs_run_delayed_refs:3083: errno=-5 IO failure
> > [  313.034627] BTRFS info (device sda): forced readonly
> > [  313.036328] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > [  313.036596] IP: merge_reloc_roots+0x19f/0x2c0 [btrfs]
> 
> This suggests you are hitting a known problem with reloc roots which
> have been fixed in the latest upstream and lts (5.4) kernels:
> 
> 044ca910276b btrfs: reloc: fix reloc root leak and NULL pointer
> dereference (3 months ago) <Qu Wenruo>
> 707de9c0806d btrfs: relocation: fix reloc_root lifespan and access (7
> months ago) <Qu Wenruo>
> 1fac4a54374f btrfs: relocation: fix use-after-free on dead relocation
> roots (11 months ago) <Qu Wenruo>

Those commits fix a bug that did not exist in btrfs before 5.1.  What is
the rationale for these commits being relevant to a 4.15 kernel?

> So yes, try to update to latest stable kernel and re-run the device
> remove. Also update your btrfs progs to latest 5.6 version and rerun
> check again (by default it's a read only operations so it shouldn't
> cause any more damage).

> 
> <snip>
