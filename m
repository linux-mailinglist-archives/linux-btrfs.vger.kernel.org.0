Return-Path: <linux-btrfs+bounces-16125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D5B2AC68
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82EE196420E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E227022157F;
	Mon, 18 Aug 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfoX3AMK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+rfiYe/E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfoX3AMK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+rfiYe/E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9623496F
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529983; cv=none; b=H0Gaeuw1ENLEaZE4MlLz7uGa8Y5DLTwsERsEeIRiU3w8nNImqYLWFx6VEzL6FVgGn7ajDRVC/tRpOr1EDKNvwE3ROFjyfTalnqs/0ISFqjd756Dm9YEL5NLIOwlwetO1cncqRAN7N7MXZa+lKFFf2C8ePkEby0uxeO4d7Kp3zAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529983; c=relaxed/simple;
	bh=NmgL5z75kS+y0DPRBsnFCV8hLRfYvA+FUneCVmFBJCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdyO0pfveDKgPwG/1AGIErP3oxA2wzw2TDApt5khyPJBPvWswskl/8LQ63esW59W0jp+dvZSyzV6JMokGRDEt7htb1dR1rIpfGtbku4R12AHGBAGEJzj/LZkKZhQ1mTUZrfv/BVhp5U0gmZ949BcXbaMtilsQIwbVI8w+3RRUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfoX3AMK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+rfiYe/E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfoX3AMK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+rfiYe/E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D47BF211F8;
	Mon, 18 Aug 2025 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755529979;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FDZXnfdjyPxNyXHe+vCUAq5gJB3TqMF3Z+Ofv8msGs=;
	b=BfoX3AMKVeVBmzXLsr2HWhgTxeOHnuUHOy70NbulcDmScVNH4SVkkwO0JgVWf3IXPiSj0P
	8Y6HdutbS1SSJMH8cdW/jZ7sKqsSLCtVp5LabP2zQJ+enOX3gijVkG9IWRPOtFnBGqXkhx
	V6repD0d/nIVIDoYF2EiyNjyJHV/kJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755529979;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FDZXnfdjyPxNyXHe+vCUAq5gJB3TqMF3Z+Ofv8msGs=;
	b=+rfiYe/EmQpOZe6fMy483+t0fmkh4sZ2zlcfYrL+4Fjeqo8ZK91Tg4N4OI7FRCIrd7wEE9
	gEXZ2h2e0+TQdhDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755529979;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FDZXnfdjyPxNyXHe+vCUAq5gJB3TqMF3Z+Ofv8msGs=;
	b=BfoX3AMKVeVBmzXLsr2HWhgTxeOHnuUHOy70NbulcDmScVNH4SVkkwO0JgVWf3IXPiSj0P
	8Y6HdutbS1SSJMH8cdW/jZ7sKqsSLCtVp5LabP2zQJ+enOX3gijVkG9IWRPOtFnBGqXkhx
	V6repD0d/nIVIDoYF2EiyNjyJHV/kJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755529979;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FDZXnfdjyPxNyXHe+vCUAq5gJB3TqMF3Z+Ofv8msGs=;
	b=+rfiYe/EmQpOZe6fMy483+t0fmkh4sZ2zlcfYrL+4Fjeqo8ZK91Tg4N4OI7FRCIrd7wEE9
	gEXZ2h2e0+TQdhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA70A13686;
	Mon, 18 Aug 2025 15:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a7hTLftCo2gNLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Aug 2025 15:12:59 +0000
Date: Mon, 18 Aug 2025 17:12:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/7] btrfs: add generic workspace manager initialization
Message-ID: <20250818151258.GM22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755148754.git.wqu@suse.com>
 <d388ffd7cff17a0e6e62b7d24d218ec198efa010.1755148754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d388ffd7cff17a0e6e62b7d24d218ec198efa010.1755148754.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Thu, Aug 14, 2025 at 03:03:22PM +0930, Qu Wenruo wrote:
> This involves:
> 
> - Add generic_(alloc|free)_workspace_manager helpers.
>   These are the helper to alloc/free workspace_manager structure, which
>   will allocate a workspace_manager structure, initialize it, and
>   pre-allocate one workspace for it.
> 
> - Call generic_alloc_workspace_manager() inside
>   btrfs_alloc_compress_wsm()
>   For none, zlib and lzo compression algorithms.
> 
> - Call generic_alloc_workspace_manager() inside
>   btrfs_free_compress_wsm()
>   For none, zlib and lzo compression algorithms.
> 
> For now the generic per-fs workspace managers won't really have any effect,
> and all compression is still going through the global workspace manager.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 0ee8a17abc30..8a7b2b802ddd 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -773,6 +773,40 @@ static void free_workspace(int type, struct list_head *ws)
>  	}
>  }
>  
> +static int generic_alloc_workspace_manager(struct btrfs_fs_info *fs_info,
> +					   enum btrfs_compression_type type)

The helpers are static so you may drop the "generic_" prefix, we have
other unprefixed helpers like alloc_workspace etc.

