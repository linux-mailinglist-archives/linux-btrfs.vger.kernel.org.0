Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F622F661A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbhANQkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 11:40:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbhANQkE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:40:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19BF3AEBB;
        Thu, 14 Jan 2021 16:39:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2B1FDA7EE; Thu, 14 Jan 2021 17:37:29 +0100 (CET)
Date:   Thu, 14 Jan 2021 17:37:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Why do we need these mount options?
Message-ID: <20210114163729.GY6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Thu, Jan 14, 2021 at 03:12:26AM +0100, waxhead wrote:
> I was looking through the mount options and being a madman with strong 
> opinions I can't help thinking that a lot of them does not really belong 
> as mount options at all, but should rather be properties set on the 
> subvolume - for example the toplevel subvolume.

I agree that some of them should not be there but mount options still
have their own usecase. They can be set from the outside and are
supposed to affect the whole filesystem mount lifetime.

However, they've been used as default values for some operations, which
is something that points more to what you suggest. And as they're not
persistent and need to be stored in /etc/fstab is also weighing for
storage inside the fs.

> And any options set on a child subvolume should override the parrent 
> subvolume the way I see it.

Yeah, that's one of the ways how to do it and I see it that way as well.
Property set closer to the object takes precedence, roughly

mount < subvolume < directory < file

but last time we had a discussion about that, the other oppinion was
that mount options beat everything, perhaps because they can be set from
the outside and forced to ovrride whatever is on the filesystem.

> By having a quick look - I don't see why these should be mount options 
> at all.
> 
> autodefrag / noautodefrag
> commit
> compress / compress-force
> datacow / nodatacow
> datasum / nodatasum
> discard / nodiscard
> inode_cache / noinode_cache
> space_cache / nospace_cache
> sdd / ssd_spread / nossd / no_ssdspread
> user_subvol_rm_allowed

So there are historical reasons and interface limitations that led to
current state and multiple ways to do things.

Per-inode attributes were originally private ioctl of ext2 that other
filesystems adopted due to feature parity, and as the interface was
bit-based, no additional values could be set eg. compression, limited
number of bits, no precedence, inter-flag dependencies.

> Stuff like compress and nodatacow can be set with chattr so there is as 
> far as I am aware three methods of setting compression for example.
> 
> Either by mount options in fstab, by chattr or by btrfs property set
> 
> I think it would be more consistent to have one interface for adjusting 
> behavior.

I agree with that and there's a proposal to unify that into the
properties as interface once for all, accessible through the extended
attributes. But there are much more ways how to do that wrong so it
hasn't been implemented so far.

A suggestion for an inode flag here and there comes from time to time,
fixing one problem each time. Repeating that would lead to a mess that
can be demonstrated on the existing mount options, so we've been there
and need to do it the right way.

> As I asked before, the future plan to have different storage profiles on 
> subvolumes seem to have been sneakily(?) removed from the wiki

I don't think the per-subvolume storage options were ever tracked on
wiki, the closest match is per-subvolume mount options that's still
there

https://btrfs.wiki.kernel.org/index.php/Project_ideas#Per-subvolume_mount_options

> - if that is indeed a dropped goal I can see why it makes sense to
> keep the mount options, if not I think the mount options should go in
> favor of btrfs property set.
