Return-Path: <linux-btrfs+bounces-20076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE49CEE30E
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 11:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F850300C5C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDA42DCBF8;
	Fri,  2 Jan 2026 10:48:42 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC901DFF7
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767350922; cv=none; b=XEumdXpNEEmfo59BytKkQUg2zs/yyHPTNWAYOL0izUgVEpg5yCiXLwDyWB8gPY1dAp0xGZzotf85l0jhqZZXc1SBUlyeYTwHJMY/oGLIWOhHdiSNGiBa68Fdqcx6fJRu60KE/6T8jzmPFMXT239s1BpnrecNkG1oh/NbBiMPOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767350922; c=relaxed/simple;
	bh=Cig/wRNFwFl0b+i8Eov7xqErQzwdLfUQ4qo61ejJCjY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3PmlXzuu3cUzjw9IZgglnhdxHBhe1sDHoA0S3iZWYeSuRH1CfYD1p11GwY4l45SDGEmAWq0VtOt6EgM0H76u1g0QemSj1D2/RaYs0S88PN0vmCCqBHypTzzizgzbD7+VJhX6m1BGd7bANoxRXeQ/tSG/NBfkud8giLq7XlB250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Fri, 2 Jan 2026 11:39:17 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: backup best practise?
Message-ID: <1767349993@msgid.manchmal.in-ulm.de>
References: <20260101234624.GA1955478@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101234624.GA1955478@tik.uni-stuttgart.de>

Heya,

Ulli Horlacher wrote...

> What is the best practise for backup of a local btrfs file system?

send/receive was already mentioned, and despite a higher cost of setting
things up I'd never want to miss the efficiency of incremental syncs.
And of course it allows remote replication as well.

> In my case, I have 2 disks: disk one contains a /home btrfs filesystem,
> disk two contins a /backup btrfs filesystem.
> So far I use:
> rsync -a --delete /home /backup
> 
> The drawback of this methode is: In /home there are also *big* VMs which
> will be copied every time even if they have changed only a few bytes,
> because rsync works file based.

A bit offtopic here, check --inplace, rsync's support for this has
improved a lot over the past years. Still, check the manpage for various
caveats.

    Christoph

