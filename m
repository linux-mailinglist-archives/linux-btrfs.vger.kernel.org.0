Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5ED483697
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiACSJD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:09:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiACSJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:09:02 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D73A1F38A;
        Mon,  3 Jan 2022 18:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641233341;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XL63Y3rpbRTl9tCCyJt39m1qEOqMS9MLZ9w9JtOukns=;
        b=f0IydM+CIxk9vxvm9DoAmazkyAlPLZLprdwmKCnI+AC7ieqKMEAjYbjpDCiYt8fJhsDlmt
        k1TDJjGK+Amb6zWE3FYsUm8SSMs4lZw6fhfMgtdEZiyyOqXF3ANTIfTHAEQZDDoCNDpSAS
        AWSB/SrLnd4T2unn23p7Oo7SEvWH6+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641233341;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XL63Y3rpbRTl9tCCyJt39m1qEOqMS9MLZ9w9JtOukns=;
        b=WU8webU6fOJFkx3fWcJeo1JNzk7gJpRvj8EJ1b0T8Y6U8EvSxT4NuegiXR9qWnMG9sM8IX
        f7kH/PmjF27ovRBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2475BA3B81;
        Mon,  3 Jan 2022 18:09:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 659F7DA729; Mon,  3 Jan 2022 19:08:32 +0100 (CET)
Date:   Mon, 3 Jan 2022 19:08:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: selftests: dump extent io tree if extent-io-tree
 test failed
Message-ID: <20220103180832.GK28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211230084513.29292-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230084513.29292-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 30, 2021 at 04:45:13PM +0800, Qu Wenruo wrote:
> When code modifying extent-io-tree get modified and got that selftest
> failed, it can take some time to pin down the cause.
> 
> To make it easier to expose the problem, dump the extent io tree if the
> selftest failed.
> 
> This can save developers debug time, especially since the selftest we
> can not use the trace events, thus have to manually add debug trace
> points.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/tests/extent-io-tests.c | 52 ++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
> index c2e72e7a8ff0e..160480f6155e8 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -56,6 +56,54 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
>  	return count;
>  }
>  
> +#define STATE_FLAG_STR_LEN	256
> +
> +#define print_one_flag(state, dest, cur, name)				\

Please use uppercase name for magic macros.
