Return-Path: <linux-btrfs+bounces-15552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69379B0AA09
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E6F4E108F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C139528850F;
	Fri, 18 Jul 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iu4x8F2w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9bMA5t9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220E1DE2C9
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862524; cv=none; b=j1W/Tq+IlmAFku2jyfXcWwWlWIjDlB0kDwtXtIKWt399mm9lEcqQWNZpGX3TZ5iV7zTjXJM0r4Ule2Xb8s1lDNKVEkRNXxu6GBbjsg1hFVz0rJ3/g9ulRVG0n8S91PnAYSYvupRgL/orDpB8i/rZXzDmO+nM8rV8QgtPUh2TRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862524; c=relaxed/simple;
	bh=MFA17hmAoJFGn5I1iOtiHwKc3xiFcQ3krMsRaUbKOTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkaUhLA39VWQ+6c4JAe4s0SFRJkFNmwTyP4fvlRunIX1pI1UAPVxouy6AuXwFalzSw7k2QRePn8UMalWS9rgPmu4AxIjkjJjuq9EBpkytJdbUX8teTI26dXR/4bt3x/pNqc/B8CfEJUcb+HCwCK1yj3JeR+6pVASJFebt2gO5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iu4x8F2w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9bMA5t9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5DFEC7A00E2;
	Fri, 18 Jul 2025 14:15:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 18 Jul 2025 14:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1752862521; x=1752948921; bh=CMl10GmsKG
	Yj7emDd7KX1mFnZa5WTC5ftBc/J8Wy4ts=; b=iu4x8F2waSGifoBhp4hojqqDgb
	nwVzKATFbvH2KKo1ueMBeoDOHp9W4kxKf1uHAUMh0LvQrS/r54t5/MPA5rFxC8CN
	o+M2OwFPQL93BcBvSV0FJvuul7vlRq9pMloUM8C38KuMC51kSbLgIvKkAPJX9eFn
	RIifxzdKqArZREJ5Q1rVijIYFwEO+3/L17KBFvoeScMaHPL1WDzj8oerQYGrTeNA
	UsmJv3+IB1B9jKyT09qWwGAZoBh5/lxtrvLCZOnDCuen8NmL8UbShPM7zf+co08t
	/9vdfdrvPoiQXFMHJBc8HpGKNmSe5KSYp+YOHtw6KBSwC5M4vYc5OZwHlUfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752862521; x=1752948921; bh=CMl10GmsKGYj7emDd7KX1mFnZa5WTC5ftBc
	/J8Wy4ts=; b=g9bMA5t9FS092gJZqwRSjLQJH75ZXXOjSh0RJz+XgJxu+vx9YnS
	KuyIinup5GIG0AeUh+ekSt9dv/18UjstOdLroAaHmV/G9NYdyYEv9vGOQKTfkR4W
	end0hVHdj+FKCfzcGO0L6oRFhDPGt/tRX+Lh0BBPU60BNBA9PATSDDu4Or9B35Bd
	z0SVf8ESGm6U+9oBUcOOOKFLXC++VEp8f3BWQOP0slV0yF46XJZ/N2383ZJuUN/j
	iwQIXKn4Y8LCasriN9eGEv0b3XMOsHxbuBTADzpmyzQUbgyTkqYRaHRI/QEybLR8
	wynuN5SHphv5xkzx332fgVEf9a6dqg82Tgg==
X-ME-Sender: <xms:OI96aBibYyxB_oCOLvZuQ5LguAFPk8crnLoqsIQ2mkr7-yQmz6t6VA>
    <xme:OI96aGOPKWJpRCU_wq6m_TOqjH8zmz8r0WnBG9yKwm0z-XKITVvfR57-X_-FKFG3p
    yLghwCw9a9FF9K3-18>
X-ME-Received: <xmr:OI96aC5Io1MsqIyWmyX-NR02VtZNfrTU7oFteIIf0q9cuQJZl_WfdBJJImzpYfMz52egJ1QH369VgKjY4Ss9EJBGzs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeelffegveegteeugeeltdeuledutddukeehhfduueehge
    efveeiheetveeijeeuteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehfughmrghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OI96aE2Njafn5LNJge6jrYyZxW0OImUCeF3f2th-h6TteCUBB0BUgQ>
    <xmx:OI96aDZDzCrLyZg2lt7nlmmDWjlFrw2L4b5DA-DfOi_eXwBJiKndzg>
    <xmx:OI96aMDUt2I4x-RYNLOA2YnSZuu0HzQ2EXhmTp-PGsZn6PMYbrs17A>
    <xmx:OI96aF8NPITSFSrMhZNQcqhiA2exxEZPQEpVxzLewVd4Cj-J5_Uflw>
    <xmx:OY96aOGWfE6Srhz_VLySICSMTWxpdWN9Tyx32b1XW3LOBVSySEx2G_Lq>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:15:20 -0400 (EDT)
Date: Fri, 18 Jul 2025 11:16:50 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: use fallocate for hole punching with send
 stream v2
Message-ID: <20250718181624.GA4060971@zen.localdomain>
References: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>

On Fri, Jul 18, 2025 at 01:28:46PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently holes are sent as writes full of zeroes, which results in
> unnecessarily using disk space at the receiving end and increasing the
> stream size.
> 
> In some cases we avoid sending writes of zeroes, like during a full
> send operation where we just skip writes for holes.
> 
> But for some cases we fill previous holes with writes of zeroes too, like
> in this scenario:
> 
> 1) We have a file with a hole in the range [2M, 3M), we snapshot the
>    subvolume and do a full send. The range [2M, 3M) stays as a hole at
>    the receiver since we skip sending write commands full of zeroes;
> 
> 2) We punch a hole for the range [3M, 4M) in our file, so that now it
>    has a 2M hole in the range [2M, 4M), and snapshot the subvolume.
>    Now if we do an incremental send, we will send write commands full
>    of zeroes for the range [2M, 4M), removing the hole for [2M, 3M) at
>    the receiver.
> 
> We could improve cases such as this last one by doing additional
> comparisons of file extent items (or their absence) between the parent
> and send snapshots, but that's a lot of code to add plus additional CPU
> and IO costs.
> 
> Since the send stream v2 already has a fallocate command and btrfs-progs
> implements a callback to execute fallocate since the send stream v2
> support was added to it, update the kernel to use fallocate for punching
> holes for V2+ streams.
> 
> Test coverage is provided by btrfs/284 which is a version of btrfs/007
> that exercises send stream v2 instead of v1, using fsstress with random
> operations and fssum to verify file contents.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/1001
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 09822e766e41..7664025a5af4 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/bsearch.h>
> +#include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/file.h>
>  #include <linux/sort.h>
> @@ -5405,6 +5406,30 @@ static int send_update_extent(struct send_ctx *sctx,
>  	return ret;
>  }
>  
> +static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset, u64 len)
> +{
> +	struct fs_path *path;
> +	int ret;
> +
> +	path = get_cur_inode_path(sctx);
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
> +
> +	ret = begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
> +	if (ret < 0)
> +		return ret;
> +
> +	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
> +	TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> +	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
> +
> +	ret = send_cmd(sctx);
> +
> +tlv_put_failure:
> +	return ret;
> +}
> +
>  static int send_hole(struct send_ctx *sctx, u64 end)
>  {
>  	struct fs_path *p = NULL;
> @@ -5412,6 +5437,14 @@ static int send_hole(struct send_ctx *sctx, u64 end)
>  	u64 offset = sctx->cur_inode_last_extent;
>  	int ret = 0;
>  
> +	/*
> +	 * Starting with send stream v2 we have fallocate and can use it to
> +	 * punch holes instead of sending writes full of zeroes.
> +	 */
> +	if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
> +		return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				      offset, end - offset);
> +
>  	/*
>  	 * A hole that starts at EOF or beyond it. Since we do not yet support
>  	 * fallocate (for extent preallocation and hole punching), sending a

I think this comment is out of date, now that we support fallocate :)

> -- 
> 2.47.2
> 

