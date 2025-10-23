Return-Path: <linux-btrfs+bounces-18220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65215C030DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EF21AA3707
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3496F29BD85;
	Thu, 23 Oct 2025 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T4My599u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F1hzFQB4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VCr+Zb5a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+qCOOoUV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553D257835
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245158; cv=none; b=DMNWsod63Mi9nj1e68lnsiAkv0QhNwPPXW/LbHRjqTeNVLZ9EyoYgWid5NTu7p/WlM0RgnU9zSt0xiYzpnqmUepL1meaqO3dlFQtzAUHm5dLqa4c3Eql4HU4ypQKiDgmw2XBHQLmOZ6rNpMJ79+1X0boTzv2eUqznwx0esKdBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245158; c=relaxed/simple;
	bh=UoSp3aIfb+na87FxUMSykouMs0jHUrOyweI0uRK1xiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZAQV/w9VIp2Sj/h5ekoWq8TyRqCHKtr+NfF3CC8DeEWSTXb8eTi07qNGuyU1jGr4lO+LDTCXe4JNxQsKEHJ1CKrlXRt0p4TEgC07bYnPqOQOlw56WhdRAbVnT6+mTyOxRkO75/KizmgNk5eUoy0q0XVnjaTRSatfwGZ6VHHTNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T4My599u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F1hzFQB4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VCr+Zb5a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+qCOOoUV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AE031F388;
	Thu, 23 Oct 2025 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761245151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2/VJEywAU9LBRvL2S4Xz/ZfJnrbrX//+Tmg/U0F1u4=;
	b=T4My599uidGQ17KIMIpiuMCrLcTjHTKVVWRHiTgtcmvrOPQrtjmTAl9YutNQtffhA1Xcav
	+KI+7EoZ/sL1CK9flabFtCeEfRBZn5KIbQnW6JfvZni/1J+BKAC8WblU3VEhD74Iug9PDX
	nePqMTvAFj8qpDSKhinT27FOasQRMK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761245151;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2/VJEywAU9LBRvL2S4Xz/ZfJnrbrX//+Tmg/U0F1u4=;
	b=F1hzFQB4596YPQHJ2G6n0o3XQW3Kf18ov3cO52wyctYcOCnc63ciL9Q+MfEYtxTts1Sz/o
	F00nsq2y22+gCxCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761245147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2/VJEywAU9LBRvL2S4Xz/ZfJnrbrX//+Tmg/U0F1u4=;
	b=VCr+Zb5aned6VdcQds7Gp8QJ+zU43pxj1DaJQB2N7WC/cn0Ihbv/ODd5Z/sG3MTZ6aEUFV
	LHd3C2/kpAXLDiefZzHaXXsRW1YFSEsGOtQwvgpiXo9uxnxeGJ84Xs7/8jlqJGGsWZp73Q
	+ADhja8ThNl3uLnMFDiAcO+4/rtZ1hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761245147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2/VJEywAU9LBRvL2S4Xz/ZfJnrbrX//+Tmg/U0F1u4=;
	b=+qCOOoUVBZ0e7pWyy+vZTDIbPlhXABGPbWy6Yvw0k1AcwAs1XDcEwq6qhFcgFonaxpsspa
	43KdR0xKJ8fhANCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D357A13285;
	Thu, 23 Oct 2025 18:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5xVvMtp3+mgdWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 Oct 2025 18:45:46 +0000
Date: Thu, 23 Oct 2025 20:45:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 10/10] btrfs: switch to library APIs for checksums
Message-ID: <20251023184537.GB20913@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251018043106.375964-1-ebiggers@kernel.org>
 <20251018043106.375964-11-ebiggers@kernel.org>
 <20251022071141.GV13776@twin.jikos.cz>
 <20251022175934.GA1646@quark>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022175934.GA1646@quark>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Oct 22, 2025 at 10:59:34AM -0700, Eric Biggers wrote:
> > Thanks, this simplifies quite a few things. I'd like to take it via the
> > btrfs tree as there may be the hash additions (XXH3, BLAKE3) but
> > currently I'm not sure if it won't make things more complicated. I
> > haven't started the kernel part yet so I can use this patchset for
> > development and rebase once it's merged. 
> 
> Great.  I'm planning to take patches 1-9 through libcrypto-next for
> 6.19.  You can then take patch 10 through the btrfs tree for 6.20.  Does
> that sound good?

Yes, the 6.20 schedule works better for me.

> We can work out the XXH3 and BLAKE3 support later.  If
> you'd like to add another checksum algorithm, I'd suggest picking just
> one.  btrfs already supports an awful lot of choices for the checksum.
> But we can discuss that later.

Yes, I'v deleted long answer to that, it would be better to discuss that
separately once the xxh3 and blake3 get posted.

