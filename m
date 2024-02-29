Return-Path: <linux-btrfs+bounces-2951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A356786D443
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 21:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9941C20CBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23ED1428F1;
	Thu, 29 Feb 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RqWE8bpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ha/CQsGS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6C7BAEB
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238782; cv=none; b=XnPCn8qGmwFHgofQngBOm5vRf3wMOfVghkKnTrWjhSTdl0rd2qZEeJnUR+o2M46BprSi1QAzhzq8+kjZFX2MEX3kKspzzvnRFKU/v1KXuQTFSaXZLdx8/c9Got8dTOnWAIMKzAxl9w6/JVoACtH1ag6y5smIQW/pUyjuX1QW0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238782; c=relaxed/simple;
	bh=rNb7QAv2ydfHFTdoNAmq+peAlZmgeFvxPF+fDEUhAMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBpNabIJvAppSa9z+WIBEeQOj7gGlKTU5eGm3lJ6ivGrSl/tulWpEiZHG01fD0NnffKBrO7uJcPbIxdQbqyTiD2vkvvAqp6j21fYeSim9OZxDwrhlO8c0YTAgNBcgau7pM2234ZJMpDP3tYppc/3EIycT0YRt68/iVOBBBIevvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=RqWE8bpH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ha/CQsGS; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 4A3673200392;
	Thu, 29 Feb 2024 15:32:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Feb 2024 15:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709238777; x=1709325177; bh=RgsTh2cDTS
	QUS6uCF9NwpyaE58OPuaBqdqmsjIMYdto=; b=RqWE8bpHKpCr/pDTtOiNioMd+c
	XzrfLlWplkrxR5zcB3cjIKveeMIQOPCnfdaUw7EZa+nqtzNe8pl24vf69t7hEpi3
	6Z2kpOJCSBQAzG8QG91HlwwZnE2S803n+cg9goDHOro4T69CYMEt1p2BTZSi9Rln
	c4Od6beA5BK+jp4Yb3VI/AR9jOBAegHFW3BpzpE6d46CYsq8RtUIzo5+cz+BEP5X
	P7d0nJW9dbNnA5AveVrGxIPcbWm3UUibvNapnySnb7lVh1D8Te5r3ny5i1zxqRz/
	EzutZHRYYPnHF3UM77sGUyVBjSO71PY+18mdbBtMMIhGvvadBlq57sqzDPNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709238777; x=1709325177; bh=RgsTh2cDTSQUS6uCF9NwpyaE58OP
	uaBqdqmsjIMYdto=; b=ha/CQsGSBaoillvvUJPPztStZpWSgIZm2fP52xsv4InJ
	Yf5x91XDtkwYoTic7mT3NRgIEP0hc4KrYvKWM/NY+GZ7VsRZSpEy2J8iI0mf2TSR
	cnLyyVVmLH2ThB/FMXzUeusLZu8aHtLLQ0hMC2PV/lBd3jcToWUQHBi8ZT55b6ib
	i8D8e7J/LKG2OCOu1UrWHn+KEkz0oiyt9j2o9KLtT+R+GnU0k1Xpc6d3RaUxbTHz
	IEmZBxGeb9t8Xu1dtU2HJLJCCpr2j/NIIkprvbJTyjVz5cbevMbdj+XfDuD9FBqF
	uN5AJz0A1Rsvpj9psBrNQG/NMlPHvKReFDXYvNgMKA==
X-ME-Sender: <xms:-engZUUutLYgWgCpBC1S16_CJAJ-LSgFDlcivmMTIblnNLc1urKfSA>
    <xme:-engZYnN23G7B-1qZu_dob4WfYSpUEW_40wZK9sIF1gS_aMyVs8RJ2WHw_VbA0ty4
    TMDsLtwPv8oZAY1fXs>
X-ME-Received: <xmr:-engZYbx6zRMazNUIUP2YCC7mqUY5JJBR0qHlTRIpd09nKKjH64P9FiHdrbr7y3__xZMDzX_YEew7sAK_9fDEVg5Okc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:-engZTWm36P_ahh4OXGB9nwnLs5PIHJeV9cTNhX6cpJWmXHPyePe_Q>
    <xmx:-engZekmrSBbqnW3Tm9sWEMg9pR-teaJh_xY0jMmyZ2xns4AAcU0AQ>
    <xmx:-engZYeDYegOzbagnFjb-R6jnnHkyrqsI5-bPqNJNK12ZIgre4eHwg>
    <xmx:-engZStjDxQ90ZNKolJHzZ_731SONBJlVtG6otiyUJqQg9FplJ395w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 15:32:57 -0500 (EST)
Date: Thu, 29 Feb 2024 12:34:09 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs-progs: add udev rule to forget removed device
Message-ID: <20240229203409.GA1754735@zen.localdomain>
References: <cover.1709231441.git.boris@bur.io>
 <80545243dec10a48562bf8a9b5d10b8ba6f16983.1709231441.git.boris@bur.io>
 <20240229195339.GF2604@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229195339.GF2604@twin.jikos.cz>

On Thu, Feb 29, 2024 at 08:53:39PM +0100, David Sterba wrote:
> On Thu, Feb 29, 2024 at 10:36:55AM -0800, Boris Burkov wrote:
> > Now that btrfs supports forgetting devices that don't exist, we can add
> > a udev rule to take advantage of that. This avoids bad edge cases
> > with cached devices in multi-device filesystems without having to rescan
> > all the devices on every change.
> > 
> > Signed-of-by: Boris Burkov <boris@bur.io>
> > ---
> >  64-btrfs-rm.rules | 7 +++++++
> >  Makefile          | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >  create mode 100644 64-btrfs-rm.rules
> > 
> > diff --git a/64-btrfs-rm.rules b/64-btrfs-rm.rules
> > new file mode 100644
> > index 000000000..852155d28
> > --- /dev/null
> > +++ b/64-btrfs-rm.rules
> > @@ -0,0 +1,7 @@
> 
> Please add a comment that explains when and why this udev rule should be
> used.
> 

Definitely happy to add a comment.

This is certainly the discussion I was hoping to have, as well, but I
thiiink we just always want this? Basically if we don't have it,
multi-device users are in danger of accidentally making a stale device
cache between mounts. It's probably not that big of a risk in general,
but we did hit an easier to hit variant in v5.19 at Meta.

OTOH, there is also the problem that this is a no-op unless the kernel
has the patch I sent at the same time:
btrfs: support device name lookup in forget

I don't think there is any downside to running this command which will
simply fail on an older kernel.

If this becomes ubiquitous, then we can also remove the special case for
single device cache clearing from the btrfs unmount code.

> > +SUBSYSTEM!="block", GOTO="btrfs_rm_end"
> > +ACTION!="remove", GOTO="btrfs_rm_end"
> > +ENV{ID_FS_TYPE}!="btrfs", GOTO="btrfs_rm_end"
> > +
> > +RUN+="/usr/local/bin/btrfs device scan -u $devnode"
> 
> Is the full path mandatory or is 'btrfs' sufficient? I think systemd
> uses own tool of the same name.

Unfortunately, it did not work for me. I saw logs saying
/usr/lib/udev/rules.d/btrfs file not found or something like that in
dmesg.

I also considered the btrfs udev "builtin" but from experimenting and
checking out the code, it looks like that only does device ready, not
all device commands.

> 
> Please use long option name so it's more obvious what it does.

