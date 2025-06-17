Return-Path: <linux-btrfs+bounces-14749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A1EADDD16
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 22:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B23D3BAE5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A9288CAC;
	Tue, 17 Jun 2025 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p1c/BRYe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IPMmjWE7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p1c/BRYe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IPMmjWE7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129DCA4B
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191480; cv=none; b=Fx0sV695aXSS5tgIK68r21J4V3Rf/1ssLBb5F24U1ZbqEjehqxgylloEXxqh79cUoefNwWRBuNDp4DsxO4lQs4cgb7tohnMCGBf+/iIEmbqtd2R/hZ+Ip0HLBesvqKumA8HBSqawu7JtBz/jswU99DvlSdYW57YSLczptmM3JQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191480; c=relaxed/simple;
	bh=zixkYSTlnTXNunGXrz2f3XuMUKY+iD6Yqa6w5WoCFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHEGjfIww2PyWvwQFS6m10Lk7IG+OTuNaJFhPE3L7bw4Dk9LegUXNXBaV3hLEBORkmqMuOVDYHWh8aKWNbHWykLy9ancdm+FMZhkN0f6nwj2itykaiTJ6bhdP2gxF4U3Zc2r4FELsiT436OidBYahuO5gGChh6kMtGgNgD1wEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p1c/BRYe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IPMmjWE7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p1c/BRYe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IPMmjWE7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 744011F79D;
	Tue, 17 Jun 2025 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750191477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21ZcOxVwbSzRFwETfVZj2snZJOVF9FMz7fREHpUJgQ=;
	b=p1c/BRYefOKu0C9E60tYNbH7+IltbRjTI3o9oqAT7d+qetlBXnZ/+4Xxh3Rq1Bb7cv1EU3
	i+S2ZAo1471BlGgMMrbQ+kICcT+IHDS4/97AoGXcHKgdPM3i5Z2vQ6/fm5IiBiTaNBl2tM
	t2o6QPDnXxx5WQeeMRgktsDImT+x/8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750191477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21ZcOxVwbSzRFwETfVZj2snZJOVF9FMz7fREHpUJgQ=;
	b=IPMmjWE7F01ChjTElFtZBXO3U3W8/hAwSDwpFXEBcdyqUOXSSlcUPPxGNqetj/TBiUWkBw
	kGUW5ioOTqjiWzAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750191477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21ZcOxVwbSzRFwETfVZj2snZJOVF9FMz7fREHpUJgQ=;
	b=p1c/BRYefOKu0C9E60tYNbH7+IltbRjTI3o9oqAT7d+qetlBXnZ/+4Xxh3Rq1Bb7cv1EU3
	i+S2ZAo1471BlGgMMrbQ+kICcT+IHDS4/97AoGXcHKgdPM3i5Z2vQ6/fm5IiBiTaNBl2tM
	t2o6QPDnXxx5WQeeMRgktsDImT+x/8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750191477;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X21ZcOxVwbSzRFwETfVZj2snZJOVF9FMz7fREHpUJgQ=;
	b=IPMmjWE7F01ChjTElFtZBXO3U3W8/hAwSDwpFXEBcdyqUOXSSlcUPPxGNqetj/TBiUWkBw
	kGUW5ioOTqjiWzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45AEE13A69;
	Tue, 17 Jun 2025 20:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ZjHEHXNUWhoTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Jun 2025 20:17:57 +0000
Date: Tue, 17 Jun 2025 22:17:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-btrfs@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/2] crypto/crc32[c]: register only "-lib" drivers
Message-ID: <20250617201748.GE4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250613183753.31864-1-ebiggers@kernel.org>
 <20250613183753.31864-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613183753.31864-3-ebiggers@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Jun 13, 2025 at 11:37:53AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> For the "crc32" and "crc32c" shash algorithms, instead of registering
> "*-generic" drivers as well as conditionally registering "*-$(ARCH)"
> drivers, instead just register "*-lib" drivers.  These just use the
> regular library functions crc32_le() and crc32c(), so they just do the
> right thing and are fully accelerated when supported by the CPU.
> 
> This eliminates the need for the CRC library to export crc32_le_base()
> and crc32c_base().  Separate patches make those static functions.
> 
> Since this patch removes the "crc32-generic" and "crc32c-generic" driver
> names which crypto/testmgr.c expects to exist, update crypto/testmgr.c
> accordingly.  This does mean that crypto/testmgr.c will no longer
> fuzz-test the "generic" implementation against the "arch" implementation
> for crc32 and crc32c, but this was redundant with crc_kunit anyway.
> 
> Besides the above, and btrfs_init_csum_hash() which the previous patch
> fixed, no code appears to have been relying on the "crc32-generic" or
> "crc32c-generic" driver names specifically.
> 
> btrfs does export the checksum driver name in
> /sys/fs/btrfs/$uuid/checksum.  This patch makes that file contain
> "crc32c-lib" instead of "crc32c-generic" or "crc32c-$(ARCH)".  This
> should be fine, since in practice the purpose of this file seems to have
> been just to allow users to manually check whether they needed to enable
> the optimized CRC32C code.  This was needed only because of the bug in
> old kernels where the optimized CRC32C code defaulted to off and even
> needed to be explicitly added to the ramdisk to be used.  Now that it
> just works in Linux 6.14 and later, there's no need for users to take
> any action and this file is basically obsolete.

Well, not the whole file, because it says which checksumming algo is
used for the filesystem, but the implementation part is.

