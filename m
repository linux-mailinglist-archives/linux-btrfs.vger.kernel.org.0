Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FDC421290
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhJDPXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 11:23:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41622 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhJDPXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 11:23:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D3D772021E;
        Mon,  4 Oct 2021 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633360889;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9HURKGqR1NPbWcs/8x5ImfjiDnimcXohJKfd7Cy0jQ=;
        b=sOzQg8xTp0dguae0WjUsPhLSlbhkigC1JEzyjkT+aywZ0ndhER+Nf0j4q86Gu9B09C4QJb
        K/LYHMJT5x6dnHmacDnulTRJRfkoV/6Fj264Pw4Z5n7QRH9xM5vbu3Y2SbYpxq6FClBEUd
        f2X8HiP3dD/6BEkWMO2aBVKkvpAlAE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633360889;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9HURKGqR1NPbWcs/8x5ImfjiDnimcXohJKfd7Cy0jQ=;
        b=KixvUHchiCbbdW0WKvvnryFq96OOg0ceeaU5Fww1MS+Wt2XDkVWVbnDVP8BLmaQSKj0jCI
        kh9uJVSxBYE62EDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CE26BA3BB4;
        Mon,  4 Oct 2021 15:21:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 94282DA7F3; Mon,  4 Oct 2021 17:21:10 +0200 (CEST)
Date:   Mon, 4 Oct 2021 17:21:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs-progs: property: ro->rw and received_uuid
Message-ID: <20211004152110.GZ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1633101904.git.dsterba@suse.com>
 <4c02eb0d00433fa95b77befecafcdf147c230f21.1633101904.git.dsterba@suse.com>
 <bfb7c505-64c4-5c11-8ab1-1d1377be6d25@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb7c505-64c4-5c11-8ab1-1d1377be6d25@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 04, 2021 at 01:10:30PM +0300, Nikolay Borisov wrote:
> > +		err = btrfs_util_get_subvolume_read_only(object, &is_ro);
> > +		if (err) {
> > +			error_btrfs_util(err);
> > +			return -errno;
> > +		}
> > +		/* No change if already read-only */
> > +		if (is_ro && read_only)
> > +			return 0;
> > +
> > +		err = btrfs_util_subvolume_info(object, 0, &info);
> > +		if (err)
> > +			warning("cannot read subvolume info\n");
> > +		if (is_ro && !uuid_is_null(info.received_uuid)) {
> > +			printf("ro->rw switch but has set receive_uuid\n");
> > +
> > +			if (force) {
> > +				do_clear_received_uuid = true;
> 
> So you'll require the user to explicitly pass -f in order to clear
> received uuid when switching ro->rw but otherwise you are not actively
> preventing the user to continue relying on invalid behavior.

At first I'm solving the problem where it happens, ie. in most cases
switching the ro->rw by the command. As this is in user space and does
not rely on kernel changes it will affect users with old stable trees
after progs update. The kernel fixes go in parallel.

> > +			} else {
> > +				printf("cannot flip ro->rw with received_uuid set, use force\n");
> > +				return -EPERM;
> > +			}
> > +		}
> > +		if (!is_ro && !uuid_is_null(info.received_uuid))
> > +			warning("read-write subvolume with received_uuid, this is bad");
> 
> Do you intend to augment this error message or not, I know this is just
> a prototype but I wonder what would a useful text here look like. Ok you
> are going to warn the user what they are doing is wrong but you won't
> stop them from doing it so how is this preventing possible future
> streams of people coming to the mailing list and complaining that their
> incremental send isn't working or that they are experiencing silent data
> corruptions following in incremental send?

You mean that people will still come in the future even with these
changes in progs? The warning is a placeholder, the explanation will be
long and pointing to some specific steps what to do to resolve the
prolbem.

> In contrast, my approach is to have btrfs progs check

This is on a different level, 'check' works on an unmounted filesystem
and is not recommended to be run just because. Also I don't like much to
add yet another one-shot fix that would be probably more suitable for
command like 'rescue' group.

> scan for such
> cases and when it finds them to directly clear the received_uuid as part
> of a --repair switch.

With repair? No. It can be part of check to report but as it's not a
structural damage, it's not the best place and for a specific fix the
scope of --repair is too big.

> >  
> >  		err = btrfs_util_set_subvolume_read_only(object, read_only);
> 
> So indeed, you are not preventing the users from continuing to exercise
> the invalid behavior.

So I think that's the source of the disagreement or misunderstanding.
I'm looking for preventing the problem to happen in the first place, you
keep repeating 'continue the invalid behaviour'.  Yes we need to deal
with the existing rw+received_uuid too and will eventually.

> >  		if (err) {
> >  			error_btrfs_util(err);
> >  			return -errno;
> >  		}
> > +		if (do_clear_received_uuid) {
> > +			int ret;
> > +
> > +			printf("force used, clearing received_uuid\n");
> > +			ret = subvolume_clear_received_uuid(object);
> 
> The fact that this can't be made atomic w.r.t setting RO (from user
> space) just demonstrates this is somewhat fragile. Even after someone
> running btrfs property set -f and a crash occurs it's possible they end
> up with a subvol.

Yeah that's true, both ioctls call commit so there's an intermediate
state when RW is committed and uuid is not reset.

> My approach on the other hands solves this on the kernel side where we
> can make the ro->rw switch + received_uuid clear atomic.

That would be better but slightly changes the semantics of the setflags
ioctl, lacking the similar force flag like userspace does.
