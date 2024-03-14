Return-Path: <linux-btrfs+bounces-3293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC487C188
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35AB1F21B06
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746307351E;
	Thu, 14 Mar 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="p7BKA/JD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4bmfuWO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4986F524
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434984; cv=none; b=ZWahMJOMcKJAJC0sRgT9mU3zoxCzDDi73TAk4dGrwA3NOTcNdXJsVX4dLvSCXdLkGT0+vayz4SOZt141T4GwUCJJ0JkLjZinua+GU8pgiJn+7DQBL7mlSicjrg0hdDs0K6Cx1lKO+lDMUebD0bnSaso3z5WvTi4qOlVM+98BMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434984; c=relaxed/simple;
	bh=NqEEFAGvrNk+cpB2tFzwOFUv3yNxGRXmuSR3lPqVqWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhcjzNqzFS8KfE76LsbHeCRa73A7EINnzvgLHSRq0UleQYKJQwrA7PDJk0BjOEMhrVEL+3Cjk/XpDmTIdKx8AZOJ3RKLEgZIDb3eQOxFKyTNrWc3jMSK82cT83Ta4zYGkCjOBGrIpJCimcSMH7gcr7Zxwhp0ZbtLipeE9D7/SQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=p7BKA/JD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4bmfuWO; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 6414E5C007D;
	Thu, 14 Mar 2024 12:49:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 14 Mar 2024 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710434981; x=1710521381; bh=Gd3ZvA3XOu
	/I6s8noW1HQBpAijEKN0dP+hAvzvfDM/w=; b=p7BKA/JDrzsWDRDUzIkqVrsPcB
	50hIaXCJ4yQuCiewaW4HJZEB4STfV2vT87G3y05wRimnXqSP09qiB+iC1fUvZa9v
	uUZ8RHD2xaK40RtEenVJeQw8uKIIeuA3Tu4rooaejGRhvsTNgB5B18v3BJ6iW6I4
	LOged+2SftA59MOZYTtetWC1n4rVYW82TDqTHFDKyp1B9tTod7CojCfDLX+XvHkx
	BLrVDSuxIz88NTS4QfkdzfUbf91KWNTjSvjv5Vm5E18lxXIJxSC5X6mYYe8GAjG8
	/6kZHQauePf8i8/5mUKIiMeQ9ci18YLA4+aHzU2pFN91dUA/0jHAyNzrDOKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710434981; x=1710521381; bh=Gd3ZvA3XOu/I6s8noW1HQBpAijEK
	N0dP+hAvzvfDM/w=; b=c4bmfuWO8Nsatge9dBkmHF8ZUw/ETZkhqkHxqsnlPhyF
	ENFNSzUaYrV4gWGFp6dJ8yb/VmgVS17Qk97i442RmFcOzolL4z6WF5E330xodMEY
	PwjJ1/rCVjMTn6/fknaeGTMqqTKbGD2cRK/ic/t031zx2xfMJhx1OtXlQbNW/XS+
	6S5br6/4Se2EFCPU5cFIRP2HZn92JxIDm0O0GrUKN/SN6ARUnXHV5gqdwR/I2y4e
	b8t3C6ipjA1nV2YnX87+aoKt3J+KML8qrY7rO9jce4b8mdahY9FPp6uRIq3FtF/Z
	pFB2TtjgUAamBuEQKIrDXq/7UZlyOvPyxzDu6cAOig==
X-ME-Sender: <xms:pSrzZZiyfnfaEVUc4q9U5O-FfshOhXf19FmXIesCw5A8CrQrkl61Iw>
    <xme:pSrzZeC2fHH82yd-TrHw82VBAd8a2uF7s1Frki02OM2WXeae21PuCuxjSDNcwHyvs
    KsC006AoZ1Cr-d15jc>
X-ME-Received: <xmr:pSrzZZF1Rywi49hfdaNV7nR1pGpZDEePq8pMiaJyqHaF-3-wAeV_YoaMKK94xdl8vgCmuHuS9kpPLZEf2HctgDF8YKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:pSrzZeTAnHLh0UkHCtktg0hfQbJIhbKVDHGdoTdj0jCT-7x8rXhTUw>
    <xmx:pSrzZWy9fmh7L6bQhuZLInEwODGXyT8JzHdxLhUwRi9NSIV-2O9-9A>
    <xmx:pSrzZU5LnCQdALwx8oYeb67AGHz6AQ5OFeYNJKjrV48wbQovOi3O_Q>
    <xmx:pSrzZby1uYRhnsbgZBcPTTaoY8cgNlta5asLBEhEbt4TCuAwE7S_zw>
    <xmx:pSrzZbqETbp9KCXg8EyksnkH2-0zB2-uukZGqqbdhKMYMQZgMI9U6A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 12:49:40 -0400 (EDT)
Date: Thu, 14 Mar 2024 09:50:31 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: return accurate error code on open failure
Message-ID: <20240314165031.GB3483638@zen.localdomain>
References: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
 <0108b2de-56f5-4a7c-94a1-db415be8653c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0108b2de-56f5-4a7c-94a1-db415be8653c@oracle.com>

On Thu, Mar 14, 2024 at 07:09:24PM +0530, Anand Jain wrote:
> 
> And this one as well, for the review. Thx.
> 
> 
> On 3/9/24 19:16, Anand Jain wrote:
> > When attempting to exclusive open a device which has no exclusive open
> > permission, such as a physical device associated with the flakey dm
> > device, the open operation will fail, resulting in a mount failure.
> > 
> > In this particular scenario, we erroneously return -EINVAL instead of the
> > correct error code provided by the bdev_open_by_path() function, which is
> > -EBUSY.
> > 
> > Fix this, by returning error code from the bdev_open_by_path() function.
> > With this correction, the mount error message will align with that of
> > ext4 and xfs.
> > 
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>

One small "nit", but LGTM.

Reviewed-by: Boris Burkov <boris@bur.io>

> > ---
> >   fs/btrfs/volumes.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index bb0857cfbef2..8a35605822bf 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1191,6 +1191,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> >   	struct btrfs_device *device;
> >   	struct btrfs_device *latest_dev = NULL;
> >   	struct btrfs_device *tmp_device;
> > +	int ret_err = 0;

A quick grep shows that "err" is a much more common name for the
variable when using this pattern in btrfs.

> >   	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
> >   				 dev_list) {
> > @@ -1205,9 +1206,15 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> >   			list_del(&device->dev_list);
> >   			btrfs_free_device(device);
> >   		}
> > +		if (ret_err == 0 && ret != 0)
> > +			ret_err = ret;
> >   	}
> > -	if (fs_devices->open_devices == 0)
> > +
> > +	if (fs_devices->open_devices == 0) {
> > +		if (ret_err)
> > +			return ret_err;
> >   		return -EINVAL;
> > +	}
> >   	fs_devices->opened = 1;
> >   	fs_devices->latest_dev = latest_dev;
> 

