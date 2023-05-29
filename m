Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15497714EFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjE2Rpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE2Rpm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 13:45:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC3AB
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 10:45:40 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 084231F8B2;
        Mon, 29 May 2023 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685382339;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9LiAUoYbNFzQGuIea5bYML2vMRqzjoeUhjtkC05cJ0=;
        b=CovKPrev9lH9BO0ern8v47NRiDuwyWc5odSz5P49XWuN8MU3zBWf9x9/29A79+waWQVYTh
        dS1YfE0OrOA2SoygS/vhTK8r5nFP2s4a+M0JfC6J7UNFyyGqKecGhhas5qF3GFPBK+wB2C
        7L5eopp558FS8hN4xXAJYfIugF+4yXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685382339;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9LiAUoYbNFzQGuIea5bYML2vMRqzjoeUhjtkC05cJ0=;
        b=jNeMdwQ7XgBZwLwniV60EuJlXWmpeRrrN4YiZsevIbigQEk/ouB04WXkdcdySBkeI2BnhO
        DuV6YXTOQKcdS7DQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D2DF9134BC;
        Mon, 29 May 2023 17:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Jau9MsLkdGSFJAAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 29 May 2023 17:45:38 +0000
Date:   Mon, 29 May 2023 19:39:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/16] btrfs: unify fsverify vs other read error handling
 in end_page_read
Message-ID: <20230529173928.GK575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523081322.331337-4-hch@lst.de>
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

On Tue, May 23, 2023 at 10:13:09AM +0200, Christoph Hellwig wrote:
> Don't special case the fsverify error handling and clear the uptodate
> bit for them as well like other readpage implementations (iomap, buffer,
> mpage) do.
> 
> Fixes: 146054090b08 ("btrfs: initial fsverity support")

Wit Fixes: tag it means there's a bug but the the changelog does not
read as abug description. Non-bug references to patches introducing some
code can be done in the text.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/extent_io.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fc48888742debd..4297478a7a625d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -497,12 +497,8 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
>  	ASSERT(page_offset(page) <= start &&
>  	       start + len <= page_offset(page) + PAGE_SIZE);
>  
> -	if (uptodate) {
> -		if (!btrfs_verify_page(page, start)) {
> -			btrfs_page_set_error(fs_info, page, start, len);
> -		} else {
> -			btrfs_page_set_uptodate(fs_info, page, start, len);
> -		}
> +	if (uptodate && btrfs_verify_page(page, start)) {
> +		btrfs_page_set_uptodate(fs_info, page, start, len);
>  	} else {
>  		btrfs_page_clear_uptodate(fs_info, page, start, len);
>  		btrfs_page_set_error(fs_info, page, start, len);

So the difference is that now !btrfs_verify_page() will forcibly clear
uptodate. At this point it should not be set so comparing it to previous
code it's a no-op. From the clarity POV the new code is better but I
don't see any bug here.
