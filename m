Return-Path: <linux-btrfs+bounces-8082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0297B15E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080A9281B3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81417967F;
	Tue, 17 Sep 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYgDFZhd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7GcMDwb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AYgDFZhd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7GcMDwb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FC176228
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726582764; cv=none; b=Fr42932E8HIQZSPfbpLgnF2HAvR4SMNqeZZBhrB9D48uLd7pPHl0jSFAyNdqmlcBb7e9DJRRvXIQOdQQT4r/Fw1Af9VU03LCNJTleCvFOjQLybYWyapx1SjomxDMC6+bag4L4VALazPRx+wkcj3Nuhw02PS6t5jSUVjBDE6yIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726582764; c=relaxed/simple;
	bh=WofNdAalk4ygxtw84Pu0TzZTbwomzlfYFy5TqNBAeCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgyNbbcHfScvHE/zPqe2Wj4IA0k5hthE92MGy3jdEe6J1CMJ0xp8GrhZlpLXZwucGKmu8f5OXjazyiBmJLl5WWpai0LMmufTymQG/19Pa3DKc7JjJih1tadq5+m7q7nvuIhmuVly0qRqtHw6TiVEk7URc8fllsxPBqIY5CdQ8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYgDFZhd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7GcMDwb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AYgDFZhd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7GcMDwb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 914A722287;
	Tue, 17 Sep 2024 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726582760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nROhScpLz5RbvUzyunOijkuD62SIG98M0BZBztkDM0c=;
	b=AYgDFZhdriheA4HAVBEDeVPLujY20XwB54Sd4Mrz17wRaZbEDFSbqIqO9yVvGdBbBmYlYz
	hY3NADwPgJcUIxmndf42HViNBopw+ho/sa5KSqRc7BfZHlFkyzPsMfPcKDk5U5WXutZBS2
	JsnSQ2tjTczJ1fpIAJRtnp6gjg2zNwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726582760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nROhScpLz5RbvUzyunOijkuD62SIG98M0BZBztkDM0c=;
	b=s7GcMDwbvTNRflSWk6yk9NG6PemouGNvbSynjyzdl1+rKvXj81I07oE3uP9aLKoXW7bQ9K
	aJJFwq3hq+IGwhBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726582760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nROhScpLz5RbvUzyunOijkuD62SIG98M0BZBztkDM0c=;
	b=AYgDFZhdriheA4HAVBEDeVPLujY20XwB54Sd4Mrz17wRaZbEDFSbqIqO9yVvGdBbBmYlYz
	hY3NADwPgJcUIxmndf42HViNBopw+ho/sa5KSqRc7BfZHlFkyzPsMfPcKDk5U5WXutZBS2
	JsnSQ2tjTczJ1fpIAJRtnp6gjg2zNwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726582760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nROhScpLz5RbvUzyunOijkuD62SIG98M0BZBztkDM0c=;
	b=s7GcMDwbvTNRflSWk6yk9NG6PemouGNvbSynjyzdl1+rKvXj81I07oE3uP9aLKoXW7bQ9K
	aJJFwq3hq+IGwhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71E2413AB6;
	Tue, 17 Sep 2024 14:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qc2SG+iP6WZhPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 14:19:20 +0000
Date: Tue, 17 Sep 2024 16:19:19 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: map-logical: fix search miss when extent is
 the first in a leaf
Message-ID: <20240917141918.GA2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <dd34707ffd1cd5a458980a209cfcc06a1817b848.1726149878.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd34707ffd1cd5a458980a209cfcc06a1817b848.1726149878.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Sep 12, 2024 at 03:05:44PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When searching the extent tree for the target extent item, we can miss it
> if the extent item is the first item in a leaf and if there is a previous
> leaf in the extent tree.
> 
> For example, if we call btrfs-map-logical like this:
> 
>    $ btrfs-map-logical -l 5382144 /dev/sdc
> 
> And we have the following extent tree layout:
> 
>    leaf 5386240 items 26 free space 2505 generation 7 owner EXTENT_TREE
>    leaf 5386240 flags 0x1(WRITTEN) backref revision 1
>    (...)
>            item 25 key (5373952 METADATA_ITEM 0) itemoff 3155 itemsize 33
>                    refs 1 gen 7 flags TREE_BLOCK
>                    tree block skinny level 0
>                    (176 0x5) tree block backref root FS_TREE
> 
>    leaf 5480448 items 56 free space 276 generation 7 owner EXTENT_TREE
>    leaf 5480448 flags 0x1(WRITTEN) backref revision 1
>    (...)
>            item 0 key (5382144 METADATA_ITEM 0) itemoff 3962 itemsize 33
>                    refs 1 gen 7 flags TREE_BLOCK
>                    tree block skinny level 0
>                    (176 0x7) tree block backref root CSUM_TREE
>    (...)
> 
> Then the following happens:
> 
> 1) We enter map_one_extent() with search_forward == 0 and
>    *logical_ret == 5382144;
> 
> 2) We search for the key (5382144 0 0) which leaves us with a path
>    pointing to leaf 5386240 at slot 26 - one slot beyond the last item;
> 
> 3) We then call:
> 
>      btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0])
> 
>    Which is not valid since there's no item at that slot, but since the
>    area of the leaf where an item at that slot should be is zeroed out,
>    we end up getting a key of (0 0 0);
> 
> 4) We then enter the "if" statement bellow, since key.type is 0, and call
>    btrfs_previous_extent_item(), which leaves at slot 25 of leaf 5386240,
>    point to the extent item of the extent 5373952.
> 
>    The requested extent, 5382144, is the first item of the next leaf
>    (5480448), but we totally miss it;
> 
> 5) We return to the caller, the main() function, with 'cur_logical'
>    pointing to the metadata extent at 5373952, and not to the requested
>    one at 5382144.
> 
>    In the last while loop of main() we have 'cur_logical' == 5373952,
>    which makes the loop have no iterations and therefore the local
>    variable 'found' remans with a value of 0, and then the program fails
>    like this:
> 
>    $ btrfs-map-logical -l 5382144 /dev/sdc
>    ERROR: no extent found at range [5382144,5386240)
> 
> Fix this by never accessing beyond the last slot of a leaf. If we ever end
> up at a slot beyond the last item in a leaf, just call btrfs_next_leaf()
> and process the first item in the returned path.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to devel, thanks.

