Return-Path: <linux-btrfs+bounces-9177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4C9B0D7B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC641C22A1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0020BB30;
	Fri, 25 Oct 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKRB5MQf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TNla3uF+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wFk72jZ9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jz9WKc0J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD0185E50
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881537; cv=none; b=d5U/BPdwNWCMJu+irPL+rHt6SUrEzoQaOCn6gq09v2NYG2KOZMR3GEUQuPggcPgyU0TQRaImWV4u23ik/tzU3YJGr68cozpzN+u04HefkgqPZHXk89eURK0qN3NrJtO2xtXCrC0/cDq9QBDb1OGPOMAltpKA7ZsTo7f/hJd3VuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881537; c=relaxed/simple;
	bh=3DdiiJQq/95n1l7snkzVbb7VAU9TU7nQgKTf9yiD4dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igKCEbmicOdJFglFDfmEI6lTeD6KEbr/1bcS/ox3f0OHmG4r2IQHS/DoLwywnfaI5AZzVsfz/EfD07iuHsJMcCKH7qTilp+QYAyzaQcVKEsMxgIj1IQQNNaLlSaqCJGRbD8OOH20GtaizMKHfdGfO20flGIGdpaiMnegmBz60cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKRB5MQf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TNla3uF+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wFk72jZ9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jz9WKc0J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F0F11FB8B;
	Fri, 25 Oct 2024 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729881533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lpIQRHk6xepvLMO9YlqRq8OiZhmHAgG/mkrVpwqTQCM=;
	b=cKRB5MQfqsrt0BA1a5xtNqLX6u/ssy9K3eGu7jUeQxfQpvFwkEPfoZ/RWooeUp0lMQaP0H
	EjsjOzY1BfLAO9a6FXtPmSF9K8H+ebyO0wCXZXdW7Ndvd41ymTCWqbHXH1Iw/RIvYo58xO
	m9cbHAaQOuz9RIG0h2tG8U8XZpjSSDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729881533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lpIQRHk6xepvLMO9YlqRq8OiZhmHAgG/mkrVpwqTQCM=;
	b=TNla3uF+Ed7BSTRzJK7i2t5N4TY69j81DuaMLMNP6QPZeNOEikVeZVThkqbU7b3JmifRyo
	TA8WZlIUEqBAm4DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wFk72jZ9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jz9WKc0J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729881532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lpIQRHk6xepvLMO9YlqRq8OiZhmHAgG/mkrVpwqTQCM=;
	b=wFk72jZ90gn9kiwf77VW6B1KLTxekDfcC0wSEYwZV80vqoKulCN/PVg0w9gALL2Jzs/9WR
	QfFrqIEjj3OF3M16Z+MqyHVwGqXmmIcGBDBTC+i2LT4R2Exv3kySfRHHHf+9L2IgLCr/B7
	ks50eBMdWMFwlthAVgBIwvmdC5UTwIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729881532;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lpIQRHk6xepvLMO9YlqRq8OiZhmHAgG/mkrVpwqTQCM=;
	b=Jz9WKc0JYo/HNAIOKi1FKXJHCaodoUbv14OdEFMBfMXUXsko3aFlSWwmo25hp/ULjWcRpv
	WLZ4iSFIoaZYLgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 129FB136E4;
	Fri, 25 Oct 2024 18:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1fQaBLzlG2dqKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Oct 2024 18:38:52 +0000
Date: Fri, 25 Oct 2024 20:38:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 17/18] btrfs: track delayed ref heads in an xarray
Message-ID: <20241025183850.GK31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1729784712.git.fdmanana@suse.com>
 <529e3a34a057b4389dd779bc6cddfb075d9c5c34.1729784713.git.fdmanana@suse.com>
 <20241024185531.GA315088@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024185531.GA315088@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2F0F11FB8B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Oct 24, 2024 at 11:55:31AM -0700, Boris Burkov wrote:
> On Thu, Oct 24, 2024 at 05:24:25PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Currently we use a red black tree (rb-tree) to track the delayed ref
> > heads (in struct btrfs_delayed_ref_root::href_root). This however is not
> > very efficient when the number of delayed ref heads is large (and it's
> > very common to be at least in the order of thousands) since rb-trees are
> > binary trees. For example for 10K delayed ref heads, the tree has a depth
> > of 13. Besides that, inserting into the tree requires navigating through
> > it and pulling useless cache lines in the process since the red black tree
> > nodes are embedded within the delayed ref head structure - on the other
> > hand, by being embedded, it requires no extra memory allocations.
> > 
> > We can improve this by using an xarray instead which has a much higher
> > branching factor than a red black tree (binary balanced tree) and is more
> > cache friendly and behaves like a resizable array, with a much better
> > search and insertion complexity than a red black tree. This only has one
> > small disadvantage which is that insertion will sometimes require
> > allocating memory for the xarray - which may fail (not that often since
> > it uses a kmem_cache) - but on the other hand we can reduce the delayed
> > ref head structure size by 24 bytes (from 152 down to 128 bytes) after
> > removing the embedded red black tree node, meaning than we can now fit
> > 32 delayed ref heads per 4K page instead of 26, and that gain compensates
> > for the occasional memory allocations needed for the xarray nodes. We
> > also end up using only 2 cache lines instead of 3 per delayed ref head.
> 
> The explanation makes sense to me, and I don't think the new allocation
> is particularly risky, since the paths calling add_delayed_ref_head are
> already allocating and can return ENOMEM.
> 
> With that said, just curious, have you tried hammering this under memory
> pressure? Have you been able to create conditions where the new
> allocation fails?

Under normal condtions this will not fail as it's using GFP_NOFS which
still acts as no-fail. It could fail on a system with configured cgroup
memory limits and syzbot sometimes does that. But as long as the error
is handled we're fine.

