Return-Path: <linux-btrfs+bounces-14283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5737AC7419
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 00:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2949C188A0A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 22:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658321FF5C;
	Wed, 28 May 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X02GJN2p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQ/jkHmB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y9b00WzM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbiU2e/f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066A1F151C
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471561; cv=none; b=U55TALyF0PQxd1e+cnJv0dLqR0GsMxPrFdrmOB/00pU0aMItJwnI6zgvyb4z5sJoptYOOWmoh3rBewBbgu2AcsEcHwmxOMae7DMoWzjd7fnDPlDXl/QlXyNrFHmATIDYJDXV1LN/ClxEMgPj3oBIv0pyTOPim+KxhE9Y4qu2czI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471561; c=relaxed/simple;
	bh=M4IIrbotu7ndOHPMV+E1SasYoNuAXsOCWV48l3pM6Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL20X6b+fbSv4M+Jrbgx7ve0e/VbOzINLdWDT9W8roJf/oajyNI76DvnamLt3+UoyJt0whwyXgMY0ypTOMvO/nBrRskp+spJBcYHn8qa1VWeftBvO6pTTZqAklBdNMfJhkHVuO3RyWv9OZwE52AaiZxpCzS9Xq7DHHN+EAM6G2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X02GJN2p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQ/jkHmB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y9b00WzM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbiU2e/f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF0EC218F4;
	Wed, 28 May 2025 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748471558;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANK7uXmHIvTW0rjPfITtNAvJVW90qxG+kkwroveUN5w=;
	b=X02GJN2plguhvvVhUoRtbDdhWEm1SGNOty0KT3OzRaigQg8hDlYZaWifn9nf1THGAXi6s1
	yNH5o/xi/z/mh4c792lmYbcTMBXjj+85L8LhMBiKr6RE8d1t/Oz5citdDsC+pTwpRhloJI
	1F8Ho1Q3gG6gzrJgurYQZwgbF+/ggR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748471558;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANK7uXmHIvTW0rjPfITtNAvJVW90qxG+kkwroveUN5w=;
	b=iQ/jkHmBo3dNSdIQkJ62rAYNTY4Gc7TmQZfe3sWyJzTb+qv3Ag3/vL9vlFvhL/V3j+Fjxs
	GHAFBoLTqUa2pUBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y9b00WzM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="AbiU2e/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748471557;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANK7uXmHIvTW0rjPfITtNAvJVW90qxG+kkwroveUN5w=;
	b=Y9b00WzMQumFc8C9f58LCCcmz6NOBIWx0ZUImPbU7mkvfQZfqfc65rv7Vh4Qk7GSyB6++W
	UjdxdWXpKDNTQBbTNVygDstWL2wOmlnbU/IOjSJidNk9N3qd9myHxvXUXDbiMTnPrIgYNz
	lmrtETuBKEPEdI1TCmVyqequWCOfqdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748471557;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANK7uXmHIvTW0rjPfITtNAvJVW90qxG+kkwroveUN5w=;
	b=AbiU2e/fP8XguurtAUn3IvfNomD8vzTUXlyJliogB+ltRbvGV2M6fiqNkWddCffmGeDknq
	VQQBGZs8JCkn0oBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBA7B136E0;
	Wed, 28 May 2025 22:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oJWWLQWPN2gwUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 22:32:37 +0000
Date: Thu, 29 May 2025 00:32:36 +0200
From: David Sterba <dsterba@suse.cz>
To: Pan Chuang <panchuang@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, frank.li@vivo.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] btrfs: convert to use rb_find() and
 rb_find_add() helper
Message-ID: <20250528223236.GI4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250516030333.3758-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516030333.3758-1-panchuang@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DF0EC218F4
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, May 16, 2025 at 11:03:18AM +0800, Pan Chuang wrote:
> Based on patch v1, perform code style conversions such as function naming
> and commit message adjustments without changing the logic. Additionally,
> add patch 14 and patch 15.
> 
> Pan Chuang (2):
>   btrfs: pass struct rb_simple_node pointer directly in
>     rb_simple_insert()
>   btrfs: use rb_find_add() in rb_simple_insert()
> 
> Yangtao Li (13):
>   btrfs: use rb_find_add() in btrfs_insert_inode_defrag()
>   btrfs: use rb_find() in __btrfs_lookup_delayed_item()
>   btrfs: use rb_find() in ulist_rbtree_search()
>   btrfs: use rb_find_add() in ulist_rbtree_insert()
>   btrfs: use rb_find() in lookup_block_entry()
>   btrfs: use rb_find_add() in insert_block_entry()
>   btrfs: use rb_find() in lookup_root_entry()
>   btrfs: use rb_find_add() in insert_root_entry()
>   btrfs: use rb_find_add() in insert_ref_entry()
>   btrfs: use rb_find() in find_qgroup_rb()
>   btrfs: use rb_find_add() in add_qgroup_rb()
>   btrfs: use rb_find() in btrfs_qgroup_trace_subtree_after_cow()
>   btrfs: use rb_find_add() in btrfs_qgroup_add_swapped_blocks()

Thanks for the v2, the cleanups look good, I'll add them to for-next,
with a few coding style fixups.

