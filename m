Return-Path: <linux-btrfs+bounces-2940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE186D28E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71021285738
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D353134418;
	Thu, 29 Feb 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ejoiuBNb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDepflVC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED313440E
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232432; cv=none; b=tgghKhYl+ziDSbtMFrhKgtONTQ5SNl6Gy68UfgM++gyVa28d6jXW1VNaMvF89Ek963hUctz62hhfespujZKqRLlrV36kVmyeppEYOiAZuDmGhVTtRsx0wNvap3HEuaFPzKFF9V8CzwnLVV0aUM5fo9IONOODl638gPs9M9RrAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232432; c=relaxed/simple;
	bh=z/zxsh/YeWOg3Bn2SJZGbGkE8rznn1FLHChM7oe1xfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq7La17Gm725FCwLZQBTm7+OUiHqWTorDijqCnMGakDNBTZAqEZZJzU+hETdkiC7uaQO+ZjNUgjG5UBy4uUjRslKZNkD6F09FZ3DGg2NAyaJ9BDqM+o7voDb4lfDWemVDmOCdHPYdSW8G4FcOQssEsIJmSrNySyC2ApoKHsDiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ejoiuBNb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDepflVC; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BA201320024A;
	Thu, 29 Feb 2024 13:47:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Feb 2024 13:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1709232428;
	 x=1709318828; bh=eZbO8rvb05w1ybVROp/A+imRL3z3fidiSsfXMmtQdOE=; b=
	ejoiuBNbdose5rkKDN/In9kW/1HRupcKGK0giigqUgMMS7ADZNsFqus6qjWkoERj
	8jdIXpE1jazMPAeLceQ2sZdL0CmptlYnPv0BvUvv+6/IiGukJTZjbVCh1530gkpC
	P9YmLXYscYmWWlceND1gcBZCm4OYBbnjJokzSduVwoHFax/N6f9FBWrOfNPVKbDs
	i9PoK/SGIC1EonG2GU1Yc3QTqQ34XyZHMzwoFwQ2uFfCNslbCIFXupCkjzt9qUGq
	xsWzDpl+eQGjQt1Cju07yNVPrPl7L056qc30XfWYtu7j36tzGdDtbzNYrDnsJ/Fg
	Z6m+MAAQNoF+GOXgE1nP3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709232428; x=
	1709318828; bh=eZbO8rvb05w1ybVROp/A+imRL3z3fidiSsfXMmtQdOE=; b=X
	DepflVCj/RtSwcHyNS/toLr3Pu0QXRg9EjD7R90eWYCXcpZMdDVTlpmSg7IsDkX2
	64fbep3FkuX7yBQn+90VOXnSRZm0m0EFUTniPMWeaNJIJ/FeXyVf30+UBmYcXp4D
	l+4bwylDOhJww3pedz+v53uID88dB98Nb6TCcT6/Bwb4S5+xlasYF3oykmcfhIEB
	Po3iFd/gOZCAEgXFvezXAQTzKbtY7VcjRToKCQXXpiRMV/NiynmoX9DVJ3PiIJPj
	EippBrPmIvrCaDdmhsxTzYl2aUCHaDQJ4xaVPNg8QE4k43unYJsjsjUArNF/3SAT
	9wYSRUHrDHRk81l/nB/QQ==
X-ME-Sender: <xms:LNHgZZ6f6Riw1P0wk1y_hDLyGBwpc8Oa5aYADgKSZhDQfFfJ--xhvw>
    <xme:LNHgZW4Gf_K-OPQt1Ef9RFVD7EZE4BaJcnvYLMO9TtsB51Im7beI3XLgOaG-PZmso
    RKy8jTlR4NxPIcHahk>
X-ME-Received: <xmr:LNHgZQfppKjcsPLfEZYu7sPhqVXmGBCpLP26dSRaEwsPTaGAP3kYFSC7e7dCEaGXOyIsiqGFjjitbSTF8V6hVJFaGaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epieektedvhfejveehieetuddvvdffkeeileelkeejgfekiefhueekvdfhgffhffeknecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:LNHgZSLu6iDpYr7Ekf5Or3VJx-nfh8teJ7MtoC_A1HMJAQiZua8VSA>
    <xmx:LNHgZdK0lVVTPmOROgyy-YHHHLPLzq5Q7DO5lpWDqOE7RxxSZblB5g>
    <xmx:LNHgZbxFsT_NWDbPJosrLeixWW5dM5sODdv3ILIfahhjX5mJX9WA7g>
    <xmx:LNHgZbjbcMwQHeyHm7kuQHzy64R3U3i184_qvKn833uxzK0qFTFMfg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 13:47:07 -0500 (EST)
Date: Thu, 29 Feb 2024 10:48:21 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: support device name lookup in forget
Message-ID: <20240229184821.GA1752685@zen.localdomain>
References: <659b811232f9c647e8a2250f6d4acd6a12751b6c.1709231726.git.boris@bur.io>
 <CAL3q7H4hMjpa5NJ=57RHBtX=Z_6MM5AMY4gD8Z_vSwqzq6qqyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4hMjpa5NJ=57RHBtX=Z_6MM5AMY4gD8Z_vSwqzq6qqyw@mail.gmail.com>

On Thu, Feb 29, 2024 at 06:44:48PM +0000, Filipe Manana wrote:
> On Thu, Feb 29, 2024 at 6:35 PM Boris Burkov <boris@bur.io> wrote:
> >
> > btrfs forget assumes the device still exists in the block layer and
> > that we can lookup its dev_t. For handling some tricky cases with
> > changing devt across device recreation, we need udev rules that run on
> > device removal. However, at that point, there is no node to lookup, so
> > we need to rely on the cached name. Refactor the forget code to handle
> > this case, while still preferring to use dev_t when possible.
> >
> > Tested by a new fstest btrfs/303 which uses parted to trigger a
> 
> Haven't read the code, but this is confusing.
> 
> What is test btrfs/303?
> Currently it doesn't exist upstream in the for-next branch or any other.
> 
> There were two tests recently submitted upstream with a number of
> btrfs/303, one for send and another for qgroups.
> None of them is what you are referring to.

I *truly* hate the numbered tests naming system. It's awful.

> 
> Even if it's in some branch of the fstests forked repo
> (https://github.com/kdave/xfstests), mentioning that and the branch
> name is still confusing.
> Because that is periodically rebased on the upstream repo, and
> therefore the number 303 could change to something else sooner or
> later.
> 
> My suggestion, paste here the test code in the change log as a simple
> bash script, like I usually do in my change logs.
> That eliminates any confusion, and it also makes it a lot simpler to
> run the test, just copy paste it to a file, make it executable and
> voilá.

Great idea, will do.

> 
> Thanks.
> 
> > partition to take on different devts between remounts. That test passing
> > also assumes btrfs-progs patches which takes advantage of this kernel
> > change in `device scan -u` and udev.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/super.c   | 11 ++++-------
> >  fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++++++++---------
> >  fs/btrfs/volumes.h |  1 +
> >  3 files changed, 42 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 7e44ccaf348f..3609b9a773f7 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -2192,7 +2192,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
> >  {
> >         struct btrfs_ioctl_vol_args *vol;
> >         struct btrfs_device *device = NULL;
> > -       dev_t devt = 0;
> > +       char *name = NULL;
> >         int ret = -ENOTTY;
> >
> >         if (!capable(CAP_SYS_ADMIN))
> > @@ -2217,12 +2217,9 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
> >                 mutex_unlock(&uuid_mutex);
> >                 break;
> >         case BTRFS_IOC_FORGET_DEV:
> > -               if (vol->name[0] != 0) {
> > -                       ret = lookup_bdev(vol->name, &devt);
> > -                       if (ret)
> > -                               break;
> > -               }
> > -               ret = btrfs_forget_devices(devt);
> > +               if (vol->name[0] != 0)
> > +                       name = vol->name;
> > +               ret = btrfs_forget_devices_by_name(name);
> >                 break;
> >         case BTRFS_IOC_DEVICES_READY:
> >                 mutex_lock(&uuid_mutex);
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 3cc947a42116..68fb0b64ab3f 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -503,11 +503,13 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
> >  }
> >
> >  /*
> > - *  Search and remove all stale devices (which are not mounted).  When both
> > + *  Search and remove all stale devices (which are not mounted).  When all
> >   *  inputs are NULL, it will search and release all stale devices.
> >   *
> >   *  @devt:         Optional. When provided will it release all unmounted devices
> > - *                 matching this devt only.
> > + *                 matching this devt only. Don't set together with name.
> > + *  @name:         Optional. When provided will it release all unmounted devices
> > + *                 matching this name only. Don't set together with devt.
> >   *  @skip_device:  Optional. Will skip this device when searching for the stale
> >   *                 devices.
> >   *
> > @@ -515,14 +517,16 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
> >   *             -EBUSY if @devt is a mounted device.
> >   *             -ENOENT if @devt does not match any device in the list.
> >   */
> > -static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device)
> > +static int btrfs_free_stale_devices(dev_t devt, char *name, struct btrfs_device *skip_device)
> >  {
> >         struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
> >         struct btrfs_device *device, *tmp_device;
> >         int ret;
> >         bool freed = false;
> > +       bool searching = devt || name;
> >
> >         lockdep_assert_held(&uuid_mutex);
> > +       ASSERT(!(devt && name));
> >
> >         /* Return good status if there is no instance of devt. */
> >         ret = 0;
> > @@ -533,14 +537,18 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
> >                                          &fs_devices->devices, dev_list) {
> >                         if (skip_device && skip_device == device)
> >                                 continue;
> > +                       if (!searching)
> > +                               goto found;
> >                         if (devt && devt != device->devt)
> >                                 continue;
> > +                       if (name && device->name && strcmp(device->name->str, name))
> > +                               continue;
> > +found:
> >                         if (fs_devices->opened) {
> > -                               if (devt)
> > +                               if (searching)
> >                                         ret = -EBUSY;
> >                                 break;
> >                         }
> > -
> >                         /* delete the stale device */
> >                         fs_devices->num_devices--;
> >                         list_del(&device->dev_list);
> > @@ -561,7 +569,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
> >         if (freed)
> >                 return 0;
> >
> > -       return ret;
> > +       return ret ? ret : -ENODEV;
> >  }
> >
> >  static struct btrfs_fs_devices *find_fsid_by_device(
> > @@ -1288,12 +1296,32 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
> >         return disk_super;
> >  }
> >
> > +int btrfs_forget_devices_by_name(char *name)
> > +{
> > +       int ret;
> > +       dev_t devt = 0;
> > +
> > +       /*
> > +        * Ideally, use devt, but if not, use name.
> > +        * Note: Assumes lookup_bdev handles NULL name gracefully.
> > +        */
> > +       ret = lookup_bdev(name, &devt);
> > +       if (!ret)
> > +               name = NULL;
> > +
> > +       mutex_lock(&uuid_mutex);
> > +       ret = btrfs_free_stale_devices(devt, name, NULL);
> > +       mutex_unlock(&uuid_mutex);
> > +
> > +       return ret;
> > +}
> > +
> >  int btrfs_forget_devices(dev_t devt)
> >  {
> >         int ret;
> >
> >         mutex_lock(&uuid_mutex);
> > -       ret = btrfs_free_stale_devices(devt, NULL);
> > +       ret = btrfs_free_stale_devices(devt, NULL, NULL);
> >         mutex_unlock(&uuid_mutex);
> >
> >         return ret;
> > @@ -1364,7 +1392,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >                         btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> >                                    path, ret);
> >                 else
> > -                       btrfs_free_stale_devices(devt, NULL);
> > +                       btrfs_free_stale_devices(devt, NULL, NULL);
> >
> >                 pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
> >                 device = NULL;
> > @@ -1373,7 +1401,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >
> >         device = device_list_add(path, disk_super, &new_device_added);
> >         if (!IS_ERR(device) && new_device_added)
> > -               btrfs_free_stale_devices(device->devt, device);
> > +               btrfs_free_stale_devices(device->devt, NULL, device);
> >
> >  free_disk_super:
> >         btrfs_release_disk_super(disk_super);
> > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > index feba8d53526c..a5388a6b2969 100644
> > --- a/fs/btrfs/volumes.h
> > +++ b/fs/btrfs/volumes.h
> > @@ -681,6 +681,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
> >                        blk_mode_t flags, void *holder);
> >  struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> >                                            bool mount_arg_dev);
> > +int btrfs_forget_devices_by_name(char *name);
> >  int btrfs_forget_devices(dev_t devt);
> >  void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
> >  void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
> > --
> > 2.43.0
> >
> >

