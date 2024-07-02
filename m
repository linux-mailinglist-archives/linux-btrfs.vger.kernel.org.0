Return-Path: <linux-btrfs+bounces-6151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726FC9243C5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DB21F2748C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422591BD507;
	Tue,  2 Jul 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aouqHLSr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/9RHUqHN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aouqHLSr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/9RHUqHN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70B14293
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938595; cv=none; b=tY6z2p6kkmhlUsNNvN0AI+9B1q9vKQnkleaIs2uqScdfCXeeVZDTUHXBvnGiw6UlCgUkpNyV+kuk7HUM3cSTKqvAsIR1YfZJo1BYMLH5tVA51fXFWDzJ/M6Y2HY1n+D3ZKNKKEcmUjOtRqcknZineYgVjWNtMcUGnTFgiP3VQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938595; c=relaxed/simple;
	bh=CkQcb2lStLEzVZRdz6JfG8J4xsSGYKhe4D2Ippw0wfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac8kTeCNT5EFpzKDHmTiL79jCvtZl5mtfKoZqFaIDtg/GLaEkMQEsLhQIltGXtlh9O88Q1TVyRMypcHyVpU3AOnIrIKNnz6FUad7ffAnTRg0qYdeDMqtXYPIourieyGytv73fLVeIO/4pLE93s05z/GqbSYPiM0h+gE4HES/Pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aouqHLSr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/9RHUqHN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aouqHLSr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/9RHUqHN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8AD821B63;
	Tue,  2 Jul 2024 16:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719938591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwitlnkzdlZi82oEoCkWxinRfreSahn1ufzlg1riqsk=;
	b=aouqHLSracA+RWlfatbJyDPGB1hfGBZntTz8uW2JuRjqV0OkLHU/A0iO6eKTLrxMimyu2w
	5135pVaw126NEJef7DIgcmwhKhqv7LKBOx2Rc6Cfwp7j2PNk38QmJeMi3HPCLzWYLsPvdu
	nU4bxWIHujk0rq3jvEABLMLW0JYnsVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719938591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwitlnkzdlZi82oEoCkWxinRfreSahn1ufzlg1riqsk=;
	b=/9RHUqHNzG0DSvXCN7056N63PArhERzGKnE478MpAuZnZnO2gQu88sT9k+uEYOAo3xgsWJ
	UWcDC97jWZKvIGAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719938591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwitlnkzdlZi82oEoCkWxinRfreSahn1ufzlg1riqsk=;
	b=aouqHLSracA+RWlfatbJyDPGB1hfGBZntTz8uW2JuRjqV0OkLHU/A0iO6eKTLrxMimyu2w
	5135pVaw126NEJef7DIgcmwhKhqv7LKBOx2Rc6Cfwp7j2PNk38QmJeMi3HPCLzWYLsPvdu
	nU4bxWIHujk0rq3jvEABLMLW0JYnsVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719938591;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwitlnkzdlZi82oEoCkWxinRfreSahn1ufzlg1riqsk=;
	b=/9RHUqHNzG0DSvXCN7056N63PArhERzGKnE478MpAuZnZnO2gQu88sT9k+uEYOAo3xgsWJ
	UWcDC97jWZKvIGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC75713A9A;
	Tue,  2 Jul 2024 16:43:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tbTMLR8uhGbSPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 16:43:11 +0000
Date: Tue, 2 Jul 2024 18:43:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: enhance function
 extent_range_clear_dirty_for_io()
Message-ID: <20240702164306.GJ21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716427131.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716427131.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]

On Thu, May 23, 2024 at 10:49:36AM +0930, Qu Wenruo wrote:
> [Changelog]
> v3:
> - Drop the patch to use subpage helper
>   For subpage cases, fsstress with compression can lead to hang where
>   OE seems hanging and never to be finished.
>   So far it looks like some race with i_size change but still not sure
>   why the code change is involved.
>   Drop the subpage helper change for now.
> 
> v2:
> - Split the original patch into 3
> 
> - Return the error from filemap_get_folio() to be future-proof
> 
> - Enhance the comments for the new ASSERT() on
>   extent_range_clear_dirty_for_io() error
>   In fact, even if some pages are missing, we do not need to handle the
>   error at compress_file_range(), as btrfs_compress_folios() and each
>   compression routine would handle the missing folio correctly.
> 
>   Thus the new ASSERT() is only an early warning for developers.
> 
> Qu Wenruo (2):
>   btrfs: move extent_range_clear_dirty_for_io() into inode.c
>   btrfs: remove the BUG_ON() inside extent_range_clear_dirty_for_io()

Reviewed-by: David Sterba <dsterba@suse.com>

