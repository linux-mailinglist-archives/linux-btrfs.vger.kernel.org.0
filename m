Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73F735DA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 21:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjFSTBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 15:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFSTBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 15:01:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F91118C
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 12:01:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5459D1F86C;
        Mon, 19 Jun 2023 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687201269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzkwLi1OOAN2lTD0wcYqYTAONx/lvKAHEc3qs52p6eA=;
        b=xHGR0TQz4bxPzsE5puV9b9/6vqWaW58PHD5Blk1A1jz+ofDYii3jiJE97OdZPAF7x5E46y
        tAEcg8Qx2WEieoBQ1XBT0m8Sh3bM06msX02zvzbQncN20BjvBTTvehfZFF/GUsnpWjVFSi
        Fheb9R82OD3oZC2eTejOi2VRSRt0Pe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687201269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzkwLi1OOAN2lTD0wcYqYTAONx/lvKAHEc3qs52p6eA=;
        b=5vWnooNJuIy883FNYIS064ieyyKGy3/L1JXjCd0VuNYc49kNw8QMyS30ODbbV2VLH62agy
        n0ZqTbOT3Fvq11Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F67C138E8;
        Mon, 19 Jun 2023 19:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ulWzCvWlkGRlHQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Jun 2023 19:01:09 +0000
Date:   Mon, 19 Jun 2023 20:54:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: remove btrfs_writepage_endio_finish_ordered
Message-ID: <20230619185446.GG16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230607073045.97261-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607073045.97261-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 07, 2023 at 09:30:44AM +0200, Christoph Hellwig wrote:
> btrfs_writepage_endio_finish_ordered is a small wrapper around
> btrfs_mark_ordered_io_finished that just changs the argument passing
> slightly, and adds a tracepoint.
> 
> Move the tracpoint to btrfs_mark_ordered_io_finished, which means
> it now also covers the error handling in btrfs_cleanup_ordered_extent
> and switch all callers to just call btrfs_mark_ordered_io_finished
> directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

FYI, for now cleanups or refactoring that do not seem to be necessary
for some other fix will be postponed after rc1. I'm replying here but
it's meant for other patches.
