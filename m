Return-Path: <linux-btrfs+bounces-18150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4432BFA7AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42D5B4FFE1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0142F546D;
	Wed, 22 Oct 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwyl57t8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ugWAT5ne";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nz14d9Rp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2CbetMO3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0312EAB6F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117115; cv=none; b=X2KKxTkErolg+iRHiXVZSEOgVjSATQEXACMBepC1bQDL8j4nuchZ8C6fjvJxHYumS2zka6K0zjj2PXyJzpjea1/9L05GQOwbpKzZx/cRZ4WSxSYeayGYNOW52zukhjbMt3TNTkDzwwy/L+7jVhrU/WspOBaY8gxFkQkzHKDmw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117115; c=relaxed/simple;
	bh=lFxy0NK1X/El45Qs3Wjm9AlJrpb5J9XKmRCy6hI9130=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDf09S+I3cOWhZmq7NLFdFU7oz1Z9zXrOZ4Gqc48I5G2SxDQCHRaSHFEKw8mBxvgnXXEbp7IASFOsC44MIu0HAjOaARQedqQRPJPnIvU51CmEr33U4mkgakR+/JTE9aR/Q3QgSw0XE114CK1GvVSn22ALgT18+/stVGPF1Si3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwyl57t8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ugWAT5ne; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nz14d9Rp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2CbetMO3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 239FE1F397;
	Wed, 22 Oct 2025 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761117107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCo6c3jOZCaszWTotbd5IGeLwwS2UDsyK+Ikn6++0Po=;
	b=uwyl57t81guhonppnXFDGMXfR9U7SWkuCFBhChzVol4xQBLUSuzn0vE3zVnroUarlwG8az
	8inLHxz9uQBj8/nMVAq638zCJxrpfbV347iysJTXbv0YZYVfzYfiazWkTiKsxheKoNXzMx
	k9yUr4Ck5sSmOF1zucXr97+dnPOPG6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761117107;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCo6c3jOZCaszWTotbd5IGeLwwS2UDsyK+Ikn6++0Po=;
	b=ugWAT5ne/R5Uah2/TnNa3gI2htSG4EnlTGU3w6Kl45ggvUjN+4lut8u3dXWgBspObgqLBn
	i3Xra7Ck8l9/Q6Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761117103;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCo6c3jOZCaszWTotbd5IGeLwwS2UDsyK+Ikn6++0Po=;
	b=Nz14d9Rpu4YM6XFzzL3V01i3AKFihaFLwOi9Xtd1MRq+ewjQte5pYedDmNdlKN2SzFKQYs
	qxT6/s/ZGoB4cjd/0ej5Egw10+wRs2QdL8iu9anPR8O8kjB0FNUVsmmXDONP4bXb3l/2oB
	HRQzUIWtu+xpL/d1xFmlS/7RRF39ycU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761117103;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCo6c3jOZCaszWTotbd5IGeLwwS2UDsyK+Ikn6++0Po=;
	b=2CbetMO3lkdIzGNlIxl8ebU5307el5FJS9UnUP+rsBIIL4JcxlrJJCmefxy6qJcF5nCf5o
	hqKE8JlAFQ8aygBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9231339F;
	Wed, 22 Oct 2025 07:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VeGiA6+D+GgRBAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 07:11:43 +0000
Date: Wed, 22 Oct 2025 09:11:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 10/10] btrfs: switch to library APIs for checksums
Message-ID: <20251022071141.GV13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251018043106.375964-1-ebiggers@kernel.org>
 <20251018043106.375964-11-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018043106.375964-11-ebiggers@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Oct 17, 2025 at 09:31:06PM -0700, Eric Biggers wrote:
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
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Thanks, this simplifies quite a few things. I'd like to take it via the
btrfs tree as there may be the hash additions (XXH3, BLAKE3) but
currently I'm not sure if it won't make things more complicated. I
haven't started the kernel part yet so I can use this patchset for
development and rebase once it's merged. 

