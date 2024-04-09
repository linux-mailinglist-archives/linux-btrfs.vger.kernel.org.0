Return-Path: <linux-btrfs+bounces-4056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4C89D82B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D4C287197
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 11:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97635129A75;
	Tue,  9 Apr 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NxgZIz6+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9W0fwZW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NxgZIz6+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9W0fwZW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5281AA5
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662511; cv=none; b=csCkhV20ZDhJ+pOr5nwOGOafPT3h2Z830k86rNdQ3a5+dZICijw4eC1Gu/RW0WEDqkRCcg+fzqEi6tIwGj9VEk3n23zwLMDU0pnxUESxepgn9z1j+SfpVIzFjUVrqQgg9iZZ+/+LEMzrrgk+Af3Cw5nUxNDNIBoBOX98DeXf448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662511; c=relaxed/simple;
	bh=PLxeVce/5SoesHGoKQy3Rt+PYPIy6upsigyBloK54vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo4+grFyLb3t4dHzxkR3w29JTxBtLt+n48yQASi6QuEdKKY5qMzIhwhCFNeUdtgJQFlVklwwX56rcIOEFgdCpD1IhX0vjjxduZe0cUZnNbZ/dgFXSEPN5otLUFWZl1AsVZPSKf6ndmvG8XIJ8qDr/Z6wHlTiaycSLlVoR6tnmOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NxgZIz6+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9W0fwZW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NxgZIz6+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9W0fwZW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F20620973;
	Tue,  9 Apr 2024 11:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712662508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4skFnkG0ow38tn44xZaeRLmdYRSSzSK4IvMWmoIh74M=;
	b=NxgZIz6+isGSqxcn2J6qMgwsRwLemu5xZ11QVHQTHfnTJ9PYfgXHECwKcmyxRUdyeCcnUu
	hGIOdXTmeQmwE6cxzQuCuSVNenVY9/e9zMMkY61kzCWAJuBenr8wTH/XsSDwb0Op2HZ6lJ
	2Dg6QLdnYP2/WfYQOe4l5+NgoLvSRsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712662508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4skFnkG0ow38tn44xZaeRLmdYRSSzSK4IvMWmoIh74M=;
	b=p9W0fwZWCqdcO4/y4LcU5ie/zfLxYJ1csx+blh4Bl1UK8GtHfNYbGlqEYd4QKSJ9ckpGa2
	lXMNWeWZa5cm+JCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712662508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4skFnkG0ow38tn44xZaeRLmdYRSSzSK4IvMWmoIh74M=;
	b=NxgZIz6+isGSqxcn2J6qMgwsRwLemu5xZ11QVHQTHfnTJ9PYfgXHECwKcmyxRUdyeCcnUu
	hGIOdXTmeQmwE6cxzQuCuSVNenVY9/e9zMMkY61kzCWAJuBenr8wTH/XsSDwb0Op2HZ6lJ
	2Dg6QLdnYP2/WfYQOe4l5+NgoLvSRsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712662508;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4skFnkG0ow38tn44xZaeRLmdYRSSzSK4IvMWmoIh74M=;
	b=p9W0fwZWCqdcO4/y4LcU5ie/zfLxYJ1csx+blh4Bl1UK8GtHfNYbGlqEYd4QKSJ9ckpGa2
	lXMNWeWZa5cm+JCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 14D011332F;
	Tue,  9 Apr 2024 11:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id U/fdBOwnFWZdYgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 11:35:08 +0000
Date: Tue, 9 Apr 2024 13:27:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, kernel-team@meta.com,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH] btrfs: fallback if compressed IO fails for ENOSPC
Message-ID: <20240409112743.GC3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4607d44ee4cf72a302d3adeba5d0ae99518a5f36.1712391866.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4607d44ee4cf72a302d3adeba5d0ae99518a5f36.1712391866.git.sweettea-kernel@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -1.76
X-Spam-Level: 
X-Spamd-Result: default: False [-1.76 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.76)[84.24%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

On Sat, Apr 06, 2024 at 04:45:02AM -0400, Sweet Tea Dorminy wrote:
> In commit b4ccace878f4 ("btrfs: refactor submit_compressed_extents()"), if
> an async extent compressed but failed to find enough space, we changed
> from falling back to an uncompressed write to just failing the write
> altogether. The principle was that if there's not enough space to write
> the compressed version of the data, there can't possibly be enough space
> to write the larger, uncompressed version of the data.
> 
> However, this isn't necessarily true: due to fragmentation, there could
> be enough discontiguous free blocks to write the uncompressed version,
> but not enough contiguous free blocks to write the smaller but
> unsplittable compressed version.
> 
> This has occurred to an internal workload which relied on write()'s
> return value indicating there was space. While rare, it has happened a
> few times.
> 
> Thus, in order to prevent early ENOSPC, re-add a fallback to
> uncompressed writing.
> 
> Fixes: b4ccace878f4 ("btrfs: refactor submit_compressed_extents()")
> Co-developed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Reviewed-by: David Sterba <dsterba@suse.com>

