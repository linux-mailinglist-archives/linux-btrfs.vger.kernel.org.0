Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2BB26FB2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIRLLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 07:11:25 -0400
Received: from mail.talpidae.net ([176.9.32.230]:46267 "EHLO
        node0.talpidae.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRLLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 07:11:25 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:11:24 EDT
Received: from talpidae.net (localhost [127.0.0.1])
        by node0.talpidae.net (mail.talpidae.net) with ESMTP id C8957B7DCDA;
        Fri, 18 Sep 2020 11:05:43 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 18 Sep 2020 13:05:41 +0200
From:   Jonas Zeiger <jonas.zeiger@talpidae.net>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Detecting new partitions fails after "btrfs device scan --forget"
In-Reply-To: <e8bdb0c13f5f91b90e75b1a218ded2cb@talpidae.net>
References: <1ab4e230fe413c033b195bbd0f7e1db0@talpidae.net>
 <40e2315e-e60e-6161-ceb7-acd8b8a4e4a0@oracle.com>
 <e8bdb0c13f5f91b90e75b1a218ded2cb@talpidae.net>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <c9541227857a2d7ad8c09ad93fdf5c24@talpidae.net>
X-Sender: jonas.zeiger@talpidae.net
Organization: talpidae.net
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seems like the following commit in 5.8.10 fixes the issue:

commit b730cc810f71f7b2126d390b63b981e744777c35
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Sep 8 16:15:06 2020 +0200

     block: restore a specific error code in bdev_del_partition

     [ Upstream commit 88ce2a530cc9865a894454b2e40eba5957a60e1a ]

     mdadm relies on the fact that deleting an invalid partition returns
     -ENXIO or -ENOTTY to detect if a block device is a partition or a
     whole device.

     Fixes: 08fc1ab6d748 ("block: fix locking in bdev_del_partition")
     Reported-by: kernel test robot <rong.a.chen@intel.com>
     Signed-off-by: Christoph Hellwig <hch@lst.de>
     Signed-off-by: Jens Axboe <axboe@kernel.dk>
     Signed-off-by: Sasha Levin <sashal@kernel.org>

On 2020-09-14 13:10, Jonas Zeiger wrote:
> Hi Anand,
> 
> Thank you for your assistance.
> 
> I enabled lock-stats in the kernel and stopped directly after
> initramfs boot from PXE:
> 
>  1. "partprobe" already fails even directly after boot, so my initial
> hunch that "btrfs device scan" is causing it is likely wrong.
> 
>  2. "lsof /dev/sdd" doesn't return anything and there is no mention of
> the device in "lsof" output.
> 
>  3. Nothing from disks is mounted, running only from tmpfs (unpacked
> from initramfs), almost no daemons (even killed smartd).
> 
>  4. "strace partprobe /dev/sdd" STDERR output is attached
> (strace-partprobe-dev-sdd.txt).
> 
>  5. I could not tell from "/proc/lock_stat" which lock could be
> responsible, if any, so I attached the file (lock_stat.txt).
> 
>  6. Partprobe's "ioctl(3, BLKPG, {op=BLKPG_DEL_PARTITION..." returns
> ENOMEM. Maybe I should mention that my kernel doesn't have swap
> (CONFIG_SWAP=n), but I guess ENOMEM means something different in this
> context. Also, why would it reliably work on 5.8.7.
> 
> I have set one host aside to help debug this issue as it prevents us
> from updating the kernel.
> 
> How can I help to further analyze this regression?
> 
> 
> On 2020-09-14 02:36, Anand Jain wrote:
>>> /dev/sda have been written, but we have been unable to inform the 
>>> kernel of the change, probably because it/they are in use.  As a 
>>> result, the old partition(s) will remain in use.  You should reboot 
>>> now before making further changes.
>>> 
>>> The partitions do not become visible so the deployment can't 
>>> continue.
>> 
>> The forget subcommand does not touch the mounted device, and it frees
>> only the unmounted or unopened btrfs devices from its kernel memory.
>> 
>> Now the error seems to be about the device being kept open. Can you
>> find out who did not close it?
