Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E64DB84C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbiCPS6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiCPS6r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 14:58:47 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB46E4DE
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:57:33 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 5885083F69; Wed, 16 Mar 2022 14:57:32 -0400 (EDT)
References: <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com>
 <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
 <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net> <Yi/I54pemZzSrNGg@hungrycats.org>
 <87fsnjnjxr.fsf@vps.thesusis.net> <YjD/7zhERFjcY5ZP@hungrycats.org>
User-agent: mu4e 1.7.0; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Ziak <0xe2.0x9a.0x9b@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Date:   Wed, 16 Mar 2022 14:46:33 -0400
In-reply-to: <YjD/7zhERFjcY5ZP@hungrycats.org>
Message-ID: <877d8twwrn.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:

> If the extent is compressed, you have to write a new extent, because
> there's no other way to atomically update a compressed extent.

Right, that makes sense for compression.

> If it's reflinked or snapshotted, you can't overwrite the data in place
> as long as a second reference to the data exists.  This is what makes
> nodatacow and prealloc slow--on every write, they have to check whether
> the blocks being written are shared or not, and that check is expensive
> because it's a linear search of every reference for overlapping block
> ranges, and it can't exit the search early until it has proven there
> are no shared references.  Contrast with datacow, which allocates a new
> unshared extent that it knows it can write to, and only has to check
> overwritten extents when they are completely overwritten (and only has
> to check for the existence of one reference, not enumerate them all).

Right, I know you can't overwrite the data in place.  What I'm not
understanding is why you can't just just write the new data elsewhere
and then free the no longer used portion of the old extent.

> When a file refers to an extent, it refers to the entire extent from the
> file's subvol tree, even if only a single byte of the extent is contained
> in the file.  There's no mechanism in btrfs extent tree v1 for atomically
> replacing an extent with separately referenceable objects, and updating
> all the pointers to parts of the old object to point to the new one.
> Any such update could cascade into updates across all reflinks and
> snapshots of the extent, so the write multiplier can be arbitrarily large.

So the inode in the subvol tree points to an extent in the extent tree,
and then the extent points to the space on disk?  And only one extent in
the extent tree can ever point to a given location on disk?

In other words, if file B is a reflink copy of file A, and you update
one page in file B, it can't just create 3 new extents in the extent
tree: one that refers to the firt part of the original extent, one that
refers to the last part of the original extent, and one for the new
location of the new data?  Instead file B refers to the original extent,
and to one new extent, in such a way that the second superceeds part of
the first only for file B?

