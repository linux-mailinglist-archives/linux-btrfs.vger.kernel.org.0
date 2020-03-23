Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5218FE67
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCWUBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 16:01:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCWUBq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 16:01:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A0F9AB6D;
        Mon, 23 Mar 2020 20:01:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 74AC5DA811; Mon, 23 Mar 2020 21:01:14 +0100 (CET)
Date:   Mon, 23 Mar 2020 21:01:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@gmail.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH RESEND v2 3/3] btrfs-progs: tests: add test for receiving
 clone from duplicate subvolume
Message-ID: <20200323200114.GP12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@gmail.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1583914311.git.osandov@fb.com>
 <999924f436ccad26b30f555ee106a131dff015c9.1583914311.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999924f436ccad26b30f555ee106a131dff015c9.1583914311.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 01:17:11AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This test case is the reproducer for the previous fix.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  .../test.sh                                   | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh
> 
> diff --git a/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh b/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh
> new file mode 100755
> index 00000000..be648605
> --- /dev/null
> +++ b/tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh
> @@ -0,0 +1,34 @@
> +#!/bin/bash
> +# Test that when receiving a subvolume whose received UUID already exists in
> +# the filesystem, we clone from the correct source (the subvolume that we are
> +# receiving, not the existing subvolume). This is a regression test for
> +# "btrfs-progs: receive: don't lookup clone root for received subvolume".
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq btrfs
> +check_prereq mkfs.btrfs
> +
> +setup_root_helper
> +
> +rm -f disk
> +run_check truncate -s 1G disk
> +chmod a+w disk
> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f disk
> +run_check $SUDO_HELPER mount -o loop disk "$TEST_MNT"

I don't see any special reason to use the loop device (like an
additional one to the default), so I think this should be fine using the
default image and the common helpers.


> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subvol"
> +run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/subvol/foo" \
> +	bs=1M count=1 status=none
> +run_check $SUDO_HELPER cp --reflink "$TEST_MNT/subvol/foo" "$TEST_MNT/subvol/bar"
> +run_check $SUDO_HELPER mkdir "$TEST_MNT/subvol/dir"
> +run_check $SUDO_HELPER mv "$TEST_MNT/subvol/foo" "$TEST_MNT/subvol/dir"
> +run_check $SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/subvol" ro true
> +run_check $SUDO_HELPER "$TOP/btrfs" send -f send.data "$TEST_MNT/subvol"
> +
> +run_check $SUDO_HELPER mkdir "$TEST_MNT/first" "$TEST_MNT/second"
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "$TEST_MNT/first"
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f send.data "$TEST_MNT/second"

All paths are inside $TEST_MNT, so a 'cd' into the directory would save
some typing. I'll fix it.
