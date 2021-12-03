Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC324675F9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380304AbhLCLRW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 06:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbhLCLRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 06:17:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A927C06173E
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 03:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FF93B8269B
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 11:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B89C53FC7;
        Fri,  3 Dec 2021 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530027;
        bh=sMP13Sq3mV91RIkNgGpneL1ZMzNafwAf+iQkThCI5sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4b7lBr6CQ02H8U65V+5vnAv8VuLEhFMneamAxJYSmtA8CYMI5vFQfb1wQrXKCNU8
         1thCfOmvAYbIIhywRxAZZd+oS5yeMqg2LyepKdYG4VbbL41XbkJ/7vahsz6ABdgVPZ
         dXGb9tqJfJtokWMazEsBEeTethSzUhfVbVHy3+Jqvfuzg6/3BTdtTMkTlMfyXy944O
         zJ9Ucj6T3s/AbXFWWLtLHstw2RBTrKtngg+hPQNh5RXO+iUlKQ6dssMu003M66Uy7g
         FncfmHuGgbFAnAyKQb2KubC0lencPrIuAxSgsjIg2hWmh5SjOCc8Zc/R79BNFqi1Pq
         dva79L2PYbMuw==
Date:   Fri, 3 Dec 2021 11:13:44 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix a failure when looking for data
 backrefs after relocation
Message-ID: <Yan76IDfL2R0rrRS@debian9.Home>
References: <829076d580be74f270e740f8dded6fda45390311.1638440202.git.fdmanana@suse.com>
 <YakecWBMcRKlPdGa@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YakecWBMcRKlPdGa@localhost.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 02:28:49PM -0500, Josef Bacik wrote:
> On Thu, Dec 02, 2021 at 10:21:43AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > During a send, when trying to find roots from which to clone data extents,
> > if the leaf of our file extent item was obtained before relocation for a
> > data block group finished, we can end up trying to lookup for backrefs
> > for an extent location (file extent item's disk_bytenr) that is not in
> > use anymore. That is, the extent was reallocated and the transaction used
> > for the relocation was committed. This makes the backref lookup not find
> > anything and we fail at find_extent_clone() with -EIO and log an error
> > message like the following:
> > 
> >   [ 7642.897365] BTRFS error (device sdc): did not find backref in send_root. inode=881, offset=2592768, disk_byte=1292025856 found extent=1292025856
> > 
> > This is because we are checking if relocation happened after we check if
> > we found the backref for the file extent item we are processing. We should
> > do it before, and in case relocation happened, do not attempt to clone and
> > instead fallback to issuing write commands, which will read the correct
> > data from the new extent location. The current check is being done too
> > late, so fix this by moving it to right after we do the backref lookup and
> > before checking if we found our own backref.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> I'm not against this in principal, but won't we come all the way back out of
> this loop and re-search higher up because things changed?  Can we just do a
> -EAGAIN, come out and re-search down to this key so we can still do the clone
> properly?  If we can't then this is reasonable, but I'd like to avoid blowing up
> a send stream because relocation was running if at all possible.

It could be done, but I didn't do it that way because:

1) Mostly to keep it as simple as possible initially.

2) I wanted to avoid the possibility of too many tree re-searches.
   Though I have seen it happens rarely at find_extent_clone() during my
   testing, and that's because we do the check and re-search before advancing
   to the next key in the tree iteration code (full_send_tree() and
   btrfs_compare_trees()).

   Overall I haven't seen an excessive number of re-searches, and when they
   happen they are cheap as the extent buffers are already in memory.

   But I plan on later to eliminate some unnecessary re-searches, by keeping
   track of what kind of block group was relocated (data/metadata/system) and
   its logical range.

   For now I wanted to make sure that it always produces corrects results and
   that performance is acceptable. As it is it may ocassionaly issues write
   operations instead of clone operations, but again it rarely happens and we
   already have a few cases where we skip cloning anyway (too many extent refs
   and a few edge cases).

Seems reasonable?

Thanks.

> 
> Josef
