Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00AE555117
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 18:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359769AbiFVQQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376412AbiFVQP5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 12:15:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA5344CD
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 09:15:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 233EF68AA6; Wed, 22 Jun 2022 18:15:47 +0200 (CEST)
Date:   Wed, 22 Jun 2022 18:15:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: remove bioc->stripes_pending
Message-ID: <20220622161546.GA683@lst.de>
References: <20220617100414.1159680-1-hch@lst.de> <20220617100414.1159680-11-hch@lst.de> <20220622160725.GJ20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622160725.GJ20633@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 22, 2022 at 06:07:25PM +0200, David Sterba wrote:
> On Fri, Jun 17, 2022 at 12:04:14PM +0200, Christoph Hellwig wrote:
> > Replace the stripes_pending field with the pending counter in the bio.
> > This avoid an extra field and prepares splitting the btrfs_bio at the
> > stripe boundary.
> 
> This does not seem sufficient as changelog, does not explain why the
> stripes_pending is being removed, just that it's some prep work. Given
> the questions that Nikolay had I think this needs to be expanded. I'll
> try to summarize the discussion but in the bio code nothing is that
> simple that reading the patch would answer all questions.

Maybe just skip this patch for now then.  I also have two follows up
for it, so I can resend it with an updated version of this one.

But the single sentence summary is: use the block layer infrastructure
instead of reinveting it poorly.
