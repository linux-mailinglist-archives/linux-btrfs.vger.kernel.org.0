Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629170ED41
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 07:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbjEXFoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 01:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239379AbjEXFoy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 01:44:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C9C1
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 22:44:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B33FC68D07; Wed, 24 May 2023 07:44:49 +0200 (CEST)
Date:   Wed, 24 May 2023 07:44:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 10/21] btrfs: return bool from lock_extent_buffer_for_io
Message-ID: <20230524054449.GA19255@lst.de>
References: <20230503152441.1141019-1-hch@lst.de> <20230503152441.1141019-11-hch@lst.de> <20230523184317.GY32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523184317.GY32559@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 08:43:17PM +0200, David Sterba wrote:
> On Wed, May 03, 2023 at 05:24:30PM +0200, Christoph Hellwig wrote:
> > lock_extent_buffer_for_io never returns a negative error value, so switch
> > the return value to a simple bool.  Also remove the noinline_for_stack
> > annotation given that nothing in lock_extent_buffer_for_io or its callers
> > is particularly stack hungry.
> 
> AFAIK the reason for noinline_for_stack is not because of a function is
> stack hungry but because we want to prevent inlining it so we can see it
> on stack in case there's an implied waiting. This makes it easier to
> debug when IO is stuck or there's some deadlock.
> 
> This is not consistent in btrfs code though, quick search shows lots of
> historical noinline_for_stack everywhere without an obvious reason.

Hmm.  noinline_for_stack is explicitly documented to only exist as an
annotation that noinline is used for stack usage.  So this is very odd.

If you want a normal noinline here I can add one, but to be honest
I don't really see the point even for stack traces.
