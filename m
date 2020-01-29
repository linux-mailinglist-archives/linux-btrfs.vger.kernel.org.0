Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40B914CE08
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 17:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgA2QMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 11:12:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:50088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgA2QMg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 11:12:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8699ADB3;
        Wed, 29 Jan 2020 16:12:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21DFDDA730; Wed, 29 Jan 2020 17:12:14 +0100 (CET)
Date:   Wed, 29 Jan 2020 17:12:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.de>
Cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Message-ID: <20200129161214.GJ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.de>,
        linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200127024817.15587-1-marcos.souza.org@gmail.com>
 <20200128172638.GA3929@twin.jikos.cz>
 <fd8a3cb87b1084e5ab68fdcb60f7af3c6b6265d1.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8a3cb87b1084e5ab68fdcb60f7af3c6b6265d1.camel@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 29, 2020 at 12:07:40PM -0300, Marcos Paulo de Souza wrote:
> > > -	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
> > > -	namelen = strlen(vol_args->name);
> > > -	if (strchr(vol_args->name, '/') ||
> > > -	    strncmp(vol_args->name, "..", namelen) == 0) {
> > > -		err = -EINVAL;
> > > -		goto out;
> > > +		if (!(vol_args2->flags & BTRFS_SUBVOL_BY_ID)) {
> > > +			err = -EINVAL;
> > > +			goto out;
> > 
> > The flag validation needs to be factored out of the if. First
> > validate,
> > then do the rest. For backward compatibility, the v1 ioctl must take
> > no
> > flags, so if theres BTRFS_SUBVOL_BY_ID for v1, it needs to fail. For
> > v2
> > the flag is optional.
> 
> Only vol_args_v2 has the flags field, so for current
> BTRFS_IOC_SNAP_DESTORY there won't be any flags. If we drop the check
> for BTRFS_SUBVOL_BY_ID in BTRFS_IOC_SNAP_DESTORY_V2, so won't check for
> this flag at all, making it meaningless.

Oh right, so the validation applies only to v2 and in that case it's
fine to keep it in the place you have it.

> What do you think? Should we drop this flag at all and just rely in the
> ioctl number + subvolid being informed?

No, v2 should work for both deletion by name and by id. It's going to
supersede v1 that has to stay for backward compatibility, but must
provide complete functionality of v1 to keep the usability sane.
