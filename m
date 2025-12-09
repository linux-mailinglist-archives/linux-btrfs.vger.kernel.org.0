Return-Path: <linux-btrfs+bounces-19612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B737CB0F5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 20:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 040A4301CD96
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3714307AE7;
	Tue,  9 Dec 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1xM30D9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/JaEk3a3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1xM30D9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/JaEk3a3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B5304985
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309674; cv=none; b=dgSES4/eQ1PrR04UzAiCUWsHnu04Ne5bvO4LvQD8aH0HDXkQqrpGBFP5TB9G7zhsxIBgx2dh55ptdLVV4adObgyJtCipRpYxCN4xt5mdwqSqqejLxE3eAL1JJaBKyKtkaDgmG9AOqIiIRPLki76MGWNTOLiFCrVEzaTC64FXJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309674; c=relaxed/simple;
	bh=SAyiJFE/CVVyKvKLFXt2Ns5XrAAwFArlarC48tBkS54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvX9i4p+Y/UHUbsl1lIPYuZSr8LnlTFNFWfpJP0j6Jf8NYWGFBRQ+iFccyHPiYWpjakHN2Ry1zNFupimHKnxLX3Rcm+olqJNXshQ//yzNxltEDEzyvjvvMMDuimJYHCQd+TPWLJ0Kr5XH102vbw/wYSjBBvICVQ6K6XsMBdG8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T1xM30D9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/JaEk3a3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T1xM30D9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/JaEk3a3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5428133884;
	Tue,  9 Dec 2025 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765309670;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXVuBjckK48BjvpDH3j/HiP15BLaUidVBNBHe9Ak5SI=;
	b=T1xM30D9TCpI7Xw5gHcPIf0Ecxdpo2Z/T1HitnXIirGpayLbfmeSNjJzR+XaEWdcgCkXTC
	vZ4D1+mR6LDthh/ECTRsTZ2dneX3myobPAcRlE0ZMXhwL1S0BdkT7PUC6alf2h/KNKrRkG
	NKElxaqzLK9Im6mWHqmL2ABBjLqKGm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765309670;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXVuBjckK48BjvpDH3j/HiP15BLaUidVBNBHe9Ak5SI=;
	b=/JaEk3a35hYGDvkFEaVm79gVf8PR/K2F/ZSWf/B5u5XrTSAyKodTbiIuogMlAWfHOxpWjy
	NgHjtUytqOm0t0AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T1xM30D9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/JaEk3a3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765309670;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXVuBjckK48BjvpDH3j/HiP15BLaUidVBNBHe9Ak5SI=;
	b=T1xM30D9TCpI7Xw5gHcPIf0Ecxdpo2Z/T1HitnXIirGpayLbfmeSNjJzR+XaEWdcgCkXTC
	vZ4D1+mR6LDthh/ECTRsTZ2dneX3myobPAcRlE0ZMXhwL1S0BdkT7PUC6alf2h/KNKrRkG
	NKElxaqzLK9Im6mWHqmL2ABBjLqKGm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765309670;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXVuBjckK48BjvpDH3j/HiP15BLaUidVBNBHe9Ak5SI=;
	b=/JaEk3a35hYGDvkFEaVm79gVf8PR/K2F/ZSWf/B5u5XrTSAyKodTbiIuogMlAWfHOxpWjy
	NgHjtUytqOm0t0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 331DA3EA63;
	Tue,  9 Dec 2025 19:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qdj2C+Z8OGnOdgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Dec 2025 19:47:50 +0000
Date: Tue, 9 Dec 2025 20:47:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] btrfs: switch to library APIs for checksums
Message-ID: <20251209194748.GH4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251205070454.118592-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205070454.118592-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 5428133884
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Thu, Dec 04, 2025 at 11:04:54PM -0800, Eric Biggers wrote:
> Make btrfs use the library APIs instead of crypto_shash, for all
> checksum computations.  This has many benefits:
> 
> - Allows future checksum types, e.g. XXH3 or CRC64, to be more easily
>   supported.  Only a library API will be needed, not crypto_shash too.
> 
> - Eliminates the overhead of the generic crypto layer, including an
>   indirect call for every function call and other API overhead.  A
>   microbenchmark of btrfs_check_read_bio() with crc32c checksums shows a
>   speedup from 658 cycles to 608 cycles per 4096-byte block.
> 
> - Decreases the stack usage of btrfs by reducing the size of checksum
>   contexts from 384 bytes to 240 bytes, and by eliminating the need for
>   some functions to declare a checksum context at all.
> 
> - Increases reliability.  The library functions always succeed and
>   return void.  In contrast, crypto_shash can fail and return errors.
>   Also, the library functions are guaranteed to be available when btrfs
>   is loaded; there's no longer any need to use module softdeps to try to
>   work around the crypto modules sometimes not being loaded.
> 
> - Fixes a bug where blake2b checksums didn't work on kernels booted with
>   fips=1.  Since btrfs checksums are for integrity only, it's fine for
>   them to use non-FIPS-approved algorithms.
> 
> Note that with having to handle 4 algorithms instead of just 1-2, this
> commit does result in a slightly positive diffstat.  That being said,
> this wouldn't have been the case if btrfs had actually checked for
> errors from crypto_shash, which technically it should have been doing.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> v2: rebased onto latest mainline, now that both the crypto library and
>     btrfs pull requests for 6.19 have been merged

Added to for-next as we're now based on recent master, thanks.

