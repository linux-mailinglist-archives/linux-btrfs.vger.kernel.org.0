Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034E52A349
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbiEQNY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 09:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347647AbiEQNY4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 09:24:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC6543496;
        Tue, 17 May 2022 06:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05BFFB818A1;
        Tue, 17 May 2022 13:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3BDC385B8;
        Tue, 17 May 2022 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652793891;
        bh=ePi+UIoTM2O8DaDc41FoXuIPGMY2KQZdC3cIVuAYEBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPOvilL2VfTnSYQpFTfYmEZqrxyzLhOugzq06ZpX+TPc2WIQQjyErsJQwHOujPwPD
         ScevPGL2q6HLvv1Yt+YjsxyaHAGaVK6hJrhoLNblmmC52N9aXZ4PODb3g73QnGETzY
         iaPYGynD7EMZnjOXOueIPGywARj+FYFmTP4kOyEOrJquyQuCzmpvtV2He92ZxBMbfy
         Qwjp8fM8dKmuu7mpxJK78lXHhijgrc30UAUZpDtyJ8hHehD8hmo4pDd2NgvqisJcti
         PH2LqQyu0rmwm6a0AdvMr2y48yzwu+bANB0RAdFfrxGISVkxaE3+RE4kmY3OVeEuhl
         nQypJIjdI7Bjw==
Date:   Tue, 17 May 2022 14:24:48 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: add a btrfs read_repair group
Message-ID: <20220517132448.GA2626143@falcondesktop>
References: <20220517063502.3017563-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517063502.3017563-1-hch@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 08:35:02AM +0200, Christoph Hellwig wrote:
> Add a new group to run all tests the exercise the btrfs read_repair code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good to me as well, thanks.

> ---
>  doc/group-names.txt | 1 +
>  tests/btrfs/140     | 2 +-
>  tests/btrfs/141     | 2 +-
>  tests/btrfs/142     | 2 +-
>  tests/btrfs/143     | 2 +-
>  tests/btrfs/150     | 2 +-
>  tests/btrfs/157     | 2 +-
>  tests/btrfs/215     | 2 +-
>  8 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index e8e3477e..ef411b5e 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -88,6 +88,7 @@ punch			fallocate FALLOC_FL_PUNCH_HOLE
>  qgroup			btrfs qgroup feature
>  quota			filesystem usage quotas
>  raid			btrfs RAID
> +read_repair		btrfs error correction on read failure
>  realtime		XFS realtime volumes
>  recoveryloop		crash recovery loops
>  redirect		overlayfs redirect_dir feature
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index 66efc126..c680fe0a 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -12,7 +12,7 @@
>  #	commit 2e949b0a5592 ("Btrfs: fix invalid dereference in btrfs_retry_endio")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index ca164fdc..9fdcb2ab 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -13,7 +13,7 @@
>  #	Commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index c88cace9..58d01add 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -13,7 +13,7 @@
>  #	commit 97bf5a5589aa ("Btrfs: fix segmentation fault when doing dio read")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 8f086ee8..71db861d 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -20,7 +20,7 @@
>  #	commit 9d0d1c8b1c9d ("Btrfs: bring back repair during read")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/150 b/tests/btrfs/150
> index 986c8069..c5e9c709 100755
> --- a/tests/btrfs/150
> +++ b/tests/btrfs/150
> @@ -11,7 +11,7 @@
>  #	Btrfs: fix kernel oops while reading compressed data
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dangerous
> +_begin_fstest auto quick dangerous read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index ae56f3e1..343178b7 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -21,7 +21,7 @@
>  # Btrfs: make raid6 rebuild retry more
>  #
>  . ./common/preamble
> -_begin_fstest auto quick raid
> +_begin_fstest auto quick raid read_repair
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index cbcd60e0..0dcbce2a 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -9,7 +9,7 @@
>  # 814723e0a55a ("btrfs: increment device corruption error in case of checksum error")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick read_repair
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.30.2
> 
