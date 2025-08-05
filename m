Return-Path: <linux-btrfs+bounces-15865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB590B1BAFB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 21:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8F7184514
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E3421A94F;
	Tue,  5 Aug 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WxzNr3Vr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpZcM6nt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C70367
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422505; cv=none; b=gLJzxA0cE1F/gRX0NjVo7XPBvtkkGawrvplJ214q5GOFriSfnVp4CZXK1C7FUMb4z3iYgNLjVWDtB7zh3maCURqyQMizle0tC2ktVZDKlobqpSW0Y67gT9RsPZDn7cQgzPJNhSmzaTKoQdTtuMINzcprp6lRFgBpqsczLQS7O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422505; c=relaxed/simple;
	bh=WuFs19gqdgLGW2syIwOLJHcw3RnJFGm7gnLN1Wsg67o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzI80pFNq3t5w6vah0BI0/Or8kUor7oacTw+Kszo2MRLsgcoQsvnWZLjT2fQH9fzIx5uKJ88pn6vktY1bT3/3fZldBShxjLCuGMHh+10qZovpkr9foejvay1/NLLqCCiu1cxbIKeQsz0rRwY0wGOQ2r4vticSrdiN3dwgOa6y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WxzNr3Vr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpZcM6nt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E4D4FEC0258;
	Tue,  5 Aug 2025 15:35:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 15:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754422502; x=1754508902; bh=RWPgtf+KeQ
	n9Lryu7fLxJ727F8zrUykqi59q/9T7VLk=; b=WxzNr3VrIzjP9joKvhECuNdhPg
	xhJ9G+KpmDEV72+haP2y1gvhzRNeWI37AHHDdoFaVV7GmVZnUlQJPTCBdFVyDYUd
	Bn+A2F2/31IIgRbumoDYFIFN7wf0h+/M+e8OB7Wv+eGvckRxIw/brJrL2yESPR7h
	hxwdXIiSB66Qv/dqKdRnJ11sMJm+AdTSkAxecWC1yGDncCkbZE+mb5KrONFlCo4H
	oAIGwJ/6w6L2onO9RarTxNmu47iA8E64xQQTvl2d5XPBJGsgnrMvcuc6EARzfG4U
	WXpW41TBMWB/X/Lwk6tlzWNIP2xfpy8G6/6AsBz7sqA7xIAAZV/CvxIq59tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754422502; x=1754508902; bh=RWPgtf+KeQn9Lryu7fLxJ727F8zrUykqi59
	q/9T7VLk=; b=VpZcM6ntpL+pRC3PgbTqG+vJSXCUA1jimUmMrEcFTMb6u7uaMmE
	1CzTaeFnzQhs7ntRxC1U96kEAfab17gQxSgexz45/W5iTfXBAkQbqQGQPKluoFDq
	V1+pIFCT2CWZOLT/NuQCWDwBcZ1ONJxwhk9RY6ugCWdvhEqpJM/jMYz6ePFsdB+g
	RE0hh19ExbYpRlLWWiHupjrySWrB7fr0vJCaiXziTXkn8sGK14ix4H00gecKCdSZ
	63RQ41j+yqzqnyOkPY2b5pEcWtEVaiDUZ/C7SrBgLjMCqJIb/K5uu3y+OHYQPVxS
	lvcLsavm2RCKIJUQ7ma2TNv1zjg8JT2OcSA==
X-ME-Sender: <xms:5lySaEHa_hyzLuzUJDginL_8REzp_xxXqpqTdbd8kfBzsmVirMowmQ>
    <xme:5lySaNhJzhYWclNGI6WEtQyqw7YIkLQnpzqk8e4yzbUfv01ITJTeUS-UPt8YAWi6U
    qJzahHJOKPe2y7CFFs>
X-ME-Received: <xmr:5lySaP_JJ5c06WCySaNDmlr4npmAL9Avz4fbBEbtyzrKyyzm_xfd6E7Q7qWwZs19yG2kBe9Ifh00Y5t912cZUYGjzxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeitdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5lySaEqZRl4Eny_z2VryePhUty5jQyqU-AbnQFul_VzaJs8Jt24_Rg>
    <xmx:5lySaO-rl6tgyBfYWRjo7V44T8_F7qM1wMvB11gzWNc_xbkV2ui_cg>
    <xmx:5lySaIWh9fGhZceD1GfrEJpgPnAfPoaslinWggMPEtUKO2degkZwbw>
    <xmx:5lySaEA7IaMRJP1G7TSiz8YkVq1ReGOzNhSBbk1Roo4RqgqEKpLmBQ>
    <xmx:5lySaGW3G29OJuW1DaVnHL7yOdoQDB6Ba71A3Cs7QZhLehoNI6SDz-0c>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 15:35:02 -0400 (EDT)
Date: Tue, 5 Aug 2025 12:36:00 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: fix a bug that leads to
 unnecessary error message
Message-ID: <20250805193600.GE4106638@zen.localdomain>
References: <f72a754b3e1b4e6b7ef09ed6451166ccbd9103af.1754003430.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72a754b3e1b4e6b7ef09ed6451166ccbd9103af.1754003430.git.wqu@suse.com>

On Fri, Aug 01, 2025 at 08:40:39AM +0930, Qu Wenruo wrote:
> [BUG]
> When a btrfs is mounted with "user_subvol_rm_allowed" mount option,
> unprivileged users are allowed to delete a subvolume using "btrfs
> subvolume delete" command.
> 
> But in that case, there is always a warning message:
> 
>  $ btrfs subvolume delete /mnt/btrfs/dir1/subv1/
>  WARNING: cannot read default subvolume id: Operation not permitted
>  Delete subvolume 257 (no-commit): '/mnt/btrfs/dir1/subv1'
> 
> [CAUSE]
> The warning message is caused by tree search ioctl, which is to
> determine if we're deleting the default subvolume.
> This search is just to give a more helpful error message, and even
> without it deleting the default subvolume will fail anyway.
> 
> Thus commit 0e66228959c4 ("btrfs-progs: subvol delete: hide a warning on
> an unprivileged delete") tries to hide the warning for unprivileged
> users.
> 
> But unfortunately the function geteuid() returns the effective user id,
> thus we should hide the warning for non-zero uid, not the opposite.
> 
> [FIX]
> Change the condition to output the warning only when the uid is 0.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  cmds/subvolume.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 08918c1efbb5..3523fc410835 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -498,7 +498,7 @@ again:
>  	default_subvol_id = 0;
>  	err = btrfs_util_subvolume_get_default_fd(fd, &default_subvol_id);
>  	if (err == BTRFS_UTIL_ERROR_SEARCH_FAILED) {
> -		if (geteuid() != 0)
> +		if (geteuid() == 0)
>  			warning("cannot read default subvolume id: %m");
>  	}
>  
> -- 
> 2.50.1
> 

