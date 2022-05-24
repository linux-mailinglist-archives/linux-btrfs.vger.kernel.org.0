Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5235329FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbiEXMIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 08:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbiEXMIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 08:08:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3569732
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 05:08:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC1C168AFE; Tue, 24 May 2022 14:08:47 +0200 (CEST)
Date:   Tue, 24 May 2022 14:08:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Message-ID: <20220524120847.GA18478@lst.de>
References: <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com> <20220522123108.GA23355@lst.de> <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com> <20220522125337.GB24032@lst.de> <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com> <20220523062636.GA29750@lst.de> <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com> <20220524073216.GB26145@lst.de> <6047f29e-966d-1bf5-6052-915c1572d07a@gmx.com> <b78b6c09-eb70-68a7-7e69-e8481378b968@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78b6c09-eb70-68a7-7e69-e8481378b968@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 24, 2022 at 04:21:38PM +0800, Qu Wenruo wrote:
>> The things like resetting initial_mirror, making the naming "initial"
>> meaningless.
>> And the reset on the length part is also very quirky.
>
> In fact, if you didn't do the initial_mirror and length change (which is
> a big disaster of readability, to change iterator in a loop, at least to
> me),

So what is the big problem there?  Do I need more extensive documentation
or as there anything in this concept that is just too confusing.

> and rely on the VFS re-read behavior to fall back to sector by
> secot read, I would call it better readability...

I don't think relying on undocumented VFS behavior is a good idea.  It
will also not work for direct I/O if any single direct I/O bio has
ever more than a single page, which is something btrfs badly needs
if it wants to get any kind of performance out of direct I/O.
