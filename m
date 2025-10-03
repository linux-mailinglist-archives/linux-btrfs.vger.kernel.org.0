Return-Path: <linux-btrfs+bounces-17415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD574BB7314
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 16:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DE719E76DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E023A9AE;
	Fri,  3 Oct 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwBoM6R9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3YM1fHvm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mwBoM6R9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3YM1fHvm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A715E8B
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502111; cv=none; b=DF9J8T2IZ1Vi4UHOU2kwkUunMXPETlxjZ3ophdAvhjQJ0yUr2P+xhbdkFTH2axrLHGlDh7QXu3xFxn/vpZb5MzHgoRriUhTYh2wrUq7+sihI2GDXADq62oRfQKdh7fg7J5q816FcmJm6XtK0JVveAUGqq79XATpiPZ9Krq0dgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502111; c=relaxed/simple;
	bh=JwCjEy9JFwSUs/AKLizBo5+UkrmNp+OQevdl0+GmqKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ120DFexJ+EYF9q//GnqjvNZgK1wl3lXh359iIs3vmsUupSIDoPZurdtBjjgrnvmbFBsaurlBUWL8ZjpmkFY4PLKKCqHjNK01s3ijI2XcjXphyLb1wPB38LmUsJePRUOJRwuEomm2ouSymtLZjIbc1NWa2oBcVgHbfY4adQwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mwBoM6R9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3YM1fHvm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mwBoM6R9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3YM1fHvm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4187E3376C;
	Fri,  3 Oct 2025 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759502104;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJjJnTWacdwBQsFFJOl7NLJxzUidxNMCN27q3O8Qa7U=;
	b=mwBoM6R9lTGtk7VMu8kayIyLRpWEIkcmoBREmQszgT1pgPW5qoaGv4dIzduaZ8NMYkSSao
	C+viFm50cAqYfkNKnlaessitUvh963P42Dlqx42lyIEJCI2QbzFlrESWtZcS061EpGHTW5
	q96qF2e+6cvBKsSKoYzgxdhn+CGvMjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759502104;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJjJnTWacdwBQsFFJOl7NLJxzUidxNMCN27q3O8Qa7U=;
	b=3YM1fHvmtUCgYliapARZ4As4S1HlMaTQAzcXfXqqf/GDoNYxjLOmKl5vy6RAUlR+KJlKtn
	0Z7vU70xtlnOTsBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mwBoM6R9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3YM1fHvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759502104;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJjJnTWacdwBQsFFJOl7NLJxzUidxNMCN27q3O8Qa7U=;
	b=mwBoM6R9lTGtk7VMu8kayIyLRpWEIkcmoBREmQszgT1pgPW5qoaGv4dIzduaZ8NMYkSSao
	C+viFm50cAqYfkNKnlaessitUvh963P42Dlqx42lyIEJCI2QbzFlrESWtZcS061EpGHTW5
	q96qF2e+6cvBKsSKoYzgxdhn+CGvMjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759502104;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJjJnTWacdwBQsFFJOl7NLJxzUidxNMCN27q3O8Qa7U=;
	b=3YM1fHvmtUCgYliapARZ4As4S1HlMaTQAzcXfXqqf/GDoNYxjLOmKl5vy6RAUlR+KJlKtn
	0Z7vU70xtlnOTsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AAB313AAD;
	Fri,  3 Oct 2025 14:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xv0uChjf32gsVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 Oct 2025 14:35:04 +0000
Date: Fri, 3 Oct 2025 16:35:02 +0200
From: David Sterba <dsterba@suse.cz>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <20251003143502.GJ4052@suse.cz>
Reply-To: dsterba@suse.cz
References: <aN_Zeo7JH9nogwwq@kspp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN_Zeo7JH9nogwwq@kspp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4187E3376C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Oct 03, 2025 at 03:11:06PM +0100, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that `struct fs_path` is a flexible structure,
> this is a structure that contains a flexible-array member (`char
> inline_buf[];` in this case).

It contains a flexible member but also a padding array and a limit
calculated for the usable space of inline_buf (FS_PATH_INLINE_SIZE),
it's not the pattern where flexible array is in the middle of a
structure and could potentially overwrite other members.

> Fix the following warning:
> 
> fs/btrfs/send.c:181:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Otheriwse OK to fix the warning.

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/btrfs/send.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 9230e5066fc6..2b7cf49a35bb 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -178,7 +178,6 @@ struct send_ctx {
>  	u64 cur_inode_rdev;
>  	u64 cur_inode_last_extent;
>  	u64 cur_inode_next_write_offset;
> -	struct fs_path cur_inode_path;
>  	bool cur_inode_new;
>  	bool cur_inode_new_gen;
>  	bool cur_inode_deleted;
> @@ -305,6 +304,9 @@ struct send_ctx {
>  
>  	struct btrfs_lru_cache dir_created_cache;
>  	struct btrfs_lru_cache dir_utimes_cache;
> +
> +	/* Must be last --ends in a flexible-array member. */
                        ^^

Is this an en dash?

> +	struct fs_path cur_inode_path;
>  };
>  
>  struct pending_dir_move {
> -- 
> 2.43.0
> 

