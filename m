Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836AE596D2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiHQK6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiHQK6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 06:58:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695482D04
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 03:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DBB1B81CD1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 10:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C2BC433D6;
        Wed, 17 Aug 2022 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660733884;
        bh=fpNl77PKVy5YvpWQE8bHFhzvfq8TcYauJJ04enyi4HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0MCo/5tg/TH13sAfK7l+SXSKj4cw3PeaafSzR2AYFWHWs/HedBGSVqM0RtBqHU6P
         0oJw3pOVGWVVZZJoEtret8EZnT/1XPHc+UbJbhjKRkTwCL/ou56CgRZFvsqavkK3Nh
         h+4Y05DeMTYde6pt/cvPu7TyufqhlQg7BNaROVnOQPBwVsVTJa9FRbkfxfUtvNroXt
         rxWEcmIPfAXptRJBvxsTxHQ1yJ3D4sRNqD7a55MZegHtve5GobFW+QJtApRnr2XUIU
         OMPqfLMJ+hTabmA6RYAtBWDzhQJGB4NAubHAgtI4bqcf8ZcFZqJuaQ5vaTyit1chLx
         rSXc45Mr4crEw==
Date:   Wed, 17 Aug 2022 11:58:00 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Check if root is readonly while setting
 security xattr
Message-ID: <20220817105800.GA2823553@falcondesktop>
References: <20220816214256.t5ikj7pyqe6l6qgn@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816214256.t5ikj7pyqe6l6qgn@fiona>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 04:42:56PM -0500, Goldwyn Rodrigues wrote:
> For a filesystem which has btrfs read-only property set to true, all
> write operations including xattr should be denied. However, security
> xattr can still be changed even if btrfs ro property is true.
> 
> This happens because xattr_permission() does not have any restrictions
> on security.*, system.*  and in some cases trusted.* from VFS and
> the decision is left to the underlying filesystem. See comments in
> xattr_permission() for more details.
> 
> This patch checks if the root is read-only before performing the set
> xattr operation.
> 
> Testcase: 
> 
> #!/bin/bash
> 
> DEV=/dev/vdb
> MNT=/mnt
> 
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
> echo "file one" > $MNT/f1
> 
> setfattr -n "security.one" -v 2 $MNT/f1
> btrfs property set /mnt ro true
> 
> # Following statement should fail
> setfattr -n "security.one" -v 1 $MNT/f1
> 
> umount $MNT
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

Btw, as noted in the review of the test case for fstests, the subject
should be "btrfs: check ..." and not "btrfs: Check ...", as that's
the convention used for btrfs. David will likely change that when
picking the patch, as usual.

> 
> 
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 7421abcf325a..5bb8d8c86311 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -371,6 +371,9 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
>  				   const char *name, const void *buffer,
>  				   size_t size, int flags)
>  {
> +	if (btrfs_root_readonly(BTRFS_I(inode)->root))
> +		return -EROFS;
> +
>  	name = xattr_full_name(handler, name);
>  	return btrfs_setxattr_trans(inode, name, buffer, size, flags);
>  }
> 
> -- 
> Goldwyn
