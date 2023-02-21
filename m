Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD769E266
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 15:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjBUOei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 09:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbjBUOeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 09:34:37 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C22F26846
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 06:34:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 06F8968B05; Tue, 21 Feb 2023 15:34:34 +0100 (CET)
Date:   Tue, 21 Feb 2023 15:34:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/12] btrfs: simplify submit_extent_page
Message-ID: <20230221143433.GE29949@lst.de>
References: <20230216163437.2370948-1-hch@lst.de> <20230216163437.2370948-13-hch@lst.de> <0af54f4b-34ff-3216-0503-51c8915b2aea@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af54f4b-34ff-3216-0503-51c8915b2aea@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 01:14:44PM +0000, Johannes Thumshirn wrote:
> On 16.02.23 17:35, Christoph Hellwig wrote:
> > +
> > +		if (bio_add_page(bio_ctrl->bio, page, len, pg_offset) != len) {
> > +			/* bio full: move on to a one */
> 
>                           to a "new" one?

Yes.
