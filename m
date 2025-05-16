Return-Path: <linux-btrfs+bounces-14086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24A1ABA296
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA241898FA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AE27F16F;
	Fri, 16 May 2025 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="t3zBduJN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5qzp1U+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97E27CB38
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419146; cv=none; b=ruqnEqsiBJLiNfmMacKcBSP/UhzUx9qknD14LEsG49FviWnHpX7e7XbSm9qZGcOiTOk2M1TXhEGlhmdXIpKvi8/GoJ/b+SCCnuW+JX1ESyg7huqgjGD+RmyrA1eVvmlHW+e/q8X1FYeB6E5pNJF3XaKuflnvDWFicoqYpp15Q+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419146; c=relaxed/simple;
	bh=BEw+bANOSYCKLgjXm3W5VELRNqYcAPG9BKzRkspfFzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhfJB1uRltG8BvCs1m3CIQVoPsFHUrbkafd7Kt1Ewe4svLPUs10hK6FJDvqeMQP6wxgT3taU75oElGsqL0vVjAqloPFsKaUbYV/Dxxy+aSREPb3tAbFhKS4KahnnaQXn45KpZFcEExXTH14/EQR2TXfcpu9Ewv0sBDSkHkQyvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=t3zBduJN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5qzp1U+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 833391140123;
	Fri, 16 May 2025 14:12:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 16 May 2025 14:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1747419142; x=1747505542; bh=hIDVv5w+/1
	L5atRayFkUW1tEflcABH4JjIOJvoyDo38=; b=t3zBduJNwLVN0snaG6QZ2DeSsc
	22UF+RZEjujTETWweKEcSYRCsSlV1nDkNRAenVZgzr+a1q70mk7Z9hXDs1ql1EXq
	0uvODl6LHyV6tPpfg2XaEJiDjV+iXMai7iQeJeBCL0hiR7dqoVKxFXs+/I3OQ6/d
	4n3ZdreVAXSEGH5+6Lzzf/4vdtnmTTUi9+VhOurC+4/EA0AcPI9t5z5H7/PFTJ9G
	oFYgAZSjJm+2MmqUQo+YTXNQNgFl126vCgg/3omD/shsr6GotbfOBtMFWD79ZbHD
	BspPaYiHJfublBh1DjzPP7NWZVwa0AYqiHpvrhN2qt6+AI+tKm9NC+ZVHyCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747419142; x=1747505542; bh=hIDVv5w+/1L5atRayFkUW1tEflcABH4JjIO
	JvoyDo38=; b=A5qzp1U+DQNeNSedGtVpOiNAD9rUj1Yb/5tVl8uahwnzSC/uO4Y
	lO9W4IKu/4lgQNAJ6+yumSVVuDYK6eL1dQawM4jwRoxnPHMCgfiSNClV2yDjHwNG
	i1FwppokmuF5RUeaNqx72I+U+oeF+Ne9lVYdIImwQJK3ojuQAyLXjdwV5QgQXZN1
	H7Mv+XYHIxRgYe3M4f6enatEg+UiaN8UKjRzZS6ytCHrkpYg8PJxMu26jQBTvaRd
	QGtiLcgXGQkgLtRl/PM3bklsdKJWxyf+6hXgkK8yoxqSycxBKClolDLATdvsX5Hu
	VeUnvPf6zggdPQo3ypnv1E9AxC4OsyjHZLQ==
X-ME-Sender: <xms:BoAnaI5BPAm0g5HanF6V6v7K7uR9pO7uugKojILI2JqqHMwgxT5imw>
    <xme:BoAnaJ6Za-zSyuSNceubIhFy6OOQfJldYtitVTPm1q08RSDG_6idvmREJIMsptHKk
    bSD_m6unhIk_a6pN3s>
X-ME-Received: <xmr:BoAnaHe03O5-WCKI3cspXcKsfdlTCeTHm-rIyERVgGqjFh3Dy9QnEK8xBxEvR2I_QER-cN59uPqmP3n3kEjio8o7sqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BoAnaNIss9JRVthURt4hiEw1KRtWmw8vkBZS1wX6VjUPsQNUN_4XMA>
    <xmx:BoAnaMKFalpWeVLklYXT5iRVpq9nV-68YTvTbeGG-EM2dQcjMGvSGQ>
    <xmx:BoAnaOzbRT84PQ_SB3ieb0EB9FYF6bpVyYnT4DAAsHxrxKjdfLudpA>
    <xmx:BoAnaAI9gozdkNgQfo-4bW8vio70i3uolGr_76a9ovgGsGm8_8YrSA>
    <xmx:BoAnaC1PTKZFwMJCaJ_eOf001fZOnJAi2x-AYDXd1b4823LNNHxjiUTf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 14:12:21 -0400 (EDT)
Date: Fri, 16 May 2025 11:12:49 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: unfold transaction abort at
 __btrfs_inc_extent_ref()
Message-ID: <20250516181249.GA3585683@zen.localdomain>
References: <56bea892fbeb023b89ac362c3882c80181372f7a.1747412853.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bea892fbeb023b89ac362c3882c80181372f7a.1747412853.git.fdmanana@suse.com>

On Fri, May 16, 2025 at 05:34:58PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when either
> insert_tree_block_ref() failed or when insert_extent_data_ref() failed,
> move the btrfs_transaction_abort() to happen immediately after each one of
> those calls, so that when analysing a stack trace with a transaction abort
> we know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent-tree.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index cb6128778a83..678989a5931d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1522,13 +1522,15 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>  	btrfs_release_path(path);
>  
>  	/* now insert the actual backref */
> -	if (owner < BTRFS_FIRST_FREE_OBJECTID)
> +	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
>  		ret = insert_tree_block_ref(trans, path, node, bytenr);
> -	else
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
> +	} else {
>  		ret = insert_extent_data_ref(trans, path, node, bytenr);
> -
> -	if (ret)
> -		btrfs_abort_transaction(trans, ret);
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.47.2
> 

