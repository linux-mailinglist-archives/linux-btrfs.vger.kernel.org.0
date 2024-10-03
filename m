Return-Path: <linux-btrfs+bounces-8528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D889398F8FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6071AB216D7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9111B86E6;
	Thu,  3 Oct 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FxBX/+qq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/5Zqm3m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5D1A0708
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991247; cv=none; b=RSRnFYAjFOhBxwIXx5OkxcgUgP4zzRr0DGa079YpygMQ9erWtSAwIq17N5y+mUCFnW84AEklf8qYNA9ELsCokL4HWLkr66pCBBSTT3ROq1n2GcSyl9CaFUDsiXosE24jZrgERFSfJZWcX75Kfj+iK/PGIf5gVtMBPbnWizanEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991247; c=relaxed/simple;
	bh=oYe6LZuu74pqexHGqIRo1E9max6Wqh1TOAep8yp7sR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX22O/jQ2NO2KlgfuX537JHx1B3y/qFaViQ6OYaF5PfbnK7AZpizDNkqv10G9ETbpy+TXz3m796s/nxajQMP1DFC/xZcwiF5BkajkiprOht8xAFOuVpyyrbpW7qgRDXxj/vuaJuNsw28scRLKVWvyfLRLvroGZe0FWjnP6COzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FxBX/+qq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/5Zqm3m; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 99F011380231;
	Thu,  3 Oct 2024 17:34:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 03 Oct 2024 17:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727991244; x=1728077644; bh=e7vXQzknbZ
	D/7PD42Y4y22ENnEWnO09hrVrcpGCWePU=; b=FxBX/+qqmLgic3JGcF6qnPsHVz
	bynTrD0mwq/9lgg0DK61efS6lQ619K8V6Cu5WfQ0R3SCAJUdv76gJdSWo4UfK7sT
	xUpHpbPYcKt1BUxH7cpBgDGvzVJVO3lFd3Gp29kpvHRREkhPTzo8VZqkM8VT/ZUj
	oOOLisUfcHXDWevSD6SYGJAByLU0/cUyUfPgxPFCU2ufQTTv5vIsgTS8s7nMX480
	wbBshbeDwiFHqHLI3NWnmbXwAE7+1h6s8o4nxIb+dO9Sz6pkqOWk1GUsKegOVzUo
	3/BMmF2tEndzJwwi2hpO1qMLhRvYBEJTrikHuWUq+IYTTPGkE87LT1Hn3ZuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727991244; x=1728077644; bh=e7vXQzknbZD/7PD42Y4y22ENnEWn
	O09hrVrcpGCWePU=; b=m/5Zqm3mDHCiu9rdQ0tR5+H3JSPbKsuf4/1YGRPLC+Tg
	XqSIvRql+v1tnsYm3txs3l86EVVvdhob9gVH++i/VRQlc1U65P0esALDBKn9R97p
	3N4jYt+3O8LjEMDH6MQcZhdq5N76TzfFWTVQB+uUvA9ec91UUL1GA05bU5L+FfqW
	xHH38dixI0htJJqoQrbWozufDdu7e1Ek/aNqDC8IPuFu0vz8BSQ6cKsQvImIQdA2
	qQLYGxV4VQOQwbtsqn3jK+1CGWj25l1D+k8AMFJ0zBaKk7ZnvLk19oYGSYoOB5zG
	fmYVq2c+snIKV1ttR2LE+vWtNWk166vX4svGH3WjMQ==
X-ME-Sender: <xms:zA3_ZhtapzY5UIyXhMQ_pzbS-IEUY2MtAbaB7MTPMh17vKkbndHE1A>
    <xme:zA3_Zqe7D2PbuW1AJ8aSSE2blYeVpu8cYa_EjMBUHlp6apY_UWEyQQCLmDIh2QDOZ
    c7_aezP6J5KhVNQGew>
X-ME-Received: <xmr:zA3_ZkxInxf3C0laOxNCWvqeHAzvaqEXUfr725ig7zqYi4hcuipRaSAbJQHZIe038zHbgpLCQxXW2KY3C5tMQodDMXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudeifecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:zA3_ZoN8ufyQF7Ri9vtXVlrUHMsXwufHBMu3c8YmE-pyaNbPaV4G3A>
    <xmx:zA3_Zh9639_Y00mzhFMM6lmrJ03xZekyj16Viui87D7cGnvMq00nSQ>
    <xmx:zA3_ZoV1WRFbJStpwZzYkDx9ALIzctHeRL47B6aFihP8YBOW7eNttQ>
    <xmx:zA3_ZicZ5uGypRv1vs6kJ1k40aOguwLLdHw3Agj7Q6bjRLTeLhAj0Q>
    <xmx:zA3_ZsYmZ0maPuIYoEVVQ8rdGAkFOXAYygjzTornEbIrCyyR1IzIufB->
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:34:03 -0400 (EDT)
Date: Thu, 3 Oct 2024 14:34:01 -0700
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 03/10] btrfs: add a comment for new_bytenr in
 bacref_cache_node
Message-ID: <20241003213401.GC435178@zen.localdomain>
References: <cover.1727970062.git.josef@toxicpanda.com>
 <822af146718551c3f2ba248ba9df9092ba022160.1727970063.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822af146718551c3f2ba248ba9df9092ba022160.1727970063.git.josef@toxicpanda.com>

On Thu, Oct 03, 2024 at 11:43:05AM -0400, Josef Bacik wrote:

s/bacref/backref/
in the commit title

> Add a comment for this field so we know what it is used for.  Previously
> we used it to update the backref cache, so people may mistakenly think
> it is useless, but in fact exists to make sure the backref cache makes
> sense.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/backref.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index a810253d7b8a..754c71bdc9ce 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -318,6 +318,12 @@ struct btrfs_backref_node {
>  		u64 bytenr;
>  	}; /* Use rb_simple_node for search/insert */
>  
> +	/*
> +	 * This is a sanity check, whenever we cow a block we will update
> +	 * new_bytenr with it's current location, and we will check this in
> +	 * various places to validate that the cache makes sense, it shouldn't
> +	 * be used for anything else.
> +	 */
>  	u64 new_bytenr;
>  	/* Objectid of tree block owner, can be not uptodate */
>  	u64 owner;
> -- 
> 2.43.0
> 

