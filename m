Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB28FDD49
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 13:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfKOMSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 07:18:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:50830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbfKOMSq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 07:18:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44690AD7F;
        Fri, 15 Nov 2019 12:18:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39BA6DA7D3; Fri, 15 Nov 2019 13:18:47 +0100 (CET)
Date:   Fri, 15 Nov 2019 13:18:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.com,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: Re: [PATCH btrfs-progs 0/2] balance: check balance errors on
 background
Message-ID: <20191115121847.GS3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        dsterba@suse.com,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20191030233641.30123-1-marcos.souza.org@gmail.com>
 <87bc3923-8cda-4bcf-a3e7-fa6204c71d5e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bc3923-8cda-4bcf-a3e7-fa6204c71d5e@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 31, 2019 at 06:00:35PM +0800, Anand Jain wrote:
> On 10/31/19 7:36 AM, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > The first patch removes the close/open operation of stderr, so we can receive
> > errors of balance when starting in the background.
> > 
> > The second patch waits up to three seconds after started the balance process, to
> > check is some problem happened to the balance process. This is done only when
> > the user issues the "balance start" in background mode.
> > 
> > This was tested by issuing running "btrfs balance start --background
> > --full-balance <path>", when the balance started, issue the same command again
> > in the same terminal:
> > 
> > # ./btrfs balance start --background --full-balance /mnt
> > # ./btrfs balance start --background --full-balance /mnt
> > ERROR: error during balancing '/mnt': Operation now in progress
> > 
> > These two patches together fixes the issue 167[1].
> > 
> > Please review,
> > Thanks.
> > 
> > [1]: https://github.com/kdave/btrfs-progs/issues/167
> 
> 
> David,
> 
> -----
> (To fix this, the parent process should wait a bit if the forked 
> background process still runs and report errors otherwise. There are no 
> blocking calls when the 2nd ioctl is called, so a few seconds should be 
> enough.)
> -----
> 
>   This approach might work in most of the cases. However user thread
>   waiting for 3 sec is not a deterministic way to find if the balance
>   was started successfully in the kernel. IMO.

Yes, that's right, it's the simplest thing to implement right now.

>   Instead can we use the balance start ioctl to spin a kthread
>   to run the actual balance that is __btrfs_balance(). With means
>   until call to __btrfs_balance() we shall use ioctl-thread and
>   to spin up kthread to run __btrfs_balance() and return the ioctl
>   thread with the interim status
>   (So for the --no-background user thread has to monitor the
>   balance status using the balance progress ioctl and return when
>   the status becomes completed and also it should call balance control
>   ioctl if the received sigint).
> 
>   We do use kthread for balance, if mount thread has to resume the
>   balance. so its a kind of extension to it.
> 
>   But in the view of the backward btrfs-progs compatibility (that is new
>   kernel with old progs) it looks like we need a new balance-ioctl
>   altogether, but the question is if its too much infrastructure changes,
>   which otherwise might have worked fairly well with a 3 sec delay? What
>   do you think? I think its a good idea to fix it in the right way.

The balance ioctl could start a kthread, we don't need to do a new ioctl
but just extend flags passed to BTRFS_IOC_BALANCE_V2.

As the current --background option creates a userspace process, this is
something we can't silently change to a kernel thread. So this will
probably need a new option but otherwise I don't see any other problems.

Reporting the status is done in the same way using the ioctl
BTRFS_IOC_BALANCE_PROGRESS .

The 3 second wait is not 100% reliable, we can potentially make it a bit
more reliable if the timeout starts right before the other process
starts the ioctl. To minimize effects of activity in the rest of the
system. This could be done in a simple way by a pipe that signals from
the child to the parent that the ioctl is going to be called next.
