Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3190E5B3830
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 14:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIIMwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 08:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIIMwY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 08:52:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7B102D6B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 05:52:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0A441F8F2;
        Fri,  9 Sep 2022 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662727941;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0ai3tj0A2SAunTJQ8xCAS1ROnwfGyxgLV0gSp0PWrw=;
        b=LXrRYYa/XAj4CMnPSMMGvmoIEyCSfn6IbDPzHh4Ybl/RblWfmBTu9lKyPS7fu8IJOa6Cte
        iEQTO+h/F7LeLOcNAdwLo2bwDdvJrGmqAjLQa9C9S4cHaU5BmMZgROhuNTguG09KJxswqS
        v48LHD+RNnE8qj/dgF+DepuNZVHwMps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662727941;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0ai3tj0A2SAunTJQ8xCAS1ROnwfGyxgLV0gSp0PWrw=;
        b=6TXfbkq8xCTKwy/Viqc683M+8bsvYLPuacCHtIorHbB0vBauIYVi7qCltTA164oJNoGf+F
        jWVyTWuBaB0jxvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AC28139D5;
        Fri,  9 Sep 2022 12:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hx6dJAU3G2NiNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 12:52:21 +0000
Date:   Fri, 9 Sep 2022 14:46:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: stop tracking failed reads in the I/O tree
Message-ID: <20220909124657.GX32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220907111741.2572029-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907111741.2572029-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 07, 2022 at 01:17:41PM +0200, Christoph Hellwig wrote:
> There is a separate I/O failure tree to track the fail reads, so remove
> the extra EXTENT_DAMAGED bit in the I/O tree.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> 
> Split out from the "consolidate btrfs checksumming, repair and bio
> splitting" series as it makes sens on its own.

Right, added to misc-next, thanks.
