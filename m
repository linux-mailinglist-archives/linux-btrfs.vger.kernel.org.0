Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDA690E15
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBIQNV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 11:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBIQNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 11:13:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED7244A1;
        Thu,  9 Feb 2023 08:13:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25C3661B22;
        Thu,  9 Feb 2023 16:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F4FC433EF;
        Thu,  9 Feb 2023 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675959192;
        bh=QecBsobEFYAe0gYvqkMuPeIicTpdWCP6zl9gBffDX7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgRHSrsaTK6+7EDiPg8BzHplbA78UIuNO8eJzH//1YYVBOn6hcduE3JJbZyL4vyjp
         f0wNybgYx3xVVVDebgVeAdFoq6ps7mms+CfFBtiiAPcck1t3C3xIKhOUiGftpt6/jN
         Bg5n31oeIAiveCfBHeSnKnmEZAtmOH78YgY95mSyM547wBmd+/2UOZai62zxvcOccY
         NBrfP/TNGMBNZnbRA6IADYl7/Z22rz2ygCQ6i6yib24vav4U9/kQOgvj+z4WNnUxTN
         c+19lOcPakkMHhc/lrs3QLNikLteZoHRlM4LhqRuA1YrntO+djPihfUPo5GpLDKMun
         AkrA5oIbK3gkA==
Date:   Thu, 9 Feb 2023 08:13:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/7] generic: add 251 to the auto group
Message-ID: <Y+Ublyc88P7mlg/i@magnolia>
References: <20230209051355.358942-1-hch@lst.de>
 <20230209051355.358942-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209051355.358942-7-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 09, 2023 at 06:13:54AM +0100, Christoph Hellwig wrote:
> generic/251 isn't dangerous, doesn't takes overly long to run and doesn't
> produce spurious failures, so add it to the auto group.

How long does it take for you?  It generally takes 300-700s to run on my
testing cloud.  That's not a reason to keep it out of the auto group,
but I've been surveying the long running tests to find the ones that run
stuff in a loop and subject them to TIME_FACTOR (or the new
SOAK_DURATION knob that I'm working on to allow direct control of loop
runtime) constraints.

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/251 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/251 b/tests/generic/251
> index 192ab5cc..2a271cd1 100755
> --- a/tests/generic/251
> +++ b/tests/generic/251
> @@ -10,7 +10,7 @@
>  # corrupts the filesystem (data/metadata).
>  #
>  . ./common/preamble
> -_begin_fstest ioctl trim
> +_begin_fstest ioctl trim auto
>  
>  tmp=`mktemp -d`
>  trap "_cleanup; exit \$status" 0 1 3
> -- 
> 2.39.1
> 
