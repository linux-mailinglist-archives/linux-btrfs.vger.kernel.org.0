Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE1351895
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhDARqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 13:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234772AbhDARkB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE707AF21;
        Thu,  1 Apr 2021 17:39:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68D51DA790; Thu,  1 Apr 2021 19:37:49 +0200 (CEST)
Date:   Thu, 1 Apr 2021 19:37:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: improve btree readahead for full send operations
Message-ID: <20210401173748.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <ec7b0d5e27fc3f54c888fb7b71510f3a6d793cd7.1617188079.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec7b0d5e27fc3f54c888fb7b71510f3a6d793cd7.1617188079.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 31, 2021 at 11:56:21AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently a full send operation uses the standard btree readahead when
> iterating over the subvolume/snapshot btree, which despite bringing good
> performance benefits, it could be improved in a few aspects for use cases
> such as full send operations, which are guaranteed to visit every node
> and leaf of a btree, in ascending and sequential order. The limitations
> of that standard btree readahead implementation are the following:
> 
> 1) It only triggers readahead for for leaves that are physically close
>    to the leaf being read, within a 64K range;
> 
> 2) It only triggers readahead for the next or previous leaves if the
>    leaf being read is not currently in memory;
> 
> 3) It never triggers readahead for nodes.
> 
> So add a new readahead mode that addresses all these points and use it
> for full send operations.
> 
> The following test script was used to measure the improvement on a box
> using an average, consumer grade, spinning disk and with 16Gb of ram:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdj
>   MNT=/mnt/sdj
>   MKFS_OPTIONS="--nodesize 16384"     # default, just to be explicit
>   MOUNT_OPTIONS="-o max_inline=2048"  # default, just to be explicit
> 
>   mkfs.btrfs -f $MKFS_OPTIONS $DEV > /dev/null
>   mount $MOUNT_OPTIONS $DEV $MNT
> 
>   # Create files with inline data to make it easier and faster to create
>   # large btrees.
>   add_files()
>   {
>       local total=$1
>       local start_offset=$2
>       local number_jobs=$3
>       local total_per_job=$(($total / $number_jobs))
> 
>       echo "Creating $total new files using $number_jobs jobs"
>       for ((n = 0; n < $number_jobs; n++)); do
>           (
>               local start_num=$(($start_offset + $n * $total_per_job))
>               for ((i = 1; i <= $total_per_job; i++)); do
>                   local file_num=$((start_num + $i))
>                   local file_path="$MNT/file_${file_num}"
>                   xfs_io -f -c "pwrite -S 0xab 0 2000" $file_path > /dev/null
>                   if [ $? -ne 0 ]; then
>                       echo "Failed creating file $file_path"
>                       break
>                   fi
>               done
>           ) &
>           worker_pids[$n]=$!
>       done
> 
>       wait ${worker_pids[@]}
> 
>       sync
>       echo
>       echo "btree node/leaf count: $(btrfs inspect-internal dump-tree -t 5 $DEV | egrep '^(node|leaf) ' | wc -l)"
>   }
> 
>   initial_file_count=500000
>   add_files $initial_file_count 0 4
> 
>   echo
>   echo "Creating first snapshot..."
>   btrfs subvolume snapshot -r $MNT $MNT/snap1
> 
>   echo
>   echo "Adding more files..."
>   add_files $((initial_file_count / 4)) $initial_file_count 4
> 
>   echo
>   echo "Updating 1/50th of the initial files..."
>   for ((i = 1; i < $initial_file_count; i += 50)); do
>       xfs_io -c "pwrite -S 0xcd 0 20" $MNT/file_$i > /dev/null
>   done
> 
>   echo
>   echo "Creating second snapshot..."
>   btrfs subvolume snapshot -r $MNT $MNT/snap2
> 
>   umount $MNT
> 
>   echo 3 > /proc/sys/vm/drop_caches
>   blockdev --flushbufs $DEV &> /dev/null
>   hdparm -F $DEV &> /dev/null
> 
>   mount $MOUNT_OPTIONS $DEV $MNT
> 
>   echo
>   echo "Testing full send..."
>   start=$(date +%s)
>   btrfs send $MNT/snap1 > /dev/null
>   end=$(date +%s)
>   echo
>   echo "Full send took $((end - start)) seconds"
> 
>   umount $MNT
> 
> The durations of the full send operation in seconds were the following:
> 
> Before this change:  217 seconds
> After this change:   205 seconds (-5.7%)
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
