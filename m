Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B886C8EBD
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 15:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCYOGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 10:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYOGG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 10:06:06 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E0113C4
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 07:06:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6AB8E425DF;
        Sat, 25 Mar 2023 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1679753158; bh=iRVgMjgccoP9yaursTMEMI9WVW3DgtlA0royECk5fgs=;
        h=Date:To:Cc:From:Subject;
        b=h7fq6AF546XtiCNIoq3hqAKpQznO05FLOEggOxLbPv3xMF5vv5EQCq6JqEYmF8xiS
         NQzCL+uWelz2zzA+cTnpXlgUrs4TWJmyMFOUMNE9vdPavvSFqPkGXE/jm2jez91sim
         JnBBWkRYrzERYZFnNyuFK8TZZ3HG6BbUNw/dqL2D+vt2eRWBS98bStnj4btj24lN3H
         IYaO1rNLY8Cp059JGdL3zRJUg4Xd18uuBlYtX263Ih+ca4MbwafYYxnAGOELQltu0J
         +ghFf2Ey2fIFP5xYuu8gcLjAyxbD/yxAtWvZ1Z2hDouJFIKGHFimW1qllcEnXkisPp
         FgaQRQ4TfDmTA==
Message-ID: <e409bf4d-5415-4524-e7c0-480f5387ce6e@marcan.st>
Date:   Sat, 25 Mar 2023 23:05:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>,
        Davide Cavalca <davide@cavalca.name>,
        Sven Peter <sven@svenpeter.dev>, "axboe@fb.com" <axboe@fb.com>,
        Asahi Linux <asahi@lists.linux.dev>
Content-Language: en-US
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2023 14.19, Qu Wenruo wrote:
> 
> 
> On 2023/3/21 18:07, Hector Martin wrote:
> [...]
>>
>> btrfs/140 is the first one that looks bad. Looks like the corruption
>> correction didn't work for some reason.
>>
>> ... and then btrfs/142 which is similar actually managed to log a bunch
>> of errors on our NVMe controller. Nice.
>>
>> [ 1240.000104] nvme-apple 393cc0000.nvme: RTKit: syslog message:
>> host_ans2.c:1564: cmd parsing error for tag 12 fast decode err 0x1
>> [ 1240.000767] nvme0n1: Read(0x2) @ LBA 322753843, 0 blocks, Invalid
>> Field in Command (sct 0x0 / sc 0x2)
>> [ 1240.000771] nvme-apple 393cc0000.nvme: RTKit: syslog message:
>> host_ans2.c:1469: tag 12, completed with err BAD_CMD-
>> [ 1240.000775] operation not supported error, dev nvme0n1, sector
>> 2582030751 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
> 
> Mind to share the reproducibility?

100% as far as I can tell. I'm using 20G devices for everything. It
instantly hits that bug.

Good news is it's not a btrfs bug though :)

common/dmdust:  DUST_TABLE="0 $DEV_SIZE dust $SCRATCH_DEV 0 512"

The dust device is created with 512 byte sectors, while the NVMe on
these machines has 4K sectors. Changing that to 4K and the respective
block size calculation in the tests (142/143) (`physical / 512` ->
`physical / 4096`) makes it pass. It's not reading 0 bytes, it's reading
512 bytes (which gets truncated to 0 sectors).

And then that explains why 140 doesn't work: it also assumes 512, but in
a way that just fails instead of causing kernel explosions. Same with
btrfs/265, 266, 267, 269.

So there's two problems here: a bunch of tests assume 512 byte sectors,
and the kernel DM dust device is missing a check that should reject
creation with an invalid sector size instead of just causing wreckage
further down the block device chain.

>> 213 failed to balance with ENOSPC.
> 
> Passed with 5x10G LVs as scratch dev pool.

5x20G GPT partitions here, and I can reliably repro this one. Maybe it's
also related to the 4K sectors?

> I hope it's not Apple Silicon too fast to trigger it, or it would be 
> pretty hard to reproduce...

FWIW, there's also the whole thing where Apple Silicon is *really* good
at triggering memory ordering and concurrency problems, since it is such
a wide architecture. I found a bug in the core kernel workqueue code
that had been there for years on ARM64...

>> generic/251 then failed too, with dmesg logs about failing to trim block
>> groups.
> 
> It takes much longer time but still passed here.

Reliably fails here, and this is another 4K sector one and actually a
btrfs bug I think. It tries to do discards that are not 4K-aligned.
Here's the call trace leading to the bad discard attempt:

[   70.571872]  btrfs_issue_discard+0x224/0x260
[   70.571874]  btrfs_discard_extent+0x128/0x1dc
[   70.571876]  do_trimming+0xc4/0x220
[   70.571878]  trim_no_bitmap+0x21c/0x3f0
[   70.571879]  btrfs_trim_block_group+0x88/0x170
[   70.571880]  btrfs_trim_fs+0xf0/0x3a0
[   70.571882]  btrfs_ioctl_fitrim+0x100/0x1dc
[   70.571885]  btrfs_ioctl+0x1550/0x25bc
[   70.571887]  __arm64_sys_ioctl+0x464/0xbb0
[   70.571891]  invoke_syscall.constprop.0+0x78/0xd0
[   70.571894]  do_el0_svc+0x58/0x170
[   70.571896]  el0_svc+0x38/0xf0
[   70.571900]  el0t_64_sync_handler+0xf4/0x120
[   70.571902]  el0t_64_sync+0x190/0x194

Note that discard size is actually a *separate* device property from
sector size, so this is doubly wrong. btrfs probably needs to explicitly
align to the discard size.

> I'll try my best to got some runs on real Apple machines meanwhile, but 
> don't expect any improvement on my hardware situation any time soon...

Hope you can repro with the 4K sector hint. Last time I had emulate that
I used a loop device with 4K sectors, but I don't know if that supports
discard... not sure if there is a better way.

> 
> Thanks,
> Qu
> 
>>
>> generic/520 failed with an EBUSY on umount, but I suspect this might be
>> some desktop/systemd stuff trying to use the mount?
>>
>> generic/563 suggests there may be cgroup accounting issues
>>
>> generic/619 seems known to be pathologically slow on arm64, so I killed
>> it (https://www.spinics.net/lists/linux-btrfs/msg131553.html).
>>
>> generic/708 failed but that pointed to a known kernel bug that we don't
>> have the fix for yet (this is running on 6.2 + asahi patches).
>>
>> Run output and some select dmesg sections:
>> https://gist.github.com/marcan/822a34266bcaf4f4cffaa6a198b4c616
>>
>> Let me know if you need anything else.
>>
> 

- Hector

