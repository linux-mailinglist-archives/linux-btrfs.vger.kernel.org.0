Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8284015D781
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBNMg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 07:36:56 -0500
Received: from len.romanrm.net ([91.121.86.59]:55582 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgBNMg4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 07:36:56 -0500
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 7BC4A40E3A;
        Fri, 14 Feb 2020 12:36:54 +0000 (UTC)
Date:   Fri, 14 Feb 2020 17:36:54 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: cpu bound I/O behaviour in linux 5.4 (possibly others)
Message-ID: <20200214173654.394c1c7d@natsu>
In-Reply-To: <20200214113027.GA6855@schmorp.de>
References: <20200214113027.GA6855@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 14 Feb 2020 12:30:27 +0100
Marc Lehmann <schmorp@schmorp.de> wrote:

> I've upgraded a machine to linux 5.4.15 that runs a small netnews

You don't seem to mention which version you upgraded from. If a full bisect is
impractical, this is the (very distant) next best thing you can do. Was it from
5.14.14, or from 3.4? :)

Also would be nice if you can double-check that returning to that previous
version right now makes the issue go away, and it's not a coincidence of
something else changed on the FS or OS (such as other package upgrades beside
the kernel).

> system. It normally pulls news with about 20MB/s. After upgrading (it
> seems) that this process is now CPU bound, and I get only about 10mb/s
> throughput. Otherwise, everything seems fine - no obvious bugs, and no
> obvious performance problems.
> 
> "CPU-bound" specifically means that the disk(s) seem pretty idle (it an
> 6x10TB raid5), I can do a lot of I/O without slowing down the transfer,
> but there is always a single kworker which is constantly at 100% cpu (i.e.
> one core) in top:
> 
>  8963 root      20   0       0      0      0 R 2 100.0   0.0   2:04 [kworker/u8:15+flush-btrfs-3]
> 
> When I cat /proc/8963/task/8963/stack regularly, I get either no output or
> (most often) this single line:
> 
>    [<0>] tree_search_offset.isra.0+0x16a/0x1d0 [btrfs]
> 
> It is possible that this is _not_ new behaviour with 5.4, but I often use
> top, and I can't remember having a kworker stuck at 100% cpu for days.
> (The fs is about a year old and had no issues so far, the last scrub is about
> a week old).
> 
> Another symptom is that Dirty in /proc/meminfo is typically at 7-8GB,
> which is more or less the value of /proc/sys/vm/dirty_ratio, Writeback is
> usually 0 or has small values, and running sync often takes 30m or more.
> 
> The 100% cpu is definitely caused by the news transfer - pausing it and
> waiting a while makes it effectively disappear and everything goes back to
> normal.
> 
> The news process effectively does this in multiple parallel loops:
> 
>    openat(AT_FDCWD, "/store/04267/26623~", O_WRONLY|O_CREAT|O_EXCL, 0600...
>    write(75, "Path: ask005.abavia.com!"..., 656453...
>    close(75)                   = 0
>    renameat2(AT_FDCWD, "/store/04267/26623~", AT_FDCWD, "/store/04267/26623", 0 ...
> 
> The file layout is one layer of subdirectories with 100000 files inside
> each, which has posed absolutely no probelms withe xt4/xfs in the past,
> and also btrfs didn't seem to mind.
> 
> My question is, would this be expected behaviour? If yes, is it something
> that can be influenced/improved on my side?
> 
> I can investigate and do some experiments, but I cannot easily update
> kernels/do reboots on this system.
> 


-- 
With respect,
Roman
