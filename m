Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56517DDDA5
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 09:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjKAIQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKAIQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 04:16:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACC8A6
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 01:16:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBBDC433C9;
        Wed,  1 Nov 2023 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698826615;
        bh=CgZozKJYxb8Oa/2I8G9ne3tgA8/W0ox0Fxzv5N3rn2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCg0zh/b3Mtx6gGfqFEh3jRGS8PRFUemE7gdSlo1kf4VF9mvG9zA05iwApKKEn97O
         CVKz3B8LxUsYOjBLxLZlgCHM41X/xmTMWvdfYSgg5QLFRWvQF72PKnB4A53ZLWVqJX
         e6vHEjzlfjiWlNMmWP5SE853wWyWF4vDd86XniZgwlWmkpcziHIvzLPeQBf5pqhBQA
         5HOaDbQOfx0/a/pouBAaybjHQiqH5FzSqw8BGpj5Ncg5g9+cXnszQjS9hi0rj5N9aj
         NubVKnLlnQ/tQsns5D953s/m08NS21VByyT2aAxG/J9zsefVTQeHds8F6sluI5Be2d
         BXH7hO+602RMA==
Date:   Wed, 1 Nov 2023 09:16:50 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUE0CWQWdpGHm81L@infradead.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 10:06:17AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote:
> > So this is effectively a request for:
> > 
> > btrfs subvolume create /mnt/subvol1
> > 
> > to create vfsmounts? IOW,
> > 
> > mkfs.btrfs /dev/sda
> > mount /dev/sda /mnt
> > btrfs subvolume create /mnt/subvol1
> > btrfs subvolume create /mnt/subvol2
> > 
> > would create two new vfsmounts that are exposed in /proc/<pid>/mountinfo
> > afterwards?
> 
> Yes.
> 
> > That might be odd. Because these vfsmounts aren't really mounted, no?
> 
> Why aren't they?
> 
> > And so you'd be showing potentially hundreds of mounts in
> > /proc/<pid>/mountinfo that you can't unmount?
> 
> Why would you not allow them to be unmounted?
> 
> > And even if you treat them as mounted what would unmounting mean?
> 
> The code in btrfs_lookup_dentry that does a hand crafted version
> of the file system / subvolume crossing (the location.type !=
> BTRFS_INODE_ITEM_KEY one) would not be executed.

So today, when we do:

mkfs.btrfs -f /dev/sda
mount -t btrfs /dev/sda /mnt
btrfs subvolume create /mnt/subvol1
btrfs subvolume create /mnt/subvol2

Then all subvolumes are always visible under /mnt.
IOW, you can't hide them other than by overmounting or destroying them.

If we make subvolumes vfsmounts then we very likely alter this behavior
and I see two obvious options:

(1) They are fake vfsmounts that can't be unmounted:

    umount /mnt/subvol1 # returns -EINVAL

    This retains the invariant that every subvolume is always visible
    from the filesystems root, i.e., /mnt will include /mnt/subvol{1,}

(2) They are proper vfsmounts:

    umount /mnt/subvol1 # succeeds

    This retains standard semantics for userspace about anything that
    shows up in /proc/<pid>/mountinfo but means that after
    umount /mnt/subvol1 succeeds, /mnt/subvol1 won't be accessible from
    the filesystem root /mnt anymore.

Both options can be made to work from a purely technical perspective,
I'm asking which one it has to be because it isn't clear just from the
snippets in this thread.

One should also point out that if each subvolume is a vfsmount, then say
a btrfs filesystems with 1000 subvolumes which is mounted from the root:

mount -t btrfs /dev/sda /mnt

could be exploded into 1000 individual mounts. Which many users might not want.

So I would expect that we would need to default to mounting without
subvolumes accessible, and a mount option to mount with all subvolumes
mounted, idk:

mount -t btrfs -o tree /dev/sda /mnt

or sm.

I agree that mapping subvolumes to vfsmounts sounds like the natural
thing to do.

But if we do e.g., (2) then this surely needs to be a Kconfig and/or a
mount option to avoid breaking userspace (And I'm pretty sure that btrfs
will end up supporting both modes almost indefinitely.).
