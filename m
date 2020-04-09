Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BD1A37EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Apr 2020 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDIQYT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 12:24:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDIQYS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 12:24:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7532AB7F;
        Thu,  9 Apr 2020 16:24:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1CB0DDA70B; Thu,  9 Apr 2020 18:23:41 +0200 (CEST)
Date:   Thu, 9 Apr 2020 18:23:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH v3 4/4] btrfs-progs: fix misc-test/029 provide device for
 mount
Message-ID: <20200409162340.GE5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
 <1585879843-17731-5-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585879843-17731-5-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 10:10:43AM +0800, Anand Jain wrote:
> The mount fails with 'file exists' error. Fix it by providing the device
> name.
> 
> $ make TEST=029\* test-misc
>     [TEST]   misc-tests.sh
>     [TEST/misc]   029-send-p-different-mountpoints
> failed: mount -t btrfs -o subvol=subv1 /btrfs-progs/tests//test.img /btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
> test failed for case 029-send-p-different-mountpoints
> make: *** [test-misc] Error 1
> 
> ====== RUN CHECK mount -t btrfs -o subvol=subv1
> /btrfs-progs/tests//test.img
> /btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
> mount: mount /dev/loop1 on
> /btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
> failed: File exists
> failed: mount -t btrfs -o subvol=subv1 /btrfs-progs/tests//test.img
> /btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
> test failed for case 029-send-p-different-mountpoints
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: use readlink to sanitize the TEST_DEV path
> v3: readlink for TEST_DEV is not needed drop it
> 
>  tests/misc-tests/029-send-p-different-mountpoints/test.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/misc-tests/029-send-p-different-mountpoints/test.sh b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
> index a478b3d26495..b05e4172ca0f 100755
> --- a/tests/misc-tests/029-send-p-different-mountpoints/test.sh
> +++ b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
> @@ -20,7 +20,8 @@ run_check_mkfs_test_dev
>  run_check_mount_test_dev
>  
>  run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
> -run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$TEST_DEV" "$SUBVOL_MNT"
> +lodev=$(losetup  | grep ${TEST_DEV} | awk '{print $1}')
> +run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$lodev" "$SUBVOL_MNT"

The test dev is not necessarily a loop device, yes by default it is, but
TEST_DEV can be set externally.

I still wonder why the test fails for you because it does not for me and
without more information it's not clear what is mount reporting as
'File exists', which is EEXIST.
