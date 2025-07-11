Return-Path: <linux-btrfs+bounces-15464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2100DB018CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 11:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E49B4477C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20027E06C;
	Fri, 11 Jul 2025 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KsnL9kM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldb8wJ2v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2KsnL9kM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldb8wJ2v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D39207E1D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227658; cv=none; b=XiN7AK2INcB0LODXsUgPReXrxEc7aCPwwdlSrqmQgACMIy5W7bf1jMTqfV89ImWLXG+t2X5A0Wx4aXnSLztP4DjezKV8IQWSjOS1quMOvsE6YkGkt1JzwMu4dyB6sE1sJpOC83/BnuGw8gAWNPByema/8m8Ij6ghSXuYmJckTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227658; c=relaxed/simple;
	bh=pYM3B62SUEvKUQXZ2AFOuGJnmlnhX02ZJHo7n2h4lMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+kxWETQI7fIT7Sra1G9G8ZzefJKyEBoCaHKv/1SzCVR/YXEXd2E1xE9OhaFVM/mCwAa6OlqBAorf1qpvexD0dxWEBMgLJ+6TCv8uWlrCC+7tQJM3narhmxXPGf8/O+XE7OsLr59vxVmtLXCIbDBKVHeaMPjRI/OIsKSXh7tYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KsnL9kM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldb8wJ2v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2KsnL9kM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldb8wJ2v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BE9021197;
	Fri, 11 Jul 2025 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752227654;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfCAuNY9XC79Qdoz43TE+k+DrUnOHdkFTamprYiMLY=;
	b=2KsnL9kM/zptjzLQD76H9KEHLdNVZNhjyA22jInFpE50kaNPnYRvre1SWP5220FpuBGa7S
	BadqtNW5nesujOtB1hhmjQ9iSsKNiVvqS1bXawTatp9pQK9Pyim8Qfjw4CG6+qvILidwEK
	Qq8mnxCkS28B4zND9+6lTWjdHC628G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752227654;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfCAuNY9XC79Qdoz43TE+k+DrUnOHdkFTamprYiMLY=;
	b=ldb8wJ2voavRBZAKVw/va+ZPjJKPIIXnBOdcQMljq9sIZRjNtuontdyy02No/4xGHAlbIV
	UluIkhhJrKOHK6Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752227654;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfCAuNY9XC79Qdoz43TE+k+DrUnOHdkFTamprYiMLY=;
	b=2KsnL9kM/zptjzLQD76H9KEHLdNVZNhjyA22jInFpE50kaNPnYRvre1SWP5220FpuBGa7S
	BadqtNW5nesujOtB1hhmjQ9iSsKNiVvqS1bXawTatp9pQK9Pyim8Qfjw4CG6+qvILidwEK
	Qq8mnxCkS28B4zND9+6lTWjdHC628G0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752227654;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfCAuNY9XC79Qdoz43TE+k+DrUnOHdkFTamprYiMLY=;
	b=ldb8wJ2voavRBZAKVw/va+ZPjJKPIIXnBOdcQMljq9sIZRjNtuontdyy02No/4xGHAlbIV
	UluIkhhJrKOHK6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FDC41388B;
	Fri, 11 Jul 2025 09:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0CkuC0bfcGj0dAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Jul 2025 09:54:14 +0000
Date: Fri, 11 Jul 2025 11:54:12 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_clear_extent_bits()
Message-ID: <20250711095412.GA22472@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <89e52089f6d6cb7b4dad233f30bf8d8ee8ea857c.1752224006.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89e52089f6d6cb7b4dad233f30bf8d8ee8ea857c.1752224006.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Jul 11, 2025 at 09:54:10AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's just a simple wrapper around btrfs_clear_extent_bit() that passes a
> NULL for its last argument (a cached extent state record), plus there is
> not counter part - we have a btrfs_set_extent_bit() but we do not have a
> btrfs_set_extent_bits() (plural version). So just remove it and make all
> callers use btrfs_clear_extent_bit() directly.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

