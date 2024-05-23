Return-Path: <linux-btrfs+bounces-5254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F778CD876
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 18:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51FF1C210E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971417C9E;
	Thu, 23 May 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W4LUycwK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZmNBkvw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W4LUycwK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RZmNBkvw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3EAD31
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481985; cv=none; b=Hi9748AqsfUPN8dJTsWzpNEknSdhyMcy/0lPIFU/23L8ppCeaek2qpd/5ycIak2sfjHwThMWUgGAwTlOW+X1AOijEXo6oTIEFtPSE7bYr6ShkDhVkKpTEw024dowEwcDZHv0YbGnzjNHEJ4SsI1b1a9/jqva4YympI/Sf0b7aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481985; c=relaxed/simple;
	bh=7DhxDwpJoK/bO4Xhazo+z6FmZX9Ku7PfoSrVdOel/iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb6+WSt0AIa3MfxT7Hw+aiCsr+wYSazags0hPvUQA6CC/XpKmtXYG9Nxj1RO+9CwK9qDWdLivvyLjronUu0Mf83WArbjSa6a4fjQIB6yVHns+1Q8sUVufBkG/23tpYsYrv3qPPPiV+4BU/J9Kmiunus38/jEJA0zgox1trNgQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W4LUycwK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RZmNBkvw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W4LUycwK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RZmNBkvw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35C7E229A1;
	Thu, 23 May 2024 16:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716481982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nzyxieg+sa62e/Ssqsra9uNamtR0xWDOHav+fIEN5M=;
	b=W4LUycwK6Yilr0ckKSq5uVD5u0vAvGQ4Rpjwc6xEjdZ+NpaAWrjmLazl2MUCGgJRfuUbY+
	f/LCeJn80tPOKUWCBO3K8UBHwsQz1gk/ArQ0rzTXpyOTdwKXTKvJwKL75WpI5M0TTYuQRM
	pVllkoGrQWSeuBiiPu+se8qqxxe8nDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716481982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nzyxieg+sa62e/Ssqsra9uNamtR0xWDOHav+fIEN5M=;
	b=RZmNBkvwiBQVKxKzbdevQ3Asbya/s59PkQg1DH6wVEXykgmigwSdE3ZvjYEafdkbP9CuCu
	+7+bXsT3tNPn+5Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716481982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nzyxieg+sa62e/Ssqsra9uNamtR0xWDOHav+fIEN5M=;
	b=W4LUycwK6Yilr0ckKSq5uVD5u0vAvGQ4Rpjwc6xEjdZ+NpaAWrjmLazl2MUCGgJRfuUbY+
	f/LCeJn80tPOKUWCBO3K8UBHwsQz1gk/ArQ0rzTXpyOTdwKXTKvJwKL75WpI5M0TTYuQRM
	pVllkoGrQWSeuBiiPu+se8qqxxe8nDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716481982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nzyxieg+sa62e/Ssqsra9uNamtR0xWDOHav+fIEN5M=;
	b=RZmNBkvwiBQVKxKzbdevQ3Asbya/s59PkQg1DH6wVEXykgmigwSdE3ZvjYEafdkbP9CuCu
	+7+bXsT3tNPn+5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A22013A6B;
	Thu, 23 May 2024 16:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4cYdCr5vT2alXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 May 2024 16:33:02 +0000
Date: Thu, 23 May 2024 18:33:00 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move fiemap code into its own file
Message-ID: <20240523163300.GC17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d7579e89a2926ae126ba42794de3e7c39726f6eb.1716408773.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7579e89a2926ae126ba42794de3e7c39726f6eb.1716408773.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 22, 2024 at 09:15:59PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the core of the fiemap code lives in extent_io.c, which does
> not make any sense because it's not related to extent IO at all (and it
> was not as well before the big rewrite of fiemap I did some time ago).
> The entry point for fiemap, btrfs_fiemap(), lives in inode.c since it's
> an inode operation.
> 
> Since there's a significant amount of fiemap code, move all of it into a
> dedicated file, including its entry point inode.c:btrfs_fiemap().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

