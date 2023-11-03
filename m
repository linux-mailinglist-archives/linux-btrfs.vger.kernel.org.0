Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4079E7E05BC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 16:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjKCPrL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCPrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 11:47:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3BA6
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 08:47:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF56C433C8;
        Fri,  3 Nov 2023 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699026427;
        bh=KeIiqguBYlSRF8vx5WKfpqQAOYEKESQgLTzJDzV/9G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3LiV0fIB07MkHAxmfMtxayrp1mb92tS2MjHIIFuuQPvD/C1T5UCjvr6Pno3tgTW2
         +MBSp3c+SDdvmoOJDYuWQCz1kW+LIVaa5DByHF9+FWXinF/YzPG5cCzIhmfv8FLNqM
         a6LB587DKSjP35vJT++8/p3R8Q1mONgCEqZ+e7uiFCPHONlp6On4Piyai21ydX+umT
         cAuMxnFoi7S6Pbt84/ocM9xNIkVh4ZmAAEtFHU1iS7GovbjxNkWjpydhmo8ZI5MTcO
         eY8+2NgQSZIGUT2IZYqhAtlCb1S1o3yjDlrH2/NfSA7+z0atnbGy37Zp5s/YAn2krA
         EpMBmF82uN6Qw==
Date:   Fri, 3 Nov 2023 16:47:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
References: <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUUDmu8fTB0hyCQR@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 03, 2023 at 07:28:42AM -0700, Christoph Hellwig wrote:
> On Thu, Nov 02, 2023 at 12:07:47PM +0100, Christian Brauner wrote:
> > But at that point we really need to ask if it makes sense to use
> > vfsmounts per subvolume in the first place:
> > 
> > (1) We pollute /proc/<pid>/mountinfo with a lot of mounts.
> > (2) By calling ->getattr() from show_mountinfo() we open the whole
> >     system up to deadlocks.
> > (3) We change btrfs semantics drastically to the point where they need a
> >     new mount, module, or Kconfig option.
> > (4) We make (initial) lookup on btrfs subvolumes more heavyweight
> >     because you need to create a mount for the subvolume.
> > 
> > So right now, I don't see how we can make this work even if the concept
> > doesn't seem necessarily wrong.
> 
> How else do you want to solve it?  Crossing a mount point is the
> only legitimate boundary for changing st_dev and having a new inode
> number space.  And we can't fix that retroactively.

I think the idea of using vfsmounts for this makes some sense if the
goal is to retroactively justify and accommodate the idea that a
subvolume is to be treated as equivalent to a separate device.

I question that premise though. I think marking them with separate
device numbers is bringing us nothing but pain at this point and this
solution is basically bending the vfs to make that work somehow.

And the worst thing is that I think that treating subvolumes like
vfsmounts will hurt vfsmounts more than it will hurt subvolumes.

Right now all that vfsmounts technically are is a topological
abstraction on top of filesystem objects such as files, directories,
sockets, even devices that are exposed as filesystems objects. None of
them get to muck with core properties of what a vfsmount is though.

Additionally, vfsmount are tied to a superblock and share the device
numbers with the superblock they belong to.

If we make subvolumes and vfsmounts equivalent we break both properties.
And I think that's wrong or at least really ugly.

And I already see that the suggested workaround for (2) will somehow end
up being stashing device numbers in struct mount or struct vfsmount so
we can show it in mountinfo and if that's the case I want to express a
proactive nak for that solution.

The way I see it is that a subvolume at the end is nothing but a
subclass of directories a special one but whatever.

I would feel much more comfortable if the two filesystems that expose
these objects give us something like STATX_SUBVOLUME that userspace can
raise in the request mask of statx().

If userspace requests STATX_SUBVOLUME in the request mask, the two
filesystems raise STATX_SUBVOLUME in the statx result mask and then also
return the _real_ device number of the superblock and stop exposing that
made up device number.

This can be accompanied by a vfs ioctl that is identical for both btrfs
and bcachefs and returns $whatever unique property to mark the inode
space of the subvolume.

And then we leave innocent vfs objects alone and we also avoid
bringing in all that heavy vfsmount machinery on top of subvolumes.
