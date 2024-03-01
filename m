Return-Path: <linux-btrfs+bounces-2972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E4086E495
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91D71C222F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8B6FB9D;
	Fri,  1 Mar 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DALqA5ds";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdD50uaj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746F39FCF
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307817; cv=none; b=jJMM2ie+/A+IpszBnj1TrFzM8NK4CCycdNhF/G+iyJj4VJXhUGmM1OKCliD3qxicuaCASs/huiUuaPM8ytCPe6gdvhlAUXdEAOsGQDk/cIi9IwczfNCaB3fYN9IMZjkuFc3ONCjOBSKU3py+irQ781KfQCapq3b2UnycMtCUJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307817; c=relaxed/simple;
	bh=y6Vw4aglAp91qE3Kcw+c71ZaAhmotuAc6XmPYMMubc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwaxpbTHYqRrO1Bal6SiyvAXjWHsCv3OB/5qmGMSJLo9ibcYuWRsSU0S/Z6XnQBPVhQT+hm9MVYa3WZQh5FE+poL3SLRwcOCJk3PZZVz4ECN12uiUgqcEUXALiwZQZQO4G8fBQ1wfeCZoLN9F7TOpcosPbwBEj4Wt4dg7EJeYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DALqA5ds; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jdD50uaj; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C70E93200AC7;
	Fri,  1 Mar 2024 10:43:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 01 Mar 2024 10:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709307813; x=1709394213; bh=EV5gfBReEq
	gPlV+L9BlfwYiH6UM/e8uFsSNO8c68bts=; b=DALqA5ds816Aztck5ndyRX2sqI
	vcdNsed4RExLryn5N+H0C3K3ey9syDZegV0l4vDKXJxSiYyA+QNVnKPPye7OLwMT
	ySX7hYi3dDehFi7qchFT+i2bMSbL+/mbO14kwp7gzxptIc63zkU+tA2r9Yc+dwlb
	mH97lYdwxA5fSP058xQ6Lyg+0eGVyGd+6YYLXs5tf4DCCpmQFAPAyaaVmZAgyDMY
	iXSAng3xE9Pt3YTnMmjLMQE2e0PeabCLEHtPl1/6OmE/7urMNqTJHyRLTyepaRPw
	EumgDHwb75EpibN9lf6WM9VYwqVF5+kEEzzXZdBa/pVFiSFUi359d+DQhfqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709307813; x=1709394213; bh=EV5gfBReEqgPlV+L9BlfwYiH6UM/
	e8uFsSNO8c68bts=; b=jdD50uajRZRCYALGoNb+ULujkf/OJuC/wovcJPgOPKX+
	01ADQGBY+DVIPytFNWwBm77t9qraAIJj8YVvm9hddJ4BQ5zuvBpyu/ViMnjYKE/l
	k1CbcF5jHLGEGyoFmjhv1bFwtT1kkRMyCajm8esTi7ea2EquiUKeWKwQUglIAoE1
	oiRVzRqFcsqemKR7jg9uQ6bNKzP2tekZ3GL7QGRdY6YNEaCNvchDzoTK/ETzbrVG
	/ZmZqDtJTUPqiSKC/KTpkTjVqVwKd+vqQPHieT/RE6tEcRQYbbV5Hb+Gaom6KcAx
	vsWmWpeFColeP9a3Yaxs8MfcdxLrLvEOWsIexPqxRg==
X-ME-Sender: <xms:pPfhZckhf_huSE7smVve-2PR279sznqdAvMs6wVa8HGH60H8tEtxbA>
    <xme:pPfhZb0UvsE-hwWkb75t06LgBf3H1njhMKsCFQkDNY_TasxZAND6yGEwv6QJ1Sen-
    KRFPr6Xne48X4wppEo>
X-ME-Received: <xmr:pPfhZar6LEDomQx3Vnh8I8z6R6EEGJ6KvpVbcfhwsnFusITjdvQAHGnF63B3FlgJuBT8F7UxtnFFkFiBtbsGyMrGVmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:pffhZYni9oGbkPksr9pkhhcKcBgmYaw8G1aBQlTwmfc4kxv67hYERw>
    <xmx:pffhZa1ONQZCrMroR9v7Tx7Vwvf0QpDGswAIdg1QPPj5u29V3jzSBg>
    <xmx:pffhZfuJxJcjAqeWHlFv-MHAXyHU3MHBkENadK3vncSouiyhWqsHbg>
    <xmx:pffhZYCkiHcN-kOpKNHzAFtz4ErAgKTaSlHNyVtj2LEham7QrqgjAQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Mar 2024 10:43:32 -0500 (EST)
Date: Fri, 1 Mar 2024 07:44:44 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs-progs: forget removed devices
Message-ID: <20240301154444.GB1832434@zen.localdomain>
References: <cover.1709231441.git.boris@bur.io>
 <751eba3d-c72e-475b-8d21-e15c1d085ce0@oracle.com>
 <20240301115442.GI2604@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301115442.GI2604@twin.jikos.cz>

On Fri, Mar 01, 2024 at 12:54:42PM +0100, David Sterba wrote:
> On Fri, Mar 01, 2024 at 08:01:44AM +0530, Anand Jain wrote:
> > On 3/1/24 00:06, Boris Burkov wrote:
> > > To fix bugs in multi-dev filesystems not handling a devt changing under
> > > them when a device gets destroyed and re-created with a different devt,
> > > we need to forget devices as they get removed.
> > > 
> > > Modify scan -u to take advantage of the kernel taking unvalidated block
> > > dev names and modify udev to invoke this scan -u on device remove.
> > > 
> > 
> > Unless we have a specific bug still present after the patch
> > "[PATCH] btrfs: validate device maj:min during open," can we
> > hold off on using the external udev trigger to clean up stale
> > devices in the btrfs kernel?
> > 
> > IMO, these loopholes have to be fixed in the kernel regardless.
> 
> Agreed, spreading the solution to user space and depending on async
> events would only make things harder to debug in the end.

In my opinion, leaving the incorrect cache around after a device is
destroyed is a footgun and a recipe for future error. Patching it up
with Anand's kernel-only fix will fix the problem for now, but I would
not be at all surprised if there isn't a different more serious problem
waiting for us down the road. We're just looking at exactly devt and
temp_fsid, and I'm quite focused on breaking single device filesystems.
I spent a week or two hacking on that reproducer. Are we *confident* that
I couldn't do it again if I tried with all kinds of raid arrays, error
injection, races, etc? What about after we add three more features to
volume management and it's been two years?

Getting a notification on device destruction and removing our state for
that device is the correct fix. If things like this need to be
in-kernel, then why is udev the only mechanism for this kind of
communication? Can we get a callback from the block layer?

Boris

