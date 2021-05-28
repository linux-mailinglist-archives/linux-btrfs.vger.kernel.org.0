Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED33943EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 16:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhE1ORV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 10:17:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbhE1ORQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 10:17:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622211341;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M9O880aEiAEZUcT75DlEnHdMdqULo3euYzEhIhafrso=;
        b=IOdd5h+fO4HxkD0GhbWCrOW+BU3/H4+79yc5EF+Jm3o64o06dkMpjHTSWOHePu9V3Bn70V
        VLswew/fYYGdfeKUy/xCiueIrK672NYNtxnACMJylbz530zzndkqGxUOVMTC9EUNHZMDT+
        s5Va8A5bNyk+/Aqjio4fmhJBAL5FjCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622211341;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M9O880aEiAEZUcT75DlEnHdMdqULo3euYzEhIhafrso=;
        b=84Iht5H4UwMCJWTrtZDpuufHuofCZz8m1SX4CXM79Fgj94DATYrZS5RvddQeZiCRlNut7z
        bJCwrfhFfMSkPBDQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AAA1AEBA;
        Fri, 28 May 2021 14:15:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2008DDA70B; Fri, 28 May 2021 16:13:03 +0200 (CEST)
Date:   Fri, 28 May 2021 16:13:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid unnecessary logging of xattrs during fast
 fsyncs
Message-ID: <20210528141302.GB14136@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <712009b23575e0d7a82f86072fa6e9bf14ec4efa.1622197177.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712009b23575e0d7a82f86072fa6e9bf14ec4efa.1622197177.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 28, 2021 at 11:37:32AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging an inode we always log all its xattrs, so that we are able
> to figure out which ones should be deleted during log replay. However this
> is unnecessary when we are doing a fast fsync and no xattrs were added,
> changed or deleted since the last time we logged the inode in the current
> transaction.
> 
> So skip the logging of xattrs when the inode was previously logged in the
> current transaction and no xattrs were added, changed or deleted. If any
> changes to xattrs happened, than the inode has BTRFS_INODE_COPY_EVERYTHING
> set in its runtime flags and the xattrs get logged. This saves time on
> scanning for xattrs, allocating memory, COWing log tree extent buffers and
> adding more lock contention on the extent buffers when there are multiple
> tasks logging in parallel.
> 
> The use of xattrs is common when using ACLs, some applications, or when
> using security modules like SELinux where every inode gets a security
> xattr added to it.
> 
> The following test script, using fio, was used on a box with 12 cores, 64G
> of RAM, a NVMe device and the default non-debug kernel config from Debian.
> It uses 8 concurrent jobs each writing in blocks of 64K to its own 4G file,
> each file with a single xattr of 50 bytes (about the same size for an ACL
> or SELinux xattr), doing random buffered writes with an fsync after each
> write.
> 
>    $ cat test.sh
>    #!/bin/bash
> 
>    DEV=/dev/nvme0n1
>    MNT=/mnt/test
>    MOUNT_OPTIONS="-o ssd"
>    MKFS_OPTIONS="-d single -m single"
> 
>    NUM_JOBS=8
>    FILE_SIZE=4G
> 
>    cat <<EOF > /tmp/fio-job.ini
>    [writers]
>    rw=randwrite
>    fsync=1
>    fallocate=none
>    group_reporting=1
>    direct=0
>    bs=64K
>    ioengine=sync
>    size=$FILE_SIZE
>    directory=$MNT
>    numjobs=$NUM_JOBS
>    EOF
> 
>    echo "performance" | \
>        tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> 
>    mkfs.btrfs -f $MKFS_OPTIONS $DEV > /dev/null
>    mount $MOUNT_OPTIONS $DEV $MNT
> 
>    echo "Creating files before fio runs, each with 1 xattr of 50 bytes"
>    for ((i = 0; i < $NUM_JOBS; i++)); do
>        path="$MNT/writers.$i.0"
>        truncate -s $FILE_SIZE $path
>        setfattr -n user.xa1 -v $(printf '%0.sX' $(seq 50)) $path
>    done
> 
>    fio /tmp/fio-job.ini
>    umount $MNT
> 
> fio output before this change:
> 
> WRITE: bw=120MiB/s (126MB/s), 120MiB/s-120MiB/s (126MB/s-126MB/s), io=32.0GiB (34.4GB), run=272145-272145msec
> 
> fio output after this change:
> 
> WRITE: bw=142MiB/s (149MB/s), 142MiB/s-142MiB/s (149MB/s-149MB/s), io=32.0GiB (34.4GB), run=230408-230408msec
> 
> +16.8% throughput, -16.6% runtime

Nice, thanks. Patch added to misc-next.
