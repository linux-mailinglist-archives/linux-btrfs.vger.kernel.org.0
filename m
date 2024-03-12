Return-Path: <linux-btrfs+bounces-3234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E311879C2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 20:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD32287959
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96E14263B;
	Tue, 12 Mar 2024 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="c+gh9Z/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOp69Aly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF97E761;
	Tue, 12 Mar 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271002; cv=none; b=hdc3EZOWVYtcs+dDeR/RpRy5t/4h4Rn0C9lmGagniBXG2hI6avovFW0FvJUxD1ILHf3jRlTH+Db6cun7EH3g1jDCPTHaroDdl9YbB9Zitv2aN6odBt14TJjz2B1PJpo1uJ/kotozRIKRnR9L57Lh+1mFlo7FgplDkDRipCBLqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271002; c=relaxed/simple;
	bh=5j6QeDtWO58mmaTdwshkUJxyTsa96Ky/7JBvc4Mgyzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBfPL4qs8Sd+jPO3F5mhas+CFean433LyOiHscZmOdGYZc3k+3NNqeOR+Isb2h4jS0e43iw78VNYsQxeUcoYxTeKPEvq+qXNDst21QdYMdX0buEnOBtTRBOKmwl5Nz47EzMVjGhjeJ+QNbyUU2up5WQJsV+UEcysg4A6INf+x+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=c+gh9Z/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOp69Aly; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2D20D5C0062;
	Tue, 12 Mar 2024 15:16:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 15:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710270999; x=1710357399; bh=zSAHdQop2U
	bbpk6h+DLvM6shV2H5ZnQtgNpwK+0CbOA=; b=c+gh9Z/J2ZJp92oKM8eS25+0As
	nL6K0MLg+eO75RuF8SYHM9T2JddWJXPhc+7CE6kvGT8HSPsUpfTae7r2vRj8QLej
	qHY8n9BbFL60ZI5R1nEnE/Xlqp5kHASAssJF2P9ZNM14LMOLodnyvlNpw85e9K+H
	PXaOKuc6U1aavqofj4rHnSvbWSvniFW14z/ZaFxzjdxEHWVSeuIKdRhvL3WKrUuD
	T+Yyw+MG3ENJyiN4tGBceWcDqJB98MZWcphQPT8xDoTwG2ST4WgY96IsZi3v46eZ
	0nuG2Og71m2SxfCwr36nmKOlFtrTpMlYLCXiRSyVJ+Tutnq2IAnh5mjbxAaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710270999; x=1710357399; bh=zSAHdQop2Ubbpk6h+DLvM6shV2H5
	ZnQtgNpwK+0CbOA=; b=kOp69Aly9CeH215lxdoBYXlN6cj0NG0oiGALCY6MRil/
	nmW7OqAbRF/NbfVjFcJdwoEvz9ezeD51bbBvjM1Fy60t6o/WZo+fyB+wSH/4lTNN
	ST0JjVfIz0Y5Ziu3984wa8TJUNWAAS7m3ACA4BQ9/+JcpgiJIAZsLHP+gbhwlwuJ
	mKmH+ZIgQEoQOn+0gcnpgcIk5hkYLl6NBkCx0Cpw+BCCtv8nS6ZBeQ81hbFye6Np
	k9io4rlmCU/ZhQ4ndqi9aoCDKL8doldkm/3i5O5OKOBnWiZc5yNdgxmHLaAX/UA6
	T2/P0bnJyP9WzJ8BaK27KojkfTLbO9efzIpRcKCM7A==
X-ME-Sender: <xms:FqrwZSZxFrQftV9BZC7acTEbaWa6rCsW2Tw6pIDn8W2lIMNL5QSWag>
    <xme:FqrwZVZtNGLtpUr3Fqisz1gUFwwNpyWRwDukRI5OXrw2uNL7vZTo0iO7bq4cN0R7T
    s2GVfwpRmu0Cz-lXOk>
X-ME-Received: <xmr:FqrwZc8pNkEHSemM64KAbdUKXtORgkzQMD9NCF5BBjPVnDY1Q1iyYLqVj9UXxKHx62gVn9UCdo1-Nigg1NO-C1fn944>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehtdfhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:F6rwZUozV78bl_55lLyUAPU2mKxoMJbWcXLvADlAwowC2fnVoYVCSg>
    <xmx:F6rwZdoWsYDRRzjXySkNUfWxwNaghGVY3tk7unzhlIdR7gLInEuAcA>
    <xmx:F6rwZSQzzYN6H6ODehdZOdd7UA9Hx2UE9ATB3L4NS57xyHoZDxj4EQ>
    <xmx:F6rwZdqvHkqnHtYbiw6-a4VzxfdNPZXcidILtQS2SMghnw-GVWr2ug>
    <xmx:F6rwZUVZExbnFB_GQWQetMmQndEd-MvFixUcZYWTZq9JWAc73yId6g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 15:16:38 -0400 (EDT)
Date: Tue, 12 Mar 2024 12:17:32 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate device maj:min during open
Message-ID: <20240312191732.GB2898816@zen.localdomain>
References: <845dfb4fbf36dae204020c6a0a0e027cab42bcf0.1709865032.git.anand.jain@oracle.com>
 <20240308174138.GB2469063@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308174138.GB2469063@zen.localdomain>

On Fri, Mar 08, 2024 at 09:41:38AM -0800, Boris Burkov wrote:
> On Fri, Mar 08, 2024 at 08:15:07AM +0530, Anand Jain wrote:
> > Boris managed to create a device capable of changing its maj:min without
> > altering its device path.
> > 
> > Only multi-devices can be scanned. A device that gets scanned and remains
> > in the Btrfs kernel cache might end up with an incorrect maj:min.
> > 
> > Despite the tempfsid feature patch did not introduce this bug, it could
> > lead to issues if the above multi-device is converted to a single device
> > with a stale maj:min. Subsequently, attempting to mount the same device
> > with the correct maj:min might mistake it for another device with the same
> > fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.
> > 
> > To address this, this patch validates the device's maj:min at the time of
> > device open and updates it if it has changed since the last scan.
> 
> You and Dave have convinced me that it is important to fix this in the
> kernel. I still have a hope of simplifying this further, while we are
> here and have the code kicking around in our heads.
> 

I don't want to get stuck on this forever, so feel free to add
Reviewed-by: Boris Burkov <boris@bur.io>

However, I would still love to get rid of device->devt if possible. It
seems like it might be needed for that other grub bug you fixed. Though
perhaps not, since we do skip stale devices in much of the logic.

Anyway, let's move forward with this! Thanks for hacking on it with me.

> > 
> > CC: stable@vger.kernel.org # 6.7+
> > Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
> > Reported-by: Boris Burkov <boris@bur.io>
> > Co-developed-by: Boris Burkov <boris@bur.io>
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > v2:
> > Drop using lookup_bdev() instead, get it from device->bdev->bd_dev.
> > 
> > v1:
> > https://lore.kernel.org/linux-btrfs/752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com/
> > 
> >  fs/btrfs/volumes.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index e49935a54da0..c318640b4472 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -692,6 +692,16 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
> >  	device->bdev = bdev_handle->bdev;
> >  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
> >  
> > +	if (device->devt != device->bdev->bd_dev) {
> > +		btrfs_warn(NULL,
> > +			   "device %s maj:min changed from %d:%d to %d:%d",
> > +			   device->name->str, MAJOR(device->devt),
> > +			   MINOR(device->devt), MAJOR(device->bdev->bd_dev),
> > +			   MINOR(device->bdev->bd_dev));
> > +
> > +		device->devt = device->bdev->bd_dev;
> > +	}
> > +
> 
> If we are permanently maintaining an invariant that device->devt ==
> device->bdev->bd_dev, do we even need device->devt? As far as I can
> tell, all the logic that uses device->devt assumes that the device is
> not stale, both in the temp_fsid found_by_devt lookup and in the "device
> changed name" check. If so, we could just always use
> device->bdev->bd_dev and eliminate this confusion/source of bugs
> entirely.
> 
> >  	fs_devices->open_devices++;
> >  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
> >  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> > -- 
> > 2.38.1
> > 

