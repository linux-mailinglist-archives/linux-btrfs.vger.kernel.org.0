Return-Path: <linux-btrfs+bounces-14087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF9ABA298
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09626502061
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89F27A473;
	Fri, 16 May 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="EGvaxC5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AC4t0U1c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7127BF7D
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419216; cv=none; b=TnpszM7OIXSKqvuT+eanN8DyAZYrIyTJ4PNWeo9eyJYz6Vi3lgRtAluS/U0tNMbA4jXCK/ixgzCWWyPmidC8kIwmqqvIHjrL3DzWdxdAROOAAG8WPK1uW0b6lz3MXXkEtu4JhhZfw9zFErtcMms4bmx2PZzMLgU0f3cRo7ZeaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419216; c=relaxed/simple;
	bh=j570ZY9q+Y1NArBxb4zTgdkoIzs+GN0Ejz7GLiBHoSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/z2ZqeK+qLE7HKgnJCd3kRC5b3UlT9lsWbujW+8hDmgKpiNBro2Y0z+r2xpuaOKEIup1XXxoyoZAu/QknwMDQdVXDFOtraoP3Z2U3zfrbgwwmyGgfMx/ooXzRaES9RK8UqjhvAAN+JrZYmaZmMuh7gq7Xjz8x3l+C1wabVlE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=EGvaxC5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AC4t0U1c; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D31DC11400D9;
	Fri, 16 May 2025 14:13:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 16 May 2025 14:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1747419213; x=1747505613; bh=RJDxL06QLj
	uF9PVGoFBFLFq8qDUdZ7If8Zs9Fy4+Mbs=; b=EGvaxC5HBwJqygp8CQxaCH1qBj
	+VTGpQVml+i2MwPe1sJ+iIftlg88xgOsCygBBsRV26mnE84lLonK3Q2yQLegMvqX
	sWT0KhCDtrkkSjMN9HrlQpLw4KR+3lhqvz4UEneUgSRpvsy92Rvy/ZvrWqiVfaCn
	ktemla81byZqo8RGbwa4JVGwcNHQKc7Hs96JXT+uttFdDUXA7bAO74YcmTCNDcxs
	rOVY+zPHVwm/bmPctc36/yoIvIAQZjb62+NUerAQLsJSPzwpOmWo2pL/4FrisZT4
	+Q82ziexwElmnfPyIxcKjptMvAMkRNeBUuEV2HP/eTnw0H9YlGqpe0h1IymQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747419213; x=1747505613; bh=RJDxL06QLjuF9PVGoFBFLFq8qDUdZ7If8Zs
	9Fy4+Mbs=; b=AC4t0U1cKWgrjuhHAI7iUUhK5vfRuSpQ8Z0WKMThulnJ55GJoa7
	8RMuL34dqoic1IkpPCsZWWBHH3ebnDIo+zsk4i0TbB6vw+K+zNJgRVYMWYl7Zu1I
	lJFUwFUjLurVyu6tuHqv1ihyzV+89d7fl7sZbYBagfhUW80ihDnFBHI9V5AS0HHV
	foZtWXQ/rw0Q6pRcvLYhTzPb1dzcpwJa34Wi6jrLzI47pCroOWz2PLbUbz9RtGwm
	MXsL32r4qUDdjMyAIubvGKZWUhoeAM2Lbg/WZIuwdYRuMe4H0BSUwga49pcWw0fJ
	cHXJEJfgqEUhVqYEmGO/zHAfKU7MAyXgJUg==
X-ME-Sender: <xms:TYAnaDlkZT-TqCN7hhGwxe1jr8f6i3CuhTgRppzGRgRHMnknPsW7uw>
    <xme:TYAnaG3-uDBLECUhwWe6mW3msefRzXHAhl-vibMiguX_iIphOMkvmC5sZxL1Eq4Fu
    _44NSPsNegCxsBOimQ>
X-ME-Received: <xmr:TYAnaJqaNv2c4RxkSARQbWBgCIQcc6wU1jxV6yUbdRWrRFUeMwApEoIu5to9miHGl2yRqbyj-9Vjw8JHSqCfhQ8RNTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TYAnaLmbATZwPZdzIrili89-llXbbIzkW9b8CY2jPEWR2BtkhJY9SA>
    <xmx:TYAnaB1IZ6nIrqrf6HLq712Am8kFyVnXUAXgqVyO5Klk3-hJDHrXHA>
    <xmx:TYAnaKteZg1RHA-XYYihV9twgv2zfMHqjeFigZ2pHAIm3Axb70FttQ>
    <xmx:TYAnaFWC5a8GCzeao7WOsmGA49xq5tKHG2SeKV1EbvX9sa7MiZADQw>
    <xmx:TYAnaAC6k-j0h-6s9wjVJqe3x2IvaVyA17DiwaWccRVDoilTGoiW9A-M>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 14:13:33 -0400 (EDT)
Date: Fri, 16 May 2025 11:14:00 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction abort at walk_up_proc()
Message-ID: <20250516181400.GB3585683@zen.localdomain>
References: <abc8c07f10bb3565627533a7140b2add7f6b5e00.1747413241.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc8c07f10bb3565627533a7140b2add7f6b5e00.1747413241.git.fdmanana@suse.com>

On Fri, May 16, 2025 at 05:35:53PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when any of
> the rwo btrfs_dec_ref() calls fail, move the btrfs_transaction_abort() to
> happen immediately after each one of the calls, so that when analysing a
> stack trace with a transaction abort we know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent-tree.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 678989a5931d..f1925ea2261f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5874,13 +5874,18 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
>  
>  	if (wc->refs[level] == 1) {
>  		if (level == 0) {
> -			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF)
> +			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
>  				ret = btrfs_dec_ref(trans, root, eb, 1);
> -			else
> +				if (ret) {
> +					btrfs_abort_transaction(trans, ret);
> +					return ret;
> +				}
> +			} else {
>  				ret = btrfs_dec_ref(trans, root, eb, 0);
> -			if (ret) {
> -				btrfs_abort_transaction(trans, ret);
> -				return ret;
> +				if (ret) {
> +					btrfs_abort_transaction(trans, ret);
> +					return ret;
> +				}
>  			}
>  			if (is_fstree(btrfs_root_id(root))) {
>  				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
> -- 
> 2.47.2
> 

