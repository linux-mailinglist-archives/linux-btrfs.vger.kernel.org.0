Return-Path: <linux-btrfs+bounces-14750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11466ADDD1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 22:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A023117FFCE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BCA2E2676;
	Tue, 17 Jun 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MRtrYlSj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNTixEym";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rTqpBmLN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/PN/7KN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DC2EFD8B
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191579; cv=none; b=iMHH/18MAm+PM/mMA3eL/nijPf8qAIjpG2do8QqMLq6hvalq0Ximlrw/z3qzKrVfiGRjnT66QJ7i0usmG4F1foq2OzXFRepc/2g8F9GbqR7UFG4vzItOy9TmnulsodxvgX1Akge/kPWmCO8jeSLGGW3bLL3oeutKeQlZEQ97V6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191579; c=relaxed/simple;
	bh=vKALW/+sH/ZkyGI/FMVc+IdRyTBozE1Yhwl+ZAe27wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWyTsToguVNnCazxwbLrLoGB3kumlauGeFqG+Of5AqeS0puxNM1Jr60nbBXo70UEqGlXTsn4g6pOBNWZ+23zLalxR797nc80/p5Gz5plEg7F65O6PfT2+XHbmifwFGNW6XmgpbdO43anJRJq/X8Ob7gFMjztei/xTnYEAMzlWbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MRtrYlSj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNTixEym; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rTqpBmLN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/PN/7KN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC5DD21195;
	Tue, 17 Jun 2025 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750191575;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oikjIAvfCHoDy16GhZNIt3/nlsh3cDXd3xCKEpliscE=;
	b=MRtrYlSjr70PxOBUllk8mR/vTPeSTeQJIeQg5tbVFpHHN7FOSASkX+9Vbqg9tyANaeDQfX
	yCguHGH6AF5ZnFEKbS6NBUFdJ+B8fv/Q8JpiT9oJjBTRtqBynizCUsDEArX3Mvt71RG3Z0
	hB29XcAp9lLbxaMlhYAIbbe1Ljeozkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750191575;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oikjIAvfCHoDy16GhZNIt3/nlsh3cDXd3xCKEpliscE=;
	b=mNTixEymP/Nnfsxg7LTVTkFPNS4eWwX6F3zjRFX3gE8jrzuVOBYFs2dy7kGbHLf5iZ5LEq
	WS7eijFCBU6FyeBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750191574;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oikjIAvfCHoDy16GhZNIt3/nlsh3cDXd3xCKEpliscE=;
	b=rTqpBmLNagwhG3APBXmuRAOcr9o3XeiICydmsB7xcsWrN23w2BLXv2wd9ywsCg/NDXxSma
	spnQZsbRRu5NtYkmtFj0g3UvTuQwMqtTFgHQkYfDvNhhryS66h4XIRUw9oVDcRNEirDNwn
	JgGkziv1qCy1nkNcTpHxbJfgL4k2OSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750191574;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oikjIAvfCHoDy16GhZNIt3/nlsh3cDXd3xCKEpliscE=;
	b=G/PN/7KNXMBXNq4QM43/6uBoY1YYTmLZG+5Lb1F9EgggTWK1Dj2mRMiAQIjKpPZmj15+dY
	zC0JFVRN5V2WemAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC59A13A69;
	Tue, 17 Jun 2025 20:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wb+oMdbNUWi8TQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Jun 2025 20:19:34 +0000
Date: Tue, 17 Jun 2025 22:19:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/2] Simplify the shash wrappers for the CRC32 library
Message-ID: <20250617201933.GF4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250613183753.31864-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613183753.31864-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Jun 13, 2025 at 11:37:51AM -0700, Eric Biggers wrote:
> This series simplifies how the CRC32 library functions are exposed
> through the crypto_shash API.  We'll now have just one shash algorithm
> each for "crc32" and "crc32c", and their driver names will just always
> be "crc32-lib" and "crc32c-lib" respectively.  This seems to be all
> that's actually needed.
> 
> As mentioned in patch 2, this does change the content of
> /sys/fs/btrfs/$uuid/checksum again, but that should be fine.

Yes, this is fine, I don't think any ABI applies here and the
implementation was only informative.

> This is based on v6.16-rc1, and I'm planning to take these patches
> through the crc-next tree.  These supersede
> https://lore.kernel.org/r/20250601224441.778374-2-ebiggers@kernel.org/
> and
> https://lore.kernel.org/r/20250601224441.778374-3-ebiggers@kernel.org/,
> and they fix the warning in the full crypto self-tests reported at
> https://lore.kernel.org/r/aExLZaoBCg55rZWJ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com/
> 
> Eric Biggers (2):
>   btrfs: stop parsing crc32c driver name
>   crypto/crc32[c]: register only "-lib" drivers

Acked-by: David Sterba <dsterba@suse.com>

Thanks.

