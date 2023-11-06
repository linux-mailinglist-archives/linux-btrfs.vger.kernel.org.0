Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5B7E25FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 14:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKFNr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 08:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjKFNrY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 08:47:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2DC191
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 05:47:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3100AC433C9;
        Mon,  6 Nov 2023 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699278441;
        bh=Nris/B6yiOJMHyv9UxuC3AlAOoGJDtlQXUvrccNZ81I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQwiVt++BM0LzRUnlMyx/1NbuFPuXp3di76ujHY5+NkG0LUQVaFuBOYArzz127NVc
         u+X2Pl52bve7F3MgZ0d+lizz+kOAb273XyWTAB8axy7y7ma0wQsekY+ad955dSR87i
         bCRMO8AksWKee4PL+dOpI6ixT7B5rUloOFQ3E7sFmpkJPnmAihHeZMEIQkeV8IIUjX
         Xj8s1Gzx6QHE65HUjQTyPH76PZFl7g8B9mJ/loi2OblQruQ3DXIsu7N9MBEr9bV5An
         Spzyy3BkT73CCydUySlAaDv+ZkSFZyEqmUCv+9bUQMNqWcU9MsjQ6/PaBQcWY6iXR+
         LyHL8blDxRh2w==
Date:   Mon, 6 Nov 2023 14:47:16 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-unser-fiskus-9d1eba9fc64c@brauner>
References: <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUjcI1SE+a2t8n1v@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 06, 2023 at 04:29:23AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 06, 2023 at 11:03:37AM +0100, Christian Brauner wrote:
> > But why do we care?
> > Current code already does need to know it is on a btrfs subvolume. They
> > all know that btrfs subvolumes are special.
> 
> "they all know" is a bit vague.  How do you know "all" code knows?

Granted, an over-generalization but non in any way different from
claiming that currently on one needs to know about btrfs subvolumes or
that the proposed vfsmount solution will make it magically so that no
one needs to care anymore.

Tools will have to change either way is my point. And a lot of tools do
already handle subvolumes specially exactly because of the non-unique
inode situation. And if they don't they still can get confused by seing
st_dev numbers they can't associate with a filesystem.

> > They will need to know that
> > btrfs subvolumes are special in the future even if they were vfsmounts.
> > They would likely end up with another kind of confusion because suddenly
> > vfsmounts have device numbers that aren't associated with the superblock
> > that vfsmount belongs to.
> 
> Let's take a step back.  Posix says st_ino is uniqueue for a given
> st_dev, and per posix a mount mount is defined as any file that
> has a different st_dev from the parent.  So by the Posix definition
> btrfs subvolume roots are mount points, which is am obvios clash
> with the Linux definition based on vfsmounts.

3.229 Mount Point
Either the system root directory or a directory for which the st_dev
field of structure stat differs from that of its parent directory.

I think that's just an argument against mapping subvolumes to vfsmounts.
Because bind-mounts don't change the device number - and they very much
shouldn't.

> 
> > > > If userspace requests STATX_SUBVOLUME in the request mask, the two
> > > > filesystems raise STATX_SUBVOLUME in the statx result mask and then also
> > > > return the _real_ device number of the superblock and stop exposing that
> > > > made up device number.
> > > 
> > > What is a "real" device number?
> > 
> > The device number of the superblock of the btrfs filesystem and not some
> > made-up device number.
> 
> The block device st_dev is just as made up.
> 
> > I care about not making a btrfs specific problem the vfs's problem by
> > hoisting that whole problem space a level up by mapping subvolumes to
> > vfsmounts.
> 
> While I'd love to fix it, and evern more not have more of this
> crap sneak in (*cough* bcachefs, *cough*). І'm ok with that stance.
> But that also means we can't let this creep into the vfs by other
> means, which is what started the thread.

The thing is I'm not even sure there's anything to fix.

This discussion started with btrfs maybe getting an alternative way to
uniquify an inode independent of st_dev.

I'm not sure that is such a massive problem.

If we give both btrfs and bcachefs a single flag in statx() that allows
_interested_ userspace to query whether a file is located on a subvolume
that shouldn't be a problem (We have STATX_ATTR_* which identifies
additional properties that are restricted to few filesytems).

And all the specific gobbledigook can be implemented as an ioctl() -
ideally both btrfs and bcachefs agree on something - that the vfs
doesn't have to care about at all.

I genuinely don't care if they report a fake st_dev from stat(). I
genuinely _do_ care that we don't make vfsmounts privy to this.

Let alone that automounts are a giant paint. Not just do they iirc allow
to create shadow mounts, they also interact with namespace and container
creation.

If you spawn thousands of containers each with a private mount namespace
- which is the default - you now trigger automounts in thousands of
containers when triggering a lookup on btrfs. If you have mount
propagation turned on each automount may also propagate into god knows
how many other mount namespaces. That's just nasty.

IOW, making subvolumes vfsmounts will also have wider semantic
implications for using btrfs as a filesystem.
