Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF440F82C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhIQMpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 08:45:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhIQMpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 08:45:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C00DD2238B;
        Fri, 17 Sep 2021 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631882630;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WoChDCFeUKckRZgcQd/05ktBb1VFmdtMvq/SY0Y2v5I=;
        b=mw5dIK+YXB+MLm0m6AuD7UgipKRxnVxD+8wxwgBmvciDvPaxs7Ll8TVdmCWhpa7L/G8KWr
        Hxo0NMDCi5DscgXnmYZARgGaNCPc5jVpXgzGyX57mfFh6iKPKqS/xcXe963fv9B3CWYEuw
        TQT0IaNTJEC/aoqTwv+IZ3bXxcEqKOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631882630;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WoChDCFeUKckRZgcQd/05ktBb1VFmdtMvq/SY0Y2v5I=;
        b=GBrdq/K2tU7NTTKyzKJEx0Ypxv0DvNQHgvTDGmDkXo094a9ymt15YbWjJ+grKxC7cEHMcY
        z9sjndCxZ1quzlCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B6C80A3B90;
        Fri, 17 Sep 2021 12:43:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 215FDDA781; Fri, 17 Sep 2021 14:43:41 +0200 (CEST)
Date:   Fri, 17 Sep 2021 14:43:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
Message-ID: <20210917124341.GS9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
 <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 17, 2021 at 03:27:44PM +0300, Nikolay Borisov wrote:
> > -struct bio *btrfs_bio_alloc(u64 first_byte)
> > +struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
> >  {
> >  	struct bio *bio;
> >  
> > -	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
> > -	bio->bi_iter.bi_sector = first_byte >> 9;
> > +	ASSERT(nr_iovecs <= BIO_MAX_VECS);
> > +	if (nr_iovecs == 0)
> > +		nr_iovecs = BIO_MAX_VECS;
> 
> hell no! How come passing 0 actually means BIO_MAX_VEC. Instead of
> having 0 everywhere and have the function translate this to
> BIO_MAX_VECS, simply pass BIO_MAX_VECS in every call site where it's
> needed.

I had thought about that before and cocluded that passing BIO_MAX_VECS
everywhere would be the wrong way as it's a detail about how many bio
vecs are allocated. So 0 is a default is ok as any other number means
that it's the exact count.

> David, please either fix the patch in the tree or retract it. Let's try
> and refrain from adding such "gems" to the code base.

So should we add another helper that takes the exact number and drop the
parameter everwhere is 0 so it's just btrfs_io_bio_alloc() with the
fallback?
