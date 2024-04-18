Return-Path: <linux-btrfs+bounces-4414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A78A9C3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFAF1C23C2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745C165FC2;
	Thu, 18 Apr 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RUrz+XBf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZRTZv+V3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RUrz+XBf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZRTZv+V3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733B165FC0
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449153; cv=none; b=fua000Zz3Ha/H/8Ub7ysgKwd0/WyiRSSeW93/q7mnXnbrCvkcfiBa5DeDE+xr4XHEZ0Nfi/OHWd+dS07guVr7MB8GJDn/vv0nOtWGq/cnq5OnjgBDF+o3H/ofxERUHdDCxdraBC233HonqCWfpyf6o2olNUCISXTqhgJw2zGDkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449153; c=relaxed/simple;
	bh=MY3SiGWkzGpE7sEbzl/AZS9cGAtsL1BnMITyPOOqrnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liPViGALWrxk7fwglFZPeu/3YhyJJwXzhk3a0CgAhtSZ6kepgy5mzf6BMdOskI6VCd4dgEWBvPhKevWpYICfVi/yKFXPizoT8JmmYVLCeb92e+SkYmaCFZYQJpdpZowyrWR386+qLDYyKUMFWYlVgINhtMp/4IUcT494HxgIPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RUrz+XBf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZRTZv+V3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RUrz+XBf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZRTZv+V3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D061F5CBED;
	Thu, 18 Apr 2024 14:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713449146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z52TkHCKonKFwz/bLDI+lCOP7Cl1WyJbTTZEtu/7wlw=;
	b=RUrz+XBf3v6Z7Kqgw9uGAbNOik/Sj1GAZs1vxKzMR55arygUPDyJisTBHsnvwjlBXD5PXI
	gYQe9tl1w1mq05Z9wvOt50ei5lIRt9hlP/HkJpqRrZ/xSvp1BLGTZ67OeBu75DwVzPcYeZ
	vuKkNTdqRcgFO9T2tQQoJuYy5MA8kYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713449146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z52TkHCKonKFwz/bLDI+lCOP7Cl1WyJbTTZEtu/7wlw=;
	b=ZRTZv+V34EFiTeJsW72HpZRlrqzqwM+/11txct1QoGM5+J3rOAXpbhjNY+6S9uJNJfRkkZ
	mYVNHH9w7kTfH2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713449146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z52TkHCKonKFwz/bLDI+lCOP7Cl1WyJbTTZEtu/7wlw=;
	b=RUrz+XBf3v6Z7Kqgw9uGAbNOik/Sj1GAZs1vxKzMR55arygUPDyJisTBHsnvwjlBXD5PXI
	gYQe9tl1w1mq05Z9wvOt50ei5lIRt9hlP/HkJpqRrZ/xSvp1BLGTZ67OeBu75DwVzPcYeZ
	vuKkNTdqRcgFO9T2tQQoJuYy5MA8kYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713449146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z52TkHCKonKFwz/bLDI+lCOP7Cl1WyJbTTZEtu/7wlw=;
	b=ZRTZv+V34EFiTeJsW72HpZRlrqzqwM+/11txct1QoGM5+J3rOAXpbhjNY+6S9uJNJfRkkZ
	mYVNHH9w7kTfH2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75F7313687;
	Thu, 18 Apr 2024 14:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wDV7EbooIWYPHQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 18 Apr 2024 14:05:46 +0000
Date: Thu, 18 Apr 2024 09:05:44 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 08/17] btrfs: adjust while loop condition in
 run_delalloc_nocow
Message-ID: <mzy6ls3bbdo5sfcbnksktfsh7yvwrylqzyrvk3cdb6m5z4z2au@pdn3amhl6dy7>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <e6b89a60facace44086fc9eaed3e78fbece6c45e.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b89a60facace44086fc9eaed3e78fbece6c45e.1713363472.git.josef@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Score: -1.16
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	BAYES_HAM(-0.36)[76.67%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On 10:35 17/04, Josef Bacik wrote:
> We have the following pattern
> 
> while (1) {
> 	if (cur_offset > end)
> 		break;
> }
> 
> Which is just
> 
> while (cur_offset <= end) {
> }
> 
> so adjust the code to be more clear.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/inode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f14b3cecce47..80e92d37af34 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1988,7 +1988,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	nocow_args.end = end;
>  	nocow_args.writeback_path = true;
>  
> -	while (1) {
> +	while (cur_offset <= end) {
>  		struct btrfs_block_group *nocow_bg = NULL;
>  		struct btrfs_ordered_extent *ordered;
>  		struct btrfs_key found_key;
> @@ -2192,8 +2192,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  		 */
>  		if (ret)
>  			goto error;
> -		if (cur_offset > end)
> -			break;
>  	}
>  	btrfs_release_path(path);
>  

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn

