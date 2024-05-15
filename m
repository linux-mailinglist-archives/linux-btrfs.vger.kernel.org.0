Return-Path: <linux-btrfs+bounces-5020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA48C6C22
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27B71F21AF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85A158DD2;
	Wed, 15 May 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NqhhA6VZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TePVHyxb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NqhhA6VZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TePVHyxb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE8158DA0
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797722; cv=none; b=PFMfgkxRALPC0tey+gNOKn6WTFHtDF74ZMae1TmeqlYiO14NwPWRTRyJ1qj2W6DyAGDGzYvftcsGjze+SFou0nvWJyKSmDfeowE9e3Xyv4ZrVmCx8Fcj4pgT7k9ktrEl+yKFLEaHbtma71LkDgBvMjJGXytfq2WdCwB4vVbL744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797722; c=relaxed/simple;
	bh=YhxSLje3d7lb9zjXchuHUb3XHFwPcn/GebNqr36IliQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVXvxsezGtdYDlLJ4I9zEAU90Wi7KsgQq95PBQUf7srqOD9p638phP1uaAA9B2FTTI9MKrmADs/1/2UNtRpCoyCjmYeBqraq3CcexPUwTsDEbDxkG64dwH0l5W3HU/cjxP3HrXZfx+TmKbnpRYfvwxPFrTtZoyA8mghTC2V0OOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NqhhA6VZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TePVHyxb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NqhhA6VZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TePVHyxb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1688622768;
	Wed, 15 May 2024 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715797718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cg5QSegcGSrmsKzWEtUYM9LF7kif46MDumjknrU4uMo=;
	b=NqhhA6VZgrkX80mPnOWE2fhUZ3X7YuLdXDQLcmY2jObRi6qakFT6RZ2aUCGNyovfc0YFnK
	1FtbCtsxvqsBCJpC0RI0FoaXxDJNBUZqvyEwGyJziIazNTWdDnamwoYTWyteOI0FU/bxEa
	sVXt9N+FlGnNp22+6B9ez0/bN9EcebA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715797718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cg5QSegcGSrmsKzWEtUYM9LF7kif46MDumjknrU4uMo=;
	b=TePVHyxb/9vn7J+unVDyxqt2a7R6S2FcDImPV+hFYwTeS454GWCAL4sSnmWtnj45Cemn1E
	Lqm39uadbowI3wBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715797718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cg5QSegcGSrmsKzWEtUYM9LF7kif46MDumjknrU4uMo=;
	b=NqhhA6VZgrkX80mPnOWE2fhUZ3X7YuLdXDQLcmY2jObRi6qakFT6RZ2aUCGNyovfc0YFnK
	1FtbCtsxvqsBCJpC0RI0FoaXxDJNBUZqvyEwGyJziIazNTWdDnamwoYTWyteOI0FU/bxEa
	sVXt9N+FlGnNp22+6B9ez0/bN9EcebA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715797718;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cg5QSegcGSrmsKzWEtUYM9LF7kif46MDumjknrU4uMo=;
	b=TePVHyxb/9vn7J+unVDyxqt2a7R6S2FcDImPV+hFYwTeS454GWCAL4sSnmWtnj45Cemn1E
	Lqm39uadbowI3wBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1CEB1372E;
	Wed, 15 May 2024 18:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SRh9OtX+RGZQWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 18:28:37 +0000
Date: Wed, 15 May 2024 20:28:32 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/10] btrfs: inode management and memory consumption
 improvements
Message-ID: <20240515182832.GW4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715362104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715362104.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email]

On Fri, May 10, 2024 at 06:32:48PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some inode related improvements, to use an xarray to track open inodes per
> root instead of a red black tree, reduce lock contention and use less memory
> per btrfs inode, so now we can fit 4 inodes per 4K page instead of 3.
> More details in the change logs.
> 
> V2: Added two more patches (9/10 and 10/10) to make sure btrfs_inode size
>     is reduced to 1024 bytes when CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY
>     are set. I wasn't using these configs before, and with them the final
>     size for btrfs_inode was 1032 bytes and not 1016 bytes as I initially
>     had - now the final size is 1024 bytes with those configs enabled.
> 
> Filipe Manana (10):
>   btrfs: use an xarray to track open inodes in a root
>   btrfs: preallocate inodes xarray entry to avoid transaction abort
>   btrfs: reduce nesting and deduplicate error handling at btrfs_iget_path()
>   btrfs: remove inode_lock from struct btrfs_root and use xarray locks
>   btrfs: unify index_cnt and csum_bytes from struct btrfs_inode
>   btrfs: don't allocate file extent tree for non regular files
>   btrfs: remove location key from struct btrfs_inode
>   btrfs: remove objectid from struct btrfs_inode on 64 bits platforms
>   btrfs: rename rb_root member of extent_map_tree from map to root
>   btrfs: use a regular rb_root instead of cached rb_root for extent_map_tree

Reviewed-by: David Sterba <dsterba@suse.com>

