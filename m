Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC385FB9CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJKRiz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJKRiq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 13:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2739CE7D;
        Tue, 11 Oct 2022 10:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B80B16121B;
        Tue, 11 Oct 2022 17:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAC2C433C1;
        Tue, 11 Oct 2022 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665509924;
        bh=zbRvJJ+Yd7aNm53rXlfDNWX/5TvA5nk7hw1lgPskbvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2gl4ePviRvWrCNWhrgDV4QOy7iGD7btzrk1eD43Qbb0iIOozSBjYkT9eqMLCHQ13
         10Pj1Hjci/red8pakdb1KkL9I7BCtzxfxgLUfsFiquKq1QQbJHWzZxiLteQgiScUDr
         64ey80z8+soR63+rKy52wjyzNg3RyKZs+ijauPT0oefqoqzQX8zLVokToein4983v0
         Pdp4X5mTO19KU7rAxynF7pgFnYA5PA+xXBgIxGFyULV60JuAOi+/c6RprsmpuRuz0o
         li7O2HE+D7byUp+qzjDyGgDcZHDEOatZYG7G8uRUrGXMxb1xCveXdMqODSQVBCt1c+
         I06RhnpciGHxg==
Date:   Tue, 11 Oct 2022 10:38:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/3] fstests: add missing require of xfs_io fiemap
 command to some tests
Message-ID: <Y0WqI0D3SAZYzcBM@magnolia>
References: <cover.1665150613.git.fdmanana@suse.com>
 <f10f9fb7fe2ba35d651150f891aec3d996731a96.1665150613.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10f9fb7fe2ba35d651150f891aec3d996731a96.1665150613.git.fdmanana@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 07, 2022 at 02:53:35PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs/257, btrfs/258, btrfs/259 and xfs/443 use the fiemap command of
> xfs_io but don't do a '_require_xfs_io_command "fiemap"'. So add the
> missing requirement.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Yep
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/btrfs/257 | 1 +
>  tests/btrfs/258 | 1 +
>  tests/btrfs/259 | 1 +
>  tests/xfs/443   | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/tests/btrfs/257 b/tests/btrfs/257
> index 3092495f..87f9e0b2 100755
> --- a/tests/btrfs/257
> +++ b/tests/btrfs/257
> @@ -33,6 +33,7 @@ _require_btrfs_no_compress
>  # Needs 4K sectorsize
>  _require_btrfs_support_sectorsize 4096
>  _require_xfs_io_command "falloc"
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs -s 4k >> $seqres.full 2>&1
>  
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> index da073333..be61d039 100755
> --- a/tests/btrfs/258
> +++ b/tests/btrfs/258
> @@ -17,6 +17,7 @@ _begin_fstest auto defrag quick
>  # Modify as appropriate.
>  _supported_fs generic
>  _require_scratch
> +_require_xfs_io_command "fiemap"
>  
>  # Needs 4K sectorsize, as larger sectorsize can change the file layout.
>  _require_btrfs_support_sectorsize 4096
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> index 92d0b9a6..36f499f9 100755
> --- a/tests/btrfs/259
> +++ b/tests/btrfs/259
> @@ -18,6 +18,7 @@ _begin_fstest auto quick defrag
>  # Modify as appropriate.
>  _supported_fs btrfs
>  _require_scratch
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs >> $seqres.full
>  
> diff --git a/tests/xfs/443 b/tests/xfs/443
> index f2390bf3..de28b85b 100755
> --- a/tests/xfs/443
> +++ b/tests/xfs/443
> @@ -30,6 +30,7 @@ _require_test_program "punch-alternating"
>  _require_xfs_io_command "falloc"
>  _require_xfs_io_command "fpunch"
>  _require_xfs_io_command "swapext"
> +_require_xfs_io_command "fiemap"
>  
>  _scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
>  _scratch_mount
> -- 
> 2.35.1
> 
