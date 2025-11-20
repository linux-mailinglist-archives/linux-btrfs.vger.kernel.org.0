Return-Path: <linux-btrfs+bounces-19227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E4AC75FEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 20:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81E5635BE89
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C92368296;
	Thu, 20 Nov 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="asVfwJ4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GkUb0fLq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D03644D3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665308; cv=none; b=DnLBlBGy3NbhDvJ5qL6wILtjqCXUMBTPQrrisnK0SxZjMZr7exoT8bPaQuipNfW1Mh0ksl4ryabXdW8XmjEcnxv9vFk5RUUgyDTsZKJLQbBV6z5ULp8jLcEgEJg0omxnRfny3Y9lHdXVpv9nsQvHoo8x7Etj+l2F4rft4+V/ToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665308; c=relaxed/simple;
	bh=hEMGs9a5BLNTinbqQP2VxY3nituShkZldl6aA1pHRhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAgqWBUOtq4YU+Mcteg3qashSZhOmntM4wyxHuVA8DAjuYG4EkIevsKrie3NMKXkEuK9v6kXhcQBDYSn8/G94mFUPoZu/PgmCJ71hzuhN+oHRj2oCAIp2d4i1edvJyGSfOly+Sa4aLsvwXD4Q7DH+Majx1Wiu86mHKVhAT/C+sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=asVfwJ4g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GkUb0fLq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 096BB1D0018E;
	Thu, 20 Nov 2025 14:01:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 20 Nov 2025 14:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763665302; x=1763751702; bh=ZB5vkGbXNu
	hKWhrh9T6aJA2pojiihpYem6U8igMbtkY=; b=asVfwJ4g0Z5TE+GeBWHWdkh6tM
	3+9gGHAn7ZTwT1BNsJocapkSD+G/rKaw/QmCfexW1HoBGCcQMck3am5S34Ax/b0w
	SZ83MpjS4dSp2bXi4jY9hTfXE+clgg+R4G1deiHhLna74SFJ4l0EW9y+Azm5sEMo
	oh0AOg3CbUo/STUieznWRgG+ywgWjdq8sif05Te8Xl9DPWX3fdtIdItMXUT3vaYh
	GnSo/Ec5RLFLf8MkO0wj0dQ9E2puIf8wRt4pJieO9h1ddqXqF2FPSZWra2xRuvTZ
	BEyh7QsdyRjR3YiA5vLzW3L5hAJ8Mcxo+FGNTO8+uZxwzmExas2+PsLLOpSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763665302; x=1763751702; bh=ZB5vkGbXNuhKWhrh9T6aJA2pojiihpYem6U
	8igMbtkY=; b=GkUb0fLqvVABOhqon9XAYMWltJYo5PskJzG8+q8KU7z/KwWYvGN
	5+nctYkwc0nJMNNAvi1aV2ZfwJIKHohIOS1hR5X+oQV+WlU/rQKrDmzL1QV86jte
	VpydMltYnd5yZQiyuAfbzA/pdMeT7KuuUUyVFqvg1SjYhbvrHz4sJRMxO4uSm6dO
	M7hcrSBXptUql95zliCOqqdBkKePvTosix8o6QArZNs7QZ9RTCDQQeO5hnr/ZjY5
	8nFPV9Z12dCl6IoPYi3R+yc/tZN9WDo7Ly33ncoOKcX2VZQH3JCKzGYWcDEIIMLZ
	EZyoVzwTNygh6B2AtABCQjUWSxeJcTJXYIQ==
X-ME-Sender: <xms:lmUfaRmqE5uGP9BbCT_wcKEzLqx2SW9iWXFKjBYcVQTIyCvyM7N0Yg>
    <xme:lmUfaS2C0QdtjoAisvXWNJ3ekqPXS_9tNMKHTFdkpbE5iA0WFavtPXEVl6dkTnaWz
    vbkP3LXFaTHdGCfnMYOf41ijofxYndJbhy45uAIJaXxZWBityduL-I>
X-ME-Received: <xmr:lmUfaVTR7cpBzieWrZdBH3m7q20RO_weID54DAhB0fUl6F9R4bTfaXowj2P8Lvik63AItoSRVv2FVkNT05cnOgb_aZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:lmUfacvhnQqS_LepjmI31zNMmaSz-jCIEgCVxCdmrVMKsJZEBgCPHg>
    <xmx:lmUfaSYDAHmaGviBQ-KoWIOLbymf3e1iMb2puxypli-4ytz5c1kvZw>
    <xmx:lmUfaZtmdQDK6a50bpM0sYNLs91_dJBvx0qu6GpNsthf8sMJXikOGw>
    <xmx:lmUfacGkpIiQF248gDHhJZ3WJ8cuMp1nqchGtOPUmWOptZSC8kBMzA>
    <xmx:lmUfaaXeJTeR20uMIv9HK7u2pQPHI-3_8H0QxM_n_pTTT636qXkdyVxh>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 14:01:42 -0500 (EST)
Date: Thu, 20 Nov 2025 11:00:56 -0800
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: use true/false and simplify boolean
 parameters in btrfs_{inc,dec}_ref
Message-ID: <20251120190056.GB2899191@zen.localdomain>
References: <20251120141948.5323-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120141948.5323-1-sunk67188@gmail.com>

On Thu, Nov 20, 2025 at 10:19:12PM +0800, Sun YangKai wrote:
> This tiny series removes the last 0/1 integer literals passed to
> btrfs_inc_ref() / btrfs_dec_ref() and replaces the open-coded
> if/else blocks with concise boolean expressions.
> 
> Patch 1 switches the callsites to the self-documenting true/false
> constants, eliminating the implicit bool <-> int mixing.
> 
> Patch 2 folds the remaining if/else ladders into a single line
> using the condition directly, which shrinks the code and makes the
> intent obvious.

Nice improvement on patch 2. It's much better already, but I am also
sort of curious how you feel about giving the bool a name to make it
more self-documenting.

e.g.,
bool full_backref = btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID;
btrfs_inc_ref(trans, root, cow, full_backref);

Just a thought, definitely not a blocker. Either way you decide, please
feel free to add

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> No functional change.
> 
> Sun YangKai (2):
>   btrfs: use true/false for boolean parameters in btrfs_{inc,dec}_ref
>   btrfs: simplify boolean argument for btrfs_{inc,dec}_ref
> 
>  fs/btrfs/ctree.c       | 33 +++++++++++----------------------
>  fs/btrfs/extent-tree.c | 21 +++++++--------------
>  2 files changed, 18 insertions(+), 36 deletions(-)
> 
> -- 
> 2.51.2
> 

