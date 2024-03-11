Return-Path: <linux-btrfs+bounces-3199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0F878957
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 21:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278AE1C2141C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2F5677F;
	Mon, 11 Mar 2024 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p8slDniw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252854F95
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188113; cv=none; b=SveGJTdaCFKyaMQtxcxjUB064S6mJgZ6t0piFVFGFCvjumkHoyz5gJcxOoCuFwcgd6ltJNKpW1Caf34lXUwxNpIZusFZ45g857ISB4Yh1wT6MOrveLkrtnQ4J3xSHY9IG5p4tVfon5/aAfTEJm35td706yqCJJGkGuk9Y5wwQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188113; c=relaxed/simple;
	bh=QbYADPDBIWMz8RvVNhlHQlSLvPk4ZApr2C24Ncddp4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl5aY3GTDgTMp5S0XqoCXTdPmXjtKs1i+OBZqNrHRR5ggEMxSozc1X1IZlPhYclufkg3o6nMfMjrf4FvktK0rEdHrTSM54eJkGzziQ8MlGEUfRJRLPvWgAGJRwOiSXP6pcWedZV+AE76+hOBdjEbzi7yL2XHEHc4+904mpDcHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p8slDniw; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Mar 2024 16:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710188109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPH7ucjw82hmheL2YoPYII61gZkvtsG0gacrsgo96lg=;
	b=p8slDniwhJzap8O8HgyaftK4FtnPREo6B2abiXJgMgbDkSL/isMmm8OiMAAj+USVAoTvkg
	SdMQ5k23nPvC/tewL/wN5WJmfTLvf6oks3ahPs1LNz8adWgsF2g1Wc8mBcYoy/PqjLuxXz
	v9WwRFQQsDKEZM5E7Q1JY0EOAqThcD8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <kzhjrn5kfggurz46wahncz4smekj7aizmhoe4sqphxt44vyfdm@3fgozft33f5u>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com>
 <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 11, 2024 at 02:43:11PM +0100, Christian Brauner wrote:
> On Mon, Mar 11, 2024 at 08:12:33AM +0000, Johannes Thumshirn wrote:
> > On 08.03.24 03:29, Kent Overstreet wrote:
> > > Add a new statx field for (sub)volume identifiers, as implemented by
> > > btrfs and bcachefs.
> > > 
> > > This includes bcachefs support; we'll definitely want btrfs support as
> > > well.
> > 
> > For btrfs you can add the following:
> > 
> > 
> >  From 82343b7cb2a947bca43234c443b9c22339367f68 Mon Sep 17 00:00:00 2001
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Date: Mon, 11 Mar 2024 09:09:36 +0100
> > Subject: [PATCH] btrfs: provide subvolume id for statx
> > 
> > Add the inode's subvolume id to the newly proposed statx subvol field.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> 
> Thanks, will fold, once I hear from Josef.

Can we try to make 6.9? Need to know what to put in the manpage, and
I've got userspace tooling that wants to use it.

