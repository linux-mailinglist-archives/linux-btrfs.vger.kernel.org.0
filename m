Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D391214D3F
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGEOx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 10:53:28 -0400
Received: from syrinx.knorrie.org ([82.94.188.77]:47696 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgGEOx2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jul 2020 10:53:28 -0400
Received: from [IPv6:2a02:a213:2b80:f000::12] (unknown [IPv6:2a02:a213:2b80:f000::12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id B33BA609854E3;
        Sun,  5 Jul 2020 16:53:25 +0200 (CEST)
Subject: Re: Balance + Ctrl-C = forced readonly
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <42c9515d-7913-e768-84b1-d5222a0ca17d@knorrie.org>
 <131421c2-1c2a-4b1b-8885-a8700992a77d@gmx.com>
From:   Hans van Kranenburg <hans@knorrie.org>
Autocrypt: addr=hans@knorrie.org; keydata=
 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
Message-ID: <93419615-8f34-efc4-f50e-eac1151f0f37@knorrie.org>
Date:   Sun, 5 Jul 2020 16:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <131421c2-1c2a-4b1b-8885-a8700992a77d@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/5/20 3:13 PM, Qu Wenruo wrote:
> 
> 
> On 2020/7/5 下午8:49, Hans van Kranenburg wrote:
>> Hi,
>>
>> This is Linux kernel 5.7.6 (the Debian package, 5.7.6-1).
>>
>> So, I wanted to try out this new quicker balance interrupt thing, and
>> the result was that I could crash the fs at my very first try using it,
>> which was simply doing balance, and then pressing Ctrl-C.
>>
>> Recipe to reproduce: Start balance, wait a few seconds, then press
>> Ctrl-C. For me here, ~ 5 out of 10 times, it ends up exploding:
>>
>> -# btrfs balance start --full /btrfs/
>> ^C
>>
>> [41190.572977] BTRFS info (device xvdb): balance: start -d -m -s
>> [41190.573035] BTRFS info (device xvdb): relocating block group
>> 73001861120 flags metadata
>> [41205.409600] BTRFS info (device xvdb): found 12236 extents, stage:
>> move data extents
>> [41205.509316] BTRFS info (device xvdb): relocating block group
>> 71928119296 flags data
>> [41205.695319] BTRFS info (device xvdb): found 3 extents, stage: move
>> data extents
>> [41205.723009] BTRFS info (device xvdb): found 3 extents, stage: update
>> data pointers
>> [41205.750590] BTRFS info (device xvdb): relocating block group
>> 60922265600 flags metadata
>> [41208.183424] BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505:
>> errno=-4 unknown
> 
> -4 means -EINTR.

From extent-tree.c:

  5495         /*
  5496          * So if we need to stop dropping the snapshot for
whatever reason we
  5497          * need to make sure to add it back to the dead root list
so that we
  5498          * keep trying to do the work later.  This also cleans up
roots if we
  5499          * don't have it in the radix (like when we recover after
a power fail
  5500          * or unmount) so we don't leak memory.
  5501          */
  5502         if (!for_reloc && !root_dropped)
  5503                 btrfs_add_dead_root(root);
  5504         if (err && err != -EAGAIN)
  5505                 btrfs_handle_fs_error(fs_info, err, NULL);
  5506         return err;
  5507 }

> It means during btrfs balance, signal could interrupt code running in
> kernel space??!!

What a wonderful world.

In the cases where the fs does not crash, it displays e.g.:

[ 1749.607057] BTRFS info (device xvdb): balance: start -d -m -s
[ 1749.607154] BTRFS info (device xvdb): relocating block group
69780635648 flags data
[ 1749.732598] BTRFS info (device xvdb): found 3 extents, stage: move
data extents
[ 1750.087368] BTRFS info (device xvdb): found 3 extents, stage: update
data pointers
[ 1750.109675] BTRFS info (device xvdb): relocating block group
60922265600 flags metadata
[ 1758.021840] BTRFS info (device xvdb): balance: ended with status: -4

...and it fairly quickly after pressing Ctrl-C exits 130 because SIGINT.
(128+2)

But when it goes wrong, then in between pressing Ctrl-C and the forced
readonly happening, the balance in kernel continues for some time (this
can be even multiple next block groups), until it hits the code path
seen above (in btrfs_drop_snapshot), and it's *always* at that line.

So, it seems that depending on what part of the kernel code is running
when the signal is sent, it's queued for being processed in that
(different) part of the running code?

> I thought when we fall into the balance ioctl, we're unable to
> receive/handle signal, as we are in the kernel space, while signal
> handling are all handled in user space.

System calls can be interrupted from user space, e.g. a large read that
goes to slow.

Previously, ^C on the btrfs balance execution would exit when the
current block group in progress was ended. So, in that case the signal
would also be picked up somewhere in the kernel.

> Or is there some config or out-of-tree patches make it possible? Is this
> specific to Debian kernels?
> At least I tried several times with upstream kernel, unable to reproduce
> it yet (maybe my fs is too small?)

So, it at least seems to depends on the moment when Ctrl-C is pressed.

This is a two-disk fs, where I reflinked a single file many tens of
thousands of time to generate quite some metadata. You might have to
need some more data or metadata to have enough change to hit Ctrl-C at
the right time, but I can only make guesses about that now.

-# btrfs fi show /btrfs/
Label: none  uuid: 4771ea11-6ec6-4c00-a5f5-58acb3233659
	Total devices 2 FS bytes used 5.76GiB
	devid    1 size 10.00GiB used 3.50GiB path /dev/xvdb
	devid    2 size 10.00GiB used 3.53GiB path /dev/xvdc

-# btrfs-search-metadata block_groups /btrfs
block group vaddr 78370570240 length 1073741824 flags DATA used
1072177152 used_pct 100
block group vaddr 79444312064 length 268435456 flags METADATA used
219824128 used_pct 82
block group vaddr 79712747520 length 33554432 flags SYSTEM used 16384
used_pct 0
block group vaddr 79746301952 length 1073741824 flags DATA used
1071206400 used_pct 100
block group vaddr 80820043776 length 268435456 flags METADATA used
214712320 used_pct 80
block group vaddr 81088479232 length 1073741824 flags DATA used
1073045504 used_pct 100
block group vaddr 82162221056 length 268435456 flags METADATA used
262979584 used_pct 98
block group vaddr 85920317440 length 1073741824 flags DATA used
1069948928 used_pct 100
block group vaddr 86994059264 length 1073741824 flags DATA used 15978496
used_pct 1
block group vaddr 90349502464 length 1073741824 flags DATA used
1073246208 used_pct 100
block group vaddr 91423244288 length 268435456 flags METADATA used
109608960 used_pct 41

> If it's config related, then we must re-consider a lot of error handling.

I don't know, but I don't think so.

> 
> Thanks,
> Qu
>> [41208.183450] BTRFS info (device xvdb): forced readonly
>> [41208.183469] BTRFS info (device xvdb): balance: ended with status: -4
>>
>> Boom, readonly FS.
>>
>> Hans
>>
> 

Hans
