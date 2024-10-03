Return-Path: <linux-btrfs+bounces-8527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAB98F8E8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78CE2839A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013E1B85F6;
	Thu,  3 Oct 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dLPKoKho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qFGLIn44"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672B224D1
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990870; cv=none; b=Q0h99+Q5L6BNbEgCHiovYgCE+lu/d9BgO90Vos7XweXhdZ6y1s7pFf2J4/I8fXTKJzxd9NvRba91l59zEk+BPjHi42+l3GZgqi1UG1CwrmpfVv9dPxuJ4njDZQr4AG6owm1XWZSvrLc6515Rs9OWRXtxpsa7pJ1KekzJf85OBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990870; c=relaxed/simple;
	bh=fgwRrO+BDYPgXinLLxRZzm3VhkmEtyL7CCi0TdD60WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgMCaNWHBwELCWV6cFyJKkjkFkyltsUg5ayGV2AKD6Yb1SdF35rvCVhqyJXpkGEoJjle4F3j3MiSGbXuVyHvy0tMV2iMI9kOohSLDp0FhIHtcqRrWfWWQuuCGiagQnMEgCfDBKU3IlvknKgaZjF/0v8CQSBkaxq6ArIjnzpXKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dLPKoKho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qFGLIn44; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5914E13800CB;
	Thu,  3 Oct 2024 17:27:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 03 Oct 2024 17:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727990867; x=1728077267; bh=YZuv0BReAO
	e7FCN5TEaKhTm1K8bXRpPCgLKiz6EuTyM=; b=dLPKoKhox65LCsY27l35bz2B6h
	WAK5fLspR2GR+4czAy01wcIq67bwVNT3GNCCogrAo4Ot+9raIRgJtAX5RwEq+C6S
	wcGiYAJifi5c5ebQjdhjvOKGeu1zSR4e0KLfkIOCSTOV5eAclFIq7BblMEJRVKyS
	uRX+GVHon99ndpNTtpUurqqr9eTlAN8njLaqJxioEDvy8W13AUGbsC5B4yqtooF8
	u9gG1/dd8fwTIzvTwu5d23aNlAALNo+oXwXcnWRQ3xwEynve77kJwD9YUFAVaXk/
	3SsOjSN+d7j2a77W0DL1lChNcKbEn82YrwUOQ0lu9uxbV/I4XjNJ75DrXmWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727990867; x=1728077267; bh=YZuv0BReAOe7FCN5TEaKhTm1K8bX
	RpPCgLKiz6EuTyM=; b=qFGLIn44R7PqA/7QpuTA6ZeQmfqP9T5+DSFurLpffC9G
	Fo82dKio/r1Ii7EERhvZ2gVoj8JKaZZCfdL2raRbuVRjTVwqq5bZucbOtEVW1VxZ
	KZCrhJmo+rKP4Y5P69rOuymupOEhXgmYbflfUJ6RPCnCA72HFpPar+UNapHf7odT
	ro+bxY8sekJw83dT1MzcygKa4KCmPEedhH7L7qQOSUJbXPcMNDKmWLeBuaNx3OJY
	D/Jt1P08ZihLAqcuVyb7Z8hV6bB8fW0SWZ2opGHEsHDbKrmswXnbqJVYY2xLCFxq
	5g7sOWRjl8+SIsefkN54ZerqyGDuf8Mk4l6A0YtbTw==
X-ME-Sender: <xms:Ugz_Zu7iIkj3cNuSo33CBRfFsig3EXGrqTZXoktwixuBcYJWsFynGA>
    <xme:Ugz_Zn6PGu4uRCRjxmBYo_l7Jf-vvtNB65nDV0tFeT8LBPduGBcelue8HLVJALBUP
    In_neeCSR9YPqrD5vI>
X-ME-Received: <xmr:Ugz_ZtekwsFc-HlMBFmMaM3iPtM_m-JsJFAaYDAmAOieB06jD517RS06if3hY0TXMbH0xYeiZL1GKEnHpeJmqNWvSus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:Uwz_ZrLFEA3Jk4SdmZERYgoLq53aPebl1GHFDzHz0A1lu_C5qPgONA>
    <xmx:Uwz_ZiLdHXr6TYeluITmwWce0hP6QslMoGSAYqKcRYro6QHwEYyMSg>
    <xmx:Uwz_ZsxPoquNK3tlqbgtO-SP22sxCeVBoYhVEN-Ngtx8Ik5il53pkQ>
    <xmx:Uwz_ZmLTetLK-Lk1YkbwvxwcDyXkJqVFpl6vUzOAK1le6QmBN57xig>
    <xmx:Uwz_Zu1ioBH5Rr7IhbHB2cLJltNYAtrrrZyVcFJLyYWy7too92up29cT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:27:46 -0400 (EDT)
Date: Thu, 3 Oct 2024 14:27:43 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 04/10] btrfs: cleanup select_reloc_root
Message-ID: <20241003212743.GB435178@zen.localdomain>
References: <cover.1727970062.git.josef@toxicpanda.com>
 <fe72732de97d83d6f5b649fce1642019e78de981.1727970063.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe72732de97d83d6f5b649fce1642019e78de981.1727970063.git.josef@toxicpanda.com>

On Thu, Oct 03, 2024 at 11:43:06AM -0400, Josef Bacik wrote:
> We have this setup as a loop, but in reality we will never walk back up
> the backref tree, if we do then it's a bug.  Get rid of the loop and
> handle the case where we have node->new_bytenr set at all.  Previous the
> check was only if node->new_bytenr != root->node->start, but if it did
> then we would hit the WARN_ON() and walk back up the tree.
> 
> Instead we want to just freak out if ->new_bytenr is set, and then do
> the normal updating of the node for the reloc root and carry on.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 144 ++++++++++++++++++------------------------
>  1 file changed, 61 insertions(+), 83 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index ac3658dce6a3..6b2308671d83 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c

I think this (and most other functions in backref caching) could really
benefit from some description of their invariants. I think that will pay
its weight in gold if we ever have to read this code again in 10
years...

> @@ -2058,97 +2058,75 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
>  	int index = 0;
>  	int ret;
>  
> -	next = node;
> -	while (1) {
> -		cond_resched();
> -		next = walk_up_backref(next, edges, &index);
> -		root = next->root;
> +	next = walk_up_backref(node, edges, &index);
> +	root = next->root;
>  
> -		/*
> -		 * If there is no root, then our references for this block are
> -		 * incomplete, as we should be able to walk all the way up to a
> -		 * block that is owned by a root.
> -		 *
> -		 * This path is only for SHAREABLE roots, so if we come upon a
> -		 * non-SHAREABLE root then we have backrefs that resolve
> -		 * improperly.
> -		 *
> -		 * Both of these cases indicate file system corruption, or a bug
> -		 * in the backref walking code.
> -		 */
> -		if (!root) {
> -			ASSERT(0);
> -			btrfs_err(trans->fs_info,
> -		"bytenr %llu doesn't have a backref path ending in a root",
> -				  node->bytenr);
> -			return ERR_PTR(-EUCLEAN);
> -		}
> -		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
> -			ASSERT(0);
> -			btrfs_err(trans->fs_info,
> -	"bytenr %llu has multiple refs with one ending in a non-shareable root",
> -				  node->bytenr);
> -			return ERR_PTR(-EUCLEAN);
> -		}
> +	/*
> +	 * If there is no root, then our references for this block are
> +	 * incomplete, as we should be able to walk all the way up to a block
> +	 * that is owned by a root.
> +	 *
> +	 * This path is only for SHAREABLE roots, so if we come upon a
> +	 * non-SHAREABLE root then we have backrefs that resolve improperly.
> +	 *
> +	 * Both of these cases indicate file system corruption, or a bug in the
> +	 * backref walking code.
> +	 */
> +	if (!root) {
> +		ASSERT(0);
> +		btrfs_err(trans->fs_info,
> +			  "bytenr %llu doesn't have a backref path ending in a root",
> +			  node->bytenr);
> +		return ERR_PTR(-EUCLEAN);
> +	}
> +	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
> +		ASSERT(0);
> +		btrfs_err(trans->fs_info,
> +			  "bytenr %llu has multiple refs with one ending in a non-shareable root",
> +			  node->bytenr);
> +		return ERR_PTR(-EUCLEAN);
> +	}
>  
> -		if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
> -			ret = record_reloc_root_in_trans(trans, root);
> -			if (ret)
> -				return ERR_PTR(ret);
> -			break;
> -		}
> -
> -		ret = btrfs_record_root_in_trans(trans, root);
> +	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
> +		ret = record_reloc_root_in_trans(trans, root);
>  		if (ret)
>  			return ERR_PTR(ret);
> -		root = root->reloc_root;
> -
> -		/*
> -		 * We could have raced with another thread which failed, so
> -		 * root->reloc_root may not be set, return ENOENT in this case.
> -		 */
> -		if (!root)
> -			return ERR_PTR(-ENOENT);
> -
> -		if (next->new_bytenr != root->node->start) {
> -			/*
> -			 * We just created the reloc root, so we shouldn't have
> -			 * ->new_bytenr set yet. If it is then we have multiple
> -			 *  roots pointing at the same bytenr which indicates
> -			 *  corruption, or we've made a mistake in the backref
> -			 *  walking code.
> -			 */
> -			ASSERT(next->new_bytenr == 0);
> -			if (next->new_bytenr) {
> -				btrfs_err(trans->fs_info,
> -	"bytenr %llu possibly has multiple roots pointing at the same bytenr %llu",
> -					  node->bytenr, next->bytenr);
> -				return ERR_PTR(-EUCLEAN);
> -			}
> -
> -			next->new_bytenr = root->node->start;
> -			btrfs_put_root(next->root);
> -			next->root = btrfs_grab_root(root);
> -			ASSERT(next->root);
> -			mark_block_processed(rc, next);
> -			break;
> -		}
> -
> -		WARN_ON(1);
> -		root = NULL;
> -		next = walk_down_backref(edges, &index);
> -		if (!next || next->level <= node->level)
> -			break;
> +		goto found;
>  	}
> -	if (!root) {
> -		/*
> -		 * This can happen if there's fs corruption or if there's a bug
> -		 * in the backref lookup code.
> -		 */
> -		ASSERT(0);
> +
> +	ret = btrfs_record_root_in_trans(trans, root);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	root = root->reloc_root;
> +
> +	/*
> +	 * We could have raced with another thread which failed, so
> +	 * root->reloc_root may not be set, return ENOENT in this case.
> +	 */
> +	if (!root)
>  		return ERR_PTR(-ENOENT);
> +
> +	if (next->new_bytenr) {
> +		/*
> +		 * We just created the reloc root, so we shouldn't have
> +		 * ->new_bytenr set yet. If it is then we have multiple
> +		 * roots pointing at the same bytenr which indicates
> +		 * corruption, or we've made a mistake in the backref
> +		 * walking code.
> +		 */
> +		ASSERT(next->new_bytenr == 0);
> +		btrfs_err(trans->fs_info,
> +			  "bytenr %llu possibly has multiple roots pointing at the same bytenr %llu",
> +			  node->bytenr, next->bytenr);
> +		return ERR_PTR(-EUCLEAN);
>  	}
>  
> +	next->new_bytenr = root->node->start;
> +	btrfs_put_root(next->root);
> +	next->root = btrfs_grab_root(root);
> +	ASSERT(next->root);
> +	mark_block_processed(rc, next);
> +found:
>  	next = node;
>  	/* setup backref node path for btrfs_reloc_cow_block */
>  	while (1) {
> -- 
> 2.43.0
> 

