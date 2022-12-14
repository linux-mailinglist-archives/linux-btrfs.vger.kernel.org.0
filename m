Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA4164CE46
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 17:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiLNQp2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 11:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiLNQpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 11:45:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4F15709
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 08:45:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9EA8168AA6; Wed, 14 Dec 2022 17:45:19 +0100 (CET)
Date:   Wed, 14 Dec 2022 17:45:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/8] btrfs: cleanup scrub_rbio
Message-ID: <20221214164519.GA13110@lst.de>
References: <20221213084123.309790-1-hch@lst.de> <20221213084123.309790-6-hch@lst.de> <083cd81a-644e-a054-80c1-1b3b902ff6e9@gmx.com> <20221213132433.GA21430@lst.de> <d4124214-f09b-5089-38c8-47f29a07b7d5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4124214-f09b-5089-38c8-47f29a07b7d5@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 07:32:00AM +0800, Qu Wenruo wrote:
>
> One personal thing is, I'd prefer "_wait_" for functions that may wait for 
> IOs. Thus submit_read_bios() may be better renamed to 
> submit_read_wait_bios().
> (bios means it still directly handle a bio list, or just 
> submit_read_wait_bio_list()?)

I can do either one.

>
> Another changes is, since there is no bio_list out of the 
> <work>_read_bios(), the "bios" naming can be removed.
> Something like <work>_read_wait() may be a little better.

Sure.
