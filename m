Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A86B8AEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCNGJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNGJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:09:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB203977D
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:09:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61A6968AA6; Tue, 14 Mar 2023 07:09:17 +0100 (CET)
Date:   Tue, 14 Mar 2023 07:09:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/20] btrfs: always read the entire extent_buffer
Message-ID: <20230314060917.GD25047@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-5-hch@lst.de> <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 09, 2023 at 11:29:54AM +0000, Johannes Thumshirn wrote:
> > -		if (!PageUptodate(page)) {
> > -			num_reads++;
> > +		if (!PageUptodate(page))
> >  			all_uptodate = 0;
> > -		}
> 
> I think we could also break out of the loop here. As soon as
> one page isn't uptodate we don't care about the fast path anymore.

FYI, I've decided to keep this as-is for the next version as the
code is gone by the end of the series anyway.
