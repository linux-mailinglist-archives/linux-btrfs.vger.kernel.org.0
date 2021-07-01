Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74123B96B9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhGATqb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 15:46:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGATqb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 15:46:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F12771FFE5;
        Thu,  1 Jul 2021 19:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625168639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlu/ZHcXkJfdTLpv5H/oQ1AU6mloYP89OGNkVNM7I+o=;
        b=FckHKZmOw7ELRgz9OjN2qmZSPrbTNfpvU++CXgAK7+ZTka3wbQA9M1emcK8I2Sh7ifrC9i
        JtLIDgCIFqa754JnDfd/2FB7hPq3qTx3GxKkndOdog4Z9oBaMjMyuik/lczRCIxtxa5Iio
        JnkNVnKLLMlBoVieihW1H8x0UoR+BJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625168639;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlu/ZHcXkJfdTLpv5H/oQ1AU6mloYP89OGNkVNM7I+o=;
        b=t9lC47uG95rYdkceAHtmGUgnP5qiZN9pJyw8ewk5rvuP4Ptj1ojQyFjw/+9AcgarrEkD9n
        1oo9kf+MXIWNJrCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EA65BA3B8B;
        Thu,  1 Jul 2021 19:43:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C2C1DA6FD; Thu,  1 Jul 2021 21:41:29 +0200 (CEST)
Date:   Thu, 1 Jul 2021 21:41:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: follow sectorsize for mixed mode
Message-ID: <20210701194129.GC2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210517095516.129287-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517095516.129287-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 17, 2021 at 05:55:16PM +0800, Qu Wenruo wrote:
> [BUG]
> When running fstests with 4K sectorsize and 64K page size (aka subpage
> support), the following tests failed:
> 
>   $ sudo ./check generic/416 generic/619
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/aarch64 rockpi4 5.12.0-rc8-custom+ #9 SMP Tue Apr 27 12:49:52 CST 2021
>   MKFS_OPTIONS  -- -s 4k /dev/mapper/arm_nvme-scratch1
>   MOUNT_OPTIONS -- /dev/mapper/arm_nvme-scratch1 /mnt/scratch
> 
>   generic/416     [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//generic/416.out.bad)
>      QA output created by 416
>     -wrote 16777216/16777216 bytes at offset 0
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/arm_nvme-scratch1, missing codepage or helper program, or other error.
>     +mount failed
>     +(see ~/xfstests-dev/results//generic/416.full for details)
>     ...
>     (Run 'diff -u ~/xfstests-dev/tests/generic/416.out ~/xfstests-dev/results//generic/416.out.bad'  to see the entire diff)
>   generic/619     [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//generic/619.out.bad)
>      QA output created by 619
>     -Silence is golden
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/arm_nvme-scratch1, missing codepage or helper program, or other error.
>     +mount failed
>     +(see ~/xfstests-dev/results//generic/619.full for details)
>     ...
>     (Run 'diff -u ~/xfstests-dev/tests/generic/619.out ~/xfstests-dev/results//generic/619.out.bad'  to see the entire diff)
>   Ran: generic/416 generic/619
>   Failures: generic/416 generic/619
>   Failed 2 of 2 tests
> 
> [CAUSE]
> Those two tests call _scratch_mkfs_sized to create a small fs, all of them
> are smaller than the 256M.
> 
> Since the fs is small, fstests choose to pass -M to make a mixed btrfs.
> (Let's just ignore whether we should pass -M here).

I think this is actually the problem, this should be fixed in fstests.

> 
> Then on 64K page size system, "mkfs.btrfs -s 4K -M -b 128M $dev" will fail

When --mixed is used, use both --sectorsize and --nodesize.

> with the following error message:
> 
>   btrfs-progs v5.11
>   See http://btrfs.wiki.kernel.org for more information.
> 
>   ERROR: illegal nodesize 65536 (not equal to 4096 for mixed block group)
> 
> This is caused by the nodesize selection, which always try to choose the
> larger value between pagesize and sectorsize.
> 
> This hardcoded PAGESIZE usage in mkfs.btrfs makes us to choose 64K
> nodesize even we specified to use 4K sectorsize.
> 
> [FIX]
> Just use sectorsize as nodesize when -M is specified.
> 
> With this fix, above two tests now pass for btrfs subpage case.

This is changing the mkfs behaviour for everybody just to fix a fstests
test case. I disagree to do that. Fstests get weekly releases so if the
test is failing now, it won't next week once a patch is applied.
