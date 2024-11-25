Return-Path: <linux-btrfs+bounces-9893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D79D891C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 16:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0166161582
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A711B395D;
	Mon, 25 Nov 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPV4UESG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8GA8IgA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LPV4UESG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8GA8IgA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75F171CD;
	Mon, 25 Nov 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548087; cv=none; b=Fwj2QsazuExx/PRLabh3U9S8gg5LBwr6GvCY4DDZ9CslK/uUUu1OPXwfCusfRClidD9+eJhLdXqXrBgBbRy6FoariCD5qClEUg/JxswVJ+fzRPprqg4KsmFt+kwkwStZsg/tR+lokBiP5OACjLQ5UUxvW1iCpvixnkc+GXJ/1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548087; c=relaxed/simple;
	bh=yweQJS1T5MofFQxuCLlGNCE03LYgUUuFJ7++Wg4EkrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRcMFex3qqyb9gFwO0QZCEGK7GIf8k6xvNDJtaBZ60yU7rk+x7JdIJFeV55Mxo/UJ8cBrKxkiGKw0Wv9aRRr+TF6z1hLmfVzV1f++O+jIYA4kmv/pXoVE87InhCRKKzBF4XR+gswA3kwXEXaTXFwoLgGNbnUc7mQ8rARpEiqNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPV4UESG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8GA8IgA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LPV4UESG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8GA8IgA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A5E51F442;
	Mon, 25 Nov 2024 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732548083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPBe0Y4n/AZ6gwF2arusg1VMijc8sZYzIsikVrciUoo=;
	b=LPV4UESGR9i8iG116YJslgdxLPC5IE7TFL6ygnR5t+mLTPlBLfeo9Bfiq2DYg95Gu/rL8N
	9Uk7aFSzv/Nki+7HZKaoPlVje8hU5vCPeM8LVtlfZdA6dOfMbMEJdpm2d9atvIcxVXe76w
	deDlGjoqnSW3Vd4PU1yyn1qGVxVgOY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732548083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPBe0Y4n/AZ6gwF2arusg1VMijc8sZYzIsikVrciUoo=;
	b=E8GA8IgAkhxUfrEBIuiDiV5LfGoKIJahzaW0++YRsKY4bvmBlsOCZW4GSK4CL7ALM7JhV8
	Mx4LEcVl8dL7vUAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LPV4UESG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=E8GA8IgA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732548083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPBe0Y4n/AZ6gwF2arusg1VMijc8sZYzIsikVrciUoo=;
	b=LPV4UESGR9i8iG116YJslgdxLPC5IE7TFL6ygnR5t+mLTPlBLfeo9Bfiq2DYg95Gu/rL8N
	9Uk7aFSzv/Nki+7HZKaoPlVje8hU5vCPeM8LVtlfZdA6dOfMbMEJdpm2d9atvIcxVXe76w
	deDlGjoqnSW3Vd4PU1yyn1qGVxVgOY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732548083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPBe0Y4n/AZ6gwF2arusg1VMijc8sZYzIsikVrciUoo=;
	b=E8GA8IgAkhxUfrEBIuiDiV5LfGoKIJahzaW0++YRsKY4bvmBlsOCZW4GSK4CL7ALM7JhV8
	Mx4LEcVl8dL7vUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E451137D4;
	Mon, 25 Nov 2024 15:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dYupGvOVRGcWWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Nov 2024 15:21:23 +0000
Date: Mon, 25 Nov 2024 16:21:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 10/19] btrfs: make
 extent_range_clear_dirty_for_io() to handle sector size < page size cases
Message-ID: <20241125152122.GZ31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241124123912.3335344-1-sashal@kernel.org>
 <20241124123912.3335344-10-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124123912.3335344-10-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 8A5E51F442
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sun, Nov 24, 2024 at 07:38:45AM -0500, Sasha Levin wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> [ Upstream commit a4ef54dbb576032ba31a646a5ffc8a26a83cb92c ]
> 
> For btrfs with sector size < page size (e.g. 4K sector size, 64K page
> size), and enable the sector perfect compression support, then the
> following dirty range can lead to problems:
> 
>    0     32K     64K     96K    128K
>    |     |///////||//////|    |/|
>                               124K
> 
> In above case, if we start writeback for that inode, the last dirty
> range [124K, 128K) will not be submitted and cause reserved space
> leakage:
> 
> - Start writeback for page 0
>   We find the range [32K, 96K) is suitable for compression, and queue it
>   into a workqueue to do the delayed compression and submission.
> 
> - Compression happens for range [32K, 96K)
>   Function extent_range_clear_dirty_for_io() is called, however it is
>   only doing full page handling, not considering any the extra bitmaps
>   for subpage cases.
> 
>   That function will clear page dirty for both page 0 and page 64K.
> 
> - Writeback for the inode is done
>   Because page 64K has its dirty flag cleared, it will not be considered
>   as a writeback target.
> 
> This means the range [124K, 128K) will not be submitted, and reserved
> space for it will be leaked.
> 
> Fix this problem by using the subpage helper to clear the dirty flag.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please drop this patch from stable, it's preparatory work and has
otherwise no effect.

