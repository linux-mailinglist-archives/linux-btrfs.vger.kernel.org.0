Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A36A83E6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCBN7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 08:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCBN7s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 08:59:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164B1E5FA
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 05:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G8TYaQH0P1DvGgdmrGJ4RrBSHE1pALhnmNnKS2Bp9/w=; b=D+RreTsDM3UnjqDIlBwTgB5Dpx
        FdgmFcDRSduiV5nv6nvRftV6z8ttgZvSpEOW2SuBXRkcjHQwjYuOUGF1WJ/CfEHPglSMUv26t5UyV
        PWodT1u6cEbqVjwjCxdAsYLcPp3cprEo8NhObVrTyzj0hcGe2c5iSbD5NQfJD3mGAyOw9HLdLm/sN
        KMquhKDHWWrclFVFj7t1z7jaAwPkBy1RyFwo4V/4nO4MgguuenJSfQo8rZgAACdEBjMdNMXRWiW8l
        zhNaXWQqTlmW+qBwUBhqLZUgurYe1DRbjaD3GF0eomXf1qQZtIn+0j+/U3d01Mt6LahrH2LmpnIbf
        f3nOYrYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXjTB-002OmV-CV; Thu, 02 Mar 2023 13:59:41 +0000
Date:   Thu, 2 Mar 2023 05:59:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZACrzUh82/9HPDV2@infradead.org>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 11:25:22AM +0000, Johannes Thumshirn wrote:
> > The main concern may be the bioc <-> ordered extent mapping, but IIRC 
> > for zoned mode one bioc is one ordered extent, thus this shouldn't be a 
> > super big deal?
> 
> Yep, but I want to be able to use RST for non-zoned devices as well
> to attack the RAID56 problems and add erasure coding RAID.

I have a series in my queue the limits every btrfs_bio (and thus bioc)
to a single ordered_extent.  The bio spanning ordered_extents is a very
strange corner case that rarely happens but causes a lot of problems.
With that series we'll also gain a pointer to the ordered_extent from
the btrfs_bio, which will remove all the ordered_extent lookups from
the fast path.

So I think you can rework your series to also limit the bio to a single
ordered extent, and if needed split the ordered extent for anything that
uses the raid stripe tree and we'll nicely converge there.
