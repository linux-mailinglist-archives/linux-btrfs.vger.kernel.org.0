Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5C5AFFEC
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiIGJIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiIGJIi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 05:08:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909EB07F6
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 02:08:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AD776732D; Wed,  7 Sep 2022 11:08:27 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:08:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs I/O completion cleanup and single device I/O
 optimizations v2
Message-ID: <20220907090826.GA31659@lst.de>
References: <20220713061359.1980118-1-hch@lst.de> <20220906131201.GM13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906131201.GM13489@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 06, 2022 at 03:12:01PM +0200, David Sterba wrote:
> Let me point out one example, the 5/11 "btrfs: remove
> bioc->stripes_pending". The subject gives a false idea what's going on.
> There was a member removed, yes but the whole logic regarding bios is
> changed, it's now using the bio chaining, as mentioned in the first
> paragraph at least. Other patches state in words what the code does, not
> explaining why.

Maybe I'm just too familiar with the block code to not agree with you,
as to me these changes are totally obvious.  But as I often point out:
if an experienced developers asks questions that seem obvious to me
my changelogs are not good enough.  But asking for that after the series
has been out for a month and a half is a bit silly.  Please comment
on these patches in a somewhat timely fashion if you think the
changelogs are not good, and I will update them in a timely fashion.

