Return-Path: <linux-btrfs+bounces-20461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B0D1AD9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED333304A8E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D892FC01B;
	Tue, 13 Jan 2026 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Up8/O867";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SsxmLxB8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25522288530
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329160; cv=none; b=RadqgFTD7DozU2pnSfP0Y0k3RJ20RGzteWO0Ct3TskAPd4jroZ4PDTad1iZX6u2q+xhlOHMNxhyYP+Z+Y7+tSvk+Nz5EDvJLLaLgXUHpe5AbmmaWRJHZz7t9hbuduwRwzOSEEHVm6itDZyD5pJNuLDdh1gcIKRgw++ciQ36JT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329160; c=relaxed/simple;
	bh=Cz0JjOOOXRF8Oty9s9Ve+SCl4rWuFuBGcr1Db76Ooy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reElN/EsVc/B++pih6Uh+baX3/RvxpuKWwl11aHrUa6ULPmnAkana3CtaA9vZ5os2ojIMRqZYtqdLCAlC07wQmYH5OiLk7jdKuw04fb6+AOQnjz3zf0S5BNvZ+JD1U2fzNwbqDcLK947HKnJH4jXU2DjQfit8GMygrIkpj18Vf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Up8/O867; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SsxmLxB8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 698C5EC006A;
	Tue, 13 Jan 2026 13:32:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Jan 2026 13:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768329158; x=1768415558; bh=Mc+Nanil1n
	tsTZYqfSa+c/02sg7jgodeyU4Krk1iA+0=; b=Up8/O867xulnrJu+wxjYiIvu8b
	XyxIUkf2CBfvwpj8vFln5E0MWbM9tGAC9cTqbjesnJUv4o47s4bUFJ7Yk+1fjFLb
	ho/a6IiHp5OSHA/saEMswLmwBGXHlhBqdj9Pf/+X518o5At6FsElWhjAlHcWpwT5
	EA+9z6UuRLL/UVq8w48JJ869PI5XhkuRNqFmqLiJKdEZ/s8avBTSg7011sajLTew
	N98oIyVqRm5+LlQTLKcprvCfjGyRoLBh68/bmV+ZKClFcS2Cb4EsJM0FvvN1/cZ7
	LkI8E1rfzv0TLdPKoFMQzDLFJICk7C98L5B46jRq/v/q+2vgLW2pNNgLRpiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768329158; x=1768415558; bh=Mc+Nanil1ntsTZYqfSa+c/02sg7jgodeyU4
	Krk1iA+0=; b=SsxmLxB8J3UYp2cVWumLpgC+B7p+A+5MNfJHd/teYxM0R+kevWi
	0rfe9EclbvXPPQPlS1p5pQlBsAe/qiHFdolOuLkp5zVXWk0pNweIbiUV5w7Qf384
	ysJaYAmQnaLi6LEuJW0PBcitssnDlNAVvAWpD/94AXJf4gZIN6Q5q1udvZQPInJQ
	Vjz95pGHw0gyI4ytY2Dytk/oaIAiE8bLcggdrDAzppq0AJgNOU0cmrdtW/j0MwBH
	F3rprIMCOHRUzLGGaerBRo14YqP1pyvD4IILftR337YR4p8WIMwnDuduQgqSY/dK
	RB98CyQs5tWk1CamOewgqOs9HfwIdIYqGtA==
X-ME-Sender: <xms:xo9mab4gdjZi8gOGHHNf3dlsApMvO0g6l5duM6CrbNxiFLGkmu4ggQ>
    <xme:xo9maW5Ech0EqJ6J2tIdj8XrgtSrvaH4I-WKEhS55TJ7xTRHfpeJx94gcQqlS1nHT
    MHByaIqd24DuhxnBHm82nqdhEHjIjQYnH2eQCLqiM181LOwf3vMTw>
X-ME-Received: <xmr:xo9maQHt0uBBb3JGxWc1VvknKLHNlc5D7STQe48L5sUy28OCGLeTPhC4Umv78I4m-F-ZNkCfszTfUcxfAr03krgBr9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:xo9maXQYhL0XtHMFNv7J78mm3Gprq4UtKh--lmennBdJ7UYHVBCrZQ>
    <xmx:xo9maRsf7WvgWiwN1hSiA-zFIYOrWX3T_9Zor4MlRnQHjjkQktV8PQ>
    <xmx:xo9maexrZLKUyw5l3vcc2XKVzUgJikjojvVPdWj0Wur2_2al3Tu_AA>
    <xmx:xo9maT6u3C70Q8bYcAZzjatJrB3hzEIuRV2y-710dUOV3Z8NXYZ3vw>
    <xmx:xo9maZp3ICkhqlinYbUj9ON3nibXLCP5p-wqsHAhNMHuaqccdTVXK9eh>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 13:32:37 -0500 (EST)
Date: Tue, 13 Jan 2026 10:32:38 -0800
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: consolidate reclaim readiness checks in
 btrfs_should_reclaim()
Message-ID: <20260113183238.GE972704@zen.localdomain>
References: <20260113060935.21814-2-sunk67188@gmail.com>
 <20260113060935.21814-4-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113060935.21814-4-sunk67188@gmail.com>

On Tue, Jan 13, 2026 at 12:07:05PM +0800, Sun YangKai wrote:
> Move the filesystem state validation from btrfs_reclaim_bgs_work() into
> btrfs_should_reclaim() to centralize the reclaim eligibility logic.
> Since it is the only caller of btrfs_should_reclaim(), there's no
> functional change.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/block-group.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index f0945a799aed..9ca4db7eebfb 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1804,6 +1804,12 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
>  
>  static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
>  {
> +	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> +		return false;
> +
> +	if (btrfs_fs_closing(fs_info))
> +		return false;
> +
>  	if (btrfs_is_zoned(fs_info))
>  		return btrfs_zoned_should_reclaim(fs_info);
>  	return true;
> @@ -1838,12 +1844,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	struct btrfs_space_info *space_info;
>  	LIST_HEAD(retry_list);
>  
> -	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> -		return;
> -
> -	if (btrfs_fs_closing(fs_info))
> -		return;
> -
>  	if (!btrfs_should_reclaim(fs_info))
>  		return;
>  
> -- 
> 2.52.0
> 

