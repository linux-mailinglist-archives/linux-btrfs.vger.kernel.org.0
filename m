Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4848C6B28B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCIPXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 10:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCIPWn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 10:22:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7562EF0C4A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 07:22:27 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA77768AA6; Thu,  9 Mar 2023 16:22:24 +0100 (CET)
Date:   Thu, 9 Mar 2023 16:22:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 13/20] btrfs: simplify the extent_buffer write end_io
 handler
Message-ID: <20230309152224.GF17952@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-14-hch@lst.de> <7b12d1ea-79dd-211c-9eca-84ff453e20e5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b12d1ea-79dd-211c-9eca-84ff453e20e5@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 02:10:51PM +0000, Johannes Thumshirn wrote:
> > +	end_extent_buffer_writeback(eb);
> >  
> > -	bio_put(bio);
> > +	bio_put(&bbio->bio);
> >  }
> >  
> 
> 
> Can we merge end_extent_buffer_writeback() here? It's a 3 line function
> that get's only called once after this change.

I can add a patch for that.
