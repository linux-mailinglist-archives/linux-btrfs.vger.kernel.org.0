Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB86E7DDEBD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 10:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjKAJwa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJw3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 05:52:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B3DA
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 02:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1632C433C7;
        Wed,  1 Nov 2023 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698832343;
        bh=gr9/ISQr++i5nHb8Hma92GyRHRag1n7JMO5W53UdNA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0ID5BAXhrIgl1T6GbN5L7EC/39F7BVlTSDBcEUg0LFcc8OywJD/pjIRn53soG65z
         xCg0F+xEp1WTlpPybXZ8hKcaSQao6h06/x4dzarvju8PeGSNz9XnJMchxyJeZFXOPY
         WQECPTDIb6W7XnJomtqJoal8d7ABjM0jJlt2VtbbIuoIxqYhZazPMQBz3k/xSTcE5r
         fBMD0v0AGKg0U62x6s8Q4TqG6nV2PCyVgTVDWGcyHwFjYzBhgi/rF9xkix+M7Y0Bl2
         D1XoNMDByksZo81YgBCwFBAJE0T2afVSxQeI2QSqWEurPorOu6pTn2CQgAL1vwSfNp
         9rqw05KDFSeHg==
Date:   Wed, 1 Nov 2023 10:52:18 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231101-neigen-storch-cde3b0671902@brauner>
References: <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 01, 2023 at 07:11:53PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/1 18:46, Christian Brauner wrote:
> > On Tue, Oct 31, 2023 at 10:06:17AM -0700, Christoph Hellwig wrote:
> > > On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote:
> > > > So this is effectively a request for:
> > > > 
> > > > btrfs subvolume create /mnt/subvol1
> > > > 
> > > > to create vfsmounts? IOW,
> > > > 
> > > > mkfs.btrfs /dev/sda
> > > > mount /dev/sda /mnt
> > > > btrfs subvolume create /mnt/subvol1
> > > > btrfs subvolume create /mnt/subvol2
> > > > 
> > > > would create two new vfsmounts that are exposed in /proc/<pid>/mountinfo
> > > > afterwards?
> > > 
> > > Yes.
> > > 
> > > > That might be odd. Because these vfsmounts aren't really mounted, no?
> > > 
> > > Why aren't they?
> > > 
> > > > And so you'd be showing potentially hundreds of mounts in
> > > > /proc/<pid>/mountinfo that you can't unmount?
> > > 
> > > Why would you not allow them to be unmounted?
> > > 
> > > > And even if you treat them as mounted what would unmounting mean?
> > > 
> > > The code in btrfs_lookup_dentry that does a hand crafted version
> > > of the file system / subvolume crossing (the location.type !=
> > > BTRFS_INODE_ITEM_KEY one) would not be executed.
> > 
> > So today, when we do:
> > 
> > mkfs.btrfs -f /dev/sda
> > mount -t btrfs /dev/sda /mnt
> > btrfs subvolume create /mnt/subvol1
> > btrfs subvolume create /mnt/subvol2
> > 
> > Then all subvolumes are always visible under /mnt.
> > IOW, you can't hide them other than by overmounting or destroying them.
> > 
> > If we make subvolumes vfsmounts then we very likely alter this behavior
> > and I see two obvious options:
> > 
> > (1) They are fake vfsmounts that can't be unmounted:
> > 
> >      umount /mnt/subvol1 # returns -EINVAL
> > 
> >      This retains the invariant that every subvolume is always visible
> >      from the filesystems root, i.e., /mnt will include /mnt/subvol{1,}
> 
> I'd like to go this option. But I still have a question.
> 
> How do we properly unmount a btrfs?
> Do we have some other way to record which subvolume is really mounted
> and which is just those place holder?

So the downside of this really is that this would be custom btrfs
semantics. Having mounts in /proc/<pid>/mountinfo that you can't unmount
only happens in weird corner cases today:

* mounts inherited during unprivileged mount namespace creation
* locked mounts

Both of which are pretty inelegant and effectively only exist because of
user namespaces. So if we can avoid proliferating such semantics it
would be preferable.

I think it would also be rather confusing for userspace to be presented
with a bunch of mounts in /proc/<pid>/mountinfo that it can't do
anything with.

> > (2) They are proper vfsmounts:
> > 
> >      umount /mnt/subvol1 # succeeds
> > 
> >      This retains standard semantics for userspace about anything that
> >      shows up in /proc/<pid>/mountinfo but means that after
> >      umount /mnt/subvol1 succeeds, /mnt/subvol1 won't be accessible from
> >      the filesystem root /mnt anymore.
> > 
> > Both options can be made to work from a purely technical perspective,
> > I'm asking which one it has to be because it isn't clear just from the
> > snippets in this thread.
> > 
> > One should also point out that if each subvolume is a vfsmount, then say
> > a btrfs filesystems with 1000 subvolumes which is mounted from the root:
> > 
> > mount -t btrfs /dev/sda /mnt
> > 
> > could be exploded into 1000 individual mounts. Which many users might not want.
> 
> Can we make it dynamic? AKA, the btrfs_insert_fs_root() is the perfect
> timing here.

Probably, it would be an automount. Though I would have to recheck that
code to see how exactly that would work but roughly, when you add the
inode for the subvolume you raise S_AUTOMOUNT on it and then you add
.d_automount for btrfs.
