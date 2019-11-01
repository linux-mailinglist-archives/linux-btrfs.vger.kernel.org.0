Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16436EC23C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 12:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfKALsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 07:48:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:44178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfKALsJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 07:48:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88B0FB090;
        Fri,  1 Nov 2019 11:48:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4FADEDA7AF; Fri,  1 Nov 2019 12:48:16 +0100 (CET)
Date:   Fri, 1 Nov 2019 12:48:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: tests: Test backup root retention logic
Message-ID: <20191101114815.GO3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191015154249.21615-1-nborisov@suse.com>
 <20191015154249.21615-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154249.21615-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 06:42:49PM +0300, Nikolay Borisov wrote:
> This tests ensures that the kernel correctly persists backup roots in
> case the filesystem has been mounted from a backup root.

The test does not work very well under a non-root user.

> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  .../misc-tests/038-backup-root-corruption/test.sh  | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100755 tests/misc-tests/038-backup-root-corruption/test.sh
> 
> diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
> new file mode 100755
> index 000000000000..2fb117b3a928
> --- /dev/null
> +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
> @@ -0,0 +1,50 @@
> +#!/bin/bash
> +# Test that a corrupted filesystem will correctly handle writing of 
> +# backup root
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +check_prereq btrfs-corrupt-block
> +

setup_root_helper

> +setup_loopdevs 1
> +prepare_loopdevs
> +dev=${loopdevs[1]}

You can use TEST_DEV and then all the common mkfs/mount/umount helpers
will work

> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev"
> +
> +# Create a file and unmount to commit some backup roots
> +run_check $SUDO_HELPER mount "$dev" "$TEST_MNT"
> +run_check touch "$TEST_MNT/file" && sync

'touch' is on the mounted fs, so it needs $SUDO_HELPER too

> +run_check $SUDO_HELPER umount "$TEST_MNT"
> +
> +# Ensure currently active backup slot is the expected one (slot 3)
> +backup2_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
> +	| grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
> +
> +main_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
> +	| grep root | head -n1 | awk '{print $2}')
> +
> +[[ "$backup2_root_ptr" -eq "$main_root_ptr" ]] || _fail "Backup slot 2 is not in use"
> +
> +run_check "$TOP/btrfs-corrupt-block" -m $main_root_ptr -f generation "$dev"
> +
> +## should fail because the root is corrupted

double ##

> +run_mustfail "Unexpected successful mount" $SUDO_HELPER mount "$dev" "$TEST_MNT"
> +
> +# Cycle mount with the backup to force rewrite of slot 3 
> +run_check $SUDO_HELPER mount -ousebackuproot "$dev" "$TEST_MNT"

run_check_mount_test_dev -o usebackuproot

> +run_check $SUDO_HELPER umount "$TEST_MNT"

run_check_umount_test_dev

> +
> +

two empty lines

> +# Since we've used backup 1 as the usable root, then backup 2 should have been 
> +# overwritten 

trailing whitespace (here and in several above as well)

> +main_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
> +	| grep root | head -n1 | awk '{print $2}')
> +backup2_new_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
> +	| grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
> +
> +[[ "$backup2_root_ptr" -ne "$backup2_new_root_ptr" ]] || _fail "Backup 2 not overwritten"
> +
> +cleanup_loopdevs
> -- 
> 2.7.4
