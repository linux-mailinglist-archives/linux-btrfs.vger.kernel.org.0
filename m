Return-Path: <linux-btrfs+bounces-10643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E579FB4D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 20:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF860165C57
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005D1C5F25;
	Mon, 23 Dec 2024 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpDzCKH0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BiD+aYg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpDzCKH0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BiD+aYg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308718A921
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983710; cv=none; b=Ak8fjabaKqWMQ92z7gz6CelH1aN7h2QVfFK8qt4TQatjyCfD3NCojcw4yukSr6d1nyvc/JTmu5EtMh6uZ/xa68xXETI9o9DOC0P9H5DQPeSMxbtgS35NedMciHpLsdpUH/7tutYdO64tno4wK/2Mxuy4LdoB2C0h3/NhTxbgeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983710; c=relaxed/simple;
	bh=rAiEm2hQ5tcAjbqgfMV0NG7RYItGCxYhysuHhDBIaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP3axi5r5s0RAvL7RvvUCL6EyzVZm/dE7J+Udwu/fD81EYfvVRzmfSJLIonHcy1p84s5EBSDJQ3V9fQDhQ01P24GmviVcsFqKXRa/g6MLQ6H60sTo7njYtXIIOpZHFWtSsAKlugWQc8/VQgTnIONp/8byyeaQJKnHxO6kos3vGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpDzCKH0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BiD+aYg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpDzCKH0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BiD+aYg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99C9C1F38C;
	Mon, 23 Dec 2024 19:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734983700;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vJzc73kJBC+klicIht8jSi9R9zUc4Y8gx+kvqp0XwQ=;
	b=rpDzCKH0pOvb/ccQqmWxvlhhLmHPL7iELR1dixAKiY9qD77Mr2TEuCyszgCxyJS2SqJp0X
	70QC82RC4gaRNLoin47VKhpjADY7b4py7WZLLKHHlBY11NKEMnWBacE2fe8W910hNYocX9
	fj32TY1bILP2Zk7P6uCvQbDJO2HzO8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734983700;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vJzc73kJBC+klicIht8jSi9R9zUc4Y8gx+kvqp0XwQ=;
	b=1BiD+aYgsdnaWoPnfw2hHMrQFJLF/5zJ2psaDw3cdIfs/gLjEOCDMfGBJmBiudJ9LMKPcs
	dECMWCykMZ+PTtBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rpDzCKH0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1BiD+aYg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734983700;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vJzc73kJBC+klicIht8jSi9R9zUc4Y8gx+kvqp0XwQ=;
	b=rpDzCKH0pOvb/ccQqmWxvlhhLmHPL7iELR1dixAKiY9qD77Mr2TEuCyszgCxyJS2SqJp0X
	70QC82RC4gaRNLoin47VKhpjADY7b4py7WZLLKHHlBY11NKEMnWBacE2fe8W910hNYocX9
	fj32TY1bILP2Zk7P6uCvQbDJO2HzO8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734983700;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vJzc73kJBC+klicIht8jSi9R9zUc4Y8gx+kvqp0XwQ=;
	b=1BiD+aYgsdnaWoPnfw2hHMrQFJLF/5zJ2psaDw3cdIfs/gLjEOCDMfGBJmBiudJ9LMKPcs
	dECMWCykMZ+PTtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DBB3137DA;
	Mon, 23 Dec 2024 19:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zahGGhTAaWcedAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Dec 2024 19:55:00 +0000
Date: Mon, 23 Dec 2024 20:54:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/6] reduce boilerplate code within btrfs
Message-ID: <20241223195451.GM31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734472236.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734472236.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 99C9C1F38C
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Dec 18, 2024 at 08:28:49AM +1030, Qu Wenruo wrote:
> [Changelog]
> v3:
> - Fix the error handling in the 2nd patch
> 
> - Fix the backref walk failure
>   There are two bugs in the 3rd patch:
>   * Bad parent/ref pointer update
>     Which only get updated once at the beginning, meanwhile they should
>     be updated only when we found an existing node.
>   * Order change for prelim_ref
>     The prelim_ref_compare() require the first parameter to be the
>     existing ref, and the second parameter to be the new one.
>     This is different from the new rb_find_add_cached() order
>   Fix both and remove unnecessary variables.
> 
> - Add named parameters for cmp() function used in rb_find_add_cached()
>   To give a more explicit distinguish on which one should be the newer
>   node and which should be the existing node.
>   This should reduce the confusion on the order.
> 
> - Unify the parameters for cmp() functions
>   And all internal entry structure will have corresponding "new_/exist_"
>   prefix.
> 
> - Make all parameters of cmp() to be const
> 
> v2: By Roger L
> - Fix error handing in the 2nd patch
>   Which is still not done correctly
> 
> - Add Acked-by tag from Peter
> 
> The goal of this patch series is to reduce boilerplate code
> within btrfs. To accomplish this rb_find_add_cached() was added
> to linux/include/rbtree.h. Any replaceable functions were then 
> replaced within btrfs.
> 
> changelog: 
> updated if() statements to utilize newer error checking
> resolved lock error on 0002
> edited title of patches to utilize update instead of edit
> added Acked-by from Peter Zijlstra to 0001
> eliminated extra variables throughout the patch series
> 
> Roger L. Beckermeyer III (6):
>   rbtree: add rb_find_add_cached() to rbtree.h
>   btrfs: update btrfs_add_block_group_cache() to use rb helper
>   btrfs: update prelim_ref_insert() to use rb helpers
>   btrfs: update __btrfs_add_delayed_item() to use rb helper
>   btrfs: update btrfs_add_chunk_map() to use rb helpers
>   btrfs: update tree_insert() to use rb helpers

Reviewed-by: David Sterba <dsterba@suse.com>

