Return-Path: <linux-btrfs+bounces-14785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E44AE076E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 15:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95393B9FF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CD2638A3;
	Thu, 19 Jun 2025 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vSFLOXHM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LdlQBs0K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vSFLOXHM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LdlQBs0K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217C25A338
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339772; cv=none; b=dVigQiVePBdG+J8CDm6li+fGLrPB+eI5/3vdiQ9vgpUCjQGSVKRZTVzDU5x45jcJ6ulIUFka05Uy49yCdTAWhQSSy5mlft/F8fIXwI8NgIirvgYfGBCq48SoCgeoY5BerpMy4LwgaKNaiAcyL7VBopjtg1DsmLRgzII7fb362Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339772; c=relaxed/simple;
	bh=KbhkjdNKThDLeCRbyNqLKROxsK9iPYQcBQqnOaqH3Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhFmJPXu5OQ64hDkyQIYCG0vpo6YTCHmGT7lO//Mh/fcQHRyGPq8WxaPtthFUC0SIKNGt7f3HjgOwgjATFzhufqbVvqEiAsiOmRE7feYjIdNe+0Exf2I7oWI1+bdizyC+sT5hZ0w8zAEMCsvFq+gBYNdi62+DFaUa3UOpWpqS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vSFLOXHM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LdlQBs0K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vSFLOXHM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LdlQBs0K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 975B61F38D;
	Thu, 19 Jun 2025 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750339768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgGWsqjdS2umkCC5hzGmMuGY/fi65tUam0NGNx7iWgw=;
	b=vSFLOXHMVHUApC4PvvgOfmVYC4S+YaYj0w0fq94d84E0kt8sxwDr7w88qNP9nBV/6jtrBF
	Em6T7j0szEHaiv0IGBNZKDv4xgL+XAx2T3q8TcnuTOPuevFF6EUzXuN3XyDAmttSFrHebt
	/13nOsL0sig6IiYvTo1kDXFwgGJAEO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750339768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgGWsqjdS2umkCC5hzGmMuGY/fi65tUam0NGNx7iWgw=;
	b=LdlQBs0KLCghebG/XLZw5UFISDjQx6EP2r7dfxtdXbcdlD+AUdt5qP7qFTqYK8+qMxLI4V
	Fwf5DFQ1liIMOiDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750339768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgGWsqjdS2umkCC5hzGmMuGY/fi65tUam0NGNx7iWgw=;
	b=vSFLOXHMVHUApC4PvvgOfmVYC4S+YaYj0w0fq94d84E0kt8sxwDr7w88qNP9nBV/6jtrBF
	Em6T7j0szEHaiv0IGBNZKDv4xgL+XAx2T3q8TcnuTOPuevFF6EUzXuN3XyDAmttSFrHebt
	/13nOsL0sig6IiYvTo1kDXFwgGJAEO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750339768;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgGWsqjdS2umkCC5hzGmMuGY/fi65tUam0NGNx7iWgw=;
	b=LdlQBs0KLCghebG/XLZw5UFISDjQx6EP2r7dfxtdXbcdlD+AUdt5qP7qFTqYK8+qMxLI4V
	Fwf5DFQ1liIMOiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 870C113721;
	Thu, 19 Jun 2025 13:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DSDBILgQVGguEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Jun 2025 13:29:28 +0000
Date: Thu, 19 Jun 2025 15:29:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/6] btrfs: use the super_block as bdev holder
Message-ID: <20250619132918.GK4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750137547.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750137547.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Tue, Jun 17, 2025 at 02:49:33PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v3:
> - Drop the btrfs_fs_devices::opened split
>   It turns out to cause problems during tests.
> 
> - Extra cleanup related to the btrfs_get_tree_*()
>   Now the re-entry through vfs_get_tree() is completely dropped.
> 
> - Extra comments explaining the sget_fc() behavior
> 
> - Call bdev_fput() instead of fput()
>   This alignes us to all the other fses.
> 
> - Updated patch to delay btrfs_open_devices() until sget_fc()
>   Instead of relying on the previous solution (split
>   btrfs_open_devices::opened), just expand the uuid_mutex critical
>   section.

I've added the patches to linux-next for testing.

