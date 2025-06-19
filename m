Return-Path: <linux-btrfs+bounces-14787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67807AE07A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 15:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CC6189C6AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC226C3AA;
	Thu, 19 Jun 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIcIdaKh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDD63Y49";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GIcIdaKh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDD63Y49"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF75253939
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340614; cv=none; b=U6BG2JJ57mfDfnghLrGsFYfa9Pp4SanXgv7Nn9MvIMla2+hz+BYvbHaSF4zsuNjfzG5i4RbY/bnJu8w5h9rC4jsmSMmEKfydobF4E07zl7RbHsIEHriCXJkUJnLlN3VCNWSZi4WXm4QVmXuGK9Y7u9HL8V4k/OF3qxYQMIldhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340614; c=relaxed/simple;
	bh=Dk049L9ItV/3QIliuEMTatiJPJsI+GU49ds+evCaj6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbjnIc1CQCyPPYUixF0w9uvhalv54TRLntMnR1iz3OelHmKaed24Cf+nA/geSF68oDha6Ca48zXQTojifuoqQRo8dD2cBLoUBmdCgpmfvq6pNmJzb6UK4pCAZRtCn2SpBz+Jh2aKLcAf/mGbqKIGtraqfe4mWzExqPgaxzIs/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIcIdaKh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDD63Y49; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GIcIdaKh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDD63Y49; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BC0F1F38D;
	Thu, 19 Jun 2025 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750340610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRYKd5eBwF7dWP5xrCysKI39cJowpzvNcWXTPG4Dl1k=;
	b=GIcIdaKh0nMey8Qx/nVc/+rbvfwJx1sh5tIOCSaMHajIkWHlebHiaAS2X0fKqQKcFjMVEM
	yIKhKxe5jwWsbGfQWnoFtB2aLaqRy1JKG6l8qJf7xAL/5MwGxvhP3fRrRkm81xQOYY+hz9
	bP9NeutsC/X6uK3TWN0JSq2CGY3fsUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750340610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRYKd5eBwF7dWP5xrCysKI39cJowpzvNcWXTPG4Dl1k=;
	b=qDD63Y498ya68kQUlOsICYN71OtVczJQMpR07P4jWU/vvyi9Nb9MwuNZ8AG1VjwSAIUPYQ
	G0cW2vu5tnxHsBCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GIcIdaKh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qDD63Y49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750340610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRYKd5eBwF7dWP5xrCysKI39cJowpzvNcWXTPG4Dl1k=;
	b=GIcIdaKh0nMey8Qx/nVc/+rbvfwJx1sh5tIOCSaMHajIkWHlebHiaAS2X0fKqQKcFjMVEM
	yIKhKxe5jwWsbGfQWnoFtB2aLaqRy1JKG6l8qJf7xAL/5MwGxvhP3fRrRkm81xQOYY+hz9
	bP9NeutsC/X6uK3TWN0JSq2CGY3fsUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750340610;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRYKd5eBwF7dWP5xrCysKI39cJowpzvNcWXTPG4Dl1k=;
	b=qDD63Y498ya68kQUlOsICYN71OtVczJQMpR07P4jWU/vvyi9Nb9MwuNZ8AG1VjwSAIUPYQ
	G0cW2vu5tnxHsBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 677D8136CC;
	Thu, 19 Jun 2025 13:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OYILGQIUVGjxFAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 19 Jun 2025 13:43:30 +0000
Date: Thu, 19 Jun 2025 15:43:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: replace key_in_sk() with a simple btrfs_key
 compare
Message-ID: <20250619134329.GM4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250612043311.22955-1-sunk67188@gmail.com>
 <20250612043311.22955-4-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612043311.22955-4-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8BC0F1F38D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Jun 12, 2025 at 12:31:13PM +0800, Sun YangKai wrote:
> The min-key guard is inherent to btrfs_search_forward().
> 
> The max-check logic is equivalent to the original.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ioctl.c | 43 +++++++++++++------------------------------
>  1 file changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5e6202a417c4..2bc99e603974 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1446,30 +1446,6 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>  	return ret;
>  }
>  
> -static noinline bool key_in_sk(const struct btrfs_key *key,
> -			       const struct btrfs_ioctl_search_key *sk)
> -{
> -	struct btrfs_key test;
> -	int ret;
> -
> -	test.objectid = sk->min_objectid;
> -	test.type = sk->min_type;
> -	test.offset = sk->min_offset;
> -
> -	ret = btrfs_comp_cpu_keys(key, &test);
> -	if (ret < 0)
> -		return false;
> -
> -	test.objectid = sk->max_objectid;
> -	test.type = sk->max_type;
> -	test.offset = sk->max_offset;
> -
> -	ret = btrfs_comp_cpu_keys(key, &test);
> -	if (ret > 0)
> -		return false;
> -	return true;
> -}
> -
>  static noinline int copy_to_sk(struct btrfs_path *path,
>  			       struct btrfs_key *key,
>  			       const struct btrfs_ioctl_search_key *sk,
> @@ -1481,7 +1457,8 @@ static noinline int copy_to_sk(struct btrfs_path *path,
>  	u64 found_transid;
>  	struct extent_buffer *leaf;
>  	struct btrfs_ioctl_search_header sh;
> -	struct btrfs_key test;
> +	struct btrfs_key min_key;
> +	struct btrfs_key max_key;
>  	unsigned long item_off;
>  	unsigned long item_len;
>  	int nritems;
> @@ -1492,17 +1469,26 @@ static noinline int copy_to_sk(struct btrfs_path *path,
>  	slot = path->slots[0];
>  	nritems = btrfs_header_nritems(leaf);
>  
> +	max_key.objectid = sk->max_objectid;
> +	max_key.type = sk->max_type;
> +	max_key.offset = sk->max_offset;
> +
>  	if (btrfs_header_generation(leaf) > sk->max_transid)
>  		goto advance_key;
>  
>  	found_transid = btrfs_header_generation(leaf);
>  
> +	min_key.objectid = sk->min_objectid;
> +	min_key.type = sk->min_type;
> +	min_key.offset = sk->min_offset;
> +
>  	for (int i = slot; i < nritems; i++) {
>  		item_off = btrfs_item_ptr_offset(leaf, i);
>  		item_len = btrfs_item_size(leaf, i);
>  
>  		btrfs_item_key_to_cpu(leaf, key, i);
> -		if (!key_in_sk(key, sk)) {
> +		WARN_ON(btrfs_comp_cpu_keys(&min_key, key) > 0);

I'd rather use a DEBUG_WARN or ASSERT here. If it's a runtime error that
can otherwise happen then it should be handled as and error.

One way or another it's good to have it here as we want to verify the
assumptions of btrfs_search_forward().

