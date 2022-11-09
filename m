Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08C962291D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 11:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKIKxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 05:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiKIKwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 05:52:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2800201A7;
        Wed,  9 Nov 2022 02:52:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C690B81D8F;
        Wed,  9 Nov 2022 10:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9040C433D6;
        Wed,  9 Nov 2022 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667991144;
        bh=G861l9p3Erm/WgZA9W/8nMIuYeSl9dweiVME3EmP3oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6dNl8+R7qVB6BruCuSflgySsFMR/KcUyRxHmKvybW+dFjxk43aZ4gBo1mpR5eJqw
         FdQpDEn+BLaixqSQ708q0CjT+aTIg97WFkkCK6I+7VTG6zXE7pNcVsLZWicIV+YggE
         RRkGduw8bYlOkbRzg4Oa9B73m59D0LK5wIOCOOY6j7HAR0Wib2ziRvh1I8G9d8tJc7
         Pj7U/OkcrJY3E1p5Mgpd8cXUNM/i934rE61kEaEdt7h7kvaxY8HWm4O8d6gBxfI0c9
         f5Dby7wt+jgA1AkiNOS6VBTp5hRiGvWzg8HZ/ZSPCbdK0z8jd/2lTnxnlQ2wXYedlK
         xNSjEOfZJTBvQ==
Date:   Wed, 9 Nov 2022 10:52:21 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: filter.btrfs: handle detailed missing device
 report better
Message-ID: <20221109105221.GA3904993@falcondesktop>
References: <20221109062236.42253-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109062236.42253-1-wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 09, 2022 at 02:22:36PM +0800, Qu Wenruo wrote:
> [FAILURES]
> The following btrfs test cases failed with newer btrfs-progs:
> 
> - btrfs/197
> - btrfs/198
> - btrfs/254
> 
> They all fail due to output mismatch like the following:
> 
>      Label: none  uuid: <UUID>
>      	Total devices <NUM> FS bytes used <SIZE>
>      	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>     -	*** Some devices missing
>     +	devid <DEVID> size 0 used 0 path  MISSING
> 
> [CAUSE]
> Since btrfs-progs commit 957a79c9b016 ("btrfs-progs: fi show: print
> missing device for a mounted file system"), we output the detailed info
> of a missing device if "btrfs filesystem show" is executed using
> "-m <mnt>" option.
> 
> Such detailed output no longer follows the old format, thus causing the
> output mismatch.
> 
> [FIX]
> Update _filter_btrfs_filesystem_show() to handle detailed missing
> device by:
> 
> - Buffer the output first
> 
> - Output the first two lines
>   Which is always label/uuid and the total device accounting.
> 
> - Replace the detailed missing device line with old output
> 
> - Sort (in reverse order) and uniq the device list
> 
> By this we can handle both old and new output correctly.
> Although this means we lacks the ability to detect mutltiple missing
> devices, thankfully the involved test cases are not checking this yet.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/filter.btrfs | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index d4169cc6..c570d366 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -35,7 +35,17 @@ _filter_btrfs_filesystem_show()
>  	_filter_size | _filter_btrfs_version | _filter_devid | \
>  	_filter_zero_size | \
>  	sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
> -	uniq
> +	uniq > $tmp.btrfs_filesystem_show
> +
> +	# The first two lines are Label/UUID and total devices
> +	head -n 2 $tmp.btrfs_filesystem_show
> +
> +	# The remaining is the device list, first filter out the detailed
> +	# missing device to the generic one.
> +	# Then sort and uniq the result
> +	tail -n +3 $tmp.btrfs_filesystem_show | \
> +	sed -e "s/devid <DEVID> size 0 used 0 path  MISSING/*** Some devices missing/" | \
> +	sort -r | uniq

Ah, I had updated to btrfs-progs 6.0 last week, and was wondering how
was it possible no one had fixed this before - either no one is testing
with 5.19+ or no one cares.

It looks good to me, and it works for me.

I had a local patch here as well, but you beat me to it.
My version is based on awk only, no sorting needed:

diff --git a/common/filter.btrfs b/common/filter.btrfs
index d4169cc6..a27a7276 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -30,11 +30,22 @@ _filter_btrfs_filesystem_show()
                UUID=$2
        fi
 
-       # the uniq collapses all device lines into 1
+       # The awk script converts between the output format of btrfs-progs 5.19+
+       # to the output format of older versions when there are missing devices.
+       # That format changed in the btrfs-progs commit:
+       #
+       #   957a79c9b016 ("btrfs-progs: fi show: print missing device for a mounted file system")
+       #
+       # The uniq at the end collapses all device lines into 1.
        _filter_uuid $UUID | _filter_scratch | _filter_scratch_pool | \
        _filter_size | _filter_btrfs_version | _filter_devid | \
        _filter_zero_size | \
        sed -e "s/\(Total devices\) $NUMDEVS/\1 $NUM_SUBST/g" | \
+       $AWK_PROG -e 'BEGIN { missing = 0 }' \
+                 -e '/\sMISSING$/ { missing = 1 }' \
+                 -e '/^\s*$/ { next }' \
+                 -e '!/\sMISSING$/ { print }' \
+                 -e 'END { if (missing) print "\t*** Some devices missing\n" }' | \
        uniq
 }

Either way, it looks good to me, thanks!

Reviewed-by: Filipe Manana <fdmanana@suse.com>


>  }
>  
>  # This eliminates all numbers, and shows only unique lines,
> -- 
> 2.38.0
> 
