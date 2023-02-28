Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909CB6A5188
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Feb 2023 03:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjB1C6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 21:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB1C6e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 21:58:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41AD1CF48
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 18:58:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2219067373; Tue, 28 Feb 2023 03:58:25 +0100 (CET)
Date:   Tue, 28 Feb 2023 03:58:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Message-ID: <20230228025824.GA26819@lst.de>
References: <20230227151704.1224688-1-hch@lst.de> <20230227151704.1224688-7-hch@lst.de> <4253c978-d19e-5032-913a-dafda476eded@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253c978-d19e-5032-913a-dafda476eded@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 27, 2023 at 04:20:54PM +0000, Johannes Thumshirn wrote:
> On 27.02.23 16:17, Christoph Hellwig wrote:
> > +		if (bio_ctrl->compress_type != this_bio_flag)
> > +			submit_one_bio(bio_ctrl);
> > +
> >  		if (force_bio_submit)
> >  			submit_one_bio(bio_ctrl);
> 
> 
> Sorry for not having noticed this earlier. But this looks odd TBH.
> 
> 		if (bio_ctrl->compress_type != this_bio_flag ||
> 		    force_bio_submit)
> 			submit_one_bio(bio_ctrl);

It does.  But with patch 8 it would stop working, as we must
uptdate the compress_type field after submitting the bio for that case.

Been there, done that and it broke :)
