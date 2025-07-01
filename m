Return-Path: <linux-btrfs+bounces-15137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A1AEED69
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 07:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F647189F1CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856EF1EFF8D;
	Tue,  1 Jul 2025 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="liFZqopn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPKmt5Oj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401272627
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 05:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751346212; cv=none; b=kTUfnGfC/V7ai62FqwMwrKcU0nxFsy/GIGEDW5DWmO3K5BuO6D9GK5tqb55JPdbxpToJT2I1NkHsj2/JojBit0B41EMxcZ0mHkE28jXqOCQkmn+Pl60VMyP4ic2Jv4VBxh1wRa5uelRUNruLYm1C7SSKzuBSR0YwyOuW8tG75QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751346212; c=relaxed/simple;
	bh=6Wkd/luf20DJOfQV6F2ALDh4Sxlp35RxVeeLgEPTcus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWmohYmT9TA7xAEpeb4FZecqlIYnM5wEH/ftsvC7tfjvYIyYZXAQ+YNya+zPFUIBjlhTS7hqdTW6RIuIZd8cMf/vWdDFmMppFOW6wwfhjsxM14x6kQ19DURySSJQn2qkkF5M64ih1H+/Mf80qe5bePczwJmhvTgK7TvFjoMnsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=liFZqopn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QPKmt5Oj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CE87EC01BE;
	Tue,  1 Jul 2025 01:03:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 01 Jul 2025 01:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1751346209; x=1751432609; bh=Fo+lKy33es
	aODvVN3G1bceOPJezGSe38e05fKuUFp8g=; b=liFZqopnN0KX4NOV4n8547zBpZ
	FaU9P34/TbRXA0X73hMOU4cTO8/P4P3MakjOiJo2l3m76+v31qT/gKJmFHG+qunB
	Tzleo8abqeHFnxsZY4fHP52JeM5YmdVgI1S8m+EWYjBybPhKCnJF/bFLLVoH44bY
	SN68CzjNAeEBh3cMF6FLHst7XcAEH81N0GKMfr7f7heZyHYtZlUDQscxtGKN+uA1
	KE6vH2LQgraCUKDAXl63Ph7O4uKY4Jst/8D6By37T+TMTDKnco2PZiz1ojeaY7j6
	gIVtqZbYGlqKnGgXfIHiKclYxVoHoUVdf9No99wmYk1165G4enywdzTAoQcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751346209; x=1751432609; bh=Fo+lKy33esaODvVN3G1bceOPJezGSe38e05
	fKuUFp8g=; b=QPKmt5OjpWEwEy+/YMVPCDo4mBlEsO8npVQoOl35uh9SBWLKpo3
	w+ISL5tM+cE+jp5NtLgpshJZt8ryfhvaKf7RIjYt9NGpxeih4bbpgx2GTIcUGLOd
	Jzi7PHTl929Fqk3+F/KmBuv6vwCg4OWfGwPyoZL6oZc09qQXAjA8HTkhed1h5zv0
	Xglc3tUsr5sFVjhbqQosm4i0qn57IuvbT0GTthr7ldn6SSg5ZYhcc1Ji/VpZUZiH
	8Ktb9FDVWYIfF3qHIh4tq4H/TtZKtv7UffOLihPz2Gi+qC/ooImwX0UiyOzYVMdm
	RhgOWwGk/H1qsGcA1cVnRhZkfKMY0wpcI/w==
X-ME-Sender: <xms:IWxjaNjzakdXEWmcUTnYnO80jUot4DNqUuNsvXimwqstS0Axbj4sPg>
    <xme:IWxjaCD_s-Iq1q65kr27j484VNKmSOog9vmV4lVsRoCa9_0hPirAycF407qY6EUKw
    Jh5WmmrFrm5Du9yH90>
X-ME-Received: <xmr:IWxjaNG4uiYdsMlcVzVd_gBY2fOApDPgHXWNBUV3CfSVXhZXAUdEx6iXeS1ycZt-pWjklbgmkGy8TBriiD8EaLFBzA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:IWxjaCTjGyO5SY-ryiub2bhH1EZfX6XCX4HcqOsDFcP4VqFvobGwnA>
    <xmx:IWxjaKzSZdrBamMJeZzMUv4k-jJks--JQg6MTiZs83qrFPOuXJdWxA>
    <xmx:IWxjaI7XF1jly0AZgSIXhtPLP7MLYAZaUG_DMlJDXzLwlQvww_hvnw>
    <xmx:IWxjaPzsVTvqXgHf3jkxL0noFjySHmUijtl9UlFAgm1Cnz0Y2UvqGQ>
    <xmx:IWxjaCeEKXdoLpCQYGHDW01XCwHDGQb9DLfVsDhTmtAeDKvxnoBrqHXU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 01:03:28 -0400 (EDT)
Date: Mon, 30 Jun 2025 22:05:06 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: clear dirty status from extent buffer on error at
 insert_new_root()
Message-ID: <20250701050506.GA1405443@zen.localdomain>
References: <e9542d79dd176857624ab9e492acc7484a01b57b.1751282942.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9542d79dd176857624ab9e492acc7484a01b57b.1751282942.git.fdmanana@suse.com>

On Mon, Jun 30, 2025 at 01:33:20PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we failed to insert the tree mod log operation, we are not removing the
> dirty status from the allocated and dirtied extent buffer before we free
> it. Removing the dirty status is needed for several reasons such as to
> adjust the fs_info->dirty_metadata_bytes counter and remove the dirty
> status from the respective folios. So add the missing call to
> btrfs_clear_buffer_dirty().
> 
> Fixes: f61aa7ba08ab ("btrfs: do not BUG_ON() on tree mod log failure at insert_new_root()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ctree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 2997f2420719..dc21e840664b 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2881,6 +2881,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
>  	if (ret < 0) {
>  		int ret2;
>  
> +		btrfs_clear_buffer_dirty(trans, c);
>  		ret2 = btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
>  		if (ret2 < 0)
>  			btrfs_abort_transaction(trans, ret2);
> -- 
> 2.47.2
> 

