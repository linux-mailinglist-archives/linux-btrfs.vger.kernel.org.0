Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52EB717497
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjEaEAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjEaEAa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:00:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BDC107
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:00:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EF2F768B05; Wed, 31 May 2023 06:00:14 +0200 (CEST)
Date:   Wed, 31 May 2023 06:00:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/14] btrfs: return void from btrfs_finish_ordered_io
Message-ID: <20230531040014.GA32357@lst.de>
References: <20230524150317.1767981-1-hch@lst.de> <20230524150317.1767981-10-hch@lst.de> <20230530154415.GA30110@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530154415.GA30110@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 05:44:15PM +0200, David Sterba wrote:
> On Wed, May 24, 2023 at 05:03:12PM +0200, Christoph Hellwig wrote:
> > The callers don't check the btrfs_finish_ordered_io return value, so
> > drop it.
> 
> Same general comments like in
> https://lore.kernel.org/linux-btrfs/20230530150359.GS575@twin.jikos.cz/
> 
> "Function can return void if none of its callees return an error,
>  directly or indirectly, there are no BUG_ONs left to be turned to
>  proper error handling or there's no missing error handling"
> 
> btrfs_finish_ordered_io mixes a few error handling styles, there's
> direct return -ERROR, transaction abort or mapping_set_error. Some
> called functions are not error handling everything propely and at least
> btrfs_free_reserved_extent() returns an error but is not handled.
> 
> I'm not counting the state bit handlers (clear_extent_bit) as we know
> they "should not fail". unpin_extent_cache() does not look clean either.
> 
> If 'callers don't check error values' the question is 'Should they?'.

The clear answer is no, as we're in an I/O completion handler where
there is no one we could return them to.  The errors are propagate
through the mapping state.
