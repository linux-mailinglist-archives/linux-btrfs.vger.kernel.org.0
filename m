Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A778636F0BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbhD2UBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 16:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:56000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237065AbhD2T7m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 15:59:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21DBBADE2;
        Thu, 29 Apr 2021 19:58:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF92EDA7D2; Thu, 29 Apr 2021 21:56:31 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:56:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs-progs: misc-tests: add test to ensure the
 restored image can be mounted
Message-ID: <20210429195631.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210429090658.245238-1-wqu@suse.com>
 <20210429090658.245238-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429090658.245238-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 05:06:58PM +0800, Qu Wenruo wrote:
> This new test case is to make sure the restored image file has been
> properly enlarged so that newer kernel won't complain.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  .../048-image-restore-mount/test.sh           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100755 tests/misc-tests/048-image-restore-mount/test.sh
> 
> diff --git a/tests/misc-tests/048-image-restore-mount/test.sh b/tests/misc-tests/048-image-restore-mount/test.sh
> new file mode 100755
> index 000000000000..b61b7a7188cf
> --- /dev/null
> +++ b/tests/misc-tests/048-image-restore-mount/test.sh
> @@ -0,0 +1,20 @@
> +#!/bin/bash
> +# Verify that the restored image of an empty btrfs filesystem can still be
> +# mounted
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq btrfs-image
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +
> +tmp=$(mktemp -d --tmpdir btrfs-progs-image.XXXXXXXX)
> +prepare_test_dev
> +
> +run_check_mkfs_test_dev
> +run_check "$TOP/btrfs-image" "$TEST_DEV" "$tmp/dump"
> +run_check "$TOP/btrfs-image" -r "$tmp/dump" "$tmp/restored"
> +
> +run_check $SUDO_HELPER mount -t btrfs -o loop "$tmp/restored" "$TEST_MNT"
> +umount "$TEST_MNT" &> /dev/null

Please note that unlike in fstests, the progs testsuite is intentionally
verbose and the command output should end up in the logs, and all main
commands should be started with run_check (in this case with
$SUDO_HELPER as well).
