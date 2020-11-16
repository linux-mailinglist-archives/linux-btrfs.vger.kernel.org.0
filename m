Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364522B4956
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Nov 2020 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgKPPak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Nov 2020 10:30:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:59266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbgKPPak (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Nov 2020 10:30:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34916ABF4;
        Mon, 16 Nov 2020 15:30:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC7AADA6E3; Mon, 16 Nov 2020 16:28:53 +0100 (CET)
Date:   Mon, 16 Nov 2020 16:28:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: skip unnecessary searches for xattrs when logging
 an inode
Message-ID: <20201116152853.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <eb0d75e48d9dcc438cc618e0a47be8e299e22649.1605266359.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0d75e48d9dcc438cc618e0a47be8e299e22649.1605266359.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 11:21:49AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Every time we log an inode we lookup in the fs/subvol tree for xattrs and
> if we have any, log them into the log tree. However it is very common to
> have inodes without any xattrs, so doing the search wastes times, but more
> importanly it adds contention on the fs/subvol tree locks, either making
> the logging code block and wait for tree locks or making the logging code
> making other concurrent operations block and wait.
> 
> The most typical use cases where xattrs are used are when capabilities or
> ACLs are defined for an inode, or when SELinux is enabled.
> 
> This change makes the logging code detect when an inode does not have
> xattrs and skip the xattrs search the next time the inode is logged,
> unless the inode is evicted and loaded again or a xattr is added to the
> inode. Therefore skipping the search for xattrs on inodes that don't ever
> have xattrs and are fsynced with some frequency.
> 
> The following script that calls dbench was used to measure the impact of
> this change on a VM with 8 cpus, 16Gb of ram, using a raw NVMe device
> directly (no intermediary filesystem on the host) and using a non-debug
> kernel (default configuration on Debian distributions):
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdk
>   MNT=/mnt/sdk
>   MOUNT_OPTIONS="-o ssd"
> 
>   mkfs.btrfs -f -m single -d single $DEV
>   mount $MOUNT_OPTIONS $DEV $MNT
> 
>   dbench -D $MNT -t 200 40
> 
>   umount $MNT
> 
> The results before this change:
> 
>  Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  NTCreateX    5761605     0.172   312.057
>  Close        4232452     0.002    10.927
>  Rename        243937     1.406   277.344
>  Unlink       1163456     0.631   298.402
>  Deltree          160    11.581   221.107
>  Mkdir             80     0.003     0.005
>  Qpathinfo    5221410     0.065   122.309
>  Qfileinfo     915432     0.001     3.333
>  Qfsinfo       957555     0.003     3.992
>  Sfileinfo     469244     0.023    20.494
>  Find         2018865     0.448   123.659
>  WriteX       2874851     0.049   118.529
>  ReadX        9030579     0.004    21.654
>  LockX          18754     0.003     4.423
>  UnlockX        18754     0.002     0.331
>  Flush         403792    10.944   359.494
> 
> Throughput 908.444 MB/sec  40 clients  40 procs  max_latency=359.500 ms
> 
> The results after this change:
> 
>  Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  NTCreateX    6442521     0.159   230.693
>  Close        4732357     0.002    10.972
>  Rename        272809     1.293   227.398
>  Unlink       1301059     0.563   218.500
>  Deltree          160     7.796    54.887
>  Mkdir             80     0.008     0.478
>  Qpathinfo    5839452     0.047   124.330
>  Qfileinfo    1023199     0.001     4.996
>  Qfsinfo      1070760     0.003     5.709
>  Sfileinfo     524790     0.033    21.765
>  Find         2257658     0.314   125.611
>  WriteX       3211520     0.040   232.135
>  ReadX        10098969     0.004    25.340
>  LockX          20974     0.003     1.569
>  UnlockX        20974     0.002     3.475
>  Flush         451553    10.287   331.037
> 
> Throughput 1011.77 MB/sec  40 clients  40 procs  max_latency=331.045 ms
> 
> +10.8% throughput, -8.2% max latency
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Nice, added to misc-next, thanks.
