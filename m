Return-Path: <linux-btrfs+bounces-20458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31ED1AD66
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E59303B7EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7E34DCD7;
	Tue, 13 Jan 2026 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ndlRxnq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwgrK3G2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649CA342CB1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328854; cv=none; b=m3QaGuLHsy/u35n76ecP8xlVmGFW2fvzSkTRNk+ZxZppazzBRJQzNW8wx0OAECi7I+SbSUtiuQyq1+pnJO9A9bl4EIboORP4734vRgOuXXtToytSai98glUrBG7HwXqAmkiaQQ1eP5SCSysll4MgmFXeYMoDG3AqyDVsQq8AY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328854; c=relaxed/simple;
	bh=dY8esNADBm1GvWPyTGaDiY8ps3jW0xCQ2ArGElzEq8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi5145LaEIY2PTi8FJCqIo3z3UAsKKcmNgAyI+geHp2X/0yQZ1S4orCtQUi/pgqBqg3UgjSNILv+5Q9+qRFEoyjKWUOER+QMu24qwO9kb9UYzS65s6xUKCVgBqs7v05ArOVBdZuwoLvkdxZBgoLgOr/qH8Ipbj17TtxeggoHl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ndlRxnq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwgrK3G2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D3AA140005C;
	Tue, 13 Jan 2026 13:27:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 13 Jan 2026 13:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768328852; x=1768415252; bh=XizoBGUjF1
	aSii6eJ+Rxp1JFpUVN5BxWUL91oRY/A+0=; b=ndlRxnq2VxqNcYJzxcOhtlKTlP
	UlVKEeGqtxt3+DAlphTzomO2Dzx1MVJYIjnRSWkgzK6FP4g12Jig+0B80AXtLO1p
	hT0xh/LYD6QqpD/3XV/8o7jWrftfykFqTBAEWYFg75ZPeVwOTGyMGlAH2wizKj84
	trw0a3k59KMXyX4302CyJSfox38WqkAjC7VQ7V9LHN5RD6KrKr3DjEBEkDdY4aLs
	bAU6BVktyfHlAfUHdmg+GVNkURP01deCgWMCNd1dPTQ4GseTooHwoR6C25ugryGp
	zo+gOgb9DSuBY1xYHidzuP7Vw9zdN7pMv/c0/37ntjlGWlJHmQR+1tTTO7hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768328852; x=1768415252; bh=XizoBGUjF1aSii6eJ+Rxp1JFpUVN5BxWUL9
	1oRY/A+0=; b=fwgrK3G2omGV1Obri05GzG7GKyOmSZZ5YwxD6+glAZtxDAFuAj8
	G5ezG8lvgCE5w3q6TGgr9z8f0bUfXdhBQJGOTURxPBthZv6gf1ZAruiG/rVLkDdf
	sCu+o+aFxLF5JmhL5QGyIz6b04qOiu3MjdSQi3w296QXPlyXx4VcleR8RqrXGxaP
	Ihc44Y45uTjLecIQ6DhDEW6tjus7j5UxIjGojuVqXv1ki8w24q7BWliXV9i1arsR
	7+8SRQJ37MzsPC2djKstBPnIp/38mKfCOr7mwuIQaNrSupcePZpVyb8Bu/XVnsHn
	4N6vp1BKzi5smBnoQ1Zh7zchrikN/SJLTGA==
X-ME-Sender: <xms:lI5maRnPK6T-xsYSjUwAFhhvcGfNYZ2hjByngDpXA4rqaEZVA96Oaw>
    <xme:lI5maS1DV7Tl2pyyNixNh_tFnVF3VHp8sl57FjgzD2BoDVCos0egy9rdwFarojQOq
    NZariuxKkiqEeVS27cJiEhJznTFkYUAh9tydJz8uJbnNb-0-UHPxw>
X-ME-Received: <xmr:lI5maVT-RleksfVTjDGoVsOMNt-TZHlxRG-50owhsQ1Kx2ALzv3rP-WJZz3h0sMxWWhD_7WlpkaIPUiWaKFCQojFmYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:lI5macsKBGdEkBsLwmY8QXUUOR3YHtDoFO62XQypJEHoGcx4_XuhsA>
    <xmx:lI5maSZ4VWW5_vvKkGTCCk89rLQmV23kUIXWrvyGreFU8YxL118Weg>
    <xmx:lI5maZs39kMUQXCf-O8I1iinMM3Tq_Su92CnNqRa4re5rXTVm44QnQ>
    <xmx:lI5macGhQ645VXGIUAEbg4J1Sbbv7pKamEsF59_YxttG2b8YUNtQpg>
    <xmx:lI5maV4DYkQkmTniEvbGxFAzzMPRoJSsGr4py7UYDx7jkHXy-1drsg7r>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 13:27:32 -0500 (EST)
Date: Tue, 13 Jan 2026 10:27:33 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: get rid of a BUG() in run_one_delayed_ref()
 and cleanups
Message-ID: <20260113182733.GB972704@zen.localdomain>
References: <cover.1768322747.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768322747.git.fdmanana@suse.com>

On Tue, Jan 13, 2026 at 04:50:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Remove a BUG() call in run_one_delayed_ref() and a couple trivial cleanups
> in that function.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (3):
>   btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
>   btrfs: remove unnecessary else branch in run_one_delayed_ref()
>   btrfs: tag as unlikely error handling in run_one_delayed_ref()
> 
>  fs/btrfs/extent-tree.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> -- 
> 2.47.2
> 

