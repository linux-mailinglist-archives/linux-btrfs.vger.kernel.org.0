Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2688702863
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjEOJZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbjEOJZP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 05:25:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B224A2118
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 02:23:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7EA7668C4E; Mon, 15 May 2023 11:22:55 +0200 (CEST)
Date:   Mon, 15 May 2023 11:22:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        naohiro.aota@wdc.com
Subject: Re: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied
 buffers
Message-ID: <20230515092254.GA21580@lst.de>
References: <20230508145839.43725-1-hch@lst.de> <20230508145839.43725-4-hch@lst.de> <20230509225737.GK32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509225737.GK32559@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 10, 2023 at 12:57:37AM +0200, David Sterba wrote:
> On Mon, May 08, 2023 at 07:58:39AM -0700, Christoph Hellwig wrote:
> > When btrfs_redirty_list_add redirties a buffer, it also acquires
> > an extra reference that is released on transaction commit.  But
> > this is not required as buffers that are dirty or under writeback
> > are never freed (look for calls to extent_buffer_under_io())).
> > 
> > Remove the extra reference and the infrastructure used to drop it
> > again.
> 
> I vaguely remember that the redirty list was need for zoned to avoid
> some write pattern that disrupts the ordering, added in d3575156f662
> ("btrfs: zoned: redirty released extent buffers").

So the redirting itself is needed for that - without it buffers where
the dirty bit wasn't ever set would never get written, leading to a
write outside of the zone pointer.  But the extra reference can't
influece the write pattern, as we don't make writeback descriptions
based of it.

> I'd appreciate more eyes on this patch, with the indirections and
> writeback involved it's not clear to me that we don't need the list at
> all.

My suspicision is that Aoto-san wanted the extra safety of the extra
reference because he didn't want to trust or hadn't noticed the
extent_buffer_under_io() magic.  Auto-san, can you confirm or deny? :)
