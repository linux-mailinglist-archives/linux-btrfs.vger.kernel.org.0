Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630D26FF93F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbjEKSDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbjEKSDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 14:03:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19284D072
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 11:02:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E87020016;
        Thu, 11 May 2023 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683828158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MikxRlh03tGyaxKZ8gby0A8Sma6CXbADpBzyMBw6qcs=;
        b=xNLjX3QUW4iSbbtNN5XaIJGQ2LbTVrTryPZEdwFvYICP2A/V8y4VTYzw0GCPQhmdt5nVKF
        NlJdiPCV2ZbV12DIvhNnxW8GR26/APUJ14n+zV1OCNA6Qd71NngOyjkTTxQBXi/CSt5OPv
        Dw081suXaKsx6ORkdcWH96WOYtTwA8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683828158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MikxRlh03tGyaxKZ8gby0A8Sma6CXbADpBzyMBw6qcs=;
        b=tUzUEGMQLMqtReuv3AdotiZLMtjJ7M+hbxhGsku90l7C2mM/Mw8tmcEQe60h4g2SdrXnBm
        BxVISAmrcoA3LPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D26F3138FA;
        Thu, 11 May 2023 18:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDFIMr0tXWSkOQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 11 May 2023 18:02:37 +0000
Date:   Thu, 11 May 2023 19:56:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: add an ordered_extent pointer to struct btrfs_bio
Message-ID: <20230511175637.GA32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508160843.133013-1-hch@lst.de>
 <20230510163221.GT32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510163221.GT32559@twin.jikos.cz>
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

On Wed, May 10, 2023 at 06:32:21PM +0200, David Sterba wrote:
> On Mon, May 08, 2023 at 09:08:22AM -0700, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series adds a pointer to the ordered_extent to struct btrfs_bio to
> > reduce the repeated lookups in the rbtree.  For non-buffered I/Os the
> > I/O will now never do a lookup of the ordered extent tree (other places
> > like waiting for I/O still do).  For buffered I/O there is still a lookup
> > as the writepages code is structured in a way that makes it impossible
> > to just pass the ordered_extent down.  With some of the work from Goldwyn
> > this should eventually become possible as well, though.
> 
> Series added as topic branch to for-next, thanks.

I did another pass and adjusted some minor style things. I'm curious
about the performance effects now that the lookups are gone, we'll have
some data from the nightly CI tests next week.
