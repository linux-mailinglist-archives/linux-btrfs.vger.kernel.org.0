Return-Path: <linux-btrfs+bounces-21566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKQ3BZFUimlvJgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21566-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 22:41:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D0114DF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 22:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E585301CCFA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED930EF83;
	Mon,  9 Feb 2026 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nLCMODlZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q7XE1Tyg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E226ED48
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673288; cv=none; b=QG5AvEpnCe2eIw0mPYGB9uGqnW4aFqu8pO576Kjy5sbLY+aayX6oKzxsLQnxUWW0IqjOF8NFbbcZv+6QqdZUSk8g42XFdKxzO4Vo97WHz7cEUWR7640WLBTS/Z0cQLAes3eNIyz/ngmVK3BJRSdCBPMPfZDehU9USKCdoWulJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673288; c=relaxed/simple;
	bh=aJI+ayx+yydqY1Ec8P6d/mdpAld224dqPKuN5876Yqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXfZiHa84Zoy4oAgfSIJ4Vz6bOHiHieia2eEdBCc39jhQN52t43R77z7ofgIZCQsi6kZKmVXDVceCEWDJ54DwkJdHAxIsAUZQrl4F5FjtSLb8hJDEckm+BI6ESs4MQLNy7cf6c5o1s8KH8Kso+CuLpUVI6ZdufROKzexYzN6nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nLCMODlZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q7XE1Tyg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BEA3F1D00119;
	Mon,  9 Feb 2026 16:41:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 09 Feb 2026 16:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770673285; x=1770759685; bh=vGIO7PtMD+
	jeXBntx8iovmcWD5On4W3Yp/n601Sh6oA=; b=nLCMODlZgFvpSZP+1ppswADYIT
	WFYdJwiBfw/pBy/woObvQtbPieIXVzjWhE3DQ12rQjacHydFCdOzULweNRgR3aAP
	b0SnJZJrsDPO3gwobq/pKAxUxWebIKNx7MyS4G6qzxDcHh8+BemL+fdyn2O3gznV
	L5AbKnQlw7WO2aP2s6tok2YxQ1iK/+l2Fjzx2AybA0K992tp8t3dbSZHr3RPKATc
	aruix3qOlD3HZ9M2PJ+l8qSDfSj2alKv6U2qkXC5+Wn19nOxEHrioZLJAGMAFNa8
	kIPmOHO8IddgQsskrLsQsXpXg4ly7OQUcWn9Vapq2aOBDvOao+P894QGo2Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770673285; x=1770759685; bh=vGIO7PtMD+jeXBntx8iovmcWD5On4W3Yp/n
	601Sh6oA=; b=q7XE1TygCcTR9HcBpBIT5HLDZ10faKMQ6tm7N/crxmmAkysisN6
	ooMmmkyl7YuxQPSe+3Iw1PVZD+993LeaK7verY9zsUeIPI4f9I6yPx53JlBkzuKK
	TylDGaK3vhwkb46mODP0Gv7hcNmEApYL0ponnTAJB+qs1GKILERfL83EwHdWX+z6
	alcuVK3oN1B8GJ1O7mGJc5PH3q1YNJW4qALCm+kGpP5LqvBiAWdDl3TRC8CARd/Q
	vbZiRGC4JoRyl4cJNMlmDyVkOzm4S/YvAENNwE5iwdi0z6T6ktzAC04GGBJQIEw8
	uoURYj9TLwCQuf75vwgKKISW6H36UAHovkA==
X-ME-Sender: <xms:hVSKaauY51i4IDcg1gp7E9ACbbO12cCyswFicBJydHKMah3QiSX4rw>
    <xme:hVSKaVdC_c2ivHOx-YrgSAMWQJcAkPGrCt-SUq1Dmu_H_lpDlhYtvmmOMMxLk41Cv
    i5n8V8oYCnyAsAZAetLx8pt2vCpU8JDBppX40D1Fypl_0wowd9yLxcj>
X-ME-Received: <xmr:hVSKaTZf7Axfcz0Fa8qESyfSMKG_UmNjl74TnIa2OWAHaxFei7Bco1gqW6hKwby1CshFXvuNr2rep3rUSlhqeA-lNEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:hVSKaQVX0Z8kwqFSqITMGj6LhcXFD7oQNlIwgEkHCTJgemoKEU8ILg>
    <xmx:hVSKadgIs5hXZKyium5u4HX6PCt1ShadHWpO-bHhF41jtQaZEkbCQg>
    <xmx:hVSKaWW_5PJHptUu5sIBfSGpaBWwsHnDgR4XLeWC9gdL8KYEaZkoFA>
    <xmx:hVSKacPuCtIqB9gNTG6EiMn9KzrZuKPtFmmq_QyHS6z0-6NO7QktWg>
    <xmx:hVSKaWD5rbzuMn0QJRFPrcm1f_DREcx1aywAORgkF6injoGVSNeXcjA->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 16:41:25 -0500 (EST)
Date: Mon, 9 Feb 2026 13:40:38 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid starting new transaction and commit in
 relocate_block_group()
Message-ID: <20260209214038.GA379757@zen.localdomain>
References: <fe10986ea88fddf9ff8dd58c29694583c805733e.1770667488.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe10986ea88fddf9ff8dd58c29694583c805733e.1770667488.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21566-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: A39D0114DF6
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 08:24:34PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We join a transaction with the goal of catching the current transaction
> and then commit it to get rid of pinned extents and reclaim free space,
> but a join can create a new transaction if there isn't any running, and if
> right before we did the join the current transaction happened to be
> committed by someone else (like the transaction kthread for example),
> we end up starting and committing a new transaction, causing rotation of
> the super block backup roots besides extra and useless IO.
> 
> So instead of doing a transaction join followed by a commit, use the
> helper btrfs_commit_current_transaction() which ensures no transaction is
> created if there isn't any running.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/relocation.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 1da892af9a44..8a8a66112d42 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3642,12 +3642,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>  	btrfs_block_rsv_release(fs_info, rc->block_rsv, (u64)-1, NULL);
>  
>  	/* get rid of pinned extents */
> -	trans = btrfs_join_transaction(rc->extent_root);
> -	if (IS_ERR(trans)) {
> -		err = PTR_ERR(trans);
> -		goto out_free;
> -	}
> -	ret = btrfs_commit_transaction(trans);
> +	ret = btrfs_commit_current_transaction(rc->extent_root);
>  	if (ret && !err)
>  		err = ret;
>  out_free:
> -- 
> 2.47.2
> 

