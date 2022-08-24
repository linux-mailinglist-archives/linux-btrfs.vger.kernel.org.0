Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D459FDD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiHXPGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiHXPGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 11:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7B684EE9;
        Wed, 24 Aug 2022 08:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE71D618C9;
        Wed, 24 Aug 2022 15:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21683C433D6;
        Wed, 24 Aug 2022 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661353563;
        bh=UjDrFlKz2thFMxYo2zoBS5Fysft/27n1ibGekptr+QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZr04OsewFU2lMvN7wG2gwBu8rn38lbaLTwX1tqXTGkQEV3FlqrY7cIl2QAaiWIG9
         kzXA6HhZXqz3+O0MMMLYuklbGZ78iz0dwrR+jD22wBqpBe2L0WuFr95A/RtANAXvch
         7Y5e5Lfbarqn4YGLX72vxt8uGxBKkoUquBtzH4pGTjenVr+rHSFnkr/Remg7bzY4ux
         wN2FXM1kmHlcqgPGd/ux4pkymhMa6MpHhvwj6DNX1hRwTI0+ciDmyyQRcMUYRRF7dG
         BFKRZPJjJVMfCCv/PoB9PfARXQM9pLo5xHeG28rgabxDyq4JKERfIa6GJv8XcznAd8
         wETxDgOD1Nx8A==
Date:   Wed, 24 Aug 2022 08:06:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs/271: include common/fail_make_request
Message-ID: <YwY+WlxtojHF1SMx@magnolia>
References: <20220823193230.505544-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823193230.505544-1-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 09:32:29PM +0200, Christoph Hellwig wrote:
> This tests needs the _require_fail_make_request helper from
> common/fail_make_request, so include that file to avoid a test failure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Oops, sorry I forgot that. :/
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/btrfs/271 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/271 b/tests/btrfs/271
> index c21858d1..681fa965 100755
> --- a/tests/btrfs/271
> +++ b/tests/btrfs/271
> @@ -10,6 +10,7 @@
>  _begin_fstest auto quick raid
>  
>  . ./common/filter
> +. ./common/fail_make_request
>  
>  _supported_fs btrfs
>  _require_scratch
> -- 
> 2.30.2
> 
