Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B8D64925F
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Dec 2022 05:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLKE5A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 10 Dec 2022 23:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKE45 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Dec 2022 23:56:57 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82C3A12D21
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Dec 2022 20:56:55 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id D01076668EB; Sat, 10 Dec 2022 23:56:53 -0500 (EST)
Date:   Sat, 10 Dec 2022 23:56:53 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     benibr@domainmess.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature Request: Subvolume Expiration
Message-ID: <Y5VjFfo3aZqyWH5I@hungrycats.org>
References: <a3c94f14eb13667ff5dba3cb9455b875@domainmess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <a3c94f14eb13667ff5dba3cb9455b875@domainmess.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 05, 2022 at 01:28:42PM +0000, benibr@domainmess.org wrote:
> Hi everyone,
> 
> I'd like to propose "subvolume expiration dates" as a new feature for btrfs.
> 
> I want to use btrfs for archiving and backup solutions for which snapshots are very convenient.
> However, the rotation and cleanup of snapshots is always based on some scripting and often
> reimplemented for each usecase.
> I know at least some proprietary storage solutions which allow to set a expiration date on
> snapshots so I wonder if it would be possible to add a similar functionality to btrfs.
> The advantage would be that one doesn't have to encode the expiry information in the subvolume name
> or parse it from an extended file attribute but it would be an (optional) attribute of the
> subvolume itself.

I can understand not wanting to encode it in the filename, but this
is exactly the sort of use case that extended attributes are for:
attaching new bits of information to btrfs objects that are useful
for userspace tools but not useful for the kernel.

> Therefore it would be easy to implement a subcommand in btrfs-progs which checks for expired
> subvolumes and deletes them (eg. `btrfs subvolume prune` or similar).
> This would make btrfs a very easy to use solution for archiving data for a specific timespan as
> well as for backup snapshot rotations.
> 
> As I understand it I'd say the expiration date could be implemented in the `root_item` struct by
> squeezing in a additional `btrfs_timespec` into the `reserved` space.

These fields (and there will always be more fields for these kinds of
use cases) can be stored in xattrs on the subvol root dir.  Nothing in
the kernel needs to know anything about them.  Userspace can parse the
expiration date xattr, compare to the current date, and issue subvol
delete commands for subvols where one is less than the other.

The gotcha is that it's not easy to store xattrs on subvol roots.
They can be read-only, and making them read-write so you can set an
xattr (e.g. change the expiration date) breaks btrfs incremental sends.

You can avoid the read-only problems by setting an expiration date xattr
on the origin subvol before making a snapshot.  You'd have to find some
way to remove the risk that the origin subvol ends up with an expiration
date that another tool notices before you can remove the expiration date
from the origin subvol.  Also the xattrs will be transmitted by btrfs
send, rsync -X, and possibly other tools, and it's not always the case
that the received subvol should have the same attribute values as the
origin subvol.  This isn't ideal--you wouldn't want your short-lived
origin subvols to move to an archive server and be promptly deleted for
being too old.

So we'd need some way to store xattrs for a subvol, but somehow avoid
to storing them in the subvol itself.  It looks like the root tree is
ideally set up for that--just add XATTR items to the tree alongside the
existing root_items, and add some way for userspace to get and set them.
They would be outside of the subvol, so they are not affected by subvol
read-only state, and not copied or snapshotted with the subvol contents,
but still uniquely associated with one instance of the subvol on one
filesystem, and still follow the subvol around if it is renamed.

Without a sane place to store xattrs and without modifying the kernel, it
makes the most sense to simply store expiration times in a tool-specific
external database, and let that tool manage the whole lifecycle of the
subvols it knows about.  That way there's no possibility of cross-tool
confusion, and no need to implement new kernel-space interfaces to access
xattrs in a previously unused part of the filesystem.  This approach
basically reduces to "install a subvol management tool to solve this
problem in an appropriate way for your use case" and likely contributes
to why there are so many fine subvol management tools available today.

> But since I'm not really familiar with btrfs code I wanted to ask for more opinions before I spend
> time on a proof-of-concept.
> 
> So is this feature interesting, absurd, nice to have or completely impossible?
> Any feedback welcome :-)
> 
> Regards,
> Beni
