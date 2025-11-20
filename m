Return-Path: <linux-btrfs+bounces-19228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DF9C75FEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 20:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 682F33456CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A9D32C94A;
	Thu, 20 Nov 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kBFf9bhc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O10ZGjTM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kBFf9bhc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O10ZGjTM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6C3B2BA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665331; cv=none; b=GD8x5jXA6Rzg478Feej8C0O31F6PzCwHsTEcwHLVoJD+Z3awzmaMe9nGoWvMMKzL5lR01xBatkkcjvj2vfR0BwFmN8jWG3ojrwBba8DVzg730S+TRx06fstMpwY6Nd08k70mKMWYd9MY7XUZP3O1L0BSdh2mEwEZSixzrEM5pcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665331; c=relaxed/simple;
	bh=uOT+z2uuRe9LLwW9E+qL4qLk9Ix4vwGWIohyYwZFOfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqrTJhot9VvIGlYoaiJ7K3gJVb3ByLsSNE1MMSWEZI7P7Wbzq7iWcLg8PkFh3E1Xi/zL7zPmRPGS3WfoTC8199nWsmbcaKuKm6fcEr6vNhIDw0eq7gm5pZ8Nh37Ws6JoJ/QER16rBZmOhkO9GF2OEaDTzZXcboXmDkmRxtekS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kBFf9bhc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O10ZGjTM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kBFf9bhc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O10ZGjTM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90BD020BA6;
	Thu, 20 Nov 2025 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763665327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXylREP83wJEVV5JNinBNQILuKmFkFKyOkgC1nOrOI4=;
	b=kBFf9bhc0fUe/pkR6hB5kt4UWcN+FjhewX8NPgQfJCpyZSDrfsddTAsqififMNDVp+FXo6
	GjfUcc9cb16c0OFlMUAWM1TL+nVuZgonKke61lR+OKeCeO3kK6Q5bqGeeJyeCSpFm01FeA
	QuUeUu+PO+Or017Mz4ZiyhYZCK41g7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763665327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXylREP83wJEVV5JNinBNQILuKmFkFKyOkgC1nOrOI4=;
	b=O10ZGjTMiuZ+KfScRRi+2qy3lHSLUZY0j4kGpq4FJFL1xsaEzxKQ7kY/2FXLaP4gp0KwYs
	ul8VcjWd9hEaTMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763665327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXylREP83wJEVV5JNinBNQILuKmFkFKyOkgC1nOrOI4=;
	b=kBFf9bhc0fUe/pkR6hB5kt4UWcN+FjhewX8NPgQfJCpyZSDrfsddTAsqififMNDVp+FXo6
	GjfUcc9cb16c0OFlMUAWM1TL+nVuZgonKke61lR+OKeCeO3kK6Q5bqGeeJyeCSpFm01FeA
	QuUeUu+PO+Or017Mz4ZiyhYZCK41g7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763665327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXylREP83wJEVV5JNinBNQILuKmFkFKyOkgC1nOrOI4=;
	b=O10ZGjTMiuZ+KfScRRi+2qy3lHSLUZY0j4kGpq4FJFL1xsaEzxKQ7kY/2FXLaP4gp0KwYs
	ul8VcjWd9hEaTMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 765173EA61;
	Thu, 20 Nov 2025 19:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LJq7HK9lH2kyUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Nov 2025 19:02:07 +0000
Date: Thu, 20 Nov 2025 20:02:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: simplify boolean argument for
 btrfs_{inc,dec}_ref
Message-ID: <20251120190206.GM13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251120141948.5323-1-sunk67188@gmail.com>
 <20251120141948.5323-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120141948.5323-3-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Nov 20, 2025 at 10:19:14PM +0800, Sun YangKai wrote:
> Replace open-coded if/else blocks with the boolean expression
> directly, making the code shorter and easier to read.
> 
> No functional change.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c       | 25 +++++++------------------
>  fs/btrfs/extent-tree.c | 17 +++++------------
>  2 files changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1b15cef86cbc..e056dedec221 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -291,15 +291,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
>  		return ret;
>  	}
>  
> -	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
> -		ret = btrfs_inc_ref(trans, root, cow, true);
> -		if (unlikely(ret))
> -			btrfs_abort_transaction(trans, ret);
> -	} else {
> -		ret = btrfs_inc_ref(trans, root, cow, false);
> -		if (unlikely(ret))
> -			btrfs_abort_transaction(trans, ret);
> -	}
> +	ret = btrfs_inc_ref(trans, root, cow, new_root_objectid == BTRFS_TREE_RELOC_OBJECTID);
> +	if (unlikely(ret))
> +		btrfs_abort_transaction(trans, ret);

I find this worse than the original because the key piece of code is the
condition and putting it to the argument obscures it. I think we have
the condition in paramter in some places but it's where it does not
matter that much.

