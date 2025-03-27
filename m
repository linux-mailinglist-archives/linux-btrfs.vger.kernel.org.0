Return-Path: <linux-btrfs+bounces-12618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB469A73759
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1AE188DA23
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0A217F31;
	Thu, 27 Mar 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZQ6SnpOb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9QjFB6bV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZQ6SnpOb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9QjFB6bV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EA1E868
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094223; cv=none; b=HOgtSFQlpgHqxEh76M5up2k+ye4n8MPx0XNecKHqrUwkfI4RPBrVmHJL2IgGW6l7EuvAM8aqYikNkrJAgp3UkWfM7KiLhVoOp/sWyIZlBLoJQRRgV2qxeYB3H9xnkSIB6xhysJ/PjdOtFRtXyOJM9K+Xe7zIgXItnOtNvm2VDns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094223; c=relaxed/simple;
	bh=xBjMOWj0GbxqZAnmS+1QjAL3LMn2x4KqGeAmLBda02Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTo+iGh3I0MllrpF/PDqY/Zo7eBuWIWortO2Vg+xZImjvnMUgKFKP44ATvL92oG+QWc2imeIOS5wavvPcyugv5jmtNjZyXOWABsM7H6LL7zK3poG8Ms+qqzsTI8gv3YfyUdmhefEtof1xcRKGwZ7FuhTrhHw0M6QCth2TsmckHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZQ6SnpOb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9QjFB6bV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZQ6SnpOb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9QjFB6bV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 876222118E;
	Thu, 27 Mar 2025 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743094219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMN1IdePprnmgpiupDCx6jwvXU7R6hnalDPDGRt9id8=;
	b=ZQ6SnpObN/OkBkcToWghdgnrVwHj8ZUWYhqTF0l+iiAzrRuUYTWKRrKRUy8t3VmVTsKct2
	wE/9Q9HeMw7QPaub01fB2S2nwzGjVky9kmdN7T+1eXt7UkJEC+fINqAgNoNVmheodp2UJx
	kUoC3dMESXJxW5ohAyS769OufRJVqZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743094219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMN1IdePprnmgpiupDCx6jwvXU7R6hnalDPDGRt9id8=;
	b=9QjFB6bV/Lv8VNeOppwv/tyavpMjT4KJC3FuFopVy9Tcm7RSg2PvHWq2wSLpDv1rR1azag
	Hqw1pcixUZbA7RBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743094219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMN1IdePprnmgpiupDCx6jwvXU7R6hnalDPDGRt9id8=;
	b=ZQ6SnpObN/OkBkcToWghdgnrVwHj8ZUWYhqTF0l+iiAzrRuUYTWKRrKRUy8t3VmVTsKct2
	wE/9Q9HeMw7QPaub01fB2S2nwzGjVky9kmdN7T+1eXt7UkJEC+fINqAgNoNVmheodp2UJx
	kUoC3dMESXJxW5ohAyS769OufRJVqZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743094219;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMN1IdePprnmgpiupDCx6jwvXU7R6hnalDPDGRt9id8=;
	b=9QjFB6bV/Lv8VNeOppwv/tyavpMjT4KJC3FuFopVy9Tcm7RSg2PvHWq2wSLpDv1rR1azag
	Hqw1pcixUZbA7RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74893139D4;
	Thu, 27 Mar 2025 16:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZNFDHMuB5WcpEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 16:50:19 +0000
Date: Thu, 27 Mar 2025 17:50:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: extract the main loop of
 btrfs_buffered_write() into a helper
Message-ID: <20250327165010.GW32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742443383.git.wqu@suse.com>
 <4710798bb9d917697384db6abbae75ac8a5ab6cf.1742443383.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4710798bb9d917697384db6abbae75ac8a5ab6cf.1742443383.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Mar 20, 2025 at 04:04:11PM +1030, Qu Wenruo wrote:
> Inside the main loop of btrfs_buffered_write() we are doing a lot of
> heavy lift work inside a while () loop.
> 
> This makes it pretty hard to read, extract the content into a helper,
> copy_one_range() to do the heavy lift work.
> 
> This has no functional change, but with some minor variable renames,
> e.g. rename all "sector" into "block".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 292 ++++++++++++++++++++++++------------------------
>  1 file changed, 147 insertions(+), 145 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 99580ef906a6..21b90ed3e0e4 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1153,21 +1153,161 @@ static ssize_t reserve_space(struct btrfs_inode *inode,
>  	return reserve_bytes;
>  }
>  
> +/*
> + * Do the heavy lift work to copy one range into one folio of the page cache.
> + *
> + * Return >=0 for the number of bytes copied. (Return 0 means no byte is copied,
> + * caller should retry the same range again).
> + * Return <0 for error.
> + */
> +static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,

'struct iov_iter *i'  was probably copied from btrfs_buffered_write()
prototype bug uh naming 'i' such parameter is quite an anti-pattern.
I've renamed it to 'iter', and will fix the other one too so it does not
get accidentally copied somewhere else.

