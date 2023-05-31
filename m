Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907137174FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjEaEQc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjEaEQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:16:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CFDBE
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:16:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99A8668B05; Wed, 31 May 2023 06:16:26 +0200 (CEST)
Date:   Wed, 31 May 2023 06:16:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        naohiro.aota@wdc.com
Subject: Re: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied
 buffers
Message-ID: <20230531041626.GA32582@lst.de>
References: <20230508145839.43725-1-hch@lst.de> <20230508145839.43725-4-hch@lst.de> <20230509225737.GK32559@twin.jikos.cz> <20230515092254.GA21580@lst.de> <20230530155648.GB30110@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155648.GB30110@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 05:56:48PM +0200, David Sterba wrote:
> > > I'd appreciate more eyes on this patch, with the indirections and
> > > writeback involved it's not clear to me that we don't need the list at
> > > all.
> > 
> > My suspicision is that Aoto-san wanted the extra safety of the extra
> > reference because he didn't want to trust or hadn't noticed the
> > extent_buffer_under_io() magic.  Auto-san, can you confirm or deny? :)
> 
> The number of patches above this one in the queue is increasing so it
> would get harder to remove it. I took another look and agree that
> regarding the references it's safe but would still like a confirmation.

As stated, I am very confident that this is safe based on all my
recent work with the extent_buffer code base.  I'd love to hear
from Aota, but there's not much more I can add here myself.
