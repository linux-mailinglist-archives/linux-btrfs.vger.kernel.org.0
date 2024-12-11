Return-Path: <linux-btrfs+bounces-10258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39D9ED4AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0B188B3DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C3203719;
	Wed, 11 Dec 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP1B1zeT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E924632E;
	Wed, 11 Dec 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941497; cv=none; b=ZevcJNNvcyPue7I95LYfMlJ0D4hiC900klWj4Vg30+IVhTkOqe2VPGnndypF7Pk2pgvdJxQa9ya7BzhtjhgmSfuAtlrRgrOb6UgyWqfqYft8POC56zVm8EjnVLnmxdYxxsF44JCe9wv7e9VdteJLe+Cm0lLZkhHmCa1BiB+BIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941497; c=relaxed/simple;
	bh=CpkVqRsqTVYTWq8tJp8V8w4gjqmdJ7vzau4nV0SSUSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEtk4EWvQYqhTV00VQg9gBDx3Yu1cuQ4m538t0YXiGfP8wEvkSmY5oI9DHvfCP+h/RCNkuKNXJvlfgxXqco1skgz/P15IMTTDN9CIdHFZNdqy6X/vZ1zZFHzbHcSCT23MbcS1RqJOqLIl7ImRt2/UydfWFL7fG0X2/gwr5VIXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP1B1zeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8043C4CED2;
	Wed, 11 Dec 2024 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941497;
	bh=CpkVqRsqTVYTWq8tJp8V8w4gjqmdJ7vzau4nV0SSUSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nP1B1zeTtq2WQpdzNpH7g8de/SvkU7dtWRTf4JC2uvWovDASZrlgwlKi3zOOiHUzq
	 KjBFkhKJWiEInqNd3+qN9SbWPzoeS4HtWr1ehp+SIJ+Im5KN57hvEAsY9CbSV2CTc/
	 co9fHbGqk+6X52hvT42GUGULzBCuyiTU6rQn0ebY5CxrdGMulPY2SQr0Y7zCc7ok37
	 o4/sPmsS2l90CfcUGgj9mPmnLOFkecI/MwlwC4puQmXnHHc0/MeM/qmKWrWSG7OQyw
	 qMpKzrANMdda2XoA/esKuggYq3h131FpBQ+RmHO+gyn2bre5YpwBtPMl9ZQdxk5hhd
	 tOAwh01ElHdOw==
Date: Wed, 11 Dec 2024 10:24:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Bug when attempting to active swap file that used to be
 cloned/shared
Message-ID: <20241211182456.GF6678@frogsfrogsfrogs>
References: <CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com>

On Wed, Dec 11, 2024 at 02:49:08PM +0000, Filipe Manana wrote:
> Hello,
> 
> While looking at a btrfs bug where we fail to active a swap file that
> used to have shared extents, I noticed xfs has the same bug, however
> the test fails intermittently, suggesting some sort of race.

I bet swapon is racing with inodegc unmapping the extents from the
previously rm'd files.  The fix for this is (probably?) to call
xfs_inodegc_flush from xfs_iomap_swapfile_activate... though that might
be involved, since iirc at that point we hold the swapfile's IOLOCK.

--D

> The test is this:
> 
> root 11:03:31 /home/fdmanana/scripts/btrfs-bugs > cat swap-all-tests.sh
> #!/bin/bash
> 
> DEV=/dev/sdi
> MNT=/mnt/sdi
> NUM_CLONES=50
> 
> run_test()
> {
>     local sync_after_add_reflinks=$1
>     local sync_after_remove_reflinks=$2
> 
>    # mkfs.btrfs -f $DEV > /dev/null
>    mkfs.xfs -f $DEV > /dev/null
>    mount $DEV $MNT
> 
>    touch $MNT/foo
>    chmod 0600 $MNT/foo
>    # On btrfs the file must be NOCOW.
>    chattr +C $MNT/foo &> /dev/null
>    xfs_io -s -c "pwrite -b 1M 0 1M" $MNT/foo
>    mkswap $MNT/foo
> 
>    for ((i = 1; i <= $NUM_CLONES; i++)); do
>        touch $MNT/foo_clone_$i
>        chmod 0600 $MNT/foo_clone_$i
>       # On btrfs the file must be NOCOW.
>       chattr +C $MNT/foo_clone_$i &> /dev/null
>       cp --reflink=always $MNT/foo $MNT/foo_clone_$i
>    done
> 
>    if [ $sync_after_add_reflinks -ne 0 ]; then
>       # Flush delayed refs and commit current transaction.
>       sync -f $MNT
>    fi
> 
>    # Remove the original file and all clones except the last.
>    rm -f $MNT/foo
>    for ((i = 1; i < $NUM_CLONES; i++)); do
>       rm -f $MNT/foo_clone_$i
>    done
> 
>    if [ $sync_after_remove_reflinks -ne 0 ]; then
>       # Flush delayed refs and commit current transaction.
>       sync -f $MNT
>    fi
> 
>    # Now use the last clone as a swap file. It should work since
>    # its extent are not shared anymore.
>    swapon $MNT/foo_clone_${NUM_CLONES}
>    swapoff $MNT/foo_clone_${NUM_CLONES}
> 
>    umount $MNT
> }
> 
> echo -e "\nTest without sync after creating and removing clones"
> run_test 0 0
> 
> echo -e "\nTest with sync after creating clones"
> run_test 1 0
> 
> echo -e "\nTest with sync after removing clones"
> run_test 0 1
> 
> echo -e "\nTest with sync after creating and removing clones"
> run_test 1 1
> 
> 
> Running the test, it fails most of the time, but not always:
> 
> root 11:04:25 /home/fdmanana/scripts/btrfs-bugs > ./swap-all-tests.sh
> 
> Test without sync after creating and removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0013 sec (756.430 MiB/sec and 756.4297 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=5613cb28-3f3d-4530-a152-c98184e58e63
> 
> Test with sync after creating clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0028 sec (354.862 MiB/sec and 354.8616 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=da7932b0-0428-4318-82b1-d7a536daa066
> 
> Test with sync after removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0017 sec (586.510 MiB/sec and 586.5103 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=2ef8212c-64df-4bca-89fd-9ddadb7a824d
> 
> Test with sync after creating and removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0014 sec (672.495 MiB/sec and 672.4950 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=0d7a0bf3-081b-4069-a346-81f1a10ebdda
> root 11:04:29 /home/fdmanana/scripts/btrfs-bugs >
> 
> No failures above, great.
> 
> Running it again:
> 
> root 11:04:31 /home/fdmanana/scripts/btrfs-bugs > ./swap-all-tests.sh
> 
> Test without sync after creating and removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0019 sec (513.611 MiB/sec and 513.6107 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=9dbafcff-1270-419a-9677-f30f8ea78b18
> swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
> swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
> 
> Test with sync after creating clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0010 sec (969.932 MiB/sec and 969.9321 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=dae60c3d-524f-4be5-9d1c-4cfd6a968beb
> 
> Test with sync after removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0018 sec (548.847 MiB/sec and 548.8474 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=9d99061e-5675-414d-9067-c591eb6e3528
> 
> Test with sync after creating and removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0020 sec (488.520 MiB/sec and 488.5198 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=ff225f28-7e54-4045-8ba6-2c99df02eded
> root 11:04:34 /home/fdmanana/scripts/btrfs-bugs >
> 
> Only the first sub-test failed.
> 
> Running it once again:
> 
> root 11:04:35 /home/fdmanana/scripts/btrfs-bugs > ./swap-all-tests.sh
> 
> Test without sync after creating and removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0012 sec (803.859 MiB/sec and 803.8585 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=aeb8d730-f2c4-4adc-a59d-8047df74b75c
> 
> Test with sync after creating clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0018 sec (550.055 MiB/sec and 550.0550 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=d5b7d7eb-327c-4df8-a63f-c8d556d3a083
> swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
> swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
> 
> Test with sync after removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0017 sec (567.859 MiB/sec and 567.8592 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=22b26e8b-c1db-4e86-a39c-82df9b4f324c
> swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
> swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
> 
> Test with sync after creating and removing clones
> wrote 1048576/1048576 bytes at offset 0
> 1 MiB, 1 ops; 0.0019 sec (514.139 MiB/sec and 514.1388 ops/sec)
> Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
> no label, UUID=1becd3ea-a6a5-4245-92b9-f4ef4ad23afd
> swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
> swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
> root 11:04:39 /home/fdmanana/scripts/btrfs-bugs >
> 
> This time all sub-tests failed except the first one.
> 
> So just to let you know, as I was integrating the test into a generic
> test case for fstests.
> 
> Thanks.
> 

