Return-Path: <linux-btrfs+bounces-6929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B029438B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 00:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FBE1F22265
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983D16C879;
	Wed, 31 Jul 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qpej9cWW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="be6HErjw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7BC433B1
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464351; cv=none; b=MO84O6j+uCIJOcbddBf9gUFezCkuoOyLdWLY2nfd+2J+JaYqgJS9RRopxWwohnVcgmavkaUd4vMWSc/d201kSC8YS1tHKdX2Yqy6a//8goYKwNRlWhmF77qSfdBCjFSdHSaWqdSLrlTkPo3OS185aypIXcyv2x7hIpXH2HHJWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464351; c=relaxed/simple;
	bh=6SwUnwrjjuijC5YyHBgMg8pY/5Ixinxj+IriHvd6y7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQoqUZ5M76qyCu/QNfuo6Fo6jnyBdxKVssvTWgjHqxw1oERuowbaB82EWqW/5M1kLoynMRyq1eKynYZKF0WlgIrnHKQyMF5HIca11wMfZrpUOyJOqX/TKOzemPR6ZbFz0/rcvcv9/scbeizyCnF+A3WQQUpEBCSHaj/8oMWKED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qpej9cWW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=be6HErjw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id B62C31382C93;
	Wed, 31 Jul 2024 18:19:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 Jul 2024 18:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1722464347; x=1722550747; bh=cGgH2n289t
	LqPDd6QQ6j16ogias+zHHtmGKHynsH1tk=; b=qpej9cWWD4JzBK4zNrksmB5GGC
	/5IXvlLd+neAfT5zYzqWlvumty69Of7iUaXP8O+CkHoC1bzYDQVtjPE6W3DpO/8Q
	ZSur3XUZrXZOdcBlQtldTmgA7aajsBjFN8z+jRGw7CsSSXBf6W50QdTqZOwmkkNV
	gXljDdg6qGHdGnOATrbaIF4J9J0BMwlBgVcgsvm5/C7lltmXsrIn1UGL20zKd88D
	BvttKix9PIe4axzyPnDZZZZQ0lBK48lWXKV9ldhO1aGU8Y2Jy7kKZj2v3p4Nc+v3
	FFvQGub+12iuQCEPZ3t5toOTyXa1ax3cbj4sUh5lPJCJ/aFACUfQmPfnef8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722464347; x=1722550747; bh=cGgH2n289tLqPDd6QQ6j16ogias+
	zHHtmGKHynsH1tk=; b=be6HErjwYEiwdl6N0Ker8u3Pg6xlxNi8YiDq7AHmCtE4
	9Yn1d/ie1sIlbhnZ9ANOGolyyMzY1O3Zauf5ePvT1JxWaVpbxlXyf9wt5oabaVXN
	gybovL13czpgYoik9BGPMbNo6B6rWlqtBCNMjeex1xmxPxtlPtyRSD30szt00JJQ
	h65jwmNab/32TltPZN3l09mAAa2S/lhdhdfMeVddPH6MCyrWv1Uefa9DZVKeu5+C
	VSn+IHd5nj3luBo5Wm9KrS8TAbJx7SYd9WmzkrnJVQOyNh7qyeyEUaGpkWUGrRoD
	LlEQKubth5NaghnV+qBPT9L80tqX7eS1bijStXPYJw==
X-ME-Sender: <xms:W7iqZs3cnAEbv_zyinHlG5hW4zMJAUOfko81Y0bK2aIZj1HNy2TZzQ>
    <xme:W7iqZnFNHDmT-aQArPk2d2A1PNVQIvB81iidriu3aUn8L_iJBGVWzdhjyPcMwIgxq
    U8dlB7Pra0YctE_49c>
X-ME-Received: <xmr:W7iqZk7XLBgL8VrAP9AF4GCQuUI5AZ5UVhC6bLhkuyVbc34MuY2rLzmdjIl7RzziR8ucHhQ2kVYtMxcxZRzFXCs0S44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeejgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:W7iqZl0sU_k7ox-N1iNlpc9K8QtYrBKOrD44zDY5GF_ruwHqj7UukQ>
    <xmx:W7iqZvE1RaqZsjhy1uq_hvdcNRBrFSNeF-x0j8Y0LiKymqwyBD8mjw>
    <xmx:W7iqZu8ZAecqHmHH4E9jv5nkPUPCsZEaeNf0WdHZ6_8V2WVCd6A_5w>
    <xmx:W7iqZklWtvXQ2pzfhyOYzcMDzlgDz3ho2iiFaE7I6eunOr9WJ6GsNg>
    <xmx:W7iqZkSwDCfGfWP7ZQraeN3cKdgNxmBi2SCJDeBOgMqUSN6OZSxQu_qT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 18:19:07 -0400 (EDT)
Date: Wed, 31 Jul 2024 15:17:39 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: rootdir: reject hard links
Message-ID: <20240731221739.GA3808023@zen.localdomain>
References: <cover.1722418505.git.wqu@suse.com>
 <7984ff20beeb81268f786234d30d3c24d90a9a5b.1722418505.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7984ff20beeb81268f786234d30d3c24d90a9a5b.1722418505.git.wqu@suse.com>

On Wed, Jul 31, 2024 at 07:08:48PM +0930, Qu Wenruo wrote:
> Hard link detection needs extra memory to save all the inodes hits with
> extra nlinks.
> 
> There is no such support from the very beginning, and our code will just
> create two different inodes, ignoring the extra links completely.

I don't understand exactly what this means.

How does the code you are replacing handle hardlinks? As far as I can
tell (far from an expert...) it looks like it does handle them, so
explicitly rejecting them now is a regression?

> 
> Considering the most common use case (populating a rootfs), there is not
> much distro doing hard links intentionally, it should be pretty safe.
> 
> Just error out if we hit such hard links.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  mkfs/rootdir.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index d8bd2ce29d5a..babb9d102d6a 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -418,6 +418,18 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
>  	u64 ino;
>  	int ret;
>  
> +	/*
> +	 * Hard link need extra detection code, not support for now.
> +	 *
> +	 * st_nlink on directories is fs specific, so only check it on
> +	 * non-directory inodes.
> +	 */
> +	if (unlikely(!S_ISDIR(st->st_mode) && st->st_nlink > 1)) {
> +		error("'%s' has extra hard links, not supported for now",
> +			full_path);

I would change the message to something like:
"inodes with hard links are not supported"

Thanks,
Boris

> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* The rootdir itself. */
>  	if (unlikely(ftwbuf->level == 0)) {
>  		u64 root_ino = btrfs_root_dirid(&root->root_item);
> -- 
> 2.45.2
> 

