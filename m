Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2A3B9522
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhGARDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 13:03:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44704 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhGARDS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 13:03:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A1B40204F1;
        Thu,  1 Jul 2021 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625158846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhkIpr+RhcIdBYo/hJSdW0DQvn6zKdLArgtE0BNd8gs=;
        b=L1BeI1MIoIDDKujZN4eNQpMAXAQ5+17OV2MZ12wO9oS/Ity/N0N6jNWQqJXsUfUo96fI8f
        bOI4w2kZgMgyiE66cMea+g9otzTnbux0ew6/BudO+4iTRBJtWw/GxkgBTDzhz2bGDoG2y/
        mz1De2v2PDRzoTYHAULhP/ijSUxcoeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625158846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhkIpr+RhcIdBYo/hJSdW0DQvn6zKdLArgtE0BNd8gs=;
        b=0zCcJcvvKeuAMiMlEl53XuLUpYljCkE7Tc1jKZkECBNtPjJ0cUKvADnVeRqcVTIDzSIrZt
        HUvCocNVVH6GKvAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 99823A3B91;
        Thu,  1 Jul 2021 17:00:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0038ADA6FD; Thu,  1 Jul 2021 18:58:15 +0200 (CEST)
Date:   Thu, 1 Jul 2021 18:58:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 02/10] btrfs: defrag: extract the page preparation
 code into one helper
Message-ID: <20210701165815.GZ2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210610050917.105458-1-wqu@suse.com>
 <20210610050917.105458-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610050917.105458-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 10, 2021 at 01:09:09PM +0800, Qu Wenruo wrote:
> In cluster_pages_for_defrag(), we have complex code block inside one
> for() loop.
> 
> The code block is to prepare one page for defrag, this will ensure:
> - The page is locked and set up properly
> - No ordered extent exists in the page range
> - The page is uptodate
> - The writeback has finished
> 
> This behavior is pretty common and will be reused by later defrag
> rework.
> 
> So extract the code into its own helper, defrag_prepare_one_page(), for
> later usage, and cleanup the code by a little.
> 
> Since we're here, also make the page check to be subpage compatible,
> which means we will also check page::private, not only page->mapping.

Please split this change, it's unnoticeable in the refactoring.
