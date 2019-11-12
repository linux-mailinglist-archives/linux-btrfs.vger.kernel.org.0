Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989B5F9772
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLRnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 12:43:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34465 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfKLRnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 12:43:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so13901310pff.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jzWi5KTL2S56uEV/l0JwMPLNUi8EoXA4Zno44KY/Z5w=;
        b=JlDJ/BkSUD8pBUATMPPntMEFgtQYCnRfYGqIgs4ys3TW0F50Dqxd37yIFo+uj9IU7B
         PJ9fZauo3AFLxTBc6GWuPpkxs3kp07m7xiTgMkfi06d/5NSEp3QQgJUr5C6U0BPbeaP7
         sPsoapBDl4e+K8LykReBPpDCpWnl9bhw7wIaehMIQo+gg8VXAiW0ns31WiEp4oiJgEND
         u9zUSoZzzEiL0jz8U5rC879GVoDUG0NvVx2/BRPKSKfrrRq2n6wfJHxP2SReXe9u7Fe/
         D5dd75x8UJfLaqt3vCnO8OtR8fC2YYMV+XlR06bkluCgUmzKA1SeS7Fdo9e081t/pteA
         jT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jzWi5KTL2S56uEV/l0JwMPLNUi8EoXA4Zno44KY/Z5w=;
        b=RmvGByvKyz0x+fahtdq1MLv+Yk9e9KJaWR49VnA7hXqcsYYA/gT/m9ZnX4USobrgkI
         EiXfNjRFsWaZem2/xjVxFSldmBgxhC5WJaFMP9NjAqoFW0HVZ1Ds7s7Zvh4dER6z13L0
         v5uKlxYK3xAwWugQpPAzpGS75zkA3+hJpytTZqOt22yT0qHVq5CFIOvSMEklrTfM2bdA
         ydtE40C3+lWrIhzkiiSWyZnvEEygKtpmDo1wrYZTK4JyiElEPyfwwsvmC0QBcSOON2eB
         4NV+FG3DQjYG4Ela/RFf8zCMlA123Wo702+fRss6EvJ1BkhJyklAauCptl33oe72UQH1
         1tYw==
X-Gm-Message-State: APjAAAVl/qY/N8gkoJXGU+tJ7r57BsAV3wpROgtBYMvwKmXINqCBPMNd
        ymqXp2iIHVn7Mq8Lw6Af71P77w==
X-Google-Smtp-Source: APXvYqx2uYhDQ/HXjGEqHlQFeN21l6PFSUbhjXsZMJtuyA+MOvJKFI4S+QDS+k03ZOu/VI+QxmgXTA==
X-Received: by 2002:a63:5f49:: with SMTP id t70mr1862875pgb.219.1573580596660;
        Tue, 12 Nov 2019 09:43:16 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::1:1c21])
        by smtp.gmail.com with ESMTPSA id u3sm19071799pgp.51.2019.11.12.09.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:43:15 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:43:14 -0800
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: fix missing hole after hole punching and fsync
 when using NO_HOLES
Message-ID: <20191112174314.kagevssffc3oc3ev@macbook-pro-91.dhcp.thefacebook.com>
References: <20191112151331.3641-1-fdmanana@kernel.org>
 <20191112173459.7c6piekqjfjidjon@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H4rdkfpdsdq4k75Yn+wibOxXnWsmVxTeaXNPAHZ6t7cvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4rdkfpdsdq4k75Yn+wibOxXnWsmVxTeaXNPAHZ6t7cvQ@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 05:39:59PM +0000, Filipe Manana wrote:
> On Tue, Nov 12, 2019 at 5:35 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Nov 12, 2019 at 03:13:31PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When using the NO_HOLES feature, if we punch a hole into a file and then
> > > fsync it, there is a case where a subsequent fsync will miss the fact that
> > > a hole was punched:
> > >
> > > 1) The extent items of the inode span multiple leafs;
> > >
> > > 2) The hole covers a range that affects only the extent items of the first
> > >    leaf;
> > >
> > > 3) The fsync operation is done in full mode (BTRFS_INODE_NEEDS_FULL_SYNC
> > >    is set in the inode's runtime flags).
> > >
> > > That results in the hole not existing after replaying the log tree.
> > >
> > > For example, if the fs/subvolume tree has the following layout for a
> > > particular inode:
> > >
> > >   Leaf N, generation 10:
> > >
> > >   [ ... INODE_ITEM INODE_REF EXTENT_ITEM (0 64K) EXTENT_ITEM (64K 128K) ]
> > >
> > >   Leaf N + 1, generation 10:
> > >
> > >   [ EXTENT_ITEM (128K 64K) ... ]
> > >
> > > If at transaction 11 we punch a hole coverting the range [0, 128K[, we end
> > > up dropping the two extent items from leaf N, but we don't touch the other
> > > leaf, so we end up in the following state:
> > >
> > >   Leaf N, generation 11:
> > >
> > >   [ ... INODE_ITEM INODE_REF ]
> > >
> > >   Leaf N + 1, generation 10:
> > >
> > >   [ EXTENT_ITEM (128K 64K) ... ]
> > >
> > > A full fsync after punching the hole will only process leaf N because it
> > > was modified in the current transaction, but not leaf N + 1, since it was
> > > not modified in the current transaction (generation 10 and not 11). As
> > > a result the fsync will not log any holes, because it didn't process any
> > > leaf with extent items.
> > >
> > > So fix this by detecting any leading hole in the file for a full fsync
> > > when using the NO_HOLES feature if we didn't process any extent items for
> > > the file.
> > >
> > > A test case for fstests follows soon.
> > >
> > > Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > This adds an extra search for every FULL_SYNC, can we just catch this case in
> > the main loop, say we keep track of the last extent we found,
> 
> It's already doing that by checking if "last_extent == 0" before
> calling the new function.
> Having last_extent == 0, no extents processed is very rare (hitting
> that specific item layout and hole range).
> 

Yup you're right, I missed that bit.  You can add 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
