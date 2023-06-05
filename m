Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F200F7231EA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjFEVIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFEVIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 17:08:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB21ED
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 14:08:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2847D2199B;
        Mon,  5 Jun 2023 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685999294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rPAiHG+Yickoo3DhKqToUp+ODVtSpV10gP4BEgqFuEg=;
        b=NDBuvZpJ8ZLmPVpINGfaPmjJr4bapR7NGyP/IzeF++hf4b55kqrYr6bAF0DdUDGQBxNP6b
        K4biUlaGFjuv6K+qGe7i5bsRJPkaoJ1oeube9f+pFYS3I/SbQ7wpk6VCK9+hwHsvL2Ozu4
        ekiiF7ncFveIaniL+lXnTHiV/Fd9s1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685999294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rPAiHG+Yickoo3DhKqToUp+ODVtSpV10gP4BEgqFuEg=;
        b=Ms320EC+Q+nVfJ1+lDPpU9Y7USIcVEVbCAucCn/mNjmHxkuTj59SsY2cUi/cfYgGFqScaX
        rAZZQ2wqXd63kiAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07DA6139C8;
        Mon,  5 Jun 2023 21:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tqIQAb5OfmSSFgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 05 Jun 2023 21:08:14 +0000
Date:   Mon, 5 Jun 2023 23:01:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: writeback fixlets and tidyups v2
Message-ID: <20230605210159.GF25292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230531060505.468704-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 08:04:49AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this little series fixes a few minors bugs found by code inspection in the
> writeback code, and then goes on to remove the use of PageError.
> 
> This replaces the earlier version in the for-next branch.
> 
> Changes:
>  - rebased to the latest misc-next tree
>  - remove a set but unused variable in pages_processed
>  - remove a spurious folio_set_error
>  - return bool from btrfs_verify_page
>  - update various commit message
> 
> Subject:
>  compression.c |    2 
>  extent_io.c   |  359 +++++++++++++++++++---------------------------------------
>  extent_io.h   |    6 
>  inode.c       |  180 ++++++++++++-----------------
>  subpage.c     |   35 -----
>  subpage.h     |   10 -
>  6 files changed, 209 insertions(+), 383 deletions(-)

Patches 14, 15 and 16 got postponed, the rest is now in misc-next,
thanks.
