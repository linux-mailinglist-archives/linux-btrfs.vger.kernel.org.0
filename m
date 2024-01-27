Return-Path: <linux-btrfs+bounces-1857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3CA83F02E
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2926E282A3C
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06411AADA;
	Sat, 27 Jan 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eqvWoO2h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20224199A0;
	Sat, 27 Jan 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390353; cv=none; b=U1iM8g8tRkGon4DM4exYUc+BTrIu2F7WvCG3rEWZF4pBxV3TBr7ntc6pSEVhZuB+qSRoRqcOVp8/i7feWST0HArIps5M+9eIw2WBgudhzS1p8ernhxPhXSL0QiVRPCIuu7qR4FRT/PkLHk/JxeKusbv9W3Ypeqd15jDHoltSiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390353; c=relaxed/simple;
	bh=vWLXP5N/7E4Yq4GujEHG6iMiMI0uPzoSWHXQa+nEzPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq6yamiMUAcIB/Q/4N0RAB8J+XoYB9CVbkww8x3YS5ZZGkqVLgRHfow1lXlYd7dQDtL43l2YUQltxbfQmM/MXoKPVh5Y54qP34zHG7r7Fh53vtVFwYIRWgIW4rJdxP87PDhMQucnHkC9nPjbrCcHIZl22nQcwCe5FfJjA7W7ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eqvWoO2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BB1C433F1;
	Sat, 27 Jan 2024 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706390352;
	bh=vWLXP5N/7E4Yq4GujEHG6iMiMI0uPzoSWHXQa+nEzPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqvWoO2hpwmseDkPTBCd31xrqBtwKsj7VsNqyXwfwHDVN27IIPJsO2HDBPGnFx2+i
	 ylF6uVZ1U8xnHIqlO/ttX/rstT5p2asTQEeGuL1Bv8OLj4vuV45/yJuzPOghsO3R8o
	 vhySQDDhTT9RhP79/+2p839CFR/GCY3/cVlytvFc=
Date: Sat, 27 Jan 2024 13:19:12 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, erosca@de.adit-jv.com,
	Maksim.Paimushkin@se.bosch.com, Matthias.Thomae@de.bosch.com,
	Sebastian.Unger@bosch.com, Dirk.Behme@de.bosch.com,
	Eugeniu.Rosca@bosch.com, wqu@suse.com, dsterba@suse.com,
	stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for
 stable 5.15
Message-ID: <2024012755-congenial-unshipped-5aac@gregkh>
References: <cover.1706183427.git.fdmanana@suse.com>
 <2024012633-retold-avid-8113@gregkh>
 <CAL3q7H5ZXmN32iYx9LjMh7arcp+tyLdn1zDHZCT+8hGhMfAA9A@mail.gmail.com>
 <CAL3q7H4xi0t1QZ1JTGxvMSPLFpK7YiN_=ui9XDe8qnqjpUhgnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4xi0t1QZ1JTGxvMSPLFpK7YiN_=ui9XDe8qnqjpUhgnw@mail.gmail.com>

On Sat, Jan 27, 2024 at 06:18:49PM +0000, Filipe Manana wrote:
> On Sat, Jan 27, 2024 at 5:58 PM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Sat, Jan 27, 2024 at 1:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jan 25, 2024 at 11:59:34AM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Here follows the backport of some directory related fixes for the stable
> > > > 5.15 tree. I tested these on top of 5.15.147.
> > >
> > > As these are not also in 6.1.y, we can't take these as you do not want
> > > to upgrade and have regressions, right?
> > >
> > > If you can provide a working set of 6.1.y changes for these, we will be
> > > glad to queue them all up, thanks.
> >
> > Ok, here the version for 6.1, tested against 6.1.75:
> >
> > https://lore.kernel.org/linux-btrfs/cover.1706377319.git.fdmanana@suse.com/
> 
> Sorry, there's a change I forgot to git add and amend to patch 1/4, so
> fixed in a v2 at:
> 
> https://lore.kernel.org/linux-btrfs/cover.1706379057.git.fdmanana@suse.com/

All now queued up, thanks!

greg k-h

