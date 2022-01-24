Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54178498F5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 20:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245183AbiAXTwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 14:52:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348231AbiAXTol (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 14:44:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5F1992113A;
        Mon, 24 Jan 2022 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643053479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PALzt4viqppnbCTEd5JnoddSy6Y386bU+yI0jFXb2Xs=;
        b=IcseyuDiG7EozSQCnSlNaIu0C8m1RyI7OuFmUHsOAWJWLqp41pauanI+rysneFWcm5CLBR
        n7LPQF4ilqHydWcwaG6eVa1Qy64FHY/FhoTpzfBHzyn1QaqN5MDgMHpI4cGzjbyXkxCyDH
        9MrEYU4J3b/joldDU/jitBydSALwLZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643053479;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PALzt4viqppnbCTEd5JnoddSy6Y386bU+yI0jFXb2Xs=;
        b=fzuSFXyQjPmOXWqT/rGkeCcHwkWfuZUI8J6+pgGu3olwRTUa2sshOKH52RYgaMjfPNFRXV
        3/b0X7L9No9PlVCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 51D7EA3B81;
        Mon, 24 Jan 2022 19:44:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54796DA7A3; Mon, 24 Jan 2022 20:43:59 +0100 (CET)
Date:   Mon, 24 Jan 2022 20:43:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] btrfs: scrub: Remove redundant initialization of
 increment
Message-ID: <20220124194359.GE14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220121114224.92247-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121114224.92247-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 21, 2022 at 07:42:24PM +0800, Jiapeng Chong wrote:
> increment is being initialized to map->stripe_len but this is never
> read as increment is overwritten later on. Remove the redundant
> initialization.

> 
> Cleans up the following clang-analyzer warning:
> 
> fs/btrfs/scrub.c:3193:6: warning: Value stored to 'increment' during its
> initialization is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/btrfs/scrub.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 2e9a322773f2..38f5666eff14 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3209,7 +3209,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>  	offset = 0;
>  	nstripes = div64_u64(dev_extent_len, map->stripe_len);
>  	mirror_num = 1;
> -	increment = map->stripe_len;

I'd rather remove the initialization at the declarataion, the other
values are initialized here so it's all in one place. As is's a minor
change I'll do that at commit time, no need to resend. Thanks.
