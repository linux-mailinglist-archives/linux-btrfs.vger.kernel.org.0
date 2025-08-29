Return-Path: <linux-btrfs+bounces-16520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E875B3B0A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 03:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8FF1C8638D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565FB1FFC46;
	Fri, 29 Aug 2025 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yvM2fhup";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCXIM4gw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yvM2fhup";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCXIM4gw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A11E1C1A
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432373; cv=none; b=a1IoYgaQOFe6CdvriqqtcF27Nh6neePwkPuxdlm9Iex8D8zzj/A0X+/M2vlR99U7V5CjRZsRqZTyzzKnnkgxt6VinYh6lehOQ3FCTzuW1dvcggIzGwUHl/+YlQNZXR78C5XQNm/1jo5BDSQwAtAd67n3/EsiN5+IHuUEadRXm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432373; c=relaxed/simple;
	bh=pMia6vI4WbSIqbW0nAYVCHR+yaY2mf5GDQGSNt/EEmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B48kc05xno0lKG2mpLRjf+pz691D/U3eY37OXWPXSh+kFgaGF9DXLK0TE07540huZJynaBFyssz6ou5KZv6y1RHDEiSiFIT6Bx9V5iNIgSRycxfnJ1AcLWGEhCeffixDWcRspL6OdUvT02joaMA9b55zlCF/Fv1FI+acRCH213A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yvM2fhup; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCXIM4gw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yvM2fhup; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCXIM4gw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15DC933A80;
	Fri, 29 Aug 2025 01:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756432369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5PjV1QuRgaFx0hIiX2Widzl5+PIyq+xRHTpwMuiIVg=;
	b=yvM2fhup4rBkZcITx5B+l6Aj3FXyJw4oxIsu3au2HfR1WSnCAswugdHO1SoviztjZYfx/6
	HbclGBBd25M/K80U0f3GAMZ2fh3U6iwCKVjosqLjQMoiPT9GUJgIqJNvXOmdjnAjLCPgoV
	YpVCaEq93eb+H+UhOGw0sPFelO1SuRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756432369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5PjV1QuRgaFx0hIiX2Widzl5+PIyq+xRHTpwMuiIVg=;
	b=BCXIM4gwGM9NlgtoMDV+uaSe5/qq1Ysi47ADNXsSJHjYTRQUdzN2FTx10XPimgLzEbFKRq
	oFQccs21R/F7QvAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756432369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5PjV1QuRgaFx0hIiX2Widzl5+PIyq+xRHTpwMuiIVg=;
	b=yvM2fhup4rBkZcITx5B+l6Aj3FXyJw4oxIsu3au2HfR1WSnCAswugdHO1SoviztjZYfx/6
	HbclGBBd25M/K80U0f3GAMZ2fh3U6iwCKVjosqLjQMoiPT9GUJgIqJNvXOmdjnAjLCPgoV
	YpVCaEq93eb+H+UhOGw0sPFelO1SuRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756432369;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5PjV1QuRgaFx0hIiX2Widzl5+PIyq+xRHTpwMuiIVg=;
	b=BCXIM4gwGM9NlgtoMDV+uaSe5/qq1Ysi47ADNXsSJHjYTRQUdzN2FTx10XPimgLzEbFKRq
	oFQccs21R/F7QvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9B9613310;
	Fri, 29 Aug 2025 01:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hpziOPAHsWg0EQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Aug 2025 01:52:48 +0000
Date: Fri, 29 Aug 2025 03:52:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	willy@infradead.org, mhocko@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v4 0/3] introduce kernel file mapped folios
Message-ID: <20250829015247.GJ29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1755812945.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755812945.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Thu, Aug 21, 2025 at 02:55:34PM -0700, Boris Burkov wrote:
> I would like to revisit Qu's proposal to not charge btrfs extent_buffer
> allocations to the user's cgroup.
> 
> https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> 
> I believe it is detrimental to account these global pages to the cgroup
> using them, basically at random. A bit more justification and explanation
> in the patches themselves.
> 
> ---
> Changelog:
> v4:
> - change the concept from "uncharged" to "kernel_file"
> - no longer violates the invariant that each mapped folio has a memcg
>   when CONFIG_MEMCG=y
> - no longer really tied to memcg conceptually, so simplify build/helpers
> v3:
> - use mod_node_page_state since we will never count cgroup stats
> - include Shakeel's patch that removes a WARNING triggered by this series
> v2:
> - switch from filemap_add_folio_nocharge() to AS_UNCHARGED on the
>   address_space.
> - fix an interrupt safety bug in the vmstat patch.
> - fix some foolish build errors for CONFIG_MEMCG=n
> 
> 
> 
> Boris Burkov (3):
>   mm/filemap: add AS_KERNEL_FILE
>   mm: add vmstat for kernel_file pages
>   btrfs: set AS_KERNEL_FILE on the btree_inode
> 
>  fs/btrfs/disk-io.c      |  1 +
>  include/linux/mmzone.h  |  1 +
>  include/linux/pagemap.h |  2 ++
>  mm/filemap.c            | 13 +++++++++++++
>  mm/vmstat.c             |  1 +

For the btrfs parts,

Acked-by: David Sterba <dsterba@suse.com>

