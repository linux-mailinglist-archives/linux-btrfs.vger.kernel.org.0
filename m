Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91D666C1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 09:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjALIJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 03:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjALIJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 03:09:58 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392DB855
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 00:09:56 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26D5468BEB; Thu, 12 Jan 2023 09:09:53 +0100 (CET)
Date:   Thu, 12 Jan 2023 09:09:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/10] btrfs: add a bio_list_put helper
Message-ID: <20230112080952.GA12947@lst.de>
References: <20230111062335.1023353-1-hch@lst.de> <20230111062335.1023353-5-hch@lst.de> <2e946375-bfdb-7361-842d-c0b40e206298@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e946375-bfdb-7361-842d-c0b40e206298@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 11, 2023 at 11:12:21AM +0000, Johannes Thumshirn wrote:
> On 11.01.23 07:24, Christoph Hellwig wrote:
> > +static inline void bio_list_put(struct bio_list *bio_list)
> > +{
> > +	struct bio *bio;
> > +
> > +	while ((bio = bio_list_pop(bio_list)))
> > +		bio_put(bio);
> > +}
> > +
> 
> Shouldn't that be lifted into bio.h? At least 
> drivers/target/target_core_iblock.c would benefit from it as well.

That is in fact the only other two callers, out of which one is bogus
as we don't even need the list there (Write Same just has a single
block payload).  So for now I'd prefer to not move it to common
code.
