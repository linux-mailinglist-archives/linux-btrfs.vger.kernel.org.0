Return-Path: <linux-btrfs+bounces-19753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08BCBF72E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC7AC301397E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A6D30BF67;
	Mon, 15 Dec 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7XKoTDZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2YiSt2i6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3Ooh/ct";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U8kKsd16"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E729226D00
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823780; cv=none; b=Pyg4q/QaI/V5xkoInz7JHvzpUez1a4uqnPxyqTez7BJSJHM6hDAGjzBI0zgV53E2lM+BZ6ltMlKZ6PFG5S/nzg53EC9sU418c0YlzxBzeH38KZ4de7BYQHdQDT9LMBIInvhPk2MXz6oTQjL8n03gTaV6NySfmBby7Tv3YoMRq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823780; c=relaxed/simple;
	bh=nJ7GYbdjP49hibawO7pM7dKKcsn1ED1DJMYV9K4aC+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faYVJYfxrQ/mAclV1qyfMnWJFtJ+iyI9lJp+4ak7rAB5P8AWpCwsmwrauKjtL9+tYsOYqOVM2BaolJGq7im44JS3G2e/V9+E8cbDgXAzvF58BFQHNdQAogbG33ein6kqrij6a+Nd3jgLdC1cOvudm9J0pJ0YAKiNenXSFzvUViI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7XKoTDZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2YiSt2i6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3Ooh/ct; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U8kKsd16; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CD4B336F9;
	Mon, 15 Dec 2025 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765823775;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkvFAZeMU6QhijKuqGW/08Ene+/4tFlBXrjTITGGG7E=;
	b=J7XKoTDZUZZ0dp/R6dUZ6l6wn+temqSPv5x5maPzkq/V3IU6JDAQn9kCQFiWCe4kERw89j
	9MXyB2vEKES+cNMM5no6vNDBmSMK1VLbCl6AAgKP3yVhEC+pmVdLu8bxbw0B+F860i7YCP
	3oQ4A580Z8CwEKDw7UsImKGneU7+wIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765823775;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkvFAZeMU6QhijKuqGW/08Ene+/4tFlBXrjTITGGG7E=;
	b=2YiSt2i65uRvLUPRrPOw1t4G0KHUs3zgIWZOPcFxDcJEtu0Fq8PRWVxrfvM2Jnkd8kaXZl
	eKk1vCyFgVXTC+DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Y3Ooh/ct";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U8kKsd16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765823774;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkvFAZeMU6QhijKuqGW/08Ene+/4tFlBXrjTITGGG7E=;
	b=Y3Ooh/ct+5JZYwTETK3FCI5QIboFz6LwdYhRhE72Wt56jDEGqFsSQUhNaERQHTq9PnNzYv
	s3RI146BK1VE24ZX5+8gkzrGeu92eGTIwl/WMNtGSOXo61oP6TGXaZPebJwDeQnnUg19ZR
	ufBPy47zgAXFYW5AM4kR1+LFeMjiTqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765823774;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkvFAZeMU6QhijKuqGW/08Ene+/4tFlBXrjTITGGG7E=;
	b=U8kKsd16SsBQ7iuzbjjPsf/I5xeBQTO36xYn7LBl08u93+yJD6g0qsHBH/HxqTh6/Uq+m+
	9DbXk8IuGJrlGsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CF293EA63;
	Mon, 15 Dec 2025 18:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zEH7Ah5VQGkUfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 18:36:14 +0000
Date: Mon, 15 Dec 2025 19:36:04 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: re-flow prepare_allocation_zoned
Message-ID: <20251215183604.GD3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251215103818.39805-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215103818.39805-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 2CD4B336F9
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Mon, Dec 15, 2025 at 11:38:18AM +0100, Johannes Thumshirn wrote:
> Re-flow prepare allocation zoned to make it a bit more readable by
> returning early and removing unnecessary indentations.
> 
> This patch does not change any functionality.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
>  fs/btrfs/extent-tree.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 04a266bb189b..726aa30642c4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4288,36 +4288,43 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
>  				    struct find_free_extent_ctl *ffe_ctl,
>  				    struct btrfs_space_info *space_info)
>  {
> +	struct btrfs_block_group *block_group;
> +
>  	if (ffe_ctl->for_treelog) {
>  		spin_lock(&fs_info->treelog_bg_lock);
>  		if (fs_info->treelog_bg)
>  			ffe_ctl->hint_byte = fs_info->treelog_bg;
>  		spin_unlock(&fs_info->treelog_bg_lock);
> -	} else if (ffe_ctl->for_data_reloc) {
> +		return 0;
> +	}
> +
> +	if (ffe_ctl->for_data_reloc) {
>  		spin_lock(&fs_info->relocation_bg_lock);
>  		if (fs_info->data_reloc_bg)
>  			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
>  		spin_unlock(&fs_info->relocation_bg_lock);
> -	} else if (ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA) {
> -		struct btrfs_block_group *block_group;
> +		return 0;
> +	}
>  
> -		spin_lock(&fs_info->zone_active_bgs_lock);
> -		list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
> -			/*
> -			 * No lock is OK here because avail is monotonically
> -			 * decreasing, and this is just a hint.
> -			 */
> -			u64 avail = block_group->zone_capacity - block_group->alloc_offset;
> +	if (!(ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA))
> +		return 0;
>  
> -			if (block_group_bits(block_group, ffe_ctl->flags) &&
> -			    block_group->space_info == space_info &&
> -			    avail >= ffe_ctl->num_bytes) {
> -				ffe_ctl->hint_byte = block_group->start;
> -				break;
> -			}
> +	spin_lock(&fs_info->zone_active_bgs_lock);
> +	list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
> +		/*
> +		 * No lock is OK here because avail is monotonically
> +		 * decreasing, and this is just a hint.
> +		 */
> +		u64 avail = block_group->zone_capacity - block_group->alloc_offset;
> +
> +		if (block_group_bits(block_group, ffe_ctl->flags) &&
> +				block_group->space_info == space_info &&
> +				avail >= ffe_ctl->num_bytes) {

Minor thing, multi-line conditions should be aligned under "(".

