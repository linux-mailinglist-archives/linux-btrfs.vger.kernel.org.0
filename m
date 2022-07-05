Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B791B567563
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiGERRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiGERRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 13:17:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A991EEEE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 10:17:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 577DE67373; Tue,  5 Jul 2022 19:17:11 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:17:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 1/4] btrfs: simplify the pending I/O counting in struct
 compressed_bio
Message-ID: <20220705171711.GB15148@lst.de>
References: <20220630160130.2550001-1-hch@lst.de> <20220630160130.2550001-2-hch@lst.de> <47d3c2ee-e602-b6be-bd48-d6d913455a29@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d3c2ee-e602-b6be-bd48-d6d913455a29@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 05, 2022 at 05:40:22PM +0300, Nikolay Borisov wrote:
> nit: This slightly changes the semantics of the function because with the 
> old code the bio could have been completed in submit_compressed_write iff 
> there was an error during submission for one of the sub-bios. Whilst with 
> this new code there is a chance even in the success case this happens (if 
> the sub bios complete by the time we arrive at this code).

Yes.

> Generally that'd 
> be very unlikely due to io latency and indeed this code becomes effective 
> iff there is an error. Personally I'd like such changes to be called out 
> explicitly in the change log or at least with a comment.

Ok, I can spell this out a little more explicitly.
