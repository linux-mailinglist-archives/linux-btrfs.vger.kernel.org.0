Return-Path: <linux-btrfs+bounces-3666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86FA88EC64
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C6A29FCCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D08142E9E;
	Wed, 27 Mar 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DiXvlUru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wWyDlYDD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7D1EEE4
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559910; cv=none; b=ZG9WkpwWm3rHFJzdFm5+hAoqcyGdo9SoD6j34JBWqnYrE+Rv3v9Zdjj8VPXxCk0NEe/Q0vlyDA6iUNN/Zm+a9HxQPPHDwzjjJu0fVIZblBw3FHE7B+Q+OMZ4st/nrRE/neMgg/oYXx14J3aWObdI8++yBJr6GlWZFhFGih8uxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559910; c=relaxed/simple;
	bh=okcrDmnykW4KbibuV4a4tuXN6M2Z9Vo6EAxUVjmYsFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7kC2DLWEBYouGM6FFXKjklQhfy2tZLtLrOYzGLpeHChc4ojCsfbMkfcS/B98iXwiYnzpege9VlqBQGuYvz8knJqEzgal7IyUY5KXd9U/ECzoostK8/HchqNQh010C6GxOv8LqRms+ov65ayfISPPT4pJbb9I77eTHeZ4S6C4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DiXvlUru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wWyDlYDD; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id AE7083200906;
	Wed, 27 Mar 2024 13:18:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Mar 2024 13:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711559906;
	 x=1711646306; bh=pZI1yGYmdT1sSxIuBUrWQrf84MTyktUcm+SuPNuiiWg=; b=
	DiXvlUrurh7xPpCDYe2Pe8jTauv8epjqYjCgLAvzDTrKeyrQyyKI6IU7yGPyVwp7
	sJU+txe8CXsyDIbQYHsAQ7bKALOaymjvbQ6XdgovwW8Eb2kXdkVDXo5CVgS6IpmK
	uuHAlUOYa5fOAM6xCROInLooLEIOKPbvIa18eDqx6m59GYsmCDK7GXfOYeW0DnXy
	TgkkGkc/n9vBZis7Tkx5aldivHg/CkhxTusGIxmrUo/nRnualwFP6SEFnZgCkeVU
	rFQLCZYVNLtQD96fZWPJ9OqqihBD56Wc+vwlLZ8THFBhXKkbNnf4vsiQXvT/RTog
	Dcbo9dYBZDXVZuQxCtmCFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711559906; x=
	1711646306; bh=pZI1yGYmdT1sSxIuBUrWQrf84MTyktUcm+SuPNuiiWg=; b=w
	WyDlYDD6puPS4NUopmPgxvOaQo5iKTbcE42BHMrGrndkQhPx5YBPCTfdQvBkwgMD
	iem7+ndb62dBJwmu3oyHzTY4GeHgCkvOsg10SO6VB4Z7p8f5vQqwIwS1VueQLW46
	iYp0rm/OUSb8qx86s8FKjd0rXFYqFKyvSC7ti2FRH7o5ckHSKbm7dIssn7qzVj1w
	tZgnRDo5kpKPDDCyZ+IufkQZ+2A19mPq5i9l5fHq9vbaRBLbKo028qbIxcV1TIfC
	/MRu15zB7vo/MfqZuaqu8fQSy73pTYBXebRhCSN7euMxTpTRmpwRP1oZF2rxjcCm
	WTEGBO8xRe03z2vwN9few==
X-ME-Sender: <xms:4lQEZvqQ8XIFq4Wi_qWebayIcZfH4KHYj_lXM9udEvWL_zPwI1q3Lw>
    <xme:4lQEZppyibM1iuantiZiO-x0qGg3XbBON8ih-kxVGXCYnc24ZMkEe8NU5KrhHK3ZL
    Qrx3KXQX-s7ilgePIk>
X-ME-Received: <xmr:4lQEZsN_1BfGT3F_Drp7t60pbsKTwrXwbqTgcWABSuqcsiRMtfUNk1y46H0m6eVUF-muJLu1CwQcJxbuElx2aAjVu-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:4lQEZi4E6zZGPXHidfqsPDvFUTXvwYZjuIjiAtuzibvMPsdna1iUQQ>
    <xmx:4lQEZu7ffYKXgjAfn6yVcQcM1mGv8Hnd9j5cWVeWuh_itpUFssqvLw>
    <xmx:4lQEZqjIFvvgQyIQE_BTBrZBFnjnDx6_PVwq4t6WAtemVxZkkM9tHA>
    <xmx:4lQEZg7xd35Z9Sm8dkGOzQ9Vnvyg5RXZy2BzmqOi-uqskJENf2tLsA>
    <xmx:4lQEZuG8f-wJPTqcIIAK8UvHcUDolsYgn7WTqI7wO05DawR0G2NoBQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 13:18:25 -0400 (EDT)
Date: Wed, 27 Mar 2024 10:20:31 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/7] btrfs: correctly model root qgroup rsv in convert
Message-ID: <20240327172031.GA2470028@zen.localdomain>
References: <cover.1711488980.git.boris@bur.io>
 <71f49d2923b8bff3a06006abfcb298b10e7a0683.1711488980.git.boris@bur.io>
 <245057c8-e7fb-4ad0-9e88-d21ae31cf375@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <245057c8-e7fb-4ad0-9e88-d21ae31cf375@suse.com>

On Wed, Mar 27, 2024 at 08:30:47AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/3/27 08:09, Boris Burkov 写道:
> > We use add_root_meta_rsv and sub_root_meta_rsv to track prealloc and
> > pertrans reservations for subvols when quotas are enabled. The convert
> > function does not properly increment pertrans after decrementing
> > prealloc, so the count is not accurate.
> > 
> > Note: we check that the fs is not read-only to mirror the logic in
> > qgroup_convert_meta, which checks that before adding to the pertrans rsv.
> > 
> > Fixes: 8287475a2055 ("btrfs: qgroup: Use root::qgroup_meta_rsv_* to record qgroup meta reserved space")
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/qgroup.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index a8197e25192c..2cba6451d164 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -4492,6 +4492,8 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
> >   				      BTRFS_QGROUP_RSV_META_PREALLOC);
> >   	trace_qgroup_meta_convert(root, num_bytes);
> >   	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
> > +	if (!sb_rdonly(fs_info->sb))
> > +		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
> 
> Don't we already call qgroup_rsv_add() inside qgroup_convert_meta()?
> This sounds like a double add here.

qgroup_rsv_add doesn't call add_root_meta_rsv. AFAICT, this is the
separate accounting in root->qgroup_meta_rsv_pertrans to fixup underflow
errors as we free.

> 
> And if you have any example to show the problem in a more detailed way, it
> would be great help.

I don't have a reproducer for this, it was just something I noticed. I'm
fine to drop this patch if you don't think it's worth the churn (and
certainly if I'm just a dummy and didn't see where we already call it)

In fact, this counter only exists to avoid underflow, but PERTRANS is
cleared by exact amount, and not via btrfs_qgroup_free_meta_pertrans, so
it might just be moot to track it at all in this way.

> 
> Thanks,
> Qu
> >   }
> >   /*

