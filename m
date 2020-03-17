Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988571876E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 01:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbgCQAaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 20:30:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733026AbgCQAaP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 20:30:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DF923ACD0;
        Tue, 17 Mar 2020 00:30:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E001DA726; Tue, 17 Mar 2020 01:29:46 +0100 (CET)
Date:   Tue, 17 Mar 2020 01:29:46 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Andrea Gelmini <gelma@gelma.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Request about "Page cache invalidation failure on direct I/O."
Message-ID: <20200317002945.GV12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Andrea Gelmini <gelma@gelma.net>,
        linux-btrfs@vger.kernel.org
References: <20200311204204.GA21905@li61-168.members.linode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311204204.GA21905@li61-168.members.linode.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 08:42:04PM +0000, Andrea Gelmini wrote:
>    On my laptop (Ubuntu 19.10, Kernel 5.5.7, VirtualBox 6.1.4-136177)
>    I have an SSD (Samsung SSD 860 EVO 4TB + luks + lvm + ext4)
>    with a virtual machine, without troubles, since months.
> 
>    Now, I move the virtual machine on external USB
>    disk (Seagate M3 Portable 4TB + luks + BTRFS).
>    Run it, and after a few minutes of simple boot and Windows updating
>    (the guest system), I find this in dmesg:
> 
> [376827.145222] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [376827.145225] File: /mnt/4TB/piastrelli/home/virtual/VirtualBox VMs/Zuccotti/Snapshots/{badf36e0-30a3-4fef-b723-4cdab32f2ef0}.vdi PID: 48667 Comm: kworker/1:0
> [376827.145230] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [376827.145231] File: /mnt/4TB/piastrelli/home/virtual/VirtualBox VMs/Zuccotti/Snapshots/{badf36e0-30a3-4fef-b723-4cdab32f2ef0}.vdi PID: 48667 Comm: kworker/1:0
> [376827.145234] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [376827.145234] File: /mnt/4TB/piastrelli/home/virtual/VirtualBox VMs/Zuccotti/Snapshots/{badf36e0-30a3-4fef-b723-4cdab32f2ef0}.vdi PID: 48667 Comm: kworker/1:0
> [376827.145236] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [376827.145237] File: /mnt/4TB/piastrelli/home/virtual/VirtualBox VMs/Zuccotti/Snapshots/{badf36e0-30a3-4fef-b723-4cdab32f2ef0}.vdi PID: 48667 Comm: kworker/1:0
> [376827.145240] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!
> [376827.145241] File: /mnt/4TB/piastrelli/home/virtual/VirtualBox VMs/Zuccotti/Snapshots/{badf36e0-30a3-4fef-b723-4cdab32f2ef0}.vdi PID: 48667 Comm: kworker/1:0
> 
>    I kindly ask your advice. At the moment the virtual seems to work
>    without problem.

The warning is there to point out use of buffered writes and direct io
on the same range. More details are in the commits that added the code,
eg.

5a9d929d6e13278  iomap: report collisions between directio and buffered writes to userspace
a92853b6746fe5f  fs/direct-io.c: keep dio_warn_stale_pagecache() when CONFIG_BLOCK=n

whether the corruption really happens depends. If the collision happens
then fsync will report EIO at some point but if you haven't observed any
problems I think it's ok.

According to the timestamps, the reads happen in a quick sequence.
It could be that something during the VM startup reads parts of the
image as buffered and then it goes only DIO.  Looking to the code, the
message is rate limited so the burst would appear once per day and
without tuning of the rate I can't say if the buffered vs dio happens
all the time or just once. For the 'once' case I would not be worried.
