Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83263A1C0E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhFIRq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 13:46:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhFIRq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 13:46:28 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2506021962;
        Wed,  9 Jun 2021 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623260673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ei0ME4XdPwnISLgb1h8lPCMxzehHtJo+fArhgbZoKAQ=;
        b=YjiOv1bR9ba/Rb8h5HkjTPiKNGd6nhSaG1x/Q2bDufIv3MA/MmTg4Au/tYBgqkx/SKhHxt
        7o+KL07fYFJCmAdNXF8WCeGZ8XC9K1vY7yo4c0ePR6+zoJXTafZdQ6rz9UjUGDg+3yLxi4
        VKMOaiPGZizNEnsjhaJ0NVZGaL1uqLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623260673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ei0ME4XdPwnISLgb1h8lPCMxzehHtJo+fArhgbZoKAQ=;
        b=41jMOqE8+sS3smCK9uB2VqwDIxwBg5ofRJFzDWMBmZI56bYqKdN8hq7WaZAUro2a7X+Wh+
        Ss6F3bnEhxuhu3Ag==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A46AD118DD;
        Wed,  9 Jun 2021 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623260673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ei0ME4XdPwnISLgb1h8lPCMxzehHtJo+fArhgbZoKAQ=;
        b=YjiOv1bR9ba/Rb8h5HkjTPiKNGd6nhSaG1x/Q2bDufIv3MA/MmTg4Au/tYBgqkx/SKhHxt
        7o+KL07fYFJCmAdNXF8WCeGZ8XC9K1vY7yo4c0ePR6+zoJXTafZdQ6rz9UjUGDg+3yLxi4
        VKMOaiPGZizNEnsjhaJ0NVZGaL1uqLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623260673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ei0ME4XdPwnISLgb1h8lPCMxzehHtJo+fArhgbZoKAQ=;
        b=41jMOqE8+sS3smCK9uB2VqwDIxwBg5ofRJFzDWMBmZI56bYqKdN8hq7WaZAUro2a7X+Wh+
        Ss6F3bnEhxuhu3Ag==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id lfBAGv/9wGDoNwAALh3uQQ
        (envelope-from <mpdesouza@suse.de>); Wed, 09 Jun 2021 17:44:31 +0000
Message-ID: <b70c23ab25fe327b8a4a18511a5d1b2d1c2ae3f5.camel@suse.de>
Subject: Re: [PATCH] btrfs: Add new flag to rescan quota after subvolume
 creation
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
Date:   Wed, 09 Jun 2021 14:44:45 -0300
In-Reply-To: <20210525162054.GE7604@twin.jikos.cz>
References: <20210521143811.16227-1-mpdesouza@suse.com>
         <20210525162054.GE7604@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-05-25 at 18:20 +0200, David Sterba wrote:
> On Fri, May 21, 2021 at 11:38:11AM -0300, Marcos Paulo de Souza
> wrote:
> > Adding a new subvolume/snapshot makes the qgroup data inconsistent,
> > so
> > add a new flag to inform the subvolume ioctl to do a quota rescan
> > right
> > after the subvolume/snapshot creation.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > 
> >  This is an attempt to help snapper to create snapshots with
> > 'timeline'
> >  cleanup-policy to keep the qgroup data consistent after a new
> > snapshot is
> >  created.
> 
> I'm not sure adding something like rescan into subvolume creation. It
> can be started separately as a workaround. The problem I see is that
> there are two big things happening and both can fail, but there's
> only
> one return value and the user can tell which one failed.

Agreed. Indeed, it's much easier to issue another ioctl to do a quota
rescan.

> 
> > +	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_RESCAN) {
> > +		if (!capable(CAP_SYS_ADMIN)) {
> > +			ret = -EPERM;
> 
> Eg. here, did the subvolume creation fail due to EPERM, or the
> rescan?

Agreed.

> 
> > +			goto free_args;
> > +		}
> > +
> > +		quota_rescan = true;
> > +	}
> > +
> >  	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
> >  		readonly = true;
> >  	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
> > @@ -1843,6 +1869,22 @@ static noinline int
> > btrfs_ioctl_snap_create_v2(struct file *file,
> >  					subvol, readonly, inherit);
> >  	if (ret)
> >  		goto free_inherit;
> > +
> > +	if (quota_rescan) {
> > +		ret = do_quota_rescan(file);
> > +		/*
> > +		 * EINVAL is returned if quota is not enabled. There is
> > already
> > +		 * a warning issued if quota rescan is started when
> > quota is not
> > +		 * enabled, so skip a warning here if it is the case.
> > +		 */
> > +		if (ret < 0 && ret != -EINVAL)
> > +			btrfs_warn(btrfs_sb(file_inode(file)->i_sb),
> > +		"Couldn't execute quota rescan after snapshot creation:
> > %d",
> > +					ret);
> > +		else
> > +			ret = 0;
> 
> That's another special case and the system error message is required
> to
> interpret the error code but we've seen in the past that this is not
> a
> good usability pattern.

Agreed.

> 
> > +#define BTRFS_SUBVOL_QGROUP_RESCAN	(1ULL << 5)
> > +
> >  #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
> >  			(BTRFS_SUBVOL_RDONLY |		\
> >  			BTRFS_SUBVOL_QGROUP_INHERIT |	\
> >  			BTRFS_DEVICE_SPEC_BY_ID |	\
> > -			BTRFS_SUBVOL_SPEC_BY_ID)
> > +			BTRFS_SUBVOL_SPEC_BY_ID |	\
> > +			BTRFS_SUBVOL_QGROUP_RESCAN)
> 
> The idea of bits is to extend mode of operation of the ioctls, not to
> proxy other functionality. What I'd see as reasonable would be
> something
> like conditionally marking the quotas inconsistent by setting a bit
> after snapshot creation and when quotas are enabled. But the snapshot
> creation should do only snapshot creation.

It's much easier to change snapper in order to execute a quota rescan
when the quota data is inconsistent (due to a new snapshot being
created for example).


