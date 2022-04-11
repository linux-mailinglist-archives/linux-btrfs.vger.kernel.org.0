Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E734FBF5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiDKOly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347345AbiDKOlx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 10:41:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9CCF1C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 07:39:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF0C01F7AD;
        Mon, 11 Apr 2022 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649687977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4XPObCBfeht/HwbcRikG2ujLdGpoFmKx0bxS/L2ihk=;
        b=m0uGa3xXS32B+4cl2BH9Fpz/c/wMX3Db3E1CQ55ofy4Rz/hoMq4dRlv59nvDfdDJYTwOOb
        MHbiaghWaFNReFrJgDWEaaqrHYtP6JQ0dNVm9MPxTIZNrL3BDhdOH8lKNBbFFnUprmMPha
        cskF0Q4uiGBj/JDRSOOpwXG9R5PaJz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649687977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4XPObCBfeht/HwbcRikG2ujLdGpoFmKx0bxS/L2ihk=;
        b=u+nJSEGdaEMujGnOd9mQyatF6GdSCGGnFds4sEPbds/Vy2BpLMi+hL4nUL/TMP2V4Puo7y
        loVeiJH1hHMlhcDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C6E21A3B82;
        Mon, 11 Apr 2022 14:39:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 704D7DA7DA; Mon, 11 Apr 2022 16:35:33 +0200 (CEST)
Date:   Mon, 11 Apr 2022 16:35:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/16] btrfs: introduce btrfs_raid_bio::bio_sectors
Message-ID: <20220411143533.GM15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <5737a015d302fb7cb3774deb3115f0e8a26258db.1648807440.git.wqu@suse.com>
 <20220408164647.GV15609@twin.jikos.cz>
 <adef07e2-a6fe-0be5-1c8a-e57be8af19c6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adef07e2-a6fe-0be5-1c8a-e57be8af19c6@gmx.com>
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

On Sat, Apr 09, 2022 at 06:58:56AM +0800, Qu Wenruo wrote:
> On 2022/4/9 00:46, David Sterba wrote:
> > On Fri, Apr 01, 2022 at 07:23:20PM +0800, Qu Wenruo wrote:
> >> This new member is going to fully replace bio_pages in the future, but
> >> for now let's keep them co-exist, until the full switch is done.
> >>
> >> Currently cache_rbio_pages() and index_rbio_pages() will also populate
> >> the new array.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/raid56.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 53 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> >> index 8cfe00db79c9..f23fd282d298 100644
> >> --- a/fs/btrfs/raid56.c
> >> +++ b/fs/btrfs/raid56.c
> >> @@ -60,6 +60,7 @@ struct btrfs_stripe_hash_table {
> >>   struct sector_ptr {
> >>   	struct page *page;
> >>   	unsigned int pgoff;
> >> +	unsigned int uptodate:1;
> >>   } __attribute__ ((__packed__));
> >
> > Even with packed this does not help as the full in is allocated for the
> > single bit and it requires bit operations to set/clear. Up to 4 bools
> > fit into one int and using them is better.
> 
> I guess I can put pgoff to take at most 31 bits, then can share uptodate
> flag with pgoff.

If we go that way, splitting the bit fields on byte boundary generates a
better code, anything non-aligned requires masking and oring
> 
> >
> >>
> >>   enum btrfs_rbio_ops {
> >> @@ -175,6 +176,9 @@ struct btrfs_raid_bio {
> >>   	 */
> >>   	struct page **stripe_pages;
> >>
> >> +	/* Pointers to the sectors in the bio_list, for faster lookup */
> >> +	struct sector_ptr *bio_sectors;
> >> +
> >>   	/* Pointers to the pages in the bio_list, for faster lookup */
> >>   	struct page **bio_pages;
> >>
> >> @@ -282,6 +286,24 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
> >>   		copy_highpage(rbio->stripe_pages[i], rbio->bio_pages[i]);
> >>   		SetPageUptodate(rbio->stripe_pages[i]);
> >>   	}
> >> +
> >> +	/*
> >> +	 * TODO: This work is duplicated with above loop, should remove above
> >
> > I think I told you several times, please don't write TODO notes. A plain
> > comment explaining that the loop is duplicated is understandable by
> > itself.
> 
> Even it's going to be deleted in later patches?

Yes.

> TODO provides a pretty good highlight in most editors, thus it's way
> more easier to be exposed without being forgotten.

Being forgotten by you while writing the patches, it's not interesting
for anybody else and I'm really opposed to using source code as todo
list and note taking storage. We have too many in btrfs code, lots of
them stale for years. If it's in the same patchset there's little risk
you'd forget about it, or take notes on paper or maybe your editor has a
capability to bookmark lines.
