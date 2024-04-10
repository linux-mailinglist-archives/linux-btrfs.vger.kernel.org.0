Return-Path: <linux-btrfs+bounces-4111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DCC89F344
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044091C277DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FDC15CD6B;
	Wed, 10 Apr 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="quWSomj3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ESasSBb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="quWSomj3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ESasSBb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAA15B126
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753997; cv=none; b=IXXVXJqmnTrXCv+hiHe58sS6ZjO3DhSV34ezbTci5a7Z+Nf5rG29Kh8jF1JyDClPjJmf9YHC3eBv6PPO1CEnvSF9bBCg21vgKHjs9XfbIJjms9uJMuQHYfcXInDb4jYniXYYaTBRnfnqpdpVKQOwEUVbMTDaUxd5ec9gkNG9V4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753997; c=relaxed/simple;
	bh=aHmAFfYvRBl55k8UjIaZ5FZGmhJ1+aubeUGAPd3f184=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6iRaVUxv0VW8Rq+ebYhrtBzG/7Adwn3JWTVKgbw7Jc11tPFy4ToPF/m3foEBNjNnL8CuF8EjrHFf0Hy5EADpdyq3sWiB5Ms+8g2YZM9aPb8tX8bsqFRU5mD71pM8bZPP374Hno9rVkBxF5yQWJg4fXlZk2MDKaoNydPBfHmXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=quWSomj3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ESasSBb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=quWSomj3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ESasSBb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 313685CD8C;
	Wed, 10 Apr 2024 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712753994;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jnx+YpVdoBhnqVkOG82a9BCrbYu8KHnGxWQIp5shznU=;
	b=quWSomj304roJkfqB5cgvO6ZeLt/+eCkde7DUM5Z1e8//uh7Zvq32UKQHIFPtkBFQW72pM
	Xv5fHV4NPxLROrKU7INLK9s1ChsxdyTl7+wx5YZxxrTAePzYK4XQIdvohrH+TdViGRAc66
	NnThg39sjt4P/q3wc+/EK75BrgyXMnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712753994;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jnx+YpVdoBhnqVkOG82a9BCrbYu8KHnGxWQIp5shznU=;
	b=2ESasSBbo4vhJFEeEcNts3/DUqpxWW8ZXceCXyCeEwdI0DJf8ir9IQ5/HZ42R1fcw3QtqK
	3dcgGVOGLI4OxwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712753994;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jnx+YpVdoBhnqVkOG82a9BCrbYu8KHnGxWQIp5shznU=;
	b=quWSomj304roJkfqB5cgvO6ZeLt/+eCkde7DUM5Z1e8//uh7Zvq32UKQHIFPtkBFQW72pM
	Xv5fHV4NPxLROrKU7INLK9s1ChsxdyTl7+wx5YZxxrTAePzYK4XQIdvohrH+TdViGRAc66
	NnThg39sjt4P/q3wc+/EK75BrgyXMnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712753994;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jnx+YpVdoBhnqVkOG82a9BCrbYu8KHnGxWQIp5shznU=;
	b=2ESasSBbo4vhJFEeEcNts3/DUqpxWW8ZXceCXyCeEwdI0DJf8ir9IQ5/HZ42R1fcw3QtqK
	3dcgGVOGLI4OxwCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BC6B1390D;
	Wed, 10 Apr 2024 12:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nOqfBkqNFmafEAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 10 Apr 2024 12:59:54 +0000
Date: Wed, 10 Apr 2024 14:52:20 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move btrfs_page_mkwrite() from inode.c into file.c
Message-ID: <20240410125220.GM3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b7d1ee7e696e2ed290e3de640102073dcb0334bb.1712749432.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d1ee7e696e2ed290e3de640102073dcb0334bb.1712749432.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.62
X-Spam-Level: 
X-Spamd-Result: default: False [-3.62 / 50.00];
	BAYES_HAM(-2.62)[98.34%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

On Wed, Apr 10, 2024 at 12:45:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs_page_mkwrite() is a struct vm_operations_struct callback and we
> define that structure in file.c. Currently the function is in inode.c and
> has to be exported to be used in file.c, which makes no sense because it's
> not used anywhere else. So move btrfs_page_mkwrite() from inode.c and into
> file.c.
> 
> While at it do a few minor style changes:
> 
> 1) Capitalize the first word of every comment and end each sentence with
>    punctuation;
> 
> 2) Avoid splitting some statements into two lines when everything fits in
>    85 characters or less.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

