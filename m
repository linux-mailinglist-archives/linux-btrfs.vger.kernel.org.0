Return-Path: <linux-btrfs+bounces-12154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3EA5A3DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BB318920A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FC2309B3;
	Mon, 10 Mar 2025 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4fW+L1a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gl+Bqyt3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4fW+L1a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gl+Bqyt3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34F1CAA60
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635357; cv=none; b=S3gk+hiGStcdscQrBnKgW6uSD1AZGMs7zp7GrOMpYdR6JLsjuBIdYnmvDn21F5y2s7piSxdZT2fSMmnK19OOtjRWTc+cX+QBDGEmc4tYrSvlikE25IT5A+mCLtj/jPEkclSadHfFrpBhPopL/xSzegxBTg6yFEvPemrZL/tRRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635357; c=relaxed/simple;
	bh=lWxfXyT0umllSKgbENh/9Va997DS7wY9xvwKSVUsLK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhpJDq86ftk5Vrv87yMQFOSn49P/wOQQW+rx67SOR/HmxGjMHu1pTQkd4Jc3HBTK1R0wmushmWCA18GqDzgQXtvV/AC4TOoaDdCOs0puPlOwzooK6yVrRMtx1KUyP+dovKtadvKGZuB2RFjJU0xqUTUNdjMeU9DBZmb9owW/Ryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4fW+L1a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gl+Bqyt3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4fW+L1a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gl+Bqyt3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF4601F387;
	Mon, 10 Mar 2025 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741635353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTApaEDLiNDn3LU2MUCO+kIN5P/aTj1B+771wX/k2Bs=;
	b=N4fW+L1adR8N+cEz1qOjc0wlejIDofK55HIqG7jLXu21cglSzkhms4MyZUEi4TbTDbbUd/
	36jKmezIvuIsMSosAxFSHnCIBBhVRJbPWlCOhN9nxHcyIK1GImrdk+rzHj1Yw1m3YH1dpu
	WFeAb3K72Cdu/aBYhbLX36eeQasYVf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741635353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTApaEDLiNDn3LU2MUCO+kIN5P/aTj1B+771wX/k2Bs=;
	b=Gl+Bqyt34DtQo1EOfVOpnYt3K/ZJlo6mOh+Jm3idjsQCLO36qnK7w6QKexqEJZy46JoE8l
	o4tgvKGR4SteVfAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741635353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTApaEDLiNDn3LU2MUCO+kIN5P/aTj1B+771wX/k2Bs=;
	b=N4fW+L1adR8N+cEz1qOjc0wlejIDofK55HIqG7jLXu21cglSzkhms4MyZUEi4TbTDbbUd/
	36jKmezIvuIsMSosAxFSHnCIBBhVRJbPWlCOhN9nxHcyIK1GImrdk+rzHj1Yw1m3YH1dpu
	WFeAb3K72Cdu/aBYhbLX36eeQasYVf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741635353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTApaEDLiNDn3LU2MUCO+kIN5P/aTj1B+771wX/k2Bs=;
	b=Gl+Bqyt34DtQo1EOfVOpnYt3K/ZJlo6mOh+Jm3idjsQCLO36qnK7w6QKexqEJZy46JoE8l
	o4tgvKGR4SteVfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5A71399F;
	Mon, 10 Mar 2025 19:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RWC7JRk/z2eFFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Mar 2025 19:35:53 +0000
Date: Mon, 10 Mar 2025 20:35:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: improve readability in search_ioctl()
Message-ID: <20250310193548.GC32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250309075820.30999-1-sunk67188@gmail.com>
 <20250309075820.30999-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309075820.30999-2-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sun, Mar 09, 2025 at 03:57:59PM +0800, Sun YangKai wrote:
> This commit addresses two code issues in the search_ioctl() function:

Please avoid the phrases "This commit" or "This patch". Also the
readability is a general goal, in this case it can be more specific,
like simplifying the return values.

> 1. Move the assignment of ret = -EFAULT to within the error condition
>    check in fault_in_subpage_writeable(). The previous placement outside
>    the condition could lead to the error value being overwritten by
>    subsequent assignments, cause unnecessary assignments.
> 
> 2. Simplify loop exit logic by removing redundant `goto`.
>    The original code used `goto err` to bypass post-loop processing after
>    handling errors from `btrfs_search_forward()`. However, the loop's
>    termination naturally falls through to the post-loop section, which
>    already handles `ret` values. Replacing `goto err` with `break`
>    eliminates redundant control flow, consolidates error handling, and
>    makes the loop's exit conditions explicit.
> 
> The changes ensure proper error propagation and make the loop's exit
> conditions clearer while maintaining functional equivalence.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ioctl.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6c18bad53cd3..bef158a1260b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1642,21 +1642,20 @@ static noinline int search_ioctl(struct inode *inode,
>  	key.offset = sk->min_offset;
>  
>  	while (1) {
> -		ret = -EFAULT;
>  		/*
>  		 * Ensure that the whole user buffer is faulted in at sub-page
>  		 * granularity, otherwise the loop may live-lock.
>  		 */
>  		if (fault_in_subpage_writeable(ubuf + sk_offset,
> -					       *buf_size - sk_offset))
> +					       *buf_size - sk_offset)) {
> +			ret = -EFAULT;
>  			break;
> +		}
>  
>  		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
> -		if (ret != 0) {
> -			if (ret > 0)
> -				ret = 0;
> -			goto err;
> -		}
> +		if (ret)
> +			break;
> +
>  		ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
>  				 &sk_offset, &num_found);
>  		btrfs_release_path(path);
> @@ -1666,7 +1665,7 @@ static noinline int search_ioctl(struct inode *inode,
>  	}
>  	if (ret > 0)
>  		ret = 0;
> -err:
> +
>  	sk->nr_items = num_found;
>  	btrfs_put_root(root);
>  	btrfs_free_path(path);
> -- 
> 2.48.1
> 

