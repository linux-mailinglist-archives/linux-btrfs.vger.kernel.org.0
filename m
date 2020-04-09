Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3C371A380E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgDIQaY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 12:30:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgDIQaY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 12:30:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5EFEAC53;
        Thu,  9 Apr 2020 16:30:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 267AFDA70B; Thu,  9 Apr 2020 18:29:46 +0200 (CEST)
Date:   Thu, 9 Apr 2020 18:29:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH 3/4] btrfs-progs: test clean start after failures
Message-ID: <20200409162945.GF5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
 <1585879843-17731-4-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585879843-17731-4-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 10:10:42AM +0800, Anand Jain wrote:
> After a failure it fails for a different reason
> 
> === START TEST
> /btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints
> $TEST_DEV not given, using /btrfs-progs/tests/test.img as fallback
> ====== RUN MAYFAIL mkdir -p
> /btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
> ====== RUN CHECK /btrfs-progs/mkfs.btrfs -f /btrfs-progs/tests/test.img
> ERROR: /btrfs-progs/tests/test.img is mounted <====
> 
> Add clean_start() helper to unmount.

The testsuite is designed to stop on first failure and it's up the user
to investigate and clean it up before starting it again. For that
there's the test-clean make target. In some cases it might not clean up
the environment completely, but that's typically if the test image is
not unmoutnable due to some process having the directory open.

> +# add all the cleanups here
> +clean_start()
> +{
> +	grep -q $TEST_MNT /proc/self/mounts && umount $TEST_MNT
> +}
> +
>  init_env()
>  {
>  	TEST_MNT="${TEST_MNT:-$TEST_TOP/mnt}"
> diff --git a/tests/misc-tests.sh b/tests/misc-tests.sh
> index 3b49ab012e78..3dc96f258540 100755
> --- a/tests/misc-tests.sh
> +++ b/tests/misc-tests.sh
> @@ -40,6 +40,7 @@ export IMAGE
>  export TEST_DEV
>  
>  rm -f "$RESULTS"
> +clean_start

Instead of this I'd rather make it a hard stop if there's some problem
with the environment, like the mountpoint still mounted, or more loop
devices from the specific tests still set up as loop devices etc.

When I get to this situation I fix it manually (checkint mount output,
losetup -D), but it'd be nice to have that automated.
