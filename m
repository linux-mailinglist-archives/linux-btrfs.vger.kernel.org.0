Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED29D4AE68D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 03:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbiBICj0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 21:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiBIA5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 19:57:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D920C061576;
        Tue,  8 Feb 2022 16:57:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17761B81DFB;
        Wed,  9 Feb 2022 00:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAC8C004E1;
        Wed,  9 Feb 2022 00:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644368259;
        bh=WKjMz3C2izhb5FxYAIc2tH2kyERhNtSOvEl7mWdmV2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3QlMk0Yb7/HzInM4jvTr6i9Q5aUXB/qiwQcYMEj6rBd45bszwJHnWLYdkDlBOj3A
         pn3AVL7xwGZbyDrIyxMUypo5/PuA70WDly+ZjgAWtj6Glaa9dKD/Ca52MHoqXuNdaU
         fselYAtCRtLM5+d++ba++yM6+z6IVy7Cz2BOH1Xy48xhDej4nzxDIdtRR2msSdZC6O
         feZaFna6qKoljZVVIy5jpiWfJoPoI+pqA9LeByothYE3OkT3v8xLE1pns/wlufhFH1
         8DeH9Ism+l6Sp5KkqRXaN4mVZZ3Ur7MliLN76R+73EPzCprBxvucKVAzozxBsRN9sc
         Rol+WyWW6uDfw==
Date:   Tue, 8 Feb 2022 16:57:39 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 7/7] generic/204: do xfs unique preparation only for xfs
Message-ID: <20220209005739.GF8288@magnolia>
References: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
 <20220207030958.230618-8-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207030958.230618-8-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 07, 2022 at 12:09:58PM +0900, Shin'ichiro Kawasaki wrote:
> The test case generic/204 formats the scratch device to get block size
> as a part of preparation. However, this preparation is required only for
> xfs. To simplify preparation for other filesystems, do the preparation
> only for xfs.
> 
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/generic/204 | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index 40d524d1..ea267760 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -16,17 +16,18 @@ _cleanup()
>  	sync
>  }
>  
> -# Import common functions.
> -. ./common/filter
> -
>  # real QA test starts here
>  _supported_fs generic
>  
>  _require_scratch
>  
> -# get the block size first
> -_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
> -. $tmp.mkfs
> +dbsize=4096
> +isize=256
> +if [ $FSTYP = "xfs" ]; then
> +	# get the block size first
> +	_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
> +	. $tmp.mkfs
> +fi
>  
>  # For xfs, we need to handle the different default log sizes that different
>  # versions of mkfs create. All should be valid with a 16MB log, so use that.
> @@ -37,11 +38,15 @@ _scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
>  SIZE=`expr 115 \* 1024 \* 1024`
>  _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
>  	|| _fail "mkfs failed"

Getting back to why generic/204 calls mkfs twice --

The first time is to get dbsize (aka the data block size) and the inode
size.  AFAICT neither mkfs call add any mkfs options that would change
the block size, so I wonder why we need the first call at all?

Would the following work for g/204, assuming that _filter_mkfs some day
provides correct output for dbsize and isize?

_require_scratch

# For xfs, we need to handle the different default log sizes that
# different versions of mkfs create. All should be valid with a 16MB
# log, so use that.  And v4/512 v5/1k xfs don't have enough free inodes,
# set imaxpct=50 at mkfs time solves this problem.
[ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"

SIZE=`expr 115 \* 1024 \* 1024`
_scratch_mkfs_sized $SIZE 2> /dev/null > $tmp.mkfs.raw || \
	_fail "mkfs failed"

cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
_scratch_mount

# Source $tmp.mkfs to get geometry
. $tmp.mkfs

--D

> -cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
> +
> +if [ $FSTYP = "xfs" ]; then
> +	cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
> +	# Source $tmp.mkfs to get geometry
> +	. $tmp.mkfs
> +fi
> +
>  _scratch_mount
>  
> -# Source $tmp.mkfs to get geometry
> -. $tmp.mkfs
>  
>  # fix the reserve block pool to a known size so that the enospc calculations
>  # work out correctly. Space usages is based 22500 files and 1024 reserved blocks
> -- 
> 2.34.1
> 
