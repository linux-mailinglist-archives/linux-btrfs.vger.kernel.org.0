Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D53B0480
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfIKTRB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 15:17:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38698 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfIKTRA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 15:17:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id b2so26667897qtq.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gB/gtGHYYhGSoAnGXXu9WbrdwT3MBYwTRy4SD/XJ1A=;
        b=Po8mk4YqYgDuD/2GaR+I0BXM4tY9psQos8iQsEAXEEuvipsNz+NlcaDPrNl6Aj2/1e
         arjPc5Yh0SyaVOlzAMThBfkGwrQeCfF7JDA+C07YWnEEhKWWUz9HwDnCWYchG0Rt5h7s
         9Gmz9GP8a8lVdjA9zfqvy8wPZQa+36tY/elKIC1FliJ2OJnOWfMRj3UCNuMTbYmlvzt1
         8YNLhprApoIOzmS0t36uy6bBfe7lbxqAzAJAQRh+cNg1tbppwY/GKuzQMahjgHk0Gca1
         RiTleQxWDKa9YHCXZC0HmO/a9C3gk4KqDL7qXjAPdxMe0PkIMd6OmCxQTMy+aJMeSJPt
         l6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gB/gtGHYYhGSoAnGXXu9WbrdwT3MBYwTRy4SD/XJ1A=;
        b=TWrmZ1m3hJqrdMVKyDy91pIv5kobjuJJq4iHcEIq21wcczvDG4zgj81mdRD/NHeMq9
         jpZWX9IvpAHk/sJt+Ec8DhvYii9IACbZyQTz8Xz8RNu4FDtpqyfFBeadYVtKP+kvsJZT
         ORABZq3KtMO0QAHOBfhZtoIJ68A1qdCQ2a2t3hFKZVT6Wlr/fvi964kdOHvlrgdZqjrC
         Zs8wagiRsbGdLR8DPKLsQu+GPiIC+AkGyyO8TVGX6yGexvAGoQiV86XYTYX6eR9ydKOt
         9oTt5DInpBYdy+4SfxlHOewKxkCQsZoEwX0H+5X226m0aaODiwvH70tYkGc2ek/wbHt3
         uGzg==
X-Gm-Message-State: APjAAAWKBF73ScTfjdbaBC70iD3pfcuDX9XZ/3gn+cRXqouyralHqGUz
        Ii72c+AW7gvgHg/F+B1KzO1426OUFHwf8Q==
X-Google-Smtp-Source: APXvYqzGGRJ5DujfFVRk6li33wT6PKPf6rBq4owNrJhi7ZLOOKkMFslPyb++dJe+OzzP60deSaXAyw==
X-Received: by 2002:ac8:fb4:: with SMTP id b49mr36125497qtk.203.1568229419315;
        Wed, 11 Sep 2019 12:16:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::87bd])
        by smtp.gmail.com with ESMTPSA id d3sm10135948qtr.55.2019.09.11.12.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 12:16:58 -0700 (PDT)
Date:   Wed, 11 Sep 2019 15:16:57 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Eli V <eliventer@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/2] readmirror feature
Message-ID: <20190911191656.mrmfyhvy3latjwid@macbook-pro-91.dhcp.thefacebook.com>
References: <20190826090438.7044-1-anand.jain@oracle.com>
 <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
 <CAJtFHUQ4wq02_6qLGjMWyOt-1eqKyxSLxw=EsR63LnBuZfh4mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJtFHUQ4wq02_6qLGjMWyOt-1eqKyxSLxw=EsR63LnBuZfh4mw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 03:13:21PM -0400, Eli V wrote:
> On Wed, Sep 11, 2019 at 2:46 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
> > > Function call chain  __btrfs_map_block()->find_live_mirror() uses
> > > thread pid to determine the %mirror_num when the mirror_num=0.
> > >
> > > This patch introduces a framework so that we can add policies to determine
> > > the %mirror_num. And also adds the devid as the readmirror policy.
> > >
> > > The new property is stored as an item in the device tree as show below.
> > >     (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
> > >
> > > To be able to set and get this new property also introduces new ioctls
> > > BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
> > > is defined as
> > >         struct btrfs_ioctl_readmirror_args {
> > >                 __u64 type; /* RW */
> > >                 __u64 device_bitmap; /* RW */
> > >         }
> > >
> > > An usage example as follows:
> > >         btrfs property set /btrfs readmirror devid:1,3
> > >         btrfs property get /btrfs readmirror
> > >           readmirror devid:1 3
> > >         btrfs property set /btrfs readmirror ""
> > >         btrfs property get /btrfs readmirror
> > >           readmirror default
> > >
> > > This patchset has been tested completely, however marked as RFC for the
> > > following reasons and comments on them (or any other) are appreciated as
> > > usual.
> > >  . The new objectid is defined as
> > >       #define BTRFS_READMIRROR_OBJECTID -1ULL
> > >    Need consent we are fine to use this value, and with this value it
> > >    shall be placed just before the DEV_STATS_OBJECTID item which is more
> > >    frequently used only during the device errors.
> > >
> > > .  I am using a u64 bitmap to represent the devices id, so the max device
> > >    id that we could represent is 63, its a kind of limitation which should
> > >    be addressed before integration, I wonder if there is any suggestion?
> > >    Kindly note that, multiple ioctls with each time representing a set of
> > >    device(s) is not a choice because we need to make sure the readmirror
> > >    changes happens in a commit transaction.
> > >
> > > v1->RFC v2:
> > >   . Property is stored as a dev-tree item instead of root inode extended
> > >     attribute.
> > >   . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to BTRFS_DEV_STATE_READ_PREFERRED.
> > >   . Changed format specifier from devid1,2,3.. to devid:1,2,3..
> > >
> > > RFC->v1:
> > >   Drops pid as one of the readmirror policy choices and as usual remains
> > >   as default. And when the devid is reset the readmirror policy falls back
> > >   to pid.
> > >   Drops the mount -o readmirror idea, it can be added at a later point of
> > >   time.
> > >   Property now accepts more than 1 devid as readmirror device. As shown
> > >   in the example above.
> > >
> >
> > This is a lot of infrastructure to just change which mirror we read to based on
> > some arbitrary user policy.  I assume this is to solve the case where you have
> > slow and fast disks, so you can always read from the fast disk?  And then it's
> > only used in RAID1, so the very narrow usecase of having a RAID1 setup with a
> > SSD and a normal disk?  I'm not seeing a point to this much code for one
> > particular obscure setup.  Thanks,
> >
> > Josef
> 
> Not commenting on the code itself, but as a user I see this SSD RAID1
> acceleration as a future much have feature. It's only obscure at the
> moment because we don't have code to take advantage of it. But on
> large btrfs filesystems with hundreds of GB of metadata, like I have
> for backups, the usability of the filesystem is dramatically improved
> having the metadata on an SSD( though currently only half of the time
> due to the even/odd pid distribution.)

But that's different from a mirror.  100% it would be nice to say "put my
metadata on the ssd, data elsewhere".  That's not what this patch is about, this
patch is specifically about changing which drive we choose in a mirrored setup,
which is super unlikely to mirror a SSD with a slow drive, cause it's just going
to be slow no matter what.  Sure we could make it so reads always go to the SSD,
but we can accomplish that by just adding a check for nonrotational in the code,
and then we don't have to encode all this nonsense in the file system.  Thanks,

Josef
