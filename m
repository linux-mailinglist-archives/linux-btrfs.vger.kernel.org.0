Return-Path: <linux-btrfs+bounces-13416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7AA9C7C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E426816CF33
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117224337C;
	Fri, 25 Apr 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOm1d8n2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMR2rfeN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOm1d8n2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMR2rfeN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318414F9D9
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581152; cv=none; b=mWP+0J5nj1BZQ5cV0/I9oU34QSGW32wAqmdZKfGz0+QEe9MaPeo5dPlo2zveu4epYavxh3s/N91JniuQO8aG31DINOT9m+Zy9cPixSoKjrLVyaMbzTLZBrxwX4SQv0/z+Q0LpuU3do3io0qCaLYAPi606qbBS/WF2xD9dqw5Mts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581152; c=relaxed/simple;
	bh=P4de2ItVrUh4L1XoeGnW8HxHxKAYN1CcgMxyOhLayxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhTF79uzAWnhrJLudls8a7MEORING5eENckPGBHamUaYieQADp7jVJ3hECi4+ORJUakFlGAkVoLTo9Zkqygvn125tdnn7fdICCunKPJdAUPq31M0WXWSaK008NqTIc3FhX+wi/v3PMEDfLSJZ4toosFboiJjwBE5w+XZihH51Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KOm1d8n2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMR2rfeN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KOm1d8n2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMR2rfeN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82B991F388;
	Fri, 25 Apr 2025 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745581148;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2eJaC08jk1r+/zerFlUGOvXdyJEtNcoYjun1c5NE38=;
	b=KOm1d8n2NJqsFhy33k7Tihdzzo2nlG72JRlbsi4Fpr4RiOc8W8QcdFuir56OX15FLKjCbX
	GZ7mmEYmnH0WboheyabEbcXBS6ZVqyFDt12KLdnlKOtQpFM/8VdB5/yWzvL9+gFzcaotyY
	5q/u7037zyZsxx3mc6iDCjaX+lMcAUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745581148;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2eJaC08jk1r+/zerFlUGOvXdyJEtNcoYjun1c5NE38=;
	b=sMR2rfeNC3gkv7qdVMdVvUlzXH1AnU/fBtLJMVvu1+8V1j3eEDiZJUEXTKmjNGWqW3Y7yf
	FEV+R9O7MI6saaDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KOm1d8n2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sMR2rfeN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745581148;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2eJaC08jk1r+/zerFlUGOvXdyJEtNcoYjun1c5NE38=;
	b=KOm1d8n2NJqsFhy33k7Tihdzzo2nlG72JRlbsi4Fpr4RiOc8W8QcdFuir56OX15FLKjCbX
	GZ7mmEYmnH0WboheyabEbcXBS6ZVqyFDt12KLdnlKOtQpFM/8VdB5/yWzvL9+gFzcaotyY
	5q/u7037zyZsxx3mc6iDCjaX+lMcAUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745581148;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2eJaC08jk1r+/zerFlUGOvXdyJEtNcoYjun1c5NE38=;
	b=sMR2rfeNC3gkv7qdVMdVvUlzXH1AnU/fBtLJMVvu1+8V1j3eEDiZJUEXTKmjNGWqW3Y7yf
	FEV+R9O7MI6saaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6729C1388F;
	Fri, 25 Apr 2025 11:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZRr1GFx0C2jONQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Apr 2025 11:39:08 +0000
Date: Fri, 25 Apr 2025 13:39:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: get rid of goto in alloc_test_extent_buffer()
Message-ID: <20250425113907.GC31681@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250425072358.51788-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425072358.51788-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 82B991F388
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Apr 25, 2025 at 09:23:57AM +0200, Daniel Vacek wrote:
> The `free_eb` label is used only once. Simplify by moving the code inplace.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>  fs/btrfs/extent_io.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ea38c73d4bc5f..20cdddd924852 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3004,15 +3004,13 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>  			goto again;
>  		}
>  		xa_unlock_irq(&fs_info->buffer_tree);
> -		goto free_eb;
> +		btrfs_release_extent_buffer(eb);
> +		return exists;
>  	}
>  	xa_unlock_irq(&fs_info->buffer_tree);
>  	check_buffer_tree_ref(eb);
>  
>  	return eb;
> -free_eb:
> -	btrfs_release_extent_buffer(eb);

So the xarray conversion removed the other use of the free_eb label and
calls btrfs_release_extent_buffer() + return. Doing the same here and
removing the label completely looks as an improvement, as the whole
function does direct returns instead of goto exit block.

Reviewed-by: David Sterba <dsterba@suse.com>

