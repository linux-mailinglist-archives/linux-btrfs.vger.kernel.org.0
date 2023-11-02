Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A637DEC29
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 06:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348518AbjKBFNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 01:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348472AbjKBFNy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 01:13:54 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B46112
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 22:13:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5afbdbf3a19so6985707b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Nov 2023 22:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698902031; x=1699506831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVCLcV8A3+2nn/xKekm2qVyDfwVFohAk7Q63MVGpTAM=;
        b=dk5oKchAjz80Yta2YsF00Q0g/YDA25OQGlHkiFlFBrvHPrYjPITCI9deByno/GSlVR
         H27ixvvKitOkJG9eOXfRYMGJaEslysuAiCy7WJAfwItQ7yJyF7k8cM0U8Z5QqnmNatJk
         PJk3TlZMJ/Gbt2KM/lScGiGdIAQmOTf/NwxkzttXn2Cy1UY6OBinwbOrSUPFrtCKBpTv
         T/8By5N26ixbPl4R1YvyKBeJqS80Pghrc5PoHajXY34eJTO7oj3Eb10q51PffjdOD8NL
         U8re9TdybcmSgsr5r383TddF5L8kNw4/jflvoVLtOQ1kBCeY6We9k+DeqsQtvyAsufzg
         FbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698902031; x=1699506831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVCLcV8A3+2nn/xKekm2qVyDfwVFohAk7Q63MVGpTAM=;
        b=wPeNdgsgpqQVFRmR3spEWHiCAiBRXtAR8cAGb2Z7yf3BmmWOe4hCUXZOIJcCf49yGc
         wvntCoxYsR2qXPnp/j7NSwgLHQ0ObxOi3leF25l+rjVWP2wEVqTg/gEg99NbKSYmuuBE
         ZY2U1rSTKWk06W6VUyLyGz8v5ti4IlhuREV4B7bXvWxziS/ROF9a7fqB8AqMH+LuBVtp
         DjlRQHaY5RFPNaN0A2ar2xgiNEVjDb6J+Nx6Hu3Q53Q1BIP6tqwur9C6jBvcEA5EOStK
         0M4Gtckl5aNZmqVswppM2YcW7Qm2YZVWoZ13aeqfg+iwRQYqc7vYIzck2QfE91Nt2YH4
         T7vw==
X-Gm-Message-State: AOJu0Yz4GShiLTmVYFQrXHeS4JkQ8t5b3dfwpZZ1XS2HtoJjnjg8veMz
        Mhni4fyikDYxG9xtU0vqOfNd6w==
X-Google-Smtp-Source: AGHT+IEtjdM5elSCUGLb5uPfz//kCfiun67tSowcW5o5iqJNIVGZi2ImdtY6Csl0Iqh7dAJWD+yWKg==
X-Received: by 2002:a81:b306:0:b0:59b:ca2f:6eff with SMTP id r6-20020a81b306000000b0059bca2f6effmr15805008ywh.40.1698902031003;
        Wed, 01 Nov 2023 22:13:51 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p138-20020a819890000000b005a7bf9749c8sm827761ywg.4.2023.11.01.22.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 22:13:50 -0700 (PDT)
Date:   Thu, 2 Nov 2023 01:13:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231102051349.GA3292886@perftesting>
References: <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-neigen-storch-cde3b0671902@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 01, 2023 at 10:52:18AM +0100, Christian Brauner wrote:
> On Wed, Nov 01, 2023 at 07:11:53PM +1030, Qu Wenruo wrote:
> > 
> > 
> > On 2023/11/1 18:46, Christian Brauner wrote:
> > > On Tue, Oct 31, 2023 at 10:06:17AM -0700, Christoph Hellwig wrote:
> > > > On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote:
> > > > > So this is effectively a request for:
> > > > > 
> > > > > btrfs subvolume create /mnt/subvol1
> > > > > 
> > > > > to create vfsmounts? IOW,
> > > > > 
> > > > > mkfs.btrfs /dev/sda
> > > > > mount /dev/sda /mnt
> > > > > btrfs subvolume create /mnt/subvol1
> > > > > btrfs subvolume create /mnt/subvol2
> > > > > 
> > > > > would create two new vfsmounts that are exposed in /proc/<pid>/mountinfo
> > > > > afterwards?
> > > > 
> > > > Yes.
> > > > 
> > > > > That might be odd. Because these vfsmounts aren't really mounted, no?
> > > > 
> > > > Why aren't they?
> > > > 
> > > > > And so you'd be showing potentially hundreds of mounts in
> > > > > /proc/<pid>/mountinfo that you can't unmount?
> > > > 
> > > > Why would you not allow them to be unmounted?
> > > > 
> > > > > And even if you treat them as mounted what would unmounting mean?
> > > > 
> > > > The code in btrfs_lookup_dentry that does a hand crafted version
> > > > of the file system / subvolume crossing (the location.type !=
> > > > BTRFS_INODE_ITEM_KEY one) would not be executed.
> > > 
> > > So today, when we do:
> > > 
> > > mkfs.btrfs -f /dev/sda
> > > mount -t btrfs /dev/sda /mnt
> > > btrfs subvolume create /mnt/subvol1
> > > btrfs subvolume create /mnt/subvol2
> > > 
> > > Then all subvolumes are always visible under /mnt.
> > > IOW, you can't hide them other than by overmounting or destroying them.
> > > 
> > > If we make subvolumes vfsmounts then we very likely alter this behavior
> > > and I see two obvious options:
> > > 
> > > (1) They are fake vfsmounts that can't be unmounted:
> > > 
> > >      umount /mnt/subvol1 # returns -EINVAL
> > > 
> > >      This retains the invariant that every subvolume is always visible
> > >      from the filesystems root, i.e., /mnt will include /mnt/subvol{1,}
> > 
> > I'd like to go this option. But I still have a question.
> > 
> > How do we properly unmount a btrfs?
> > Do we have some other way to record which subvolume is really mounted
> > and which is just those place holder?
> 
> So the downside of this really is that this would be custom btrfs
> semantics. Having mounts in /proc/<pid>/mountinfo that you can't unmount
> only happens in weird corner cases today:
> 
> * mounts inherited during unprivileged mount namespace creation
> * locked mounts
> 
> Both of which are pretty inelegant and effectively only exist because of
> user namespaces. So if we can avoid proliferating such semantics it
> would be preferable.
> 
> I think it would also be rather confusing for userspace to be presented
> with a bunch of mounts in /proc/<pid>/mountinfo that it can't do
> anything with.
> 
> > > (2) They are proper vfsmounts:
> > > 
> > >      umount /mnt/subvol1 # succeeds
> > > 
> > >      This retains standard semantics for userspace about anything that
> > >      shows up in /proc/<pid>/mountinfo but means that after
> > >      umount /mnt/subvol1 succeeds, /mnt/subvol1 won't be accessible from
> > >      the filesystem root /mnt anymore.
> > > 
> > > Both options can be made to work from a purely technical perspective,
> > > I'm asking which one it has to be because it isn't clear just from the
> > > snippets in this thread.
> > > 
> > > One should also point out that if each subvolume is a vfsmount, then say
> > > a btrfs filesystems with 1000 subvolumes which is mounted from the root:
> > > 
> > > mount -t btrfs /dev/sda /mnt
> > > 
> > > could be exploded into 1000 individual mounts. Which many users might not want.
> > 
> > Can we make it dynamic? AKA, the btrfs_insert_fs_root() is the perfect
> > timing here.
> 
> Probably, it would be an automount. Though I would have to recheck that
> code to see how exactly that would work but roughly, when you add the
> inode for the subvolume you raise S_AUTOMOUNT on it and then you add
> .d_automount for btrfs.

Btw I'm working on this, mostly to show Christoph it doesn't do what he thinks
it does.

However I ran into some weirdness where I need to support the new mount API, so
that's what I've been doing since I wandered away from this thread.  I should
have that done tomorrow, and then I was going to do the S_AUTOMOUNT thing ontop
of that.

But I have the same questions as you Christian, I'm not entirely sure how this
is supposed to be better.  Even if they show up in /proc/mounts, it's not going
to do anything useful for the applications that don't check /proc/mounts to see
if they've wandered into a new mount.  I also don't quite understand how NFS
suddenly knows it's wandered into a new mount with a vfsmount.

At this point I'm tired of it being brought up in every conversation where we
try to expose more information to the users.  So I'll write the patches and as
long as they don't break anything we can merge it, but I don't think it'll make
a single bit of difference.

We'll be converted to the new mount API tho, so I suppose that's something.
Thanks,

Josef
