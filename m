Return-Path: <linux-btrfs+bounces-2975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFE86E9EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 20:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2481C23277
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AF23B780;
	Fri,  1 Mar 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="cm+lJ6ca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jb5XEKo3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41220DCD
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322403; cv=none; b=PyOK1KJPSnTexFvNICIWWewoyd30VQexfVGbYUECNo7t3j6FjHw32tbdqGz6vlkX7xg803klakaNYyd/bpkedbYtiEa9Vjuyrg799ivm7zTmnp9TkNkHdxouIsBEWZ2V4snL76ool/MlNGkM+0pxWJK6TicpgMnndxZM6b+tKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322403; c=relaxed/simple;
	bh=5SV6jS2AP7sF2PNE6R1WJOkj4OrxNZ2Z6g0fgOkyz0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPRTHSOQ1Tz6DUkqpTTALOduzdJfM21jHXl0iM1NxfdvSvPEegAn+B2gUQcvug5K0PxrifZilZWXG+wvY1D2RDKPIsLV6NT33RRRa9sBmVSU0vg6sHTzzrgwP4wxRQ2QqpUN9jYHRo+wTBGFnCqY3XfFZ9MDoMOxY9ybHE1HvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=cm+lJ6ca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jb5XEKo3; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 090765C0181;
	Fri,  1 Mar 2024 14:46:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 01 Mar 2024 14:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709322399; x=1709408799; bh=1LfpmZ3jYl
	ZH8eHvhxlVctz8slhBBEDpT3y7cix+Lg4=; b=cm+lJ6caa/1g2Xm8HCBKCpaMw8
	5oq9kBjT/UVjI2UBAraU8VEK9qyaWiqjfGG6bWP4ArKknrJzKvTaei4sKFRzm+SK
	BG+Fqw0grLnCbvPXb3joXtTGOIWt8WqqGDyEk1sxApefh+piaSYL3rraPDJvBtA2
	knI0xV+EK9yT95Cchak+N7H1/VioGmHgvG3glv7wmbp1Fuedu4z9r7+B4ls3NoGJ
	iADQb/hFy2pfUAfNTe+AB0ClT4JJoayGhbc2/GMso+vC8rcS1xD74euNrzZ4ADyF
	8Kfulp7l3SJC/5AwNGklz5osvDvuYjGOiHU3beKJxOmkRA0jsiFxsFVNyhQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709322399; x=1709408799; bh=1LfpmZ3jYlZH8eHvhxlVctz8slhB
	BEDpT3y7cix+Lg4=; b=jb5XEKo34aeJQwz/J71Tu9Zsfh4Sce4eU8V2Bu8sSsgP
	r1yqZfzvtAuwHpAhPY5MDUDqSf5JLWe0Z+QrFst0pKHArOf9CidRK29Crhf5MulK
	X9G7fQ6EqDaB4t7XH/0LV7OnfFBmdQHACwzTaNYoXC5fmdwo1Nd+4E8/Zqeen/Mq
	E8tT0mdb7oz2a6jYGJJmeYDtvnnm6H/KMKxLAKn4OgSQbE/VN5UL2nepsvMCCOkq
	Svethw8O6kFA3xb5tL9SQR5t5npCcFlPfo1ffQVpv+zqYvArKKZumKJYAnVAInhv
	SLOLuKS4QiD9960YL0vyzqGeLJd+FKncCpOs4W7OTA==
X-ME-Sender: <xms:njDiZakoHFMBPPNuws8r9ucUwvTqHJr38EyZ6LhmyWunj--LBLrOMw>
    <xme:njDiZR1CRwFuyCt2q5clw-nlklhikSwNwUhvK3osqG-0yKumz9cBADzNXHNw71H40
    zrFVSC_qJKOV439TXk>
X-ME-Received: <xmr:njDiZYqM2aDp0IMBJmDLErCMij3hQyCjKipJsvIZkF7i7-5OoJU3ZXZOJZJZF1DuRJDb3GhJZcmLOmI7r9DHwy0rCn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:njDiZek-AHGi_5mCdviatV4ej8LGY5MisOOEoNCo5cd07h8bUq26qA>
    <xmx:njDiZY3jr57jP7fzg2dDivHbMvpwn7ajurEQsXBkv2h3GXIcHb0wIg>
    <xmx:njDiZVstNyRJPeQv9wwOHInvvXbp-6ZtkKkhHPsfYlL2XtDCE_8v8A>
    <xmx:nzDiZV_eHqLWpZNtwtRnP0qRo4LwFuRRZyeG9Nbr-dLzOgUce376hw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Mar 2024 14:46:38 -0500 (EST)
Date: Fri, 1 Mar 2024 11:47:49 -0800
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: validate device maj:min during open
Message-ID: <20240301194749.GA1841098@zen.localdomain>
References: <752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com>
 <20240301153440.GA1832434@zen.localdomain>
 <3edcf934-ba56-4ac3-8edb-1663f327ab3a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edcf934-ba56-4ac3-8edb-1663f327ab3a@oracle.com>

On Fri, Mar 01, 2024 at 10:17:41PM +0530, Anand Jain wrote:
> 
> 
> On 3/1/24 21:04, Boris Burkov wrote:
> > On Fri, Mar 01, 2024 at 07:21:32AM +0530, Anand Jain wrote:
> > > Boris managed to create a device capable of changing its maj:min without
> > > altering its device path.
> > > 
> > > Only multi-devices can be scanned. A device that gets scanned and remains
> > > in the Btrfs kernel cache might end up with an incorrect maj:min.
> > > 
> > > Despite the tempfsid feature patch did not introduce this bug, it could
> > > lead to issues if the above multi-device is converted to a single device
> > > with a stale maj:min. Subsequently, attempting to mount the same device
> > > with the correct maj:min might mistake it for another device with the same
> > > fsid, potentially resulting in wrongly auto-enabling the tempfsid feature.
> > > 
> > > To address this, this patch validates the device's maj:min at the time of
> > > device open and updates it if it has changed since the last scan.
> > 
> 
> > I do believe this patch is correct for fixing my test case,
> 
> Right. It fixes the bug reported in the testcase only.
> 
> > but I don't
> > believe that it is the proper fix for this issue.
> 
> Indeed, I anticipated that it might be confusing. As I've clarified
> elsewhere, this isn't the solution for the already known multi-nodes
> single-device issue. The resolution is currently being discussed.

I'm not familiar with the the multi-nodes single-device issue.

My point was that while I agree that this fix works for the issue I do
know about, an invalid devt in the btrfs device cache, I do not like it
as a matter of taste.

We have an invalid cache and instead of invalidating it in a general
way at the point of invalidation, you are proposing that we just fix it
up when we happen to notice. I believe that is a fragile solution that
will simply leave the door open for more bugs in the future. (if not
present).

If we do go this way, at the very least I think we should do something a
bit more general. Spitballing here, but perhaps we can get rid of all
redundant caching of random values like devt in btrfs_device and just
use the contents of the bdev struct as it is currently in the block
layer. Or we need a way to treat a btrfs_device as invalid unless
open_one_device has run on it.

> 
> I think I've come up with a better idea now. I'll send out the
> proposal soon for discussions.
> 
> However, my first challenge is to simulate a multi-nodes
> single-device environment for testing.
> 
> Thx, Anand
> 
> > This is just plugging
> > one more hole in a leaky dam.
> 
> > > Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
> > > Reported-by: Boris Burkov <boris@bur.io>
> > > Co-developed-by: Boris Burkov <boris@bur.io>
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > >   fs/btrfs/volumes.c | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index deb4f191730d..4c498f088302 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -644,6 +644,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
> > >   	struct bdev_handle *bdev_handle;
> > >   	struct btrfs_super_block *disk_super;
> > >   	u64 devid;
> > > +	dev_t devt;
> > >   	int ret;
> > >   	if (device->bdev)
> > > @@ -692,6 +693,24 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
> > >   	device->bdev = bdev_handle->bdev;
> > >   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
> > > +	ret = lookup_bdev(device->name->str, &devt);
> > 
> > It should be fine to just use the dev_t in bdev_handle->bdev->bd_dev.
> > 
> > > +	if (ret) {
> > > +		btrfs_err(NULL,
> > > +	"failed to validate (%d:%d) maj:min for device %s %d resetting to 0",
> > > +			  MAJOR(device->devt), MINOR(device->devt),
> > > +			  device->name->str, ret);
> > > +		device->devt = 0;
> > > +	} else {
> > > +		if (device->devt != devt) {
> > > +			btrfs_warn(NULL,
> > > +				"device %s maj:min changed from %d:%d to %d:%d",
> > > +				   device->name->str, MAJOR(device->devt),
> > > +				   MINOR(device->devt), MAJOR(devt),
> > > +				   MINOR(devt));
> > > +			device->devt = devt;
> > > +		}
> > > +	}
> > > +
> > >   	fs_devices->open_devices++;
> > >   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
> > >   	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> > > -- 
> > > 2.38.1
> > > 

