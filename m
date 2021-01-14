Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782522F655E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbhANQCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 11:02:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:38978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbhANQCH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:02:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DFEEAC24;
        Thu, 14 Jan 2021 16:01:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18E4FDA7EE; Thu, 14 Jan 2021 16:59:45 +0100 (CET)
Date:   Thu, 14 Jan 2021 16:59:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Mark Harmstone <mark@harmstone.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Per-subvol compat flags?
Message-ID: <20210114155944.GX6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Mark Harmstone <mark@harmstone.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <805c2fd3-d62b-2d0f-0f3d-c275609bd1b5@harmstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <805c2fd3-d62b-2d0f-0f3d-c275609bd1b5@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Sun, Dec 27, 2020 at 04:07:44PM +0000, Mark Harmstone wrote:
> I'm the creator of the Windows Btrfs driver. During the course of development,
> it's become apparent that for 100% compatibility with NTFS there'd need to be
> some minor changes to the disk format. Examples: Windows' LZNT1 compression
> scheme, Windows' encryption scheme, case-sensitivity, arbitrary-length xattrs.
> 
> I'm loathe to nab a compat flag bit for these, as they're all relatively minor,
> and most wouldn't be that useful for Linux. And sod's law says that if I
> unilaterally grab the next bit, the Linux driver will sooner or later use the
> same bit for something else.
> 
> Has anyone ever brought up the idea of per-subvol compat flags? The idea is that
> if a new feature affects the FS root and nothing else, rather than adding a new
> compat flag bit, there'd be an entry in the root tree after the ROOT_ITEM, e.g.

The compat bits have affected the whole filesystem so far and we don't
have an example to follow. Per-subvolume flags in general make sense,
I'm not sure about the compat flags though, namely because of the
feedback to the user when such subvolume is being accessed. A failed
mount vs 'cannot cd to the subvolume directory'.

>     (0x100, 0x85, 0x2ed1c081232d)   for a compat entry, or
>     (0x100, 0x86, 0x85f7583bc4b0)   for a readonly compat entry

This means allocating 2 more key types, which are considered a precious
resource so I'd rather look for other options:

- regular subvolume flags (btrfs_root_item::flags), so far there's just
  one BTRFS_ROOT_SUBVOL_RDONLY, out of 64 in total, reserving eg. 8 for
  the windows driver sounds viable

- properties attached to the subvolume inode (stored in xattrs), this
  would be in a namespace btrfs.* and brings some questions as the
  property/xattr namespace is not yet clearly defined

- enhance existing key + item, which would be BTRFS_PERSISTENT_ITEM_KEY,
  key is fixed but objectid and offset are basically unused, the format
  would be like
  (COMPAT_FEATURE_..., PERSISTENT_ITEM_KEY, subvolid)
  stored in the subvolume tree

> With the third number being an arbitrary identifier for the feature (i.e. like
> a UUID). If the driver doesn't understand a certain feature, it'd make the
> subvol readonly or inaccessible, as appropriate.

This should work with all the types above, assuming the driver needs to
lookup the compat bits before accessing the subvolume. Each type has
some pros/cons, I'd favor the PERSISTENT_ITEM as I once repurposed the
specific key for such extensions.

> It'd also have to disable
> certain features, such as balancing, but the rest of the FS would be usable.

> As I see it, there's several advantages to this approach:
> 
> * Because the feature identifier is a 64-bit integer rather than a bit, it
>   increases the effective compat flag namespace from 64 bits to 2^64.

Besides the root_item::flags, the space for features is essentially
unlimited.

> * It makes out-of-tree development a lot easier, as the increased namespace
>   makes it feasible to distribute patches without worrying about what's
>   going to happen upstream.

I'd rather have all patches upstream, but realistically it'd be a
nightmare to manage and maintain. I know only about a handful of
features implemented in out of tree btrfs code (like on some NAS boxes)
and users have already seen problems when trying to access the
filesystem from a non-vendor kernel.

With more patches circling around, claiming feature bits in some
established namespace would be too encouraging I'm afraid and causing
chaos and incompatibility.

Given the raising popularity of btrfs windows driver, I wouldn't mind
reserving bits for windows-only use, possibly with some sane fallback
behaviour on linux too.

> * It lowers the cost of implementing new features (i.e., you don't have to
>   let users know that new filesystems will only work on Linux 5.x). This would
>   be especially important for encryption, as security means that you'd have to
>   make it easy to add new algorithms when necessary.

The kernel version of a feature is meant as a known point regardless of
potential backports in vendor trees. Feature status has been exported in
sysfs for that reason and is supposed to be checked instead of the
version.

Extensibility of encryption algorithms needs to be part of the design,
so I wouldn't use that one as an example, also because implementing that
is supposedly intrusive to many parts of the code.

> * It allows for features to be controlled by Linux CONFIG flags, meaning that
>   e.g. embedded devices wouldn't be burdened with a new feature for all time.

I'm not a fan of adding per-feature config options, that's shifting the
problems to a different stage. Not counting the debugging features like
integrity checker or ref-verify and a historic relic ACLs, there are
none. The main reason is to provide a filesystem driver with complete
feature set so it works everywhere the same.

I guess embedded usecase has to deal with limited resources or a
specialized purpose so more intrusive code changes are necessary. We're
more focused on the general usecase and try to keep it sane in terms of
number of features or configurability (and it's getting complicated
anyway).
