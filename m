Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A524A275A81
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIWOnl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 10:43:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOnk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 10:43:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600872218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=V67gGJHEhmj1IvQLwpgddc/4848yyJJ1QR5QmZAAjIA=;
        b=Q50ctA6g/mOt6h9IDbZ6/oc3MsApz+ZuIUfc+XrIGxKfi/qPqtNTbple0xTahrxRBaMzYg
        kA9AmMDOMMZ/pRQ/k30FCpN3yiIWXsGPvMOHjSmPDy5fBzQRkuIRIpp3pqa53a+8JWHNTE
        iLhf6rReIGAae6mW/cQD2FR0LMxk62A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34DD9B1DD;
        Wed, 23 Sep 2020 14:44:16 +0000 (UTC)
Subject: Re: [PATCH] btrfs: fix filesystem corruption after a device replace
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <09c4d27ac71d847fdc5a030a7d860610039d5332.1600871060.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9aa2e6af-3ebe-c653-d5a1-d26696499db0@suse.com>
Date:   Wed, 23 Sep 2020 17:43:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09c4d27ac71d847fdc5a030a7d860610039d5332.1600871060.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.09.20 г. 17:30 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We use a device's allocation state tree to track ranges in a device used
> for allocated chunks, and we set ranges in this tree when allocating a new
> chunk. However after a device replace operation, we were not setting the
> allocated ranges in the new device's allocation state tree, so that tree
> is empty after a device replace.
> 
> This means that a fitrim operation after a device replace will trim the
> device ranges that have allocated chunks and extents, as we trim every
> range for which there is not a range marked in the device's allocation
> state tree. It is also important during chunk allocation, since the
> device's allocation state is used to determine if a range is already
> allocated when allocating a new chunk.
> 
> This is trivial to reproduce and the following script triggers the bug:
> 
>   $ cat reproducer.sh
>   #!/bin/bash
> 
>   DEV1="/dev/sdg"
>   DEV2="/dev/sdh"
>   DEV3="/dev/sdi"
> 
>   wipefs -a $DEV1 $DEV2 $DEV3 &> /dev/null
> 
>   # Create a raid1 test fs on 2 devices.
>   mkfs.btrfs -f -m raid1 -d raid1 $DEV1 $DEV2 > /dev/null
>   mount $DEV1 /mnt/btrfs
> 
>   xfs_io -f -c "pwrite -S 0xab 0 10M" /mnt/btrfs/foo
> 
>   echo "Starting to replace $DEV1 with $DEV3"
>   btrfs replace start -B $DEV1 $DEV3 /mnt/btrfs
>   echo
> 
>   echo "Running fstrim"
>   fstrim /mnt/btrfs
>   echo
> 
>   echo "Unmounting filesystem"
>   umount /mnt/btrfs
> 
>   echo "Mounting filesystem in degraded mode using $DEV3 only"
>   wipefs -a $DEV1 $DEV2 &> /dev/null
>   mount -o degraded $DEV3 /mnt/btrfs
>   if [ $? -ne 0 ]; then
>           dmesg | tail
>           echo
>           echo "Failed to mount in degraded mode"
>           exit 1
>   fi
> 
>   echo
>   echo "File foo data (expected all bytes = 0xab):"
>   od -A d -t x1 /mnt/btrfs/foo
> 
>   umount /mnt/btrfs
> 
> When running the reproducer:
> 
>   $ ./replace-test.sh
>   wrote 10485760/10485760 bytes at offset 0
>   10 MiB, 2560 ops; 0.0901 sec (110.877 MiB/sec and 28384.5216 ops/sec)
>   Starting to replace /dev/sdg with /dev/sdi
> 
>   Running fstrim
> 
>   Unmounting filesystem
>   Mounting filesystem in degraded mode using /dev/sdi only
>   mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/sdi, missing codepage or helper program, or other error.
>   [19581.748641] BTRFS info (device sdg): dev_replace from /dev/sdg (devid 1) to /dev/sdi started
>   [19581.803842] BTRFS info (device sdg): dev_replace from /dev/sdg (devid 1) to /dev/sdi finished
>   [19582.208293] BTRFS info (device sdi): allowing degraded mounts
>   [19582.208298] BTRFS info (device sdi): disk space caching is enabled
>   [19582.208301] BTRFS info (device sdi): has skinny extents
>   [19582.212853] BTRFS warning (device sdi): devid 2 uuid 1f731f47-e1bb-4f00-bfbb-9e5a0cb4ba9f is missing
>   [19582.213904] btree_readpage_end_io_hook: 25839 callbacks suppressed
>   [19582.213907] BTRFS error (device sdi): bad tree block start, want 30490624 have 0
>   [19582.214780] BTRFS warning (device sdi): failed to read root (objectid=7): -5
>   [19582.231576] BTRFS error (device sdi): open_ctree failed
> 
>   Failed to mount in degraded mode
> 
> So fix by setting all allocated ranges in the replace target device when
> the replace operation is finishing, when we are holding the chunk mutex
> and we can not race with new chunk allocations.
> 
> A test case for fstests follows soon.
> 
> Fixes: 1c11b63eff2a67 ("btrfs: replace pending/pinned chunks lists with io tree")
> CC: stable@vger.kernel.org # 5.2+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---


Good catch!

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
