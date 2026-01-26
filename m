Return-Path: <linux-btrfs+bounces-21070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPsUAPSld2lrjwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21070-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:35:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C718B8CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5773037E66
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682F34D4C4;
	Mon, 26 Jan 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SeXI+QZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENRfUNFa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B653EBF2F
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448914; cv=none; b=s3YUT3Wn+OW7Z1fRygEjT1Gbb1BPDo47M82geJ5R3bEwkbtKgq7VXGUYnihNKvFFPm98WDy8TEe673I1uODtOLw70UZfn6bW+Hi8SMDb1hgWS2s95vE8EJGro7JcsbVe0oes9X73G9TAxg+LzInv3IJJYFd7CsE/jAlR9Oog0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448914; c=relaxed/simple;
	bh=8uIkaxmnYauW+rapDwlRL7UnAhhyiEyyA8Xp1LO9X2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VffOf9010hurNjxpwaPtoJEalNq21aDiYmdJeAAKBs+cKLMXq3TzJC8ngH1YL4bKAzukmsCotM8B7FO6iRIsyj40jpEl6G1Z9jY0yiH+70uFWMI2Zxu0qxzizdgGiB49p5tUTLsPWHftxDt2wilH3Ht4F5XVfDqN4wVG0pcg7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SeXI+QZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENRfUNFa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CF72EC00DA;
	Mon, 26 Jan 2026 12:35:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Jan 2026 12:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1769448912; x=1769535312; bh=T09NeeZNGg
	ziTaG4CgO3vejUDh6BA55nOQ02FmIV9d4=; b=SeXI+QZH7uMdah3C/fAFs1FOQE
	fsqPeryXG2Hlw7kXLDTh62nRjAjrk1QwXxpO7hyHYTFpWjevmiu0X4znxxaUOwef
	0m7DJKlM8AsmsnUd4ACMhYoFC6zSucTDsFCHP09FcargHrctnyIuvh9GmhYPvhms
	I8ZyuLe6pHlBamlkwsHVeOTN26gocUUMpdpvPsxjF3tI0Wi6EXhHpBLjjglTF0qT
	2FCdwkHZ0v4d3cYyz9i+xD+ESyA/rVyJ4db+b7JMAJIoml7O1KxjWL66+13H8chM
	SRYwVSb6X5R+0NflwHqcQgcJNJJn+of29Ml9HP3w4H3MWvfsFBpY/221Seqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769448912; x=1769535312; bh=T09NeeZNGgziTaG4CgO3vejUDh6BA55nOQ0
	2FmIV9d4=; b=ENRfUNFaOKvOhaQ5dfyn0TujaEYHTw4UbwvEVUoNClh3+NWqPx5
	urAsEUM/ODSuGluTjcJVTzFgDEkjrkfbyj4CXKCQ7K6krbNb/qKS7a/CDt40JA5w
	PGdqUkFmSmIHA8YJcbVYWtzNkP6WlfY/1ye7pyYBewlMFQ4/SuZmPE6T1i3lh3VM
	Awmz7yBQR2NW0k5GGlLQHXdxHP8Pz0IWtvNALRyOrqPCqYP2jECi5dRcGexmuhxi
	Nc7KDrJnPFm0pqkgzeDQU95EKqFvbdhSLGck6VJKcWvcEtBwX9WTTCQjjQqXQVSK
	r4m09JD1d+xEVSGxSfdzhSQVzYrsmwpQaMg==
X-ME-Sender: <xms:0KV3aQjxWEAra9QoUt_UER4XcKX9sxlbes1ipvCdFoy4zisg9Qm8WA>
    <xme:0KV3afBvX0r4OHs8ColI3-JKS2JZ4NZW97fxjctvwkxEI13dD15yGvmlfgU7xOdYm
    _7LSfHXTRz4kPXx0N8KyI8iWdN7-sw38zEZ3eiaLmaZsTi75YhiPzU>
X-ME-Received: <xmr:0KV3aVs_ve5Hmism9o9QTrVXaL5Ow8_U8Y_CwSbCY07YMCGwfN_xGI25mJPjb7sxFcdCB4ZKXhkpabsdb5HpcOFgJ-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:0KV3acYEPifCb1IO_VZ3tjax5WJpzYKr0ZdolFoq0k_lVGiRE5BS8Q>
    <xmx:0KV3aQVqAHJknmUHzM6Q8S_QXfY7QvjeGxuGrOMnOwl9SKSqBPIz7w>
    <xmx:0KV3aY6NoZkm1gULSpjUx9iGUCZtDl9rMospDgK_6vqmtnpV9_qlZA>
    <xmx:0KV3aTiMcw2FxGvLWWzKMfHAo_Hxy3R9_7yP-ln-9a6fzVbhhb6eGg>
    <xmx:0KV3aYS8GfBky3ryHLWtQpb1aDjtaAM7dLqzLimaphfRco7lXd0A8RuB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:35:12 -0500 (EST)
Date: Mon, 26 Jan 2026 09:34:50 -0800
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: initialize periodic_reclaim_ready to true
Message-ID: <20260126173450.GB1066493@zen.localdomain>
References: <20260126113104.9884-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126113104.9884-1-sunk67188@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[bur.io];
	TAGGED_FROM(0.00)[bounces-21070-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,bur.io:dkim,zen.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 76C718B8CE
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 07:30:52PM +0800, Sun YangKai wrote:
> The periodic_reclaim_ready flag determines whether the background reclaim
> worker should process a specific space_info. Previously, this flag
> defaulted to false because space_info structures are zero-initialized.
> 
> According to the original design, periodic reclaim should be active from
> the start and only disable itself (set to false) if it fails to find
> reclaimable block groups.
> 
> Now that the reclaim condition has been fixed in a previous patch to
> properly handle reclaim_bytes, it is necessary to enable this by default.
> This ensures background reclaim logic kicks in as soon as the thresholds
> are met after mount.

Is this problem practical on a test/real workload or theoretical? If we
never free net-1G, I don't know how much reclaim is gonna help anyway.

If the "net 1G freed" condition is not the actual condition that we
want, maybe we should rethink that? We can enable it on 1G total freed,
regardless of allocation to give it a chance to run even if the net free
is 800M or something. I was worried about workloads that did actually
allocate and fill in the gaps. Or we can just use the total available space
as a proxy, like "if we do a free and the total free in the space_info
is >1G, enable periodic reclaim". The reclaim loops aren't gonna be
costly and we don't expect them to do anything when the fs isn't full
anyway.

Either way, though, I don't think this is harmful, so we can probably
put it in. Just curious what you think about the other ideas and why
you decided this was needed.

Thanks,
Boris

> 
> Fixes: 862dd2fd93540 ("btrfs: fix periodic reclaim condition")
> CC: Boris Burkov <boris@bur.io>
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/space-info.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index bb5aac7ee9d2..1530c30cacc9 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -250,6 +250,7 @@ static void init_space_info(struct btrfs_fs_info *info,
>  	space_info->clamp = 1;
>  	btrfs_update_space_info_chunk_size(space_info, calc_chunk_size(info, flags));
>  	space_info->subgroup_id = BTRFS_SUB_GROUP_PRIMARY;
> +	space_info->periodic_reclaim_ready = true;
>  
>  	if (btrfs_is_zoned(info))
>  		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
> -- 
> 2.52.0
> 

