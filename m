Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A87B0BE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfILJu2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 05:50:28 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36393 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfILJu2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 05:50:28 -0400
Received: by mail-yw1-f66.google.com with SMTP id x64so8913522ywg.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0WVqWa+CQ6KBO7qcJGccvfEb1mGXQKGcoGeUP40DvXA=;
        b=N7HDKonLLIbBVljivsZMsYyfzlgAK9RgAMLOUSzC8Bz8bLltXy4sTTg5RjTpLmaMRR
         idR+2RG4wwBti5mA2+4J3zwl4gp9WvLAm63iHtzCC4QMAckpRGQ1p8XWgROQITUxq6JG
         GQRAKFSHPK60eCPg/dkl4ndT+5sU+zDeln9idz8SPQ1snER+yvOl5E7AKV6ptKgevdni
         mLKcheRrX//GEAuTaPFr6gkmqywgFKxEK3TrFPnatrqSYJ86rMBxk2lboUUEG7ZOj0V+
         CgZjx1XoN4RJFZaibOvLW+FiTMhU2PlkwnFisZhTW8rEokIg1ES7q56bOzRwbjWlUBi3
         b6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WVqWa+CQ6KBO7qcJGccvfEb1mGXQKGcoGeUP40DvXA=;
        b=p5plrVHjuPeyFYran7NXUwk3LZ4sTRvVE4D6EnvsE0zR5ieNzLc4Oc58wCXFgs7E91
         nDZPLuKlTuacQiy90x/2lTAtTQnidZ1datRK3vYAuv5fnvhzI6HARGbkTYQK079CfHyO
         uB/pxOpzmX1KUEcnKbWCuITBIQ6P7VenqXEeQ30GnmbxXqMeHk1pWDBRMeZqUQPTQHf0
         takq4PGJ+9hwR4VzqCvBCB5gARqD/N2WQjWU3FOql6VFqWXiCu84GKx26BhGewYy/gOH
         JYojPKKxEJSL5AhDvXO8AKdyQLG/4wS+gnHS0owNoK02LTO9Ya0kjPQFw7T9/nZnMY34
         4B5A==
X-Gm-Message-State: APjAAAXSslnqyt9JGD1umn3cgGWMiyz/344svPTVW/+rts+ixuL4WSfZ
        3+u0nTFa3EfYCNsaDMdj0eAOJw==
X-Google-Smtp-Source: APXvYqwPlVls0+OdC+fpxFnkPZQI8Wl8gWPeJMPHbMb31mJ3YKa+yv+IWIroJp5SYgFfy9zPd2ZL7A==
X-Received: by 2002:a81:7d8b:: with SMTP id y133mr25326480ywc.377.1568281827267;
        Thu, 12 Sep 2019 02:50:27 -0700 (PDT)
Received: from localhost ([2600:380:9c1c:691f:cb4:3daf:a71a:adbc])
        by smtp.gmail.com with ESMTPSA id t12sm4964438ywf.43.2019.09.12.02.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 02:50:26 -0700 (PDT)
Date:   Thu, 12 Sep 2019 05:50:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Eli V <eliventer@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/2] readmirror feature
Message-ID: <20190912095021.htmpvvowdprc2jhv@MacBook-Pro-91.local>
References: <20190826090438.7044-1-anand.jain@oracle.com>
 <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
 <CAJtFHUQ4wq02_6qLGjMWyOt-1eqKyxSLxw=EsR63LnBuZfh4mw@mail.gmail.com>
 <20190911191656.mrmfyhvy3latjwid@macbook-pro-91.dhcp.thefacebook.com>
 <2f10bebf-bc63-fe9e-d7d3-06b3113bc95c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f10bebf-bc63-fe9e-d7d3-06b3113bc95c@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 03:41:42PM +0800, Anand Jain wrote:
> 
> 
> Thanks for the comments. More below.
> 
> On 12/9/19 3:16 AM, Josef Bacik wrote:
> > On Wed, Sep 11, 2019 at 03:13:21PM -0400, Eli V wrote:
> > > On Wed, Sep 11, 2019 at 2:46 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > > 
> > > > On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
> > > > > Function call chain  __btrfs_map_block()->find_live_mirror() uses
> > > > > thread pid to determine the %mirror_num when the mirror_num=0.
> > > > > 
> > > > > This patch introduces a framework so that we can add policies to determine
> > > > > the %mirror_num. And also adds the devid as the readmirror policy.
> > > > > 
> > > > > The new property is stored as an item in the device tree as show below.
> > > > >      (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
> > > > > 
> > > > > To be able to set and get this new property also introduces new ioctls
> > > > > BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
> > > > > is defined as
> > > > >          struct btrfs_ioctl_readmirror_args {
> > > > >                  __u64 type; /* RW */
> > > > >                  __u64 device_bitmap; /* RW */
> > > > >          }
> > > > > 
> > > > > An usage example as follows:
> > > > >          btrfs property set /btrfs readmirror devid:1,3
> > > > >          btrfs property get /btrfs readmirror
> > > > >            readmirror devid:1 3
> > > > >          btrfs property set /btrfs readmirror ""
> > > > >          btrfs property get /btrfs readmirror
> > > > >            readmirror default
> > > > > 
> > > > > This patchset has been tested completely, however marked as RFC for the
> > > > > following reasons and comments on them (or any other) are appreciated as
> > > > > usual.
> > > > >   . The new objectid is defined as
> > > > >        #define BTRFS_READMIRROR_OBJECTID -1ULL
> > > > >     Need consent we are fine to use this value, and with this value it
> > > > >     shall be placed just before the DEV_STATS_OBJECTID item which is more
> > > > >     frequently used only during the device errors.
> > > > > 
> > > > > .  I am using a u64 bitmap to represent the devices id, so the max device
> > > > >     id that we could represent is 63, its a kind of limitation which should
> > > > >     be addressed before integration, I wonder if there is any suggestion?
> > > > >     Kindly note that, multiple ioctls with each time representing a set of
> > > > >     device(s) is not a choice because we need to make sure the readmirror
> > > > >     changes happens in a commit transaction.
> > > > > 
> > > > > v1->RFC v2:
> > > > >    . Property is stored as a dev-tree item instead of root inode extended
> > > > >      attribute.
> > > > >    . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to BTRFS_DEV_STATE_READ_PREFERRED.
> > > > >    . Changed format specifier from devid1,2,3.. to devid:1,2,3..
> > > > > 
> > > > > RFC->v1:
> > > > >    Drops pid as one of the readmirror policy choices and as usual remains
> > > > >    as default. And when the devid is reset the readmirror policy falls back
> > > > >    to pid.
> > > > >    Drops the mount -o readmirror idea, it can be added at a later point of
> > > > >    time.
> > > > >    Property now accepts more than 1 devid as readmirror device. As shown
> > > > >    in the example above.
> > > > > 
> > > > 
> > > > This is a lot of infrastructure
> 
>   Ok. Any idea on a better implementation?
>   How about extended attribute approach? v1 patches proposed
>   it, but it abused the extended attribute as commented here [1]
>   and v2 got changed to an item-key.
> 
> [1]
> https://lore.kernel.org/linux-btrfs/be68e6ea-00bc-b750-25e1-9c584b99308f@gmx.com/
>

That's a NAK on the prop interface.  This is a fs wide policy, not a
directory/inode policy.
 
> 
> > > > to just change which mirror we read to based on
> > > > some arbitrary user policy.  I assume this is to solve the case where you have
> > > > slow and fast disks, so you can always read from the fast disk?  And then it's
> > > > only used in RAID1, so the very narrow usecase of having a RAID1 setup with a
> > > > SSD and a normal disk?  I'm not seeing a point to this much code for one
> > > > particular obscure setup.  Thanks,
> > > > 
> > > > Josef
> > > 
> > > Not commenting on the code itself, but as a user I see this SSD RAID1
> > > acceleration as a future much have feature. It's only obscure at the
> > > moment because we don't have code to take advantage of it. But on
> > > large btrfs filesystems with hundreds of GB of metadata, like I have
> > > for backups, the usability of the filesystem is dramatically improved
> > > having the metadata on an SSD( though currently only half of the time
> > > due to the even/odd pid distribution.)
> > 
> > But that's different from a mirror.  100% it would be nice to say "put my
> > metadata on the ssd, data elsewhere".  That's not what this patch is about, this
> > patch is specifically about changing which drive we choose in a mirrored setup,
> > which is super unlikely to mirror a SSD with a slow drive, cause it's just going
> > to be slow no matter what.  Sure we could make it so reads always go to the SSD,
> > but we can accomplish that by just adding a check for nonrotational in the code,
> > and then we don't have to encode all this nonsense in the file system.  Thanks,
> 
>  I wrote about the readmirror policy framework here[2],
>  I forgot to link it here, sorry about that, my mistake.
> 
>  [2]
> 
> https://lore.kernel.org/linux-btrfs/1552989624-29577-1-git-send-email-anand.jain@oracle.com/
> 
>  Readmirror policy is for raid1, raid10 and future N way mirror.
>  Yes for now its only for raid1.
> 
>  Here the idea is to create a framework so that readmirror policy
>  can be configured as needed. And nonrotational can be one such policy.
> 
>  The example of hard-coded nonrotational policy does not work in case
>  of ssd and a remote iscsi ssd, OR in case of local ssd and a NVME block
>  device, as all these are still nonrotational devices. So hard-coded
>  policy is not a good idea. If we have to hardcode then there is Q-depth
>  based readmirror routing is better (patch in the ML), but that is
>  not good enough, because some configs wants it based on the disk-LBA
>  so that SAN storage target cache is balanced and not duplicated.
>  So in short it must be a configurable policy.
> 

Again, if you are mixing disk types you likely always want non-rotational, but
still mixing different speed devices in a mirror setup is just asking for weird
latency problems.  I don't think solving this use case is necessary.  If you mix
ssd + network device in a serious production setup then you probably should be
fired cause you don't know what you are doing.  Having the generic
"nonrotational gets priority" is going to cover 99% of the actual use cases that
make sense.

The SAN usecase I can sort of see, but again I don't feel like it's a problem we
need to solve with on-disk format.  Add a priority to sysfs so you can change it
with udev or something on the fly.  Thanks,

Josef
