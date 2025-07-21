Return-Path: <linux-btrfs+bounces-15595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3176B0C7E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163F316E40F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22B2DECB2;
	Mon, 21 Jul 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="q59I8ne7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxdzTEyN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F01AB6F1
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112721; cv=none; b=Lz5VaZsEcDnknAuwRz+N8D+xGO5Hr5naJTnPK7RSesOgZ52MU9zcUpRNzsF/PwL9ohzpetVKdtKwxr2ilhx7pxsNTKshR1sBOZ2zbVPRShdzQHgu3yG/ptEzLiit8KVUnPi/22HqK020tjHAgJieDnGbSI6x/lk8I/8NCNrtV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112721; c=relaxed/simple;
	bh=n5bwPOqbRbDIMLnfVvqslLtJHg4fYdmsGO0Eqrkm+9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeqpAu9qJckS+CqpfVKsEDFG1fteZd7i61cK8WOSirwoK3AE7cgT9w38SK9QyUYvSRZ+jg7RVLk7UGXByHApOUnVOHP8lxQ51w9C7bqT5M+cTIsNzJmRSIZWB0Sd2IkSlGLkID/Lz9YQR2C43/RuWgfdsqgPAMsN4hJgLg9Sp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=q59I8ne7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxdzTEyN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5805D7A0127;
	Mon, 21 Jul 2025 11:45:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 21 Jul 2025 11:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753112718; x=1753199118; bh=PTWtFWFTPZ
	pUgfxOX4U1BUDAORBYFW36a7F0oSodbFA=; b=q59I8ne7Urn5UP7gt9Mt4Dzklx
	JPhe1TXlG1cy8JyzLOPiTCZl3J6EYcpB4AFoJNGGTGaCd1Au/V6UB2J0FZ8LK3I6
	aJ/OBWIOhwyVJ0Zml3C2uEhTzVskz3pSxI0UkE0CUFJ/v6gBP+KHlOVbp0d2kuvQ
	aTtWsYfDBN5TunVxIZz8BV1km5E4xvF/tfdOq49aEx2uf6KV7YUTEB/Os7XPIj/S
	j56o+F6uNvkkRyRLwL2hEK5C5W8t7aTTDOa6MzHcuWfQIwJWzesuzz9VJ8LZSVm/
	WtbVvI17D2o9JnK7H1vTbFDUwed/80l0BiPixYAT0HSBDtjWopv84tZamc0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753112718; x=1753199118; bh=PTWtFWFTPZpUgfxOX4U1BUDAORBYFW36a7F
	0oSodbFA=; b=QxdzTEyNNIpn0epUcopyzXNRu6f7ovaAV7qwYfo74NjzSWJ4/nQ
	HaEkGe1iAIcvU55mvEJmHF/vu+tps6mn1Ag4KjGvr7aaSMEVWnnbEjNFFiHPzxX3
	2F0oJDvt0t1w9m8JO9Vueza0Oa9eQW3k4l/kJR714dSLQCffDNsSyzfGXAQe+ewK
	OiPjfN7jLqBOsBGBWKGclNxx09CLu3ln6NSQYtWae/4nDD69rDvV+sK8EfmV6s/5
	hJ7HcS6vhMe95t2mI7YHyQqmcXbjamEy0k4paYTvtkPefKCDCekt1bNHOFlB0h1Y
	tHuiLQqU7aEPpJUSkVn0ObyPQcFxbwpnBCQ==
X-ME-Sender: <xms:jmB-aGO6nUcvNwRM3bBrHhkjKpoqTaYcOSi9-mbIGkK7wASdZWxsqA>
    <xme:jmB-aFJEKhVFm1ZM05wWqRTqYkxP5ucPKpS-Eq5ghdifF8e3wYVfUoEtQ-IUgu923
    0XRpf0SI8KBTLVucrc>
X-ME-Received: <xmr:jmB-aPEL0zvVVZkNSwnv31ePfEFo5dc9qxaiXSuufx2S1i7O2zvbIsoX7y0LhiecKe06mWmZQNZW2-31XG7kbDIO2jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehtdfhvefghfdtvefghfelhffgueeugedtveduieehie
    ehteelgeehvdefgeefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsuhhrnhgvugguihesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jmB-aFQZif_uDF3diiPVMWCmlZd3HOOQDE_RQ8XSmr2P5Bx04KkGsg>
    <xmx:jmB-aDEsKclC2EKOD81kk8RNvEYeHrLy_4YtGm6YNK7ucjZ9A9E1IA>
    <xmx:jmB-aJ-J_Lp1fT83Rh1N35-MSwBqNu5fj3G1F9byJgi9WnE0MMF3YA>
    <xmx:jmB-aFJqkfOhuhEO9mM0TymCKgTb18OPeuD9UqHnt-VwaFZDZxfZJw>
    <xmx:jmB-aIyjYiLpkTdB9YZFaXwSQj2hkoq9G8gg9GTS4_mWhuYwcmhOL6CW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 11:45:17 -0400 (EDT)
Date: Mon, 21 Jul 2025 08:46:43 -0700
From: Boris Burkov <boris@bur.io>
To: burneddi <burneddi@protonmail.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: log tree corrupted (and successfully fixed) -- anything I can do
 to diagnose why?
Message-ID: <20250721154643.GA1839816@zen.localdomain>
References: <lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lh4W-Lwc0Mbk-QvBhhQyZxf6VbM3E8VtIvU3fPIQgweP_Q1n7wtlUZQc33sYlCKYd-o6rryJQfhHaNAOWWRKxpAXhM8NZPojzsJPyHMf2qY=@protonmail.com>

On Sun, Jul 20, 2025 at 09:19:42PM +0000, burneddi wrote:
> Hi,
> My system had a hard crash today (some AMD graphics instability), which resulted in the log tree on my boot drive becoming corrupt, giving me the error "open_ctree failed: -2".
> 
> I managed to fix this successfully with "btrfs-rescue zero-log", but now I'm wondering if I should try to diagnose and report this somehow. I have been running this drive with btrfs for many years and have had a fair number of hard crashes during that time (AMD graphics instability...), but this is the first time the log tree has been corrupted, so I suspect it could be a kernel bug rather than an issue with my drive's firmware. I run Fedora, so my kernel is quite new; 6.15.6 right now.
> 
> Is there anything I should or even can do after zeroing the log that could help btrfs developers narrow the cause down?

Thank you for your report, and sorry for the instability. Unfortunately,
after zeroing the log, there isn't much we can do, besides just collect
basic information about your setup to try to correlate with other
reporters:

stuff like
- hw architecture
- exact kver
- mount options

While we're on the topic,
https://lore.kernel.org/linux-btrfs/20250718185845.GA4107167@zen.localdomain/T/#t

is another thread with more reports where I mentioned the information
I'd be looking for to help debug. So if you do crash and hit it again
going forward, and are able to run btrfs check or btrfs inspect-internal
dump-tree *before* recovering with zero-log, that would be very helpful.

Thanks,
Boris

> 
> Best regards,
> Peter Wedder

