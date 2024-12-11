Return-Path: <linux-btrfs+bounces-10226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD89F9ECEFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1383B28361D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210E19E7FA;
	Wed, 11 Dec 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpgqfIak"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36F246342;
	Wed, 11 Dec 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928587; cv=none; b=t1Z1pyVS4jF/iCWTv8F1rsxfwxZTmT07NXYvgQ0o054O8c52jOKAtVJ7LV0K95bQVhgkcn0Ity2Q/8/YcR52vmPNOF+Pf6w7A3FFNhW+F3xeXHrtY0lMr4harxkDvyzwon5nQ3KF0NBbp0TuaY07syhcZVrN1YnKPSXy+6cMhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928587; c=relaxed/simple;
	bh=Y1ekCgDWMrwvXc+PddAC99Ydjo/qpjMD/CP1ePuHi2c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QkLMQiC82XVd1WY2ibzFLkGQe/Ipllpc55QOXTgg6ryFxGI73QZMn7n0Wmyndo1+mx+V+y1DsWpWABJWtgGg6bwW+TqNOEHqJyXFKJXGSe3TznTZVx/ENbSLD+Qmep2FRIfIBfpizJT/76zYShFTMFmroA5GdFFlQg/hHwZwQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpgqfIak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CA8C4CED2;
	Wed, 11 Dec 2024 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928586;
	bh=Y1ekCgDWMrwvXc+PddAC99Ydjo/qpjMD/CP1ePuHi2c=;
	h=From:Date:Subject:To:Cc:From;
	b=ZpgqfIak1353k+eSpVwOmwLWIz9wJXnjuofl5P7WQ13m1DFxE4ulGAUyA7vurryHJ
	 qEOP69PEWrlmkBIGHALu0Ql+63Y5orLznSqKXggKVupOp2VCI7YBOCktDXarYacmVK
	 JPFp0Bztz4PhC1/CHVrOGWIO6VZLLofV9yDjL5zf67Mh+upJEjn9kw8lR2BQ5SNvCs
	 Wahaf4inV2QB21fiwxry4dXvHpx1hb8u5ldDReZUc8jMwRI1aol0Y1FmKEu8DDc2Jk
	 ewfRrj0RCgOuLixWsGzvZBxkdiVoKHyG7f4OnUjFME4/L85RDBRk5roc65i3IeDQKF
	 iwifmtsHg7V2w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa66ead88b3so745464966b.0;
        Wed, 11 Dec 2024 06:49:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8qnzuu+1zwP28xQtBteGu4NKPkbCLIs8GNoCnx0f9gMp48MfV
	O1JF3JeSefm2TGBdIsx6r5eVbYb8ENn8156CtFnBT75qnvVfNi36kuzaklDmZ4ReKa52eOa53AG
	yxp84t2igJy4gv3D84cRQ5ejFjRM=
X-Google-Smtp-Source: AGHT+IHIF3yr3jU2f3fn3JqCzo9ZPiu/JNOFXlEfltvoSUxTcKUqE4ZET1VEEUsa5+OHvu2jpK3XcJomcvJBc/WK5HU=
X-Received: by 2002:a17:906:2932:b0:aa6:8b4a:46a0 with SMTP id
 a640c23a62f3a-aa6b13faabdmr319790266b.57.1733928584972; Wed, 11 Dec 2024
 06:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 11 Dec 2024 14:49:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com>
Message-ID: <CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com>
Subject: Bug when attempting to active swap file that used to be cloned/shared
To: xfs <linux-xfs@vger.kernel.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

While looking at a btrfs bug where we fail to active a swap file that
used to have shared extents, I noticed xfs has the same bug, however
the test fails intermittently, suggesting some sort of race.

The test is this:

root 11:03:31 /home/fdmanana/scripts/btrfs-bugs > cat swap-all-tests.sh
#!/bin/bash

DEV=/dev/sdi
MNT=/mnt/sdi
NUM_CLONES=50

run_test()
{
    local sync_after_add_reflinks=$1
    local sync_after_remove_reflinks=$2

   # mkfs.btrfs -f $DEV > /dev/null
   mkfs.xfs -f $DEV > /dev/null
   mount $DEV $MNT

   touch $MNT/foo
   chmod 0600 $MNT/foo
   # On btrfs the file must be NOCOW.
   chattr +C $MNT/foo &> /dev/null
   xfs_io -s -c "pwrite -b 1M 0 1M" $MNT/foo
   mkswap $MNT/foo

   for ((i = 1; i <= $NUM_CLONES; i++)); do
       touch $MNT/foo_clone_$i
       chmod 0600 $MNT/foo_clone_$i
      # On btrfs the file must be NOCOW.
      chattr +C $MNT/foo_clone_$i &> /dev/null
      cp --reflink=always $MNT/foo $MNT/foo_clone_$i
   done

   if [ $sync_after_add_reflinks -ne 0 ]; then
      # Flush delayed refs and commit current transaction.
      sync -f $MNT
   fi

   # Remove the original file and all clones except the last.
   rm -f $MNT/foo
   for ((i = 1; i < $NUM_CLONES; i++)); do
      rm -f $MNT/foo_clone_$i
   done

   if [ $sync_after_remove_reflinks -ne 0 ]; then
      # Flush delayed refs and commit current transaction.
      sync -f $MNT
   fi

   # Now use the last clone as a swap file. It should work since
   # its extent are not shared anymore.
   swapon $MNT/foo_clone_${NUM_CLONES}
   swapoff $MNT/foo_clone_${NUM_CLONES}

   umount $MNT
}

echo -e "\nTest without sync after creating and removing clones"
run_test 0 0

echo -e "\nTest with sync after creating clones"
run_test 1 0

echo -e "\nTest with sync after removing clones"
run_test 0 1

echo -e "\nTest with sync after creating and removing clones"
run_test 1 1


Running the test, it fails most of the time, but not always:

root 11:04:25 /home/fdmanana/scripts/btrfs-bugs > ./swap-all-tests.sh

Test without sync after creating and removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0013 sec (756.430 MiB/sec and 756.4297 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=5613cb28-3f3d-4530-a152-c98184e58e63

Test with sync after creating clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0028 sec (354.862 MiB/sec and 354.8616 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=da7932b0-0428-4318-82b1-d7a536daa066

Test with sync after removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0017 sec (586.510 MiB/sec and 586.5103 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=2ef8212c-64df-4bca-89fd-9ddadb7a824d

Test with sync after creating and removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0014 sec (672.495 MiB/sec and 672.4950 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=0d7a0bf3-081b-4069-a346-81f1a10ebdda
root 11:04:29 /home/fdmanana/scripts/btrfs-bugs >

No failures above, great.

Running it again:

root 11:04:31 /home/fdmanana/scripts/btrfs-bugs > ./swap-all-tests.sh

Test without sync after creating and removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0019 sec (513.611 MiB/sec and 513.6107 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=9dbafcff-1270-419a-9677-f30f8ea78b18
swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument

Test with sync after creating clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0010 sec (969.932 MiB/sec and 969.9321 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=dae60c3d-524f-4be5-9d1c-4cfd6a968beb

Test with sync after removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0018 sec (548.847 MiB/sec and 548.8474 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=9d99061e-5675-414d-9067-c591eb6e3528

Test with sync after creating and removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0020 sec (488.520 MiB/sec and 488.5198 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=ff225f28-7e54-4045-8ba6-2c99df02eded
root 11:04:34 /home/fdmanana/scripts/btrfs-bugs >

Only the first sub-test failed.

Running it once again:

root 11:04:35 /home/fdmanana/scripts/btrfs-bugs > ./swap-all-tests.sh

Test without sync after creating and removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0012 sec (803.859 MiB/sec and 803.8585 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=aeb8d730-f2c4-4adc-a59d-8047df74b75c

Test with sync after creating clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0018 sec (550.055 MiB/sec and 550.0550 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=d5b7d7eb-327c-4df8-a63f-c8d556d3a083
swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument

Test with sync after removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0017 sec (567.859 MiB/sec and 567.8592 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=22b26e8b-c1db-4e86-a39c-82df9b4f324c
swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument

Test with sync after creating and removing clones
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0019 sec (514.139 MiB/sec and 514.1388 ops/sec)
Setting up swapspace version 1, size = 1020 KiB (1044480 bytes)
no label, UUID=1becd3ea-a6a5-4245-92b9-f4ef4ad23afd
swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
root 11:04:39 /home/fdmanana/scripts/btrfs-bugs >

This time all sub-tests failed except the first one.

So just to let you know, as I was integrating the test into a generic
test case for fstests.

Thanks.

