Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6CB047A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfIKTNe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 15:13:34 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36546 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbfIKTNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 15:13:34 -0400
Received: by mail-yb1-f194.google.com with SMTP id m9so7757364ybm.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuaYOGQWgrLPxwcoepsdeeNZuzQNaW3hbCrg2w0ix58=;
        b=NFti06ZdXQ2iz9SEdiZx+tvwiVWJW8LTr4BSbYL0DSLFMXs3YITH+uW3iXtdhZi7nk
         Pz7itkOW/XwzUh+aiq9tLwEkD3YV2QaaNHgBPi7Ww3u05/GguOfLV/j3++PfqHq9k0fN
         CbVYsSpkYA5lMF41uEW0Vu0B/9zBIzKTxAH8uVE84c4S8/AdMlduAnRyn0exsEqUp3Cj
         UK4H0BjkdeSAf44pbnJw2oiu3a51YizHPyTT1IbRwYvJbSlnIUuBFfMVtnHZpO92zm5b
         n3ftzykB7qRw0n34xvtqCZ1KjgYc26K9wm14e4RYweW0cmRr0+6Xiu+n3VNgcE0YXhOX
         r3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuaYOGQWgrLPxwcoepsdeeNZuzQNaW3hbCrg2w0ix58=;
        b=b3ASKIr+Bsv3zKCTJt5v0fz+QNrWDcnGToHuUaE6lw+dZPVFBtb/wmXTmRxnRs+yeh
         X4A7TLXFSPcV58FgYI4w6koaOqILcidMYP3HGe6K2MXT9YqJGjD4jhLGhnc9XEseLNrn
         PNDrTcQwp4RaLDdY+vjDW+/+4KuUdygZgP0gYpvlUl7XNASPS3b7vEZa2lmDtSRh7Z7r
         F+nvu6QZ3oCelm+hK7sPjiN2erPQiYNfFRP7I14DHp10TZVojW3Z4G2KlMgnoo4lrJMZ
         7BjsWHOBL1xvaIl1jUKIOoolGZKLEtlfCfOfr5Jo95bDM7EoC5UXHCOOV7aZq2nz/C+w
         3l1w==
X-Gm-Message-State: APjAAAWAcMStBd3wsq7KNKemDL0j7cV8AdtmoJpBc30U6wn/Tzren3Wg
        qLIK+cvnWRZ+AqpC+AxOUcflS8MzaFFXp/V3aNg=
X-Google-Smtp-Source: APXvYqyTCzp4noCdOoPCoZAZCePxh9Mo/hOKhdzHvGbMrnEsKVXRv+Zhx+Lp51NnqwOeIn7FpvCsGtyrHSpE4QKJt+g=
X-Received: by 2002:a25:c74a:: with SMTP id w71mr24279638ybe.311.1568229212943;
 Wed, 11 Sep 2019 12:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190826090438.7044-1-anand.jain@oracle.com> <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190911184229.gl7tu3igtuuepcvm@macbook-pro-91.dhcp.thefacebook.com>
From:   Eli V <eliventer@gmail.com>
Date:   Wed, 11 Sep 2019 15:13:21 -0400
Message-ID: <CAJtFHUQ4wq02_6qLGjMWyOt-1eqKyxSLxw=EsR63LnBuZfh4mw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] readmirror feature
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 2:46 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
> > Function call chain  __btrfs_map_block()->find_live_mirror() uses
> > thread pid to determine the %mirror_num when the mirror_num=0.
> >
> > This patch introduces a framework so that we can add policies to determine
> > the %mirror_num. And also adds the devid as the readmirror policy.
> >
> > The new property is stored as an item in the device tree as show below.
> >     (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
> >
> > To be able to set and get this new property also introduces new ioctls
> > BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
> > is defined as
> >         struct btrfs_ioctl_readmirror_args {
> >                 __u64 type; /* RW */
> >                 __u64 device_bitmap; /* RW */
> >         }
> >
> > An usage example as follows:
> >         btrfs property set /btrfs readmirror devid:1,3
> >         btrfs property get /btrfs readmirror
> >           readmirror devid:1 3
> >         btrfs property set /btrfs readmirror ""
> >         btrfs property get /btrfs readmirror
> >           readmirror default
> >
> > This patchset has been tested completely, however marked as RFC for the
> > following reasons and comments on them (or any other) are appreciated as
> > usual.
> >  . The new objectid is defined as
> >       #define BTRFS_READMIRROR_OBJECTID -1ULL
> >    Need consent we are fine to use this value, and with this value it
> >    shall be placed just before the DEV_STATS_OBJECTID item which is more
> >    frequently used only during the device errors.
> >
> > .  I am using a u64 bitmap to represent the devices id, so the max device
> >    id that we could represent is 63, its a kind of limitation which should
> >    be addressed before integration, I wonder if there is any suggestion?
> >    Kindly note that, multiple ioctls with each time representing a set of
> >    device(s) is not a choice because we need to make sure the readmirror
> >    changes happens in a commit transaction.
> >
> > v1->RFC v2:
> >   . Property is stored as a dev-tree item instead of root inode extended
> >     attribute.
> >   . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to BTRFS_DEV_STATE_READ_PREFERRED.
> >   . Changed format specifier from devid1,2,3.. to devid:1,2,3..
> >
> > RFC->v1:
> >   Drops pid as one of the readmirror policy choices and as usual remains
> >   as default. And when the devid is reset the readmirror policy falls back
> >   to pid.
> >   Drops the mount -o readmirror idea, it can be added at a later point of
> >   time.
> >   Property now accepts more than 1 devid as readmirror device. As shown
> >   in the example above.
> >
>
> This is a lot of infrastructure to just change which mirror we read to based on
> some arbitrary user policy.  I assume this is to solve the case where you have
> slow and fast disks, so you can always read from the fast disk?  And then it's
> only used in RAID1, so the very narrow usecase of having a RAID1 setup with a
> SSD and a normal disk?  I'm not seeing a point to this much code for one
> particular obscure setup.  Thanks,
>
> Josef

Not commenting on the code itself, but as a user I see this SSD RAID1
acceleration as a future much have feature. It's only obscure at the
moment because we don't have code to take advantage of it. But on
large btrfs filesystems with hundreds of GB of metadata, like I have
for backups, the usability of the filesystem is dramatically improved
having the metadata on an SSD( though currently only half of the time
due to the even/odd pid distribution.)
