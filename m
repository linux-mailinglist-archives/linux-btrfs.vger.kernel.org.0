Return-Path: <linux-btrfs+bounces-10173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4234E9EA3BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 01:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1B166498
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 00:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808D433CE;
	Tue, 10 Dec 2024 00:43:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06B380
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791426; cv=pass; b=nOaJgxgUn6wK0VwPnFHtpIw+v6gBOj2DdFGkPiKPywFf0zHcFDWHSMhQZmETAZfGtDHTMTG1MrK9l8XpZm+6RWWDZYYgA46G6GbErHaoP25jUnPebvYZyiKYa2btcOXaZb2h0GaSlPlqE03Jj7Sy/vYqS0Ue/Jy14wX5yCSjv0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791426; c=relaxed/simple;
	bh=BUoXrpSRUwymrV89z8qpp2R+VAGbtlt7JpQ9zr4p5S4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfoTa4pPM5yVgJJlGp3YCKsJAp+xEUHyMHW8kbXGOQr6DLh7qXjAjc3wBwWhtna0jkMBuxM/o+CapNV3R7ILFdW1jRZTMEl21tsuYVKj5/Kh7/Iax4jgC5NiBpSX6oO7mR5sWe9JNvz2aMj+oxauzC7aB5707zVN8gmIdQj6N+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0C82FA2DB1;
	Tue, 10 Dec 2024 00:23:55 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-4.trex.outbound.svc.cluster.local [100.98.215.185])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3E713A2B74;
	Tue, 10 Dec 2024 00:23:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1733790234; a=rsa-sha256;
	cv=none;
	b=to8oVtfnvuVWQHZ90A7SinBbcwi996JdngpPRQWP4/SJtyOA6e5WD0wQrGMiEphY1IK2xV
	ZPRv2QbaGQGiPEcTREJSKpKH2a5QhPcG8Hn+YK+/wcbqWB8efonWzwvpePXLF8/yloVfwn
	Z+rlQLcMw3eJzad8URm/dq8QCH79Dx53bHAAfsgSmy18iAjsw8zdD2e3YDYwKg/I7YhIut
	qjRSeIdY6hXtI395TlrmHXawoNMejeAk1PKt7USKyl7JQK8ds+s+MvcICLRxz+ufNbuTwB
	XAUQfmzLJAFa/kHeb0iWowEaf4PVUJT7ftKRZ6CieoeW9KT8OPs0tYgdF7SVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1733790234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUoXrpSRUwymrV89z8qpp2R+VAGbtlt7JpQ9zr4p5S4=;
	b=faxt4go+iLrWkZbt7wcKRE1KzO9yMbn/OMpoSpIRfBl1DKtlP4ArhlSPftNR66hvNU+Qha
	AFuS28xOChm4nVR5Qe+sCxum2ErUAfxJdUwbSA1MMuwdhAw0+f+AU74hptN3P4ZKBfQzi7
	A7TlgWYtgsl7Mk2Yx/rYQONXTMhD4/5m+dEfviYRVucKZWmxx5NZbh44ZEoJgnebTowAhB
	oNeh9FG0PE7F56qf+EJQkkY+zAI1QVwxKxReY3oYwOdpzbtdfW1ORmSxgsatrrMlTkeE3e
	faL4vt8wdcBzHXOlvmyPn0/BhP8sAs3zIkeyy1qA02hT2jKsB2kLyHUxwKd/Gw==
ARC-Authentication-Results: i=1;
	rspamd-5d9d86ff64-ht89c;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shade-Wipe: 55b5628a2111644d_1733790234890_3555557579
X-MC-Loop-Signature: 1733790234890:2966599490
X-MC-Ingress-Time: 1733790234890
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.215.185 (trex/7.0.2);
	Tue, 10 Dec 2024 00:23:54 +0000
Received: from p5090f2d3.dip0.t-ipconnect.de ([80.144.242.211]:62234 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <calestyo@scientia.org>)
	id 1tKo2a-00000000C57-33xe;
	Tue, 10 Dec 2024 00:23:52 +0000
Message-ID: <ee6c1c04eed9b0bf56abd68013320fc05e6b3953.camel@scientia.org>
Subject: Re: super slow mounts and open_ctree failed
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Date: Tue, 10 Dec 2024 01:23:51 +0100
In-Reply-To: <1067d68e-322a-4aa4-b72c-f07e21d3afdb@suse.com>
References: <9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org>
	 <1067d68e-322a-4aa4-b72c-f07e21d3afdb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey Qu.

Thanks for having a look :-)


On Tue, 2024-12-10 at 10:12 +1030, Qu Wenruo wrote:
> It's 100% the block group items lookup, it's a known problem, and
> that's=20
> exactly why we have block group tree feature to address it.

Sure about that?

What makes me wonder - and have you considered that - is, that, as I
wrote, IO of the mounting seems super slow, but at the same time, IO of
sequential read (via dd) seems pretty fast.

Also, we have many of these systems, and many of them have similar
filesystems like the ones affected here (that is: nearly full (~90%),
many files in on dir - it's the storage software which does that)...
and I've never seen these timeouts before - only now with that one
system where the (hardware) RAID got degraded, and it seems it runs 13
background initialisations in parallel(!) (no idea why, it started
automatically doing that).

That's why I it feels a bit as if random read (as probably done by
mounting) would super slow now, causing the timeous, but sequential
read might be still fast.
In which case I'd say it's at least 50% also some controller issue.


> The open_ctree failure is mostly killed by systemd, as the mount
> takes=20
> too long time so systemd believe it's dead and interrupted the mount.

I thought that too, but couldn't really find when it even times out per
default.
From systemd.mount(5) I'd have followed that the default for x-
systemd.mount-timeout=3D. is 90s, but it tries much longer.



> I believe we will move block group tree support into the next default
> mkfs option, but considering it's only introduced in v6.1 (thus your=20
> kernel should support), we may want to wait for some extra time.
>=20
> And since your fs is totally fine, and is the perfect match for block
> group tree feature, I'd recommend to go with `btrfs-tune=20
> --convert-to-block-group-tree` to enable the feature.
>=20
> Such conversion will take some time too, and it's strongly
> recommended=20
> to use the latest btrfs-progs for that conversion.

Since for the progs you recommend the most recent version (which in the
stable distro would already be some effort), and you also say that the
feature itself was only introduced in 6.1 (which we use)... should it
really be used already with such an old kernel?

I mean we have production data on those systems and quite some
scientists from the LHC will probably not be too pleased if its lost.
;-)


Thanks,
Chris.

