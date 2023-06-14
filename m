Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A513B730525
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjFNQh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjFNQh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 12:37:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054A2706
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 09:37:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AED1218D9;
        Wed, 14 Jun 2023 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686760642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDTlnptan8mm/dhM3/4580faRF7T6GlTiXFGsb1m7Lc=;
        b=KK8HipvCRvdbNKOxqmmZ9q/6rXbNX0oqJPYZcR2XXGrPoeHog00NcnefE2xesZhEXpD7gZ
        8NY2JLmvxRw5efS8nSHVb0bS1uqSsA1U2pSmE5G+2dbc4c7gv2xabpPeWikrBJcjZ2sIRJ
        tasuw6hDNO4eH1vmwMjYabvqnvvoM4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686760642;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDTlnptan8mm/dhM3/4580faRF7T6GlTiXFGsb1m7Lc=;
        b=DYIWjpLHubYvRwsr6TcZN6cNJGpdaW3qFJdf2wUHlVWWVcopb9ZZ/7BcEwUQbWQJV7cUFt
        UhTZ0Ls6ZA9Bx0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 310D81391E;
        Wed, 14 Jun 2023 16:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2WYvC8LsiWQqPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 16:37:22 +0000
Date:   Wed, 14 Jun 2023 18:31:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: fix a return value overwrite in
 scrub_stripe()
Message-ID: <20230614163102.GM13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <846cb6c0ad0ba87026f2d0b1ac3dfc4e1ddde21c.1686725373.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846cb6c0ad0ba87026f2d0b1ac3dfc4e1ddde21c.1686725373.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 02:49:35PM +0800, Qu Wenruo wrote:
> [RETURN VALUE OVERWRITE]
> Inside scrub_stripe(), we would submit all the remaining stripes after
> iterating all extents.
> 
> But since flush_scrub_stripes() can return error, we need to avoid
> overwriting the existing @ret if there is any error.
> 
> However the existing check is doing the wrong check:
> 
> 	ret2 = flush_scrub_stripes();
> 	if (!ret2)
> 		ret = ret2;
> 
> This would overwrite the existing @ret to 0 as long as the final flush
> detects no critical errors.
> 
> [FIX]
> We should check @ret other than @ret2 in that case.
> 
> Fixes: 8eb3dd17eadd ("btrfs: dev-replace: error out if we have unrepaired metadata error during")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
