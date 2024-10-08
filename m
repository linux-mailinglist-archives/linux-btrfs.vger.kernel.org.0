Return-Path: <linux-btrfs+bounces-8650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B924999554C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA73F1C25081
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9A1E1047;
	Tue,  8 Oct 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ptS5Yklx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9sNpmpK6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ptS5Yklx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9sNpmpK6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386B1E1A15
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407124; cv=none; b=C+NNEsq+aMth8yDixjeFAN+tVEyca4yh2AewW4Ri4V8uXDxCqv8Qpdggco5Fy7LU3UgwW/5Crx6gRhP42VQhObB4+nsvfjiYWmfuXNTW2MoSJagHPqYBKU76FDVXrozu568kQ9SmJdktpaI57Dr7STfxdHrKj4N4NFbepnuP4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407124; c=relaxed/simple;
	bh=98P3YNJMU1sZoqNCyM3VvpOpIXckNFQOcRfp/21aoAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMFrP3KbO/NQBF21HRAThmf+/wF6da16aOMs7L8y+wwKi93mg9JVn6kJPfyFXFFI/E6vMUo3l88va2gqOhtrVPxAdl9Y98k9QY8PEjo6JzqeRBkOs0t8Mp1/c0iuvN/1cJpzVeh/JdLf+VGG2lV9hdFzovDuBvEsd8FNdBvBu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ptS5Yklx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9sNpmpK6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ptS5Yklx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9sNpmpK6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2A8C1FDFC;
	Tue,  8 Oct 2024 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728407120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYpEdT2XabVb3lQYThtNT+56rE3r3nEJuC6e6p6mczM=;
	b=ptS5YklxMFZ7KR2u03zd3Zj/ji88lIOFUQlbaL31IV3hOGkZcsVnZKCZ2OYndvSynUotQZ
	9qhgwrDuYJGONBVsJK7aIXkdAmWtoxTfR4odpM+2b8V8APZhvA9VZsEmhm1VLjCOwFvAPu
	PB/qJUop7bYPmzX2kWGPV1u4K87mpi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728407120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYpEdT2XabVb3lQYThtNT+56rE3r3nEJuC6e6p6mczM=;
	b=9sNpmpK6YyYb12gIQYk89suExL5nGD/kT67qmd0s+g75UvABAGpkODA9hjEIk+qFq+v5P/
	r5/XWGjnqYO4MaAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728407120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYpEdT2XabVb3lQYThtNT+56rE3r3nEJuC6e6p6mczM=;
	b=ptS5YklxMFZ7KR2u03zd3Zj/ji88lIOFUQlbaL31IV3hOGkZcsVnZKCZ2OYndvSynUotQZ
	9qhgwrDuYJGONBVsJK7aIXkdAmWtoxTfR4odpM+2b8V8APZhvA9VZsEmhm1VLjCOwFvAPu
	PB/qJUop7bYPmzX2kWGPV1u4K87mpi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728407120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYpEdT2XabVb3lQYThtNT+56rE3r3nEJuC6e6p6mczM=;
	b=9sNpmpK6YyYb12gIQYk89suExL5nGD/kT67qmd0s+g75UvABAGpkODA9hjEIk+qFq+v5P/
	r5/XWGjnqYO4MaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B8C6137CF;
	Tue,  8 Oct 2024 17:05:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U4/yHVBmBWcxVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 17:05:20 +0000
Date: Tue, 8 Oct 2024 19:05:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] btrfs: scrub: skip initial RAID stripe-tree lookup
 errors
Message-ID: <20241008170511.GE1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241007115248.16434-1-jth@kernel.org>
 <20241007115248.16434-3-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007115248.16434-3-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Oct 07, 2024 at 01:52:48PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Performing the initial extent sector read on a RAID stripe-tree backed
> filesystem with pre-allocated extents will cause the RAID stripe-tree
> lookup code to return ENODATA, as pre-allocated extents do not have any
> on-disk bytes and thus no RAID stripe-tree entries.
> 
> But the current scrub read code marks these extens as errors, because the
> lookup fails.
> 
> If btrfs_map_block() returns -ENODATA, it means that the call to
> btrfs_get_raid_extent_offset() returned -ENODATA, because there is no
> entry for the corresponding range in the RAID stripe-tree. But as this
> range is in the extent-tree it means we've hit a pre-allocated extent. In
> this case, don't mark the sector in the stripe's error bitmaps as faulty
> and carry on to the next.

I've added summary of this paragraph as a comment to the code, using the
ENODATA for a specific relations in the trees is quite unobvious.

