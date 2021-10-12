Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8942A1B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhJLKO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 06:14:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42248 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhJLKO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 06:14:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2DFC620078;
        Tue, 12 Oct 2021 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634033574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsMQXgfUIwtzL8FJnJxL+txxF0WSLv0gHP6aujpuPx0=;
        b=txq80dHSmtxjl9RSCP609lvhEoudDkw03zyu9J43xMyPf1UkCcZUMAKwPjNYdsZ+saGFeb
        ZGAfUaEAlabdQaSGzuCA9o81n2120y6vASEadtt8Qv0bJeeBKeUZ3ftAImBXXJGxFBheoa
        Bn6LReBqDQbv25Kn2d53GcXeCSbXVnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634033574;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsMQXgfUIwtzL8FJnJxL+txxF0WSLv0gHP6aujpuPx0=;
        b=2u2EsSbCVOY1zNP/vs5yB1hFVnpB8Ow9BFs6lYV29N9NXu4pA5+rDhIoyZ22nRnCQxzjOW
        gYRuWv48aLOZdgCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 26B98A3B81;
        Tue, 12 Oct 2021 10:12:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79D8ADA781; Tue, 12 Oct 2021 12:12:30 +0200 (CEST)
Date:   Tue, 12 Oct 2021 12:12:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: test-misc: search the backup slot to use at
 runtime
Message-ID: <20211012101230.GV9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012083712.31592-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012083712.31592-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 04:37:12PM +0800, Qu Wenruo wrote:
> Test case misc/038 uses hardcoded backup slot number, this means if we
> change how many transactions we commit during mkfs, it will immediately
> break the tests.
> 
> Such hardcoded tests will be a big pain for later btrfs-progs updates.
> 
> Update it with runtime backup slot search.
> 
> Such search is done by using current filesystem generation as a search
> target and grab the slot number.
> 
> By this, no matter how many transactions we commit during mkfs, the test
> case should be able to handle it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks, that's the perfect solution.

>  .../038-backup-root-corruption/test.sh        | 45 ++++++++++++-------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
> index b6c3671f2c3a..315eac9a2904 100755
> --- a/tests/misc-tests/038-backup-root-corruption/test.sh
> +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
> @@ -17,24 +17,34 @@ run_check $SUDO_HELPER touch "$TEST_MNT/file"
>  run_check_umount_test_dev
>  
>  dump_super() {
> -	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
> +	# In this test, we will dump super block multiple times, while the
> +	# existing run_check*() helpers will always dump all the output into
> +	# the log, flooding the log and hide real important info.
> +	# Thus here we call "btrfs" directly.
> +	$SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
>  }
>  
> -# Ensure currently active backup slot is the expected one (slot 3)
> -backup2_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
> -
>  main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
> +# Grab current fs generation, and it will be used to determine which backup
> +# slot to use
> +cur_gen=$(dump_super | grep ^generation | awk '{print $2}')
> +backup_gen=$(($cur_gen - 1))
> +
> +# Grab the slot which matches @backup_gen
> +found=$(dump_super | grep backup_tree_root | grep -n "gen: $backup_gen")
>  
> -if [ "$backup2_root_ptr" -ne "$main_root_ptr" ]; then
> -	_log "Backup slot 2 not in use, trying slot 3"
> -	# Or use the next slot in case of free-space-tree
> -	backup3_root_ptr=$(dump_super | grep -A1 "backup 3" | grep backup_tree_root | awk '{print $2}')
> -	if [ "$backup3_root_ptr" -ne "$main_root_ptr" ]; then
> -		_fail "Neither backup slot 2 nor slot 3 are in use"
> -	fi
> -	_log "Backup slot 3 in use"
> +if [ -z "$found" ]; then
> +	_fail "Unable to find a backup slot with generation $backup_gen"
>  fi
>  
> +slot_num=$(echo $found | cut -f1 -d:)
> +# To follow the dump-super output, where backup slot starts at 0.
> +slot_num=$(($slot_num - 1))
> +
> +# Save the backup slot info into the log
> +_log "Backup slot $slot_num will be utilized"
> +dump_super | grep -A9 "backup $slot_num:" >> "$RESULTS"

Please don't use the $RESULTS in tests, it's an implementation detail
and there should always be helpers hiding, in this case it's run_check.

> +
>  run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f generation "$TEST_DEV"
                                                    ^^^^^^^^^^^^^^

Please always quote variables (unless there's a reason not to like for
$SUDO_HELPER).

>  
>  # Should fail because the root is corrupted
> @@ -45,9 +55,10 @@ run_mustfail "Unexpected successful mount" \
>  run_check_mount_test_dev -o usebackuproot
>  run_check_umount_test_dev
>  
> -# Since we've used backup 1 as the usable root, then backup 2 should have been
> -# overwritten
> -main_root_ptr=$(dump_super | grep root | head -n1 | awk '{print $2}')
> -backup2_new_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
> +main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
> +
> +# The next slot should be overwritten
> +slot_num=$(( ($slot_num + 1) % 4 ))
> +backup_new_root_ptr=$(dump_super | grep -A1 "backup $slot_num" | grep backup_tree_root | awk '{print $2}')
>  
> -[ "$backup2_root_ptr" -ne "$backup2_new_root_ptr" ] || _fail "Backup 2 not overwritten"
> +[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
> -- 
> 2.33.0
