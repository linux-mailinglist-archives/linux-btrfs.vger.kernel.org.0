Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57346B9E4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 19:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCNS1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCNS1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 14:27:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD29E518
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 11:27:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3A5A1F8BD;
        Tue, 14 Mar 2023 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678818425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ih9Vw9qss94ZpzqGAxdQ4ZMVCmAcIjWHnE9thHnk68w=;
        b=EKQueCxmeR0JNpBU9lvLwmRXlGVWc8iQvFTzQkaVnV0VpPeUcxmmUTLiVZGaruBm+J4wXW
        U7ks5KDMMNy1tfya2d29r+h/yyaIM/m+QmsKlOfgr8hMGoAEemr1U1lT+c17Z9teEQBl7E
        w2ZLkcLd6ZTVNaIzUIKv+8S/N/86slA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678818425;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ih9Vw9qss94ZpzqGAxdQ4ZMVCmAcIjWHnE9thHnk68w=;
        b=JyPsuKjmwGEgxIbS4cjveDLBmJ/7rPB0ct8mXlTA4SwLc0SedCgn1ciCjswjb2yJ2VmFsk
        DwnBNgq7mmnYziAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FC1913A26;
        Tue, 14 Mar 2023 18:27:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MoMIInm8EGThJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 14 Mar 2023 18:27:05 +0000
Date:   Tue, 14 Mar 2023 19:20:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Message-ID: <20230314182059.GR10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1678777941.git.wqu@suse.com>
 <cfea13b2a1649e4c295b020f2713660c879ef898.1678777941.git.wqu@suse.com>
 <ee70d6fb-2aae-e0d8-8b32-a5e373c572a0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee70d6fb-2aae-e0d8-8b32-a5e373c572a0@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 12:05:52PM +0000, Johannes Thumshirn wrote:
> On 14.03.23 08:36, Qu Wenruo wrote:
> > There is really no need to go through the super complex scrub_sectors()
> > to just handle super blocks.
> > 
> > This patch will introduce a dedicated function (less than 50 lines) to
> > handle super block scrubing.
> > 
> > This new function will introduce a behavior change, instead of using the
> > complex but concurrent scrub_bio system, here we just go
> > submit-and-wait.
> > 
> > There is really not much sense to care the performance of super block
> > scrubbing. It only has 3 super blocks at most, and they are all scattered
> > around the devices already.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/scrub.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 46 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index 3cdf73277e7e..e765eb8b8bcf 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -4243,18 +4243,59 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
> >  	return ret;
> >  }
> >  
> > +static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
> > +			   struct page *page, u64 physical, u64 generation)
> > +{
> > +	struct btrfs_fs_info *fs_info = sctx->fs_info;
> > +	struct bio_vec bvec;
> > +	struct bio bio;
> > +	struct btrfs_super_block *sb = page_address(page);
> > +	int ret;
> > +
> > +	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
> > +	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
> > +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
> > +	ret = submit_bio_wait(&bio);
> > +	bio_uninit(&bio);
> > +
> 
> I don't think bio_uninit() is needed here. You're not attaching any cgroup information,
> bio integrity or crypto context to it. Or can that be attached down the stack?

It may not be needed due to functional reasons but I'd rather keep it
there to pair with bio_init.
