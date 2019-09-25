Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2CBE346
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502211AbfIYRUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 13:20:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:60452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732997AbfIYRUR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 13:20:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E915CADBB;
        Wed, 25 Sep 2019 17:20:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50B66DA7D7; Wed, 25 Sep 2019 19:20:36 +0200 (CEST)
Date:   Wed, 25 Sep 2019 19:20:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH v5 7/7] btrfs-progs: add test override for mkfs to
 use different checksums
Message-ID: <20190925172036.GK2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190925133728.18027-1-jthumshirn@suse.de>
 <20190925133728.18027-8-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925133728.18027-8-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 03:37:28PM +0200, Johannes Thumshirn wrote:
> Similar to check's test overrides add an override for mkfs tests so we can
> specify different mkfs flags.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  tests/common                                | 10 ++++++++--
>  tests/mkfs-tests/001-basic-profiles/test.sh |  8 +++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/common b/tests/common
> index 75e5540155cc..5148820bef58 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -473,16 +473,22 @@ prepare_test_dev()
>  # $1-$n: optional, default is -f
>  run_check_mkfs_test_dev()
>  {
> +	MKFS_ARGS="$@"
> +
>  	setup_root_helper
>  
>  	# check accidental files/devices passed
> -	for opt in "$@"; do
> +	for opt in "$MKFS_ARGS"; do
>  		if [ -f "$opt" -o -b "$opt" ]; then
>  			_fail "ERROR: unexpected option for run_check_mkfs_test_dev: device"
>  		fi
>  	done
>  
> -	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$@" "$TEST_DEV"
> +	if [ "$TEST_ENABLE_OVERRIDE" = 'true' ]; then
> +		MKFS_ARGS="$TEST_ARGS_MKFS $MKFS_ARGS"
> +	fi
> +
> +	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$MKFS_ARGS" "$TEST_DEV"
>  }
>  
>  run_check_mount_test_dev()
> diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
> index 6e295274119d..e0110c722555 100755
> --- a/tests/mkfs-tests/001-basic-profiles/test.sh
> +++ b/tests/mkfs-tests/001-basic-profiles/test.sh
> @@ -21,7 +21,13 @@ test_get_info()
>  }
>  test_do_mkfs()
>  {
> -	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$@"
> +	MKFS_ARGS="$@"
> +
> +	if [ "$TEST_ENABLE_OVERRIDE" = 'true' ]; then
> +		MKFS_ARGS="$TEST_ARGS_MKFS $MKFS_ARGS"
> +	fi
> +
> +	run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$MKFS_ARGS"

This is supposed to be transparent for all tests, so all the override
happens inside tests/common in _cmd_spec, so all what's needed is to add
a line to the 'case'.
