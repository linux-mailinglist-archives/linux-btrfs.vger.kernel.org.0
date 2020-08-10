Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7A240354
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 10:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHJIVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 04:21:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgHJIVc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 04:21:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47355AC82;
        Mon, 10 Aug 2020 08:21:50 +0000 (UTC)
Subject: Re: raid10 corruption while removing failing disk
To:     =?UTF-8?Q?Agust=c3=adn_Dall=ca=bcAlba?= <agustin@dallalba.com.ar>,
        linux-btrfs@vger.kernel.org
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4c967884-2252-a21d-a994-80df64a7e6ef@suse.com>
Date:   Mon, 10 Aug 2020 11:21:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.08.20 г. 10:03 ч., Agustín DallʼAlba wrote:
> Hello!
> 
> The last quarterly scrub on our btrfs filesystem found a few bad
> sectors in one of its devices (/dev/sdd), and because there's nobody on
> site to replace the failing disk I decided to remove it from the array
> with `btrfs device remove` before the problem could get worse.
> 
> The removal was going relatively well (although slowly and I had to
> reboot a few times due to the bad sectors) until it had about 200 GB
> left to move. Now the filesystem turns read only when I try to finish
> the removal and `btrfs check` complains about wrong metadata checksums.
> However as far as I can tell none of the copies of the corrupt data are
> in the failing disk.
> 
> How could this happen? Is it possible to fix this filesystem?
> 
> I have refrained from trying anything so far, like upgrading to a newer
> kernel or disconnecting the failing drive, before confirming with you
> that it's safe.
> 
> Kind regards.
> 
> 
> # uname -a
> Linux susanita 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34
> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> 
> 
> # btrfs --version
> btrfs-progs v4.15.1
> 
> 
> # btrfs fi show
> Label: 'Susanita'  uuid: 4d3acf20-d408-49ab-b0a6-182396a9f27c
> 	Total devices 5 FS bytes used 4.90TiB
> 	devid    1 size 3.64TiB used 3.42TiB path /dev/sda
> 	devid    2 size 3.64TiB used 3.42TiB path /dev/sde
> 	devid    3 size 1.82TiB used 1.59TiB path /dev/sdb
> 	devid    5 size 0.00B used 185.50GiB path /dev/sdd
> 	devid    6 size 1.82TiB used 1.22TiB path /dev/sdc
> 
> 
> # btrfs fi df /
> Data, RAID1: total=4.90TiB, used=4.90TiB
> System, RAID10: total=64.00MiB, used=880.00KiB
> Metadata, RAID10: total=9.00GiB, used=7.57GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> # btrfs check --force --readonly /dev/sda
> WARNING: filesystem mounted, continuing because of --force
> Checking filesystem on /dev/sda
> UUID: 4d3acf20-d408-49ab-b0a6-182396a9f27c
> checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
> checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
> bytenr mismatch, want=10919566688256, have=17196831625821864417
> ERROR: failed to repair root items: Input/output error
> 
> # btrfs-map-logical -l 10919566688256 /dev/sda
> mirror 1 logical 10919566688256 physical 394473357312 device /dev/sdc
> mirror 2 logical 10919566688256 physical 477218586624 device /dev/sda
> 
> 
> Relevant dmesg output:
> [    4.963420] Btrfs loaded, crc32c=crc32c-generic
> [    5.072878] BTRFS: device label Susanita devid 6 transid 4241535 /dev/sdc
> [    5.073165] BTRFS: device label Susanita devid 3 transid 4241535 /dev/sdb
> [    5.073713] BTRFS: device label Susanita devid 2 transid 4241535 /dev/sde
> [    5.073916] BTRFS: device label Susanita devid 5 transid 4241535 /dev/sdd
> [    5.074398] BTRFS: device label Susanita devid 1 transid 4241535 /dev/sda
> [    5.152479] BTRFS info (device sda): disk space caching is enabled
> [    5.152551] BTRFS info (device sda): has skinny extents
> [    5.332538] BTRFS info (device sda): bdev /dev/sdd errs: wr 0, rd 24, flush 0, corrupt 0, gen 0
> [   38.869423] BTRFS info (device sda): enabling auto defrag
> [   38.869490] BTRFS info (device sda): use lzo compression, level 0
> [   38.869547] BTRFS info (device sda): disk space caching is enabled
> 
> 
> After running btrfs device remove /dev/sdd /:
> [  193.684703] BTRFS info (device sda): relocating block group 10593404846080 flags metadata|raid10
> [  312.921934] BTRFS error (device sda): bad tree block start 10597444141056 10919566688256
> [  313.034339] BTRFS error (device sda): bad tree block start 17196831625821864417 10919566688256
> [  313.034595] BTRFS error (device sda): bad tree block start 10597444141056 10919566688256
> [  313.034621] BTRFS: error (device sda) in btrfs_run_delayed_refs:3083: errno=-5 IO failure
> [  313.034627] BTRFS info (device sda): forced readonly
> [  313.036328] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [  313.036596] IP: merge_reloc_roots+0x19f/0x2c0 [btrfs]

This suggests you are hitting a known problem with reloc roots which
have been fixed in the latest upstream and lts (5.4) kernels:

044ca910276b btrfs: reloc: fix reloc root leak and NULL pointer
dereference (3 months ago) <Qu Wenruo>
707de9c0806d btrfs: relocation: fix reloc_root lifespan and access (7
months ago) <Qu Wenruo>
1fac4a54374f btrfs: relocation: fix use-after-free on dead relocation
roots (11 months ago) <Qu Wenruo>


So yes, try to update to latest stable kernel and re-run the device
remove. Also update your btrfs progs to latest 5.6 version and rerun
check again (by default it's a read only operations so it shouldn't
cause any more damage).


<snip>
