Return-Path: <linux-btrfs+bounces-9922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802649D9D49
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544D9B25432
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20E1DDA35;
	Tue, 26 Nov 2024 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFFchYra";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4aBnJU8Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFFchYra";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4aBnJU8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079F1DD879
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645305; cv=none; b=r9Y5NyYbP/IzfsD4jQ0470AdKa9UZwF8dodyJ7b/YkTRuy9vTgWEyIxu+9s6QazXM/ZBWo0uZYENK5ZJ/hJqqmB2rDC4RkS6Q70rOBlEXnid2jziX9lNyz/mnP45Hnq/cfoM6UUE6mNOFNWGpsbVgWVrzuZkpdUNEWaYQNPV9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645305; c=relaxed/simple;
	bh=VZkb34kxIsdlH8EnLok/wlDqho/FMv/438ZMeW3vczM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0dcZl0xLaHjoh+ABXArYEXbXwuxSl/DzSBw6OUU/XDgPWOZFgb+rgyqkX4OcYDhd6/IKfx4IRXOEkjXLrGpFZcED71Y3qB52sX0GHcIayeQcCpW3Efob5I8or0ZI36gpKALe1Mnf+kd8GYscqkcORD7VFCBZySYAoR5RYCOOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFFchYra; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4aBnJU8Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFFchYra; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4aBnJU8Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95FAF1F74D;
	Tue, 26 Nov 2024 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732645301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuW12n7wKHc79QEg2Xlagh57IQ1QLkWhPOt0/zliwyQ=;
	b=yFFchYraidF3GCj0xHV5Ga32GGWhgmyNFPMDOuMVWW4bq1tWTBiilTPOXQl27dhk5cIBig
	r0v0aL43WvHSYQKS9B4yi1SldAfD5rI2Q+8NJG2nCC4+VwIqqawIjxrtmQqr05rxdcSImd
	SEukIxUajU2OtQSm0sjaklJy8xIG9OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732645301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuW12n7wKHc79QEg2Xlagh57IQ1QLkWhPOt0/zliwyQ=;
	b=4aBnJU8YebXAWj9ROa7Io8Ln45oIGAUD5D6cC4CpthUt89SMYvxwVbO1KwSDvwqafsGj3m
	iNdQK/7jIGn55EBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yFFchYra;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4aBnJU8Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732645301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuW12n7wKHc79QEg2Xlagh57IQ1QLkWhPOt0/zliwyQ=;
	b=yFFchYraidF3GCj0xHV5Ga32GGWhgmyNFPMDOuMVWW4bq1tWTBiilTPOXQl27dhk5cIBig
	r0v0aL43WvHSYQKS9B4yi1SldAfD5rI2Q+8NJG2nCC4+VwIqqawIjxrtmQqr05rxdcSImd
	SEukIxUajU2OtQSm0sjaklJy8xIG9OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732645301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuW12n7wKHc79QEg2Xlagh57IQ1QLkWhPOt0/zliwyQ=;
	b=4aBnJU8YebXAWj9ROa7Io8Ln45oIGAUD5D6cC4CpthUt89SMYvxwVbO1KwSDvwqafsGj3m
	iNdQK/7jIGn55EBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B06139AA;
	Tue, 26 Nov 2024 18:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1i0HLURRmfeRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 18:21:41 +0000
Date: Tue, 26 Nov 2024 19:21:32 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: validate system chunk array at
 btrfs_validate_super()
Message-ID: <20241126182132.GN31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5d205dc4e1126be4c33b1eac62ba625075749469.1732080133.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d205dc4e1126be4c33b1eac62ba625075749469.1732080133.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 95FAF1F74D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Nov 20, 2024 at 03:52:18PM +1030, Qu Wenruo wrote:
> Currently btrfs_validate_super() only does a very basic check on the
> array chunk size (not too large than the available space, but not too
> small to contain no chunk).
> 
> The more comprehensive checks (the regular chunk checks and size check
> inside the system chunk array) is all done inside
> btrfs_read_sys_array().
> 
> It's not a big deal, but for the sake of concentrated verification, we
> should validate the system chunk array at the time of super block
> validation.

Makes sense.

> So this patch does the following modification:
> 
> - Introduce a helper btrfs_check_system_chunk_array()
>   * Validate the disk key
>   * Validate the size before we access the full chunk/stripe items.
>   * Do the full chunk item validation
> 
> - Call btrfs_check_system_chunk_array() at btrfs_validate_super()
> 
> - Simplify the checks inside btrfs_read_sys_array()
>   Now the checks will be converted to an ASSERT().
> 
> - Simplify the checks inside read_one_chunk()
>   Now all chunk items inside system chunk array and chunk tree is
>   verified, there is no need to verify it again inside read_one_chunk().
> 
> This change has the following advantages:
> 
> - More comprehensive checks at write time
>   Although this also means extra memcpy() for the superblocks at write
>   time, due to the limits that we need a dummy extent buffer to utilize
>   all the extent buffer helpers.

Well, the memcpy() is not the problem but rather calling
alloc_dummy_extent_buffer() at the time we want to write the superblock.
This requires allocation of the extent buffer structure and all the
pages/folios. And the alloc/free would be done for each commit. A system
under load and memory pressure won't be able to flush the data. This a
known pattern we want to avoid.

So either preallocate the dummy extent buffer and keep it around
(possibly freeing the unused pages/folios), or somehow make the extent
buffer helpers work with the superblock.

There are 2 trivial helpers that we can replace
(btrfs_chunk_num_stripes, btrfs_chunk_type), but
btrfs_check_chunk_valid() needs a proper eb with folio array.

