Return-Path: <linux-btrfs+bounces-9337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FC9BD3BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB90E1F219DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D451E765B;
	Tue,  5 Nov 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FVAH3M2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0hx/sYw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FVAH3M2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0hx/sYw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799F84D02
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828985; cv=none; b=ILGXS2WtMocERv1P3I+6khn+h15Qe/qtLJliAcIgT2A1w4yrICZil/SfpJp0ozy83NzHtkYubMlwTS38a7vyo/Kq6R+rj7aSIpbVhVIBuKj7KhSgpPoB5NZpl6eO8GBrcf5/lJzn/S15AKuDkG+voayac81X78B3qnwdoEh5K5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828985; c=relaxed/simple;
	bh=Cr9KDEprzzom7QKYNvK8Sw0L+MwafHziI5gW1F474Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVey02DUNVd+OXLT5qJv4jNfX8u/jQgdcPgaAbJ0q6NfEdRE3LhrLRLkJAWF/Rl9i+/U/OuPub2bvGYiFzOumr6PNLVinJ2AeX88ItVET+dP7WMvjjuFSV76aJxMntag42xbX1WVuXrK3udG5Ve7DU13vLr22MVBY5scs/LXgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FVAH3M2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0hx/sYw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FVAH3M2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0hx/sYw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4129521A98;
	Tue,  5 Nov 2024 17:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730828982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pz/E/WofUvpgBMvsQ2Zx6C+ptxgWlx3FyFStc1X8/MY=;
	b=FVAH3M2HRc8YyKAxNIeb+ED8vzFglGj4p2oi3XeVSnOttauTRUeoLI/DsG16IqfOVNblfq
	49JMu/jzpWvQOEdDHL4rY10cyRxHCNYo4KliJJ2ktNLLkk5D26KgWg2YVBN+/PaRzOFJNC
	mx0422grznzN87yLjEAklOKYss6PXco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730828982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pz/E/WofUvpgBMvsQ2Zx6C+ptxgWlx3FyFStc1X8/MY=;
	b=Y0hx/sYwPMbEaYAgwVlZ2yeMA7a5a6jmRAdAUqE80Ofr3RlRS8XPLFDDOfkx3rf5oENwE5
	A4qcij0PMJHwT8BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730828982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pz/E/WofUvpgBMvsQ2Zx6C+ptxgWlx3FyFStc1X8/MY=;
	b=FVAH3M2HRc8YyKAxNIeb+ED8vzFglGj4p2oi3XeVSnOttauTRUeoLI/DsG16IqfOVNblfq
	49JMu/jzpWvQOEdDHL4rY10cyRxHCNYo4KliJJ2ktNLLkk5D26KgWg2YVBN+/PaRzOFJNC
	mx0422grznzN87yLjEAklOKYss6PXco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730828982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pz/E/WofUvpgBMvsQ2Zx6C+ptxgWlx3FyFStc1X8/MY=;
	b=Y0hx/sYwPMbEaYAgwVlZ2yeMA7a5a6jmRAdAUqE80Ofr3RlRS8XPLFDDOfkx3rf5oENwE5
	A4qcij0PMJHwT8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19A021394A;
	Tue,  5 Nov 2024 17:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ++qrBbZaKmf1YQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 05 Nov 2024 17:49:42 +0000
Date: Tue, 5 Nov 2024 18:49:40 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove hole from struct btrfs_delayed_node
Message-ID: <20241105174940.GC31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <008db737b88fdf9993be37ff44edc89e31a3677a.1730808362.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008db737b88fdf9993be37ff44edc89e31a3677a.1730808362.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Nov 05, 2024 at 12:08:49PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> On x86_64 and a release kernel, there's a 4 bytes hole in the structure
> after the ref count field:
> 
>   struct btrfs_delayed_node {
>           u64                        inode_id;             /*     0     8 */
>           u64                        bytes_reserved;       /*     8     8 */
>           struct btrfs_root *        root;                 /*    16     8 */
>           struct list_head           n_list;               /*    24    16 */
>           struct list_head           p_list;               /*    40    16 */
>           struct rb_root_cached      ins_root;             /*    56    16 */
>           /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>           struct rb_root_cached      del_root;             /*    72    16 */
>           struct mutex               mutex;                /*    88    32 */
>           struct btrfs_inode_item    inode_item;           /*   120   160 */
>           /* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- */
>           refcount_t                 refs;                 /*   280     4 */
> 
>           /* XXX 4 bytes hole, try to pack */
> 
>           u64                        index_cnt;            /*   288     8 */
>           long unsigned int          flags;                /*   296     8 */
>           int                        count;                /*   304     4 */
>           u32                        curr_index_batch_size; /*   308     4 */
>           u32                        index_item_leaves;    /*   312     4 */
> 
>           /* size: 320, cachelines: 5, members: 15 */
>           /* sum members: 312, holes: 1, sum holes: 4 */
>           /* padding: 4 */
>   };
> 
> Move the 'count' field, which is 4 bytes long, to just below the ref count
> field, so we eliminate the hole and reduce the structure size from 320
> bytes down to 312 bytes:
> 
>   struct btrfs_delayed_node {
>           u64                        inode_id;             /*     0     8 */
>           u64                        bytes_reserved;       /*     8     8 */
>           struct btrfs_root *        root;                 /*    16     8 */
>           struct list_head           n_list;               /*    24    16 */
>           struct list_head           p_list;               /*    40    16 */
>           struct rb_root_cached      ins_root;             /*    56    16 */
>           /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>           struct rb_root_cached      del_root;             /*    72    16 */
>           struct mutex               mutex;                /*    88    32 */
>           struct btrfs_inode_item    inode_item;           /*   120   160 */
>           /* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- */
>           refcount_t                 refs;                 /*   280     4 */
>           int                        count;                /*   284     4 */
>           u64                        index_cnt;            /*   288     8 */
>           long unsigned int          flags;                /*   296     8 */
>           u32                        curr_index_batch_size; /*   304     4 */
>           u32                        index_item_leaves;    /*   308     4 */
> 
>           /* size: 312, cachelines: 5, members: 15 */
>           /* last cacheline: 56 bytes */
>   };
> 
> This now allows to have 13 delayed nodes per 4K page instead of 12.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

