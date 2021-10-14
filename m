Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466B942DE3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJNPis (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhJNPir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:38:47 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1DC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:36:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h20so1351300qko.13
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=45xo9rqmAYWP2qEHB5+Is4HXN9Brc4pujm9eRf1osSo=;
        b=OvmWKo3o2hyAUNtp/QTgMW1/Jd7gUKFlTCa4gIlAMGF6UaZO6EmEJ/EISxPXh8wmv2
         O1wvIswhYA9ZLXmL+5IKvaRZ69R928EZbpARvGAre5/yNar8JtqudQBpm/3RWBywDSek
         FFKsEEozL/4b/rJejX6dC5FhYGHVEYcIonfDtBE7VvwtYBWinma/8bxggLOLFzeNyiMj
         gEk2x6tq4hHDxex+NrhoBaNw6I2CXHDJNISlAhyAZ4f+vdZLStOwYweI0sM4kpKW/Wa0
         0nmkiepmc6PDvamNKv/U9jh3k9O5N4fims37WEeFAKkDm8RnX91zTjbPelD69BA8HCTw
         G3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45xo9rqmAYWP2qEHB5+Is4HXN9Brc4pujm9eRf1osSo=;
        b=lYplN9xtDxrlmu5BO40/KZFCNLL092812d2lp7NPRuJsbQ2b1QqnViYlt0/JautcMf
         zdZRxSKTc1pqEBeOBAlzojvRjLBrSzt6YuVi9xvxFxSb1XACa1KpFGBCasb0/OsG0TDY
         Pa3y1Byy0cZdsKoz2gwrfOS3MwAAHHwW9cOksGTPvAY1g4rXE16g2gJs5Tvhd+Az85gn
         5SQuYfhicWkHSmwzxVtWzK6fxcj5O95je+g123otRmZa5aa5GdU17uAbMXRL9xfAC5bE
         wPZPg1TUD2CobdL2rPNQZfEuMu4vQuAYsBLOaoBJtM8LNJaZmX4Qpm9qfmk/qfvYtxg5
         8p+g==
X-Gm-Message-State: AOAM533ozEOfuX//p1DU4gtK0FbU9bi/TfiVyDBctpR8ExC1cgyYAkY/
        D96hJOMtnYnHUso8ktrRt3J13RscZl+7hQ==
X-Google-Smtp-Source: ABdhPJywVmlLq99N/nJct6ZeUYEfLF2/+SPsmAAafx+dXnuWxtA0Sw3i8UKbivXzHE1M+J7JqO1cPQ==
X-Received: by 2002:a05:620a:1709:: with SMTP id az9mr5748457qkb.191.1634225801898;
        Thu, 14 Oct 2021 08:36:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 16sm1484312qka.80.2021.10.14.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:36:41 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:36:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: test-misc: search the backup slot to use
 at runtime
Message-ID: <YWhOiG3rQvcbiys+@localhost.localdomain>
References: <20211013011233.9254-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013011233.9254-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 09:12:33AM +0800, Qu Wenruo wrote:
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
> ---
> Changelog:
> v2:
> - Use run_check() instead of manually redirect output to "$RESULT"
> - Quote "$main_root_ptr"
> ---
>  .../038-backup-root-corruption/test.sh        | 47 ++++++++++++-------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
> index b6c3671f2c3a..bf41f1e0952b 100755
> --- a/tests/misc-tests/038-backup-root-corruption/test.sh
> +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
> @@ -17,25 +17,35 @@ run_check $SUDO_HELPER touch "$TEST_MNT/file"
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
> -run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f generation "$TEST_DEV"
> +slot_num=$(echo $found | cut -f1 -d:)
> +# To follow the dump-super output, where backup slot starts at 0.
> +slot_num=$(($slot_num - 1))

What happens if we're on $slot_num == 0?  Seems like this would mess up, right?
Thanks,

Josef
