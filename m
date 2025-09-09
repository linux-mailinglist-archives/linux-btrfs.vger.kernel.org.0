Return-Path: <linux-btrfs+bounces-16735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4726CB49E5A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 02:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488021B24EF1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F520DD72;
	Tue,  9 Sep 2025 00:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2CIvega";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CjS3lUef";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2CIvega";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CjS3lUef"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1052E41E
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379319; cv=none; b=K+cz7rqPrCvxcDL9Ssx2iC/E0gOmYEXE0n921otsAyjLkf7Pd4mJSFSoXzss2jw0U77/51xpePqJuocho8kCvr5KNaorx8BnHHU4PC3HbvImHHDjcBdoMkPcYqXMi2YjWU56UKOSg8t8vRZ6JoECfCv0+9or73rhokJXRBcGYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379319; c=relaxed/simple;
	bh=XyAyK12rt9QWvGXirwVJqc8Oaxz0lNoaucAWGCWbrBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lunlBRHNqgAYa4Jr3fj4SjdWKo4EI0gT46+mT9OYhcPoDzLm01SdzUteJVujbutUc8sP73Hu+rMYJpD0PdQhfuKYeC+1gQ6sW1U3QWSzRHv7Af9dp3Ti7FdYi/gPvUONMHV67tpT94Sad9klWWKtwrsS3crKDqcyQWxrT+AKtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2CIvega; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CjS3lUef; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2CIvega; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CjS3lUef; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDA6124140;
	Tue,  9 Sep 2025 00:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757379315;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDrg8PPUaVGOG0EMCy+IM6z/hrw1WTkN5tcBo+hrvD0=;
	b=o2CIvegajXXB11zkIw2BxL4SJ4ojUb43VEKwJD7ivCfzhRQmNX4FKh/JAIjGGaUsYqB83V
	HgN/1xblCEDhVt2c3gZVzFCG6+UOjbHj6LU7AvDVPknDNoBtTrshA2zc9Xx4t04AcnGTyy
	mL6SO6em3+tpM1N+2ep4XYSYHtxfxV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757379315;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDrg8PPUaVGOG0EMCy+IM6z/hrw1WTkN5tcBo+hrvD0=;
	b=CjS3lUefc7679nyU1THLOfo18BmL3WrRgRjeo/cQfwejimsmJlix8sCHg91b6wkyv4omZo
	Re641DdH1L/ibzAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o2CIvega;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CjS3lUef
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757379315;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDrg8PPUaVGOG0EMCy+IM6z/hrw1WTkN5tcBo+hrvD0=;
	b=o2CIvegajXXB11zkIw2BxL4SJ4ojUb43VEKwJD7ivCfzhRQmNX4FKh/JAIjGGaUsYqB83V
	HgN/1xblCEDhVt2c3gZVzFCG6+UOjbHj6LU7AvDVPknDNoBtTrshA2zc9Xx4t04AcnGTyy
	mL6SO6em3+tpM1N+2ep4XYSYHtxfxV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757379315;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDrg8PPUaVGOG0EMCy+IM6z/hrw1WTkN5tcBo+hrvD0=;
	b=CjS3lUefc7679nyU1THLOfo18BmL3WrRgRjeo/cQfwejimsmJlix8sCHg91b6wkyv4omZo
	Re641DdH1L/ibzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DFE013946;
	Tue,  9 Sep 2025 00:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y8AKJvN6v2g2egAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Sep 2025 00:55:15 +0000
Date: Tue, 9 Sep 2025 02:55:14 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/33] btrfs: log replay bug fix, cleanups and error
 reporting changes
Message-ID: <20250909005514.GV5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BDA6124140
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Mon, Sep 08, 2025 at 10:52:54AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are a bug fix for an extref key offset computation, several
> cleanups to eliminate duplicated or not needed code, memory allocations
> and preparation work for the final change which is to make log replay
> failures dump contextual information useful to help debug failures during
> log replay. Details in the change logs.
> 
> V2: Update subject of patch 18/33 which was a duplicate of another one
>     likely due to copy paste. Update patch 33/33 to avoid use-after-free
>     on a name if we had an error during replay of xattr deletes.
> 
> Filipe Manana (33):
>   btrfs: fix invalid extref key setup when replaying dentry
>   btrfs: use booleans in walk control structure for log replay
>   btrfs: rename replay_dest member of struct walk_control to root
>   btrfs: rename root to log in walk_down_log_tree() and walk_up_log_tree()
>   btrfs: add and use a log root field to struct walk_control
>   btrfs: deduplicate log root free in error paths from btrfs_recover_log_trees()
>   btrfs: stop passing transaction parameter to log tree walk functions
>   btrfs: stop setting log_root_tree->log_root to NULL in btrfs_recover_log_trees()
>   btrfs: always drop log root tree reference in btrfs_replay_log()
>   btrfs: pass walk_control structure to replay_xattr_deletes()
>   btrfs: move up the definition of struct walk_control
>   btrfs: pass walk_control structure to replay_dir_deletes()
>   btrfs: pass walk_control structure to check_item_in_log()
>   btrfs: pass walk_control structure to replay_one_extent()
>   btrfs: pass walk_control structure to add_inode_ref() and helpers
>   btrfs: pass walk_control structure to replay_one_dir_item() and replay_one_name()
>   btrfs: pass walk_control structure to drop_one_dir_item() and helpers
>   btrfs: pass walk_control structure to overwrite_item()
>   btrfs: use level argument in log tree walk callback process_one_buffer()
>   btrfs: use level argument in log tree walk callback replay_one_buffer()
>   btrfs: use the inode item boolean everywhere in overwrite_item()
>   btrfs: add current log leaf, key and slot to struct walk_control
>   btrfs: avoid unnecessary path allocation at fixup_inode_link_count()
>   btrfs: avoid path allocations when dropping extents during log replay
>   btrfs: avoid unnecessary path allocation when replaying a dir item
>   btrfs: remove redundant path release when processing dentry during log replay
>   btrfs: remove redundant path release when overwriting item during log replay
>   btrfs: add path for subvolume tree changes to struct walk_control
>   btrfs: stop passing inode object IDs to __add_inode_ref() in log replay
>   btrfs: remove pointless inode lookup when processing extrefs during log replay
>   btrfs: abort transaction if we fail to find dir item during log replay
>   btrfs: abort transaction if we fail to update inode in log replay dir fixup
>   btrfs: dump detailed info and specific messages on log replay failures

Nice, thanks.

Reviewed-by: David Sterba <dsterba@suse.com>

