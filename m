Return-Path: <linux-btrfs+bounces-13841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C984AB003F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BE59E1277
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783D2820CC;
	Thu,  8 May 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Q/Id4u79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQywZDb3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5227F4E5
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721198; cv=none; b=Wewn1icGajTcZ9rKj0KGbfGE6m7wFuCYEZWF2QbNmtNyyJ/BGTFa+w7qqQA1qIWHplXsLbD4xWuUCJKza1AmcbR7u6Fq8R+f/sJOdb+EP7gp/IA4wq2JP5n1TluQbr3JWtFrlW6eKvLLqAF4tyfxCTuuDt2t31H7kJoqPGF45Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721198; c=relaxed/simple;
	bh=3otbUQuLt2888Z3C9KGIr8o+jONeJn4CSfu+oOzXkas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyTNiyM/afmfoIIdTmY/nE1tJzZeTGUp/FS9R7wW3JejDxqScPuzTz0yk4RullNVghxXHmTXiUS4Zo3m4dtycoiZAQkMvZ9V+sjbVKCqZvkMtd6omGD5PjDFFJzTItJqyPYhcaAfluvziknsY4QLfw2FkbRlTlbPQ5QBeU4gKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Q/Id4u79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQywZDb3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAF2511401C8;
	Thu,  8 May 2025 12:19:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 08 May 2025 12:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746721194; x=1746807594; bh=n/FmGPERTt
	Iq3c49ZWf0sar8+JfGl370/BsdN+BJ+7o=; b=Q/Id4u79EE6mwJnXjIPkrosWKl
	Yf8Cz5D/BzMGbmPfLZdsUdzHle7Gjtjw2NVByYSvJYt6OZlJMJL16tfIPLex1t43
	QmBYi7L1RridEBsofOIbh10N9C7FIClooeE9BZMml1d56esZxV0N83eZQNXqO59A
	xFp1Y9oIRVwWv59msAWd/qkv/JXTO0oLTuVG6UxC6f88AEO4hkADmnzVxkFCYb/1
	NrxhwC3GHjLcODniNwACxnc7uz88V611aCnJbGgPJB+VWd9IrDZxQZzwbeNplZxO
	/iXQhcVdBtQ/V7TRVQSEjCVvGOECGdAcf3I+m5t6L+Wj5ESNGSG8mRqaAeMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746721194; x=1746807594; bh=n/FmGPERTtIq3c49ZWf0sar8+JfGl370/Bs
	dN+BJ+7o=; b=MQywZDb3nCLbR7LNXEdlrUD006jhcZnoQwi9DhKQqT6sh3oNYYp
	2xWqHRmO/NSIL3jH3edrPg1qbCJwkWDj2umQ4KTOkk7mgAN+j46E+Nj5FhUUXTKM
	ZdI2TL8EHxUySlUDK/DMq3OKIWgkwdUu5qSkNiULwF5NRXfoh6JV/RugOdiTAtuk
	83DOy2AqgLsB5WizC+xsIYK+EJKpo8ZwVu4StrXf2vri3kZ/Y5XaNNc3N+OXVtBQ
	ANQ65vFnGTuP1DDxM7RtfpbF5a7L3xVZ+xVCDhgz5ZrcBzntUcxV5uQC7kiPzC1F
	jkvIkUyOwbiimOulWulsZNfFh2E0KBGb9Ig==
X-ME-Sender: <xms:qtkcaOJfaBG3mkM_wjc1sCBXLKhSvfSp-YtSKUFjlCN_8G-THD2TwQ>
    <xme:qtkcaGL749cXosER_wPRXVNOfaBOCCVrGr-_0WxBWj5Rudi8qPrQmukh5TP179xO8
    R8cWj35S3xpwbklxoQ>
X-ME-Received: <xmr:qtkcaOtspHHRe6wXTFpM8Zk2h11dNWSyaCRQGoqybU9-RN7QXBxjWitRWgWv3VyLSmSUoQ_N_8ZL4J7INosmrZZdw04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhho
    vhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeelle
    fhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughm
    rghnrghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qtkcaDbuZJTXaKg5hRaTta-XudVdxhq7Fql00ZtPjQtr7rsqZ9FHGw>
    <xmx:qtkcaFa1CYfgrGD4qJW3TykjN_5BB5MfOkT55YggasZa3LxjYiBMew>
    <xmx:qtkcaPAVPHiCQHK1ddfLtBp9OKOmAlz_mtUJwVH3dtpgrqeOLb4CRw>
    <xmx:qtkcaLaIKPn_w_4SxiUnkhFbkfr3_foQt0SHQLWiYYXGrzmdzpe0nA>
    <xmx:qtkcaOGEpoE1Z3_5hHgm0S0XkYqZAabaYZocognrlL1r-F1GBojSKzeu>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 12:19:54 -0400 (EDT)
Date: Thu, 8 May 2025 09:20:36 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: fixes and cleanups for ordered extent
 allocation
Message-ID: <20250508162036.GD3935696@zen.localdomain>
References: <cover.1746638347.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746638347.git.fdmanana@suse.com>

On Wed, May 07, 2025 at 06:23:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some fixes and cleanups around ordered extent allocation. Details in the
> change logs.

Now that we discussed the first patch in detail,
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Filipe Manana (5):
>   btrfs: fix qgroup reservation leak on failure to allocate ordered extent
>   btrfs: check we grabbed inode reference when allocating an ordered extent
>   btrfs: fold error checks when allocating ordered extent and update comments
>   btrfs: use boolean for delalloc argument to btrfs_free_reserved_bytes()
>   btrfs: use boolean for delalloc argument to btrfs_free_reserved_extent()
> 
>  fs/btrfs/block-group.c  | 10 ++++----
>  fs/btrfs/block-group.h  |  2 +-
>  fs/btrfs/direct-io.c    |  3 +--
>  fs/btrfs/extent-tree.c  |  8 +++----
>  fs/btrfs/extent-tree.h  |  2 +-
>  fs/btrfs/inode.c        | 10 ++++----
>  fs/btrfs/ordered-data.c | 51 ++++++++++++++++++++++++++---------------
>  7 files changed, 50 insertions(+), 36 deletions(-)
> 
> -- 
> 2.47.2
> 

