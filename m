Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC63D122A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbhGUOic (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:38:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbhGUOib (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:38:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A26FF1FEB3;
        Wed, 21 Jul 2021 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626880747;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJLKylhXQbeTZ7k/k9RB2fLTmgJQG3/pDfdsgwWo/yA=;
        b=EmZaGWymn1KoaE0N6gj0Xlp6hTO/zoX0m1DLVj6qbGSgA0P3rG8MwUNOkutUrtXqINtg0r
        TnlBaFQ2KFZqNw1pSl97Z95fNTdRGhBIDBQScyVyr9hRqPICGIxqtCqE0ZUScFg6L46crY
        hsf9PEDGga+jHrtnx+xwc0ntIkHmxbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626880747;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJLKylhXQbeTZ7k/k9RB2fLTmgJQG3/pDfdsgwWo/yA=;
        b=kLhdIglh+nxRhdOAUga8SYoVSBLzGTsVRAr+RAT77nOyf4yUFV61UlEYz+2jkwZhRSb/y4
        6PAjOLo+PPWidhDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9BA6CA3B87;
        Wed, 21 Jul 2021 15:19:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D405DA704; Wed, 21 Jul 2021 17:16:26 +0200 (CEST)
Date:   Wed, 21 Jul 2021 17:16:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: continue readahead of siblings even if target
 node is in memory
Message-ID: <20210721151626.GH19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <1589fffc3a30631b2268b4f64e55fcf9ce664fb6.1626792325.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589fffc3a30631b2268b4f64e55fcf9ce664fb6.1626792325.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 04:03:03PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At reada_for_search(), when attempting to readahead a node or leaf's
> siblings, we skip the readahead of the siblings if the node/leaf is
> already in memory. That is probably fine for the READA_FORWARD and
> READA_BACK readahead types, as they are used on contextes where we
> end up reading some consecutive leaves, but usually not the whole btree.
> 
> However for a READA_FORWARD_ALWAYS mode, currently only used for full
> send operations, it does not make sense to skip the readahead if the
> target node or leaf is already loaded in memory, since we know the caller
> is visiting every node and leaf of the btree in ascending order.
> 
> So change the behaviour to not skip the readahead when the target node is
> already in memory and the readahead mode is READA_FORWARD_ALWAYS.
> 
> The following test script was used to measure the improvement on a box
> using an average, consumer grade, spinning disk, with 32GiB of RAM and
> using a non-debug kernel config (Debian's default config).
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
>   file_count=2000000
>   add_files $file_count 0 4
> 
>   echo
>   echo "Creating snapshot..."
>   btrfs subvolume snapshot -r $MNT $MNT/snap1
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
> The duration of the full send operations, in seconds, were the following:
> 
> Before this change:  85 seconds
> After this change:   76 seconds (-11.2%)
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Nice, added to misc-next, thanks.
