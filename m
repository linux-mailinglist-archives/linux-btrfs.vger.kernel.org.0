Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CED70699
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 19:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfGVROm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 13:14:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729058AbfGVROm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 13:14:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B0ACAF8C
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 17:14:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B715DA882; Mon, 22 Jul 2019 19:15:16 +0200 (CEST)
Date:   Mon, 22 Jul 2019 19:15:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] btrfs-progs: mkfs-tests: Skip 010-minimal-size if we
 can't mount with 4k sector size
Message-ID: <20190722171516.GC22308@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705072651.25150-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 05, 2019 at 03:26:49PM +0800, Qu Wenruo wrote:
> [BUG]
> Test case 010-minimal-size fails on aarch64 with 64K page size:
>       [TEST/mkfs]   010-minimal-size
>   failed: /home/adam/btrfs-progs/mkfs.btrfs -f -n 4k -m single -d single /home/adam/btrfs-progs/tests//test.img
>   test failed for case 010-minimal-size
>   make: *** [Makefile:361: test-mkfs] Error 1
> 
> [CAUSE]
> Mkfs.btrfs defaults to page size as sector size. However this test uses
> 4k, 16k, 32K and 64K as node size. 4K node size will conflict with 64K
> sector size.
> 
> [FIX]
> - Specify sector size 4K manually
>   So at least no conflict at mkfs time.
> 
> - Skip the test case if kernel can't mount with 4k sector size
>   So once we add such support, the test can be automatically re-enabled.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/mkfs-tests/010-minimal-size/test.sh | 41 ++++++++++++-----------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/mkfs-tests/010-minimal-size/test.sh b/tests/mkfs-tests/010-minimal-size/test.sh
> index 8480e4c5ae23..b49fad63e519 100755
> --- a/tests/mkfs-tests/010-minimal-size/test.sh
> +++ b/tests/mkfs-tests/010-minimal-size/test.sh
> @@ -5,6 +5,7 @@ source "$TEST_TOP/common"
>  
>  check_prereq mkfs.btrfs
>  check_prereq btrfs
> +check_prereq_mount_with_sectorsize 4096

How about

	if `getconf PAGE_SIZE` != 4096; then
		_not_run "requires 4k pages"
	fi

and be done?

I don't like hardcoding the sectorsize, the effect should be the same
when the test is skipped at the beginning.

When we have the subpage-size functionality, there will be an incompat
bit exported through sysfs that we can check. Until then the cude
pagesize check should do. It is going to be a big change so we'll have
to revisit all tests anyway.
