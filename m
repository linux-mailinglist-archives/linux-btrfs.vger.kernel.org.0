Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14703EC2A7
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 13:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfKAMVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 08:21:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbfKAMVK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 08:21:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC9CBB308;
        Fri,  1 Nov 2019 12:21:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE8D5DA7AF; Fri,  1 Nov 2019 13:21:17 +0100 (CET)
Date:   Fri, 1 Nov 2019 13:21:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: tests: Test backup root retention logic
Message-ID: <20191101122117.GP3001@twin.jikos.cz>
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
> 
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
> +setup_loopdevs 1
> +prepare_loopdevs
> +dev=${loopdevs[1]}

And the loop devices are not necessary at all

prepare_device

and be done.
> +
> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev"
> +
> +# Create a file and unmount to commit some backup roots
> +run_check $SUDO_HELPER mount "$dev" "$TEST_MNT"
> +run_check touch "$TEST_MNT/file" && sync

sync is not necessary when it's followed by umount, besides that it
syncs all fileystems so it's an unnecessary slowdown

> +run_check $SUDO_HELPER umount "$TEST_MNT"
> +
> +# Ensure currently active backup slot is the expected one (slot 3)
> +backup2_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \

this should use run_check_stdout so we have the full output logged, as
the inspect-part is called several times I added a helper for that.

> +	| grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
> +
> +main_root_ptr=$($SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$dev" \
> +	| grep root | head -n1 | awk '{print $2}')
> +
> +[[ "$backup2_root_ptr" -eq "$main_root_ptr" ]] || _fail "Backup slot 2 is not in use"

[[ ]] is not necessary when it's a simple check that [ ] can do

All fixed and pushed.
