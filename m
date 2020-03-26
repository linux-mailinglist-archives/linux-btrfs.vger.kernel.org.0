Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE0194374
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 16:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgCZPqn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 11:46:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgCZPqn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 11:46:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CF88AC0C;
        Thu, 26 Mar 2020 15:46:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F480DA730; Thu, 26 Mar 2020 16:46:10 +0100 (CET)
Date:   Thu, 26 Mar 2020 16:46:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: fix misc-test/029 provide device for
 mount
Message-ID: <20200326154609.GH5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1585125129-11224-1-git-send-email-anand.jain@oracle.com>
 <1585125129-11224-2-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585125129-11224-2-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 25, 2020 at 04:32:09PM +0800, Anand Jain wrote:
> The mount fails with 'file exists' error. Fix it by providing the device
> name.

Can you be more specific about the environment where it fails? The test
passes for me.

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/misc-tests/029-send-p-different-mountpoints/test.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/misc-tests/029-send-p-different-mountpoints/test.sh b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
> index a478b3d26495..e34402d9ec06 100755
> --- a/tests/misc-tests/029-send-p-different-mountpoints/test.sh
> +++ b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
> @@ -19,8 +19,10 @@ run_mayfail $SUDO_HELPER mkdir -p "$SUBVOL_MNT" ||
>  run_check_mkfs_test_dev
>  run_check_mount_test_dev
>  
> +# The sed part is to replace double forward-slash with single forward-slash
> +lodev=$(losetup  | grep $(echo $TEST_DEV | sed 's/\/\//\//') | awk '{print $1}')

There's a simpler way to canonicalize a path, eg using readlink or
realpath.

And I don't see why would two slashes appear in a path. IIRC a path
starting with two slashes is standardized as a network path and
recognized by VFS but why this is a concern for the testsuite?
