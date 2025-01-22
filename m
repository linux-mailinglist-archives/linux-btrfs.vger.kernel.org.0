Return-Path: <linux-btrfs+bounces-11042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB48A194B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 16:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FABF7A2367
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2D214237;
	Wed, 22 Jan 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwD6yz9B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+yhH0hEM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwD6yz9B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+yhH0hEM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C1214203
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558480; cv=none; b=pD+2VVJj+ddDajzhS/Ppao/Jn21kuxirf/g7C1E8FGvuTnsC7n9gcOJsFJ/1EPvcYNQ4YoeTI1RHhnDwGa3fU8HHkV/k1q6M0m3ID8uozFubXGx2u8V4o0am03QKUkztlyyzU+7RMX2OfTPB9vi8dmUVEH2pVuxJrXv9Z9KghX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558480; c=relaxed/simple;
	bh=GZUXoxQn/MY9j+eLPCAtLtipeYJ5GKufsS8rJaptIKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MASizKMZGDuSOAn+8/zUz4n8Jzv8qXmKY/7q1rvAMtfbBn3phhoxJ7a4xdDW7X9+1PbEHEI7VO4LVoj/b2xb0+QloxuwJTzZrmLU4jgSVsBCnxi3XtwCV8laBlZVLkihZN0NPhmqti8SXQMtdmCIPLuUDr+StdF2offdsM9haiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwD6yz9B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+yhH0hEM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwD6yz9B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+yhH0hEM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 045BA218B2;
	Wed, 22 Jan 2025 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737558477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJA9KRKMpmyST2BqfKtICxdhNy+jsbjcDzFby5ugG5U=;
	b=zwD6yz9BTbTaFIMR+rMaK1/DrSxA9+oExFnDV9UKT5KZcrkG80/18v5pzdblkyO+hQrwCY
	+PHLbU0V4FhC7an/qA44Y9LHcC/7V6NnvUCMSkNrIJoX1AyW8ZHO0Sb9Erxef9fBBJ9czx
	GOTWkKLIL9W5Bft1oCd2bIRZFiSXN78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737558477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJA9KRKMpmyST2BqfKtICxdhNy+jsbjcDzFby5ugG5U=;
	b=+yhH0hEMVUi/8U1klsyZYoiNJAzqk6e7zHZ841nQMHnzFwn/WqryWty9ljsuEewsLviuq3
	eFxplmraJvEuv3DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zwD6yz9B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+yhH0hEM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737558477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJA9KRKMpmyST2BqfKtICxdhNy+jsbjcDzFby5ugG5U=;
	b=zwD6yz9BTbTaFIMR+rMaK1/DrSxA9+oExFnDV9UKT5KZcrkG80/18v5pzdblkyO+hQrwCY
	+PHLbU0V4FhC7an/qA44Y9LHcC/7V6NnvUCMSkNrIJoX1AyW8ZHO0Sb9Erxef9fBBJ9czx
	GOTWkKLIL9W5Bft1oCd2bIRZFiSXN78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737558477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJA9KRKMpmyST2BqfKtICxdhNy+jsbjcDzFby5ugG5U=;
	b=+yhH0hEMVUi/8U1klsyZYoiNJAzqk6e7zHZ841nQMHnzFwn/WqryWty9ljsuEewsLviuq3
	eFxplmraJvEuv3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3AC1136A1;
	Wed, 22 Jan 2025 15:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4oFYN8wJkWcwPgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Jan 2025 15:07:56 +0000
Date: Wed, 22 Jan 2025 16:07:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250122150751.GH5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250122122459.1148668-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122122459.1148668-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 045BA218B2
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 22, 2025 at 12:21:28PM +0000, Mark Harmstone wrote:
> Currently btrfs_get_free_objectid() uses a mutex to protect
> free_objectid; I'm guessing this was because of the inode cache that we
> used to have. The inode cache is no more, so simplify things by
> replacing it with an atomic.
> 
> There's no issues with ordering: free_objectid gets set to an initial
> value, then calls to btrfs_get_free_objectid() return a monotonically
> increasing value.
> 
> This change means that btrfs_get_free_objectid() will no longer
> potentially sleep, which was a blocker for adding a non-blocking mode
> for inode and subvol creation.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/ctree.h    |  4 +---
>  fs/btrfs/disk-io.c  | 43 ++++++++++++++++++-------------------------
>  fs/btrfs/qgroup.c   | 11 ++++++-----
>  fs/btrfs/tree-log.c |  3 ---
>  4 files changed, 25 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1096a80a64e7..04175698525b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -179,8 +179,6 @@ struct btrfs_root {
>  	struct btrfs_fs_info *fs_info;
>  	struct extent_io_tree dirty_log_pages;
>  
> -	struct mutex objectid_mutex;
> -
>  	spinlock_t accounting_lock;
>  	struct btrfs_block_rsv *block_rsv;
>  
> @@ -214,7 +212,7 @@ struct btrfs_root {
>  
>  	u64 last_trans;
>  
> -	u64 free_objectid;
> +	atomic64_t free_objectid;

Besides the other things pointed out, this also changes the type from
u64 to s64 or requiring casts so we keep u64 as this is what the on-disk
format defines.

