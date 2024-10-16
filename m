Return-Path: <linux-btrfs+bounces-8967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC379A0F0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6B21C22AE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A320F5CB;
	Wed, 16 Oct 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iki50YnI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NYxOC63V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sS0iFRrs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zIkJqlgH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0F20F5BD
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093796; cv=none; b=WkSpP4bYviPh8r6lrMZKfEEmJFG5cPEp8uk7xg3DTMkbD5FeXic7fOqyRyL+XpJ5xqEmhkV6Y014CDZNPVyo+BmNQF552aGZGUG0EBbKbiDjbrMy20k7SFPkSysNxPBEpF12KiVX1H1U0EGXpigs4Lt+VtHUC/2PhrJiK/R+FZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093796; c=relaxed/simple;
	bh=ozMswQpw73nppenD0NfEF24EfsroWtik5jYGGmw4/Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J12M1NofDmvfY4FDrBF1w3quJv1anSooyYtbmPdhN2GuvhoUTGz9LKaQNr3nsQDTttGv/4hjTOIKAg1W3YS+1Y5HHJ0Xy3xKmDJC8KR0A7KrQriv3ecmiWNApXWqnBPOt3uhRDaGpDeAudKOQM/Sxox1YXdBhx+9kqXgatnX/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iki50YnI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NYxOC63V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sS0iFRrs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zIkJqlgH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAD6621B93;
	Wed, 16 Oct 2024 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729093793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BlPoEeJ/JlLOBxXfdspwN7F7Z2atBKV/Wujt9qSJ2WQ=;
	b=iki50YnIuLbCQo2PdIzZUZnBROh3a5S1b5fC0Xlx3zLQw0U1VvDapsB7mY7SxmjiHA2lsy
	xNXH6YBdLptIho6okoxJsqK6flFE2bh3UuW9fk6bgBgt9tC+bQ+BWx6onhtSsgf8tr3zPk
	Wo5oLaSmLx7sJPJre0RC9i1aIfPUayE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729093793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BlPoEeJ/JlLOBxXfdspwN7F7Z2atBKV/Wujt9qSJ2WQ=;
	b=NYxOC63VbfnjlHjA3hQr12t45JMDCd90yb9+aOlU84thsxmKntEdYvEh3+qxSHohFelkGw
	irffAz/+HXwa+RDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729093792;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BlPoEeJ/JlLOBxXfdspwN7F7Z2atBKV/Wujt9qSJ2WQ=;
	b=sS0iFRrsszziNWnEd9wmlXhAGoVjBJicARbV6NoDWBi1t/bAUZ7thGvUr8nrjdboowwmUi
	PWGVk1x7AdXRH+/ezNdNFNQxuBHzl4qwOMKZYWVOxMbrduOqsJiCMjugmJQtzhBow1ooyk
	V5df79B4vwxkcnPrQ27LjFxkxQuFbrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729093792;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BlPoEeJ/JlLOBxXfdspwN7F7Z2atBKV/Wujt9qSJ2WQ=;
	b=zIkJqlgHFmvTv1LL/oh82wVnNLwzA9VnAI/VfpaH/ZM8seW0cTP0uiakws29WBHqMcpTty
	q1EGlB3QgX6lKEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D14DE1376C;
	Wed, 16 Oct 2024 15:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7evhMqDgD2fUNwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Oct 2024 15:49:52 +0000
Date: Wed, 16 Oct 2024 17:49:51 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: remove redundant initialization from
 btrfs_readahead_tree_block()
Message-ID: <20241016154951.GR1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1729075703.git.fdmanana@suse.com>
 <22e345124a6e35e4dbc07e9564475b5c97b37a41.1729075703.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e345124a6e35e4dbc07e9564475b5c97b37a41.1729075703.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Oct 16, 2024 at 03:20:22PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's pointless to initialize the has_first_key field of the stack local
> btrfs_tree_parent_check structure since it all fields not explicitly
> initialized are zeroed out, plus it's a bit odd because the field is
> of type bool and we are assigning 0 instead of false to it (however it's
> not incorrect since 0 is converted to false). Just remove the explicit
> initialization due to its redundancy.

Makes sense, I've noticed there's one more to remove from
btrfs_qgroup_trace_subtree() you can squash it to this patch too.

